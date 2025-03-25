Return-Path: <stable+bounces-126030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4753A6F42E
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA1E3B8F3C
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C5F1F0E31;
	Tue, 25 Mar 2025 11:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVRBuf7s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E43255E47
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902441; cv=none; b=tE6DMLEgPvf4MIHq6dbavZyObekqUAB4msvKrc5//t/v7yHk9ZT2rVV3Jyb+jqp0LFYWbI5IiFdH4bsOqFYUorojh8y7oIKnESGgwS7rej1rXFBi95+MHu3om62IGKYJ42vShCNGC8HEi3Or0xyygApqYVyL76R+dIRcK45Njhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902441; c=relaxed/simple;
	bh=hKJ4wklozwRYxkWxbUPl5nE3mQ4xyAdYZhaxpr34dxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/0leOCfTee9NGEeBdf0bHQZhAK4DObphdI1xJ8N3Nk7Ci3jvvQ1HBbJ1RPu6VOxT5NOIewle+Plo5UI6iyBwCSxL499YhHzwjKxFU2ogNXS67D0MD53n36REVst/P7BlNqPOU6RP/W/9pznjxlTMLi/P8V6kq8nQU1tYOUcm8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVRBuf7s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E86C4CEE4;
	Tue, 25 Mar 2025 11:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902441;
	bh=hKJ4wklozwRYxkWxbUPl5nE3mQ4xyAdYZhaxpr34dxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MVRBuf7s9sdnr3FHrpsZopJ+2c3fu8xBualIX23I4qJEjc+o6wFWdiQ/NQq9berLn
	 xieuanW9PJl0Uk1qZiktFftgp0Vgm+aHzBq6KWRTAPBflHGtsOfAnobLGKA4lLl+Gx
	 n+5eBOf/NORI8LsYEydpZ1owEerfE5ifK6MJMGtZXlKCKd+vnA1IVoCvxksNQS+jUi
	 3CYheMP/QGh2oXvqdaMaezWDuE+hJQO+M7pT1dtJTqHg/804P2bGZtLFbl9JzFomFb
	 DeDTKs/Q1Hv6utgTXicrvkqDi0FbykigFCDZJ+BaIkhfOrtgNLeuhx2HsrWKjcKlM6
	 W6vhRiXXKLs4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	superm1@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] drm/amd/display: Use HW lock mgr for PSR1 when only one eDP
Date: Tue, 25 Mar 2025 07:33:59 -0400
Message-Id: <20250324234036-5755290f6b437c1e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250324155629.2588451-1-superm1@kernel.org>
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

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: acbf16a6ae775b4db86f537448cc466288aa307e

WARNING: Author mismatch between patch and found commit:
Backport author: Mario Limonciello<superm1@kernel.org>
Commit author: Mario Limonciello<mario.limonciello@amd.com>

Status in newer kernel trees:
6.13.y | Not found
6.12.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  acbf16a6ae775 ! 1:  798c6bedbaa1a drm/amd/display: Use HW lock mgr for PSR1 when only one eDP
    @@ Commit message
         Fixes: f245b400a223 ("Revert "drm/amd/display: Use HW lock mgr for PSR1"")
         Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3965
         Reviewed-by: ChiaHsuan Chung <chiahsuan.chung@amd.com>
    -    Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
         Signed-off-by: Alex Hung <alex.hung@amd.com>
         Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    -    (cherry picked from commit ed569e1279a3045d6b974226c814e071fa0193a6)
         Cc: stable@vger.kernel.org
    +    (cherry picked from commit acbf16a6ae775b4db86f537448cc466288aa307e)
    +    [superm1: Adjust for missing replay support bfeefe6ea5f1,
    +              Adjust for dc_get_edp_links not being renamed from get_edp_links()]
    +    Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
     
      ## drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c ##
     @@ drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c: bool should_use_dmub_lock(struct dc_link *link)
    - 	if (link->replay_settings.replay_feature_enabled)
    + {
    + 	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
      		return true;
    - 
    ++
     +	/* only use HW lock for PSR1 on single eDP */
     +	if (link->psr_settings.psr_version == DC_PSR_VERSION_1) {
     +		struct dc_link *edp_links[MAX_NUM_EDP];
     +		int edp_num;
     +
    -+		dc_get_edp_links(link->dc, edp_links, &edp_num);
    ++		get_edp_links(link->dc, edp_links, &edp_num);
     +
     +		if (edp_num == 1)
     +			return true;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

