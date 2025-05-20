Return-Path: <stable+bounces-145201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6417ABDA82
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398EC4A47F3
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA362441B4;
	Tue, 20 May 2025 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jbfyQFYK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC90EEC4;
	Tue, 20 May 2025 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749461; cv=none; b=nmFnSIyLevlfRzWTpBBKqjVemFArSIetzYHOngWIO3pM/FerSxvs6E60pmVKJhPPpora8lQPz/t3Y5QcG6wl4BwagGt/5al3D4tdM4dAVltkNqyc5wC5lW4FZL7DVn1bYH+hV9GVaicmWmFFYbVpwXAdGIR1acB2154kGvT16dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749461; c=relaxed/simple;
	bh=UmYHASVCrKQAuugMi0jPM1TVji/sm9PRp6wZahqrhf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGSfCGvZnIyItKf/28jQJqQOn9rn5PsQrWX/qgdDzro3vHvhQvzHYqkHqVxGOm4gsdg5NHXRDcgLmsBLvT198X2lNN0lY99LeHIO5Mq/t64EHQX1KsW8iOkGa9ZawXJy1iBy6eWZRKm7IXs8njBGFZ3R2eamWnKAg9I9YYYGgnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jbfyQFYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31A2C4CEE9;
	Tue, 20 May 2025 13:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747749461;
	bh=UmYHASVCrKQAuugMi0jPM1TVji/sm9PRp6wZahqrhf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jbfyQFYKhgSAU8vzuGcQyU0lXrl50jVTgiXU2dhOEJRCR5RWTYjyy2Q1QNpl+V38e
	 T7dqb+fccPZPhPHQ+85O7X8+q3kPPnyaA9zMjGqdI/H0WPHiPHj1wXypoNikB0DdmA
	 ROnMDXWr+w0YKEUH0yUgb/5mzg4n8nIKaIPtZ6Fk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Kelley <mhklinux@outlook.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 52/97] hv_netvsc: Remove rmsg_pgcnt
Date: Tue, 20 May 2025 15:50:17 +0200
Message-ID: <20250520125802.695116574@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125800.653047540@linuxfoundation.org>
References: <20250520125800.653047540@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Kelley <mhklinux@outlook.com>

commit 5bbc644bbf4e97a05bc0cb052189004588ff8a09 upstream.

init_page_array() now always creates a single page buffer array entry
for the rndis message, even if the rndis message crosses a page
boundary. As such, the number of page buffer array entries used for
the rndis message must no longer be tracked -- it is always just 1.
Remove the rmsg_pgcnt field and use "1" where the value is needed.

Cc: <stable@vger.kernel.org> # 6.1.x
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Link: https://patch.msgid.link/20250513000604.1396-5-mhklinux@outlook.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/hyperv_net.h |    1 -
 drivers/net/hyperv/netvsc.c     |    7 +++----
 drivers/net/hyperv/netvsc_drv.c |    1 -
 3 files changed, 3 insertions(+), 6 deletions(-)

--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -156,7 +156,6 @@ struct hv_netvsc_packet {
 	u8 cp_partial; /* partial copy into send buffer */
 
 	u8 rmsg_size; /* RNDIS header and PPI size */
-	u8 rmsg_pgcnt; /* page count of RNDIS header and PPI */
 	u8 page_buf_cnt;
 
 	u16 q_idx;
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -980,8 +980,7 @@ static void netvsc_copy_to_send_buf(stru
 		     + pend_size;
 	int i;
 	u32 padding = 0;
-	u32 page_count = packet->cp_partial ? packet->rmsg_pgcnt :
-		packet->page_buf_cnt;
+	u32 page_count = packet->cp_partial ? 1 : packet->page_buf_cnt;
 	u32 remain;
 
 	/* Add padding */
@@ -1164,7 +1163,7 @@ static inline int netvsc_send_pkt(
 		u32 desc_size;
 
 		if (packet->cp_partial)
-			pb += packet->rmsg_pgcnt;
+			pb++;
 
 		ret = netvsc_dma_map(ndev_ctx->device_ctx, packet, pb);
 		if (ret) {
@@ -1326,7 +1325,7 @@ int netvsc_send(struct net_device *ndev,
 		packet->send_buf_index = section_index;
 
 		if (packet->cp_partial) {
-			packet->page_buf_cnt -= packet->rmsg_pgcnt;
+			packet->page_buf_cnt--;
 			packet->total_data_buflen = msd_len + packet->rmsg_size;
 		} else {
 			packet->page_buf_cnt = 0;
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -342,7 +342,6 @@ static u32 init_page_array(void *hdr, u3
 	pb[0].len = len;
 	pb[0].pfn = virt_to_hvpfn(hdr);
 	packet->rmsg_size = len;
-	packet->rmsg_pgcnt = 1;
 
 	pb[1].offset = offset_in_hvpage(skb->data);
 	pb[1].len = skb_headlen(skb);



