Return-Path: <stable+bounces-212189-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDwwCBMuemnd3gEAu9opvQ
	(envelope-from <stable+bounces-212189-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:41:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3070A4304
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F4A7303CD26
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2C72DB7A3;
	Wed, 28 Jan 2026 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P3HAO4y2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760122D7DE7;
	Wed, 28 Jan 2026 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614686; cv=none; b=X65uADWTH/GVah4fR4wxQUajLQHD+wXZpWpXeMfj4PqwIgJtlPNEq13JTk8AxWYHuaKl+D1Ji3ujRZjbGv3htubeDmSTobIVfKAAoWdApxn+ouxiQ8IW8CJV0NZbM9trOEGBbgCtbz/xKJuDK7OJ5Gf5PgortsZIlC3JF4apqWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614686; c=relaxed/simple;
	bh=OLRX1XYtsch8Rq2NczY6VHSLKNH1jAHJNyT4wT7pB7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzu58MBMtCiSHAukGg6aIDdBmz/P1JNSZvw4B3U0c5u2cjB6a55b9Ccqo7iNM1sA0bVQwNxH0ri6XoL93gSlfLmzDoMu+AS4liVsrP4lOaheYWUuK07wx2gtO/CtumtAZlMOkUyWBjxn25fqxsa9wAeBbdmpLEO/YELFEbWoQnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P3HAO4y2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4F4C4CEF1;
	Wed, 28 Jan 2026 15:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614686;
	bh=OLRX1XYtsch8Rq2NczY6VHSLKNH1jAHJNyT4wT7pB7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P3HAO4y2qdIz8saBHZ9YvrZ8VX9GgW/JOCI7LMC6/PVbaye0megX7uABnaYo1lGAl
	 w2vGjHQsxhZbXgRZGyoy1oscu7XkQu0XQL/ZxCnNZsDYCpHG/DTQi8OMDpbEFeCWID
	 q1VXtsQ01jc4sJfxEF53SEDAa0nXMTInRIQAO3cw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Yang <mmyangfl@gmail.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Eric Dumazet <edumazet@google.com>,
	Aaron Conole <aconole@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 178/254] net: openvswitch: fix data race in ovs_vport_get_upcall_stats
Date: Wed, 28 Jan 2026 16:22:34 +0100
Message-ID: <20260128145351.210220008@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,ovn.org,google.com,redhat.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-212189-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ovn.org:email]
X-Rspamd-Queue-Id: E3070A4304
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Yang <mmyangfl@gmail.com>

[ Upstream commit cc4816bdb08639e5cd9acb295a02d6f0f09736b4 ]

In ovs_vport_get_upcall_stats(), some statistics protected by
u64_stats_sync, are read and accumulated in ignorance of possible
u64_stats_fetch_retry() events. These statistics are already accumulated
by u64_stats_inc(). Fix this by reading them into temporary variables
first.

Fixes: 1933ea365aa7 ("net: openvswitch: Add support to count upcall packets")
Signed-off-by: David Yang <mmyangfl@gmail.com>
Acked-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Link: https://patch.msgid.link/20260121072932.2360971-1-mmyangfl@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/openvswitch/vport.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
index 972ae01a70f76..0faa6e097829c 100644
--- a/net/openvswitch/vport.c
+++ b/net/openvswitch/vport.c
@@ -310,22 +310,23 @@ void ovs_vport_get_stats(struct vport *vport, struct ovs_vport_stats *stats)
  */
 int ovs_vport_get_upcall_stats(struct vport *vport, struct sk_buff *skb)
 {
+	u64 tx_success = 0, tx_fail = 0;
 	struct nlattr *nla;
 	int i;
 
-	__u64 tx_success = 0;
-	__u64 tx_fail = 0;
-
 	for_each_possible_cpu(i) {
 		const struct vport_upcall_stats_percpu *stats;
+		u64 n_success, n_fail;
 		unsigned int start;
 
 		stats = per_cpu_ptr(vport->upcall_stats, i);
 		do {
 			start = u64_stats_fetch_begin(&stats->syncp);
-			tx_success += u64_stats_read(&stats->n_success);
-			tx_fail += u64_stats_read(&stats->n_fail);
+			n_success = u64_stats_read(&stats->n_success);
+			n_fail = u64_stats_read(&stats->n_fail);
 		} while (u64_stats_fetch_retry(&stats->syncp, start));
+		tx_success += n_success;
+		tx_fail += n_fail;
 	}
 
 	nla = nla_nest_start_noflag(skb, OVS_VPORT_ATTR_UPCALL_STATS);
-- 
2.51.0




