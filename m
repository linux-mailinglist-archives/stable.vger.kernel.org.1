Return-Path: <stable+bounces-96156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 875269E0BD5
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 20:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 560851619B0
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 19:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191E71DE3CE;
	Mon,  2 Dec 2024 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCHpUGkf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA61A1DE3BD
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 19:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166960; cv=none; b=ak6A75/4c1q1U1k3kQBhHYziqsuS+QPf8RNZoG7N25fRm1oelNqxk4iPWxfDTOMaxIKxYATTFOzBT4jyLWpgJ+ENMOBIf7SvVjRHqc1pFzZujl5ByYf/N+71EFJSCXdV6HWDS2LfplPwyRetgZg2QnrVrW7N1ib+1cjO1nhvg/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166960; c=relaxed/simple;
	bh=1cXnosBnv28vQDSUelihnaI0LMUFMS6ZF8S5yo3Z6Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1n+R+o3THKASxX1+L9XhkDR4ANyarwQTW5ipmH5ycOd+d3ZOJLff6jmk0Wv57YbQG/tikbsWdRMIytypQ6n9y/gsEWczC1ocDo20ylyN7L8TkD4PTUNKYRhj2FURt5+k9j+0NHvhZQC/G4E+aDd9JxMOmk4NrhRWrfDGoVnzAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCHpUGkf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E56C4CED1;
	Mon,  2 Dec 2024 19:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733166960;
	bh=1cXnosBnv28vQDSUelihnaI0LMUFMS6ZF8S5yo3Z6Vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fCHpUGkfhLwGPFfdN38ALbVo0zDx6p9/IkNn1FORA92BO0da8Q1Lc6lpbYlG0mzkT
	 x7kCFyS+cUhcRZ5OjONalog3cgbrOJR+HAiTQWwTbUee5+lP8rkiqZZU23CQ3z8O8r
	 pbZp3iY+j47b1oJ3yzc+1iDwgEDUa++yS1gFlD9WeYHISOcJe4hml5dQqryXaPK7ZW
	 i10yslF6gSxOl5opcHgUFPdd6CcicALqJ2zOhcCPUZfVYss6ivEpEhKwLfRnCMczlw
	 hZor7plJd629fmaxFJtVTEJpswTqioFGT4CMQslHlW4n51D9oeO++t1NsXTi2p21I6
	 iKpeDuDusgZlQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/2] drm/amd/display: Skip Invalid Streams from DSC Policy
Date: Mon,  2 Dec 2024 14:15:58 -0500
Message-ID: <20241202133950-efd84bdcc903fe92@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202172833.985253-1-alexander.deucher@amd.com>
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

Found matching upstream commit: 9afeda04964281e9f708b92c2a9c4f8a1387b46e

WARNING: Author mismatch between patch and found commit:
Backport author: Alex Deucher <alexander.deucher@amd.com>
Commit author: Fangzhi Zuo <Jerry.Zuo@amd.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: d3c4a1c71521)

Note: The patch differs from the upstream commit:
---
1:  9afeda0496428 ! 1:  e77a231c8dcab drm/amd/display: Skip Invalid Streams from DSC Policy
    @@ Commit message
         Streams with invalid new connector state should be elimiated from
         dsc policy.
     
    +    Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3405
         Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
         Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
         Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
         Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    +    (cherry picked from commit 9afeda04964281e9f708b92c2a9c4f8a1387b46e)
    +    Cc: stable@vger.kernel.org
     
      ## drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c ##
     @@ drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c: static int compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.11.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |
| stable/linux-4.19.y       |  Failed     |  N/A       |

