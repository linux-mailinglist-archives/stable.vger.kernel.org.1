Return-Path: <stable+bounces-12181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E803831933
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 13:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C8D1C224D2
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 12:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC21241F6;
	Thu, 18 Jan 2024 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VVec4YZc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D562C22091
	for <stable@vger.kernel.org>; Thu, 18 Jan 2024 12:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705581319; cv=none; b=IJxWKZOs5qNNFmM1e7BXrlKMuxRg47AxDLGWrsUI5xAdUvu05xU90E3DrOI53ao3P4LImkcPYUZBPVSIRby8/OXiQaSWMpYgnlDmxVSEhNC381+DNB4bAiqcFaNGlw+Gw1TtTRziZHqwOgeFNCdWNzhxTTBnbLWHxXbl55Fi1hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705581319; c=relaxed/simple;
	bh=w+w57AEV/S0xE0T/uGeXoKyG/1xc+AjqLHJfKA6whPk=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=TRmK+MLiBkpj4h1WN0MRSowc1qKRuI0rigQIUdTuzwHT9XdECK1NrPoLGMzeg3LGc0og5c+RsAJKh5FXYC66H361n42YEXUlBGgXK2hfbfeBRhKN2Y/28+RTPzkw8LnazdohusDDBkzl5aofdub9NgrcsXjn6QsjX0o7Jgm7sGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VVec4YZc; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705581318; x=1737117318;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=w+w57AEV/S0xE0T/uGeXoKyG/1xc+AjqLHJfKA6whPk=;
  b=VVec4YZc5RB6O2tayYwmrXu2k9kDWMsz7hvDeo1zjQRocOnw8G6BKL6x
   /XzbJHGF/QzmsFT3LA/n7R6N4Vpj/A1da2WNZIVmH+SoqVEGkDfRhbYC/
   o0ayetMr8He9rNJNtiWoXpTfwe3Eoxe5JMRH8OzKYA5GI8q8MYaXOAfkn
   Q6kMGg1wxL9ypRvLLpQqXYKq2DEdcTDOwFv6PiCysC56w4j9YF57sldmH
   UboNWa473j2AiBI6KoKw2BszEFuD+XItbvl/owORUJIFGvWNbB2aD82ki
   EwsI4rPm1VI7WyVaFatP2tkzx/EhOre7x2q2f6Q9YUR5t7Vbe/soEbRsi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="336992"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="336992"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 04:35:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="33105203"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 18 Jan 2024 04:35:17 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQRc1-0002zA-3B;
	Thu, 18 Jan 2024 12:35:13 +0000
Date: Thu, 18 Jan 2024 20:34:52 +0800
From: kernel test robot <lkp@intel.com>
To: Denis Arefev <arefev@swemel.ru>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] comedi: drivers: ni_tio: Fix arithmetic expression
 overflow
Message-ID: <Zaka7NnU-DIn760z@016e4bab3561>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118123348.45690-1-arefev@swemel.ru>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] comedi: drivers: ni_tio: Fix arithmetic expression overflow
Link: https://lore.kernel.org/stable/20240118123348.45690-1-arefev%40swemel.ru

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




