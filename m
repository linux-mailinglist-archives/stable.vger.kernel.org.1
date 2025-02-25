Return-Path: <stable+bounces-119542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC9AA445C3
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 17:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948F63B9943
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 16:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3847118B47E;
	Tue, 25 Feb 2025 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGDiYYK3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8642FB2
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500041; cv=none; b=SpGNhAzP9KkiS0Yllld6842ZLXJ5rWMozcC4t380Yr9c6QrUqdRWLac00NwBv09TNSVV3b3iBTxnHClgAW6DK29uM1pPhCzke+jV8H9nzAvquZn9KdzRuiAomxruNqzP/ebVoKmH1fp+BVGMnFG5WEgXo4Mvt90mGgAzyE6oiZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500041; c=relaxed/simple;
	bh=HM3Zx30yfADS2rq3klVofQe3dnpaZ21pG/eh+5u2qEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pt2f32Any2fAg3OdNy5mIRbX3jden/PHHGWtB+z0aQKn5lqzqqgzewWPP16t3DkPxSasnrTjkM4JnagtuD4jO+PTgWK0yiszum3na6fORmAzfxowFkeYgb4jro2CXfSrFhnaAUnSvp/bhtFNdCDINU1xJjr2mGvBNnGQlMd7VNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGDiYYK3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A42C4CEE6;
	Tue, 25 Feb 2025 16:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740500040;
	bh=HM3Zx30yfADS2rq3klVofQe3dnpaZ21pG/eh+5u2qEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UGDiYYK3j1/ENakqglS6P1UsCcCLk8P6gFKGqoXlU3JoFp+tTj9pR3lMDUQxgEv4V
	 Y+OmL3KPBYqH2NuOO7PgYvXXjzB6SNXTRbSO/UL5byo/iEmCL2is/nPIzInEBbKDu8
	 m2cHAPANyU7ugFqo8IPII+hT4PiAnoVLIhfwWwTjfjFWMn4Ffb/WdNMxnRU5vzDeXz
	 BndVvrGPtHmUl4yoz0eHv64ED5hQtHghYNYoJU+yKkjrLGAE3xoJFFAwj4y+3LcHDA
	 yDD/VwGUf+jTVC70N8V4ccnJJQDW+EmQoHI9EtHM/bHX9PiFZm43cjDxavd5yjnzlj
	 TwZdsE0FOf1UA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	imre.deak@intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] drm/i915/dsi: Use TRANS_DDI_FUNC_CTL's own port width macro
Date: Tue, 25 Feb 2025 11:13:59 -0500
Message-Id: <20250225093241-e9a9066e5762eeb7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250224153112.1959486-1-imre.deak@intel.com>
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

The claimed upstream commit SHA1 (76120b3a304aec28fef4910204b81a12db8974da) was not found.
However, I found a matching commit: 879f70382ff3e92fc854589ada3453e3f5f5b601

Note: The patch differs from the upstream commit:
---
1:  879f70382ff3e ! 1:  b3874f246c67b drm/i915/dsi: Use TRANS_DDI_FUNC_CTL's own port width macro
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
    +    [Imre: Rebased on v6.6.y, due to upstream API changes for intel_de_read(),
    +     TRANS_DDI_FUNC_CTL()]
    +    Signed-off-by: Imre Deak <imre.deak@intel.com>
     
      ## drivers/gpu/drm/i915/display/icl_dsi.c ##
     @@ drivers/gpu/drm/i915/display/icl_dsi.c: gen11_dsi_configure_transcoder(struct intel_encoder *encoder,
    + 
      		/* select data lane width */
    - 		tmp = intel_de_read(display,
    - 				    TRANS_DDI_FUNC_CTL(display, dsi_trans));
    + 		tmp = intel_de_read(dev_priv, TRANS_DDI_FUNC_CTL(dsi_trans));
     -		tmp &= ~DDI_PORT_WIDTH_MASK;
     -		tmp |= DDI_PORT_WIDTH(intel_dsi->lane_count);
     +		tmp &= ~TRANS_DDI_PORT_WIDTH_MASK;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

