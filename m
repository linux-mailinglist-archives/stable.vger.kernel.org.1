Return-Path: <stable+bounces-164764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F82B12492
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 21:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCEA5188634E
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 19:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7362257427;
	Fri, 25 Jul 2025 19:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="jg8zYEHL"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6C1256C9C;
	Fri, 25 Jul 2025 19:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753470227; cv=pass; b=nMjwCneDByMlZj8lvPZkdE20Ho+MP4//8GUGcDziOycpJuA2VxEkIX9e2s3RaIs/NY1TP4lKmmVG93/+V2g1Cl12i9Xv6C/v19paOBSUVAzdOseuUrZSArej1/osOUnK2QI6NPj0JiQMoSnjZmVoq2qr7TA33JYHmzUw3YI7kF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753470227; c=relaxed/simple;
	bh=aB9liRnEWbRaScDDjLWWeM+YCj0fmMh/RTBXyLpRoik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pdcyTW3IDX3kgBOcYXI95Z+DCBX48UW/GK0rwUV7Bj/tpBNErexmd29niV99NITo9jfCyJtTeORGbZDApy4z0Flb/GSbDrs8h9VzhZFFyiboTTwF6g9Lootwc04/ufobDKbm5XT8JurntVsNZu0mDTAqi9zAJLheGZ6PkDaxaYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=jg8zYEHL; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753470187; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=O4IFeTTOiaFqK2VNmNfeSU5crlAy2NzPYDdtzx3GX4/oaJN8/8HlEsMfEWE0RlgzU90aViXzbe87FIyXoOOvyydIIUtCf5kTi0qYZI3rHB3yI1T9Ev3jjxiIkaRC17RjUZlSPmvZ1rkk7SMer2M1eG5qe9eFTIs1FS4F20qk9S4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753470187; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0gUl65a8tci3xttZczxCT9K4PQpIDEGmqHk6r8P++JM=; 
	b=IBGBaD8cMl7XyrKws0AbHtctNmTlNtzNIvXtAtVe4CGcU16iNITKiyddGEn75SUfEKt3fvVLScL7xunpcfQhPewnzCKJS9FUvqkQg25xY3U7bUJQYckKQI7rOMbm0E8sf/9k4eYEqr6bWt9FEj68MjQu4goFgnW9bK9MBxQVSU8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753470187;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=0gUl65a8tci3xttZczxCT9K4PQpIDEGmqHk6r8P++JM=;
	b=jg8zYEHLGb8ALcZ/DLz/ZMwogEENlaKG9A0/o3fCsXfRWMS+qG0FeziZ7ETa+3aB
	GVumitXAt70xu7xW+bqFTTYErCNvnskvf3Ev+m4ZYVwiOiaMhOXBmWeayxS7jaTSMuv
	HMvznPqHPzcK4lAomcyZ9zLvQyzH5nWHvVDwNlSA=
Received: by mx.zohomail.com with SMTPS id 1753470186171650.5564365863407;
	Fri, 25 Jul 2025 12:03:06 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Cc: kernel@collabora.com,
	stable@vger.kernel.org,
	Bard Liao <bard.liao@intel.com>,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] ASoC: SOF: amd: acp-loader: Use GFP_KERNEL for DMA allocations in resume context
Date: Sat, 26 Jul 2025 00:02:54 +0500
Message-Id: <20250725190254.1081184-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Replace GFP_ATOMIC with GFP_KERNEL for dma_alloc_coherent() calls. This
change improves memory allocation reliability during firmware loading,
particularly during system resume when memory pressure is high. Because
of using GFP_KERNEL, reclaim can happen which can reduce the probability
of failure.

Fixes memory allocation failures observed during system resume with
fragmented memory conditions.

	snd_sof_amd_vangogh 0000:04:00.5: error: failed to load DSP firmware after resume -12

Fixes: 145d7e5ae8f4e ("ASoC: SOF: amd: add option to use sram for data bin loading")
Fixes: 7e51a9e38ab20 ("ASoC: SOF: amd: Add fw loader and renoir dsp ops to load firmware")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 sound/soc/sof/amd/acp-loader.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/amd/acp-loader.c b/sound/soc/sof/amd/acp-loader.c
index 2d5e58846499..5b5d6db74c10 100644
--- a/sound/soc/sof/amd/acp-loader.c
+++ b/sound/soc/sof/amd/acp-loader.c
@@ -65,7 +65,7 @@ int acp_dsp_block_write(struct snd_sof_dev *sdev, enum snd_sof_fw_blk_type blk_t
 			dma_size = page_count * ACP_PAGE_SIZE;
 			adata->bin_buf = dma_alloc_coherent(&pci->dev, dma_size,
 							    &adata->sha_dma_addr,
-							    GFP_ATOMIC);
+							    GFP_KERNEL);
 			if (!adata->bin_buf)
 				return -ENOMEM;
 		}
@@ -77,7 +77,7 @@ int acp_dsp_block_write(struct snd_sof_dev *sdev, enum snd_sof_fw_blk_type blk_t
 			adata->data_buf = dma_alloc_coherent(&pci->dev,
 							     ACP_DEFAULT_DRAM_LENGTH,
 							     &adata->dma_addr,
-							     GFP_ATOMIC);
+							     GFP_KERNEL);
 			if (!adata->data_buf)
 				return -ENOMEM;
 		}
@@ -90,7 +90,7 @@ int acp_dsp_block_write(struct snd_sof_dev *sdev, enum snd_sof_fw_blk_type blk_t
 			adata->sram_data_buf = dma_alloc_coherent(&pci->dev,
 								  ACP_DEFAULT_SRAM_LENGTH,
 								  &adata->sram_dma_addr,
-								  GFP_ATOMIC);
+								  GFP_KERNEL);
 			if (!adata->sram_data_buf)
 				return -ENOMEM;
 		}
-- 
2.39.5


