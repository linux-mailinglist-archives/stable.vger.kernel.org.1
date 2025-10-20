Return-Path: <stable+bounces-188234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E1ABF31B0
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 21:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A1D3BBBE7
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 19:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA722C21E6;
	Mon, 20 Oct 2025 19:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VScPkIkD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEC0261B9E
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 19:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987026; cv=none; b=lvHuEQw7xHQaAzNHIdta4DwZqY5l2uYp5MkBw8mHaasILx/py1W5+I0KaqsF1V4XKEM3ERguyLtzZMDGMDKVFR/6gz+zCIEx78OCykxWRHxPPG+wxMiZkhWqbuKRVwcx+m3YtpBT0lqU93GL/d/f00gQJ/SgMFWpi3AgVZ7C2JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987026; c=relaxed/simple;
	bh=U/8Rqpspsp2sHdRBBsNBZjGBhiSvcwhuydByeXzB6Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=juqDsY4MAYZU0U3HD7TbrYn6btYtWNWVGszxMumH5XKkXyX2QCec27bEUzZhdm32dPSU2VtJD8hJCJymi/L+N4EHn0hpH1Key585059JC8tIACQuh9OY/jE78vT6m2K4I+oYnBGR3PT++ymii+0l+wbWZZs6W5YjmCd6DS1WniQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VScPkIkD; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760987025; x=1792523025;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=U/8Rqpspsp2sHdRBBsNBZjGBhiSvcwhuydByeXzB6Zg=;
  b=VScPkIkDRFqzDnoUEDlca1XVMikh7JIUnkmZXjsywPHPRbm0jYtqJdJ1
   uuQ6Mp2o3b2XGULa89HD2J7qloDtM6ypwMIMunENEa7UncYPOWk63IDNQ
   t3WEOEFFg+cAIUKBJCgL2h0VnX9HIBXwvlbeZgQdBbNNfxtpgEzMKEr5W
   wVv2irS1hpPrHH5oOW/YXtyAPHldWSFwlZGvQId4iJ4juclXPiUk3v7am
   PJ53t83eCfghu8OOSP/Zd+yGq+9eXCVrY0NqBtB1ScHGS+RHUD8S+nW4W
   YwP/XOJAU+oMLRi4nrHmuMU7op8LTrX2JV0+eEz9rc0JuIdCAriuKcGiM
   w==;
X-CSE-ConnectionGUID: uAbCzSnXRZSfLCHmbHunfw==
X-CSE-MsgGUID: nJuHFoPvSWmDwWionWtlIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73399951"
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="73399951"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 12:03:45 -0700
X-CSE-ConnectionGUID: hHLMnIY4QKWPyqWNR354wQ==
X-CSE-MsgGUID: R49oE+LUTCqiAWvPIeP3rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="184175657"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 20 Oct 2025 12:03:43 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vAvAT-000A5t-14;
	Mon, 20 Oct 2025 19:03:41 +0000
Date: Tue, 21 Oct 2025 03:03:18 +0800
From: kernel test robot <lkp@intel.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 2/3] s390/pci: Add architecture specific resource/bus
 address translation
Message-ID: <aPaHdgMx9ajmeFtA@c50de720c4f1>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020190200.1365-3-alifm@linux.ibm.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v1 2/3] s390/pci: Add architecture specific resource/bus address translation
Link: https://lore.kernel.org/stable/20251020190200.1365-3-alifm%40linux.ibm.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




