Return-Path: <stable+bounces-144647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A55ABA6D6
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 02:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31670A23BF7
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 00:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE087208D0;
	Sat, 17 May 2025 00:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CiFO8vao"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB03A47
	for <stable@vger.kernel.org>; Sat, 17 May 2025 00:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440043; cv=none; b=fInf6onk+dD/HvPbVK1HV/YrhuJPk1lLKdT4NGcdR4BeCXyqy06A99Z7zhCPgv+xqzSy0KMk3ZyRc9VOZnKOZ1gjC4sE0t7BpBvLDyYEi1Iu32GZTgm+9SvaBEqrJX+MtPB8ci1Jnrp3VDH4egLOKWe1aUgnW+dDSEWMHoIRMQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440043; c=relaxed/simple;
	bh=9tw4MfudjKnpiqwmPcods5XpkbREKqLBsvfX5UK4pns=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=n7+mbA8e3rf164naKL0uYkgq0PQLeSfh8X5yKF5JHA/i7iOBHRcHn9qiBnqIy+Tgz1BH84KSdZWoTEJLKvU3HV1v3Yd8uT+fXG/YdowYYbfxJo07TNDu82U2QrVFLazCyRugJxOaiJ8U1JfESUqJki5XAHxOV96SshGr6cNKdYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CiFO8vao; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747440041; x=1778976041;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=9tw4MfudjKnpiqwmPcods5XpkbREKqLBsvfX5UK4pns=;
  b=CiFO8vao7S9jMvK/wUEPgGm+gKbUQr8OwQP6Ke3/yw3MgQs91uMu7ERH
   096Vh1Bcq7kCJrqx/F78CMqUdmj+PE0/AszXRh85aRpOwYMbS+1XsVyq+
   Omd9X1OVCw9LkhfN5TrX8OUwQdvAYNXo0i2yNlA2aOYdZBRDrE8wisAqo
   qF6cY5vOmp9n/xzUP7aAbDe7QKFTbgPZ7SanonQQ0zwTkinRfkfIr4pRb
   LNyq9Lh749HhyOchsUSRLE3UmD2zM3Mr2nHlpL1agkm1Ifg/d8dMgv/7O
   FuTnukTY+GUp5JBArjFwo1SxIMR+iZtvttRx/mtIKzHOBHGfi7KgkBxf+
   w==;
X-CSE-ConnectionGUID: LTIeSL7mQW6ZxOAJVl+Wyg==
X-CSE-MsgGUID: PD+sZidcQHCW6hLQeXQEdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49531091"
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="49531091"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 17:00:41 -0700
X-CSE-ConnectionGUID: fqMCVoNPQdW/YeCvP1PEDA==
X-CSE-MsgGUID: 7nGddxJpTvWi5CiYIVo3Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="143705384"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 16 May 2025 17:00:40 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uG4yk-000Jnf-0y;
	Sat, 17 May 2025 00:00:38 +0000
Date: Sat, 17 May 2025 08:00:28 +0800
From: kernel test robot <lkp@intel.com>
To: mhkelley58@gmail.com
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/1] Drivers: hv: Always select CONFIG_SYSFB for Hyper-V
 guests
Message-ID: <aCfRnBTuKB19578m@8c81029db2be>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516235820.15356-1-mhklinux@outlook.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 1/1] Drivers: hv: Always select CONFIG_SYSFB for Hyper-V guests
Link: https://lore.kernel.org/stable/20250516235820.15356-1-mhklinux%40outlook.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




