Return-Path: <stable+bounces-121306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA47A5563B
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 20:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56E7174CCF
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 19:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12B026D5B8;
	Thu,  6 Mar 2025 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqhJjonD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1EA26BDB5
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288280; cv=none; b=iPgjrpl00r7Qpaki2sthrDADPuZkNuBnB4Yotpqtz0W7K1nkYr5nXBk9g4Wb6xMPqjXC4qbld7dRBQnLYUBEAdDSzXwDoW/Az9OgYB/SE+fjXEg8fcTLbB5STfJ+Y1cNu2xVwAZL/ljSQOqsk+mPY3/S1AfD8uDeS1jI82Ko1Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288280; c=relaxed/simple;
	bh=CwrI83nDm9ZQVemezBuD6rX0SVEsCsH5PKPM3obNccw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N1gcI0LJ8joS9MndxsaldiRa4PvwOZvZvc5/zCbXMBSoMLgt0R78cOlADO7sNqMeNC7sADK1cDSUb8MqCUI+JH7V8xPFu/GiIsl7pDMLpHDOJbJ15XvYv+UoVCOMe54fSsWHCMeDshYr/npkJ6joKj3iHCMET+5a/gUbm31XbgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqhJjonD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FB8C4CEE0;
	Thu,  6 Mar 2025 19:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741288280;
	bh=CwrI83nDm9ZQVemezBuD6rX0SVEsCsH5PKPM3obNccw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cqhJjonDHidv76HSRQ1Wf6AbzJ7zFRiuGBbNjdzlFn6ZGqQOWFJ+9VPM7nEzf/TES
	 tXrE1zsL6id5W21opsBBgIq4FcZeM8E4zJl+wZ+cBM7+n8+m3O3UCx9kWTdYU76vsO
	 oEc6bsClLqPA3TH9qwhs2Iufvva4YvplmQozfPjMUWO+8MvzLc14pYRvOTuKjTU95N
	 AxWB19R5UTHeWjziuDCQACraTJ/ftl9qTM/B0ZEnAN19qUwpiQ1JK12hG8P6e4dCFx
	 Vr5xQ++VdJG3jonKG+lNbQepr3WIxfFZjLji7oMTK9837/rm1kkmMhoxZuqLi0KtY7
	 karHCa+SAxk3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	imre.deak@intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] drm/i915/dsi: Use TRANS_DDI_FUNC_CTL's own port width macro
Date: Thu,  6 Mar 2025 14:11:18 -0500
Message-Id: <20250306113421-0f42e630c676916b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250305155020.3565643-1-imre.deak@intel.com>
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
ℹ️ Patch is missing in 6.13.y (ignore if backport was sent)
⚠️ Commit missing in all newer stable branches

The upstream commit SHA1 provided is correct: 879f70382ff3e92fc854589ada3453e3f5f5b601

Status in newer kernel trees:
6.13.y | Present (different SHA1: d636772d1796)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  879f70382ff3e ! 1:  616483933e167 drm/i915/dsi: Use TRANS_DDI_FUNC_CTL's own port width macro
    @@ Metadata
      ## Commit message ##
         drm/i915/dsi: Use TRANS_DDI_FUNC_CTL's own port width macro
     
    +    commit 879f70382ff3e92fc854589ada3453e3f5f5b601 upstream.
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

