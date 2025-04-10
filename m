Return-Path: <stable+bounces-132152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1AFA8490C
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D7C4664AB
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2601EDA36;
	Thu, 10 Apr 2025 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l82VkECR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE931E5201
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300439; cv=none; b=NGvXOjA98S8ipbWpoaBblwjEk2qVh+fXjKHRgEvsM8oLgZUh3W1MNZLLFDKtRYKSa3Jo/0CVtidk00jJizJQwEGTkVS7o+LShGE2ieJxRN6hHDJdjSMYOxq0xS+qj/p3FasFBYRXRFgU3d5S0wvZfpDwPw75lOYU1J97whCj6x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300439; c=relaxed/simple;
	bh=Cwln+eiXKtXXfFMn/Pl1dorn1RUuZjP4OdEk5UtOhLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mvJtmfH0F/XpduOWRNOfJXPBpyg0MuKuin+e22w4GSCRQahAOEUyXCiq18ouCn6ELD2REzXLey1ThtaDbKSzF/0Dk35xhzNYjC6e3F8qhsYif+R8T5/JwNU/SZ72z7eKyORP6c1PSO+6vfwwDBYg2vgo6bFd+Pv6yIARKAe7y04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l82VkECR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D2AC4CEDD;
	Thu, 10 Apr 2025 15:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300439;
	bh=Cwln+eiXKtXXfFMn/Pl1dorn1RUuZjP4OdEk5UtOhLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l82VkECRuQ+m2ySZ+SUQDZsN509PMVIJL6SlaidKsIHwyvlQ7G6wYRRFLbrEBpohD
	 yiu931YAYoOvrmD45jO9/w104uPgoJxqfrYH/7YE/3T3ZS5ZQ91OZUN9TdRhKauusb
	 Bs1rrvob3xPAugPRjiN3T6HIUfW69VyrRfC7EHJO/j3yTO8ugfWmTGcpo6EvT8FMJp
	 kWt/+9FrpwfGkNEpg4KTCdxGHDSUzSV9x1NyPVWE4e/Bpr1q+IZ7t65kKgI6l3XfyM
	 4z6bbxxNVtnGcXu/RSevNgSQNX3vbfOJaFeCYGjgjTe2SRRVtaZItanOCsoflC0AiU
	 3UJFN58WRpYFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] drm/amd/pm: Fix negative array index read
Date: Thu, 10 Apr 2025 11:53:57 -0400
Message-Id: <20250409230333-75c796b94bb61fb9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408005606.3361967-1-jianqi.ren.cn@windriver.com>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: c8c19ebf7c0b202a6a2d37a52ca112432723db5f

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Jesse Zhang<jesse.zhang@amd.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 4711b1347cb9)
6.1.y | Present (different SHA1: 60f4a4bc3329)

Note: The patch differs from the upstream commit:
---
1:  c8c19ebf7c0b2 ! 1:  81f567e4957da drm/amd/pm: Fix negative array index read
    @@ Metadata
      ## Commit message ##
         drm/amd/pm: Fix negative array index read
     
    +    [ Upstream commit c8c19ebf7c0b202a6a2d37a52ca112432723db5f ]
    +
         Avoid using the negative values
         for clk_idex as an index into an array pptable->DpmDescriptor.
     
    @@ Commit message
         Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
         Reviewed-by: Tim Huang <Tim.Huang@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    +    [Minor conflict resolved due to code context change.]
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c ##
     @@ drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c: static int navi10_get_current_clk_freq_by_table(struct smu_context *smu,
    @@ drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c: static int navi10_get_current_c
      }
      
      static inline bool navi10_od_feature_is_supported(struct smu_11_0_overdrive_table *od_table, enum SMU_11_0_ODFEATURE_CAP cap)
    -@@ drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c: static int navi10_emit_clk_levels(struct smu_context *smu,
    - 		if (ret)
    - 			return ret;
    - 
    --		if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
    -+		ret = navi10_is_support_fine_grained_dpm(smu, clk_type);
    -+		if (ret < 0)
    -+			return ret;
    -+
    -+		if (!ret) {
    - 			for (i = 0; i < count; i++) {
    - 				ret = smu_v11_0_get_dpm_freq_by_index(smu,
    - 								      clk_type, i, &value);
     @@ drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c: static int navi10_print_clk_levels(struct smu_context *smu,
      		if (ret)
      			return size;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

