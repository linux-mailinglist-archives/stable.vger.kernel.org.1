Return-Path: <stable+bounces-100472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DE69EBA0F
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 20:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C7B7283C7D
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 19:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C248C224AEB;
	Tue, 10 Dec 2024 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QstdDokW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8387121423D
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 19:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858692; cv=none; b=i8nhpHTaET3n6yn21iIT20DVVSVvYzOs0KPaxLGqPPeWd/YzvnyJ600fmjdBwRSmZrLKFayluTT9Ct/gaWePlfloJKyt6ohULJqa/MwWYSXxss/gjOSg46ik05bIRItXOPRJEA6gjoYhSefio8ony72YMriuTNzgYCpSXZ+HZLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858692; c=relaxed/simple;
	bh=mWB24LAalvDgyiQWIRKPbpL6pYiI52Oa1Tsh3CYEz80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EBof6zQu9Id/cFzGIdHfkrO84WQDBFLYPZ/NYtDZ1fWCr6qN9dvdyHD/KeXOuVuxDNu0S5154Ht9OOB4/36LxvNNKfy2iVVDPFR5AY8OrN0LapMRV10PLPDviZBWJR6SjrEo5D13rdegR/oT+v4UsRS6qcNSGr15XE5HmfEKFms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QstdDokW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9FCC4CED6;
	Tue, 10 Dec 2024 19:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733858691;
	bh=mWB24LAalvDgyiQWIRKPbpL6pYiI52Oa1Tsh3CYEz80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QstdDokW+9SvwckinB/ZbLVxmQH0+/vVGaRCEdG8NW38WIrWw9p+CViiH17Wxs59H
	 3ybW8Ysi9d9vCZokKBf44PU5fK6QDAOUfYBtDyi/RpDNOmCBMvE0jN5oiRUFlR2YWa
	 AlKq+hnNhY+zhSOOEZ8DxPZewb2YY1n43mS3Hby/gfPPUxssyvC/gRIGuBcNoI36ur
	 GU40nK4djvfKEOYSEUhzR1cdxsNbMD0mTHFs6f6y/lOxTRMxWBmwDhfW3C7MpG6rg8
	 QcmQx5g4CA0L26+7KlmyLfWP4PE/xfQNnhPgZIPDLBkzJabwm5Oi9I7AYI0IGvm91j
	 BRtdaQQXtcj/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] drm/amdgpu: rework resume handling for display (v2)
Date: Tue, 10 Dec 2024 14:24:49 -0500
Message-ID: <20241210141614-15a30774a20fbafc@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241210165219.2865887-1-alexander.deucher@amd.com>
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

Found matching upstream commit: 73dae652dcac776296890da215ee7dec357a1032


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  73dae652dcac7 ! 1:  bcf8cb2c1f830 drm/amdgpu: rework resume handling for display (v2)
    @@ Commit message
     
         v2: fix fence irq resume ordering
     
    +    Backport to 6.12 and older kernels
    +
         Reviewed-by: Christian König <christian.koenig@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
         Cc: stable@vger.kernel.org # 6.11.x
    +    (cherry picked from commit 73dae652dcac776296890da215ee7dec357a1032)
     
      ## drivers/gpu/drm/amd/amdgpu/amdgpu_device.c ##
     @@ drivers/gpu/drm/amd/amdgpu/amdgpu_device.c: static int amdgpu_device_ip_resume_phase1(struct amdgpu_device *adev)
    @@ drivers/gpu/drm/amd/amdgpu/amdgpu_device.c: static int amdgpu_device_ip_resume_p
     +		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE ||
      		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP)
      			continue;
    - 		r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
    + 		r = adev->ip_blocks[i].version->funcs->resume(adev);
     @@ drivers/gpu/drm/amd/amdgpu/amdgpu_device.c: static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
      	return 0;
      }
    @@ drivers/gpu/drm/amd/amdgpu/amdgpu_device.c: static int amdgpu_device_ip_resume_p
     +		if (!adev->ip_blocks[i].status.valid || adev->ip_blocks[i].status.hw)
     +			continue;
     +		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE) {
    -+			r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
    ++			r = adev->ip_blocks[i].version->funcs->resume(adev);
     +			if (r)
     +				return r;
     +		}
    @@ drivers/gpu/drm/amd/amdgpu/amdgpu_device.c: static int amdgpu_device_ip_resume(s
      	return r;
      }
      
    -@@ drivers/gpu/drm/amd/amdgpu/amdgpu_device.c: int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
    +@@ drivers/gpu/drm/amd/amdgpu/amdgpu_device.c: int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
      		dev_err(adev->dev, "amdgpu_device_ip_resume failed (%d).\n", r);
      		goto exit;
      	}
    @@ drivers/gpu/drm/amd/amdgpu/amdgpu_device.c: int amdgpu_device_resume(struct drm_
      
      	if (!adev->in_s0ix) {
      		r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
    -@@ drivers/gpu/drm/amd/amdgpu/amdgpu_device.c: int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
    +@@ drivers/gpu/drm/amd/amdgpu/amdgpu_device.c: int amdgpu_do_asic_reset(struct list_head *device_list_handle,
      				if (tmp_adev->mman.buffer_funcs_ring->sched.ready)
      					amdgpu_ttm_set_buffer_funcs_status(tmp_adev, true);
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

