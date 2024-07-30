Return-Path: <stable+bounces-62721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48727940DEC
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21045B2829E
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C71419645E;
	Tue, 30 Jul 2024 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i+jIbbAJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C206C195FE0
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332068; cv=none; b=kS5bmih8yKkLofcnomT22Hyz1T7ZcJX65evoqY67GB4pFkqkWs1z4euL/NAsd+lUYS2f+WiHQ7Cwsui2X0O0AkbOCAy+LVCVfe/Q6R7lFs/shfD7InA1grjze9qC8AfBRIDyw422FRPzjv9elL8l+bVkwkZ2KuZfZ4vbDAWKmZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332068; c=relaxed/simple;
	bh=d/X0HWwdfyIboBTUANrwWKVa7+NQ5xbmNKAaNtVpW2g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=L/opQG40yaVcXde3pfCW532BFOKGRoYKr+Bpc/t0d96JoGt0D6ybZRmuTaTh7/LX3GqxFopZzAkySpD4Z8P0jDM7OCNpPH5FdxFcfShdIhcMJp3saKzU8IX9bSo4YQAEkaYoDfBgDaDcF6rkQtNUtIJcg94+BhVHJgaStdQczyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i+jIbbAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15B4C4AF51;
	Tue, 30 Jul 2024 09:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722332068;
	bh=d/X0HWwdfyIboBTUANrwWKVa7+NQ5xbmNKAaNtVpW2g=;
	h=Subject:To:Cc:From:Date:From;
	b=i+jIbbAJTJmuu0JGNv+rtArNHUnXvW3jchoTPWqslbDBFI6mQ32kvsS6cUarPC1K7
	 LTPMbegM9zReYNLMFDKARAm8aumnI1MrOrTDLbYAgxtIB6quAKAo+iNFp2tTZbIuG2
	 CzqOyDyUUNHx9urRVamuulo1EBx6eqmRuUqDGIB8=
Subject: FAILED: patch "[PATCH] bus: mhi: ep: Do not allocate memory for MHI objects from DMA" failed to apply to 6.6-stable tree
To: manivannan.sadhasivam@linaro.org,quic_mrana@quicinc.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 11:34:24 +0200
Message-ID: <2024073024-passable-cardigan-cd15@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c7d0b2db5bc5e8c0fdc67b3c8f463c3dfec92f77
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073024-passable-cardigan-cd15@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

c7d0b2db5bc5 ("bus: mhi: ep: Do not allocate memory for MHI objects from DMA zone")
2547beb00ddb ("bus: mhi: ep: Add support for async DMA read operation")
ee08acb58fe4 ("bus: mhi: ep: Add support for async DMA write operation")
8b786ed8fb08 ("bus: mhi: ep: Introduce async read/write callbacks")
927105244f8b ("bus: mhi: ep: Rename read_from_host() and write_to_host() APIs")
b08ded2ef2e9 ("bus: mhi: ep: Pass mhi_ep_buf_info struct to read/write APIs")
62210a26cd4f ("bus: mhi: ep: Use slab allocator where applicable")
987fdb5a43a6 ("bus: mhi: ep: Do not allocate event ring element on stack")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c7d0b2db5bc5e8c0fdc67b3c8f463c3dfec92f77 Mon Sep 17 00:00:00 2001
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Mon, 3 Jun 2024 22:13:54 +0530
Subject: [PATCH] bus: mhi: ep: Do not allocate memory for MHI objects from DMA
 zone

MHI endpoint stack accidentally started allocating memory for objects from
DMA zone since commit 62210a26cd4f ("bus: mhi: ep: Use slab allocator
where applicable"). But there is no real need to allocate memory from this
naturally limited DMA zone. This also causes the MHI endpoint stack to run
out of memory while doing high bandwidth transfers.

So let's switch over to normal memory.

Cc: <stable@vger.kernel.org> # 6.8
Fixes: 62210a26cd4f ("bus: mhi: ep: Use slab allocator where applicable")
Reviewed-by: Mayank Rana <quic_mrana@quicinc.com>
Link: https://lore.kernel.org/r/20240603164354.79035-1-manivannan.sadhasivam@linaro.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index f8f674adf1d4..4acfac73ca9a 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -90,7 +90,7 @@ static int mhi_ep_send_completion_event(struct mhi_ep_cntrl *mhi_cntrl, struct m
 	struct mhi_ring_element *event;
 	int ret;
 
-	event = kmem_cache_zalloc(mhi_cntrl->ev_ring_el_cache, GFP_KERNEL | GFP_DMA);
+	event = kmem_cache_zalloc(mhi_cntrl->ev_ring_el_cache, GFP_KERNEL);
 	if (!event)
 		return -ENOMEM;
 
@@ -109,7 +109,7 @@ int mhi_ep_send_state_change_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_stat
 	struct mhi_ring_element *event;
 	int ret;
 
-	event = kmem_cache_zalloc(mhi_cntrl->ev_ring_el_cache, GFP_KERNEL | GFP_DMA);
+	event = kmem_cache_zalloc(mhi_cntrl->ev_ring_el_cache, GFP_KERNEL);
 	if (!event)
 		return -ENOMEM;
 
@@ -127,7 +127,7 @@ int mhi_ep_send_ee_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_ee_type exec_e
 	struct mhi_ring_element *event;
 	int ret;
 
-	event = kmem_cache_zalloc(mhi_cntrl->ev_ring_el_cache, GFP_KERNEL | GFP_DMA);
+	event = kmem_cache_zalloc(mhi_cntrl->ev_ring_el_cache, GFP_KERNEL);
 	if (!event)
 		return -ENOMEM;
 
@@ -146,7 +146,7 @@ static int mhi_ep_send_cmd_comp_event(struct mhi_ep_cntrl *mhi_cntrl, enum mhi_e
 	struct mhi_ring_element *event;
 	int ret;
 
-	event = kmem_cache_zalloc(mhi_cntrl->ev_ring_el_cache, GFP_KERNEL | GFP_DMA);
+	event = kmem_cache_zalloc(mhi_cntrl->ev_ring_el_cache, GFP_KERNEL);
 	if (!event)
 		return -ENOMEM;
 
@@ -438,7 +438,7 @@ static int mhi_ep_read_channel(struct mhi_ep_cntrl *mhi_cntrl,
 		read_offset = mhi_chan->tre_size - mhi_chan->tre_bytes_left;
 		write_offset = len - buf_left;
 
-		buf_addr = kmem_cache_zalloc(mhi_cntrl->tre_buf_cache, GFP_KERNEL | GFP_DMA);
+		buf_addr = kmem_cache_zalloc(mhi_cntrl->tre_buf_cache, GFP_KERNEL);
 		if (!buf_addr)
 			return -ENOMEM;
 
@@ -1481,14 +1481,14 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 
 	mhi_cntrl->ev_ring_el_cache = kmem_cache_create("mhi_ep_event_ring_el",
 							sizeof(struct mhi_ring_element), 0,
-							SLAB_CACHE_DMA, NULL);
+							0, NULL);
 	if (!mhi_cntrl->ev_ring_el_cache) {
 		ret = -ENOMEM;
 		goto err_free_cmd;
 	}
 
 	mhi_cntrl->tre_buf_cache = kmem_cache_create("mhi_ep_tre_buf", MHI_EP_DEFAULT_MTU, 0,
-						      SLAB_CACHE_DMA, NULL);
+						      0, NULL);
 	if (!mhi_cntrl->tre_buf_cache) {
 		ret = -ENOMEM;
 		goto err_destroy_ev_ring_el_cache;


