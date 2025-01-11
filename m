Return-Path: <stable+bounces-108295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1585A0A589
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 20:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6413A9762
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 19:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A76F1B5336;
	Sat, 11 Jan 2025 19:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7aDj+PG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565A222083
	for <stable@vger.kernel.org>; Sat, 11 Jan 2025 19:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736622296; cv=none; b=AsGQT1Jxp9CBMPu2VNzX5qlk3uqAPQ9a++dmjlxqslcxtgUV8RmmF+zA+kUv4X2PPn6VgQd5ejY5FEBte+WsQ1rM9sS/KHaxu6Z6tDHKIWoOmjS2F5HducJH1VsOiZDJHA43Q3hpVtYAJOMmQfAK+T4EGCglosiLkJanc5b92iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736622296; c=relaxed/simple;
	bh=4u13E3PrLJHLPtDG8VYKngXL52uafdENxmZ5tRtJrYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u5yNpEHRmWmqp3BNIqG+CshBCmCkeeKFBZqzLj8cYhZEyEZFAVQYJYATgjTJb2A3QF5+287AphF/KmaBShWSpAxHGY73vBz3+ooET8MmRDNTwvowAi/L3zP2cZkcJW/YG6U5SSBLJVojhH/4mNAaUzPoQSomsa16Le9wyCSKy90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7aDj+PG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64115C4CED2;
	Sat, 11 Jan 2025 19:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736622295;
	bh=4u13E3PrLJHLPtDG8VYKngXL52uafdENxmZ5tRtJrYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T7aDj+PGRSAgXPieWsX8DfV1rp7IPJeC01UGF+ibgHYXzDsrloXAQWAu2JLVcgnxe
	 j27YMHkxaZcFAr7zXpccBijBVo7LYO1kkEFMTECJP5+hjXi/9+T1E20VCEi4m7ZJ1l
	 iPdWDVOs4v/nUzo2pcKEGW4OgHIty15AAL/ocMIli6dXaS8ID9sMhUjejE4LSIF+qV
	 NhGXSiHqzYZHx2Tei9zZ+PyqFYdmVk7RRd+7Lg1dJUsofYDuh61jIeHyiOfvZ717Im
	 be2ck7uPK5iu3DK7/dsnjqH5sllV4EXlpl+fp874O+1q+6J4yIIdkEqDZoXTSxUaHm
	 zLbivFtKuuPSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] xe/oa: Fix query mode of operation for OAR/OAC
