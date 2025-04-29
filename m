Return-Path: <stable+bounces-137867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FD7AA1572
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C79B166D83
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAB4253F2A;
	Tue, 29 Apr 2025 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PsXztbLJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA48251790;
	Tue, 29 Apr 2025 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947371; cv=none; b=m4cEsxqxqhQp1VUSjZEvkYEef0AaCbawnvKVLUzQq/o/Dk2CUpAkmLF5xp8sp+RBlfIlsbApgNm/WGwJqEYJmXmBn0U3hoZZBIGN6dt7ata2Zn7iUeMgCZZJuHUDbmGckRvMZMNWDjBLhN7bPbJ0PRKD/8hEFmRu4ZODZsJ5RNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947371; c=relaxed/simple;
	bh=C9LD6vzDzBSTx7uPhqEBopsL7zCZMFkonfYdvKkGjrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j03Lk8NiXCQknQew+COJbCEHydoBf9Capj8S8T43VYYa8GiLAoEpz0bsWPkTGMBKrlFUFA18BCiiqDYSDe+PO/GZd0l6+v7qj4jfBU4YZSgyhCAtmAptTjFpzxdt2z/291mGdc4tD3RHx0yNAF3Qu4aGS2PnQTr+Bx6XwMelXmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PsXztbLJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3119FC4CEE3;
	Tue, 29 Apr 2025 17:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745947371;
	bh=C9LD6vzDzBSTx7uPhqEBopsL7zCZMFkonfYdvKkGjrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PsXztbLJtBVdeDFuMfnWs4p/GP72YSYzVddRY/uw0PBP/ckK8tTSacvRcymcWBG/r
	 4HfnQDYLV0RlgXbgY0nuQ+JGNLdBsnJ8DJXYXse8937wOeaGnfZYXKrNmDwYwSOpwB
	 ktUTTvLq0SkwrsrxNQWRQP7a1j5slFhtTv4Ao2Xc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Auld <matthew.auld@intel.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 229/286] drm/amdgpu/dma_buf: fix page_link check
Date: Tue, 29 Apr 2025 18:42:13 +0200
Message-ID: <20250429161117.356383957@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161107.848008295@linuxfoundation.org>
References: <20250429161107.848008295@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Auld <matthew.auld@intel.com>

[ Upstream commit c0dd8a9253fadfb8e5357217d085f1989da4ef0a ]

The page_link lower bits of the first sg could contain something like
SG_END, if we are mapping a single VRAM page or contiguous blob which
fits into one sg entry. Rather pull out the struct page, and use that in
our check to know if we mapped struct pages vs VRAM.

Fixes: f44ffd677fb3 ("drm/amdgpu: add support for exporting VRAM using DMA-buf v3")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.8+
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index bbbacc7b6c463..e4d0a9377e712 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -357,7 +357,7 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
 				 struct sg_table *sgt,
 				 enum dma_data_direction dir)
 {
-	if (sgt->sgl->page_link) {
+	if (sg_page(sgt->sgl)) {
 		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
 		sg_free_table(sgt);
 		kfree(sgt);
-- 
2.39.5




