Return-Path: <stable+bounces-100646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 018929ED1D7
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE11118836C2
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF26E1B6CF3;
	Wed, 11 Dec 2024 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IU4Jkyga"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDF738DE9
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934732; cv=none; b=fmUExo5dv4xRAdfy3Sskvlk4HfaYz8aSDTCw0dFkcKxqF2NfIzad/50zXA54ZVN0kBt4Y3lLaaRNd0MZ2KCfTtKqRwtVKlFzBpBdnxleXn03vkEZeE+B+HGgemK4cldv91RTt+YEfyuVXAz37dmHPRDHnkbYX4yX23OyDtw7jQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934732; c=relaxed/simple;
	bh=n878rBrBZLvBZTB/F44w0OF0HJsM0/9ScVio040JnXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSYkQ6P+Pen0UbOKU2xu3s9xUJKWuVDT19+G0SYhLrpN3RQuf4OZKLb4/3rqrrIP4vPDFEU263Y6P7XHxJo7kd+WFA/F4pbjCH+qpKUS4hmMUwKYTHRwNfaz4Fgmhx86zw9UoxCeheAonsKL35qfdZYY1GUWFyULSnPIXrlGpN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IU4Jkyga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E549AC4CED2;
	Wed, 11 Dec 2024 16:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934732;
	bh=n878rBrBZLvBZTB/F44w0OF0HJsM0/9ScVio040JnXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IU4Jkyga6uj2YcarGG2sRXzsI5VZ8QDugJry1a2n9l46DBz5HGfgBbeptklg7/nx9
	 LKAMMpbDz2ohmCUQQCsTFUTh4+BOmsRj4/LD5sNyTQgNy+kFf9+QM+LLjpXzuKXW0I
	 uemP4HUbffupdg+ertIH7SMPgJuSjhZFjgdM8bYUqc6w/wkba9lFV39m1VX1gA2tvv
	 6L9HMG4ruXErz2Om55fmJ/JA9evSdq6L+OXbXTApHd1y0+K0VjTQtT0fneaggmJlIe
	 T0fT4oeewMwVXpnOyJz9MhTLMreM6N2jJbDebP98cxGcD7gZIKDH8uRELFw5wNhyrc
	 EgpnBSsusfnjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] drm/amd/display: Don't refer to dc_sink in is_dsc_need_re_compute
Date: Wed, 11 Dec 2024 11:32:10 -0500
Message-ID: <20241211104034-b941070268a7cc1f@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211100119.2069620-1-jianqi.ren.cn@windriver.com>
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
1:  fcf6a49d79923 ! 1:  047f6f4d94ae2 drm/amd/display: Don't refer to dc_sink in is_dsc_need_re_compute
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

