Return-Path: <stable+bounces-237199-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mB6qHOYe3WmsaAkAu9opvQ
	(envelope-from <stable+bounces-237199-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:50:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA0E3EFF74
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34EA830022F8
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466103161BF;
	Mon, 13 Apr 2026 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FXen80Ux"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A24B314D26;
	Mon, 13 Apr 2026 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098841; cv=none; b=MnqzBSlnkpoHd+O6ORx7VBxA01+amUgulFX0sQ7E14pKiCbgtOUsF2WPywss5+Xw+Pf3VI3JbQ4wn+CKa0w9pG1GltVgpc/39UxCaHPNcOMA2irqnEQHqXNocu0aOIWKkmWhqeVt8ZemekvRiTSx26mFKhOzgJ1ayj2zV+LzI0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098841; c=relaxed/simple;
	bh=jjPq92rxlN9i9zYua4ZQMEdJVyXnwu1o554g2ffqyOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5bm2RdplLzn2RjfDnEB0Qo8E8Be3tqQ+6pNXPbjM5alGsHIrLb/3u1UaOkKW+6k0OiA++Kvy3slVE5GLqKMrmPIkB9ifpXH5Fh9FpQT3+y8UfSVoZ5oH0LJYRcBm7m24ehh20CeiaoHejvOfpJ/eLGhtb5GvIm3CC+G0HXzcUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FXen80Ux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BA6C2BCAF;
	Mon, 13 Apr 2026 16:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098840;
	bh=jjPq92rxlN9i9zYua4ZQMEdJVyXnwu1o554g2ffqyOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FXen80UxnVHx/7QX5aBK1v70201GeWLoHGxaYQC1yjG1TFCq+My6VaXKeEQUhh7+c
	 Ys/Jlrji2sCwAD2XendIimDjS3LOd7eXS87iYv3HHrIzsTkE8khpuHAQo+tLozminw
	 pywHhmh/qhsjeCNwNpXphhDpqFH8QetwBWfC+y9Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Dull <monderasdor@gmail.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 077/491] netfilter: nfnetlink_queue: fix entry leak in bridge verdict error path
Date: Mon, 13 Apr 2026 17:55:22 +0200
Message-ID: <20260413155821.928440686@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,strlen.de,kernel.org];
	TAGGED_FROM(0.00)[bounces-237199-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,strlen.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0EA0E3EFF74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hyunwoo Kim <imv4bel@gmail.com>

[ Upstream commit f1ba83755d81c6fc66ac7acd723d238f974091e9 ]

nfqnl_recv_verdict() calls find_dequeue_entry() to remove the queue
entry from the queue data structures, taking ownership of the entry.
For PF_BRIDGE packets, it then calls nfqa_parse_bridge() to parse VLAN
attributes.  If nfqa_parse_bridge() returns an error (e.g. NFQA_VLAN
present but NFQA_VLAN_TCI missing), the function returns immediately
without freeing the dequeued entry or its sk_buff.

This leaks the nf_queue_entry, its associated sk_buff, and all held
references (net_device refcounts, struct net refcount).  Repeated
triggering exhausts kernel memory.

Fix this by dropping the entry via nfqnl_reinject() with NF_DROP verdict
on the error path, consistent with other error handling in this file.

Fixes: 8d45ff22f1b4 ("netfilter: bridge: nf queue verdict to use NFQA_VLAN and NFQA_L2HDR")
Reviewed-by: David Dull <monderasdor@gmail.com>
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nfnetlink_queue.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index dc6af1919deaf..bfe909267c9d9 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -1209,8 +1209,10 @@ static int nfqnl_recv_verdict(struct net *net, struct sock *ctnl,
 
 	if (entry->state.pf == PF_BRIDGE) {
 		err = nfqa_parse_bridge(entry, nfqa);
-		if (err < 0)
+		if (err < 0) {
+			nfqnl_reinject(entry, NF_DROP);
 			return err;
+		}
 	}
 
 	if (nfqa[NFQA_PAYLOAD]) {
-- 
2.51.0




