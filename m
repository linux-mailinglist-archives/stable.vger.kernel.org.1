Return-Path: <stable+bounces-86532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 932AA9A11C2
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 20:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E3B286975
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 18:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017E02141DD;
	Wed, 16 Oct 2024 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AxBN016f"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7F9290F;
	Wed, 16 Oct 2024 18:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103811; cv=none; b=MIHyX59//B4qQLxH8MhSlTjFT1r2x0/K0xY5r4s6EUyRjJrxTkCX2URFNRyvhdtCRUCVkHTJyamGsPjC3m/bjBFdZAjpaQeQNHotrjg/MKlwLgQGKbA/SXuld2Qq7jxwu0Qk+mJCkNexOUhdO5YsB0LENtbO7OYk6gJE2JoOPDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103811; c=relaxed/simple;
	bh=0odqZWPk+leaDU5OpiWhybSbr8swW1KSrnvPETAtWL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2TEdmTsvLo5IyzwW+tS3Pjlcfk6hYOUCdQwWqLJdnMLZXooIh/h4JPobiveKr/0p9Kou6VBUmHS746G2W35DOpfGcvYFn7SoJWrcwq3D+NTGYyjdvZkB9YBNJqTijMv2aN+Sf/4xhc5zD12dwO9IabUMYXIvemZ+AY/1/KmPjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AxBN016f; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729103809; x=1760639809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0odqZWPk+leaDU5OpiWhybSbr8swW1KSrnvPETAtWL0=;
  b=AxBN016fbHSOnlkXz3LlkRM9vtYeUndOer8LYdlAgYAd7bWklyQJpwcH
   +xaI10LSANVkHE2z5AE5hvDOuXpePtZqZcZ5jjI9ks/FellKCpTbkAXBI
   0Ivk64J0FB3PMmWHe5df+/k4e3uK/0U9oQin7pK9pKGH2jC+6cuogH3IA
   s8s5FxAMDSbu66OWq/BgfKknMgStoPn8dD8zJ1Zmqhni0cQDw6FI7eSsN
   vC75gu7ecl91PuubIdWuWKYoJsZgr4iDWFXnkbdHNnuHTUGr+ELiA1WE/
   10gTQzpR7NsKv+lrk66N9Qqvz18XFL9PPgb4FjSGIP56bE5160W9AGsip
   A==;
X-CSE-ConnectionGUID: ca5l9JdeRrGoBvGAL6ziMw==
X-CSE-MsgGUID: +oXfJBTiQMiIlzThTr5a0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28455252"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28455252"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 11:36:40 -0700
X-CSE-ConnectionGUID: o1aRxQG6RVu3ESpyMhvD5w==
X-CSE-MsgGUID: UeCZl5FKQpmyvsXMqjt2jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="77967661"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 16 Oct 2024 11:36:38 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t18su-000LGx-18;
	Wed, 16 Oct 2024 18:36:36 +0000
Date: Thu, 17 Oct 2024 02:35:51 +0800
From: kernel test robot <lkp@intel.com>
To: Jann Horn <jannh@google.com>, Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Frank Mori Hess <fmh6jj@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2] comedi: Flush partial mappings in error case
Message-ID: <202410170234.hthSWOJg-lkp@intel.com>
References: <20241015-comedi-tlb-v2-1-cafb0e27dd9a@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015-comedi-tlb-v2-1-cafb0e27dd9a@google.com>

Hi Jann,

kernel test robot noticed the following build errors:

[auto build test ERROR on 6485cf5ea253d40d507cd71253c9568c5470cd27]

url:    https://github.com/intel-lab-lkp/linux/commits/Jann-Horn/comedi-Flush-partial-mappings-in-error-case/20241016-022809
base:   6485cf5ea253d40d507cd71253c9568c5470cd27
patch link:    https://lore.kernel.org/r/20241015-comedi-tlb-v2-1-cafb0e27dd9a%40google.com
patch subject: [PATCH v2] comedi: Flush partial mappings in error case
config: m68k-randconfig-r071-20241016 (https://download.01.org/0day-ci/archive/20241017/202410170234.hthSWOJg-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241017/202410170234.hthSWOJg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410170234.hthSWOJg-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in lib/slub_kunit.o
>> ERROR: modpost: "zap_vma_ptes" [drivers/comedi/comedi.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

