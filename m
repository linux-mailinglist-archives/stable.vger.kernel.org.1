Return-Path: <stable+bounces-135173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17723A97543
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 21:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5FD43B596D
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 19:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D601DDA1E;
	Tue, 22 Apr 2025 19:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnzqkBD8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A2929898C
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745349454; cv=none; b=IDIBQbq9AR0ziyOoiaeJ/tVCF5MM74EOUbYst7vuiDVNnQ9YmOb3EklMFkW9FXdtbnpohSci2Nk9/FLsNsPhvQnkg1pZLhfF43cNbIgbluXmWRY5HGwVpqK6PGWL5maDgREAG9ldVBoqSmVBnwqp41ycwIbNXS4T9r28MvhndkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745349454; c=relaxed/simple;
	bh=am4hFzyXtUuxWOaD9wnRP8RSxcQI8B74wzzljq4OwAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7E6nGNe8iZrpe4w2fkHOx7siGstIYkBaQn5h600hRH6GSpxVJMTf9u0Rm1WYufttR0LHIBwpAiD27E6Obb7mA1PQ1BM//lcIjSt5/f4vHGNj8+OtPv4DjKqbSYD+3Skd6wuGpdzfYOURHGEUY+3iAviVjb6J2UFlG1Qla1uuoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnzqkBD8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DCBC4CEE9;
	Tue, 22 Apr 2025 19:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745349453;
	bh=am4hFzyXtUuxWOaD9wnRP8RSxcQI8B74wzzljq4OwAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TnzqkBD8pvMPCAbWwZy74u5Z48Y+H4cLIK6pWX++pHKdZU42Ogyj85JO0muMSV268
	 iYTlJlaIiKyqNCW7J/2pyejfM9LoXavAflWc4KfqfGjnaAlPDBh1rYsI0xemCrn2jA
	 NM2l24xYduRpIgrI2ArTvHh9is/i2dDC6Q423+efi2YA+twMTL2Qb8cTaRcTcn5+o+
	 icV2s+ivFFKnswmtWyttEyz+lJNgBk8AUS3tzDr2TZWmZjFHMLg8iUojs1fkSQC1h4
	 RHmTz1kSTyWEd2fhcPGPGQspSmpbBrntjCD6DIljsCR3e+LwRccUMz3gwGp6T/Ai2Y
	 sxsNHO4It3Lhw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] drm/amdgpu: fix usage slab after free
Date: Tue, 22 Apr 2025 15:17:30 -0400
Message-Id: <20250422115255-23690b0c03c5ef8e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250422063333.3901834-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: b61badd20b443eabe132314669bb51a263982e5c

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Vitaly Prosyak<vitaly.prosyak@amd.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 6383199ada42)
6.6.y | Present (different SHA1: 3990ef742c06)
6.1.y | Present (different SHA1: 05b1b33936b7)

Note: The patch differs from the upstream commit:
---
1:  b61badd20b443 ! 1:  a9cf4e376c397 drm/amdgpu: fix usage slab after free
    @@ Metadata
      ## Commit message ##
         drm/amdgpu: fix usage slab after free
     
    +    [ Upstream commit b61badd20b443eabe132314669bb51a263982e5c ]
    +
         [  +0.000021] BUG: KASAN: slab-use-after-free in drm_sched_entity_flush+0x6cb/0x7a0 [gpu_sched]
         [  +0.000027] Read of size 8 at addr ffff8881b8605f88 by task amd_pci_unplug/2147
     
    @@ Commit message
         Reviewed-by: Christian König <christian.koenig@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
         Cc: stable@vger.kernel.org
    +    [Minor context change fixed.]
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## drivers/gpu/drm/amd/amdgpu/amdgpu_device.c ##
    -@@ drivers/gpu/drm/amd/amdgpu/amdgpu_device.c: void amdgpu_device_fini_sw(struct amdgpu_device *adev)
    - 	int idx;
    - 	bool px;
    +@@ drivers/gpu/drm/amd/amdgpu/amdgpu_device.c: void amdgpu_device_fini_hw(struct amdgpu_device *adev)
      
    + void amdgpu_device_fini_sw(struct amdgpu_device *adev)
    + {
     -	amdgpu_fence_driver_sw_fini(adev);
      	amdgpu_device_ip_fini(adev);
     +	amdgpu_fence_driver_sw_fini(adev);
    - 	amdgpu_ucode_release(&adev->firmware.gpu_info_fw);
    + 	release_firmware(adev->firmware.gpu_info_fw);
    + 	adev->firmware.gpu_info_fw = NULL;
      	adev->accel_working = false;
    - 	dma_fence_put(rcu_dereference_protected(adev->gang_submit, true));
     
      ## drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c ##
     @@ drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c: int amdgpu_vce_sw_fini(struct amdgpu_device *adev)
    @@ drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c: int amdgpu_vce_sw_fini(struct amdgpu_de
      	for (i = 0; i < adev->vce.num_rings; i++)
      		amdgpu_ring_fini(&adev->vce.ring[i]);
      
    - 	amdgpu_ucode_release(&adev->vce.fw);
    + 	release_firmware(adev->vce.fw);
      	mutex_destroy(&adev->vce.idle_mutex);
      
     +	amdgpu_bo_free_kernel(&adev->vce.vcpu_bo, &adev->vce.gpu_addr,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

