Return-Path: <stable+bounces-161605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BADEB0069C
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 17:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F66A1885E0E
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 15:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C56271447;
	Thu, 10 Jul 2025 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2QSx0AB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D7C22E3FA
	for <stable@vger.kernel.org>; Thu, 10 Jul 2025 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161265; cv=none; b=LGj7nbM1Is/L6RVL7F7/9+KvDL8UTjonx/QscHQ9zNOH0Ua/cfCUS7i1M2ry2VIdPkOgKVOR7IlaVDPr2rLnaEytNj4fkFCcsvY4XZ2ZgFySsGPR177aQqKeQWgZIvk+SQp+YVkHJI2KVMz2+RQJYYOfueU5dgzq7lSfM24NXjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161265; c=relaxed/simple;
	bh=7Dkde+gx24WjK/9T/0pjlSMoNTHsLdCv8QV7Jsbj3qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PhvgUf8FJKyOI/I4XfbuMJ/zP2aQCkO6jQNgun2nVSMrKlMAs3XZrz7P4joPFdt/eKVTmObmFCwZl3A2JeXf2IVHuterPMjPnDaDTOF75MeTVYBCI2ZMdbc62G/7HEs4P1kiSi8HvyxfbS9xVv5r4YPoz9gBHQJJrjZF4T93zKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2QSx0AB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF178C4CEE3;
	Thu, 10 Jul 2025 15:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752161263;
	bh=7Dkde+gx24WjK/9T/0pjlSMoNTHsLdCv8QV7Jsbj3qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U2QSx0ABzX10OVBhs33NuoGablpc+jMepN0x9ZjHiJOBdC7W+ZGs8ew2+wa/GZM5f
	 BJUWyVpIQBvchsXmbwwGHZmt8SL+F1oBle0+KxmYoYiIgu4M8tH4EGqHXTkjPGCxzK
	 RuXL8lwMqjqHoQ9MmrV3ZZLFTWjokRHPI6KGV9zwExQdQkkCDsTT34LhbcxwIBx4ux
	 f0445fUWwg/zlwYqSprzo82Fh2eyMHL6hRYtLpmGl3nuGFMWXia4i4Bn71xCVCY88o
	 39MBs9a3tGXyyCO4hlwrpW2U14BKQIznFUGeR6KGkTU11Bpj/bt3dEjmqHWkp5EDBH
	 ytNc2Ytkhvz/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jetlan9@163.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] drm/amdgpu: Replace Mutex with Spinlock for RLCG register access to avoid Priority Inversion in SRIOV
Date: Thu, 10 Jul 2025 11:27:41 -0400
Message-Id: <20250709081019-080335c8604d04c8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250709115128.1263-1-jetlan9@163.com>
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

The upstream commit SHA1 provided is correct: dc0297f3198bd60108ccbd167ee5d9fa4af31ed0

WARNING: Author mismatch between patch and upstream commit:
Backport author: jetlan9@163.com
Commit author: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  dc0297f3198bd ! 1:  3da0142a2c955 drm/amdgpu: Replace Mutex with Spinlock for RLCG register access to avoid Priority Inversion in SRIOV
    @@ Metadata
      ## Commit message ##
         drm/amdgpu: Replace Mutex with Spinlock for RLCG register access to avoid Priority Inversion in SRIOV
     
    +    [ Upstream commit dc0297f3198bd60108ccbd167ee5d9fa4af31ed0 ]
    +
         RLCG Register Access is a way for virtual functions to safely access GPU
         registers in a virtualized environment., including TLB flushes and
         register reads. When multiple threads or VFs try to access the same
    @@ Commit message
         Suggested-by: Alex Deucher <alexander.deucher@amd.com>
         Reviewed-by: Christian König <christian.koenig@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    +    [ Minor context change fixed. ]
    +    Signed-off-by: Wenshan Lan <jetlan9@163.com>
     
      ## drivers/gpu/drm/amd/amdgpu/amdgpu_device.c ##
     @@ drivers/gpu/drm/amd/amdgpu/amdgpu_device.c: int amdgpu_device_init(struct amdgpu_device *adev,
    @@ drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h: struct amdgpu_virt {
     -	struct mutex rlcg_reg_lock;
     +	/* Spinlock to protect access to the RLCG register interface */
     +	spinlock_t rlcg_reg_lock;
    + };
      
    - 	union amd_sriov_ras_caps ras_en_caps;
    - 	union amd_sriov_ras_caps ras_telemetry_en_caps;
    + struct amdgpu_video_codec_info;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

