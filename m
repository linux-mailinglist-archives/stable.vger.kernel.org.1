Return-Path: <stable+bounces-240622-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gABKJvo862mfKAAAu9opvQ
	(envelope-from <stable+bounces-240622-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:50:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4704D45C832
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08BB73011A6B
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 09:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7163E342CA2;
	Fri, 24 Apr 2026 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ptip3MmV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CED3321DE
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777024247; cv=none; b=j46LKUu4qDqa6ie2ET3RBG0LbGifqvCFpD49p3dfx9F5YWjym209BSNFaimqTKEsKSSJK416MYgG8bZBBoDVTSsOyDLjAl67UU7PZyz1rJ1k1fEBplmHSEliIe6a3HlVNU08ZymmGfLqLHtlkS9o2p/gD64cZAoyoLfgSUjCso8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777024247; c=relaxed/simple;
	bh=k+7JZ/H63efJd7aL7eLdS+9JCMNozZleyZPDV3Gue6Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QjEaz9nfdf3QMh5Wr4JEu8P2t5FTwck+/ys7eyKJDD4+cvzTysfYaIi5wUrKZdCoFzKS3ecFvio5dF3rAroN9Eujy1yAXEjr4dUMVcMsRmp8nfaaiegSJ6/tQtv42Qt6Yl+XsHrxwY5JX5+uFu8Db8dc/MPULi0rqmaf0nLjrco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ptip3MmV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5D3C19425;
	Fri, 24 Apr 2026 09:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777024246;
	bh=k+7JZ/H63efJd7aL7eLdS+9JCMNozZleyZPDV3Gue6Q=;
	h=Subject:To:Cc:From:Date:From;
	b=Ptip3MmVetxQh00CWRfiPuGr5kbv6G/asco6VeOxRZOlSWcnrsShzon8AFV3YL0Rn
	 r6g4T/VZAM7epggpj0nNPI2rfSXQXoXkj0DF9AF/pomTiBSuNyFxnK0SYRejuCW4F2
	 batlsXnJJBtIZdngp+gVOAZerQarsbeAIjJ78b+I=
Subject: FAILED: patch "[PATCH] net/packet: fix TOCTOU race on mmap'd vnet_hdr in" failed to apply to 5.10-stable tree
To: patzilla007@gmail.com,kuba@kernel.org,willemb@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Apr 2026 11:50:34 +0200
Message-ID: <2026042434-salad-scope-84d1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4704D45C832
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240622-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,gregkh:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2c054e17d9d41f1020376806c7f750834ced4dc5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042434-salad-scope-84d1@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2c054e17d9d41f1020376806c7f750834ced4dc5 Mon Sep 17 00:00:00 2001
From: Bingquan Chen <patzilla007@gmail.com>
Date: Sat, 18 Apr 2026 19:20:06 +0800
Subject: [PATCH] net/packet: fix TOCTOU race on mmap'd vnet_hdr in
 tpacket_snd()

In tpacket_snd(), when PACKET_VNET_HDR is enabled, vnet_hdr points
directly into the mmap'd TX ring buffer shared with userspace. The
kernel validates the header via __packet_snd_vnet_parse() but then
re-reads all fields later in virtio_net_hdr_to_skb(). A concurrent
userspace thread can modify the vnet_hdr fields between validation
and use, bypassing all safety checks.

The non-TPACKET path (packet_snd()) already correctly copies vnet_hdr
to a stack-local variable. All other vnet_hdr consumers in the kernel
(tun.c, tap.c, virtio_net.c) also use stack copies. The TPACKET TX
path is the only caller of virtio_net_hdr_to_skb() that reads directly
from user-controlled shared memory.

Fix this by copying vnet_hdr from the mmap'd ring buffer to a
stack-local variable before validation and use, consistent with the
approach used in packet_snd() and all other callers.

Fixes: 1d036d25e560 ("packet: tpacket_snd gso and checksum offload")
Signed-off-by: Bingquan Chen <patzilla007@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260418112006.78823-1-patzilla007@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 4b043241fd56..8e6f3a734ba0 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2718,7 +2718,8 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 {
 	struct sk_buff *skb = NULL;
 	struct net_device *dev;
-	struct virtio_net_hdr *vnet_hdr = NULL;
+	struct virtio_net_hdr vnet_hdr;
+	bool has_vnet_hdr = false;
 	struct sockcm_cookie sockc;
 	__be16 proto;
 	int err, reserve = 0;
@@ -2819,16 +2820,20 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 		hlen = LL_RESERVED_SPACE(dev);
 		tlen = dev->needed_tailroom;
 		if (vnet_hdr_sz) {
-			vnet_hdr = data;
 			data += vnet_hdr_sz;
 			tp_len -= vnet_hdr_sz;
-			if (tp_len < 0 ||
-			    __packet_snd_vnet_parse(vnet_hdr, tp_len)) {
+			if (tp_len < 0) {
+				tp_len = -EINVAL;
+				goto tpacket_error;
+			}
+			memcpy(&vnet_hdr, data - vnet_hdr_sz, sizeof(vnet_hdr));
+			if (__packet_snd_vnet_parse(&vnet_hdr, tp_len)) {
 				tp_len = -EINVAL;
 				goto tpacket_error;
 			}
 			copylen = __virtio16_to_cpu(vio_le(),
-						    vnet_hdr->hdr_len);
+						    vnet_hdr.hdr_len);
+			has_vnet_hdr = true;
 		}
 		copylen = max_t(int, copylen, dev->hard_header_len);
 		skb = sock_alloc_send_skb(&po->sk,
@@ -2865,12 +2870,12 @@ tpacket_error:
 			}
 		}
 
-		if (vnet_hdr_sz) {
-			if (virtio_net_hdr_to_skb(skb, vnet_hdr, vio_le())) {
+		if (has_vnet_hdr) {
+			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le())) {
 				tp_len = -EINVAL;
 				goto tpacket_error;
 			}
-			virtio_net_hdr_set_proto(skb, vnet_hdr);
+			virtio_net_hdr_set_proto(skb, &vnet_hdr);
 		}
 
 		skb->destructor = tpacket_destruct_skb;


