Return-Path: <stable+bounces-112191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AFEA27737
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 17:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEFEA1647E5
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 16:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7A021507D;
	Tue,  4 Feb 2025 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQzm4cex"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0832C181
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738686849; cv=none; b=r3mhpiv4NslO4zRslBpF03BMhjzKKXGXjENMw0nkvyfTHaHz8xyz4VPGYyQTuUaJZ79iqvL4kgJfZVErx5reg/J0Bnl07z3/s1KkHr+PMjkcb6gLBqoUuh6gvPDS1XhKeTGICoK25gm/vN2/ul0vp0PD8Yu+5TsCjfR/z1FmAT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738686849; c=relaxed/simple;
	bh=15jom9+Gzg2HnaiATdsJZ6UWFyUPLb1fxhI/wASrU9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hQyDUkMGkFpcXjg2L2xHyAyF0aO1p4UtzSIPNJwh3oTeA5TSuTu8tzom6YKk7zs0LB5hrpS46L6pGnzSOb+VJv07MViAw+BrZ46l6Q+qilnda3wlEgui7ZGplo+0bozeAu0jr8QU21f5ePKBUpFZSS4mozgc2Zka0Zh3s9BxnrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQzm4cex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC92C4CEDF;
	Tue,  4 Feb 2025 16:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738686848;
	bh=15jom9+Gzg2HnaiATdsJZ6UWFyUPLb1fxhI/wASrU9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZQzm4cextF127Nvsg57kgngUoVC7ck5mwH1tEYyR3xePviB8lJbEDM6YOcVLd2I/D
	 Cd/7OdUsrViqGzhUA35EUiKHCdWlyJ4H35Z7GN6TY2lromHrJla2O9n+oGvv8+nJdI
	 aYimfVuc6r76TDlZjFez6v2SchE+d9y+BxVQ0Jk6DOLtHcAr/LVT+kqhqTeII+48Mx
	 Rv3ZeRPiL9KxCJsFNtBZVyi4HQTweBAPZsnyPvdke12PWVN2hGkOX1jlCwvLJ6vkx4
	 4NKMj6woQAaUC1J7QmZa6kY6SBzEb4c51paBstf09hkbxpcomoi6/5sAiekj8Df8jO
	 EjOzxjVYf9OGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wayne Lin <Wayne.Lin@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] drm/amd/display: Reduce accessing remote DPCD overhead
Date: Tue,  4 Feb 2025 11:34:03 -0500
Message-Id: <20250204111522-1628a2ec44cb6355@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250204101336.2029586-1-Wayne.Lin@amd.com>
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

Found matching upstream commit: adb4998f4928a17d91be054218a902ba9f8c1f93


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  adb4998f4928a ! 1:  0e5ffb81ed4e1 drm/amd/display: Reduce accessing remote DPCD overhead
    @@ Commit message
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
         (cherry picked from commit 4a9a918545455a5979c6232fcf61ed3d8f0db3ae)
         Cc: stable@vger.kernel.org
    +    (cherry picked from commit adb4998f4928a17d91be054218a902ba9f8c1f93)
    +    Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
     
      ## drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h ##
     @@ drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h: struct amdgpu_dm_connector {
    @@ drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c: amdgpu_dm_mst_conne
     +static inline void
     +amdgpu_dm_mst_reset_mst_connector_setting(struct amdgpu_dm_connector *aconnector)
     +{
    -+	aconnector->drm_edid = NULL;
    ++	aconnector->edid = NULL;
     +	aconnector->dsc_aux = NULL;
     +	aconnector->mst_output_port->passthrough_aux = NULL;
     +	aconnector->mst_local_bw = 0;
    @@ drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c: amdgpu_dm_mst_conne
      
      		dc_sink_release(dc_sink);
      		aconnector->dc_sink = NULL;
    --		aconnector->drm_edid = NULL;
    +-		aconnector->edid = NULL;
     -		aconnector->dsc_aux = NULL;
     -		port->passthrough_aux = NULL;
     +		amdgpu_dm_mst_reset_mst_connector_setting(aconnector);
    @@ drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c: dm_dp_mst_detect(st
      
      		dc_sink_release(aconnector->dc_sink);
      		aconnector->dc_sink = NULL;
    --		aconnector->drm_edid = NULL;
    +-		aconnector->edid = NULL;
     -		aconnector->dsc_aux = NULL;
     -		port->passthrough_aux = NULL;
     +		amdgpu_dm_mst_reset_mst_connector_setting(aconnector);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

