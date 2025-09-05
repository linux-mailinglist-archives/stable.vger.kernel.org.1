Return-Path: <stable+bounces-177865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 932B6B46083
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 19:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B161188902C
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 17:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDCB35AAD4;
	Fri,  5 Sep 2025 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WF2i0aIB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC3E3568E0
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757094286; cv=none; b=GXonFsKwXZG8Vv1p3TNFe9embIf54y7GDSp25rs87y+zV7YRY4YaSPLEoH59vhbgRd9F1+WFTN6IxweTi5yEUw/Hm6hgyGx3iXhRv49J80zmQPg6qcDInmhABxpjbtpI6C8vIMIXaWh3+AszhevdutuSuI7KGwDRVwwuyLmobC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757094286; c=relaxed/simple;
	bh=EnM7HnJx03NhrIaIoiZR1EbOnY88I6qE+q6C80Ge1Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sOzW2ItZjUIpCT0UhJc/ZEWhe3Q5dIbo8sb+QvKvzslXcGb0YJ3oajnktzkCem02JeSgq1ZURUb1fclZHzfO8iMaj3VsEP6C2dU1bpOKQZm2K3JrY1VykfRDDPvTOGqGZZA20RDWVoc13KlfYO+wNPnMIYGEuhpOPoDLT6Bs84U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WF2i0aIB; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757094285; x=1788630285;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=EnM7HnJx03NhrIaIoiZR1EbOnY88I6qE+q6C80Ge1Zw=;
  b=WF2i0aIBFSCgNs+RhP0DBOGmiWAAhViSKiqQ/i3RsCxzPQj1OQua2JDW
   zrljPdCI6L8dQEPYIcv1GEDu9aKfpdM/tKobPa15lcl3rpTldkr6GA/Yh
   Kj5NP9j7zMgYpHGePHdcxr3HZxudRv6Ckk5zuC9nUMM51T78YqYsJ+rTW
   2r46s5Eh0eU+wtAwJx1NR+QcFGqBQdU6ithVY++R9d3iNa4VyTvjWJFlt
   y4qZck2HvEKYBizzWXjOFPJooKuXdsC9YfVhwqPQ7Jy/tjLc1jUY6rs23
   TygbOeuctAKEhRY+7mesLoJBxefkne785XVroUn31meI4mGIKX+ODB50l
   A==;
X-CSE-ConnectionGUID: 33sI+pqGSK+FzEyF9jar+g==
X-CSE-MsgGUID: 7KLOzq8fQoeFA/qPWTbvWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="47019593"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="47019593"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 10:44:44 -0700
X-CSE-ConnectionGUID: EBQa4kR2QfqfEP9aXR06+g==
X-CSE-MsgGUID: uq/8/WHlSs2ohh0g/kokEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="172661837"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 05 Sep 2025 10:44:43 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uuaUL-0000gR-0k;
	Fri, 05 Sep 2025 17:44:41 +0000
Date: Sat, 6 Sep 2025 01:44:03 +0800
From: kernel test robot <lkp@intel.com>
To: Adam Xue <zxue@semtech.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v4] bus: mhi: host: Fix potential kernel panic by calling
 dev_err
Message-ID: <aLshY8zmfry2pAQx@b7823f61de85>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905174118.38512-1-zxue@semtech.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v4] bus: mhi: host: Fix potential kernel panic by calling dev_err
Link: https://lore.kernel.org/stable/20250905174118.38512-1-zxue%40semtech.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




