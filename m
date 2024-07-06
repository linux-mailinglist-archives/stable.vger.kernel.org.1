Return-Path: <stable+bounces-58166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDED92922D
	for <lists+stable@lfdr.de>; Sat,  6 Jul 2024 11:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA0B282F0E
	for <lists+stable@lfdr.de>; Sat,  6 Jul 2024 09:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA144120B;
	Sat,  6 Jul 2024 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LD/XDaGo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C659C28F0
	for <stable@vger.kernel.org>; Sat,  6 Jul 2024 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720257442; cv=none; b=Klv+YoMRzBK80rcANFmGO16n4gV6Bt+bUau39IiKMmjE37TRHvbaNt4PRGR2HYT9+WXewaC3hsf2ramWVJh5rkqe5HS9tgSuUL2W//ZAYLIpkYTEfwNlLAOAgs6PCesCynf8R1TYZYu3AWSplq+1rgjklRDmJOSNqobEL31dp44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720257442; c=relaxed/simple;
	bh=E4Rq0KEHo6es9ElRo20G9FO2Kjx+qPcNwr9RIH9y7bQ=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=ps+KEk9Qm4kolcIo+hz+yeluOqzj/M6W5O7LAcob0l29mS/3OUk67mqyLcA4t4WjRBWYwSfccjbwXueBDVBLvyhmh6894NHxZJ93NiDEQPcGqK+adDGPfDXorLSKJFdr30zLkN9vHoHcct4QCh4YsVcgjmgbEo7qveJB++pfXfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LD/XDaGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B73C2BD10;
	Sat,  6 Jul 2024 09:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720257442;
	bh=E4Rq0KEHo6es9ElRo20G9FO2Kjx+qPcNwr9RIH9y7bQ=;
	h=Subject:To:From:Date:From;
	b=LD/XDaGo0EooWeoNh4tiC3hm6JdfeoLzsCZkdi5FtY3tfKpfGgJHpNfEC7w+qWZGO
	 THCSc5YjFOmYrl1NeQJz/j7zIQs5katEGLhupPbwzrJMYNbVYYxPg8oAUVb04QGjUT
	 cLhL+2rJ2Nm9XcCjeMxYa3AgpIA0IiZkrII5L8dQ=
Subject: patch "bus: mhi: ep: Do not allocate memory for MHI objects from DMA zone" added to char-misc-testing
To: manivannan.sadhasivam@linaro.org,quic_mrana@quicinc.com,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sat, 06 Jul 2024 11:17:19 +0200
Message-ID: <2024070619-dividend-manicotti-3467@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    bus: mhi: ep: Do not allocate memory for MHI objects from DMA zone

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From c7d0b2db5bc5e8c0fdc67b3c8f463c3dfec92f77 Mon Sep 17 00:00:00 2001
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Mon, 3 Jun 2024 22:13:54 +0530
Subject: bus: mhi: ep: Do not allocate memory for MHI objects from DMA zone

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
---
 drivers/bus/mhi/ep/main.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

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
-- 
2.45.2



