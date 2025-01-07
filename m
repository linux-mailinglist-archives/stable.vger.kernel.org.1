Return-Path: <stable+bounces-107803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9061AA038A7
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 08:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82CE4163A5E
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 07:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BBC1ADFE3;
	Tue,  7 Jan 2025 07:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HztY1Ih3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C9E17C9E8
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 07:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736234235; cv=none; b=N3YrBvIeMkauqFP7dTWOF/3dgJWkCxJhwmOy4p1LmECK5RhqYJg1R6LLWzwXsEGkoX/9LV7yTZUhVB4X6j9cPYzSQEpAydNKQdgx2GiI+AeU/x06FrHznqTIrT7hNgvWFNEz/OiOP34QkOrwHm9mcsFZsQHehGSuCGjdF9CxMDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736234235; c=relaxed/simple;
	bh=kI172/XFJT3BHI6YC28OZXgc3fT+ihj7C/Mt45Sm4rA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FfKrkVQdIEBK2Mhb1AqNDklJctAzQxprRLVhypIvHNFTaxk1B16IPX42kZ+b2sqNoj2rAIGFl3anjGSoTgo5sk+1KfGZz1MAmrSCN2kdGuNQrvOZRrT8NzvgnZneVV+zYNO73sbqRTUcDgdWQbdWB7tpxi1Cb02LHZq3zUpx/co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HztY1Ih3; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736234234; x=1767770234;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=kI172/XFJT3BHI6YC28OZXgc3fT+ihj7C/Mt45Sm4rA=;
  b=HztY1Ih3L9IQm09bHulh2WzOsvUZbyH7NTLajWFD1dZf++DJE75sBOrZ
   WV7zKFGiaR2Xhc/5vINe6wrhKJG7XCJuYAlXzt28a/PHqCOl2RdIqIdZO
   fsLm8OMj6gXP8b4VM8PaI+ZihfgGiPfeqwKHkRqb+y+iS9dyCdwxUz6iO
   2HAwDGh5MTpHoONZfDRElo8J9mC9tfnpXDe/QyrTA5DvFN1s6qTDmBYVN
   wsEX2Wv00KBg+MN9/u3iV0EXE/HIXggGybk3diqsutEl0+LyEc9G4XdA3
   6D88577GFlR+JINgmeQfOUUDhzoJTONw/u+jLicdFFj4Z+rRKEp3y6dPB
   Q==;
X-CSE-ConnectionGUID: /vQb+CQmTa+HDX+lLvdRyQ==
X-CSE-MsgGUID: de1TWQ75RxujArsFG70B6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="36279449"
X-IronPort-AV: E=Sophos;i="6.12,294,1728975600"; 
   d="scan'208";a="36279449"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 23:17:14 -0800
X-CSE-ConnectionGUID: /eW34QE0RcSEVul36ezP8g==
X-CSE-MsgGUID: WDbOuCPsS8io9jJcWXPi6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="125979839"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 06 Jan 2025 23:17:11 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tV3pt-000ELn-2p;
	Tue, 07 Jan 2025 07:17:09 +0000
Date: Tue, 7 Jan 2025 15:16:57 +0800
From: kernel test robot <lkp@intel.com>
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 5.10 5.15 6.1] zram: check comp is non-NULL before
 calling comp_destroy
Message-ID: <Z3zU6YmzsZuGtiNS@42adc3c43980>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107071604.190497-1-dominique.martinet@atmark-techno.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 5.10 5.15 6.1] zram: check comp is non-NULL before calling comp_destroy
Link: https://lore.kernel.org/stable/20250107071604.190497-1-dominique.martinet%40atmark-techno.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




