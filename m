Return-Path: <stable+bounces-154981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB748AE159A
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCD1C7A6F87
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 08:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A053923497B;
	Fri, 20 Jun 2025 08:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sbkS7SP5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9A423498F
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 08:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750407162; cv=none; b=SMAF/EUg94dBtQpsSJOxTz1v8RD2ctp/KWssAqA8yzrSUVpM1IVMt/iLoDzQ7bChsroQlbSS5gkEp1nzcKs0xhEDuL7ZYlysqTNT5lnWdRwPR065K+AaKhsvL+FVP31fJUahIDhNamWFudIgeqj6YtuzWqllN4polpiFIrOX4sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750407162; c=relaxed/simple;
	bh=CQgckVbHpK4nypnAkJ0ZIbhd5g59j3Sv/mLoSpJA/I8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YrFZJJgvr+UhT5AT//Tvp+OZ8AD2UxN1a0xRU316yJsCYvmcshvOcKvRvcxSA37C/fR61tI/l/X820dFwNySBkstBRLH8SKftM7R1+9G3I0idGpyXbKGS1P/+dQSDfh9q6DZI9BKTYNT+/Q/C7zEkW3ORfCqIiW893bv+bw9I2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sbkS7SP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853B9C4CEE3;
	Fri, 20 Jun 2025 08:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750407161;
	bh=CQgckVbHpK4nypnAkJ0ZIbhd5g59j3Sv/mLoSpJA/I8=;
	h=Subject:To:Cc:From:Date:From;
	b=sbkS7SP556GYqyYhtEn8xAKUAZxLMFAYLv2NUNEgMuCobAzC1P2KjPShEFbjOK+5F
	 dEMRLN/pv2hg26V5bv7vWkPd3gYQBKVbiVV7DtWJldbaUg7JxISq7F30n6NbCEq7gd
	 fYjM7WETHIzYSQtFcDFD+9PIAnS8NtJBWYbSsW6g=
Subject: FAILED: patch "[PATCH] bus: mhi: ep: Update read pointer only after buffer is" failed to apply to 6.1-stable tree
To: quic_sumk@quicinc.com,jeff.hugo@oss.qualcomm.com,krishna.chundru@oss.qualcomm.com,manivannan.sadhasivam@linaro.org,quic_yabdulra@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 10:12:38 +0200
Message-ID: <2025062038-browbeat-unusable-6825@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6f18d174b73d0ceeaa341f46c0986436b3aefc9a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062038-browbeat-unusable-6825@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6f18d174b73d0ceeaa341f46c0986436b3aefc9a Mon Sep 17 00:00:00 2001
From: Sumit Kumar <quic_sumk@quicinc.com>
Date: Wed, 9 Apr 2025 16:17:43 +0530
Subject: [PATCH] bus: mhi: ep: Update read pointer only after buffer is
 written

Inside mhi_ep_ring_add_element, the read pointer (rd_offset) is updated
before the buffer is written, potentially causing race conditions where
the host sees an updated read pointer before the buffer is actually
written. Updating rd_offset prematurely can lead to the host accessing
an uninitialized or incomplete element, resulting in data corruption.

Invoke the buffer write before updating rd_offset to ensure the element
is fully written before signaling its availability.

Fixes: bbdcba57a1a2 ("bus: mhi: ep: Add support for ring management")
cc: stable@vger.kernel.org
Co-developed-by: Youssef Samir <quic_yabdulra@quicinc.com>
Signed-off-by: Youssef Samir <quic_yabdulra@quicinc.com>
Signed-off-by: Sumit Kumar <quic_sumk@quicinc.com>
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://patch.msgid.link/20250409-rp_fix-v1-1-8cf1fa22ed28@quicinc.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

diff --git a/drivers/bus/mhi/ep/ring.c b/drivers/bus/mhi/ep/ring.c
index aeb53b2c34a8..26357ee68dee 100644
--- a/drivers/bus/mhi/ep/ring.c
+++ b/drivers/bus/mhi/ep/ring.c
@@ -131,19 +131,23 @@ int mhi_ep_ring_add_element(struct mhi_ep_ring *ring, struct mhi_ring_element *e
 	}
 
 	old_offset = ring->rd_offset;
-	mhi_ep_ring_inc_index(ring);
 
 	dev_dbg(dev, "Adding an element to ring at offset (%zu)\n", ring->rd_offset);
+	buf_info.host_addr = ring->rbase + (old_offset * sizeof(*el));
+	buf_info.dev_addr = el;
+	buf_info.size = sizeof(*el);
+
+	ret = mhi_cntrl->write_sync(mhi_cntrl, &buf_info);
+	if (ret)
+		return ret;
+
+	mhi_ep_ring_inc_index(ring);
 
 	/* Update rp in ring context */
 	rp = cpu_to_le64(ring->rd_offset * sizeof(*el) + ring->rbase);
 	memcpy_toio((void __iomem *) &ring->ring_ctx->generic.rp, &rp, sizeof(u64));
 
-	buf_info.host_addr = ring->rbase + (old_offset * sizeof(*el));
-	buf_info.dev_addr = el;
-	buf_info.size = sizeof(*el);
-
-	return mhi_cntrl->write_sync(mhi_cntrl, &buf_info);
+	return ret;
 }
 
 void mhi_ep_ring_init(struct mhi_ep_ring *ring, enum mhi_ep_ring_type type, u32 id)


