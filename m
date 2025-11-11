Return-Path: <stable+bounces-193657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D53C4A7F7
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A92F1895EEB
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1823346E64;
	Tue, 11 Nov 2025 01:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uFWQALdR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA0F25EF81;
	Tue, 11 Nov 2025 01:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823701; cv=none; b=cDa4IPfgDp9pBmBjzGJ1FG/nWH2wso3u4hkd8iL0RW00qQ91u/gQ2tLr3ZTTlNIbb9lRUUnsEZjG7jQK/zgNXTaINd5E5xWHdx9EnHnrqaNuitK1eXCYkVIql+0KviiBltJGMOskExx0E2Sujk2qJBvFsQnbLuNTInniF6s33vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823701; c=relaxed/simple;
	bh=fkaT8skzYxl85U157kXaCBh7GAyvAoVQVRNB8hA3R5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENVb8GPLppD5sLROrTi0cjX41gLptx5blD484e01pJfL67o6YrulsmsJaFZzU0lsx8rvodu8YuucTpmST09auy+4DAFeADzTa5/7xzSi1gvjwF4klwCiOmdrQ9mTu2AwYCaKXZF2IaXHgSw2CkkIZUL04KrLF56yn8AvcYK47Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uFWQALdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB41CC4AF09;
	Tue, 11 Nov 2025 01:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762823701;
	bh=fkaT8skzYxl85U157kXaCBh7GAyvAoVQVRNB8hA3R5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uFWQALdRjCLKPYgf++zOur1zRdZomnWLxcm+dKqemc6e30zCedMuodFaUsq5db6/z
	 aEqdEJi698UXqeM85rnpmo71WUd7rr9xmUe7R94tL8Tl7iVbWNXp7E2zuzpsqIbyRq
	 fbqoDncJHD02SAFs/lQms/OnC1pbvlCMXMypTB3k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vasant Hegde <vasant.hegde@amd.com>,
	Sairaj Kodilkar <sarunkod@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 303/565] iommu/amd: Skip enabling command/event buffers for kdump
Date: Tue, 11 Nov 2025 09:42:39 +0900
Message-ID: <20251111004533.694778666@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004526.816196597@linuxfoundation.org>
References: <20251111004526.816196597@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Ashish Kalra <ashish.kalra@amd.com>

[ Upstream commit 9be15fbfc6c5c89c22cf6e209f66ea43ee0e58bb ]

After a panic if SNP is enabled in the previous kernel then the kdump
kernel boots with IOMMU SNP enforcement still enabled.

IOMMU command buffers and event buffer registers remain locked and
exclusive to the previous kernel. Attempts to enable command and event
buffers in the kdump kernel will fail, as hardware ignores writes to
the locked MMIO registers as per AMD IOMMU spec Section 2.12.2.1.

Skip enabling command buffers and event buffers for kdump boot as they
are already enabled in the previous kernel.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Link: https://lore.kernel.org/r/576445eb4f168b467b0fc789079b650ca7c5b037.1756157913.git.ashish.kalra@amd.com
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd/init.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index f5b544e0f230b..af147d279a294 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -816,11 +816,16 @@ static void iommu_enable_command_buffer(struct amd_iommu *iommu)
 
 	BUG_ON(iommu->cmd_buf == NULL);
 
-	entry = iommu_virt_to_phys(iommu->cmd_buf);
-	entry |= MMIO_CMD_SIZE_512;
-
-	memcpy_toio(iommu->mmio_base + MMIO_CMD_BUF_OFFSET,
-		    &entry, sizeof(entry));
+	if (!is_kdump_kernel()) {
+		/*
+		 * Command buffer is re-used for kdump kernel and setting
+		 * of MMIO register is not required.
+		 */
+		entry = iommu_virt_to_phys(iommu->cmd_buf);
+		entry |= MMIO_CMD_SIZE_512;
+		memcpy_toio(iommu->mmio_base + MMIO_CMD_BUF_OFFSET,
+			    &entry, sizeof(entry));
+	}
 
 	amd_iommu_reset_cmd_buffer(iommu);
 }
@@ -869,10 +874,15 @@ static void iommu_enable_event_buffer(struct amd_iommu *iommu)
 
 	BUG_ON(iommu->evt_buf == NULL);
 
-	entry = iommu_virt_to_phys(iommu->evt_buf) | EVT_LEN_MASK;
-
-	memcpy_toio(iommu->mmio_base + MMIO_EVT_BUF_OFFSET,
-		    &entry, sizeof(entry));
+	if (!is_kdump_kernel()) {
+		/*
+		 * Event buffer is re-used for kdump kernel and setting
+		 * of MMIO register is not required.
+		 */
+		entry = iommu_virt_to_phys(iommu->evt_buf) | EVT_LEN_MASK;
+		memcpy_toio(iommu->mmio_base + MMIO_EVT_BUF_OFFSET,
+			    &entry, sizeof(entry));
+	}
 
 	/* set head and tail to zero manually */
 	writel(0x00, iommu->mmio_base + MMIO_EVT_HEAD_OFFSET);
-- 
2.51.0




