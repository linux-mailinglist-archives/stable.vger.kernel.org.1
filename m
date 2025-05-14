Return-Path: <stable+bounces-144434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40514AB7694
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8891BA6630
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 20:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750E7296700;
	Wed, 14 May 2025 20:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlJQSGai"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3513129617F
	for <stable@vger.kernel.org>; Wed, 14 May 2025 20:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253649; cv=none; b=P6lG1imUhD/3InnYf5ZLWSx5BBx6MyfOoU+LyNnxvtHooyuGKD+XY/d0f5FN3rQ+Sjhop+gfiv5vZ6y/F5rdjKw6oaT2c1rXb/bkctfa6mIlPXuQ9Hx+8EOAZ0Uh+xs2smqkjW8EXtiwAupZ4cbmp5PYNanC+y6toBsZlq+KQhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253649; c=relaxed/simple;
	bh=BLj/QHwqRDvTexXdcUJaQ3m1++WkW4TISoytffYmAu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uooPP8iZUyEOpiIJF786R8S/Db9mgC0vfgxLi0Cg/5CE/2EPpiavM/w1j1PAUC2mmPjCN4X3HVQJRLol6NnOOlaHdaamRwocEfi78JSjhd5bguDS6MRLeodxkLczQzy30/SIzgD21B/oQEPCsq/9Z0EdB46gnZxoOGIaX4cKmnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlJQSGai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D74C4CEED;
	Wed, 14 May 2025 20:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747253649;
	bh=BLj/QHwqRDvTexXdcUJaQ3m1++WkW4TISoytffYmAu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dlJQSGaiePtcPyqUDQBJLU8Dqa+cSRJGFO2r7skxksH8MZVmP+VDeU/vW/VK0/Z6P
	 63h+gIJ3o/F9t1sjg3QG6oCBgPXAGdqeNEWjViwI1sF6B/FzPsh/mTsY04omxwZGLF
	 kvocVRBmb+p230Ij1PtDoqUocJmMa+Kg1d6RxgElbALcenE7nvB7bsXUN9IUd08Q/K
	 5KwUVJYFclw/Sn4RWINYeqxVaYhSTZo9ze+Cr76c6PuZsNp3PwfmapORrPo5K60hiD
	 X7/NJd0y/qoKxF2EB5iF4EA1vk7Crz6Xz010XPhPZtf6bOF7wTGsebwgMIsg0YXD7k
	 ++4TOEZc/fPHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	daniele.ceraolospurio@intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] drm/xe/gsc: do not flush the GSC worker from the reset path
Date: Wed, 14 May 2025 16:14:05 -0400
Message-Id: <20250514102623-f62384196f019631@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513232706.2986265-1-daniele.ceraolospurio@intel.com>
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

Found matching upstream commit: 03552d8ac0afcc080c339faa0b726e2c0e9361cb

Status in newer kernel trees:
6.14.y | Not found

Note: The patch differs from the upstream commit:
---
1:  03552d8ac0afc ! 1:  29475b71fb1d0 drm/xe/gsc: do not flush the GSC worker from the reset path
    @@ Commit message
         Link: https://lore.kernel.org/r/20250502155104.2201469-1-daniele.ceraolospurio@intel.com
         (cherry picked from commit 12370bfcc4f0bdf70279ec5b570eb298963422b5)
         Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
    +    (cherry picked from commit 03552d8ac0afcc080c339faa0b726e2c0e9361cb)
     
      ## drivers/gpu/drm/xe/xe_gsc.c ##
    -@@ drivers/gpu/drm/xe/xe_gsc.c: void xe_gsc_wait_for_worker_completion(struct xe_gsc *gsc)
    - 		flush_work(&gsc->work);
    +@@ drivers/gpu/drm/xe/xe_gsc.c: void xe_gsc_remove(struct xe_gsc *gsc)
    + 	xe_gsc_proxy_remove(gsc);
      }
      
     +void xe_gsc_stop_prepare(struct xe_gsc *gsc)
    @@ drivers/gpu/drm/xe/xe_gsc.h: struct xe_hw_engine;
      void xe_gsc_wait_for_worker_completion(struct xe_gsc *gsc);
     +void xe_gsc_stop_prepare(struct xe_gsc *gsc);
      void xe_gsc_load_start(struct xe_gsc *gsc);
    + void xe_gsc_remove(struct xe_gsc *gsc);
      void xe_gsc_hwe_irq_handler(struct xe_hw_engine *hwe, u16 intr_vec);
    - 
     
      ## drivers/gpu/drm/xe/xe_gsc_proxy.c ##
     @@ drivers/gpu/drm/xe/xe_gsc_proxy.c: bool xe_gsc_proxy_init_done(struct xe_gsc *gsc)
    @@ drivers/gpu/drm/xe/xe_gsc_proxy.c: bool xe_gsc_proxy_init_done(struct xe_gsc *gs
     +	struct xe_gt *gt = gsc_to_gt(gsc);
     +
     +	/* Proxy init can take up to 500ms, so wait double that for safety */
    -+	return xe_mmio_wait32(&gt->mmio, HECI_FWSTS1(MTL_GSC_HECI1_BASE),
    ++	return xe_mmio_wait32(gt, HECI_FWSTS1(MTL_GSC_HECI1_BASE),
     +			      HECI1_FWSTS1_CURRENT_STATE,
     +			      HECI1_FWSTS1_PROXY_STATE_NORMAL,
     +			      USEC_PER_SEC, NULL, false);
    @@ drivers/gpu/drm/xe/xe_gsc_proxy.c: bool xe_gsc_proxy_init_done(struct xe_gsc *gs
     
      ## drivers/gpu/drm/xe/xe_gsc_proxy.h ##
     @@ drivers/gpu/drm/xe/xe_gsc_proxy.h: struct xe_gsc;
    - 
      int xe_gsc_proxy_init(struct xe_gsc *gsc);
      bool xe_gsc_proxy_init_done(struct xe_gsc *gsc);
    + void xe_gsc_proxy_remove(struct xe_gsc *gsc);
     +int xe_gsc_wait_for_proxy_init_done(struct xe_gsc *gsc);
      int xe_gsc_proxy_start(struct xe_gsc *gsc);
      
    @@ drivers/gpu/drm/xe/xe_gsc_proxy.h: struct xe_gsc;
     
      ## drivers/gpu/drm/xe/xe_gt.c ##
     @@ drivers/gpu/drm/xe/xe_gt.c: void xe_gt_suspend_prepare(struct xe_gt *gt)
    - 
    - 	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
    + {
    + 	XE_WARN_ON(xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL));
      
     -	xe_uc_stop_prepare(&gt->uc);
     +	xe_uc_suspend_prepare(&gt->uc);
      
    - 	xe_force_wake_put(gt_to_fw(gt), fw_ref);
    + 	XE_WARN_ON(xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL));
      }
     
      ## drivers/gpu/drm/xe/xe_uc.c ##
    @@ drivers/gpu/drm/xe/xe_uc.h: int xe_uc_reset_prepare(struct xe_uc *uc);
     +void xe_uc_suspend_prepare(struct xe_uc *uc);
      int xe_uc_suspend(struct xe_uc *uc);
      int xe_uc_sanitize_reset(struct xe_uc *uc);
    - void xe_uc_declare_wedged(struct xe_uc *uc);
    + void xe_uc_remove(struct xe_uc *uc);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

