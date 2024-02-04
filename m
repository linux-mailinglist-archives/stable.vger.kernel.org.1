Return-Path: <stable+bounces-18759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B529A848A1D
	for <lists+stable@lfdr.de>; Sun,  4 Feb 2024 02:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684EE1F238A4
	for <lists+stable@lfdr.de>; Sun,  4 Feb 2024 01:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB76BEC3;
	Sun,  4 Feb 2024 01:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ReY4whhR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF49EBE
	for <stable@vger.kernel.org>; Sun,  4 Feb 2024 01:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707009599; cv=none; b=BbMVksZ6JSVM9lU+FyCCZTCGdf6ArgB/Ad5+gL9pVdJTwL1zhVHQz8Sy2a4CJeWctE15xroE5C4VlFrluEAjm+afOPLZv3Tlag1uXz9SiCKspoqalZszyOCpHdVQftkdrENNezGAV1FX8q0txYyN1VUGvwtzpIxlc8pIimtzdGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707009599; c=relaxed/simple;
	bh=mnKXM428CTNyQLwynzoZ//XN6QsTIWh7jO+y+amTYiA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WMVr3OKg9ulMwahVFMH6yziaYxN+HDQQHplW84h2O6f4qUBjTsTIxSGN+DBEtsc/jh1vdk19PFzeJOQs8F5ptKRPWAV2ozZYIIv+L+VuC3BuBjF/MtIqOf8nEPh+OJLtjJYzkOUivDeN63p3JJLps11mocPVPriDsaovRp9vTiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ReY4whhR; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707009598; x=1738545598;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=mnKXM428CTNyQLwynzoZ//XN6QsTIWh7jO+y+amTYiA=;
  b=ReY4whhRHoMSmq+zzUPxqFoUpwIuo4VYVOvQ3nw0O1Aa/4YmVoCu8V2p
   kycgGzBoYO7oXpmdAo7ifCw7UiVR4k+81C2I9AjdyWVBmRiyRclhJMoXp
   YG+Xzz5qdqMfkfghXNPOAFnmA+iITG3Vdd1ozNvHNZWTRS/f+LWzU+zLv
   nLN+1gwpACjN6fPsxEg0e099fWxuog/CeBrAdT6iBw42rNG+L+U4IMAvV
   w03qEoc5wDopFeWgXNZetp5n7R5+5KbgciTZSdVnG1RsXAKT/QfeUM8t7
   uqtbBW02B4XEc6HYSbf08lFHr1n6eLwbGJrMP7qNivxQOcLxQeMp76qJk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="273049"
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="273049"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 17:19:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,241,1701158400"; 
   d="scan'208";a="5028409"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 03 Feb 2024 17:19:56 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWRAi-0005px-1M;
	Sun, 04 Feb 2024 01:19:48 +0000
Date: Sun, 4 Feb 2024 09:19:36 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [v6.7][PATCH 01/23] eventfs: Remove "lookup" parameter from
 create_dir/file_dentry()
Message-ID: <Zb7mKLBQYy7egOju@a2a592e9b9e1>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204011827.061811169@goodmis.org>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [v6.7][PATCH 01/23] eventfs: Remove "lookup" parameter from create_dir/file_dentry()
Link: https://lore.kernel.org/stable/20240204011827.061811169%40goodmis.org

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




