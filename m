Return-Path: <stable+bounces-4993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304D1809DE8
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 09:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4D91B20AEC
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 08:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C2A1097A;
	Fri,  8 Dec 2023 08:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZBt+STa3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C63123
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 00:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702022922; x=1733558922;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=0CN5gRWHhaC+evLCrYmmGd/4Lkxf276NShkMbM3Ox/c=;
  b=ZBt+STa3qVWg8B1qpvV35enVban82rwvQLNxA+3c/pIwWVXcRfYbyfpn
   cVzcPt5rjZO3V+faHxb1N69tpgHuFFmqqoYGtGiweAYwQgtuE5NHQJiM9
   kar6+e2UnE7ZFWEKUGhdgNV4SGQoJBqmx/C4gKl1T7Klkl2rcVOadwegy
   ZXEfbBYjnYAlEsVoOLqwYiOemXWpXvSt3wsbpnsRBYW9WLrSyzVsky1SX
   Hiz9YK6RNeQfOj5JRGa+3bHZh2AdkfqHu+lLn27JAjgJjDPskj+kQp05Z
   oBUMFw/IxSRSaRSMpzHZzZUPkU/6+lvPruKIUQhA5+shxfIfN6lLpC47I
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="374538081"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="374538081"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 00:08:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="772054968"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="772054968"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 08 Dec 2023 00:08:40 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rBVuY-000DTR-1g;
	Fri, 08 Dec 2023 08:08:38 +0000
Date: Fri, 8 Dec 2023 16:07:47 +0800
From: kernel test robot <lkp@intel.com>
To: duanqiangwen <duanqiangwen@net-swift.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net v2] net: libwx: fix memory leak on free page
Message-ID: <ZXLO04oVIASKLiuG@be2c62907a9b>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208080216.20176-1-duanqiangwen@net-swift.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net v2] net: libwx: fix memory leak on free page
Link: https://lore.kernel.org/stable/20231208080216.20176-1-duanqiangwen%40net-swift.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




