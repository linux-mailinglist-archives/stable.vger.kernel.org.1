Return-Path: <stable+bounces-75933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D0D975F86
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 05:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2761F2890C
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 03:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B408E5BAF0;
	Thu, 12 Sep 2024 03:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PDBpAPSK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33B326AC1
	for <stable@vger.kernel.org>; Thu, 12 Sep 2024 03:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726110150; cv=none; b=F0UO0FJIS3bDwCwxFx6sv8jq0ZKfPziTgpN40mIhhRn8R6u4lz3Hl/qgw67VrX49dzZyY0ZtWr086qqv5VwgSNsu1uuuAd0UjgEP84jYsgTVWeJiQBcGtf6a2IifStPWoJI+QWk3Dy7iKlOCxV8DmZRRGfXC21cnuT+H+Fsp6e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726110150; c=relaxed/simple;
	bh=9MeCgRVAvizHKconAD0ure7wUjg/yRrKKzHT1BqpShw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KzDWPL5erFH8nTEYYcww90d8Nk5Nc5bYeKLVwV9RWYkgmjWF7skaROQDffNSXu90+kUQiUUiZdaJiKhq69G3U7E902JFCZs2bs0yvH2pb/9eAop86zY3TflyPDtBM/vSIEx7KmGkqb7NqWJ2gHJtuuumD34Eg4AXn5QW9m/xsQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PDBpAPSK; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726110149; x=1757646149;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=9MeCgRVAvizHKconAD0ure7wUjg/yRrKKzHT1BqpShw=;
  b=PDBpAPSKSNQTNvCwEN1kM82RJZcLlpQsTpLC+cwWp2F/oqA70TW+bEzq
   c41Ur/2Mn4U2GuVVqeD8SCIAvBBkxg7GIwyryKDxUqy0hnzDHcZB5qzvA
   FRrmI6nk2ixV4m9aRVyh0IEexMY24EsYl6zFn8X8tDYloTujWOEEXYCtv
   3VTHzjcTTmOIQdGPooizoFoprPZbjzQEkaqqSB5tFVQZRiTjnc81IC5or
   AHvSJoLJfmqaXw5l1+7UvM3ZTACdQtnOOQ6dPDjRHWQ7PFliDqYzRqEIe
   fLTBlJS48P77YDOYIE8L/tPP5QTT4xLn+2ch238dtjVuJnS8EVGmpgXx+
   g==;
X-CSE-ConnectionGUID: +wSIG6q4SeSFlNnoazMElA==
X-CSE-MsgGUID: eKQ7CmymSeSJmfsLWt985g==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="27860678"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="27860678"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 20:02:28 -0700
X-CSE-ConnectionGUID: 4CTDho9DQhWr4/osXgRSMw==
X-CSE-MsgGUID: D8Q5wje8Qpa/RJk5nSSIvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="67555655"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 11 Sep 2024 20:02:27 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soa6D-0004QI-0w;
	Thu, 12 Sep 2024 03:02:25 +0000
Date: Thu, 12 Sep 2024 11:02:23 +0800
From: kernel test robot <lkp@intel.com>
To: Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH RFC V1 1/1] ocfs2: reserve space for inline xattr before
 attaching reflink tree
Message-ID: <ZuJZv10K_wByMfNm@93b49dda42d7>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912025858.849533-1-gautham.ananthakrishna@oracle.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH RFC V1 1/1] ocfs2: reserve space for inline xattr before attaching reflink tree
Link: https://lore.kernel.org/stable/20240912025858.849533-1-gautham.ananthakrishna%40oracle.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




