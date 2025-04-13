Return-Path: <stable+bounces-132343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA81A872A9
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 18:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C0423B741F
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 16:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129A01D7E37;
	Sun, 13 Apr 2025 16:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ut0n1yiF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C789314A0A8
	for <stable@vger.kernel.org>; Sun, 13 Apr 2025 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744562805; cv=none; b=t4y/FkahYDzSb5xKks4j+lUY4BnrULwr07PB/Cq2qaGl2t1i09zqCnUnjdb/Eb5mZf2Cxhu+PtInlBfBLZV4+s5TAgZNImbxEkPVzXp8Sx7RVKFnL4xexGtGnNspsVdCz3sOaE2AmZwmw7fLOx/5xUNOg1igQXa2HH+WcauroFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744562805; c=relaxed/simple;
	bh=ZD4iIBb9ON0t+fJRyMseaD7FJxWUDYSrEqCVUgz7qC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPAaOLarHKavtDUehc/I4e1aCQPhF3CdNrwIdqpPhcvNUknILs9gOskb0QFeq8yjb0RwmPFJ8ZERmpaSY82kZ0EjF8PAvmVTeYFKE2aSpCRo/kmF78Dn3kEMtJu69kNqtmRQFX5Uh7CgEdmr2yOm3iOLlJEbc2shFdmmwhA65co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ut0n1yiF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA547C4CEDD;
	Sun, 13 Apr 2025 16:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744562805;
	bh=ZD4iIBb9ON0t+fJRyMseaD7FJxWUDYSrEqCVUgz7qC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ut0n1yiFChyqjJse00LawQyKYY1ZUBSAzsUM3X/ELNh+wc0UX52uw6vwoKzLHL5Qy
	 YA5JubMcyQueJUqPXfOND/W/8w6u68niwdLJ/X1lYkfkVmMlPN7gEt/wXyKD8ley2e
	 5K47+pHUWrH4w6A12wIBhKK+Z2cGLNmR7oos+6GLMxVvLCkB8LkRdNQYJc3XFP4YIm
	 xeV+aJWs036LiihsAnmDVWRVKLlRPUPhV2JwMifKEQcySeQa+gia0jrJfz3SAwpk+3
	 kcGsqEjstWAML58a9WJTfFQjdqQNJvnrJko9Jvs/6iDeMROV/gtm0h1x9aJtc3lBfA
	 7MmFJcDKFgxsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	adrian.larumbe@collabora.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13.y] drm/panthor: Replace sleep locks with spinlocks in fdinfo path
Date: Sun, 13 Apr 2025 12:46:43 -0400
Message-Id: <20250412124204-54cb006dfd3e0948@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250411230808.3648376-1-adrian.larumbe@collabora.com>
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

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: e379856b428acafb8ed689f31d65814da6447b2e

Status in newer kernel trees:
6.14.y | Present (different SHA1: 446311aa801c)

Note: The patch differs from the upstream commit:
---
1:  e379856b428ac ! 1:  f19951b3eb02d drm/panthor: Replace sleep locks with spinlocks in fdinfo path
    @@ Commit message
         Reviewed-by: Steven Price <steven.price@arm.com>
         Signed-off-by: Steven Price <steven.price@arm.com>
         Link: https://patchwork.freedesktop.org/patch/msgid/20250303190923.1639985-1-adrian.larumbe@collabora.com
    +    (cherry picked from commit e379856b428acafb8ed689f31d65814da6447b2e)
     
      ## drivers/gpu/drm/panthor/panthor_sched.c ##
     @@
    @@ drivers/gpu/drm/panthor/panthor_sched.c
      #include <linux/delay.h>
      #include <linux/dma-mapping.h>
     @@ drivers/gpu/drm/panthor/panthor_sched.c: struct panthor_group {
    + 
    + 	/** @fdinfo: Per-file total cycle and timestamp values reference. */
    + 	struct {
    +-		/** @data: Total sampled values for jobs in queues from this group. */
    ++		/** @fdinfo.data: Total sampled values for jobs in queues from this group. */
      		struct panthor_gpu_usage data;
      
      		/**
    @@ drivers/gpu/drm/panthor/panthor_sched.c: struct panthor_group {
      		 */
     -		struct mutex lock;
     +		spinlock_t lock;
    + 	} fdinfo;
      
    - 		/** @fdinfo.kbo_sizes: Aggregate size of private kernel BO's held by the group. */
    - 		size_t kbo_sizes;
    + 	/** @state: Group state. */
     @@ drivers/gpu/drm/panthor/panthor_sched.c: static void group_release_work(struct work_struct *work)
      						   release_work);
      	u32 i;
    @@ drivers/gpu/drm/panthor/panthor_sched.c: void panthor_fdinfo_gather_group_sample
      	xa_unlock(&gpool->xa);
      }
     @@ drivers/gpu/drm/panthor/panthor_sched.c: int panthor_group_create(struct panthor_file *pfile,
    + 	}
      	mutex_unlock(&sched->reset.lock);
      
    - 	add_group_kbo_sizes(group->ptdev, group);
     -	mutex_init(&group->fdinfo.lock);
     +	spin_lock_init(&group->fdinfo.lock);
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Success   |

