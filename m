Return-Path: <stable+bounces-172049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5169B2FA17
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB15586436
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1392432778C;
	Thu, 21 Aug 2025 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Za/raImL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11404326D43
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782085; cv=none; b=qXW9IExWxFn/rWUM7SWB0+1UU/AIsIsPCuV9N06ZnPcJqHbzPSCVslWKtBmnSHErHpJVZfr9+y3kc0MSFBm29TtvlH7giLW8U8p7t9ZKOJnT9/c53xhHLnHIbB548biHwOVfxPyaYss6BjExd4As7PF2kZUjJdyoctDnZWlMMmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782085; c=relaxed/simple;
	bh=zUE576WArG3voLzX7uZlLYoufrf30tFbTiOBwnUPf44=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Io1h5StiMTHCi6eTzp8PMYpQuKT7tVp/GI6s6pnzE07dgD8qzlUCKWi7z2L84l0RycOKloDmARKxpDfAlaRcpqtW+I9qQYGUFjOHjACHwjtIFzLTuMcThTFOaSchja7W9g9KfKGSiwiF0aO+dqUsLZ4Neni30mKmjdtOwB5kCAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Za/raImL; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755782084; x=1787318084;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=zUE576WArG3voLzX7uZlLYoufrf30tFbTiOBwnUPf44=;
  b=Za/raImL0MiTPBQWZqRVn6xs74U5wCtNdQdXaNcDPFLN1zNbnGra5/d7
   E2Xv1fmQNS/LFFbmMb0nw8ERnSgTqadZhfr5sXEcXvKnEY49KxAD+1kF4
   gMirw8jZRDlJ+Xfxaq8OLi/Ef2a+BubQUyCQTwzmPEgamI2iqlwkBTZZd
   W+dhnotFZSBFgu3UHZ2TBvknYESr+Jo6BlZuop+qZsujc/Rg2ajsRnJyn
   lPV3oUwi3r7BFnRoHLb4+zi/63JJLloQpJjtxXh3YcdmeRh7uzW1ex6DA
   0ybxjt6FnVvoldKdfeN3FZ1r9QuVZDXEbcm2KJA2mEmTGOK9G8sk8sYXr
   A==;
X-CSE-ConnectionGUID: mjy/YED6SiakyCOFqdDGRw==
X-CSE-MsgGUID: 9156MaLDR/iyqVx+73avog==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58138408"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="58138408"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 06:14:44 -0700
X-CSE-ConnectionGUID: 5dADAAQ+TL+wh7h4Dv0VKQ==
X-CSE-MsgGUID: S420H18aQFKoEpvFS3PD8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="168833874"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 21 Aug 2025 06:14:42 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1up57B-000KIt-27;
	Thu, 21 Aug 2025 13:14:11 +0000
Date: Thu, 21 Aug 2025 21:13:20 +0800
From: kernel test robot <lkp@intel.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5.10 1/2] x86/irq: Factor out handler invocation from
 common_interrupt()
Message-ID: <aKcbcCnHNK-vBmOB@85d67d3e4d56>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821130716.1094430-2-ruanjinjie@huawei.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH v5.10 1/2] x86/irq: Factor out handler invocation from common_interrupt()
Link: https://lore.kernel.org/stable/20250821130716.1094430-2-ruanjinjie%40huawei.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




