Return-Path: <stable+bounces-121192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D18FEA54510
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 09:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26B93A30C6
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 08:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BFD207675;
	Thu,  6 Mar 2025 08:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WPZTRUbL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D5E20766A
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 08:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250355; cv=none; b=Z0B1cKLZK5sBq5b8klY8+W7upLb/Wi9XQsidZGAAUE9ZfWIKmqZqVvBb+V/tTYCJtttnJjKTv4bOt7V5GD1tJbvLJqhN2nJ0gKgzmcidlie+JwImfoA9EYYPL01FExb/d3cm1mV/EsyFHR7DxFNpDlixYoLYxLlV+RQqXMtlSRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250355; c=relaxed/simple;
	bh=ZpEzmcfP3Xn9KdX/LMQLdPkYfnXBsU86R0MaBzvd6Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HkImUE2VP9Mb2htyklWmbHdE0se7BbmPR/IqWu9k1aTL4yOZa0t/HF0UfYgg6N0B9HNh39GPZznTJ2R/gD6An3k5ho6KxAhnASNEhzOnEBpkQgxALEUebokPw9yPeM43mYwV4WUJyj0/N746SmRWw9AGokzs2I7ALxEktGMdX3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WPZTRUbL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741250353; x=1772786353;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=ZpEzmcfP3Xn9KdX/LMQLdPkYfnXBsU86R0MaBzvd6Uw=;
  b=WPZTRUbLCfpt7ydwqqmo9o/cud6eI4RQlblip8a9Nxp8I+BEuJ6SorNp
   Iv2+4ko4zx31+Tq9QT/WiLTEwSWNzdyG3NHBSV8nVcGuRdL/5iaRBGtnr
   SjGThW7Og1p6WcygpdabProcXc6tciotEKeCPhSR6De+5GBNT3q+Z7Kgc
   +3vLXxFCu7Jjb0zVnwFEw9z8AuSxtSifJG4yaIcp4jRjXbF22CEfxGaw2
   HcqfYxIWjx4Db2cj6ONYTpuqoM1CIUQ9gUHYQVezihNKaXFiptHiuvQ81
   cGxCJjG8phBNO7mhL9RwVTy8pV6IWh6NS4+o/MeSxmF/vP+G1gwpyon1n
   g==;
X-CSE-ConnectionGUID: 4Hw1ImIRTeiKmtRVE0B66Q==
X-CSE-MsgGUID: Ko2KLrGjQsOnNG3vl/rOnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42162116"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="42162116"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 00:39:13 -0800
X-CSE-ConnectionGUID: Zqp/13/iRH2BANDDpij/LQ==
X-CSE-MsgGUID: fntPMJgjTeGnx9BZZgyFbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118872433"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 06 Mar 2025 00:39:12 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tq6l3-000MmA-2K;
	Thu, 06 Mar 2025 08:39:09 +0000
Date: Thu, 6 Mar 2025 16:38:18 +0800
From: kernel test robot <lkp@intel.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] clocksource: stm32-lptimer: use wakeup capable
 instead of init wakeup
Message-ID: <Z8le-nsqLhktXoKR@2dca5eb1bfca>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306083407.2374894-1-fabrice.gasnier@foss.st.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] clocksource: stm32-lptimer: use wakeup capable instead of init wakeup
Link: https://lore.kernel.org/stable/20250306083407.2374894-1-fabrice.gasnier%40foss.st.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




