Return-Path: <stable+bounces-70639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63174960F4B
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2060928232F
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4E61C93A3;
	Tue, 27 Aug 2024 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vaB7ZhH3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAB01C8FDE;
	Tue, 27 Aug 2024 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770577; cv=none; b=KdWJoFYpWbxZe9FaAFy2NcoJ3/qLQsvkmZMZR3/6LvC5PprxZcbqPCnKYyRvNeG7g7HRFwzwj+L1Q6gstl38oPbZo2hF2HiiJ6qEUco/UEsPZEPGDlvaRsa1SP4Ab3jWX8f2GpS+SU43kh4WovfjuTcrCSOc6RpKYlaAUMdJov0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770577; c=relaxed/simple;
	bh=C8AXV06tZPyeQSoMCD49ug40XoYUjJlXjyynug9Q53I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6uegxCuRMcgFDwaP15RlZvKOaEAkqEEopjlXbdaNE+qwfV02SqIpNugypzCRJT8mRN3hxumrrZxXV/SsvYufzInyAScZzQITmYDjJ6zhDOJ7FWH1DMuT73n6S9RJuJpltDGkT5joVsNxON1NrBOdcIxs3Xnozz1xJfGTb89BV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vaB7ZhH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53959C4E699;
	Tue, 27 Aug 2024 14:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724770577;
	bh=C8AXV06tZPyeQSoMCD49ug40XoYUjJlXjyynug9Q53I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vaB7ZhH3qpiy5ooHxHRY6jBKK1fohDuYXNF3qzHddA4Q+pPNAHwmMtmauN0IuUvTZ
	 IIu1F16jaVmqQoavOvMxEIKuZAa2BUoTCKqH/ZLdrdydT2MtVIYhPM/KJ0a2UlDbG2
	 mJsOJChCR/INlj0R1f7H/IH30Ml4DXvxRFlfYzQ8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 271/341] bnxt_en: Fix double DMA unmapping for XDP_REDIRECT
Date: Tue, 27 Aug 2024 16:38:22 +0200
Message-ID: <20240827143853.712732046@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
References: <20240827143843.399359062@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Somnath Kotur <somnath.kotur@broadcom.com>

[ Upstream commit 8baeef7616d5194045c5a6b97fd1246b87c55b13 ]

Remove the dma_unmap_page_attrs() call in the driver's XDP_REDIRECT
code path.  This should have been removed when we let the page pool
handle the DMA mapping.  This bug causes the warning:

WARNING: CPU: 7 PID: 59 at drivers/iommu/dma-iommu.c:1198 iommu_dma_unmap_page+0xd5/0x100
CPU: 7 PID: 59 Comm: ksoftirqd/7 Tainted: G        W          6.8.0-1010-gcp #11-Ubuntu
Hardware name: Dell Inc. PowerEdge R7525/0PYVT1, BIOS 2.15.2 04/02/2024
RIP: 0010:iommu_dma_unmap_page+0xd5/0x100
Code: 89 ee 48 89 df e8 cb f2 69 ff 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d 31 c0 31 d2 31 c9 31 f6 31 ff 45 31 c0 e9 ab 17 71 00 <0f> 0b 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d 31 c0 31 d2 31 c9
RSP: 0018:ffffab1fc0597a48 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff99ff838280c8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffab1fc0597a78 R08: 0000000000000002 R09: ffffab1fc0597c1c
R10: ffffab1fc0597cd3 R11: ffff99ffe375acd8 R12: 00000000e65b9000
R13: 0000000000000050 R14: 0000000000001000 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff9a06efb80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000565c34c37210 CR3: 00000005c7e3e000 CR4: 0000000000350ef0
? show_regs+0x6d/0x80
? __warn+0x89/0x150
? iommu_dma_unmap_page+0xd5/0x100
? report_bug+0x16a/0x190
? handle_bug+0x51/0xa0
? exc_invalid_op+0x18/0x80
? iommu_dma_unmap_page+0xd5/0x100
? iommu_dma_unmap_page+0x35/0x100
dma_unmap_page_attrs+0x55/0x220
? bpf_prog_4d7e87c0d30db711_xdp_dispatcher+0x64/0x9f
bnxt_rx_xdp+0x237/0x520 [bnxt_en]
bnxt_rx_pkt+0x640/0xdd0 [bnxt_en]
__bnxt_poll_work+0x1a1/0x3d0 [bnxt_en]
bnxt_poll+0xaa/0x1e0 [bnxt_en]
__napi_poll+0x33/0x1e0
net_rx_action+0x18a/0x2f0

Fixes: 578fcfd26e2a ("bnxt_en: Let the page pool manage the DMA mapping")
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20240820203415.168178-1-michael.chan@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 8cb9a99154aad..2845796f782c2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -297,11 +297,6 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 		 * redirect is coming from a frame received by the
 		 * bnxt_en driver.
 		 */
-		rx_buf = &rxr->rx_buf_ring[cons];
-		mapping = rx_buf->mapping - bp->rx_dma_offset;
-		dma_unmap_page_attrs(&pdev->dev, mapping,
-				     BNXT_RX_PAGE_SIZE, bp->rx_dir,
-				     DMA_ATTR_WEAK_ORDERING);
 
 		/* if we are unable to allocate a new buffer, abort and reuse */
 		if (bnxt_alloc_rx_data(bp, rxr, rxr->rx_prod, GFP_ATOMIC)) {
-- 
2.43.0




