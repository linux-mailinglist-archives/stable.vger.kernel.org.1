Return-Path: <stable+bounces-108571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C94A0FFD8
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 05:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA766166520
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 04:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965AD5336D;
	Tue, 14 Jan 2025 04:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FLn2lt7E"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C61735953;
	Tue, 14 Jan 2025 04:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736827379; cv=none; b=B/03mrB+cunxNlSSCaNByZdhzyUWwoFjX5YOXxIKFsBOXfgdJb1Gazsp4IW2HEi0c1p2oNKKLtuTCoee1ULEcrSdZP3pI0h8QjLpPjKtTUIQ3frzCl1oH55yajlPv/w5912lEGM7hXmbH/4uebNE/EIsMJ1b6C1jOoriQpocdF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736827379; c=relaxed/simple;
	bh=IT+CGMJUOqigyTEl7pGmnOBl5D0QTvQkf7ekyFaOg24=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sjyybe+RXwGxN/l1oXD61OnhHnUWPW/QjG10TVF8fxJCmPzLorlSafCgHlCKIeXiMy/fg3L9c0pRSg9Xz/0rT9r93QunFnlOhoKz98iX3LF5K5cQqjI+PjYNt9HWkBcjVX4/HVO6XAFhRaAlO08MZFwkwYiPw8XRtcTWNBnkOCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FLn2lt7E; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736827377; x=1768363377;
  h=date:message-id:from:to:cc:subject:in-reply-to:
   references:mime-version;
  bh=IT+CGMJUOqigyTEl7pGmnOBl5D0QTvQkf7ekyFaOg24=;
  b=FLn2lt7ErcjIbi5XDIYoCh/devoUrrqiezDh98BTkL3e63STBdPzvAjM
   O3Uw4ZW9tZY4wJxVq4nckgh8fC1K89RX/wyvUuNTPzM3UYwAYnUuCqodC
   tcSngq4ZWgki0/f8q96gRTTUHrXvhl1TWVAaf90hZDkzea/e/5aFIfgdQ
   sEeVQxBcvHnDqBya3PxI79nlOR6WroXJoqniHt7iw6vzaUjeWDmujidG7
   WMeanydLkqzAhBzp53/acsFUAsBU7h+JuokfhtawqFA9CYq35WxRxBk3T
   ptzJK7tfgOaw6DE59xRdSuxKhoQ75XYRYWwvKdGYMp63Id5oATHFn9N1A
   g==;
X-CSE-ConnectionGUID: Y+eP9IHqRGWcjYE9Xxf17g==
X-CSE-MsgGUID: JbfpEd+HRZO6IU8Eo138OA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37024702"
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="37024702"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 20:02:56 -0800
X-CSE-ConnectionGUID: UwHoT03BRfGcO4eV0N5NKQ==
X-CSE-MsgGUID: 3KDllL9bQHy2NPyYse/Gzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="104452112"
Received: from orsosgc001.jf.intel.com (HELO orsosgc001.intel.com) ([10.165.21.142])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 20:02:56 -0800
Date: Mon, 13 Jan 2025 20:02:55 -0800
Message-ID: <85v7uidouo.wl-ashutosh.dixit@intel.com>
From: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc: stable-commits@vger.kernel.org, Lucas De Marchi
 <lucas.demarchi@intel.com>, Thomas =?ISO-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sumit Semwal
 <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Umesh Nerlige Ramappa
 <umesh.nerlige.ramappa@intel.com>
