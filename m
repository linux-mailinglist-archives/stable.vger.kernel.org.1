Return-Path: <stable+bounces-61259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FF793AE5F
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 11:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7D62B2313E
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 09:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3631509A0;
	Wed, 24 Jul 2024 09:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XlySR6am"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D602C1A5;
	Wed, 24 Jul 2024 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721812286; cv=none; b=dqVPJnGkfDKU7NG2QPPfAfemLFUrSeO6U63lLoxIVEdM7irc7Dr2hg/wlmTsjPol/bFBjxZB+UzOOuNFhSXhlGyPbWIZ/fCLq9SM67D+4CBJIVts/9P7t9mpfSu0kw2VAR5jk1P/Dluk2QGqXSI2LbH0MapYRUlj0V9iMQcrQJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721812286; c=relaxed/simple;
	bh=v7lWae4MKXSyR/ZlzyM8ha8K/WcFnzmB9NS7KcHEi3w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A13/GqcpIeur6cfkw4C/TDhrUPawm2TrdUFwCa59SjUGv9nMMSWjzWJCsbTZ6RsUPjaJPNie+tysp67cgSrt4if/8BNeG09azc1icyEbrJhNBAz6G1BSNX1FtZQfLEJF+W4ULjm/mNDPi3PPtc3l1SSpi2ZP3CgTZ6JZDFwObQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XlySR6am; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721812285; x=1753348285;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=v7lWae4MKXSyR/ZlzyM8ha8K/WcFnzmB9NS7KcHEi3w=;
  b=XlySR6am58/SSmOQzCSwC7/NHp9abrxgKNEVTbZ1zV/09K3/0GfvH67f
   55CfDvRAyXJA0jGwxIM777bHx0K8hIkZNbibPIXP8D3Twhuvz26+SmiOC
   VSox6lH/y3Dh2MMeJxkhgB1OiDjc0ae5WyBmiY6XEUhcNPnrG3n5L+8ys
   GiQNVLNA0Q6uyEKxkMoXaRboC74DZtkZ1EOv8s1IAVU9QsV2btHUMeptq
   jOSVcgV0P2LdEDjN+C+hmQuLsKqk5VpipcBFhku0NgS1q73TA22E+iM3g
   6udLzqqIIDos2OoAf+2qLdTWjC54oBqkP47Wt+NNv2GXh6dwsH1tUaI6X
   A==;
X-CSE-ConnectionGUID: Y76kQWeFRqG0A9TqwUmfxQ==
X-CSE-MsgGUID: G+xsMQtMSZeEbtf/h9nzBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19287634"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="19287634"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 02:11:24 -0700
X-CSE-ConnectionGUID: M+bHBMbRRZmCCd16bwltcw==
X-CSE-MsgGUID: PAErH09yRPCJKgGJJ7Ye+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="56839751"
Received: from iklimasz-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.170])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 02:11:19 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ma Ke <make24@iscas.ac.cn>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 daniel@ffwll.ch, noralf@tronnes.org, sam@ravnborg.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Ma Ke
 <make24@iscas.ac.cn>, stable@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] drm/client: fix null pointer dereference in
 drm_client_modeset_probe
In-Reply-To: <20240724065155.1491111-1-make24@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240724065155.1491111-1-make24@iscas.ac.cn>
Date: Wed, 24 Jul 2024 12:11:15 +0300
Message-ID: <87o76nf93g.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 24 Jul 2024, Ma Ke <make24@iscas.ac.cn> wrote:
> In drm_client_modeset_probe(), the return value of drm_mode_duplicate() is
> assigned to modeset->mode, which will lead to a possible NULL pointer
> dereference on failure of drm_mode_duplicate(). Add a check to avoid npd.
>
> Cc: stable@vger.kernel.org
> Fixes: cf13909aee05 ("drm/fb-helper: Move out modeset config code")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v2:
> - added the recipient's email address, due to the prolonged absence of a 
> response from the recipients.
> - added Cc stable.
> ---
>  drivers/gpu/drm/drm_client_modeset.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
> index 31af5cf37a09..cca37b225385 100644
> --- a/drivers/gpu/drm/drm_client_modeset.c
> +++ b/drivers/gpu/drm/drm_client_modeset.c
> @@ -880,6 +880,9 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
>  
>  			kfree(modeset->mode);
>  			modeset->mode = drm_mode_duplicate(dev, mode);
> +			if (!modeset->mode)
> +				continue;
> +

Why would you continue in this case?

BR,
Jani.

>  			drm_connector_get(connector);
>  			modeset->connectors[modeset->num_connectors++] = connector;
>  			modeset->x = offset->x;

-- 
Jani Nikula, Intel

