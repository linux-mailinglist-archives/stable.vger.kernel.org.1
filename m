Return-Path: <stable+bounces-148102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D309AC8098
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 17:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D1F1BC4A00
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 15:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847CB22D4F3;
	Thu, 29 May 2025 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lfFY/5Rp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90801D63E1
	for <stable@vger.kernel.org>; Thu, 29 May 2025 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748534198; cv=none; b=KhdMqmePb+3LK2dNRsuOaom3pus0rdMORK3J5YvkW4Zuqj8py2TahhgTuEY+7E2b+5gQg9ZygUv0zbV+o3WLxGVbLdTtrsrL7AH05vkJPcANAHfeXMVQPSVLpn4x+AuvXJIdYZifnESt0oqaO3oSVfuvkLVpUJsQShEzf174eE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748534198; c=relaxed/simple;
	bh=tv6xuySHiDV4gLx610hgH6ikU7dn3pueKI2mAG1PpDU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IXy1X5LY/mvI3eTHXF8oIbIQ9bu9cESJBS/Lq2XEJ42JZLT5XdS7s9i6FOWp3IbAnv78E4vmoOLyTYZITMLQGAUL5BjjXfGic7ifEdhD1Qc1vvs8ZnQ/eQnUERZTi9Z3EZtT/X+mCNd7X5dEzRSueKzin79omokqIeaLy8gzHN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lfFY/5Rp; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748534197; x=1780070197;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=tv6xuySHiDV4gLx610hgH6ikU7dn3pueKI2mAG1PpDU=;
  b=lfFY/5RpIA6sU1ecPr5wx+NvduYtz1+/EK45aHSckeeSyWwfNJ3OqsvA
   p9dmI5bN9mbjKdq676eA4PXL6Wd3CzfqDcRIJfUSiGb1zio6NM6ssIZ4Z
   qzO8XjQaGyJEkyv9+8SLGqEsObK6D4CUjidZO20kVQXnRmdsymPY6VC24
   hFIqpbup8iDDx/OeoJ/vuvzOvZGML/JGWLgcHi2z/twwDwesuQusGY3sS
   Mr9BJKzQPATFpEA/i+uFiPAz+BZa+tAaML8VfMGEiJH6ltPzMmMAWnmOU
   BaZJXz1Pgezlbs6xaNiMeISB/uFedUZw8hbybxjRg9dcL6wAd0ZUTvG1i
   w==;
X-CSE-ConnectionGUID: Zn2l92uhQNux1vil1m5nLA==
X-CSE-MsgGUID: AWODXeFOSXqQMbDdR3F3bQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="75997176"
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="75997176"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 08:56:29 -0700
X-CSE-ConnectionGUID: N3F5Ymg2TnuArm511Ht9Xg==
X-CSE-MsgGUID: xVYBBVtXThOYIkqPPNON6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="148465365"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 29 May 2025 08:56:27 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKfcH-000WqC-1q;
	Thu, 29 May 2025 15:56:25 +0000
Date: Thu, 29 May 2025 23:56:17 +0800
From: kernel test robot <lkp@intel.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 4/4] selftests/mm: Add test about uprobe pte be orphan
 during vma merge
Message-ID: <aDiDoQyUxtdXVVcg@ec7822dfdd1a>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529155650.4017699-5-pulehui@huaweicloud.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v1 4/4] selftests/mm: Add test about uprobe pte be orphan during vma merge
Link: https://lore.kernel.org/stable/20250529155650.4017699-5-pulehui%40huaweicloud.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




