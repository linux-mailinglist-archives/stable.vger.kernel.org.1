Return-Path: <stable+bounces-75898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1B89759CE
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 19:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC3611F23544
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 17:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525661AED23;
	Wed, 11 Sep 2024 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V4FrzLmF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3221B2EE5
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 17:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726077192; cv=none; b=TQQngCITZ/nNK/LAoSRn7tHgGRWhXduqBFl2Logm0hs9N+PKTextj7yBj9NPQJHlqNXiWlsNtTlQ0RHiVhQR9zqj1zjqdYpz149nZGTSX/a03YRz4h4/jFKYi+POSZxtJ5bbfC/eDRhshplWURHuVJ8O28+rFV+VVRdysqCv5bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726077192; c=relaxed/simple;
	bh=vsPiuPjLz/FdRTmXwKPwu0HKaExVSgIlo+EFcGgajEw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Qvjq9PbgEZ/bFllSH5FKfJcsmCpwNkUIbsDVHKKlheJuI7XmrUDVbfKqi2eUQJPrAoiX6TMGaS1B3RgkohONWa7xANlVQyOZtOhkFMYZ1PXqJDT+WwKW7Ud96ZDp+p+oiBYeF9OBseUVYgIyaG/a1pFq3T/BH9IL6EbHDikey44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V4FrzLmF; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726077189; x=1757613189;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=vsPiuPjLz/FdRTmXwKPwu0HKaExVSgIlo+EFcGgajEw=;
  b=V4FrzLmFjx3+sjpaYaVK8boRdaTsnzJE48GsTHz25TDGiACSXFDArg48
   ZOLaklWMQkdpr/jYiRGXAy5+Li2gKqd0UajsKWPAprgRYi6EXuoKlqYum
   ACNDRrnnt/b9qIlpOuZ4+ERFZsBxORVaSipFC62sCAwpXGVotLqHlEiiC
   m6kr5SN7uTwIdDOgYQgPZvALdDOtrmqOJ9VMWQ3yoPKr1/JNEQCalzFrx
   qaCt/VhAGiQA3tUfEAbsUGmycKLO8ns4mMx+NboLTna9+VkON8gIMsOoN
   3q5dQRN4jvlR/2/NvNhFR1zYWbzQWKXv0VNg+qbprccyd087ktlrSJVm4
   Q==;
X-CSE-ConnectionGUID: NO1wdf4PRdm4bxusWdXJeA==
X-CSE-MsgGUID: e5h0loAsTD2Auxq6sAi8Kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="24831420"
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="24831420"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 10:53:09 -0700
X-CSE-ConnectionGUID: WlPgSP2iTmabQBYZlk0c7Q==
X-CSE-MsgGUID: OtoFJkCzTU+j59qyuKop2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="67166863"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 11 Sep 2024 10:53:08 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soRWb-0003vL-1f;
	Wed, 11 Sep 2024 17:53:05 +0000
Date: Thu, 12 Sep 2024 01:52:21 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH hotfix 6.11 v2 2/3] minmax: reduce min/max macro
 expansion in skbuff
Message-ID: <ZuHY1clkcuQjoa-N@e6eda6b5eb58>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a32131084038312529243bc22b06f0ee64c95fb6.1726074904.git.lorenzo.stoakes@oracle.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH hotfix 6.11 v2 2/3] minmax: reduce min/max macro expansion in skbuff
Link: https://lore.kernel.org/stable/a32131084038312529243bc22b06f0ee64c95fb6.1726074904.git.lorenzo.stoakes%40oracle.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




