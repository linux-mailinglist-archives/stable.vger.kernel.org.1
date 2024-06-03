Return-Path: <stable+bounces-47890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 401128D8AFD
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 22:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69AF61C21748
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 20:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7549813B582;
	Mon,  3 Jun 2024 20:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c14NGIrZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7B0136674
	for <stable@vger.kernel.org>; Mon,  3 Jun 2024 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717447345; cv=none; b=WZid9m1Olz6OZ7GBcFDRW5vJSkXN1yzuGzPhLqcNziATExWr7sV9vqlfHkDJrVIZv1MnDJz63EyTzJcyXFSE/guibY5+TYbMPq+v/pM05l5zAIiP32fDrRAxtbkLF4fxIlf7ojLww8SgjUU2jCet7E4vpLcvPZCrJi08w9fZflI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717447345; c=relaxed/simple;
	bh=otnxhcfSt5UbL4O0zIn8rZEGWLr567tpTzedaNns2CY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ONJFh4XO83ekcynCJuwli+FVvQb1WjB9VpcqdolCeOu+n+Yt77ucyTU94j/okjO+3yWKhVU3BhKITZkW0DpJNNSGbr12Xm2JoD08i3EGzvYIc68BfEshlT2J9XdhJXfkALYtftahfQnUKkucyvMz8Gx6L7BW9v+RYlw4Szdf5Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c14NGIrZ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717447343; x=1748983343;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=otnxhcfSt5UbL4O0zIn8rZEGWLr567tpTzedaNns2CY=;
  b=c14NGIrZ0mEpgEQjjzLjdmDgw68Ehnae/H9GPtE8zDculucQZeso9dPg
   ZPXQ6GWwL2u5XrJgl0WH2oHJgDsuySKpVly3t+l9+LDXHISdu3iziAMXX
   V75pVHxWFE33G12+ONf+SHIp6OaChKAVOxpR4hQeotIsNpM6WifdLqdGn
   bJWm2vZnKARp1ZfWZoHl3u6keXYp8drI+UcDlFGpBj9hZfWwBKslJtweJ
   xV4sGCpYJJqNji7rYfiPfWLTnslKKw6hOJgYVrrwu1APxFfy5JOuAQn1u
   l+n3OcVFouKN3RUfF4HcJpLHN9JvdXQcPK8oOjhXxiE9trGDKev4GdqmS
   A==;
X-CSE-ConnectionGUID: a+0i9jcoQRC+Fc9B0gC6YA==
X-CSE-MsgGUID: YbSW38EnSF6qGkNMO8Mayw==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="36482825"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="36482825"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 13:42:22 -0700
X-CSE-ConnectionGUID: Mp+SBggoR0ePzdQGZRkr+g==
X-CSE-MsgGUID: RGmqHVluQkCj6WbXpITjww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="41421303"
Received: from unknown (HELO [10.245.245.174]) ([10.245.245.174])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 13:42:21 -0700
Message-ID: <e772bf3fe4577f66f56a969ee261e218b8daf738.camel@linux.intel.com>
Subject: Re: [PATCH] drm/xe: Restrict user fences to long running VMs
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org
Date: Mon, 03 Jun 2024 22:42:19 +0200
In-Reply-To: <20240603175312.1915763-1-matthew.brost@intel.com>
References: <20240603175312.1915763-1-matthew.brost@intel.com>
Autocrypt: addr=thomas.hellstrom@linux.intel.com; prefer-encrypt=mutual;
 keydata=mDMEZaWU6xYJKwYBBAHaRw8BAQdAj/We1UBCIrAm9H5t5Z7+elYJowdlhiYE8zUXgxcFz360SFRob21hcyBIZWxsc3Ryw7ZtIChJbnRlbCBMaW51eCBlbWFpbCkgPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPoiTBBMWCgA7FiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQuBaTVQrGBr/yQAD/Z1B+Kzy2JTuIy9LsKfC9FJmt1K/4qgaVeZMIKCAxf2UBAJhmZ5jmkDIf6YghfINZlYq6ixyWnOkWMuSLmELwOsgPuDgEZaWU6xIKKwYBBAGXVQEFAQEHQF9v/LNGegctctMWGHvmV/6oKOWWf/vd4MeqoSYTxVBTAwEIB4h4BBgWCgAgFiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwwACgkQuBaTVQrGBr/P2QD9Gts6Ee91w3SzOelNjsus/DcCTBb3fRugJoqcfxjKU0gBAKIFVMvVUGbhlEi6EFTZmBZ0QIZEIzOOVfkaIgWelFEH
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Mon, 2024-06-03 at 10:53 -0700, Matthew Brost wrote:
> User fences are intended to be used on long running VMs, enforce this
> restriction. This addresses possible concerns of using user fences in
> dma-fence and having the dma-fence signal before the user fence.

As mentioned in a separate thread, We should not introduce an uAPI
change with the above motivation. We need to discuss potential use-
cases for !LR vms and if there are found to be none, we could consider
restricting in this way.

/Thomas


>=20
> Fixes: d1df9bfbf68c ("drm/xe: Only allow 1 ufence per exec / bind
> IOCTL")
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
> GPUs")
> Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> ---
> =C2=A0drivers/gpu/drm/xe/xe_exec.c | 3 ++-
> =C2=A0drivers/gpu/drm/xe/xe_vm.c=C2=A0=C2=A0 | 3 ++-
> =C2=A02 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_exec.c
> b/drivers/gpu/drm/xe/xe_exec.c
> index 97eeb973e897..a145813ad229 100644
> --- a/drivers/gpu/drm/xe/xe_exec.c
> +++ b/drivers/gpu/drm/xe/xe_exec.c
> @@ -168,7 +168,8 @@ int xe_exec_ioctl(struct drm_device *dev, void
> *data, struct drm_file *file)
> =C2=A0			num_ufence++;
> =C2=A0	}
> =C2=A0
> -	if (XE_IOCTL_DBG(xe, num_ufence > 1)) {
> +	if (XE_IOCTL_DBG(xe, num_ufence > 1) ||
> +	=C2=A0=C2=A0=C2=A0 XE_IOCTL_DBG(xe, num_ufence && !xe_vm_in_lr_mode(vm)=
)) {
> =C2=A0		err =3D -EINVAL;
> =C2=A0		goto err_syncs;
> =C2=A0	}
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 26b409e1b0f0..85da3a8a83b6 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -3226,7 +3226,8 @@ int xe_vm_bind_ioctl(struct drm_device *dev,
> void *data, struct drm_file *file)
> =C2=A0			num_ufence++;
> =C2=A0	}
> =C2=A0
> -	if (XE_IOCTL_DBG(xe, num_ufence > 1)) {
> +	if (XE_IOCTL_DBG(xe, num_ufence > 1) ||
> +	=C2=A0=C2=A0=C2=A0 XE_IOCTL_DBG(xe, num_ufence && !xe_vm_in_lr_mode(vm)=
)) {
> =C2=A0		err =3D -EINVAL;
> =C2=A0		goto free_syncs;
> =C2=A0	}


