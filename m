Return-Path: <stable+bounces-108242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D38A09E72
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 23:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AB03A5D07
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 22:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EBA21A43A;
	Fri, 10 Jan 2025 22:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H/v/hzIA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2440021C182
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 22:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736549990; cv=none; b=Q0I7G6uSjITP49DgPVj5cUtkqkXfYEjTzCMUzMao/UlMgwfNR5hiOtqJghj7+fQX80RkoJGu2fmNPtaGkL8r1QPOs2inXPizoXlq8q5imp/fvKNtVTa+gG177EHu+N7ye78o2DD0Y9P1oAbpwushXHwT/DiL1v2CZ/jqe0XmWEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736549990; c=relaxed/simple;
	bh=nVnzOhXVxo5NY0Tbh2J8lLq6IqbelsVBafE+WVKXFeE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Vh7AyryzHCdSrfrfKN2oK1jMkYNjPi/Ik9Lc14ZtNT0SuEf/YjLzRpwncCIHox3MB15nADRBd1rmJH7Vl+y2tYglagPH1ea7yB+bO5SyZdSa8JQ8Wl+TDyjiv0b0q2Ws8+fXrcwKnawsOiOP+bd4THH+P+aT0WEPwmcxXZpEs/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H/v/hzIA; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736549989; x=1768085989;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=nVnzOhXVxo5NY0Tbh2J8lLq6IqbelsVBafE+WVKXFeE=;
  b=H/v/hzIAm8hb5Qby4/LdYR0H+mLHjgGcFyszLyAqUuMQqpnX6fD52Gtb
   hqTq8klZlcgza1YcUpX4L6ZA5W7brtZJhLuLq6XxR1PJsvu0SO7V7n3af
   UxfDLTyzSMZS44I2+l3aMIzpGSSMfpihTZ9sjC1u0CXjdqhg5HGX9CI8l
   lNjNLpH2/FMLsYGbQLWApEcZRWaf+THHb9x+0qisK6JW1rcx8y20J2pYu
   WIEbJ7ulPe1nj5wbAfqEw8CckKkCmf2UyP9/dqwADhST1z2kP98q1WLb0
   9w5Aa+213ZRb0AjryeaQq6jvn71fcMtSVSIjAmd2RidbSgyDXLBTr0x+9
   A==;
X-CSE-ConnectionGUID: l630qui0SEGWeHDH+Gh+HA==
X-CSE-MsgGUID: S317oc16Rwap1MV9fRY0vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="36543516"
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="36543516"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 14:59:45 -0800
X-CSE-ConnectionGUID: mAfceRBjTyaUb6PIA/DHaQ==
X-CSE-MsgGUID: jyU2u2GLRYiQbsX9BHhDMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="141154240"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 10 Jan 2025 14:59:45 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWNyf-000Jrf-3D;
	Fri, 10 Jan 2025 22:59:42 +0000
Date: Sat, 11 Jan 2025 06:59:25 +0800
From: kernel test robot <lkp@intel.com>
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 5.15 2/3] zram: check comp is non-NULL before calling
 comp_destroy
Message-ID: <Z4GmTf885lHCvj0F@244b91683e12>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110075844.1173719-3-dominique.martinet@atmark-techno.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 5.15 2/3] zram: check comp is non-NULL before calling comp_destroy
Link: https://lore.kernel.org/stable/20250110075844.1173719-3-dominique.martinet%40atmark-techno.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