Subject: Re: Patch "drm/xe/oa: Separate batch submission from waiting for completion" has been added to the 6.12-stable tree
In-Reply-To: <20250113140353.1739560-1-sashal@kernel.org>
References: <20250113140353.1739560-1-sashal@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?ISO-8859-4?Q?Goj=F2?=) APEL-LB/10.8 EasyPG/1.0.0
 Emacs/28.2 (x86_64-redhat-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII

On Mon, 13 Jan 2025 06:03:53 -0800, Sasha Levin wrote:
>

Hello Sasha,

> This is a note to let you know that I've just added the patch titled
>
>     drm/xe/oa: Separate batch submission from waiting for completion
>
> to the 6.12-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>      drm-xe-oa-separate-batch-submission-from-waiting-for.patch
> and it can be found in the queue-6.12 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

I am writing about 3 emails I received (including this one) about 3 commits
being added to stable. These are the 3 commits I am referring to (all
commit SHA's refer to Linus' tree and first commit is at the bottom,
everywhere in this email):

    2fb4350a283af drm/xe/oa: Add input fence dependencies
    c8507a25cebd1 drm/xe/oa/uapi: Define and parse OA sync properties
    dddcb19ad4d4b drm/xe/oa: Separate batch submission from waiting for completion

So none of these commits had any "Fixes:" tag or "Cc: stable" so not sure
why they are being added to stable. Also, they are part of a 7 commit
series so not sure why only 3 of the 7 commits are being added to stable?

In addition, for this commit which is also added to stable:

    f0ed39830e606 xe/oa: Fix query mode of operation for OAR/OAC

We modified this commit for stable because it will otherwise with the
previous 3 commits mentioned above, which we were assuming would not be in
stable.

Now, if we want all these commits in stable (I actually prefer it), we
should just pick them straight from Linus' tree. This would be all these
commits:

    f0ed39830e606 xe/oa: Fix query mode of operation for OAR/OAC
    c0403e4ceecae drm/xe/oa: Fix "Missing outer runtime PM protection" warning
    85d3f9e84e062 drm/xe/oa: Allow only certain property changes from config
    9920c8b88c5cf drm/xe/oa: Add syncs support to OA config ioctl
    cc4e6994d5a23 drm/xe/oa: Move functions up so they can be reused for config ioctl
    343dd246fd9b5 drm/xe/oa: Signal output fences
    2fb4350a283af drm/xe/oa: Add input fence dependencies
    c8507a25cebd1 drm/xe/oa/uapi: Define and parse OA sync properties
    dddcb19ad4d4b drm/xe/oa: Separate batch submission from waiting for completion

So: we should either drop the 3 patches at the top, or just pick all 9
patches above. Doing the latter will probably be the simplest and I don't
expect any conflicts, or if there are, I can help to resolve those.

The above list can be generated by running the following in Linus' tree:

    git log --oneline -- drivers/gpu/drm/xe/xe_oa.c

Thanks.
--
Ashutosh

>
>
>
> commit 9aeced687e728b9de067a502a0780f8029e61763
> Author: Ashutosh Dixit <ashutosh.dixit@intel.com>
> Date:   Tue Oct 22 13:03:46 2024 -0700
>
>     drm/xe/oa: Separate batch submission from waiting for completion
>
>     [ Upstream commit dddcb19ad4d4bbe943a72a1fb3266c6e8aa8d541 ]
>
>     When we introduce xe_syncs, we don't wait for internal OA programming
>     batches to complete. That is, xe_syncs are signaled asynchronously. In
>     anticipation for this, separate out batch submission from waiting for
>     completion of those batches.
>
>     v2: Change return type of xe_oa_submit_bb to "struct dma_fence *" (Matt B)
>     v3: Retain init "int err = 0;" in xe_oa_submit_bb (Jose)
>
>     Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
>     Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
>     Link: https://patchwork.freedesktop.org/patch/msgid/20241022200352.1192560-2-ashutosh.dixit@intel.com
>     Stable-dep-of: f0ed39830e60 ("xe/oa: Fix query mode of operation for OAR/OAC")
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
> index 78823f53d290..4962c9eb9a81 100644
> --- a/drivers/gpu/drm/xe/xe_oa.c
> +++ b/drivers/gpu/drm/xe/xe_oa.c
> @@ -567,11 +567,10 @@ static __poll_t xe_oa_poll(struct file *file, poll_table *wait)
>	return ret;
>  }
>
> -static int xe_oa_submit_bb(struct xe_oa_stream *stream, struct xe_bb *bb)
> +static struct dma_fence *xe_oa_submit_bb(struct xe_oa_stream *stream, struct xe_bb *bb)
>  {
>	struct xe_sched_job *job;
>	struct dma_fence *fence;
> -	long timeout;
>	int err = 0;
>
>	/* Kernel configuration is issued on stream->k_exec_q, not stream->exec_q */
> @@ -585,14 +584,9 @@ static int xe_oa_submit_bb(struct xe_oa_stream *stream, struct xe_bb *bb)
>	fence = dma_fence_get(&job->drm.s_fence->finished);
>	xe_sched_job_push(job);
>
> -	timeout = dma_fence_wait_timeout(fence, false, HZ);
> -	dma_fence_put(fence);
> -	if (timeout < 0)
> -		err = timeout;
> -	else if (!timeout)
> -		err = -ETIME;
> +	return fence;
>  exit:
> -	return err;
> +	return ERR_PTR(err);
>  }
>
>  static void write_cs_mi_lri(struct xe_bb *bb, const struct xe_oa_reg *reg_data, u32 n_regs)
> @@ -656,6 +650,7 @@ static void xe_oa_store_flex(struct xe_oa_stream *stream, struct xe_lrc *lrc,
>  static int xe_oa_modify_ctx_image(struct xe_oa_stream *stream, struct xe_lrc *lrc,
>				  const struct flex *flex, u32 count)
>  {
> +	struct dma_fence *fence;
>	struct xe_bb *bb;
>	int err;
>
> @@ -667,7 +662,16 @@ static int xe_oa_modify_ctx_image(struct xe_oa_stream *stream, struct xe_lrc *lr
>
>	xe_oa_store_flex(stream, lrc, bb, flex, count);
>
> -	err = xe_oa_submit_bb(stream, bb);
> +	fence = xe_oa_submit_bb(stream, bb);
> +	if (IS_ERR(fence)) {
> +		err = PTR_ERR(fence);
> +		goto free_bb;
> +	}
> +	xe_bb_free(bb, fence);
> +	dma_fence_put(fence);
> +
> +	return 0;
> +free_bb:
>	xe_bb_free(bb, NULL);
>  exit:
>	return err;
> @@ -675,6 +679,7 @@ static int xe_oa_modify_ctx_image(struct xe_oa_stream *stream, struct xe_lrc *lr
>
>  static int xe_oa_load_with_lri(struct xe_oa_stream *stream, struct xe_oa_reg *reg_lri)
>  {
> +	struct dma_fence *fence;
>	struct xe_bb *bb;
>	int err;
>
> @@ -686,7 +691,16 @@ static int xe_oa_load_with_lri(struct xe_oa_stream *stream, struct xe_oa_reg *re
>
>	write_cs_mi_lri(bb, reg_lri, 1);
>
> -	err = xe_oa_submit_bb(stream, bb);
> +	fence = xe_oa_submit_bb(stream, bb);
> +	if (IS_ERR(fence)) {
> +		err = PTR_ERR(fence);
> +		goto free_bb;
> +	}
> +	xe_bb_free(bb, fence);
> +	dma_fence_put(fence);
> +
> +	return 0;
> +free_bb:
>	xe_bb_free(bb, NULL);
>  exit:
>	return err;
> @@ -914,15 +928,32 @@ static int xe_oa_emit_oa_config(struct xe_oa_stream *stream, struct xe_oa_config
>  {
>  #define NOA_PROGRAM_ADDITIONAL_DELAY_US 500
>	struct xe_oa_config_bo *oa_bo;
> -	int err, us = NOA_PROGRAM_ADDITIONAL_DELAY_US;
> +	int err = 0, us = NOA_PROGRAM_ADDITIONAL_DELAY_US;
> +	struct dma_fence *fence;
> +	long timeout;
>
> +	/* Emit OA configuration batch */
>	oa_bo = xe_oa_alloc_config_buffer(stream, config);
>	if (IS_ERR(oa_bo)) {
>		err = PTR_ERR(oa_bo);
>		goto exit;
>	}
>
> -	err = xe_oa_submit_bb(stream, oa_bo->bb);
> +	fence = xe_oa_submit_bb(stream, oa_bo->bb);
> +	if (IS_ERR(fence)) {
> +		err = PTR_ERR(fence);
> +		goto exit;
> +	}
> +
> +	/* Wait till all previous batches have executed */
> +	timeout = dma_fence_wait_timeout(fence, false, 5 * HZ);
> +	dma_fence_put(fence);
> +	if (timeout < 0)
> +		err = timeout;
> +	else if (!timeout)
> +		err = -ETIME;
> +	if (err)
> +		drm_dbg(&stream->oa->xe->drm, "dma_fence_wait_timeout err %d\n", err);
>
>	/* Additional empirical delay needed for NOA programming after registers are written */
>	usleep_range(us, 2 * us);

