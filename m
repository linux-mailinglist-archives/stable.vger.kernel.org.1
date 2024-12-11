Return-Path: <stable+bounces-100678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 465039ED202
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256C128123F
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF0B1DDA3C;
	Wed, 11 Dec 2024 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PY30/4uG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B471DD873
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934812; cv=none; b=ifP0d58pC4axNi7yoL95jwC1Tq74OoaTA7yzPnV6EBfr789IlNGwPxt1eZzFyklHASkufl40shHtILyLbT40wBph0/eHtIsmd8E/F3BIz+O1Pg+jVLmBjWEeymeusfzb0pKvKSHbZuD8qNzZ+zJjj1h23ajUS3KYR4whTUIBjG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934812; c=relaxed/simple;
	bh=cZWQxkH2V/+P7MM06PxGFKd9rCAD6t7ftzYVUcCG8XU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POD4mHTJ9L656iHbroleNtc7C0CfmODoBuRY17THCaJ0u7uwqK1T/ZrIjXmCAL1esubV3fjOffm6IDo6B7TcFipWMK+lf8tbSuSwtFVJf88oM4Go9E0htmFtfTEV7WrcO4sYFB290Wjnr9v2Kh0zPZZowuoK2n60qhbSPcTjN8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PY30/4uG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A497C4CED7;
	Wed, 11 Dec 2024 16:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934811;
	bh=cZWQxkH2V/+P7MM06PxGFKd9rCAD6t7ftzYVUcCG8XU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PY30/4uGH33/4MUVP/Jcjicy+1WIGu1cNsbfnAuppFOlG1erTIQ83a1de/thhe94c
	 Mgfw9wFZ2iOUFZNo7Iw6Ap5ahW1zRljRk9NRTv1LBrC2HUk79/zOEFZ3Ltj+1ObUwU
	 uEW0nQPkmhAuZE+A/AFtfM15cMJf3a2eZb5x6/IyfcW87pXasoxbdabKUN+QAUgKod
	 ODPhUuXCmGEe5rF2zVWa+2Liei2VFnBKw7DjJGQ1ud6lOX8BnBVlG1cMwcYcauMhT0
	 uuNgjIkMVZAaiyUJ8GNjw9nCkMbemeTJvQyNAKmGT1SIpctoxuc+hHOvs/fz7PEA0/
	 JZ+3S/tTQk1HA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] drm/amd/display: Don't refer to dc_sink in is_dsc_need_re_compute
Date: Wed, 11 Dec 2024 11:33:27 -0500
Message-ID: <20241211093733-0674d1a310236afb@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211101544.2121147-1-jianqi.ren.cn@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: fcf6a49d79923a234844b8efe830a61f3f0584e4

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Wayne Lin <wayne.lin@amd.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: c7e65cab54a8)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  fcf6a49d79923 ! 1:  bb340e15684fc drm/amd/display: Don't refer to dc_sink in is_dsc_need_re_compute
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
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
     
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

