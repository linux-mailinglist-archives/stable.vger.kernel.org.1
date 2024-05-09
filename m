Return-Path: <stable+bounces-43512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C63648C1785
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 22:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62CF1B2594B
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 20:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5933F81741;
	Thu,  9 May 2024 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DPuMysuj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C831680631
	for <stable@vger.kernel.org>; Thu,  9 May 2024 20:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715286565; cv=none; b=C1frgyKjm6e59dE45URA2kFKgc1nOSVPIOC0qwgL+wyuccI4Qme2TAkAY5qx1SiNlJie7vJ2Uw6u6Jp2CMmkbSkXAKlzMQhe8OdTsKdCPieFYk0A/nTKp/Tct52DGYxiX/Ijg9c8IeKRLlGnvfj9CxgHYf5gGR8zc3dni6WLlJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715286565; c=relaxed/simple;
	bh=k2clpoxEleqdiZ2W8l7/weomsOpm5xXGa1qiQL1ZUG0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=adO6EbCTKtuhLTV2EK8WM7auyj9RmxAePqa257GXR4bmpeh8fs7ebUC+UYG5r9hNDIZKq7zTv7SQyV8DYXny3sp3g94PH9s8SLh/ACf+VCW94N3EZ9swq9axHJS569NdbGMutvAC3ahn/PXtjJ0vA6oyaDuVPiFsdwC0ZRs+kUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DPuMysuj; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715286564; x=1746822564;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=k2clpoxEleqdiZ2W8l7/weomsOpm5xXGa1qiQL1ZUG0=;
  b=DPuMysujhiolB6oXbyRG0KJ9lLLllW7hq8QGBsvgt+wOpE7HX8rbXFVK
   mstYIBfca5QqABZwJf0tY6Vl5Sb7V6WhUpT/yj1vq0EIhcpP8hXrC/6Nf
   LIgiqDKdOAa+EDVaHrdd8tGWJ6aHtmG0/r0zx1KjsThvprps0ee1ycXbs
   7oorQm9grmdHq0d/NplWj9Jl3ONS73gDjRec6V9Th4DPXYIsZ8xb1XUgu
   tWpeTpHhzKH9jvOlokC4AfXPgM+abAmZki27cAbgZu1KVLieXqgDTFmaR
   B2CcAo4X9VnR4a5bhMzc6WniIyre0My1yAt3P2pNQp+axyUbsf/ld7Zx9
   A==;
X-CSE-ConnectionGUID: 5saNMBjoSe2Hw8T8yN5DDQ==
X-CSE-MsgGUID: 3PBfftVjQd6zwGiK1Gbzdw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15046586"
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000"; 
   d="scan'208";a="15046586"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 13:29:23 -0700
X-CSE-ConnectionGUID: Mx1LkDo7TJeKV+GoYr0pfQ==
X-CSE-MsgGUID: e54QywOKRDWzGcSuru8fQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,148,1712646000"; 
   d="scan'208";a="29924149"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 09 May 2024 13:29:22 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5AOF-0005KP-2L;
	Thu, 09 May 2024 20:29:19 +0000
Date: Fri, 10 May 2024 04:29:12 +0800
From: kernel test robot <lkp@intel.com>
To: Leah Rumancik <leah.rumancik@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.1] MAINTAINERS: add leah to 6.1 MAINTAINERS file
Message-ID: <Zj0yGLZM2b8KDTLk@974e639ab07c>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509201735.2208865-1-leah.rumancik@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 6.1] MAINTAINERS: add leah to 6.1 MAINTAINERS file
Link: https://lore.kernel.org/stable/20240509201735.2208865-1-leah.rumancik%40gmail.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




