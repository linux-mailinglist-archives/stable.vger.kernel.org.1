Return-Path: <stable+bounces-128810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 527D7A7F314
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 05:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C6E1898E3D
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 03:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07E48462;
	Tue,  8 Apr 2025 03:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HN22cPv/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7B41DE2A1
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 03:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744081775; cv=none; b=Rc1H0qle6dEwny8R1WTWlNWH+Y3kkyKKLWb5fRFHF7+vMkcggk5j6DHwr0ovhO/hL2dTfM3dyx1KrSC0dy3wtd8u6138mo7M/E4wZ8OmvY9TXKrc5efIwkgojF5h810V1p4uHKLHIjbJj/ZNCCtfTb690gp0eB6yjbL7Tp1msh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744081775; c=relaxed/simple;
	bh=WdNJDsGM1PyNvI1KJDtX9z0M52xLxBNswEB0RXN42AU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P8LssxciVXnGrHt1quBsIerNYCeOzZumkUCkrZ6xhSlk+l400Orn5W7QcbMEzAMs/BNnh1+F5FZIO2vG5h4JISsO66Uaw3CNqJzGipASVLDYDXFsa+Me8efuBckc9iRLZsOCdP8qCOJCzT1aoK2w7Wgw9BnXMT9eh6DoqaJChOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HN22cPv/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF072C4CEEA;
	Tue,  8 Apr 2025 03:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744081774;
	bh=WdNJDsGM1PyNvI1KJDtX9z0M52xLxBNswEB0RXN42AU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HN22cPv/udfj+UkSOr7ZOLUxA5nHqNaQp9kcgiodv+cj/spzyGp/jXzO3Xv2KFkd/
	 sn7jTXaEB4IeYppRgPeiVEKwxGVLCEMiNkF+0WFXI41NjuF98mR5SA9Z2yccThiXFA
	 sHhj9HBhPIj2N0Q2JCQM9Wb0rZ2ZoPXtNreM9oaMwc8t2aZJLrgQHIYd/osHHgMHgX
	 Y5Ih/fXBHqYs68F23QjEw+2Fbi7Rw8ArSMnSzNiUP1tvC6Pv7ubdaQ5MoFF8b1HYfN
	 NDfmSfB87PFYLQfsNK7HMbMX4499kH88Dsq5m6UF4UiGRKG5uSewf/L4mIg54eMRDY
	 QMOta7ScVcWJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	alexander.deucher@amd.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] drm/amd/display: Temporarily disable hostvm on DCN31
Date: Mon,  7 Apr 2025 23:09:32 -0400
Message-Id: <20250407224358-1dac3ac93da4c94a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250407234329.2347358-1-alexander.deucher@amd.com>
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

Found matching upstream commit: ba93dddfc92084a1e28ea447ec4f8315f3d8d3fd

WARNING: Author mismatch between patch and found commit:
Backport author: Alex Deucher<alexander.deucher@amd.com>
Commit author: Aurabindo Pillai<aurabindo.pillai@amd.com>

Note: The patch differs from the upstream commit:
---
1:  ba93dddfc9208 ! 1:  5e9fb61f1028c drm/amd/display: Temporarily disable hostvm on DCN31
    @@ Commit message
         Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
         Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    +    (cherry picked from commit ba93dddfc92084a1e28ea447ec4f8315f3d8d3fd)
    +    Cc: stable@vger.kernel.org
     
      ## drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c ##
     @@ drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c: static const struct dc_debug_options debug_defaults_drv = {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |
| stable/linux-6.13.y       |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |

