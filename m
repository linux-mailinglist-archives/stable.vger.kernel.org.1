Return-Path: <stable+bounces-188019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13391BF02E3
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 11:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E94413A4842
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 09:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420492F60A5;
	Mon, 20 Oct 2025 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A9JEz9GP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F41C2F60CA
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760952634; cv=none; b=W16R17kpNTrOVhV4oS0nOYFmLYsSn6GOKFsF2df5bxr9Z3zPpcHESB2d9v7COOVsqSbv8xKyRTTxlPNejaDAM4TaRmPPPrZujQ04pHMTimpRQaY1KRG4e7MlR4dXz9hxUi/OKQy5XGXF3X1ABDF/NyDfvLYGhHIgY6uWUwSubks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760952634; c=relaxed/simple;
	bh=YWv0wUMNSMPgNRqdl9ln5qfNkK/W4QOJi6WtJPcAoJc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tBvXyn6alYCRlsFl+x0crruGuunW5oP3F5qGpoKoHHtDG3PaTzkTIL9lNCV/Wqqt/bA36P3tPWoFzkfzYXfEBOq41Pe4krAmbfjs50tFk1KNbz0Lv9qpoajnFEL43OYL814HBpsnwg3EHExR6193yw+SGJv61lGGo3zfnhVcsEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A9JEz9GP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760952627; x=1792488627;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=YWv0wUMNSMPgNRqdl9ln5qfNkK/W4QOJi6WtJPcAoJc=;
  b=A9JEz9GPitDO6SdOKZ4WaaIEaw+f2rBvEohmQhTz/JCTYazvlkJMfdM3
   Q0lBQZPEJi7fJosiCHW2cVkEnBJfnQluPOtjSldfINZ+Hz8BwilyfbTt6
   aDbNtTBHIsmk9UMIy/FSOs7roX4iwnh+f26bOvTF9auVOpuz1/TUXngx0
   sM9z4w7GhE/ppJPu69cddM6eraCdoY7ez+nkry+eYfUmzCeQuD5fsnLf4
   PSurgWp0QqbH6RcoV/p1BasJEW2qGA0y8Of/yrNYZjvF6ndE4GevqBRIK
   LZuVb/qX07I+lesCztWNxqcUcFrYsq2yFOc4yGSfbjHUEm/Bcco1CUlZl
   w==;
X-CSE-ConnectionGUID: 1FB6TRRNQw+zbno1LqqL8g==
X-CSE-MsgGUID: fhyQmGtvQz2f0YeU0hA90A==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="63107346"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="63107346"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 02:30:26 -0700
X-CSE-ConnectionGUID: 8PJTP3SJTiiwZPs+L6GLNQ==
X-CSE-MsgGUID: 77U0ztMoTz2owSUNRRntJA==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 20 Oct 2025 02:30:25 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vAmDf-0009hN-14;
	Mon, 20 Oct 2025 09:30:23 +0000
Date: Mon, 20 Oct 2025 17:30:12 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.16-6.17 2/2] arm64: errata: Apply workarounds for
 Neoverse-V3AE
Message-ID: <aPYBJGWKS1hS5NFF@ff1a9926167f>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020092741.592431-3-ryan.roberts@arm.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 6.16-6.17 2/2] arm64: errata: Apply workarounds for Neoverse-V3AE
Link: https://lore.kernel.org/stable/20251020092741.592431-3-ryan.roberts%40arm.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




