Return-Path: <stable+bounces-109278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 250BEA13C76
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 15:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5CC6162B48
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 14:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C96624A7C9;
	Thu, 16 Jan 2025 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ataNAgx2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10DE35968
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038400; cv=none; b=dgntNNMhKB69wBG4/in5mmaV3FmindjdCaSN9tC1hjYBpjVHlY4TJQPdlAUBZat+yK5qpJsEzREtAz+d+xDl/EAhrpPxn0ekgoyn3hS0Fnr6h7800dVSU1pPtwqdcgkFATTQYMEnC2YX4j6kwdR8NWaQ+5J2CCFvVGMmliaen8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038400; c=relaxed/simple;
	bh=R2kMoKyA24eRD1RHTGEEDVjYjVpaVhaxedhphSTpBZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GcogtPkD2mJy9k3tMlw2j9r1XcEhCRpcUR1I2otUwDXwop/k/GlxRpdBZUqirTMH0h1156Kuts4WiZB5Fgxutv0r+SoQ2Oa/u7rNx3oDvfVisX3mTbFALxtq9XyCnFyWeZeWXKnH2JQd6MAKlRUAnEn+rHNvcgF4Mgxqh+0FifE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ataNAgx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD1CC4CED6;
	Thu, 16 Jan 2025 14:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737038399;
	bh=R2kMoKyA24eRD1RHTGEEDVjYjVpaVhaxedhphSTpBZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ataNAgx2Y1oyVukIuP91JH2hWowUlYtCKFWuDIgqDNzCDTr6xXD2aLP82qKPYY5vM
	 AlguSnKT56UomoSWSTplZZRTmkeR3Qt94VlyQJpv5Xdvf31qEtQtUhY4LcCelkV5TR
	 hCBtehH91LX4qmOb4XjAmlhzsvtWRBQzYOo+eyHcQupE3yzl4MIluy8KBOch2R3ddL
	 gcQ7RQHiEMutJW3//cfHV35KrZgl2yf7Dj+yQhxBr9sIQnyzX5h6I7zW5zFIVUt+0h
	 aDsPPadxWbiT5XTwAWdiaL327wHOA3HpqFvPYYQtrfTCLbULNGPm4S5xrwSXw0eZqL
	 vcYRZfX5V8JVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: lanbincn@qq.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] drm/amd/display: Fix out-of-bounds access in 'dcn21_link_encoder_create'
Date: Thu, 16 Jan 2025 09:39:55 -0500
Message-Id: <20250116090832-0f3114d4fa2e7b85@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <tencent_58418A96BD26EB035F32DE1A12670EA6A005@qq.com>
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

The upstream commit SHA1 provided is correct: 63de35a8fcfca59ae8750d469a7eb220c7557baf

WARNING: Author mismatch between patch and upstream commit:
Backport author: lanbincn@qq.com
Commit author: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: f01ddd589e16)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  63de35a8fcfc ! 1:  028f9cc22df4 drm/amd/display: Fix out-of-bounds access in 'dcn21_link_encoder_create'
    @@ Metadata
      ## Commit message ##
         drm/amd/display: Fix out-of-bounds access in 'dcn21_link_encoder_create'
     
    +    commit 63de35a8fcfca59ae8750d469a7eb220c7557baf upstream.
    +
         An issue was identified in the dcn21_link_encoder_create function where
         an out-of-bounds access could occur when the hpd_source index was used
         to reference the link_enc_hpd_regs array. This array has a fixed size
    @@ Commit message
         Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
         Reviewed-by: Roman Li <roman.li@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    +    Signed-off-by: Bin Lan <lanbincn@qq.com>
     
    - ## drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c ##
    -@@ drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c: static struct link_encoder *dcn21_link_encoder_create(
    + ## drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c ##
    +@@ drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c: static struct link_encoder *dcn21_link_encoder_create(
      		kzalloc(sizeof(struct dcn21_link_encoder), GFP_KERNEL);
      	int link_regs_id;
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

