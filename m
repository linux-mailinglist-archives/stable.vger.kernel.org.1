Return-Path: <stable+bounces-70293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2977C95FFE5
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 05:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48941F22651
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 03:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1ED41AAD7;
	Tue, 27 Aug 2024 03:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KKRGNiJg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E470617BD6
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 03:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724729807; cv=none; b=QgxpKVrJuguhSh/yahX0BtIsKygVyjVq7ZY2Pr5ytRrka5MLLmAImielT7NLyukUPeaO+ajl3kTey2B6cXvBN22Xp+e7Z9lbuW5BNd9kaE4EbbsuVoqQvMjWK2KLMVMG5jqnxZf0pqWJmMxkw9YAnQe0eQ3jFlTynJaIT5azz6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724729807; c=relaxed/simple;
	bh=qs9vqYM5ILCoCrBn2JGgG4NT+I9NNypOzJi1ynVDFeg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=I5WWApsdC6hI/G9eWhIC1OCgWy7+mDuA7M/YpC2gnGf5T+HLTSRUUaYHrPdymagsmjAGutmtU5PRjmpIV6VX3Nta8qP6bNolPbBwC2PdPj4wSxw6VZs7NXgk8zTNoTdrbIdo8b045Hn1CQRHCa/S4ykmjxBRGnnVjB88zQbPI6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KKRGNiJg; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724729805; x=1756265805;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=qs9vqYM5ILCoCrBn2JGgG4NT+I9NNypOzJi1ynVDFeg=;
  b=KKRGNiJgeIYMD9eo2t/olJvz2IY3mR6219EUNnWf3+zm8gACdvyuOMEt
   Abgr/yuKHnnl8SjK43LJIetGEMN0XbkPmNcdObu766CPXyhHrHRsmZ4AY
   aD4ECNnL9f+EjZ/V8iFgU2gSrDi5uLkPECQWPsAbQBe1Fh6CnV2+C8maq
   PQVlZeUjE5IQ+FCzV2WE2+bcrl/voKNa5BAAXldpt8Zd3xMxtd5o+lcad
   60AWGLy2Plu7gYEPGH0JWDHWbWSy8KPVjakVK1DhlJjqmzRGEz7AVbGRa
   pXMf4dB/e69BqKljUammyiMI4aXqR3K+jOM4JdG5GOm5m2TZ4co+3mxUE
   w==;
X-CSE-ConnectionGUID: zh3E3IdbRJKgJJE+i2XhTA==
X-CSE-MsgGUID: v5Uzln3VQk+gI9ixXdt/iQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="40657724"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="40657724"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 20:36:45 -0700
X-CSE-ConnectionGUID: pCP8lY0lSIKpKLWlVHFhTg==
X-CSE-MsgGUID: 0fpEG+ypTJGSqL6bzIU2Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="67068436"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 26 Aug 2024 20:36:45 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sin0c-000HrC-1H;
	Tue, 27 Aug 2024 03:36:42 +0000
Date: Tue, 27 Aug 2024 11:36:36 +0800
From: kernel test robot <lkp@intel.com>
To: Yanhao Dong <570260087@qq.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] cpuidle: haltpoll: Fix guest_halt_poll_ns failed to take
 effect
Message-ID: <Zs1JxGfEn9vL_rLY@36921a91ba0e>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_65D10BAC9579867D29B79F44D999AED1E506@qq.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] cpuidle: haltpoll: Fix guest_halt_poll_ns failed to take effect
Link: https://lore.kernel.org/stable/tencent_65D10BAC9579867D29B79F44D999AED1E506%40qq.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




