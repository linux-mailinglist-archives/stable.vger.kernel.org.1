Return-Path: <stable+bounces-200488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 203ADCB121A
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 22:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9DC14301D1BC
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 21:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAD22FDC49;
	Tue,  9 Dec 2025 21:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YX+ngi9x"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5523081C0
	for <stable@vger.kernel.org>; Tue,  9 Dec 2025 21:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765314851; cv=none; b=KysPBKTWepvV2ItiAANX89Xq1BF/kwMYCthc0G1kmuDCVMWcWR5cRjZT8nXKW3gH7pkDDvatftdvQfhqxsyX7buI3R19I/yg1TJctCpqACaCplmMSzZI8WAsWImxg6TGbopicMuFPOwh89uXbLL66rSgnSmX0OigvbECMxSe0V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765314851; c=relaxed/simple;
	bh=y+nKCCGtegI3QnwAkd/hkQIIGXS2/x3mSykgUgZA43w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=a4/5qKewvoUc/5iXtOadO+cZXLGn0LYHflsVV/zqK92rT1lacX8E7D/aJsw8RDgKJXXYzRSEapPb86STBVcs1BrMR+gmbP2nzoT5HE3phAtICVfIZ7BCeqviouhUElKIhJZqFt3cmyYPBPe1Jij2hydEoSAq/5yOsV2hVRcGs2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YX+ngi9x; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765314850; x=1796850850;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=y+nKCCGtegI3QnwAkd/hkQIIGXS2/x3mSykgUgZA43w=;
  b=YX+ngi9xz3Q6BJhN5ZVgBm23CDL+IHB0W6HxLrKr1ckatiI+atcaAVld
   on6xqs2AwCcljPm/NVmEomDTruX5cZavWOYCqNJVpCSm7JmYwErw8ParL
   Fi6jwcAbwfXcLj5ANYS06USVsQIjOJG450ehx5TO+dNiJY82gDp0r9TM5
   l38xXKNMwTxi0coCf1F3EpI6VkpsVDgRxIZ+1LVZx/Uno1RJ9zczV9pIF
   JSoCfOgdqwa2w3FvwPqd15CG8wIVXQC2w0RR5IUKK4GPFfL+HrUDYHnKx
   GDmNMsWGbRGgLiT15X4FUemNu/ZDTGFDdszbBUo3Q39hVFQNPlPX79vN7
   g==;
X-CSE-ConnectionGUID: TgjWoF0vQ7icc+4rXQhAVA==
X-CSE-MsgGUID: zHbFab1lTQSjmRRKw77PRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="54825775"
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="54825775"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 13:14:10 -0800
X-CSE-ConnectionGUID: NMauCMy8TTuh9v2F08NlhQ==
X-CSE-MsgGUID: i2JGLv9dRfqFghSPLx2HPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="201255830"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 09 Dec 2025 13:14:08 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vT526-000000002GL-1WYE;
	Tue, 09 Dec 2025 21:14:06 +0000
Date: Wed, 10 Dec 2025 05:13:38 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-6.19-fixes] sched_ext: Fix bypass depth
 leak on scx_enable() failure
Message-ID: <aTiRApl5-FFwVSVp@a281ed4ccb28>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286e6f7787a81239e1ce2989b52391ce@kernel.org>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH sched_ext/for-6.19-fixes] sched_ext: Fix bypass depth leak on scx_enable() failure
Link: https://lore.kernel.org/stable/286e6f7787a81239e1ce2989b52391ce%40kernel.org

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




