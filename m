Return-Path: <stable+bounces-119541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0058DA445B2
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 17:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C32B1890B2F
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 16:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B8F18C00B;
	Tue, 25 Feb 2025 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usc1DCo3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718D218F2FB
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500039; cv=none; b=ezYU4QjmPcsLW3tE7Tft16kYNowo/AWLUXcaQv3ZbAESG0f6hYexQL99fvIxrP+E/YVTgjs1MJ7bUHnrx6g6XOLx8ejZuheEsTjh7OKwzwt+5uGoBnvc11UFsw8q73FFrFX8zliClVU8nS4YkRQ8TwmSZx3isFKDuiCMXvSfEBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500039; c=relaxed/simple;
	bh=XCgxzaSx8WFfm/RIvYD2S/aqoisnaZFd7nbgd4KyKDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKz3PBvOT2FpYj4XfQpyfGLMm9FspFYOdW9tzn4VlTZlSPUgTx0s57dN0S9bs1hPI6vvZ6taEbygoIZwxWUHPHEmVwTA43S6JyfpEuT9MSUvLg1obHG4zYYVDMKUcq8pX67Ldkv/PaLsQ2PLYRO41Zbh/+Z7hSDV/a6NQ5ivY5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usc1DCo3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A4AC4CEDD;
	Tue, 25 Feb 2025 16:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740500038;
	bh=XCgxzaSx8WFfm/RIvYD2S/aqoisnaZFd7nbgd4KyKDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=usc1DCo3Jjo8F8UM/KKAu4Ni4FsqLZ84L3rgXA02O6ZAhv5Zg4bvD8CQpBi3v1PDF
	 sqnGakXqME4emdhQPGKLKA6QwSpPfy3hkhKciwt0fODbOiOezTjeQ8wUaXYV2Wl2+X
	 z+QwYyQaesIFK649/LFhUCrWy1oIyB16CBt+FWMyOHT5jit9MsE2/JoF41kQLHj7h0
	 CYte89Rg3SMyqbYUntRiARjdD2k9Rb+y4Zkpl2HEDETu192tZoA+QYMD0CPdUoeXXc
	 kbKxLS0poP4gidAKwYJ0Cd/zqgYIm1egSJv+zKXgMTn38g8Q2eLASu0NqDg9z4sN9R
	 2uNQAnHvXSxwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	imre.deak@intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] drm/i915/dsi: Use TRANS_DDI_FUNC_CTL's own port width macro
Date: Tue, 25 Feb 2025 11:13:57 -0500
Message-Id: <20250225092150-aa652f5ea80fe710@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250224153910.1960010-1-imre.deak@intel.com>
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
⚠️ Provided upstream commit SHA1 does not match found commit
ℹ️ Patch is missing in 6.13.y (ignore if backport was sent)
⚠️ Commit missing in all newer stable branches

The claimed upstream commit SHA1 (76120b3a304aec28fef4910204b81a12db8974da) was not found.
However, I found a matching commit: 879f70382ff3e92fc854589ada3453e3f5f5b601

Status in newer kernel trees:
6.13.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  879f70382ff3e ! 1:  087834a498981 drm/i915/dsi: Use TRANS_DDI_FUNC_CTL's own port width macro
    @@ Metadata
      ## Commit message ##
         drm/i915/dsi: Use TRANS_DDI_FUNC_CTL's own port width macro
     
    +    commit 76120b3a304aec28fef4910204b81a12db8974da upstream.
    +
         The format of the port width field in the DDI_BUF_CTL and the
         TRANS_DDI_FUNC_CTL registers are different starting with MTL, where the
         x3 lane mode for HDMI FRL has a different encoding in the two registers.
    @@ Commit message
         Link: https://patchwork.freedesktop.org/patch/msgid/20250214142001.552916-2-imre.deak@intel.com
         (cherry picked from commit 76120b3a304aec28fef4910204b81a12db8974da)
         Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
    +    (cherry picked from commit 879f70382ff3e92fc854589ada3453e3f5f5b601)
    +    [Imre: Rebased on v6.12.y, due to upstream API changes in
    +     intel_de_read(), TRANS_DDI_FUNC_CTL()]
    +    Signed-off-by: Imre Deak <imre.deak@intel.com>
     
      ## drivers/gpu/drm/i915/display/icl_dsi.c ##
     @@ drivers/gpu/drm/i915/display/icl_dsi.c: gen11_dsi_configure_transcoder(struct intel_encoder *encoder,
      		/* select data lane width */
    - 		tmp = intel_de_read(display,
    - 				    TRANS_DDI_FUNC_CTL(display, dsi_trans));
    + 		tmp = intel_de_read(dev_priv,
    + 				    TRANS_DDI_FUNC_CTL(dev_priv, dsi_trans));
     -		tmp &= ~DDI_PORT_WIDTH_MASK;
     -		tmp |= DDI_PORT_WIDTH(intel_dsi->lane_count);
     +		tmp &= ~TRANS_DDI_PORT_WIDTH_MASK;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

