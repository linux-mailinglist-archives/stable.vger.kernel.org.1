Return-Path: <stable+bounces-99960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA499E76BD
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 18:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D03282850
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 17:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B841F3D49;
	Fri,  6 Dec 2024 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHru0aGk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA541206274
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505084; cv=none; b=Rq+knjGTHenwBp6Z3RHjGhWttnKvNRnw5fTX5j+ThnY8G3dAi8B/iSyX/gB0k9iB6Rep6mDwhIMLCwCJVgSD/LPvVuOL0l9+qWZnnP+RRRQh3zSKR3AeNwjzJFdb/+9iQopf59vBNE1TwFZ2wJwwiTrTbFqKT0LZIhNKtb4YGTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505084; c=relaxed/simple;
	bh=lXaOmmXJLtItvRsbm5rcUkl5oIOt5Fe5w1WzRydAVh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqgNpWRFMrrlKj485quM4NVLfUNta1Hz+h4ypnds/6yupcroCC9ywq89AXUfC6qXP2iczeG3nGF3DHfjfxUF/oKfwRj00xr56/qLtNIVwMOEi5l4JAQcJ3lAivoPdJlM9OCao+Pf8LmdA8on+6t9Yf/v1dFlFRXXywsfmQ1SuBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHru0aGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC10C4CED1;
	Fri,  6 Dec 2024 17:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505084;
	bh=lXaOmmXJLtItvRsbm5rcUkl5oIOt5Fe5w1WzRydAVh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aHru0aGkaxFuubTSVnV3LOaDaJkXQdq/YEFOG64CYFrkg+4fgorn4drsjB7Ze2ZeV
	 wSNqO4ov3D/oeJ/Rg2hiu3AfHtclGpK06Bh9tTX86Vs2evuhGWP3UrXtm6L95rrpXv
	 MzX5msopQA27KArbM0NaJ0v6TbzfBHCjUtr8wsenFLQZMWPshV/wK4sA5JiJPCTEyz
	 D7m10RwHsdNPN8f3/Ku5nMx5S/q/3HK3B0FBa+QtvKLK01jN8LROBLsb4gXVO4UxIn
	 +xr/gQZljYFIt8MDOvKJhPi64d4YXX0LqgT9XQZ8CnGHX5SXJu3aYd8wf83J8up4eY
	 7QZpDrSldeLMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] drm/amd/display: Don't refer to dc_sink in is_dsc_need_re_compute
Date: Fri,  6 Dec 2024 12:11:22 -0500
Message-ID: <20241206093913-7b2a89a36754689c@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206100629.1243468-1-jianqi.ren.cn@windriver.com>
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
6.6.y | Present (different SHA1: 77b96aa2e06c)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  fcf6a49d79923 ! 1:  5ff7cd9148131 drm/amd/display: Don't refer to dc_sink in is_dsc_need_re_compute
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

