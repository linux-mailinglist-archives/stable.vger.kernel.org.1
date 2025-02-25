Return-Path: <stable+bounces-119544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A9AA448C8
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 18:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4336882F58
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 17:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0200119922F;
	Tue, 25 Feb 2025 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g+67o0g6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D82197A7E
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504642; cv=none; b=id7cqfOPBBZAnRwI5YLaX5mjmu6desW1MzsVhdp4P96D9BGaYdGSkFe5/aweuz08Sj0S/4AwVGsTFd41DeVEr+3RQmtRSmKX4TMiIwE3qoPXM7ug30w4TW5cUXeHFztG4fKGwqTDR2aTGeMHMuhdmmInUBCUX7V7XGfvZzJwS4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504642; c=relaxed/simple;
	bh=qVre7epAnWHLovr7ts5O9ztnvBU3rzLXD/XcD7+ERRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqBcP955EW/WqzyCXVRUxdox0scrHMmdI1IKqGPhh3TXBoRhnUyo4Tfo/7OMXNTCVvfHKQYTfox7Jipak8FEQcCwoMFf7JqQix7XvSIm6nhoVLzjsM9WBX3f4TI8aySB+ZhwccNOLSQuIHZGSsxDMbaEnFrikPwLKnHFlyBwK0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g+67o0g6; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740504641; x=1772040641;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qVre7epAnWHLovr7ts5O9ztnvBU3rzLXD/XcD7+ERRs=;
  b=g+67o0g6RRETc20gt7ERKPl7GjmiSXSofW/c44tngTYRHvDOnDBIa5OA
   LDZx5kot2L7/lz9yeYOj2NqGE4gbDdskikbVFc6who/zFfIwIPJbgOPxV
   SgraPcrZ5v69EOe0i8iY7vy6srh2L3aFjinzBkWztq9kAa7muWW3Fhyvk
   H/mjE4ksI+ZYq3pg7m5J1ee3U5pF7Na3AaP+CQFj5aiLFj6Fq4JAm61dJ
   64SjKe73DUjG6PLzPl46jcqDIypOdMkyKqBid3EIrpODdZw0nYpBTqTSS
   luu8toGVQQt78lvbKuRH+3wv70e4xZO5xfNguEWjK3+0cK21BPNZgf3lJ
   g==;
X-CSE-ConnectionGUID: dV89tso8RjeimxuX9Lt6Wg==
X-CSE-MsgGUID: unE9uu5ERByxi4dRrDCJww==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41525563"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41525563"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 09:30:40 -0800
X-CSE-ConnectionGUID: DMBSrcnhSe+H//oBhwNplw==
X-CSE-MsgGUID: h2kDOgo8Rw+vn7zsb4NwsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="116441136"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 09:30:39 -0800
Date: Tue, 25 Feb 2025 19:31:40 +0200
From: Imre Deak <imre.deak@intel.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.6.y] drm/i915/dsi: Use TRANS_DDI_FUNC_CTL's own port
 width macro
Message-ID: <Z73-fBszCDsobXWJ@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <20250224153112.1959486-1-imre.deak@intel.com>
 <20250225093241-e9a9066e5762eeb7@stable.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250225093241-e9a9066e5762eeb7@stable.kernel.org>

Hi,

On Tue, Feb 25, 2025 at 11:13:59AM -0500, Sasha Levin wrote:
> [ Sasha's backport helper bot ]
> 
> Hi,
> 
> Summary of potential issues:
> ⚠️ Provided upstream commit SHA1 does not match found commit
> 
> The claimed upstream commit SHA1 (76120b3a304aec28fef4910204b81a12db8974da) was not found.
> However, I found a matching commit: 879f70382ff3e92fc854589ada3453e3f5f5b601

thanks for the report. The original commit is 76120b3a304a (see [1]),
but indeed it's not upstream yet, as it was merged to the drm-intel-next
branch which will be only part of a later drm pull request.

Since the change is a fix it was also cherry-picked to drm-intel-fixes
as 879f70382ff3 and merged upstream via an earlier drm-fixes pull
request.

The same happened in two other backports I sent (see [2] and [3]).

> Note: The patch differs from the upstream commit:

The patches differ from the upstream ones, as they had to be rebased due
to upstream changes that are not in the stable trees.

Is it ok if I resend this and [2], [3], with the commit ... upstream
lines changed to the SHA1 actually upstream (166ce267ae3f for [2] and
879f70382ff3 for this and [3])?

Thanks,
Imre

[1] https://cgit.freedesktop.org/drm-intel/commit/?h=drm-intel-next&id=76120b3a304aec28fef4910204b81a12db8974da
[2] https://lore.kernel.org/stable/20250225091539-d02fffb8792ca6dd@stable.kernel.org
[3] https://lore.kernel.org/stable/20250225092150-aa652f5ea80fe710@stable.kernel.org

> ---
> 1:  879f70382ff3e ! 1:  b3874f246c67b drm/i915/dsi: Use TRANS_DDI_FUNC_CTL's own port width macro
>     @@ Metadata
>       ## Commit message ##
>          drm/i915/dsi: Use TRANS_DDI_FUNC_CTL's own port width macro
>      
>     +    commit 76120b3a304aec28fef4910204b81a12db8974da upstream.
>     +
>          The format of the port width field in the DDI_BUF_CTL and the
>          TRANS_DDI_FUNC_CTL registers are different starting with MTL, where the
>          x3 lane mode for HDMI FRL has a different encoding in the two registers.
>     @@ Commit message
>          Link: https://patchwork.freedesktop.org/patch/msgid/20250214142001.552916-2-imre.deak@intel.com
>          (cherry picked from commit 76120b3a304aec28fef4910204b81a12db8974da)
>          Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
>     +    (cherry picked from commit 879f70382ff3e92fc854589ada3453e3f5f5b601)
>     +    [Imre: Rebased on v6.6.y, due to upstream API changes for intel_de_read(),
>     +     TRANS_DDI_FUNC_CTL()]
>     +    Signed-off-by: Imre Deak <imre.deak@intel.com>
>      
>       ## drivers/gpu/drm/i915/display/icl_dsi.c ##
>      @@ drivers/gpu/drm/i915/display/icl_dsi.c: gen11_dsi_configure_transcoder(struct intel_encoder *encoder,
>     + 
>       		/* select data lane width */
>     - 		tmp = intel_de_read(display,
>     - 				    TRANS_DDI_FUNC_CTL(display, dsi_trans));
>     + 		tmp = intel_de_read(dev_priv, TRANS_DDI_FUNC_CTL(dsi_trans));
>      -		tmp &= ~DDI_PORT_WIDTH_MASK;
>      -		tmp |= DDI_PORT_WIDTH(intel_dsi->lane_count);
>      +		tmp &= ~TRANS_DDI_PORT_WIDTH_MASK;
> ---
> 
> Results of testing on various branches:
> 
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-6.6.y        |  Success    |  Success   |


