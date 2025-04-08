Return-Path: <stable+bounces-129110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E99F5A7FE1B
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F039016DD0C
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE256267B7F;
	Tue,  8 Apr 2025 11:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XfRrbgdo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C60D26659C;
	Tue,  8 Apr 2025 11:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110142; cv=none; b=uEXlQJmv6CsvKVv4du3V0HZB0T6PD+d5CmNmidLqL/i3lDJzORjBJe+FJSMIr2284/sfU848TkKgFKW2SRHAVDLpYAyqnTQG81i+MGLiZ8ouVFe5ujwj0xTfoUOeTo4PKG/lIV2LKEe3Kgeiwn2u5P1q2BITMlaw4ichpUrYimo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110142; c=relaxed/simple;
	bh=0Heqv9WBCDjbFox2X+hF8w1BvsVLJghrwspv/TonC0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZEYmzk7xX5q2moirzICqz1drYI+QpD1lEzFZC8xt9/abd3Qde4cP1fAg/0WIlB4iH3m9fzS2FXqNmKmnvAUTv/ZppK1+sOoL31VRdHksBCGkMyE3rHIisgH99W631L2WTaS1EuaiVQ39Skcrsi1PFwADx/fWLzAM6kYkra79sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XfRrbgdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E61CC4CEE5;
	Tue,  8 Apr 2025 11:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744110142;
	bh=0Heqv9WBCDjbFox2X+hF8w1BvsVLJghrwspv/TonC0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XfRrbgdoz+X4eF7rRiRLHwQfqjCe6H4mrKciq+lTIZPGGrSC1QKUs87E9E9JzU9tS
	 EKYJk0nMRVgFZLWM27ayrH53OG4d+zSniVExW7gOAk4QMZNOskLOpLVsVVAs80+5qg
	 +g+GEpHqSJBuCFtQPLUDTmW37OFawtOHkfVuSsVI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Icenowy Zheng <uwu@icenowy.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 184/227] nvme-pci: skip CMB blocks incompatible with PCI P2P DMA
Date: Tue,  8 Apr 2025 12:49:22 +0200
Message-ID: <20250408104825.828101601@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.353768086@linuxfoundation.org>
References: <20250408104820.353768086@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Icenowy Zheng <uwu@icenowy.me>

[ Upstream commit 56cf7ef0d490b28fad8f8629fc135c5ab7c9f54e ]

The PCI P2PDMA code will register the CMB block to the memory
hot-plugging subsystem, which have an alignment requirement. Memory
blocks that do not satisfy this alignment requirement (usually 2MB) will
lead to a WARNING from memory hotplugging.

Verify the CMB block's address and size against the alignment and only
try to send CMB blocks compatible with it to prevent this warning.

Tested on Intel DC D4502 SSD, which has a 512K CMB block that is too
small for memory hotplugging (thus PCI P2PDMA).

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7993acdfd3185..a56baaafe79df 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1867,6 +1867,18 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	if (offset > bar_size)
 		return;
 
+	/*
+	 * Controllers may support a CMB size larger than their BAR, for
+	 * example, due to being behind a bridge. Reduce the CMB to the
+	 * reported size of the BAR
+	 */
+	size = min(size, bar_size - offset);
+
+	if (!IS_ALIGNED(size, memremap_compat_align()) ||
+	    !IS_ALIGNED(pci_resource_start(pdev, bar),
+			memremap_compat_align()))
+		return;
+
 	/*
 	 * Tell the controller about the host side address mapping the CMB,
 	 * and enable CMB decoding for the NVMe 1.4+ scheme:
@@ -1877,14 +1889,6 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 			     dev->bar + NVME_REG_CMBMSC);
 	}
 
-	/*
-	 * Controllers may support a CMB size larger than their BAR,
-	 * for example, due to being behind a bridge. Reduce the CMB to
-	 * the reported size of the BAR
-	 */
-	if (size > bar_size - offset)
-		size = bar_size - offset;
-
 	if (pci_p2pdma_add_resource(pdev, bar, size, offset)) {
 		dev_warn(dev->ctrl.device,
 			 "failed to register the CMB\n");
-- 
2.39.5




