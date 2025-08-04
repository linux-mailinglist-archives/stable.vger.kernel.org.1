Return-Path: <stable+bounces-166456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC66B19EDF
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 11:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 975494E0FEB
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 09:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD8E2417C5;
	Mon,  4 Aug 2025 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YsUTDOp4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E971EA7CF;
	Mon,  4 Aug 2025 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300422; cv=none; b=NZgUQ2ZxD4gyt21Y9p8X3ZjMpdglWkKxJcm1ylBPTFLi5J+CTDUNMJyns+O1gNSFeygUmQrsuqY8agH0JTATKE5ZOMmpgZv6+GBagvt8mAyqZcgFOpTSlQeUzAOOg9cc9NUFVe7iTObyTq/zP23ek6+7LRQPQ6xgVJtRbRrnajk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300422; c=relaxed/simple;
	bh=za1PTKsWjFibSErq85AFsMvUwxohoDzwmMSpj4Q7Hog=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ai9Urdo4v6THbCri2AmkQSN9fJOdnYCghw7pcA8Ua28aT1ldgIENy23qGvO2kD7MHQAxnyfNnBuD2oOo55EmH+N1oT8+rqYOsRWc7/AR/mo3zk6v1KSkcflE8lMpXdo4+7KMBfY5jwEnMObSZZ9/fbu9819AO6Sgm9hFvmfaFeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YsUTDOp4; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754300421; x=1785836421;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=za1PTKsWjFibSErq85AFsMvUwxohoDzwmMSpj4Q7Hog=;
  b=YsUTDOp4IfsO2nIkXxMt5wgurI0C64sXoFlJRWgZfOd4JkIoe0/kau1D
   VmPkFOpBeADALZyJs3tXY5ko/s1EIwRpxzZVj5i4++2VobB8RTa7lyYRG
   kc8y8xwLl1Pbd07lm0lGUZ3qA0jDh0u60nwd7Y/q26F8LV4LxtOex67KA
   ZX1dbMJJTMo9J2tNew9LShzIXYAU1VkPo16khLJqIuD0W3TW9xqonQXEa
   05SS75B6Iu3hHO1x1UZ9xItv0M0Tgu3K7zoOVaBBv/94gKLc1efoBiYii
   Ec28F5OmdhgcoRWROC83McNRhNjsSQqViBcku5Xfm0Tdvyk6UqskD2+md
   g==;
X-CSE-ConnectionGUID: 2c5pNpAOTO+PjsrkeurmFQ==
X-CSE-MsgGUID: 2TtQkNpMS3KmimQVO5Vb3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11511"; a="74142327"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="74142327"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 02:40:20 -0700
X-CSE-ConnectionGUID: 7d6dt920SEexhKinLnnNRA==
X-CSE-MsgGUID: EDZ/GzpIQ52XiYqiFjo+7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="163785264"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO [10.245.245.63]) ([10.245.245.63])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 02:40:18 -0700
Message-ID: <ccf7c5b0494e46bbf86d45927e6bd130115c50fb.camel@linux.intel.com>
Subject: Re: [PATCH v4] Mark xe driver as BROKEN if kernel page size is not
 4kB
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Simon Richter <Simon.Richter@hogyros.de>,
 intel-xe@lists.freedesktop.org, 	dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Date: Mon, 04 Aug 2025 11:40:15 +0200
In-Reply-To: <20250802024152.3021-1-Simon.Richter@hogyros.de>
References: <37abb9a1a4fde174a54a9d7868d31b2615df0e47.camel@linux.intel.com>
	 <20250802024152.3021-1-Simon.Richter@hogyros.de>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-08-02 at 11:40 +0900, Simon Richter wrote:
> This driver, for the time being, assumes that the kernel page size is
> 4kB,
> so it fails on loong64 and aarch64 with 16kB pages, and ppc64el with
> 64kB
> pages.
>=20
> Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
> Cc: stable@vger.kernel.org
> ---
> =C2=A0drivers/gpu/drm/xe/Kconfig | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
> index 2bb2bc052120..714d5702dfd7 100644
> --- a/drivers/gpu/drm/xe/Kconfig
> +++ b/drivers/gpu/drm/xe/Kconfig
> @@ -5,6 +5,7 @@ config DRM_XE
> =C2=A0	depends on KUNIT || !KUNIT
> =C2=A0	depends on INTEL_VSEC || !INTEL_VSEC
> =C2=A0	depends on X86_PLATFORM_DEVICES || !(X86 && ACPI)
> +	depends on PAGE_SIZE_4KB || COMPILE_TEST || BROKEN
> =C2=A0	select INTERVAL_TREE
> =C2=A0	# we need shmfs for the swappable backing store, and in
> particular
> =C2=A0	# the shmem_readpage() which depends upon tmpfs

R-B still stands.

I've pushed this to drm-xe-next with a Fixes: tag which means it will
likely end up in Linus' tree the upcoming weekend.

Thanks,
Thomas


