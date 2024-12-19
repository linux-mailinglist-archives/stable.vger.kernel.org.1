Return-Path: <stable+bounces-105314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8169F9F7F30
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 17:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 783F91892296
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 16:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7C9227B8B;
	Thu, 19 Dec 2024 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3MQm17k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079B7227B87;
	Thu, 19 Dec 2024 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734624928; cv=none; b=cwbfC+VFdAJDTgpU52nkd9Rt+F6zZnSKyXrYnNuu/SJOJ4MP8jcgiVGR9Japhoz6ItUuaznEU7fQIABaCYdbB38WJD0AiZF7ePQAQITMCKXiW5/9du6UYFUyIyuTjyPdQkqyl+MARlYrghKnTVaODLbZbRPwoZXtaH3o20q6RQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734624928; c=relaxed/simple;
	bh=o+xdoDzhAyW5Kcho4dZEyqpLXH34N9lPGzm1TKuiaC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVSLZaRzItwzf/H1y4oUvfRB+C7N1iMerlEI7+3tJvdlaiDHmbpezMw/uloPIBvzOwMVxtDGjEXLCZk4rzyTdGeXdJz8PZH0Z+QSwDG3CYqrr/9uZLX+G/xAOvXmrL765Ris30itJl7tylgDkSWMEzNLQUHaLnFTrpCvmqpamvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3MQm17k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBC5C4CECE;
	Thu, 19 Dec 2024 16:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734624927;
	bh=o+xdoDzhAyW5Kcho4dZEyqpLXH34N9lPGzm1TKuiaC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j3MQm17kEMix4Lu1GVlZUUMFVLTUwqQcryIcm/qtFm2NNM8U/4vjVW03G+K+mEc9e
	 NJ/EiQFkP0vHzEvUmdIaatL7C3LG+qtBcOpUJKHo+RB2lQ7u9jYjbZC+wT9bS5/N/L
	 sI41ETeoLeRw+LFIuNc/aaaZkkBki9QgIYBHIC57pI0Ac8t3iSkTxaW63CQXfo4T6S
	 poHClpo1e1tjtFTRzNq8l23DHgQEH7+8kXiqbhaT5HLM//BkOloifH5J0G7l59gw0u
	 IdCLgAKdThueSRZKE3Ela/25Y124mYNGTboIcgkzE7yatR6bGQR8++aqeB7kOLopBg
	 54Zf4Qfs1ofFw==
Date: Thu, 19 Dec 2024 06:15:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Tvrtko Ursulin <tursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	kernel-dev@igalia.com, linux-kernel@vger.kernel.org,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] workqueue: Do not warn when cancelling WQ_MEM_RECLAIM
 work from !WQ_MEM_RECLAIM worker
Message-ID: <Z2RGnlAUB4vsXYCi@slm.duckdns.org>
References: <20241219093030.52080-1-tursulin@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241219093030.52080-1-tursulin@igalia.com>

On Thu, Dec 19, 2024 at 09:30:30AM +0000, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> 
> After commit
> 746ae46c1113 ("drm/sched: Mark scheduler work queues with WQ_MEM_RECLAIM")
> amdgpu started seeing the following warning:
> 
>  [ ] workqueue: WQ_MEM_RECLAIM sdma0:drm_sched_run_job_work [gpu_sched] is flushing !WQ_MEM_RECLAIM events:amdgpu_device_delay_enable_gfx_off [amdgpu]
> ...
>  [ ] Workqueue: sdma0 drm_sched_run_job_work [gpu_sched]
> ...
>  [ ] Call Trace:
>  [ ]  <TASK>
> ...
>  [ ]  ? check_flush_dependency+0xf5/0x110
> ...
>  [ ]  cancel_delayed_work_sync+0x6e/0x80
>  [ ]  amdgpu_gfx_off_ctrl+0xab/0x140 [amdgpu]
>  [ ]  amdgpu_ring_alloc+0x40/0x50 [amdgpu]
>  [ ]  amdgpu_ib_schedule+0xf4/0x810 [amdgpu]
>  [ ]  ? drm_sched_run_job_work+0x22c/0x430 [gpu_sched]
>  [ ]  amdgpu_job_run+0xaa/0x1f0 [amdgpu]
>  [ ]  drm_sched_run_job_work+0x257/0x430 [gpu_sched]
>  [ ]  process_one_work+0x217/0x720
> ...
>  [ ]  </TASK>
> 
> The intent of the verifcation done in check_flush_depedency is to ensure
> forward progress during memory reclaim, by flagging cases when either a
> memory reclaim process, or a memory reclaim work item is flushed from a
> context not marked as memory reclaim safe.
> 
> This is correct when flushing, but when called from the
> cancel(_delayed)_work_sync() paths it is a false positive because work is
> either already running, or will not be running at all. Therefore
> cancelling it is safe and we can relax the warning criteria by letting the
> helper know of the calling context.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Fixes: fca839c00a12 ("workqueue: warn if memory reclaim tries to flush !WQ_MEM_RECLAIM workqueue")
> References: 746ae46c1113 ("drm/sched: Mark scheduler work queues with WQ_MEM_RECLAIM")
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: <stable@vger.kernel.org> # v4.5+

Applied to wq/for-6.13-fixes.

Thanks.

-- 
tejun

