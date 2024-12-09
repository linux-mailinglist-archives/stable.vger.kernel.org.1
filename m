Return-Path: <stable+bounces-100203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133C29E9905
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08AE6166C12
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093241B422F;
	Mon,  9 Dec 2024 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0sxoDBv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3BA1ACEB8
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754930; cv=none; b=mqurx31NXVPgyFzWrd2TrLSZHlIqvrhSUa/ueuYme12hZ4nberncwTIsDDHsfhqIjqtyqmRfvT8CUKpyF0s5u0hRmpsQ1JIGdSuqzbkjQm2QI9ETc8OcI0y1bVo02ign0dbGUgN4R7Ru1kjSxqSlkz/F0INgynT5u7jSe+y45k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754930; c=relaxed/simple;
	bh=Hs3+e71IxKwsi/fBtnGvSage5yUswVr5MuniRIecfBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KR7mO75puYEo7yx5QVQSZ6qaj3hVw3NlhAuRiisxYLv1UsAH9mhlkIo5F5nJazxpMsglQbM9CMTkn7dzFgx1/KR0nKGzfk4AAHcPYk1egG15o406DqQUbNiarkSvXHruHVDx72rKx1CaI7okze/rYw91gDlinvrjHnzlgtox15k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0sxoDBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28A4C4CEDE;
	Mon,  9 Dec 2024 14:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733754930;
	bh=Hs3+e71IxKwsi/fBtnGvSage5yUswVr5MuniRIecfBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S0sxoDBvnd8A8gj0vsePiMRkl+9za2PFbZ1c2v8I8BtksJcNMwFbwyvpA0u+dLha3
	 owKAnq/JFCKbLn32G9hMxPEapf5spDfVjAaOcsklYMLknHO87UMIQAAN2mxEPOvozE
	 kOr8+Kumvr/lbqRYY9lY7qvEXDmOu4bqZgY79j1nOOemWhW2F1yUz2glfBwm0WPJ81
	 266KAug15zzrGzzwYhyCRMwJfrSaVnzfgnNy8Od1A0mV1NoRd6k6DCI+wHuXhKPJZL
	 ak5HpQDmZB/EU0HQxgn6ZwitpQy1WFa6xCQZnafKwer5IjSaeJ3cifBqCKZ2JeNNBv
	 AkfLYOzl6URRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] drm/amd/display: Don't refer to dc_sink in is_dsc_need_re_compute
Date: Mon,  9 Dec 2024 09:35:28 -0500
Message-ID: <20241209075139-c81c31a9b158dfbf@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241209063637.3427088-1-jianqi.ren.cn@windriver.com>
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
1:  fcf6a49d79923 ! 1:  82afb36e9f872 drm/amd/display: Don't refer to dc_sink in is_dsc_need_re_compute
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

