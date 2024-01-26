Return-Path: <stable+bounces-15957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D5883E569
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4F41F21BB3
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 22:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03AE25545;
	Fri, 26 Jan 2024 22:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TsEIDDq6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609FE24B22
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 22:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308112; cv=none; b=JdkVGOrM5DfxIjZbXcHSiSjdWsBLGzIb8mN6LmXig5kQ86i8jE5eMzenchLBosIuBLG8LwaBoo8RSd/qyESFH3byHURaGwhr+y2TWgD3rnSnG9KTCnTNWek1VMf3LoRSSLX8rhUKbQRC2UkXjkKVyPBhX51Pk8qrDW+9hpmkJZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308112; c=relaxed/simple;
	bh=xZBhOP2HvWnZVqbm5yzMy/4fWVDFSZ+WZ+uDRwrAzQg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HIp3n2QymC9Z0y/dIg4//X4KhbdMbzh6NSHKuZXU9opyFYjhTsLqAv2tqbM/9wBmIkZoGmeaYG1MwHUFfqY4NTQ3XptfM2au9TBOTD77k2Cw03OaMvLuqVzkO7THw6PepSyFLNVSUoxxizVnQ/EbhTqM3D3+nX+dd0KOii90SzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TsEIDDq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3290C433F1;
	Fri, 26 Jan 2024 22:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706308111;
	bh=xZBhOP2HvWnZVqbm5yzMy/4fWVDFSZ+WZ+uDRwrAzQg=;
	h=Subject:To:Cc:From:Date:From;
	b=TsEIDDq6QWIbj1eUdzvfmxytnb5BjKI9+xIq7gaONp8Ny/YoARDl3cJMsot6/hcQQ
	 IGUVvFlkJXGpSPqsKZy1b2K83Yqm+Djd/SJiSaMa8DQq2zOjNWI3gV934GhGzM5lh5
	 t1uARM6s+Vjd2lW/ShqJwxRpYn/UWokHiVp7OmqM=
Subject: FAILED: patch "[PATCH] bus: mhi: host: Add alignment check for event ring read" failed to apply to 5.15-stable tree
To: quic_krichai@quicinc.com,manivannan.sadhasivam@linaro.org,quic_jhugo@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 14:28:30 -0800
Message-ID: <2024012630-reference-stumbling-1d52@gregkh>
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
git cherry-pick -x eff9704f5332a13b08fbdbe0f84059c9e7051d5f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012630-reference-stumbling-1d52@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

eff9704f5332 ("bus: mhi: host: Add alignment check for event ring read pointer")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From eff9704f5332a13b08fbdbe0f84059c9e7051d5f Mon Sep 17 00:00:00 2001
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Tue, 31 Oct 2023 15:21:05 +0530
Subject: [PATCH] bus: mhi: host: Add alignment check for event ring read
 pointer

Though we do check the event ring read pointer by "is_valid_ring_ptr"
to make sure it is in the buffer range, but there is another risk the
pointer may be not aligned.  Since we are expecting event ring elements
are 128 bits(struct mhi_ring_element) aligned, an unaligned read pointer
could lead to multiple issues like DoS or ring buffer memory corruption.

So add a alignment check for event ring read pointer.

Fixes: ec32332df764 ("bus: mhi: core: Sanity check values from remote device before use")
cc: stable@vger.kernel.org
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20231031-alignment_check-v2-1-1441db7c5efd@quicinc.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 6cf11457380b..d80975f4bba8 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -269,7 +269,8 @@ static void mhi_del_ring_element(struct mhi_controller *mhi_cntrl,
 
 static bool is_valid_ring_ptr(struct mhi_ring *ring, dma_addr_t addr)
 {
-	return addr >= ring->iommu_base && addr < ring->iommu_base + ring->len;
+	return addr >= ring->iommu_base && addr < ring->iommu_base + ring->len &&
+			!(addr & (sizeof(struct mhi_ring_element) - 1));
 }
 
 int mhi_destroy_device(struct device *dev, void *data)


