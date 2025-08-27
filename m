Return-Path: <stable+bounces-176459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A7EB37A50
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 08:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90183BFA9C
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 06:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1086C2E7BCC;
	Wed, 27 Aug 2025 06:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UZ2octCW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4493C2E1C54
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 06:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756275965; cv=none; b=CpwirSuewFVadOtPCEK2SaMZ5qJHu0EuqB/dWgofgGT9xyWozwM/c7egsMlAp61y2dkhuTCUfpEMa9ohbQwSteESEalCS0UKZ0oojviF4lGFk+fj0AuEa+iQOI/6QA27Ttm1k7yl8GfMRmFPp+VvjgRn/8x+C7du273/7edRTT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756275965; c=relaxed/simple;
	bh=TW1cXrpSR7E2UjHHI4SCKiESn4T7NRKyLvZRfP+D/wc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pi0l8l6+HuYas1fCRFuU81I/l5YeIzni+ezBsn+6dKCI54R8DdkBCfZy3CLqOxjJ/5NUoFPTFtGlXRcr8crpE3NyO6eqb4iAg+Q9R7oZFY/duAGNl373pDhQnDUPtcyPXbT+ksbxXX/bK5wXMXJfjox0qN13AL30dvuRLAYnnXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UZ2octCW; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756275964; x=1787811964;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=TW1cXrpSR7E2UjHHI4SCKiESn4T7NRKyLvZRfP+D/wc=;
  b=UZ2octCWA2F9zk/tEsiGQ5y1Y67+52Eptju7Ue1Ab/ck6iolX8uwDee1
   feWOXU59fYtVP1mw0W2m4KA5Kx5B5EaRdUXH+pwJ+mKZlbZH0AABwD5CL
   yEXutTxo9kp3md9wjCw5SnpzeGEIc1jrvZDMiJxKDH4Vwe4TORBzfHXD7
   /k5ksQEkcKwWYnbnTliXyMGPuyslFMs3HL2Bn3wtgSR75L3RfElkeYIJA
   43uBLzNfYR1R9YJ/1l/ebAl7+T4tONgaP+fBI2dXsWpp0sAHA+ZQQ9GN4
   C0qB2XVnnQIwGax+yPYL3tB6lbEcI8XvIAyOB1qO1zoyYY5TOW9jJH5JV
   g==;
X-CSE-ConnectionGUID: 90Zp+TN6QoSRbD5YRIxSWA==
X-CSE-MsgGUID: qLE/R15hR+S5NjOZO8ZpXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="76121677"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="76121677"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 23:26:04 -0700
X-CSE-ConnectionGUID: lPPYg4yQT+qqhoCdfiGgSQ==
X-CSE-MsgGUID: /3R2T5xISMaQBdV6hwGprg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="200713245"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 26 Aug 2025 23:26:02 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ur9bI-000Sjr-1t;
	Wed, 27 Aug 2025 06:25:49 +0000
Date: Wed, 27 Aug 2025 14:25:33 +0800
From: kernel test robot <lkp@intel.com>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net v3 2/2] selftests: net: add test for destination in
 broadcast packets
Message-ID: <aK6k3bQh47Xdw34n@0d8035a08681>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827062322.4807-2-oscmaes92@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net v3 2/2] selftests: net: add test for destination in broadcast packets
Link: https://lore.kernel.org/stable/20250827062322.4807-2-oscmaes92%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




