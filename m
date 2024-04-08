Return-Path: <stable+bounces-36345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9034C89BC2A
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 11:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25861C21638
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 09:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAF21E48C;
	Mon,  8 Apr 2024 09:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUW5CaXl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B384EB23
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712569459; cv=none; b=jYnM/Df1u+XQ11IlmYYoYb+L+gWguLVrdIBWPDW/GYnD4EPBa0JNOrFfSVMQGxMep36jmZPR9GBpfWUd/mXi3dxorMgU8Y2UF0eRnxJXSvx8f4b9zppXacmOUP6EJZM+L8f+aBnBub57U5QOsF5T5YO0gERE/3AUom4dzrYXqDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712569459; c=relaxed/simple;
	bh=+asVKsp69S/t3r0iq9KqbAX24rLXboa9/tfWyZn1Ewg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDlwq1fPpSwRtHT67/C1W+TBJVXfW8fsSQGSlyKNFn6NSorLu1t4MLFvARkma8rAKW2fT58hVEQGnAJO+d8cgQ8OU1Dwx3zsDjyZjnKlo/oa95ieGHD+8YwT26Ge9qJkHBUv/T1cVZAeJ5U1vud3qC5RZ91Wdy4ZEU+PUfBOPbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUW5CaXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E3FC433C7;
	Mon,  8 Apr 2024 09:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712569459;
	bh=+asVKsp69S/t3r0iq9KqbAX24rLXboa9/tfWyZn1Ewg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XUW5CaXl+R8Y84sYF9ZnliI9LNtSd45BILg/4uiBr+b/BpijGZnjDqL9j5fL+CK9V
	 4TNa8V6CI0plwEZfKfQrrP1OalbWilW0zH8TfQi9B5HIxFS/fFdRXR3eP1MvLBMJlq
	 YIRBQj9yCODJwOJby3d5BZyfZYU1Zrw5f9cGphlXIxaII43XgxxdX3/r5qW9ygWKNL
	 TLn4gQAtr18hidzPURi6hPXJi4VTuaQjSf+/TSOdLKhxdum0nA+LwwZneguChmH5JU
	 AcPA3Wybx8b2LlEZ67Rrima2d64HKxqSbUMjHUMnYshQYED0F58erpbvlnvBo+UF1x
	 lhYplv7La/AWw==
From: Antoine Tenart <atenart@kernel.org>
To: stable@vger.kernel.org
Cc: Antoine Tenart <atenart@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 5.15.y] gro: fix ownership transfer
Date: Mon,  8 Apr 2024 11:44:16 +0200
Message-ID: <20240408094416.68848-1-atenart@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024040543-backdrop-sequester-2458@gregkh>
References: <2024040543-backdrop-sequester-2458@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit ed4cccef64c1d0d5b91e69f7a8a6697c3a865486 upstream.

If packets are GROed with fraglist they might be segmented later on and
continue their journey in the stack. In skb_segment_list those skbs can
be reused as-is. This is an issue as their destructor was removed in
skb_gro_receive_list but not the reference to their socket, and then
they can't be orphaned. Fix this by also removing the reference to the
socket.

For example this could be observed,

  kernel BUG at include/linux/skbuff.h:3131!  (skb_orphan)
  RIP: 0010:ip6_rcv_core+0x11bc/0x19a0
  Call Trace:
   ipv6_list_rcv+0x250/0x3f0
   __netif_receive_skb_list_core+0x49d/0x8f0
   netif_receive_skb_list_internal+0x634/0xd40
   napi_complete_done+0x1d2/0x7d0
   gro_cell_poll+0x118/0x1f0

A similar construction is found in skb_gro_receive, apply the same
change there.

Fixes: 5e10da5385d2 ("skbuff: allow 'slow_gro' for skb carring sock reference")
Signed-off-by: Antoine Tenart <atenart@kernel.org>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 net/core/skbuff.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 7090844af499..789aa493a8b5 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3976,8 +3976,9 @@ int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 	NAPI_GRO_CB(p)->count++;
 	p->data_len += skb->len;
 
-	/* sk owenrship - if any - completely transferred to the aggregated packet */
+	/* sk ownership - if any - completely transferred to the aggregated packet */
 	skb->destructor = NULL;
+	skb->sk = NULL;
 	p->truesize += skb->truesize;
 	p->len += skb->len;
 
@@ -4424,8 +4425,9 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 	}
 
 merge:
-	/* sk owenrship - if any - completely transferred to the aggregated packet */
+	/* sk ownership - if any - completely transferred to the aggregated packet */
 	skb->destructor = NULL;
+	skb->sk = NULL;
 	delta_truesize = skb->truesize;
 	if (offset > headlen) {
 		unsigned int eat = offset - headlen;
-- 
2.44.0


