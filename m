Return-Path: <stable+bounces-183668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 34715BC7F3B
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 10:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E81664FC8EB
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 08:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA671DFE12;
	Thu,  9 Oct 2025 08:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MG/UghVd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C122222D0
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 08:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759997113; cv=none; b=K/FsaOepRw8/bnUEqSUjVFaSUvqPdj7vVH5Kxo3yWCafP37Fy4VeiaVLy5RLXdH62PpEogWHsKsK8Rk+H2GFQg5+cucGIZSExVW4/RBDdduMujXNRwdg48X7UtNWn6ZoJv9znyw03MU/RE3uwkAf+St1iUMdZXFtgwGNweJc8Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759997113; c=relaxed/simple;
	bh=x7wu8VEj/XWw61eK2kgKqQO/pu9SagULcrbS7iNMxYA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nF1qkqgFMnqvto7QizacHlRvO82c+1OXT5PQd65wMS1jIS+Yb7d4/T55zWgOZK83ntySwhozWx0a+3Q8nbKexMXxTTR3qo1KGQkh+inebx4AGUXmKyYHghKYE0+UfO662CpcCvCOXVrhUsnQe0NTmYh6y5RWDDqoj9V5M8yb8m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MG/UghVd; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759997111; x=1791533111;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=x7wu8VEj/XWw61eK2kgKqQO/pu9SagULcrbS7iNMxYA=;
  b=MG/UghVdcC/UzPDCFGzdi09fvOBrxZ68dvdwHLaZDdlJH4aGNXzYrlf5
   lbvSC6nR0iCc6ihgroed8klVS4JcBB8bDYjadkNoRNg4hCALTFxAy+SsG
   XThgWADafW6vo46OkIkJy7pc6BgWVOpNl5SKs99azD9CMY/A+8c9G182o
   kCvzyzB+Xi3bUGYw8Wt/sJQnz+6wyTUvqHxIF1b5Lgqyf1KH1ThxZt7E8
   5AhKgYAPihq7sdo2OG+ltGLNrJtKPha64GG8bR9Ua02G9srP3BkvUHiTm
   623KAoUN2ptYe+JOAR0M55TPAiItNNxoXv1pZyNvMnmD6/6ufT7T3V1os
   g==;
X-CSE-ConnectionGUID: pzfndbkST5OrqBVnDnQdgw==
X-CSE-MsgGUID: PStWuYmvTY+kD73r8kbexw==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="65848959"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="65848959"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 01:05:11 -0700
X-CSE-ConnectionGUID: 5DWWy5z8R2WiIBxbttUNWQ==
X-CSE-MsgGUID: mcVsCeFBSCiD0/Akdwelrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="179766296"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 09 Oct 2025 01:05:10 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v6le7-0000HT-14;
	Thu, 09 Oct 2025 08:05:07 +0000
Date: Thu, 9 Oct 2025 16:04:07 +0800
From: kernel test robot <lkp@intel.com>
To: xu.xin16@zte.com.cn
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH linux-next v2 2/2] selftests: update ksm inheritation
 tests for prctl fork/exec
Message-ID: <aOdsd6FIbHh1iYr5@d0417ff97f04>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007182935207jm31wCIgLpZg5XbXQY64S@zte.com.cn>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH linux-next v2 2/2] selftests: update ksm inheritation tests for prctl fork/exec
Link: https://lore.kernel.org/stable/20251007182935207jm31wCIgLpZg5XbXQY64S%40zte.com.cn

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




