Return-Path: <stable+bounces-139343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E3CAA631C
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 20:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4521BC3895
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 18:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B099D2153FB;
	Thu,  1 May 2025 18:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/faZiYB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6001C1F22
	for <stable@vger.kernel.org>; Thu,  1 May 2025 18:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746125449; cv=none; b=sOQgEDk9A/WwXa108PajxFizWwRMAfsG1UaRmRvBAAm05jmDayfH8sbkheGusA5HD4O6tDcJ6bXX4ELxz6ThM/4RmSvD207lmEJfcX8Cp2NcEel68eNIMlkZzz2mhFVX3h8UEQF5gyTqkGgJllf+wkVgnayhJxCUzXgcbhOSOb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746125449; c=relaxed/simple;
	bh=jJkzSeHW5Us6yTYCx7prZ++jcwPFAH7f2w3efuH0w9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q5zJiH9Yy0SvGvMOtQgC3WdPugb26Zz+HEdBYBjIiAJei5VoyfAXzouQ6+BmdkBniHe/PFqF8fa79ov018jCPLMyWAsHIQIOQ1XJOtGGQu/e8v3a6UM4DAJF+sPHFJBrNk49ra6ZCLrJasMvVpYM3hqAHEjJrfGfnsp2altIziI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/faZiYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9782C4CEE3;
	Thu,  1 May 2025 18:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746125449;
	bh=jJkzSeHW5Us6yTYCx7prZ++jcwPFAH7f2w3efuH0w9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U/faZiYBfJNh5/WQ8YJJTeIq6L965/xFmW7cXLoyWxbZvYfoqDWKM8h/BggenUovW
	 qEGPFrhkzhiX7UDFos01DHVL/+U1SsMqa5CEttOS6xqSLWWCUAv0YrvlX2rzAhxqH8
	 D5Q4J8Rzwh/fX1Lp3iL4bu1dFgTOAbpinKRxtKy2tXcumfBEE6+neAOGs+xCea5VT7
	 98dCf/B5CTm8ppgU575fdh2jkImHh29+2hQwn0msNXcYTDhIYD5V9s+5uotlQNS7xM
	 tkXKUScxXpBPa8Zb1nvqQa5pAtdsVGULNVCMt/JHldFS8aagyuP/dcjQqudBztIZye
	 MltbIYAAMULWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 3/3] accel/ivpu: Add handling of VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW
Date: Thu,  1 May 2025 14:50:45 -0400
Message-Id: <20250501082936-e734b2a44cc50c49@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430123653.3748811-4-jacek.lawrynowicz@linux.intel.com>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: dad945c27a42dfadddff1049cf5ae417209a8996

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jacek Lawrynowicz<jacek.lawrynowicz@linux.intel.com>
Commit author: Karol Wachowski<karol.wachowski@intel.com>

Note: The patch differs from the upstream commit:
---
1:  dad945c27a42d ! 1:  2c62f69a5a389 accel/ivpu: Add handling of VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW
    @@ Metadata
      ## Commit message ##
         accel/ivpu: Add handling of VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW
     
    +    commit dad945c27a42dfadddff1049cf5ae417209a8996 upstream.
    +
         Mark as invalid context of a job that returned HW context violation
         error and queue work that aborts jobs from faulty context.
         Add engine reset to the context abort thread handler to not only abort
         currently executing jobs but also to ensure NPU invalid state recovery.
     
    +    Cc: <stable@vger.kernel.org> # v6.14
         Signed-off-by: Karol Wachowski <karol.wachowski@intel.com>
         Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
         Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
    @@ drivers/accel/ivpu/ivpu_job.c: static int ivpu_job_signal_and_destroy(struct ivp
      	job = ivpu_job_remove_from_submitted_jobs(vdev, job_id);
      	if (!job)
      		return -ENOENT;
    -@@ drivers/accel/ivpu/ivpu_job.c: void ivpu_context_abort_work_fn(struct work_struct *work)
    - 	unsigned long ctx_id;
    +@@ drivers/accel/ivpu/ivpu_job.c: void ivpu_context_abort_thread_handler(struct work_struct *work)
    + 	struct ivpu_job *job;
      	unsigned long id;
      
     +	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_HW)
    @@ drivers/accel/ivpu/ivpu_job.c: void ivpu_context_abort_work_fn(struct work_struc
      	mutex_lock(&vdev->context_list_lock);
      	xa_for_each(&vdev->context_xa, ctx_id, file_priv) {
      		if (!file_priv->has_mmu_faults || file_priv->aborted)
    -@@ drivers/accel/ivpu/ivpu_job.c: void ivpu_context_abort_work_fn(struct work_struct *work)
    +@@ drivers/accel/ivpu/ivpu_job.c: void ivpu_context_abort_thread_handler(struct work_struct *work)
      
      	if (vdev->fw->sched_mode != VPU_SCHEDULING_MODE_HW)
      		return;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