Date: Sat, 11 Jan 2025 14:04:54 -0500
Message-Id: <20250110164811-61a12d6905bb8676@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250110205341.199539-1-umesh.nerlige.ramappa@intel.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The claimed upstream commit SHA1 (55039832f98c7e05f1cf9e0d8c12b2490abd0f16) was not found.
However, I found a matching commit: f0ed39830e6064d62f9c5393505677a26569bb56


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f0ed39830e60 ! 1:  14a6fe72119e xe/oa: Fix query mode of operation for OAR/OAC
    @@ Metadata
      ## Commit message ##
         xe/oa: Fix query mode of operation for OAR/OAC
     
    +    commit 55039832f98c7e05f1cf9e0d8c12b2490abd0f16 upstream
    +
         This is a set of squashed commits to facilitate smooth applying to
         stable. Each commit message is retained for reference.
     
    @@ Commit message
         - Drop reg_lri related comments
         - Use XE_OA_SUBMIT_NO_DEPS in xe_oa_load_with_lri
     
    +    v6:
    +    Backport to linux-6.12.y (Umesh)
    +
         Fixes: 8135f1c09dd2 ("drm/xe/oa: Don't reset OAC_CONTEXT_ENABLE on OA stream close")
         Signed-off-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
         Reviewed-by: Matthew Brost <matthew.brost@intel.com> # commit 1
         Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
    -    Cc: stable@vger.kernel.org
    +    Cc: stable@vger.kernel.org # 6.12+
         Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
         Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
         Link: https://patchwork.freedesktop.org/patch/msgid/20241220171919.571528-2-umesh.nerlige.ramappa@intel.com
         (cherry picked from commit 55039832f98c7e05f1cf9e0d8c12b2490abd0f16)
         Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
    +    (cherry picked from commit f0ed39830e6064d62f9c5393505677a26569bb56)
     
      ## drivers/gpu/drm/xe/xe_oa.c ##
     @@ drivers/gpu/drm/xe/xe_oa.c: struct xe_oa_config {
    @@ drivers/gpu/drm/xe/xe_oa.c: struct xe_oa_config {
     -};
     -
      struct xe_oa_open_param {
    - 	struct xe_file *xef;
      	u32 oa_unit_id;
    + 	bool sample;
     @@ drivers/gpu/drm/xe/xe_oa.c: static __poll_t xe_oa_poll(struct file *file, poll_table *wait)
      	return ret;
      }
    @@ drivers/gpu/drm/xe/xe_oa.c: static __poll_t xe_oa_poll(struct file *file, poll_t
     +	}
     +}
     +
    - static struct dma_fence *xe_oa_submit_bb(struct xe_oa_stream *stream, enum xe_oa_submit_deps deps,
    - 					 struct xe_bb *bb)
    + static int xe_oa_submit_bb(struct xe_oa_stream *stream, struct xe_bb *bb)
      {
     +	struct xe_exec_queue *q = stream->exec_q ?: stream->k_exec_q;
      	struct xe_sched_job *job;
      	struct dma_fence *fence;
    + 	long timeout;
      	int err = 0;
      
     -	/* Kernel configuration is issued on stream->k_exec_q, not stream->exec_q */
    @@ drivers/gpu/drm/xe/xe_oa.c: static __poll_t xe_oa_poll(struct file *file, poll_t
     +	job = xe_bb_create_job(q, bb);
      	if (IS_ERR(job)) {
      		err = PTR_ERR(job);
    ++		xe_oa_unlock_vma(q);
      		goto exit;
      	}
     +	job->ggtt = true;
      
    - 	if (deps == XE_OA_SUBMIT_ADD_DEPS) {
    - 		for (int i = 0; i < stream->num_syncs && !err; i++)
    -@@ drivers/gpu/drm/xe/xe_oa.c: static struct dma_fence *xe_oa_submit_bb(struct xe_oa_stream *stream, enum xe_oa
    + 	xe_sched_job_arm(job);
      	fence = dma_fence_get(&job->drm.s_fence->finished);
      	xe_sched_job_push(job);
      
     +	xe_oa_unlock_vma(q);
     +
    - 	return fence;
    - err_put_job:
    - 	xe_sched_job_put(job);
    - exit:
    -+	xe_oa_unlock_vma(q);
    - 	return ERR_PTR(err);
    - }
    - 
    + 	timeout = dma_fence_wait_timeout(fence, false, HZ);
    + 	dma_fence_put(fence);
    + 	if (timeout < 0)
     @@ drivers/gpu/drm/xe/xe_oa.c: static void xe_oa_free_configs(struct xe_oa_stream *stream)
    - 	dma_fence_put(stream->last_fence);
    + 		free_oa_config_bo(oa_bo);
      }
      
     -static void xe_oa_store_flex(struct xe_oa_stream *stream, struct xe_lrc *lrc,
    @@ drivers/gpu/drm/xe/xe_oa.c: static void xe_oa_free_configs(struct xe_oa_stream *
     -static int xe_oa_modify_ctx_image(struct xe_oa_stream *stream, struct xe_lrc *lrc,
     -				  const struct flex *flex, u32 count)
     -{
    --	struct dma_fence *fence;
     -	struct xe_bb *bb;
     -	int err;
     -
    @@ drivers/gpu/drm/xe/xe_oa.c: static void xe_oa_free_configs(struct xe_oa_stream *
     -
     -	xe_oa_store_flex(stream, lrc, bb, flex, count);
     -
    --	fence = xe_oa_submit_bb(stream, XE_OA_SUBMIT_NO_DEPS, bb);
    --	if (IS_ERR(fence)) {
    --		err = PTR_ERR(fence);
    --		goto free_bb;
    --	}
    --	xe_bb_free(bb, fence);
    --	dma_fence_put(fence);
    --
    --	return 0;
    --free_bb:
    +-	err = xe_oa_submit_bb(stream, bb);
     -	xe_bb_free(bb, NULL);
     -exit:
     -	return err;
    @@ drivers/gpu/drm/xe/xe_oa.c: static void xe_oa_free_configs(struct xe_oa_stream *
     -static int xe_oa_load_with_lri(struct xe_oa_stream *stream, struct xe_oa_reg *reg_lri)
     +static int xe_oa_load_with_lri(struct xe_oa_stream *stream, struct xe_oa_reg *reg_lri, u32 count)
      {
    - 	struct dma_fence *fence;
      	struct xe_bb *bb;
      	int err;
      
    @@ drivers/gpu/drm/xe/xe_oa.c: static void xe_oa_free_configs(struct xe_oa_stream *
     -	write_cs_mi_lri(bb, reg_lri, 1);
     +	write_cs_mi_lri(bb, reg_lri, count);
      
    - 	fence = xe_oa_submit_bb(stream, XE_OA_SUBMIT_NO_DEPS, bb);
    - 	if (IS_ERR(fence)) {
    + 	err = xe_oa_submit_bb(stream, bb);
    + 	xe_bb_free(bb, NULL);
     @@ drivers/gpu/drm/xe/xe_oa.c: static int xe_oa_load_with_lri(struct xe_oa_stream *stream, struct xe_oa_reg *re
      static int xe_oa_configure_oar_context(struct xe_oa_stream *stream, bool enable)
      {
    @@ drivers/gpu/drm/xe/xe_oa.c: static int xe_oa_load_with_lri(struct xe_oa_stream *
     -	int err;
      
      	/* Set ccs select to enable programming of OAC_OACONTROL */
    - 	xe_mmio_write32(&stream->gt->mmio, __oa_regs(stream)->oa_ctrl,
    - 			__oa_ccs_select(stream));
    + 	xe_mmio_write32(stream->gt, __oa_regs(stream)->oa_ctrl, __oa_ccs_select(stream));
      
     -	/* Modify stream hwe context image with regs_context */
     -	err = xe_oa_modify_ctx_image(stream, stream->exec_q->lrc[0],
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

