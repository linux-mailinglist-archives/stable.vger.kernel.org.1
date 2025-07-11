Return-Path: <stable+bounces-161679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8300B02289
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 19:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034B317994E
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 17:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793332EF643;
	Fri, 11 Jul 2025 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RmkRnQUH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81EB195811;
	Fri, 11 Jul 2025 17:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752254678; cv=none; b=PDLKmA/ruH915NwJ0o9H61LSTn+vG/cNXtrdDGQX4z74iWaL19PVGq7uMRq0MjjZSYizz4KXmRhQOkpVA+oA7oijwbGmPGNTMoUe0fs1dNwXAQ8QSs+b5pKI4UFYf3LM65Y7vggEq0KdR4XvpkdO/7KsqIRNVuDVbDX/cIS/tZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752254678; c=relaxed/simple;
	bh=LLBeSog7DztvXtU6B0MtqYLn+ZHH8OCXrBByrrm3NXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrbAQfHp1LEeJwZNe/H9A07+XQCMdPJw62C6zecYVCSg00qdtqpSsbeVyuVmPCuIhbLevqiD/mWiJOo3dmqDcU6yn4FrnfoZf6QcN1cbZNaoSy+zjbXGota1oz72rOMNA1jW+d/Sbqp4GoraWAaKQ2+zU7p0glPGXZtpB1q1LAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RmkRnQUH; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752254677; x=1783790677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LLBeSog7DztvXtU6B0MtqYLn+ZHH8OCXrBByrrm3NXQ=;
  b=RmkRnQUHjlP53/Ps7dLZToAHJnHLkTZU8oKB46PN2bQKNjZbQ+ho7EIP
   0ew2oe+MbloCQQj+tbYsI7WtBcNS3DdQmhGp2oUsyBMX9DxH9+Z1aoUXy
   ZortiZLuQjFAF5g8GSQIpR2yi3kGGZ9AewEKHQaTtiBQreZjRtynxE92G
   8PzTLDlMbHQVRxY4Zvs7Bl646DyGLD7Uzt1+YoXxwi7jwsr4jAnKg1MTy
   qI6DSoZ1gjxXqpNy1wqyc2VRNf+/h9+L9t5h44cUI64G4E8jOcsWiHOTB
   uWmVU/FK63GYC1L8EIFMvomLcVa+vZjV9eP5ltBJ9Rb+IG0h+9pftO6Z0
   A==;
X-CSE-ConnectionGUID: OAx7jzpIQlWygJKOQJitwg==
X-CSE-MsgGUID: zzAcM/qAT9igzzFhZZ168A==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54687815"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="54687815"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 10:24:35 -0700
X-CSE-ConnectionGUID: 5eGk1HCfT7iTNafse8lEeg==
X-CSE-MsgGUID: JG62ueZoTICMXFshnx3iRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="156047284"
Received: from mgerlach-mobl1.amr.corp.intel.com (HELO localhost) ([10.124.222.101])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 10:24:34 -0700
Date: Fri, 11 Jul 2025 10:24:32 -0700
From: David Box <david.e.box@linux.intel.com>
To: "Michael J. Ruhl" <michael.j.ruhl@intel.com>
Cc: platform-driver-x86@vger.kernel.org, intel-xe@lists.freedesktop.org, 
	hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, lucas.demarchi@intel.com, 
	rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com, airlied@gmail.com, 
	simona@ffwll.ch, Tejas Upadhyay <tejas.upadhyay@intel.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v7 01/12] platform/x86/intel/pmt: fix a crashlog NULL
 pointer access
Message-ID: <wu3ijqgfztvbc7x3vdh5kl6xavvdngyt647cyvhoipv3fmkr3w@7iizjdkm5a2m>
References: <20250709184458.298283-1-michael.j.ruhl@intel.com>
 <20250709184458.298283-2-michael.j.ruhl@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250709184458.298283-2-michael.j.ruhl@intel.com>

On Wed, Jul 09, 2025 at 02:44:47PM -0400, Michael J. Ruhl wrote:
> Usage of the intel_pmt_read() for binary sysfs, requires a pcidev. The
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
> Augment struct intel_pmt_entry with a pointer to the pcidev to avoid
> the NULL pointer exception.

Reviewed-by: David E. Box <david.e.box@linux.intel.com>

> 
> Reviewed-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
> Fixes: 045a513040cc ("platform/x86/intel/pmt: Use PMT callbacks")
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
> -- 
> 2.50.0
> 
> 

