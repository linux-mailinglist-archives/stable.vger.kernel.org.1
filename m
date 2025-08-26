Return-Path: <stable+bounces-173542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2349B35DD9
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3B3189004D
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38812820B1;
	Tue, 26 Aug 2025 11:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nlklQ4CE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED71199935;
	Tue, 26 Aug 2025 11:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208519; cv=none; b=iEuVj13S7wyPrAuzLBUvbSz/pqm2HeIvmzM+g2AOc+VGqOGNeryFhzhqIB6o+Iaq7MND723tejhdRa1Xx25nfOf6Gr6CYeeSYc3jtwnD0qwSztQpi9orOq9Cbel18UI8QH4XRqNEjEzFoitpWa3xCqQb6YEUTQ12QK4xq3IfEdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208519; c=relaxed/simple;
	bh=uB1UCPiPqOY7SLHpNFsb9+i1WA/K2Vob+CJYUMTgeOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8zF+/TolXBxgrK8clJp47ynYgPH35tATmsrVxFhFx9HoSVLOHfWScM2pYZTquvhLsat+xoeDVUwA8STVm531irPwAdv33YUsiR2/1VM57VXpW4Me/7Kea0sI+q2xOhBhZy0lNa7r3CYbl3TruCAcwNHQw2tX4obHSLDzEng3Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nlklQ4CE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410B6C4CEF1;
	Tue, 26 Aug 2025 11:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208519;
	bh=uB1UCPiPqOY7SLHpNFsb9+i1WA/K2Vob+CJYUMTgeOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nlklQ4CEiUaU1Oya9X6V5dwXRIJMr3XZy1F7lqR8a0cCTQ0oa/WMUCBvbXiug+iYe
	 jhHoQsZP1flYDcMB0B7ioR1sAye5syFS9eI8JFigTA6urcmZflRFRh6StmueKgtvAo
	 rXorPOtsS2UBVVvZul9/UCVp+v+ABYIEC0qkhbQc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vedang Nagar <quic_vnagar@quicinc.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Bryan ODonoghue <bryan.odonoghue@linaro.org>,
	Bryan ODonoghue <bod@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.12 112/322] media: venus: Add a check for packet size after reading from shared memory
Date: Tue, 26 Aug 2025 13:08:47 +0200
Message-ID: <20250826110918.554048902@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
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

From: Vedang Nagar <quic_vnagar@quicinc.com>

commit 49befc830daa743e051a65468c05c2ff9e8580e6 upstream.

Add a check to ensure that the packet size does not exceed the number of
available words after reading the packet header from shared memory. This
ensures that the size provided by the firmware is safe to process and
prevent potential out-of-bounds memory access.

Fixes: d96d3f30c0f2 ("[media] media: venus: hfi: add Venus HFI files")
Cc: stable@vger.kernel.org
Signed-off-by: Vedang Nagar <quic_vnagar@quicinc.com>
Co-developed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -239,6 +239,7 @@ static int venus_write_queue(struct venu
 static int venus_read_queue(struct venus_hfi_device *hdev,
 			    struct iface_queue *queue, void *pkt, u32 *tx_req)
 {
+	struct hfi_pkt_hdr *pkt_hdr = NULL;
 	struct hfi_queue_header *qhdr;
 	u32 dwords, new_rd_idx;
 	u32 rd_idx, wr_idx, type, qsize;
@@ -304,6 +305,9 @@ static int venus_read_queue(struct venus
 			memcpy(pkt, rd_ptr, len);
 			memcpy(pkt + len, queue->qmem.kva, new_rd_idx << 2);
 		}
+		pkt_hdr = (struct hfi_pkt_hdr *)(pkt);
+		if ((pkt_hdr->size >> 2) != dwords)
+			return -EINVAL;
 	} else {
 		/* bad packet received, dropping */
 		new_rd_idx = qhdr->write_idx;



