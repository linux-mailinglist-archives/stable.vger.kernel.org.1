Return-Path: <stable+bounces-73810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D5E96FB5F
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 20:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F2528A9D4
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 18:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EB313D248;
	Fri,  6 Sep 2024 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ariadne.space header.i=@ariadne.space header.b="no0ngRzz"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-zteg10021401.me.com (pv50p00im-zteg10021401.me.com [17.58.6.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5C313B7A1
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725648153; cv=none; b=lxOZG7tVOCaNmM0f52PpZxHz3LoeLo1roWG9LJ5FtO/YIA69qz7J8Bi0Uzh5K+Q21IB2aLvRlcZVNXiklf2D0+bNisuJlBC7fpGcG74DS3qWBROpMxBlgXCOmBaYJU9nVVbxOpp41Ekke4gJPuHcEgfm18zKl5YVfJzbiZ3vCXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725648153; c=relaxed/simple;
	bh=E9qSLt0GrVBYfjxOpUedKjTmq7bndQXS3lQvPEArxjU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rLt5tBy3/5USInQG4AlWcNgyejnmp+VFegfekrF9GGy7H/ZOYFP7p50awijFGygHLsmUIVT61EouEOn7wZ3kDBQ+d+f0b8okivOJwE+pwkagpWq1wmmdGJSyS4cNsvcm1XBV52K5FUyTuW38sNjuSoj7dTS+dct3NKcBVjj3+8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ariadne.space; spf=pass smtp.mailfrom=ariadne.space; dkim=pass (2048-bit key) header.d=ariadne.space header.i=@ariadne.space header.b=no0ngRzz; arc=none smtp.client-ip=17.58.6.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ariadne.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ariadne.space
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ariadne.space;
	s=sig1; t=1725648150;
	bh=M0Q9XOB/kMF0+B3U+RveaDZ0cH/WiG/ZmzrA54s0hxc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=no0ngRzzC7FEjI9UXUSQpIWlC1yaJS5visGBOvAG0FbYV5JYtUDSBkK0Ngg23ayPv
	 PLCSRy/P9fBRUssIWTNN4achy78m1NBwFimPEjTwKNHuVOzkp/wKjB2UQ+XXIBnEDn
	 O/Vz2DD0aaHvrm+94h6TnZ0hX/i30W5g1cKGeJqSfnwihJMfsPTxkgEp8lWoooPrQU
	 V8UZuyxFkozTVlHlNcQKW6XWqfZGABG9GagtjLvZEMNnLaIJg46D48FRBf71D/zbT2
	 W9gMBfQIum1bIPt4lkVhBMx8JTG111wYkb6qukzyzWXuQEsnGgUpBzpLhnL5sVrHUh
	 erCpwRQXipSDw==
Received: from penelo.taild41b8.ts.net (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id 861EE8E07B7;
	Fri,  6 Sep 2024 18:42:27 +0000 (UTC)
From: Ariadne Conill <ariadne@ariadne.space>
To: xen-devel@lists.xenproject.org,
	alsa-devel@alsa-project.org
Cc: Ariadne Conill <ariadne@ariadne.space>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] Revert "ALSA: memalloc: Workaround for Xen PV"
Date: Fri,  6 Sep 2024 11:42:09 -0700
Message-Id: <20240906184209.25423-1-ariadne@ariadne.space>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lk0ouPNqe5kE8xXEoigDnu-oJgDNJMcY
X-Proofpoint-GUID: lk0ouPNqe5kE8xXEoigDnu-oJgDNJMcY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_04,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1030 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409060138

This patch attempted to work around a DMA issue involving Xen, but
causes subtle kernel memory corruption.

When I brought up this patch in the XenDevel matrix channel, I was
told that it had been requested by the Qubes OS developers because
they were trying to fix an issue where the sound stack would fail
after a few hours of uptime.  They wound up disabling SG buffering
entirely instead as a workaround.

Accordingly, I propose that we should revert this workaround patch,
since it causes kernel memory corruption and that the ALSA and Xen
communities should collaborate on fixing the underlying problem in
such a way that SG buffering works correctly under Xen.

This reverts commit 53466ebdec614f915c691809b0861acecb941e30.

Signed-off-by: Ariadne Conill <ariadne@ariadne.space>
Cc: stable@vger.kernel.org
Cc: xen-devel@lists.xenproject.org
Cc: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
---
 sound/core/memalloc.c | 87 +++++++++----------------------------------
 1 file changed, 18 insertions(+), 69 deletions(-)

diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index f901504b5afc..81025f50a542 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -541,15 +541,16 @@ static void *snd_dma_noncontig_alloc(struct snd_dma_buffer *dmab, size_t size)
 	struct sg_table *sgt;
 	void *p;
 
-#ifdef CONFIG_SND_DMA_SGBUF
-	if (cpu_feature_enabled(X86_FEATURE_XENPV))
-		return snd_dma_sg_fallback_alloc(dmab, size);
-#endif
 	sgt = dma_alloc_noncontiguous(dmab->dev.dev, size, dmab->dev.dir,
 				      DEFAULT_GFP, 0);
 #ifdef CONFIG_SND_DMA_SGBUF
-	if (!sgt && !get_dma_ops(dmab->dev.dev))
+	if (!sgt && !get_dma_ops(dmab->dev.dev)) {
+		if (dmab->dev.type == SNDRV_DMA_TYPE_DEV_WC_SG)
+			dmab->dev.type = SNDRV_DMA_TYPE_DEV_WC_SG_FALLBACK;
+		else
+			dmab->dev.type = SNDRV_DMA_TYPE_DEV_SG_FALLBACK;
 		return snd_dma_sg_fallback_alloc(dmab, size);
+	}
 #endif
 	if (!sgt)
 		return NULL;
@@ -716,38 +717,19 @@ static const struct snd_malloc_ops snd_dma_sg_wc_ops = {
 
 /* Fallback SG-buffer allocations for x86 */
 struct snd_dma_sg_fallback {
-	bool use_dma_alloc_coherent;
 	size_t count;
 	struct page **pages;
-	/* DMA address array; the first page contains #pages in ~PAGE_MASK */
-	dma_addr_t *addrs;
 };
 
 static void __snd_dma_sg_fallback_free(struct snd_dma_buffer *dmab,
 				       struct snd_dma_sg_fallback *sgbuf)
 {
-	size_t i, size;
-
-	if (sgbuf->pages && sgbuf->addrs) {
-		i = 0;
-		while (i < sgbuf->count) {
-			if (!sgbuf->pages[i] || !sgbuf->addrs[i])
-				break;
-			size = sgbuf->addrs[i] & ~PAGE_MASK;
-			if (WARN_ON(!size))
-				break;
-			if (sgbuf->use_dma_alloc_coherent)
-				dma_free_coherent(dmab->dev.dev, size << PAGE_SHIFT,
-						  page_address(sgbuf->pages[i]),
-						  sgbuf->addrs[i] & PAGE_MASK);
-			else
-				do_free_pages(page_address(sgbuf->pages[i]),
-					      size << PAGE_SHIFT, false);
-			i += size;
-		}
-	}
+	bool wc = dmab->dev.type == SNDRV_DMA_TYPE_DEV_WC_SG_FALLBACK;
+	size_t i;
+
+	for (i = 0; i < sgbuf->count && sgbuf->pages[i]; i++)
+		do_free_pages(page_address(sgbuf->pages[i]), PAGE_SIZE, wc);
 	kvfree(sgbuf->pages);
-	kvfree(sgbuf->addrs);
 	kfree(sgbuf);
 }
 
@@ -756,36 +738,24 @@ static void *snd_dma_sg_fallback_alloc(struct snd_dma_buffer *dmab, size_t size)
 	struct snd_dma_sg_fallback *sgbuf;
 	struct page **pagep, *curp;
 	size_t chunk, npages;
-	dma_addr_t *addrp;
 	dma_addr_t addr;
 	void *p;
-
-	/* correct the type */
-	if (dmab->dev.type == SNDRV_DMA_TYPE_DEV_SG)
-		dmab->dev.type = SNDRV_DMA_TYPE_DEV_SG_FALLBACK;
-	else if (dmab->dev.type == SNDRV_DMA_TYPE_DEV_WC_SG)
-		dmab->dev.type = SNDRV_DMA_TYPE_DEV_WC_SG_FALLBACK;
+	bool wc = dmab->dev.type == SNDRV_DMA_TYPE_DEV_WC_SG_FALLBACK;
 
 	sgbuf = kzalloc(sizeof(*sgbuf), GFP_KERNEL);
 	if (!sgbuf)
 		return NULL;
-	sgbuf->use_dma_alloc_coherent = cpu_feature_enabled(X86_FEATURE_XENPV);
 	size = PAGE_ALIGN(size);
 	sgbuf->count = size >> PAGE_SHIFT;
 	sgbuf->pages = kvcalloc(sgbuf->count, sizeof(*sgbuf->pages), GFP_KERNEL);
-	sgbuf->addrs = kvcalloc(sgbuf->count, sizeof(*sgbuf->addrs), GFP_KERNEL);
-	if (!sgbuf->pages || !sgbuf->addrs)
+	if (!sgbuf->pages)
 		goto error;
 
 	pagep = sgbuf->pages;
-	addrp = sgbuf->addrs;
-	chunk = (PAGE_SIZE - 1) << PAGE_SHIFT; /* to fit in low bits in addrs */
+	chunk = size;
 	while (size > 0) {
 		chunk = min(size, chunk);
-		if (sgbuf->use_dma_alloc_coherent)
-			p = dma_alloc_coherent(dmab->dev.dev, chunk, &addr, DEFAULT_GFP);
-		else
-			p = do_alloc_pages(dmab->dev.dev, chunk, &addr, false);
+		p = do_alloc_pages(dmab->dev.dev, chunk, &addr, wc);
 		if (!p) {
 			if (chunk <= PAGE_SIZE)
 				goto error;
@@ -797,25 +767,17 @@ static void *snd_dma_sg_fallback_alloc(struct snd_dma_buffer *dmab, size_t size)
 		size -= chunk;
 		/* fill pages */
 		npages = chunk >> PAGE_SHIFT;
-		*addrp = npages; /* store in lower bits */
 		curp = virt_to_page(p);
-		while (npages--) {
+		while (npages--)
 			*pagep++ = curp++;
-			*addrp++ |= addr;
-			addr += PAGE_SIZE;
-		}
 	}
 
 	p = vmap(sgbuf->pages, sgbuf->count, VM_MAP, PAGE_KERNEL);
 	if (!p)
 		goto error;
-
-	if (dmab->dev.type == SNDRV_DMA_TYPE_DEV_WC_SG_FALLBACK)
-		set_pages_array_wc(sgbuf->pages, sgbuf->count);
-
 	dmab->private_data = sgbuf;
 	/* store the first page address for convenience */
-	dmab->addr = sgbuf->addrs[0] & PAGE_MASK;
+	dmab->addr = snd_sgbuf_get_addr(dmab, 0);
 	return p;
 
  error:
@@ -825,23 +787,10 @@ static void *snd_dma_sg_fallback_alloc(struct snd_dma_buffer *dmab, size_t size)
 
 static void snd_dma_sg_fallback_free(struct snd_dma_buffer *dmab)
 {
-	struct snd_dma_sg_fallback *sgbuf = dmab->private_data;
-
-	if (dmab->dev.type == SNDRV_DMA_TYPE_DEV_WC_SG_FALLBACK)
-		set_pages_array_wb(sgbuf->pages, sgbuf->count);
 	vunmap(dmab->area);
 	__snd_dma_sg_fallback_free(dmab, dmab->private_data);
 }
 
-static dma_addr_t snd_dma_sg_fallback_get_addr(struct snd_dma_buffer *dmab,
-					       size_t offset)
-{
-	struct snd_dma_sg_fallback *sgbuf = dmab->private_data;
-	size_t index = offset >> PAGE_SHIFT;
-
-	return (sgbuf->addrs[index] & PAGE_MASK) | (offset & ~PAGE_MASK);
-}
-
 static int snd_dma_sg_fallback_mmap(struct snd_dma_buffer *dmab,
 				    struct vm_area_struct *area)
 {
@@ -856,8 +805,8 @@ static const struct snd_malloc_ops snd_dma_sg_fallback_ops = {
 	.alloc = snd_dma_sg_fallback_alloc,
 	.free = snd_dma_sg_fallback_free,
 	.mmap = snd_dma_sg_fallback_mmap,
-	.get_addr = snd_dma_sg_fallback_get_addr,
 	/* reuse vmalloc helpers */
+	.get_addr = snd_dma_vmalloc_get_addr,
 	.get_page = snd_dma_vmalloc_get_page,
 	.get_chunk_size = snd_dma_vmalloc_get_chunk_size,
 };
-- 
2.39.2


