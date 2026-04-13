Return-Path: <stable+bounces-236518-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMugEwcd3WlUaAkAu9opvQ
	(envelope-from <stable+bounces-236518-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:42:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8373EF921
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 311603141704
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF99F2F6931;
	Mon, 13 Apr 2026 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V9QX4T02"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C6A24DCF6;
	Mon, 13 Apr 2026 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097112; cv=none; b=Sae+XzOVfLtIHRqxWs2d9P+4R18wxA83pRbOfSj7ujehHIrkzFQ8roO/54kSwO2+AjyY96oqon/LwA/mNcecI+OkMfL0Z9jnmz2Jvd2ES+QEmLdF6Jcz5phUzMovf2Hy2IhF1WVX3NzoPMEpxOhWeGcko/yOg5s7t+0VbN0AvQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097112; c=relaxed/simple;
	bh=1RewIVi6LEZhDjpxJG0DqonfMly3/U/AEHEYDjOQklc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+PXyjTMzEBs+6Wb37ndU4/pQrar6HCOX1l6+Iyi35nOezvndk9W4NKuntqUeURSVeN6yYCFJqVAFBkI67lzi3MZsn0nbEYonDzEos6m7BzyNp4E7+zC8CL7SyR/wad2DJ1o//Gdq1C7YFRmbpCHSfjo4hkYyXdv+Woa0ywv1Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V9QX4T02; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2952DC2BCAF;
	Mon, 13 Apr 2026 16:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097112;
	bh=1RewIVi6LEZhDjpxJG0DqonfMly3/U/AEHEYDjOQklc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V9QX4T02jE1M63hXQonT08Bt5PeUmg836IL0eaM3T363zlwExc8bglIcCKtFPrtsY
	 SOPcYnRh0omlr0cbkguyESs+oRdRbBfJjBmaX27LPAJDYAMoYl+iHz9gJlJQFzEGPr
	 yMJcNnFovPwti9mkLgLbJPutEkPGsFAt1YyVgR8M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+10cc7f13760b31bd2e61@syzkaller.appspotmail.com,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Kohei Enju <kohei@enjuk.jp>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 011/570] bpf: Fix stack-out-of-bounds write in devmap
Date: Mon, 13 Apr 2026 17:52:22 +0200
Message-ID: <20260413155830.822433706@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236518-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,10cc7f13760b31bd2e61];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,enjuk.jp:email]
X-Rspamd-Queue-Id: 9E8373EF921
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kohei Enju <kohei@enjuk.jp>

[ Upstream commit b7bf516c3ecd9a2aae2dc2635178ab87b734fef1 ]

get_upper_ifindexes() iterates over all upper devices and writes their
indices into an array without checking bounds.

Also the callers assume that the max number of upper devices is
MAX_NEST_DEV and allocate excluded_devices[1+MAX_NEST_DEV] on the stack,
but that assumption is not correct and the number of upper devices could
be larger than MAX_NEST_DEV (e.g., many macvlans), causing a
stack-out-of-bounds write.

Add a max parameter to get_upper_ifindexes() to avoid the issue.
When there are too many upper devices, return -EOVERFLOW and abort the
redirect.

To reproduce, create more than MAX_NEST_DEV(8) macvlans on a device with
an XDP program attached using BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS.
Then send a packet to the device to trigger the XDP redirect path.

Reported-by: syzbot+10cc7f13760b31bd2e61@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/698c4ce3.050a0220.340abe.000b.GAE@google.com/T/
Fixes: aeea1b86f936 ("bpf, devmap: Exclude XDP broadcast to master device")
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
Link: https://lore.kernel.org/r/20260225053506.4738-1-kohei@enjuk.jp
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/devmap.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 5e2e1c3284a39..2bfdca506a4de 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -570,18 +570,22 @@ static inline bool is_ifindex_excluded(int *excluded, int num_excluded, int ifin
 }
 
 /* Get ifindex of each upper device. 'indexes' must be able to hold at
- * least MAX_NEST_DEV elements.
- * Returns the number of ifindexes added.
+ * least 'max' elements.
+ * Returns the number of ifindexes added, or -EOVERFLOW if there are too
+ * many upper devices.
  */
-static int get_upper_ifindexes(struct net_device *dev, int *indexes)
+static int get_upper_ifindexes(struct net_device *dev, int *indexes, int max)
 {
 	struct net_device *upper;
 	struct list_head *iter;
 	int n = 0;
 
 	netdev_for_each_upper_dev_rcu(dev, upper, iter) {
+		if (n >= max)
+			return -EOVERFLOW;
 		indexes[n++] = upper->ifindex;
 	}
+
 	return n;
 }
 
@@ -597,7 +601,11 @@ int dev_map_enqueue_multi(struct xdp_frame *xdpf, struct net_device *dev_rx,
 	int err;
 
 	if (exclude_ingress) {
-		num_excluded = get_upper_ifindexes(dev_rx, excluded_devices);
+		num_excluded = get_upper_ifindexes(dev_rx, excluded_devices,
+						   ARRAY_SIZE(excluded_devices) - 1);
+		if (num_excluded < 0)
+			return num_excluded;
+
 		excluded_devices[num_excluded++] = dev_rx->ifindex;
 	}
 
@@ -715,7 +723,11 @@ int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
 	int err;
 
 	if (exclude_ingress) {
-		num_excluded = get_upper_ifindexes(dev, excluded_devices);
+		num_excluded = get_upper_ifindexes(dev, excluded_devices,
+						   ARRAY_SIZE(excluded_devices) - 1);
+		if (num_excluded < 0)
+			return num_excluded;
+
 		excluded_devices[num_excluded++] = dev->ifindex;
 	}
 
-- 
2.51.0




