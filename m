Return-Path: <stable+bounces-152407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A3AAD5240
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 12:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 570F57AA493
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 10:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFAB2676D3;
	Wed, 11 Jun 2025 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gz/8p5pm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCEA2222A0;
	Wed, 11 Jun 2025 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749638539; cv=none; b=opNLweLK4Hl403gh/4YpA4A0cryeQgtf0wX2LvVdTOSUpFygaJA4Ih1iYREDf6LB7Pn+DVVSCWDABIHFf6g7+ShpTOn/LaiHpeYUD1PLUmI21K6lHfmgijizsOY68H++ujFa0gqSzqVW2k70Srtr7twtcKLPPrcIiqrjeMiyFBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749638539; c=relaxed/simple;
	bh=h08gi4WLI6tcGkAwrH+Thpr07BPoSnIzkPWpfLw/hfY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OWLMMNqQYGJbCIwLV+eR0rTuKBOliYBWKLk8FgUtd56d2SVz/e8gVTjOXB8eCODCoajVszSA/jnRw6iSSHclnb/dyDG+xvpqn7FWLDgJviwm8If+cyNJEKd4o7/KhSMhnTFR41tZsS572EBOoI1OQ4B4yLp2lF5KBNxfjgfwTnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gz/8p5pm; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749638538; x=1781174538;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=h08gi4WLI6tcGkAwrH+Thpr07BPoSnIzkPWpfLw/hfY=;
  b=gz/8p5pmWTZjGYtYQCGafI5h1d8NwkdPj1cdexR+SJCLXTMVpivBoCIL
   lSHCewk0uH1WCfr20Nspn6p0x9PaWqw3qeZZvUQ+i8pJsX/RCHgVMR5Rh
   Jh2THmzbaBbgB53La5TgrJmZ2ytzqh8LXgqh9ZGp+kA+HeowusWhABzCN
   SRWh2/3xniM9XOPkL6qAxKl2Iz3ed5MnOyQK4QhJZVlCD48SHxqyajcTX
   bs6odbi+mqb8JwDBdXsJZBaY1u652omJpj1VSdVpsz03NMaX99By0OKTi
   NOb3GUv9c8IVGkxixjw9ouwEZM0/KYhK9DxqNujmVW2HkSbk7zdVBC/Yi
   Q==;
X-CSE-ConnectionGUID: bQbv3VmUTsy+K2NIn3tC4Q==
X-CSE-MsgGUID: oOOyH7xTS4qbxPPTt2k8WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="55579937"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="55579937"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 03:42:16 -0700
X-CSE-ConnectionGUID: j9wcgsUQTH6sMQgM6O0/oA==
X-CSE-MsgGUID: maI4rBXCRCqFr7C+RSwyzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="147515911"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.183])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 03:42:12 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 11 Jun 2025 13:42:08 +0300 (EEST)
To: "Michael J. Ruhl" <michael.j.ruhl@intel.com>
cc: platform-driver-x86@vger.kernel.org, intel-xe@lists.freedesktop.org, 
    Hans de Goede <hdegoede@redhat.com>, lucas.demarchi@intel.com, 
    rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com, 
    airlied@gmail.com, simona@ffwll.ch, david.e.box@linux.intel.com, 
    stable@vger.kernel.org
Subject: Re: [PATCH v4 01/10] platform/x86/intel/pmt: fix a crashlog NULL
 pointer access
In-Reply-To: <20250610211225.1085901-2-michael.j.ruhl@intel.com>
Message-ID: <e4f3a1e0-5332-212d-6ad0-8a72dcaf554a@linux.intel.com>
References: <20250610211225.1085901-1-michael.j.ruhl@intel.com> <20250610211225.1085901-2-michael.j.ruhl@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 10 Jun 2025, Michael J. Ruhl wrote:

> Usage of the intel_pmt_read() for binary sysfs, requires a pcidev.  The
> current use of the endpoint value is only valid for telemetry endpoint
> usage.
> 
> Without the ep, the crashlog usage causes the following NULL pointer
> exception:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> Oops: Oops: 0000 [#1] SMP NOPTI
> RIP: 0010:intel_pmt_read+0x3b/0x70 [pmt_class]
> Code:
> Call Trace:
>  <TASK>
>  ? sysfs_kf_bin_read+0xc0/0xe0
>  kernfs_fop_read_iter+0xac/0x1a0
>  vfs_read+0x26d/0x350
>  ksys_read+0x6b/0xe0
>  __x64_sys_read+0x1d/0x30
>  x64_sys_call+0x1bc8/0x1d70
>  do_syscall_64+0x6d/0x110
> 
> Augment the inte_pmt_entry to include the pcidev to allow for access to

intel_pmt_entry

> the pcidev and avoid the NULL pointer exception.
> 
> Fixes: 416eeb2e1fc7 ("platform/x86/intel/pmt: telemetry: Export API to read telemetry")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> ---
>  drivers/platform/x86/intel/pmt/class.c | 3 ++-
>  drivers/platform/x86/intel/pmt/class.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
> index 7233b654bbad..d046e8752173 100644
> --- a/drivers/platform/x86/intel/pmt/class.c
> +++ b/drivers/platform/x86/intel/pmt/class.c
> @@ -97,7 +97,7 @@ intel_pmt_read(struct file *filp, struct kobject *kobj,
>  	if (count > entry->size - off)
>  		count = entry->size - off;
>  
> -	count = pmt_telem_read_mmio(entry->ep->pcidev, entry->cb, entry->header.guid, buf,
> +	count = pmt_telem_read_mmio(entry->pcidev, entry->cb, entry->header.guid, buf,
>  				    entry->base, off, count);
>  
>  	return count;
> @@ -252,6 +252,7 @@ static int intel_pmt_populate_entry(struct intel_pmt_entry *entry,
>  		return -EINVAL;
>  	}
>  
> +	entry->pcidev = pci_dev;
>  	entry->guid = header->guid;
>  	entry->size = header->size;
>  	entry->cb = ivdev->priv_data;
> diff --git a/drivers/platform/x86/intel/pmt/class.h b/drivers/platform/x86/intel/pmt/class.h
> index b2006d57779d..f6ce80c4e051 100644
> --- a/drivers/platform/x86/intel/pmt/class.h
> +++ b/drivers/platform/x86/intel/pmt/class.h
> @@ -39,6 +39,7 @@ struct intel_pmt_header {
>  
>  struct intel_pmt_entry {
>  	struct telem_endpoint	*ep;
> +	struct pci_dev		*pcidev;
>  	struct intel_pmt_header	header;
>  	struct bin_attribute	pmt_bin_attr;
>  	struct kobject		*kobj;
> 

-- 
 i.


