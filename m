Return-Path: <stable+bounces-144418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776D8AB7682
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87DB07B62CE
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 20:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836EC295DAD;
	Wed, 14 May 2025 20:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeWCHHBW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D10295512
	for <stable@vger.kernel.org>; Wed, 14 May 2025 20:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253588; cv=none; b=CIZ5oMsyuQdqEOYGSvYnjcQ/fur3lLoAAR4jGY2hYKbLzjXKWsxjjVkvx+rktZkYcW0r/oRa6Cy5PKY7CV0nNrz6Ri3BHwiqJU9/skIM5XlHsZ46thDCJlB3tazYA3zNLZpmt3UdQRP6ydJc0ZdGHs2XErQAy/PDztNchGckiYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253588; c=relaxed/simple;
	bh=IW8ymKTNS6NplFBHeXFRY+thLdYnqGSL2xeBwUNt6SA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C9mOviqwAw2Valm9l5w1XBJrGr/cYZEMxVghoZWaIKqZNLtWxLvnpbANn3+EYCUZ71I5SK3m7Ou/1l/2/yLKNErzWVloiaKPjKvyun3dxW+s0JwZ8YiU3XNPJjUYJbuNHlAfUziE01X8CA9bOZH5QE7MsIPWFFB5D1q9WM75PXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeWCHHBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB64C4CEE3;
	Wed, 14 May 2025 20:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747253587;
	bh=IW8ymKTNS6NplFBHeXFRY+thLdYnqGSL2xeBwUNt6SA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oeWCHHBW1bVgflKQyTfuc/jlaHZL7qI9bwraaytRAhfR5PLfRxugKqEVl8ct6+L/0
	 P5fRTBBBxGll+EVadg0izhQWEbYkDu2CsXHsfmQARjaYnLjZoNfBc+0+/TCVxZcQbO
	 gvWLsapFSWStbQCNHnAlP5wRe7MIRz6huKXopAQuv0HPXa1olv9OL7sB7lGGs/zzb/
	 YmwE8wJqXE/xv19iWNL0Rgm9O15wusr3OKqKnIXv/C+jghckNL11DwuQw7lsnQKdQ2
	 0QvCV4dvVGsAe5yzc6pMzoOCgiXqTsgsV2SqX7T/oCGYav8477H2USfrybpJ84nM3b
	 X1LxbG+LFicvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	daniele.ceraolospurio@intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14.y] drm/xe/gsc: do not flush the GSC worker from the reset path
Date: Wed, 14 May 2025 16:13:05 -0400
Message-Id: <20250514095358-3685068562756ee9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513233056.2986393-1-daniele.ceraolospurio@intel.com>
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

Note: The patch differs from the upstream commit:
---
1:  03552d8ac0afc ! 1:  ec3abfe7a63b2 drm/xe/gsc: do not flush the GSC worker from the reset path
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
     
      ## drivers/gpu/drm/xe/xe_gsc_proxy.h ##
     @@ drivers/gpu/drm/xe/xe_gsc_proxy.h: struct xe_gsc;
    - 
      int xe_gsc_proxy_init(struct xe_gsc *gsc);
      bool xe_gsc_proxy_init_done(struct xe_gsc *gsc);
    + void xe_gsc_proxy_remove(struct xe_gsc *gsc);
     +int xe_gsc_wait_for_proxy_init_done(struct xe_gsc *gsc);
      int xe_gsc_proxy_start(struct xe_gsc *gsc);
      
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
| stable/linux-6.14.y       |  Success    |  Success   |

