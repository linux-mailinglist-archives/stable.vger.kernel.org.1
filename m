Return-Path: <stable+bounces-103898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3239EFA2C
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 19:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64340168638
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A6E1C5F07;
	Thu, 12 Dec 2024 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWpRAVTo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8169913C918
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026242; cv=none; b=loSnIuZj3SuTDKHFyQsNpvwVqbvZ9XIzCIAfE56bfx4cccT8J/IHwFPbCqiT0ov0K5V2DlytfwfpoBpEEqtJcHF4r6SiyUXWOIrLMyEEphdX4oIpM17lcjJdGhbC/g8pzhonpa3LoonJk6b9eIWXQb+4IF9fMvoGe98amzoXPOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026242; c=relaxed/simple;
	bh=0qdxbMc147yDGrvvfbPHKO5B3fLIosVBWCQeN2+sxsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdW/22YqU+CCKV8vDgHq+ZwaevAE6cAUnOZdlpSF0jofub4Dj2x1QMZkEATqJ4brrBYCjSq2CSKYeZHf/OVAAIhiS1u71auSHxns+zWFtsnYkAgvcj7sBvUJKNNGOd/+XF0cZoCLZH2wDQ1bK6ro/s+vhjK6tO+p1O5NbROHenc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWpRAVTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA7DC4CECE;
	Thu, 12 Dec 2024 17:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734026242;
	bh=0qdxbMc147yDGrvvfbPHKO5B3fLIosVBWCQeN2+sxsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aWpRAVTokCijjyrG3FtKfL2bPtxSJS8RcmEkVuzpTM57pnyulNQWy+nDWLOIJi/f2
	 4LSw/zPw8JRoA3G9Lhtvc0bEksU6CaQZl0LRd3/HJhZGTShGEGKn9HvZ8f0q9Y5FQY
	 6j+RGlh50IuIUMLMWV51N2riBQoc22T/BguTwnUSn5TOMumMSBkWN6/xWgrBX8laQG
	 isOBltaq8JKO7eu5r+BU5N3Mtgn2gCTNh0ZKLuNMXm5aBDMWn+tRIGeFlwx0O1GKkJ
	 5Mzm9f7VntfNcW04kJ8OhJBQ48iyIT26zXNBorgAC9lHWnkhTup4oIH6eWTPuAOs/L
	 HFcbATHUt8MYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: Patch "[PATCH 6.1.y] drm/amd/display: Don't refer to dc_sink in is_dsc_need_re_compute" has been added to the 5.4-stable tree
Date: Thu, 12 Dec 2024 12:57:19 -0500
Message-ID: <20241212122112-b2d907ea9e678cf3@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <2024121217-rephrase-doctrine-7415@gregkh>
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
Backport author: <gregkh@linuxfoundation.org>
Commit author: Wayne Lin <wayne.lin@amd.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: c7e65cab54a8)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  fcf6a49d79923 ! 1:  79f06b6c107fd drm/amd/display: Don't refer to dc_sink in is_dsc_need_re_compute
    @@
      ## Metadata ##
    -Author: Wayne Lin <wayne.lin@amd.com>
    +Author: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
     
      ## Commit message ##
    -    drm/amd/display: Don't refer to dc_sink in is_dsc_need_re_compute
    +    Patch "[PATCH 6.1.y] drm/amd/display: Don't refer to dc_sink in is_dsc_need_re_compute" has been added to the 5.4-stable tree
    +
    +    This is a note to let you know that I've just added the patch titled
    +
    +        [PATCH 6.1.y] drm/amd/display: Don't refer to dc_sink in is_dsc_need_re_compute
    +
    +    to the 5.4-stable tree which can be found at:
    +        http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
    +
    +    The filename of the patch is:
    +         drm-amd-display-don-t-refer-to-dc_sink-in-is_dsc_need_re_compute.patch
    +    and it can be found in the queue-5.4 subdirectory.
    +
    +    If you, or anyone else, feels it should not be added to the stable tree,
    +    please let <stable@vger.kernel.org> know about it.
    +
    +    From jianqi.ren.cn@windriver.com  Thu Dec 12 13:11:21 2024
    +    From: <jianqi.ren.cn@windriver.com>
    +    Date: Wed, 11 Dec 2024 18:15:44 +0800
    +    Subject: [PATCH 6.1.y] drm/amd/display: Don't refer to dc_sink in is_dsc_need_re_compute
    +    To: <wayne.lin@amd.com>, <gregkh@linuxfoundation.org>
    +    Cc: <patches@lists.linux.dev>, <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, <daniel.wheeler@amd.com>, <alexander.deucher@amd.com>, <stable@vger.kernel.org>, <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <Rodrigo.Siqueira@amd.com>, <christian.koenig@amd.com>, <airlied@gmail.com>, <daniel@ffwll.ch>, <Jerry.Zuo@amd.com>, <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
    +    Message-ID: <20241211101544.2121147-1-jianqi.ren.cn@windriver.com>
    +
    +    From: Wayne Lin <wayne.lin@amd.com>
    +
    +    [ Upstream commit fcf6a49d79923a234844b8efe830a61f3f0584e4 ]
     
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
| stable/linux-5.4.y        |  Failed     |  N/A       |

