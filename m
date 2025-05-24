Return-Path: <stable+bounces-146263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B6DAC3040
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 17:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FA809E5326
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 15:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E7D1DE2D6;
	Sat, 24 May 2025 15:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HZUX8+ry"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F190199E84
	for <stable@vger.kernel.org>; Sat, 24 May 2025 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748101761; cv=none; b=bl2q7DMbsm+BTfZ2mRR/rKPbhUd3zBVF/OPHiTvYQjFfH+xeYm61Bp4tcJph3yDsFJlTHMNQFwd15AfViytG+bh6ELFtaNM6h82c+WpafHTAQlBmXaNvpxCvifDlX6MIA3Dc68pST4DZIAU6LpKSMRMGSQ+yOpcbs8sz16BiANw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748101761; c=relaxed/simple;
	bh=hDqI5fLGtVDwJsMgdb2tvLZy6QA9qZoVDwdch/SH6RI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ESctHcAsexPbjB3qxBjmA46a7/S57Epp7pQGjarrn6aiCqSiTEyFbeHUE9PLTE2xv4tieQsSLkCUZCEwTsT3fV6Bij5tYzDhgVbd78dLwBWu1/LwKurXBp7iUhfWIDe6qLW0ms21lnZ0gi3cpiLI/9GlCY1CAexwv/VcOkvdccA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HZUX8+ry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816E1C4CEE4;
	Sat, 24 May 2025 15:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748101758;
	bh=hDqI5fLGtVDwJsMgdb2tvLZy6QA9qZoVDwdch/SH6RI=;
	h=Subject:To:Cc:From:Date:From;
	b=HZUX8+ry4ZvOvY+AqUEZvhTyEr3mH1jgCn9rtm7YrB9T9hpLoRBQyvoEz88nJzB20
	 qkqVFgzNn28FHpbqq0hvB2/fpnzg8NUjtwnfLJlSHE01b7waL8GtZlNtClLn6EL5q5
	 iy/ijxe21a9rlwMjgUeIQIlEY2Ujhjq+QA+1ZJE0=
Subject: FAILED: patch "[PATCH] net: dsa: microchip: linearize skb for tail-tagging switches" failed to apply to 5.4-stable tree
To: jakobunt@gmail.com,jakob.unterwurzacher@cherry.de,kuba@kernel.org,olteanv@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 24 May 2025 17:49:02 +0200
Message-ID: <2025052402-concrete-panorama-6840@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x ba54bce747fa9e07896c1abd9b48545f7b4b31d2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025052402-concrete-panorama-6840@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ba54bce747fa9e07896c1abd9b48545f7b4b31d2 Mon Sep 17 00:00:00 2001
From: Jakob Unterwurzacher <jakobunt@gmail.com>
Date: Thu, 15 May 2025 09:29:19 +0200
Subject: [PATCH] net: dsa: microchip: linearize skb for tail-tagging switches

The pointer arithmentic for accessing the tail tag only works
for linear skbs.

For nonlinear skbs, it reads uninitialized memory inside the
skb headroom, essentially randomizing the tag. I have observed
it gets set to 6 most of the time.

Example where ksz9477_rcv thinks that the packet from port 1 comes from port 6
(which does not exist for the ksz9896 that's in use), dropping the packet.
Debug prints added by me (not included in this patch):

	[  256.645337] ksz9477_rcv:323 tag0=6
	[  256.645349] skb len=47 headroom=78 headlen=0 tailroom=0
	               mac=(64,14) mac_len=14 net=(78,0) trans=78
	               shinfo(txflags=0 nr_frags=1 gso(size=0 type=0 segs=0))
	               csum(0x0 start=0 offset=0 ip_summed=0 complete_sw=0 valid=0 level=0)
	               hash(0x0 sw=0 l4=0) proto=0x00f8 pkttype=1 iif=3
	               priority=0x0 mark=0x0 alloc_cpu=0 vlan_all=0x0
	               encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
	[  256.645377] dev name=end1 feat=0x0002e10200114bb3
	[  256.645386] skb headroom: 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	[  256.645395] skb headroom: 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	[  256.645403] skb headroom: 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	[  256.645411] skb headroom: 00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	[  256.645420] skb headroom: 00000040: ff ff ff ff ff ff 00 1c 19 f2 e2 db 08 06
	[  256.645428] skb frag:     00000000: 00 01 08 00 06 04 00 01 00 1c 19 f2 e2 db 0a 02
	[  256.645436] skb frag:     00000010: 00 83 00 00 00 00 00 00 0a 02 a0 2f 00 00 00 00
	[  256.645444] skb frag:     00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
	[  256.645452] ksz_common_rcv:92 dsa_conduit_find_user returned NULL

Call skb_linearize before trying to access the tag.

This patch fixes ksz9477_rcv which is used by the ksz9896 I have at
hand, and also applies the same fix to ksz8795_rcv which seems to have
the same problem.

Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
CC: stable@vger.kernel.org
Fixes: 016e43a26bab ("net: dsa: ksz: Add KSZ8795 tag code")
Fixes: 8b8010fb7876 ("dsa: add support for Microchip KSZ tail tagging")
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://patch.msgid.link/20250515072920.2313014-1-jakob.unterwurzacher@cherry.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index c33d4bf17929..0b7564b53790 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -140,7 +140,12 @@ static struct sk_buff *ksz8795_xmit(struct sk_buff *skb, struct net_device *dev)
 
 static struct sk_buff *ksz8795_rcv(struct sk_buff *skb, struct net_device *dev)
 {
-	u8 *tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
+	u8 *tag;
+
+	if (skb_linearize(skb))
+		return NULL;
+
+	tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
 
 	return ksz_common_rcv(skb, dev, tag[0] & KSZ8795_TAIL_TAG_EG_PORT_M,
 			      KSZ_EGRESS_TAG_LEN);
@@ -311,10 +316,16 @@ static struct sk_buff *ksz9477_xmit(struct sk_buff *skb,
 
 static struct sk_buff *ksz9477_rcv(struct sk_buff *skb, struct net_device *dev)
 {
-	/* Tag decoding */
-	u8 *tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
-	unsigned int port = tag[0] & KSZ9477_TAIL_TAG_EG_PORT_M;
 	unsigned int len = KSZ_EGRESS_TAG_LEN;
+	unsigned int port;
+	u8 *tag;
+
+	if (skb_linearize(skb))
+		return NULL;
+
+	/* Tag decoding */
+	tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
+	port = tag[0] & KSZ9477_TAIL_TAG_EG_PORT_M;
 
 	/* Extra 4-bytes PTP timestamp */
 	if (tag[0] & KSZ9477_PTP_TAG_INDICATION) {


