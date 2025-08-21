Return-Path: <stable+bounces-172074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3AFB2FA57
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BAE816CEAD
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B9B334376;
	Thu, 21 Aug 2025 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U7TUwZm0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFF93314D7
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782669; cv=none; b=BRihZ5f16dDSlMWUYtoVEaOLSwXVdaaFr6rd2ycfAfR710Sf6hJmiCJsUAALe/wxvu8y7rEME4QT1+OiXSy4vfLkTxfPvEkFwIJ4TMT8FKClEbqOfP9UfVgRvp329UbZJ+4ODxbwnDKOkYsxKN1O909AKDWz9iFzdoAFfdO3/as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782669; c=relaxed/simple;
	bh=wUeDnYir6m5KvyHidemxL9akHy6dwTuVuG/zzgMIb2M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OxB/lSKpeeh6W8eUBcBBYqx6BeiXmCNQrTgBCyLtMz5SFbFHII1OPL4F2+3TpmujuVfe+PAlKF6P1JRGIPf2rmIlk9agQ9A/uHsIqogLpbxLSJq8eyOPET/oYCEUSW91LvhDIaK5xUQlV+lWok2S8fAZVv95c3GguqhDceyXpfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U7TUwZm0; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755782668; x=1787318668;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=wUeDnYir6m5KvyHidemxL9akHy6dwTuVuG/zzgMIb2M=;
  b=U7TUwZm0Ssd1UF3mKoclLB3vEub33Ovm7rhc5A/zXevbu/uNNaSt6LMW
   0XqWUvKeqY5KYK2t7QB6VGZHHQcdY/cWW0zLjLZZVnlWqGVGQdz2IMOoj
   5Eq25ngEuZQ3p2Xw+kTqYNPMJcbrQ7r1kSdVvVjlpNCTIzxye1gzKO5/Y
   MQaiu2aZWqwVvN7b9kwrzP8k+U1hF1mqO47T/+2rDGfMTsbuvq+sKXOOj
   S4cVPdNUBO5X92ipcIrgKFWLj8DFDq3CwS2O+cRMmtam7+EHilMc/kVSJ
   lpFBQRWcCqqfzFLXEsrCohOhNr5YJaWJIcOGLlWBCXYn5lezlIMwqoTMo
   A==;
X-CSE-ConnectionGUID: JFBxH1NnSyOJiTnkROqF+Q==
X-CSE-MsgGUID: 6SA+cVlpQni6xkUKAhnnbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58216745"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="58216745"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 06:24:28 -0700
X-CSE-ConnectionGUID: e+O0B2y/Q5ycEDDM5yCXNg==
X-CSE-MsgGUID: SASbzjPmQHK6XHqWR1bBlw==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 21 Aug 2025 06:24:26 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1up5H5-000KJV-16;
	Thu, 21 Aug 2025 13:24:17 +0000
Date: Thu, 21 Aug 2025 21:23:34 +0800
From: kernel test robot <lkp@intel.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v6.6 2/2] x86/irq: Plug vector setup race
Message-ID: <aKcd1qWqHm-S7t13@85d67d3e4d56>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821131228.1094633-3-ruanjinjie@huawei.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH v6.6 2/2] x86/irq: Plug vector setup race
Link: https://lore.kernel.org/stable/20250821131228.1094633-3-ruanjinjie%40huawei.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




