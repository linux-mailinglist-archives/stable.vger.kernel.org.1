Return-Path: <stable+bounces-73089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD24C96C140
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 16:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91FC81F293A2
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 14:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4C51DB942;
	Wed,  4 Sep 2024 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UNwMDw35"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA46D1DB548
	for <stable@vger.kernel.org>; Wed,  4 Sep 2024 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461486; cv=none; b=gK+yPj+fy1uZOWa2so/h4RtwWmSRcwPGM0l/gr437og6U8ag7aRjMDw8oHSXtZyreVUHcHDFhI3wtCH7MZMR4AFCRCmMBAsT1CUZhSFNRQHvVS/zMOezDsRhY20nMMwR7n9uJ6w4dSGCqYUxNESmbnGggakKg4x0cTx4HhyuQsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461486; c=relaxed/simple;
	bh=FCAPqs4G05hrqJAmmykNRSLlAJ2YYbmgxj2kMs1AJ1s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gIxKq9gMpUaPdZmQOiKnBDeADuTZj0TnqWThSmUTDE9tkf45fIBJY8J5Cjyyb/tL26VOb90PQL2s/T6bGFwMDjLH5Qleibn6rqOmK7PnOvMXgmsVZs7DjY1fqN4uYYSfVYs6N75jkI//F58X24JuYbAGVJ/WmjXxSX4QvVtPHV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UNwMDw35; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725461485; x=1756997485;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=FCAPqs4G05hrqJAmmykNRSLlAJ2YYbmgxj2kMs1AJ1s=;
  b=UNwMDw35iFWEy53mHIQ3STb6yyjRTfWkTUf4+vIOvJo1j4/hcWWa3B4p
   YAGvcnAcMlXb5TRbcepEpuz3fV8/DiOvO9vFMs04myAC26OrDvH/uhVpq
   dN06pfI1yZPvxEtcfYBluonKGHnFWWYjGfJOKo5iev9/z53RiB68GZV4V
   b6cYfR57GeGcIH5Ay2SnrhzTMFnIVvYMpdxKZ24GUo7wZtPAX6WHNW0eC
   zilsViJMTCzlvJ8b5hpnplDK6+368L6gewbaenMDl0h/Siqa4nZaDSCDX
   BZZmzWw8UzURAcKBvZDSuGk+ixy2GiMn7p+ssa0cpTf0glLB2Pu1eA1dR
   Q==;
X-CSE-ConnectionGUID: rvcjfcPXTTOaLx5GX+kQKw==
X-CSE-MsgGUID: d6ayoZhyRSK//ILTjwbZIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="28013824"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="28013824"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 07:51:24 -0700
X-CSE-ConnectionGUID: P2ETf2G3SAaf4Pirp/QuFg==
X-CSE-MsgGUID: LAT5FjN7Rs2XT0C+415cVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="102712706"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 04 Sep 2024 07:51:23 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slrLt-0008E5-02;
	Wed, 04 Sep 2024 14:51:21 +0000
Date: Wed, 4 Sep 2024 22:50:22 +0800
From: kernel test robot <lkp@intel.com>
To: Alexandra Diupina <adiupina@astralinux.ru>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 5.10] cifs: Fix freeing non heap memory in dup_vol()
Message-ID: <Zthzrh91Z3w48KII@e904a05aed35>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904144832.28857-1-adiupina@astralinux.ru>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 5.10] cifs: Fix freeing non heap memory in dup_vol()
Link: https://lore.kernel.org/stable/20240904144832.28857-1-adiupina%40astralinux.ru

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




