Return-Path: <stable+bounces-99626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9572B9E7281
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5587E286936
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064F01FCCE5;
	Fri,  6 Dec 2024 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RFP7RBwD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B782E859;
	Fri,  6 Dec 2024 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497812; cv=none; b=Nt6OC22WUe6JF4n4nhVfI4yfAZw3ZEjKVGwnTnkIxuXiO5T040pV0w6SO5WrC1lxqxu3dqmGxi9Tjyw1n4xBooN6DdTE7WzembwtL32FzSPSs+lMq93V+aHiUOBETNmAdykPMfIKNSpP4v+HwohXauIcmRT0ncp4v6TczxxdmQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497812; c=relaxed/simple;
	bh=v2sbfikPSrXjQO6hXUzU1U78W0JTtZzV95n+2c/8nk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fj/R0gmKyozpXWTvyM52jSFqLPDdR8amP1B8JZpMBL3NzPih9KsaAP4UHAmg2zfjQlCCmN+fo4vQvZj80L8f2Ih/5W/Xc62MMhBcZKBrU0pVK87knThPD0+sT95N+9K4EJqMjqQxLP2wEFNL6w6fMS08oSdoVLmBtdLZJ3CGFSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RFP7RBwD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2477DC4CED1;
	Fri,  6 Dec 2024 15:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733497812;
	bh=v2sbfikPSrXjQO6hXUzU1U78W0JTtZzV95n+2c/8nk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RFP7RBwDHcP1yuDUjjr5Bc1Hqn+SVMaMD8IdHy9DP2zr7PwDHEpNgiM30FTK3efjA
	 fJf9HHf6998K+TAacC75ExROHandd1tfzeiJKnRLY12UZTSE0fl1tJmHgeeH06Pqcn
	 1lyUnOI+OtiJnRX2I1FUZmfVQBIqu0Z7npDZ2U4U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Salam Noureddine <noureddine@arista.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 400/676] tg3: Set coherent DMA mask bits to 31 for BCM57766 chipsets
Date: Fri,  6 Dec 2024 15:33:39 +0100
Message-ID: <20241206143708.974486925@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
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

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

[ Upstream commit 614f4d166eeeb9bd709b0ad29552f691c0f45776 ]

The hardware on Broadcom 1G chipsets have a known limitation
where they cannot handle DMA addresses that cross over 4GB.
When such an address is encountered, the hardware sets the
address overflow error bit in the DMA status register and
triggers a reset.

However, BCM57766 hardware is setting the overflow bit and
triggering a reset in some cases when there is no actual
underlying address overflow. The hardware team analyzed the
issue and concluded that it is happening when the status
block update has an address with higher (b16 to b31) bits
as 0xffff following a previous update that had lowest bits
as 0xffff.

To work around this bug in the BCM57766 hardware, set the
coherent dma mask from the current 64b to 31b. This will
ensure that upper bits of the status block DMA address are
always at most 0x7fff, thus avoiding the improper overflow
check described above. This work around is intended for only
status block and ring memories and has no effect on TX and
RX buffers as they do not require coherent memory.

Fixes: 72f2afb8a685 ("[TG3]: Add DMA address workaround")
Reported-by: Salam Noureddine <noureddine@arista.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Link: https://patch.msgid.link/20241119055741.147144-1-pavan.chebbi@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/tg3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index f1c8ff5b63acd..7f74e5e106d9d 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -17731,6 +17731,9 @@ static int tg3_init_one(struct pci_dev *pdev,
 	} else
 		persist_dma_mask = dma_mask = DMA_BIT_MASK(64);
 
+	if (tg3_asic_rev(tp) == ASIC_REV_57766)
+		persist_dma_mask = DMA_BIT_MASK(31);
+
 	/* Configure DMA attributes. */
 	if (dma_mask > DMA_BIT_MASK(32)) {
 		err = dma_set_mask(&pdev->dev, dma_mask);
-- 
2.43.0




