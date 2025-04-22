Return-Path: <stable+bounces-135021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED6AA95E0B
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8B13B81EF
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 06:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AF31F4CA3;
	Tue, 22 Apr 2025 06:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1XnfY30P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C6F1EDA08
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 06:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745302948; cv=none; b=Ue+vxF+uXajUki78/OCvEmFY9HhRoEp8p6REqoLv28B/N3Oayj6CSa+DovKg05S1bATu9kCTHAQMWkWfHDeLOSYKI5oBndyGsHicA2KaQPfhDRFvVM+e8lqpz+VFTuKWyGvxcxxhFVqt+jBVexmvd7Uv/+i9Lt0ol3pE20//eIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745302948; c=relaxed/simple;
	bh=ae/9NbOPSCKF9edgtSutuB3uVpVsAIXkuUY9LiFn5rE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=J1rNQlX1QbVRvT7GEt9piq11t5nwGto2dcBTJjp54SMo+NDuOmTPsuDe1OLvSY5EvmkVGVsFBRE2UZLBzYgzoVDA83SEp4GWHtT9WUqOaYSAOJGsI3bQ2THEBpwSncbuweSfcqcfPEEKUwUTauPsxziEHMof2pn2d3FJfAzQVqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1XnfY30P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6CEC4CEE9;
	Tue, 22 Apr 2025 06:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745302948;
	bh=ae/9NbOPSCKF9edgtSutuB3uVpVsAIXkuUY9LiFn5rE=;
	h=Subject:To:Cc:From:Date:From;
	b=1XnfY30PK9IPtIDimHa9Db/lXz95NKikHUr7/ZUdsFdTBcXgDYhLO7NFIUXGzvobo
	 RUXqyp26juoaBliKz4M9VoTDrYSlZVPkIf7VbN1KMc82LxufmFq6dChrJq9GXBLg32
	 lGYcyApWp6lqmcU5r4JjAU9+g5lbR9ZPyRIaMLP4=
Subject: FAILED: patch "[PATCH] drm/amdgpu/dma_buf: fix page_link check" failed to apply to 5.10-stable tree
To: matthew.auld@intel.com,alexander.deucher@amd.com,christian.koenig@amd.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Apr 2025 08:21:54 +0200
Message-ID: <2025042254-rumor-scared-5f6e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c0dd8a9253fadfb8e5357217d085f1989da4ef0a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042254-rumor-scared-5f6e@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c0dd8a9253fadfb8e5357217d085f1989da4ef0a Mon Sep 17 00:00:00 2001
From: Matthew Auld <matthew.auld@intel.com>
Date: Mon, 7 Apr 2025 15:18:25 +0100
Subject: [PATCH] drm/amdgpu/dma_buf: fix page_link check
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 9f627caedc3f..c9842a0e2a1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -184,7 +184,7 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
 				 struct sg_table *sgt,
 				 enum dma_data_direction dir)
 {
-	if (sgt->sgl->page_link) {
+	if (sg_page(sgt->sgl)) {
 		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
 		sg_free_table(sgt);
 		kfree(sgt);


