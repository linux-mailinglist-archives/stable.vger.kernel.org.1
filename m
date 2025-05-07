Return-Path: <stable+bounces-142078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9DAAAE373
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 16:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D333AEF0E
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 14:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DD51FF601;
	Wed,  7 May 2025 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OdFbB+hN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4A2257ACF
	for <stable@vger.kernel.org>; Wed,  7 May 2025 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629085; cv=none; b=QadCoJg9uWKTp5dDmqwcb9UmlOWwRH2gbFN6yi1TU3NoqUyMSB/LZj7t1LTh8fUzunAC0el2FG5FdBlzRy3f+DVJX2sJWmaWsuLUMEzO9EusSAVs2xVtmp+JgwnGbN/Ef1Ml0l23QWukKi8tYlyYszMPceYB3nMsm1lieTZsXJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629085; c=relaxed/simple;
	bh=n8EI7E6Dz6AzwEes/6/LRkBeJ5KMDspkzsKY7QNj+H8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=re6WUjdcPcNkUHskRIKJXe3M+LiB+qvRK+O2ecJRb/mYndHJ1LvA1cvkwkF7w4QYH7h0nTrACwUcR2BDOi6OTQOKZEtG66b8Ljw+1EI4HQVkqGAq046LVwnHLuZ0SeVDOGRqs4xFP8D8MXMzxFMXs+QYRhsRlGflMFYHfpREKHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OdFbB+hN; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746629083; x=1778165083;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=n8EI7E6Dz6AzwEes/6/LRkBeJ5KMDspkzsKY7QNj+H8=;
  b=OdFbB+hN2bOwRGuK+6Hia9jwN9aqM7NbBETTI6/BjCjMDhbE8G8erade
   T/3/XyUeGruot/xJr2oYnMDVV54cWPWhjuhz/6KxSYw6FkdW1ykdsw2kA
   erevkFAmjs73MEY+Nh+ILhZf2BTf5eI9VmHvUgSSAJkW6+0PZH4htL9Gj
   PDd69UI1qs5WfCTwPVJLD29w/T7a11205OzTUxpcq7ztv02kumqA3bU3h
   jlKnKSSdTYndL/bLHKVxdI+dBNNtsm2kd+Yn23uTmWKj26a3KinYYjOTp
   F+sRjdZelagCNmDuKEuI3QhX7I0GmE7Bo51c7VOpHdHUeevo9pivLT8CL
   w==;
X-CSE-ConnectionGUID: y2I4/PQbR6izfmdchFOsuw==
X-CSE-MsgGUID: ZPWFi2cRS/+5YdHLn8wJwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="65893900"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="65893900"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 07:44:42 -0700
X-CSE-ConnectionGUID: 6jczajH8Sl201PDxomnKCQ==
X-CSE-MsgGUID: NmJqAWPaR9aZSVLpZFutNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="136001085"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 07 May 2025 07:44:41 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCg0l-00080T-01;
	Wed, 07 May 2025 14:44:39 +0000
Date: Wed, 7 May 2025 22:44:31 +0800
From: kernel test robot <lkp@intel.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 2/3] udmabuf: use sgtable-based scatterlist wrappers
Message-ID: <aBtxz_RNTlOc1M9b@908e72e18855>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507144203.2081756-3-m.szyprowski@samsung.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2 2/3] udmabuf: use sgtable-based scatterlist wrappers
Link: https://lore.kernel.org/stable/20250507144203.2081756-3-m.szyprowski%40samsung.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




