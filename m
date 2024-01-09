Return-Path: <stable+bounces-10409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BF5828F41
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 22:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79B2CB21286
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 21:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FAB3DB98;
	Tue,  9 Jan 2024 21:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TSAEYi3H"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B8F3DB94
	for <stable@vger.kernel.org>; Tue,  9 Jan 2024 21:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704837177; x=1736373177;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=QuGtbf2oN2yn8eGjobkF1x7ubg1GNFf76zJGDEJcv/Q=;
  b=TSAEYi3HAoatFG0qyntA24Ag/lKN5N6vbDXa2cRK0HNJb4aovBXzjevH
   L1OKdVeesZOqmU5zFWoUFCMs9i8NDZ5wgWGB6kSkfFwR+U500jjqlISF6
   na93Fm2CQ2lacsx/V5mJ7ASZUwKlXDQpyX6WAYsiU6+GGTdJYzn33iQ/D
   heSiIZeVpyr1gJ2QsjiB8wsitD7p5Xzb6pcs1PHkKL9eHyoufzQegKXue
   /WTFBO6GeeeW9eYrHLNaxILd1miTKuPdb9ANfbi4iATeDiLyL8xzJvrAI
   tezZklEvJJupb6olvre3ihV2edFOGn7U8S7LqZdLy1fQGef/fRtp5ozem
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="11678392"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="11678392"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 13:52:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="758126732"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="758126732"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Jan 2024 13:52:55 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNK1l-0006I6-0i;
	Tue, 09 Jan 2024 21:52:53 +0000
Date: Wed, 10 Jan 2024 05:52:07 +0800
From: kernel test robot <lkp@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH for-5.15] perf inject: Fix GEN_ELF_TEXT_OFFSET for jit
Message-ID: <ZZ3ABxSfmI6UXN34@c3f7b2283334>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109214955.451513-1-namhyung@kernel.org>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH for-5.15] perf inject: Fix GEN_ELF_TEXT_OFFSET for jit
Link: https://lore.kernel.org/stable/20240109214955.451513-1-namhyung%40kernel.org

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




