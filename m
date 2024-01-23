Return-Path: <stable+bounces-12932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F038379BE
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99FA51C27359
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3631882D76;
	Tue, 23 Jan 2024 00:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RT8z4Kjj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E938250278;
	Tue, 23 Jan 2024 00:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968463; cv=none; b=hKxOoV+rtuTh5QN7o+UQmV5zu4kSckJ6eEBjnScSBKY/DLnVRPGB2AE994ggXZf7TcwihYbpxfNPyNVgXyXHdQv+qF7e39TcgerRzwKVvQSjOtdZRQAAxXwszCEG05xOK14cB3QjuxwM6SiMAx0QDDQy8Ml59Cjz2AQnTn7ZCK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968463; c=relaxed/simple;
	bh=eOhEN1MZ5TSsEeriQZc6Zlumwswls/i9cCP0kmPADV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krQJfkmAcZYtro5cJUnPJVlYgPyJpxjk7OHfp2Yl+2dpsk4gT8FF0ZYrVAQ/Rw7Vi37teMQiQQpUxiNFNxUTTWaKkS9AwN5y5tULJD/Y+58Ux3s3l9YvBegEVJDMxtWN/b81LRuNL+o0/2MMnh7Td/3EUhRMYr3hTjbaLHU5uZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RT8z4Kjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E000C433F1;
	Tue, 23 Jan 2024 00:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705968462;
	bh=eOhEN1MZ5TSsEeriQZc6Zlumwswls/i9cCP0kmPADV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RT8z4Kjji7c0leZhTsnCO7GfsssBQkjrjEYObXGZu1sRvMnyRRfq9vyx6T73S7TH6
	 5GT984t+IxUaOEkK01/Ro3hVblR94JpwJNci2UQp5/E8OiM45zn9eJRRUFQIXhMOOI
	 sNx0Xy/exHWBGqu8Q4E/iYDiTcpLYOgeD04ZfXo0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Beulich <jbeulich@suse.com>,
	Juergen Gross <jgross@suse.com>,
	Paul Durrant <paul@xen.org>
Subject: [PATCH 4.19 115/148] xen-netback: dont produce zero-size SKB frags
Date: Mon, 22 Jan 2024 15:57:51 -0800
Message-ID: <20240122235717.127396423@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235712.442097787@linuxfoundation.org>
References: <20240122235712.442097787@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Beulich <jbeulich@suse.com>

commit c7ec4f2d684e17d69bbdd7c4324db0ef5daac26a upstream.

While frontends may submit zero-size requests (wasting a precious slot),
core networking code as of at least 3ece782693c4b ("sock: skb_copy_ubufs
support for compound pages") can't deal with SKBs when they have all
zero-size fragments. Respond to empty requests right when populating
fragments; all further processing is fragment based and hence won't
encounter these empty requests anymore.

In a way this should have been that way from the beginning: When no data
is to be transferred for a particular request, there's not even a point
in validating the respective grant ref. That's no different from e.g.
passing NULL into memcpy() when at the same time the size is 0.

This is XSA-448 / CVE-2023-46838.

Cc: stable@vger.kernel.org
Signed-off-by: Jan Beulich <jbeulich@suse.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Paul Durrant <paul@xen.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/xen-netback/netback.c |   44 ++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -456,12 +456,25 @@ static void xenvif_get_requests(struct x
 	}
 
 	for (shinfo->nr_frags = 0; nr_slots > 0 && shinfo->nr_frags < MAX_SKB_FRAGS;
-	     shinfo->nr_frags++, gop++, nr_slots--) {
+	     nr_slots--) {
+		if (unlikely(!txp->size)) {
+			unsigned long flags;
+
+			spin_lock_irqsave(&queue->response_lock, flags);
+			make_tx_response(queue, txp, 0, XEN_NETIF_RSP_OKAY);
+			push_tx_responses(queue);
+			spin_unlock_irqrestore(&queue->response_lock, flags);
+			++txp;
+			continue;
+		}
+
 		index = pending_index(queue->pending_cons++);
 		pending_idx = queue->pending_ring[index];
 		xenvif_tx_create_map_op(queue, pending_idx, txp,
 				        txp == first ? extra_count : 0, gop);
 		frag_set_pending_idx(&frags[shinfo->nr_frags], pending_idx);
+		++shinfo->nr_frags;
+		++gop;
 
 		if (txp == first)
 			txp = txfrags;
@@ -474,20 +487,39 @@ static void xenvif_get_requests(struct x
 		shinfo = skb_shinfo(nskb);
 		frags = shinfo->frags;
 
-		for (shinfo->nr_frags = 0; shinfo->nr_frags < nr_slots;
-		     shinfo->nr_frags++, txp++, gop++) {
+		for (shinfo->nr_frags = 0; shinfo->nr_frags < nr_slots; ++txp) {
+			if (unlikely(!txp->size)) {
+				unsigned long flags;
+
+				spin_lock_irqsave(&queue->response_lock, flags);
+				make_tx_response(queue, txp, 0,
+						 XEN_NETIF_RSP_OKAY);
+				push_tx_responses(queue);
+				spin_unlock_irqrestore(&queue->response_lock,
+						       flags);
+				continue;
+			}
+
 			index = pending_index(queue->pending_cons++);
 			pending_idx = queue->pending_ring[index];
 			xenvif_tx_create_map_op(queue, pending_idx, txp, 0,
 						gop);
 			frag_set_pending_idx(&frags[shinfo->nr_frags],
 					     pending_idx);
+			++shinfo->nr_frags;
+			++gop;
 		}
 
-		skb_shinfo(skb)->frag_list = nskb;
-	} else if (nskb) {
+		if (shinfo->nr_frags) {
+			skb_shinfo(skb)->frag_list = nskb;
+			nskb = NULL;
+		}
+	}
+
+	if (nskb) {
 		/* A frag_list skb was allocated but it is no longer needed
-		 * because enough slots were converted to copy ops above.
+		 * because enough slots were converted to copy ops above or some
+		 * were empty.
 		 */
 		kfree_skb(nskb);
 	}



