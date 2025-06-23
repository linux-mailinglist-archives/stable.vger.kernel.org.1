Return-Path: <stable+bounces-156707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BD7AE50C4
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D41E07AC9C7
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597501E521E;
	Mon, 23 Jun 2025 21:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uN5dEWwS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169DA19C554;
	Mon, 23 Jun 2025 21:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714072; cv=none; b=IgCtva/iV8xWsyUAL4e9+lmPtQMBUd1O0NvKXqBjNpePllPXS24lO9r/9NhtrRP25ikjuSB+vF4ziH//zNZN4/N+HGb7xwh7eTRTFDvjF7WNkRT1FeXtVvMwfEqzgPHxngOQpLEqvxjr0mtbQaIPTCvy6DP15hofdykeoSIK0ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714072; c=relaxed/simple;
	bh=f03Jf5491enVbopMQvuF3HdsRtJmDI3G8STHsWJk6tU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/aSffYn+ESxcUz7L9n/ws2aiwj+sUtpLRLdHW0A2BtaQBiznKBRu2SBnl9BXLIBqS5r86HVQg9O2ZDWU8N7xsCulU9wsKmIwIyiyG1ylUTKyL41ddvlhbe1sMk7ecd5/jrsIAC5dU8v0zROVUujQRMC8Fapbcy//KD1eUQ9Kok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uN5dEWwS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A170FC4CEEA;
	Mon, 23 Jun 2025 21:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750714072;
	bh=f03Jf5491enVbopMQvuF3HdsRtJmDI3G8STHsWJk6tU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uN5dEWwS1TfPAnKYhSl1EgdqsJvxIEQ+dHoQXl/XyIKP86noqwYtVYk0cmu2mOZIX
	 Cn+fYhynVhrACIm92mtkxhBCT270tObq5qc0yG7DvH5nZDUqnxLgVp7jlOu1wVA/6Z
	 7sIB6MPQAUAPL8BorQjOfuGtX5E5Bc4K9mUQUeR0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Youssef Samir <quic_yabdulra@quicinc.com>,
	Sumit Kumar <quic_sumk@quicinc.com>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 6.12 079/414] bus: mhi: ep: Update read pointer only after buffer is written
Date: Mon, 23 Jun 2025 15:03:36 +0200
Message-ID: <20250623130644.057671600@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sumit Kumar <quic_sumk@quicinc.com>

commit 6f18d174b73d0ceeaa341f46c0986436b3aefc9a upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bus/mhi/ep/ring.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/drivers/bus/mhi/ep/ring.c
+++ b/drivers/bus/mhi/ep/ring.c
@@ -131,19 +131,23 @@ int mhi_ep_ring_add_element(struct mhi_e
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



