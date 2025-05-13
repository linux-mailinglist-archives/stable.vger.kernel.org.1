Return-Path: <stable+bounces-144248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421D7AB5CC7
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A51964A556F
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64A82BEC5A;
	Tue, 13 May 2025 18:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uIWVvk4H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676FA1E521A
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162221; cv=none; b=DKefU8Gk54ATS3vtuuEV0p+spUqOSom/zj30A383C8gHzVSeNdQDEKOZR/5zN2+OUz9GXmeVPdmeX8NCHiiq7O0zTSbzsXa1M5qz0vxy4z3xcBphqUlKWgRMXb8adtjthMp7CcRwonnw95IJNuI0osdHceFoipTECrm+s+jQpPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162221; c=relaxed/simple;
	bh=t482PBdY7oMKJcwaYaxFZRNDwjVryFBVkR2SA3P8d1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BLs/aoq+QeU+41pm0jH4HR0NlvF31BXikoW0OwM4USXJlKZvIVMYHqWw2NR/4MrvoJ7sB+VMCUGVsRV/EcEPL0ay2+GkiJhH/bUohmGXoKB++NDFLSgl6+gAgpXwYyrfL8gANoarYWg+pm5gvAXXlycMD/yDzXwvmt02FKrovao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uIWVvk4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A2FC4CEE4;
	Tue, 13 May 2025 18:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162221;
	bh=t482PBdY7oMKJcwaYaxFZRNDwjVryFBVkR2SA3P8d1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uIWVvk4HoyAV8FaosEu/YJA/EowPFXIEi/Sdl0V7wbK/JpgTcUWd4A4v4IikrQY2X
	 FiITQIaXtD2s4FhdzKtgos7Kr7MDHZclATElKtF53dwKjcSoCWWUyP4Y8kRd6pdUB2
	 JgD4veIHMHR/AnsRbTLk9B9ndk5xHgaP66A22JO8+8zRJmdphFTpKMHdX4puDDTDH2
	 9nU1TCmgA9jQlS1O3jj1nVMsogzQw39KMk1B28UVR10apHX7JEN/IJMbQHzX3goX2W
	 /M25Dj1tG04NJlZTTHhr90NEzpnxmhHlBIRPcztYiWgVysbw2/yl9UxOr5OscNevOT
	 NQUo9QM2mQAcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] drm/amd/display: Don't refer to dc_sink in is_dsc_need_re_compute
Date: Tue, 13 May 2025 14:50:18 -0400
Message-Id: <20250513110220-ce7378d24f73a842@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513015214.3360461-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: fcf6a49d79923a234844b8efe830a61f3f0584e4

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Wayne Lin<wayne.lin@amd.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: c7e65cab54a8)

Note: The patch differs from the upstream commit:
---
1:  fcf6a49d79923 ! 1:  a758fb74ab9a7 drm/amd/display: Don't refer to dc_sink in is_dsc_need_re_compute
    @@ Metadata
      ## Commit message ##
         drm/amd/display: Don't refer to dc_sink in is_dsc_need_re_compute
     
    +    [ Upstream commit fcf6a49d79923a234844b8efe830a61f3f0584e4 ]
    +
         [Why]
         When unplug one of monitors connected after mst hub, encounter null pointer dereference.
     
    @@ Commit message
         Signed-off-by: Wayne Lin <wayne.lin@amd.com>
         Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    +    [The deleted codes in this fix is introduced by commit b9b5a82c5321
    +    ("drm/amd/display: Fix DSC-re-computing") after 6.11.]
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c ##
     @@ drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c: amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector)
    @@ drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c: dm_dp_mst_detect(st
      
      		amdgpu_dm_set_mst_status(&aconnector->mst_status,
      			MST_REMOTE_EDID | MST_ALLOCATE_NEW_PAYLOAD | MST_CLEAR_ALLOCATED_PAYLOAD,
    -@@ drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c: static bool is_dsc_need_re_compute(
    - 		if (!aconnector || !aconnector->dsc_aux)
    - 			continue;
    - 
    --		/*
    --		 *	check if cached virtual MST DSC caps are available and DSC is supported
    --		 *	as per specifications in their Virtual DPCD registers.
    --		*/
    --		if (!(aconnector->dc_sink->dsc_caps.dsc_dec_caps.is_dsc_supported ||
    --			aconnector->dc_link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_PASSTHROUGH_SUPPORT))
    --			continue;
    --
    - 		stream_on_link[new_stream_on_link_num] = aconnector;
    - 		new_stream_on_link_num++;
    - 
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

