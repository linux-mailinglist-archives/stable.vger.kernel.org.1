Return-Path: <stable+bounces-119532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05181A445A1
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 17:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E0E16EB78
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 16:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA4F18C92F;
	Tue, 25 Feb 2025 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pbb8D1Zm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16E618C00B
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500026; cv=none; b=EsTweIhBdTZS6H2sVXqlr48UU8R9Ts+wA/brx74x1PyW7jqUFrm910257wGPn1J8cNbdoMzfqebApmii0DlpbgsQL4nb/eYMPJqUXkn/jv5dwMZPbZNxQ7gXVH3NJG9VdiA7wDSkh4ws9TBoTdyvVVJi9UlCxA3iH7/N0MnmnKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500026; c=relaxed/simple;
	bh=MHPMvmqg2hyM4iiTTKPgaZGiYabKk99zfwH6hwgzv3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JD3oJwYG3DDuwT+wApUwqW7Zexb6tuKtQo3Q9foZjngZGKQ+Gh4W72NeyAL63bCIqBNn5pHc+0vrToNUr7Ij639B1YSbDVtdRY2n8E1T0R9LymuIq6axFnUsfLW8u6mKluQe7U/GKLGdt19UT81ZGeWu5X+mMwVyHS9sUd5w24A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pbb8D1Zm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89730C4CEDD;
	Tue, 25 Feb 2025 16:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740500025;
	bh=MHPMvmqg2hyM4iiTTKPgaZGiYabKk99zfwH6hwgzv3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pbb8D1ZmzmTboHlzvtHaGlJjXin2L1q6M3tb5+WWfbV1UCSwQrpcF+8U1LbFaWxxT
	 MiV+OZ5X+T4BiR3ykYIbPboqVhZ48shPkfYtjj9RS8LTKElqUFHFhbd2QsEnqVqOHX
	 jriQhDcB78F9zS0zXK6DOzV6zHCZ25dTTXogQ53LZicjit0Ls+wNpz3XfvryBpyu17
	 KG6+LuYypxGSE4rMCopsTd3a6kQmVHACwvcVDnF0Mf8ajqikSA7xredKwnB372Gszm
	 QnCMUc0t1HSNeNKk1Jc88IfqHIVzSUr0KWgyWvuGsQmHeUQWq+x021Ap7cbE4cduEY
	 YtzwC1HqkkdIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	imre.deak@intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] drm/i915/ddi: Fix HDMI port width programming in DDI_BUF_CTL
Date: Tue, 25 Feb 2025 11:13:44 -0500
Message-Id: <20250225091539-d02fffb8792ca6dd@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250224153112.1959486-2-imre.deak@intel.com>
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

The claimed upstream commit SHA1 (b2ecdabe46d23db275f94cd7c46ca414a144818b) was not found.
However, I found a matching commit: 166ce267ae3f96e439d8ccc838e8ec4d8b4dab73

Note: The patch differs from the upstream commit:
---
1:  166ce267ae3f9 ! 1:  5dcc143132529 drm/i915/ddi: Fix HDMI port width programming in DDI_BUF_CTL
    @@ Metadata
      ## Commit message ##
         drm/i915/ddi: Fix HDMI port width programming in DDI_BUF_CTL
     
    +    commit b2ecdabe46d23db275f94cd7c46ca414a144818b upstream.
    +
         Fix the port width programming in the DDI_BUF_CTL register on MTLP+,
         where this had an off-by-one error.
     
    @@ Commit message
         Link: https://patchwork.freedesktop.org/patch/msgid/20250214142001.552916-3-imre.deak@intel.com
         (cherry picked from commit b2ecdabe46d23db275f94cd7c46ca414a144818b)
         Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
    +    (cherry picked from commit 166ce267ae3f96e439d8ccc838e8ec4d8b4dab73)
    +    [Imre: Rebased on v6.6.y, due to upstream API changes for
    +     XELPDP_PORT_BUF_CTL1() and addition of the XE2LPD_DDI_BUF_D2D_LINK_ENABLE flag]
    +    Signed-off-by: Imre Deak <imre.deak@intel.com>
     
      ## drivers/gpu/drm/i915/display/intel_ddi.c ##
    -@@ drivers/gpu/drm/i915/display/intel_ddi.c: static void intel_ddi_enable_hdmi(struct intel_atomic_state *state,
    - 		intel_de_rmw(dev_priv, XELPDP_PORT_BUF_CTL1(dev_priv, port),
    +@@ drivers/gpu/drm/i915/display/intel_ddi.c: static void intel_enable_ddi_hdmi(struct intel_atomic_state *state,
    + 		intel_de_rmw(dev_priv, XELPDP_PORT_BUF_CTL1(port),
      			     XELPDP_PORT_WIDTH_MASK | XELPDP_PORT_REVERSAL, port_buf);
      
     -		buf_ctl |= DDI_PORT_WIDTH(lane_count);
     +		buf_ctl |= DDI_PORT_WIDTH(crtc_state->lane_count);
    - 
    - 		if (DISPLAY_VER(dev_priv) >= 20)
    - 			buf_ctl |= XE2LPD_DDI_BUF_D2D_LINK_ENABLE;
    + 	} else if (IS_ALDERLAKE_P(dev_priv) && intel_phy_is_tc(dev_priv, phy)) {
    + 		drm_WARN_ON(&dev_priv->drm, !intel_tc_port_in_legacy_mode(dig_port));
    + 		buf_ctl |= DDI_BUF_CTL_TC_PHY_OWNERSHIP;
     
      ## drivers/gpu/drm/i915/i915_reg.h ##
     @@ drivers/gpu/drm/i915/i915_reg.h: enum skl_power_gate {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

