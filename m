Return-Path: <stable+bounces-179019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6656B4A074
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 05:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720DC4422B1
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 03:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9401325A2C7;
	Tue,  9 Sep 2025 03:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RiXHopAQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE2A256C9F
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 03:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757390393; cv=none; b=e/pfkQPfYj02FAJwLZR6Dt+Qun8OyYTGivzZXE6Jr7JYJL+dFFYI298oOk6UGEjZJaEhNQydRg/ITUgMYCVPJ4S400FGdpELor7UkFSupwWBAAEFDrCNBa/Z5TYFLkVBqF+XuJJdzLPvTe5KjR2VaDJMRXFI0q3c3V9mlAAnS2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757390393; c=relaxed/simple;
	bh=tKaXiMBXdrt3j2SMYBHZzziz4EnMkmNGVyOfVXfxDZA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pxq0Z5EPe092U05nHxmJSWClAKCFCjccafF3jWX7VWwlqta/bRGTmdSHiwqsDWQMwcE7IGISSFNTQMPTYNeawG49KMi83cgp4kEIADvHC9jbcRk4JBjUbtXC2lLAXqUV9I+1Ben2frn2+/YTZFC+AO4KoiR2FXXgk7fmpVO+oEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RiXHopAQ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757390392; x=1788926392;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=tKaXiMBXdrt3j2SMYBHZzziz4EnMkmNGVyOfVXfxDZA=;
  b=RiXHopAQsjhealL3kDlFa1/7SYc34Ok7FhWfZbisqmWsnTTw174LPiXT
   PzH3xmhy4KSY7tROqapIGTv96D4xuQnQIdQ06bjhwcBydVAOLWUmVlL0d
   6uIW3o3GbRg7UYBBMxV9kUa4+5gk4xuIoFFZULXPvivk4jz8MmARxOvFR
   JNMpBnS9vIEAGy8Zz4r8hBvz/vxSgFu1VfCs36Ori9V66HD3/kri0rYNX
   ln3QU5g52r5HL0vUPQIdwqnvasE800c0ypJn7cbbT0Pn3aQvYbpf6g7/K
   ETWwpgVT/QwMZ4kp8GJ0DfgD9sbCzjMI1VYH3+qq0r+YswdL6llLGZJ5C
   g==;
X-CSE-ConnectionGUID: 8D1r8AXTT8ycqK3Qn7wnRw==
X-CSE-MsgGUID: 1F3/rX72SzaDradzIrOGVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="77119808"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="77119808"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:59:52 -0700
X-CSE-ConnectionGUID: 0HYpvSBwR8KLBBoyVHmivg==
X-CSE-MsgGUID: 1N8zrSToTvKd4ARxkhx8Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="177025565"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 08 Sep 2025 20:59:35 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uvpW1-0004PP-2C;
	Tue, 09 Sep 2025 03:59:33 +0000
Date: Tue, 9 Sep 2025 11:59:02 +0800
From: kernel test robot <lkp@intel.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net v2] net: mana: Remove redundant
 netdev_lock_ops_to_full() calls
Message-ID: <aL-mBruz4MopCwOJ@b60466e413ec>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1757390253-6891-1-git-send-email-ssengar@linux.microsoft.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net v2] net: mana: Remove redundant netdev_lock_ops_to_full() calls
Link: https://lore.kernel.org/stable/1757390253-6891-1-git-send-email-ssengar%40linux.microsoft.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




