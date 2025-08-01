Return-Path: <stable+bounces-165750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECA4B18411
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 16:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD687A868C3
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 14:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B8E26E6E3;
	Fri,  1 Aug 2025 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LLJa3Gto"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAC426C3B6;
	Fri,  1 Aug 2025 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754059175; cv=none; b=MA6b9shbo/to4UkStRoW5yYhSnGHGaqJGSi3x+yz21YKgW97lMFTf5dH+xWONPmm7iekTXNwo6d0NE2zqbJO6W7pUS0v856xeGDfXQP5uHTc401H1jUe/YB//q8x4MvVhnbR3jtiJul1NdRn0jMAAMe/gqvTo6rIcyUPR4qHoBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754059175; c=relaxed/simple;
	bh=1+Yue7v22VLTwbOfZZv/7s1zdqZbFMwO7DxS1UC4Y68=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YjwxQjiPRS1wC4g8tG0ChJafozBRVpZCm1RFmLBlJEM8L2P4mv1gLljftmite4qW4qo0kM+uEJ9md31/9CB0JOah7GRIFXl2WJvku/qNqYKM4p27fPWQC9/UrfWXQhgCkg3FiFfQhBGpHv+cuEuAPQaxPgrf/mbcfDsb8DYyEPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LLJa3Gto; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754059174; x=1785595174;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=1+Yue7v22VLTwbOfZZv/7s1zdqZbFMwO7DxS1UC4Y68=;
  b=LLJa3Gto1mNQLq24T1E70/uBhgesAd57tPw/pnj78AcbInEEsmN1knGm
   1klsacTs5bfJ414mr+81ajCqb0TVBprXJQx5KGYa8thUMy9COI9OBlF89
   fzknP1ulwRQ4WX181K4sbl4fO4x2+s4gffmsJ/Zesb6x3QJAms0Bp6jL6
   hCKtzfRaTFN6bSHxPCYfH3gBi+RxFEW5M/MDht5rJ3GxHH2PPo+acuc0+
   UkzdClHsxbmSfmWLc51KEiJhImCn6A45lR3eEiOyQYBBCzH+/L8lLsOeB
   kclB2ouIKfauP4wxXaTtifNvNHh26URhrm/FpsgoAHi8JnSOO8Wubixo3
   g==;
X-CSE-ConnectionGUID: +orxp5uCR3+7ctDDCMr7aw==
X-CSE-MsgGUID: buPDGGY/TyWyfknUgGLSvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56296494"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="56296494"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 07:39:33 -0700
X-CSE-ConnectionGUID: k9bxnrpCToCcvgQiriF5qQ==
X-CSE-MsgGUID: i5DFsePTRBaK+/LXxUVj+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="163932413"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO [10.245.244.137]) ([10.245.244.137])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 07:39:31 -0700
Message-ID: <274fefe9b46bb856e5968431ed524ebe1b8e8cd4.camel@linux.intel.com>
Subject: Re: [PATCH v3] Mark xe driver as BROKEN if kernel page size is not
 4kB
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Simon Richter <Simon.Richter@hogyros.de>,
 intel-xe@lists.freedesktop.org, 	dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Date: Fri, 01 Aug 2025 16:39:28 +0200
In-Reply-To: <20250801102130.2644-1-Simon.Richter@hogyros.de>
References: <460b95285cdf23dc6723972ba69ee726b3b3cfba.camel@linux.intel.com>
	 <20250801102130.2644-1-Simon.Richter@hogyros.de>
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

On Fri, 2025-08-01 at 19:19 +0900, Simon Richter wrote:
> This driver, for the time being, assumes that the kernel page size is
> 4kB,
> so it fails on loong64 and aarch64 with 16kB pages, and ppc64el with
> 64kB
> pages.
>=20
> Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
> Cc: stable@vger.kernel.org

Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
I will add a Fixes: tag and push this.

Thanks,
Thomas


> ---
> =C2=A0drivers/gpu/drm/xe/Kconfig | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
> index 2bb2bc052120..ea12ff033439 100644
> --- a/drivers/gpu/drm/xe/Kconfig
> +++ b/drivers/gpu/drm/xe/Kconfig
> @@ -1,7 +1,7 @@
> =C2=A0# SPDX-License-Identifier: GPL-2.0-only
> =C2=A0config DRM_XE
> =C2=A0	tristate "Intel Xe2 Graphics"
> -	depends on DRM && PCI
> +	depends on DRM && PCI && (PAGE_SIZE_4KB || COMPILE_TEST ||
> BROKEN)
> =C2=A0	depends on KUNIT || !KUNIT
> =C2=A0	depends on INTEL_VSEC || !INTEL_VSEC
> =C2=A0	depends on X86_PLATFORM_DEVICES || !(X86 && ACPI)



