Return-Path: <stable+bounces-36077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A82899A8C
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 12:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B5C1F234E6
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 10:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7960161920;
	Fri,  5 Apr 2024 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SjlIrWAi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8830F27447
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712312267; cv=none; b=OyTXFYIhagXKYG6qCKgDMZjFmtyJZN0xMkbbjcrWuXAy8QV24YHrbuIiNKJJSdNvaRn+GToA00GKpzwHKXdekrAO7AF0d9Fbym0/8mzVBXSlECH445YM0Qa0i0XP9LDWFla5FXeVBs5WG0s2+PeWH+NIm5P3GGgiXWQ3UKWcg44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712312267; c=relaxed/simple;
	bh=Am13LYJ852ynyU8JvnkpwPA2DKuczrJ/i6jBZXR508o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cYH3bLsBm0UPO4OXu+qFXslYAVA1k/nUL9OigLilB7VHkl2qZV+OqHqCzT1/BEng6NZP66HjOqb2//K5AnqlSqiJbNw21k8CqgyxbCi5Bfo3El+B/9KizimYqPEhNHz0QXR5mCSap068fy571hyZcZMgCofel9AaNk3ucNZyAdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SjlIrWAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B09C43390;
	Fri,  5 Apr 2024 10:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712312267;
	bh=Am13LYJ852ynyU8JvnkpwPA2DKuczrJ/i6jBZXR508o=;
	h=Subject:To:Cc:From:Date:From;
	b=SjlIrWAioRGsZ183OS6Y9egzmYVv+4Jy+aQwcWZpJ3lBekjLFHW7mpu5qWnxSU5rj
	 vX9j86bozsMZoGLkvJWYXVPQLRhtrRLBsEUnomRhhFtEiAAQN1ZiNYYf3EN5Iw7VSw
	 YXmBptlmjW4lnLbwL9m4y5K/Ov7F6TbqgVCazxtA=
Subject: FAILED: patch "[PATCH] gro: fix ownership transfer" failed to apply to 5.15-stable tree
To: atenart@kernel.org,davem@davemloft.net,willemb@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Apr 2024 12:17:43 +0200
Message-ID: <2024040543-backdrop-sequester-2458@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ed4cccef64c1d0d5b91e69f7a8a6697c3a865486
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040543-backdrop-sequester-2458@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ed4cccef64c1d0d5b91e69f7a8a6697c3a865486 Mon Sep 17 00:00:00 2001
From: Antoine Tenart <atenart@kernel.org>
Date: Tue, 26 Mar 2024 12:33:59 +0100
Subject: [PATCH] gro: fix ownership transfer

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

diff --git a/net/core/gro.c b/net/core/gro.c
index ee30d4f0c038..83f35d99a682 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -192,8 +192,9 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 	}
 
 merge:
-	/* sk owenrship - if any - completely transferred to the aggregated packet */
+	/* sk ownership - if any - completely transferred to the aggregated packet */
 	skb->destructor = NULL;
+	skb->sk = NULL;
 	delta_truesize = skb->truesize;
 	if (offset > headlen) {
 		unsigned int eat = offset - headlen;
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index e9719afe91cf..3bb69464930b 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -449,8 +449,9 @@ static int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 	NAPI_GRO_CB(p)->count++;
 	p->data_len += skb->len;
 
-	/* sk owenrship - if any - completely transferred to the aggregated packet */
+	/* sk ownership - if any - completely transferred to the aggregated packet */
 	skb->destructor = NULL;
+	skb->sk = NULL;
 	p->truesize += skb->truesize;
 	p->len += skb->len;
 


