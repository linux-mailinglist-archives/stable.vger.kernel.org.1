Return-Path: <stable+bounces-164440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 681ECB0F453
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564A21C8169E
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 13:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C379F223338;
	Wed, 23 Jul 2025 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IScLbj/V"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3585C2E7196
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278257; cv=none; b=HJx9Z2O12WNv5MJOWee5fv/n2iCpL+pyQurIjN/qMbPpK5F2ixavOW9H3TwSyz4+YY8D/qWEGy16GYEQ0NT+wgAiX9Wrku4zpBdHJazbkE/WCHNKK4h6kQXeQNrRA8NOPdaS1KtaLxDjFVeUY38F033mwRx5vvK0mp1jUTwHLxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278257; c=relaxed/simple;
	bh=p3XiUp8mO0ZgRhHgISZZaOt5W+PfFvJWYH3v52PX7bc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NXKoGOPbwnV7GHfWm/fhCaqv8y/Gc53/WUKjap/qo2pVH70rx1GfzRBUnSNy7l4YjRuydo+RqgZTeyNtOZ8ORbxDtlEqgRxX1/+3OCEG7YH5hiKhf30HgE0V0+mQlCb2Atm3PzI5VbbU20IWt4+ytiABdzNp9BNwWinlzp9S+Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IScLbj/V; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753278256; x=1784814256;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=p3XiUp8mO0ZgRhHgISZZaOt5W+PfFvJWYH3v52PX7bc=;
  b=IScLbj/V9Iuikb6kky45XOq0OLMMF2qIYCKTN1SSvap+Kwxgj71VbUyw
   WFxsFvX+46az+Q4ZWjo+2tYmGvQmAPx1D62mecQv9VibvQhC54FwL7NCP
   vF9qmmrR6gZdVgqOHlo3I0iw4hbzjdU3mZ7WIRJ8ksa540mcHd26w8BU6
   vJuWjZV6p81f9wCv35f3Aex6j/sTdXvB36O2aNceyV+V93YfnopXJTeSR
   gVjcElhgenZErs6Z6Rd76ROcR7vRUAOibnHxl1VFdxw15ZgLlewEOoNLK
   wmIw0aJkl+EqsCexuFFpuZMTyY9MGXwDgag6T2cFegFjpxUCFIthcu/md
   g==;
X-CSE-ConnectionGUID: liz9uycwQW25ERtsAB7ehw==
X-CSE-MsgGUID: FG0+yTalSFy2QpEI8AR9cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="59218061"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="59218061"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 06:44:16 -0700
X-CSE-ConnectionGUID: 5wZUg5k4RcWMcEJLPhwPNQ==
X-CSE-MsgGUID: fQh/WVR7SOGlxoo9RVIudQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="163593403"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 23 Jul 2025 06:44:15 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueZlU-000JOJ-1F;
	Wed, 23 Jul 2025 13:44:12 +0000
Date: Wed, 23 Jul 2025 21:43:38 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Zhivich <mzhivich@akamai.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 6.12] x86/bugs: Fix use of possibly uninit value in
 amd_check_tsa_microcode()
Message-ID: <aIDnCih02ERPpFp4@8a77288bafe4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723134019.2370983-1-mzhivich@akamai.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH v3 6.12] x86/bugs: Fix use of possibly uninit value in amd_check_tsa_microcode()
Link: https://lore.kernel.org/stable/20250723134019.2370983-1-mzhivich%40akamai.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




