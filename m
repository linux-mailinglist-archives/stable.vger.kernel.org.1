Return-Path: <stable+bounces-89595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F909BAAF9
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 03:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2D1B1C20B2D
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 02:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB50315B987;
	Mon,  4 Nov 2024 02:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vo8BDgS3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A542F5A
	for <stable@vger.kernel.org>; Mon,  4 Nov 2024 02:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730688155; cv=none; b=cT3AQVCTRBZNLSdHykFMEhraGT7IeNN0lyiH5wtngeJWXLY1d2GTQ82t2LSrTEsMeTIRjAvBdtBIxmEChWKZ4TYh5DwR+ilcYhyZJCMTyC2M2tXN9UPE3gNfrA1BOG9z/aiSAD5qRqXOCsrcLnF3vl98ieFSs7TUjV/NdlyeNnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730688155; c=relaxed/simple;
	bh=DsBMO5PsU9G+AWKLnyFg8R/GdDfxg7/McvtsubaFLP8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=u6ZwAdqeA4F5mWtA9FaSvto/Q7NF48UpFbXWLZnTOVx4cg6Rq6cDX1dw1fb/fr1RkIko6K7+Cv9TBBf2Ba4jovAuDg36WO5Ex0PJXipytop1USE8rME5U0Q9ih+9/Lwv+tc7RjqgO7Hj4UTibY1ZEA7D1fbLE8FzUMBazkzySlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vo8BDgS3; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730688154; x=1762224154;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=DsBMO5PsU9G+AWKLnyFg8R/GdDfxg7/McvtsubaFLP8=;
  b=Vo8BDgS34x1LCBYSzqc6w5N/fX8yKOJopOP7trIiehov5SPoS9a63VN+
   u2Mw3AaZUOitpjvAaGGHW5e/hQoC6pAMC2YTuLfLvmBddNMVhE7e18VSw
   DpO+JJUbTYh+VhJtzCy9R3mYyw+7l3IZ5X+RKqEhV5pG/4BGyif//UGoG
   UBCVH6bRBtqkH0Kr8RKgpyWatuZpGFzTc+XD02xx1WVKYSCEgcUNzUzv3
   tL5NIvHXVID6Wxj63DGRL580uOCAZ5424pGUMVsBQrUxsEncpJscllvKw
   QR7BQmrPvApuhzgi2fu4OAeWnbJLsxg7TC2pwquMPj0OkXDT15vjl05JC
   Q==;
X-CSE-ConnectionGUID: Y4gHwnGhTk2Rm5EDvzpL1A==
X-CSE-MsgGUID: ZzYmAdFLSYSMClfTPRdZpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="40948249"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="40948249"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 18:42:33 -0800
X-CSE-ConnectionGUID: L8aHyAnRSmGs1zypEQu82A==
X-CSE-MsgGUID: 7qzIzJuqROe4nl4CuSzmRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="87453763"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 03 Nov 2024 18:42:32 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7n30-000kOL-11;
	Mon, 04 Nov 2024 02:42:30 +0000
Date: Mon, 4 Nov 2024 10:42:05 +0800
From: kernel test robot <lkp@intel.com>
To: chenchangcheng <ccc194101@163.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] media: uvcvideo:Create input device for all uvc devices
 with status endpoints.
Message-ID: <Zyg0ffucS8iMvjdl@18dc9bc60085>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104023947.826707-1-ccc194101@163.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] media: uvcvideo:Create input device for all uvc devices with status endpoints.
Link: https://lore.kernel.org/stable/20241104023947.826707-1-ccc194101%40163.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




