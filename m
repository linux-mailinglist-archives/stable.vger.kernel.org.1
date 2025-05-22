Return-Path: <stable+bounces-146042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF17AC05DE
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 09:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053C33B7781
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 07:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1FA2222C0;
	Thu, 22 May 2025 07:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcK4ltp4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEE822094
	for <stable@vger.kernel.org>; Thu, 22 May 2025 07:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747899489; cv=none; b=UrouhpH/68M4ZqkPdTxGcNfEd6wh/Yvf32xE85XCy4Egd1zuTgIxra6UQN4lucQGWWPIUbudKrAxqIFnLpWhxn2iFwoor9y7PsK5IiK2qcRkaMbsI41p3WJm0x8+cUpUVb8Zoj6iCrdCoKDVybedUlaFdDQJLqodw3RLjkDmnNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747899489; c=relaxed/simple;
	bh=XtJi0uKXdHylZlJUU9ERu6ayN9jjJLrc1iOA+RBhoNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9TeQFtB6vVLsFV0IacgldDrAT8WvuVyjhhf5pTO5V4C/c4rLidYCplh3nkPc3TQE5krTs5ZX0D9voUQebEJEphVcv791EOR7jFFQDYLbOXhHsJsFA3944HfLiHLm0RnmAFuVV2/QVtIZ7WWPSAThKZHDgl2e9ALZ/thJKzICJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcK4ltp4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F087CC4CEE4;
	Thu, 22 May 2025 07:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747899488;
	bh=XtJi0uKXdHylZlJUU9ERu6ayN9jjJLrc1iOA+RBhoNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TcK4ltp4jbSMTfK2dkyh1pMb8pXECk5FEWCdsntXOzvGvJhnPkUcNKh51uxtezsAZ
	 lKmgoNlgou9AEJLbkJuVleirQZRjWwxO8CwS05fe9nIsrf+KiAqQ10Q0K/ZP0+l4Ho
	 q7JdDxjM/ygTsUw8NyXb5GHBuXEJbp+UsiHd4hN1ENXvGrmugFZ35a+poIC4sbRO1R
	 6On/opKTwMuEZ8wU5U+cpnv0xGIY7pX18pdAesHZuvFW+SUIYXeK1Mb/AKaD5RLQID
	 kGpe7/TWPoi1/oQepypM/g0j0wjHyFF+KTpFn/5f2G24wEKB51wm0eDp/WwOG34321
	 5FHTdm4IgZPDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Naim <dnaim@cachyos.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: read back register after written for VCN v4.0.5
Date: Thu, 22 May 2025 03:38:04 -0400
Message-Id: <20250521233459-363ebb04fd975b3a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521165421.293820-2-dnaim@cachyos.org>
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

The upstream commit SHA1 provided is correct: ee7360fc27d6045510f8fe459b5649b2af27811a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Eric Naim<dnaim@cachyos.org>
Commit author: David (Ming Qiang) Wu<David.Wu3@amd.com>

Note: The patch differs from the upstream commit:
---
1:  ee7360fc27d60 ! 1:  d66acea470dc1 drm/amdgpu: read back register after written for VCN v4.0.5
    @@ Metadata
      ## Commit message ##
         drm/amdgpu: read back register after written for VCN v4.0.5
     
    +    commit ee7360fc27d6045510f8fe459b5649b2af27811a upstream
    +
         On VCN v4.0.5 there is a race condition where the WPTR is not
         updated after starting from idle when doorbell is used. Adding
         register read-back after written at function end is to ensure
    @@ Commit message
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
         (cherry picked from commit 07c9db090b86e5211188e1b351303fbc673378cf)
         Cc: stable@vger.kernel.org
    +    Tested-by: Eric Naim <dnaim@cachyos.org>
    +    Signed-off-by: Eric Naim <dnaim@cachyos.org>
     
      ## drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c ##
    -@@ drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c: static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
    +@@ drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c: static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
      			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
      			VCN_RB1_DB_CTRL__EN_MASK);
      
    @@ drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c: static int vcn_v4_0_5_start_dpg_mode(st
      	return 0;
      }
      
    -@@ drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c: static int vcn_v4_0_5_start(struct amdgpu_vcn_inst *vinst)
    +@@ drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c: static int vcn_v4_0_5_start(struct amdgpu_device *adev, int i)
      	WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
      	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

