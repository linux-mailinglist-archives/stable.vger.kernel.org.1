Return-Path: <stable+bounces-50252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E77A9052F7
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902B71C2157E
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 12:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66D4173331;
	Wed, 12 Jun 2024 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T4piLhcC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBD0153509
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196712; cv=none; b=AWK0DUIlJjm1f6tWlSLow31cw8MR5fAc10bGWyY3Ia7oedxDhdNkYudsZ8kCYX7WmzBrc4oAAnq/eArLkuut9dJwVcAyoSGwd69x6IdhJukUsi92lTQ3UZcq0lmknU1UxdPlpGgFKCjFHaSHWbC6ptp2kAMvhayLao2uhc95Lxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196712; c=relaxed/simple;
	bh=96AqxT/QkGQVZmvKVT8l9e/Ic/Ha4DrHgKCuQXbQrGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oZXLXkcsMItesml+kEAXjwZO2r3q3OQ9z7UVDeYq4NRwDfFVmLzcIUvcYjRVcZKaHRjjiQKQEc8a3y8EC+Tad/nlLMk7St5QRm3AxvWjki+Bya8KokLLvCjmlqexJNo0Yz7XADbByavRD8SUlb6No6ppODPH8G4Ucr20zSNSJWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T4piLhcC; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718196711; x=1749732711;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=96AqxT/QkGQVZmvKVT8l9e/Ic/Ha4DrHgKCuQXbQrGQ=;
  b=T4piLhcCccvZaISbY3FojWllr98KK4JLg0+exflXtlp7ZFXWp2M2TiGW
   U7TaqR/NSh9ag+B8WR3fP469KIRONYB+ZKGmR/2Y49l0Xcsy3c/bZx/Vi
   WPTU+/XJmXndGPMKCXaZdnoaHKl6zWzXNAb6rui/UDd6r7fzZn5kuUUbk
   htqGNmAw3LYlhRcj/W6dKnDxb6b2Sc7pNZ4/6qFuTiB4adZla4GOkSvap
   uFjOTT9M4iLuHQkmYJMI90GttiPWDGuF8WxVqQ9x2TQSCyN89hTMiE+vm
   ZNzm7I7+sbqCD2nBVvHTqPyY3x2kGZi5zDya/+JCAhJ5mUiHjRNeB7A5F
   w==;
X-CSE-ConnectionGUID: cw0ogEILToCEx8Ramboduw==
X-CSE-MsgGUID: GtJa7k0iSe688uujUHDbwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="25584360"
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="25584360"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 05:51:50 -0700
X-CSE-ConnectionGUID: m+Oa4GXFTNm3jFE218HjSw==
X-CSE-MsgGUID: glBrvhc/R0eNQJcykyk3fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="40249253"
Received: from lkp-server01.sh.intel.com (HELO 628d7d8b9fc6) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 12 Jun 2024 05:51:50 -0700
Received: from kbuild by 628d7d8b9fc6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sHNS7-0001XO-0c;
	Wed, 12 Jun 2024 12:51:47 +0000
Date: Wed, 12 Jun 2024 20:51:41 +0800
From: kernel test robot <lkp@intel.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] usb: ucsi: stm32: fix command completion handling
Message-ID: <ZmmZ3Qbr3GdZNnFw@67627e7c46f4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612124656.2305603-1-fabrice.gasnier@foss.st.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] usb: ucsi: stm32: fix command completion handling
Link: https://lore.kernel.org/stable/20240612124656.2305603-1-fabrice.gasnier%40foss.st.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




