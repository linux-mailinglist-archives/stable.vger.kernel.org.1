Return-Path: <stable+bounces-158917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC17AED8B2
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 11:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5891766D6
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 09:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8DF244688;
	Mon, 30 Jun 2025 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GLX7oQvY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5115123BD02;
	Mon, 30 Jun 2025 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751275749; cv=none; b=W4Jsn3Rs3EPe+mRByRoMgmefz1Q7ysrXNt9MpIiljDWr31BZVR48W7tQQnNPKs1K4aA3PZ3DmOTxDc56a/dJgk8U1g4ObnIRb7GIQ3SsakItTJT+GcR3WTS0XKoSkPKyrgd7Etk60HSsRpp5IRFiNqvXerhdJiL7CzenYoWDHbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751275749; c=relaxed/simple;
	bh=hjHmh1x3LHSxiHJHwSYt2mDw6VTgEyuQJvBe3qr0u0E=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=avE33aBX5OyQ4f77uK5SbHEZEJDzirx+hxMj+cTDl3c3SRFKZ6JehgRlvin7IuoBuwJ+fpebETC1xsuG/YHWLgmiQc+Kvcjmsu7ZqEkJJV+VS7cUIvBf8N1lAwEsclQMsWTr8Gm71r0dFsUDAYVxmwmJunCS+BMr29LR8X4RS+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GLX7oQvY; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751275748; x=1782811748;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hjHmh1x3LHSxiHJHwSYt2mDw6VTgEyuQJvBe3qr0u0E=;
  b=GLX7oQvYlHm1TsDNm1MLAo0CttOnX7LxGaZmoDxCYGgTHuwkpq485lyZ
   JamfFB4hjkMiby7JNhgoc5ATaevVSqzUVu27007Ii64aoFn9C1X4MbhCW
   nFEGfj45qbmkur597bH3ylJsExCWJoN+2WqDlfKnWu8I/9QbdKLyFipJM
   I3DPtX1G+JZXYywmN3YezmR65LIOs7HFBjtiZH4EQjfOgDN1btpnWsJ/N
   eR9Opt2/hfPUHJ1LiWi20drxXs/7mVKKahIeaA+ZnRIKy4pMqY9Wl6cAz
   irx6LNEK9buOi5QB09FUYOnVZtkOadfWM1D7B4YUuuEYtW0TFkxE1CjX7
   g==;
X-CSE-ConnectionGUID: DoBryTBoTuK1FeeKmx70XQ==
X-CSE-MsgGUID: DlxLiTS7T/SoRDlnpdPeFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="41122822"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="41122822"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 02:29:08 -0700
X-CSE-ConnectionGUID: /v5dCSGZSGCqsXnD5ZH/Vg==
X-CSE-MsgGUID: GJwE85ORQsqPDhCYTvmC+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="157951058"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.65])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 02:29:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 30 Jun 2025 12:29:00 +0300 (EEST)
To: "Michael J. Ruhl" <michael.j.ruhl@intel.com>
cc: platform-driver-x86@vger.kernel.org, intel-xe@lists.freedesktop.org, 
    Hans de Goede <hdegoede@redhat.com>, lucas.demarchi@intel.com, 
    rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com, 
    airlied@gmail.com, simona@ffwll.ch, david.e.box@linux.intel.com, 
    Tejas Upadhyay <tejas.upadhyay@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH v5 01/12] platform/x86/intel/pmt: fix a crashlog NULL
 pointer access
In-Reply-To: <20250627204321.521628-2-michael.j.ruhl@intel.com>
Message-ID: <e860ab9b-4f75-b6ef-3b82-f4e45f478d03@linux.intel.com>
References: <20250627204321.521628-1-michael.j.ruhl@intel.com> <20250627204321.521628-2-michael.j.ruhl@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 27 Jun 2025, Michael J. Ruhl wrote:

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

Can you confirm, if this was possible to trigger only after this series 
has been applied, not with the current mainline code?

-- 
 i.

> Augment struct intel_pmt_entry with a pointer to the pcidev to avoid
> the NULL pointer exception.
> 
> Reviewed-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
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

