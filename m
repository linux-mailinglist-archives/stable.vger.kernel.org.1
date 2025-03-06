Return-Path: <stable+bounces-121186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44603A5449C
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 09:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A491B7A38A6
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 08:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DFA1A9B3F;
	Thu,  6 Mar 2025 08:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ImhIKoIo"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D20E19995B
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249266; cv=none; b=SeFNP77eNslKE5bYDyGTg67nHcLTmDTBNSldDVjER4iAnrwZ7WYFbDBOCjqCg8/LNcscqnHvxbWazXAhZn0/Xp3olyxoVj7xbGO7m3Eai/cu8bq6KYgOFc6Ix0aWCoTfP2kzXQyUxgesRO/eoodl6fU+edEeHEGSMDJc+W+QAlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249266; c=relaxed/simple;
	bh=5JMTSz+Iext2fF3GSACvsD9IlDz27olamKQwW7XF0Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=g+1hpM+8KA91/r5BygbxBnO13DAHp0VgdBEWrVU3Qtpc6RO54YeexXphkdrcS6vrO2rul9Ojbr+3Z5I+Ks6ITbqLYEL4vhbQgpta1OzaDdRboC0wGrq+ccNHeUJqoQaalSyE5rWtTnx4IpkejBXKP5E0iCqOG9d5xV9gim1+4I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ImhIKoIo; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741249266; x=1772785266;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=5JMTSz+Iext2fF3GSACvsD9IlDz27olamKQwW7XF0Ic=;
  b=ImhIKoIodrIk1s6waIaH3yA3GnjmTH+98OQuo/7qsz+mzfdius+qLLm8
   J9O9LVzwsw47gtFQemuqUeIBQmcyqdlNsoKsLgTjuU/zURmcFYI8o9Xja
   S3SQbModkwWmwDWEIWS/z4PTrOp3lWI9tiKFyb6Pc0x4tVfMpRKviiNic
   yZINo7zRbqk1qCjMhGkQq9sQK5dFBdwK4CUv5rgqo/LAFffJ/1ayLV6zY
   L8Rk3CLEGNDKa05AQjWCOUewUr7R2DdE3qT+LOtXw8axRABRNZFFz2QZC
   taGI9pco+5h4NGtuGAyWFay7n+naVndgI7drzlIBiSGBtYOlRgARDHTNs
   g==;
X-CSE-ConnectionGUID: mi/3nqVGTXi8FVMiNVXXFA==
X-CSE-MsgGUID: zlFMPsRAQ7qqtB8op8zwnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42159967"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="42159967"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 00:21:05 -0800
X-CSE-ConnectionGUID: 61TbS8JgTO6K3UTZ1aD6Pw==
X-CSE-MsgGUID: fPJUqDclSfqx7TeQQ/U97g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118869880"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 06 Mar 2025 00:21:04 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tq6TV-000Mko-2L;
	Thu, 06 Mar 2025 08:21:01 +0000
Date: Thu, 6 Mar 2025 16:20:41 +0800
From: kernel test robot <lkp@intel.com>
To: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] svc-i3c-master: Fix read from unreadable memory at
 svc_i3c_master_ibi_work()
Message-ID: <Z8la2WD5yrHWAGTZ@2dca5eb1bfca>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306080345.243957-1-manjunatha.venkatesh@nxp.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] svc-i3c-master: Fix read from unreadable memory at svc_i3c_master_ibi_work()
Link: https://lore.kernel.org/stable/20250306080345.243957-1-manjunatha.venkatesh%40nxp.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




