Return-Path: <stable+bounces-26963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6650873827
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 14:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A44284415
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 13:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BBA131756;
	Wed,  6 Mar 2024 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ho/7cbAA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D9B13175B
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709733148; cv=none; b=MAoFEaTOpXZVJQGI/e1NO9/GLf752wxPPo9yJExhidSzkG/2ZTRxnbTygDJIWOapA4V22ra5mC6XZU50u/wk8UuqHE6x7WMbp29Nd9MHcrY7WmKINxBI1o0UTtffGnJzaYu8wh0cUHRiGVmw5F0vGIvUKv4Texx+0r7qJHtcMis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709733148; c=relaxed/simple;
	bh=hLlFWfK7U9czUprUrCxIsJwcRynBq1e3zZxrE3z4kuk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=s8+11Mf/MdWEXpZITeoMo2ZQSLyTfbp7sMc1xvMgcH0UfaXBsKcj/JuE1WC4k/hvXtQ4l9fLHmr1WC/P/4LLoVOrM0XdjZa4eljOD6N6PvHc8nGL1b5DmZ4KSghUV5EDIuXidDoMdNt1fEu7tzzI9ZvHcK84Osj2Tm5k08jhXRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ho/7cbAA; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709733145; x=1741269145;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=hLlFWfK7U9czUprUrCxIsJwcRynBq1e3zZxrE3z4kuk=;
  b=ho/7cbAAdIEGYnMpkm5QX4aD8Pm/h8smeddVDTien3XIpYm0M9jL/j4o
   SCjg68jqOZvgT4njq01Wyz+93uKWCKkMjcO9lcO9O0MMeYGMC4n7xc3Ij
   cc9qznehnhuJJrhbZ9MXjaDW3mYqDss1tXh+0+4+Kbjq45oZKYf36ctgw
   LuMadWBxiiBYB/XoZ+WKSWHidPG2kG1rN6CgQraaItbRFrguOle8JjQtL
   Zd8iPLH0e+pGIIX176oGaBAAVlYg+EzSSDTkSguiMA+Gm1t+MydzIYr6g
   v+D7dwCoFJeKa3hTUDwRW6zS9w4gGlkq+2uS8RnsQNoGNEz4PATRIGlML
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="14920131"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="14920131"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 05:52:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="9695639"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 06 Mar 2024 05:52:23 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rhrgz-0004Gb-0U;
	Wed, 06 Mar 2024 13:52:21 +0000
Date: Wed, 6 Mar 2024 21:51:28 +0800
From: kernel test robot <lkp@intel.com>
To: Mikhail Ukhin <mish.uxin2012@yandex.ru>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 5.10/5.15] scsi: add a length check for
 VARIABLE_LENGTH_CMD commands
Message-ID: <Zeh04FzDMBIY4jhQ@0a06dd0f349c>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306135010.9250-1-mish.uxin2012@yandex.ru>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 5.10/5.15] scsi: add a length check for VARIABLE_LENGTH_CMD commands
Link: https://lore.kernel.org/stable/20240306135010.9250-1-mish.uxin2012%40yandex.ru

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




