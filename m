Return-Path: <stable+bounces-76813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B355D97D569
	for <lists+stable@lfdr.de>; Fri, 20 Sep 2024 14:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 382E8B216F7
	for <lists+stable@lfdr.de>; Fri, 20 Sep 2024 12:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA8F5680;
	Fri, 20 Sep 2024 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eRdb5gs9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA031B85FC
	for <stable@vger.kernel.org>; Fri, 20 Sep 2024 12:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726835572; cv=none; b=oqAR+RWDfDgFNfaDiLiz3vUwcG6d6THuUTqjDDAGtEx8u7z7z/NR8rxZ+V6MY2d4Irb/PUfOmdOBMQWHoaA681TpvDdB43YihgFXRX2zWIQrn7AexMH4By31KrawyC2cBZWiVhul7Sn6vuFZ4r4LUMpr3QwoIezRitfoaDagFGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726835572; c=relaxed/simple;
	bh=6Rm9T4lC9u79gPJH1MrFRUOfw7oM+hVD1/mmQEGYbtI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EjwVTMerKKVamYGpjeqKLyK+6bN0Ka0okWrr0QA43bvdYnxPvBGZgtDLPPwHLRiGK4/gqLW6viBauXJ1W1n11oLhF77fu2wNgHcdqWiiagW8+5XOdjIb+04W0lTWIMosXx0fG68EiKqYX94t7fJgSTBO8M0oGaEIH+hN/uXsKP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eRdb5gs9; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726835571; x=1758371571;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=6Rm9T4lC9u79gPJH1MrFRUOfw7oM+hVD1/mmQEGYbtI=;
  b=eRdb5gs9Sve2dSfhnrbNhZBbJ2uPy7t75Ys7ozvOOrmVdofCGglW3+kb
   Kj73WuDsgJjzlYwxqWBqOlLEzCo3XE0DLpE2XlP/8/XMmXbEn/wST4/Yn
   t1GSsANkolfM+xphmYftqqAe9mCgPcj9cDcKTYMIWGX+V/COKMZrjb8Vt
   5FKfERwr1h5a73XIOR9YjD3XM52EY3Rg4bvOffI6hUVSe+Z1ED921Je+4
   rrj0fliRN6LjOZN4D6ZHqav1Fx+srbixaBvWlJwXYjp+Xaa4v9V9ItBVs
   9XLD5D9Enjvusm17T/f7yaYXrh+IjftY4n1ZaKlYod/7VCGvxBZSFQBnJ
   g==;
X-CSE-ConnectionGUID: bHNZnbuNSZSkNSrFeVeoRQ==
X-CSE-MsgGUID: Q52jsFIdTxOYjjddo5F2CA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="36505737"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="36505737"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 05:32:50 -0700
X-CSE-ConnectionGUID: MEPxaVRTRR2/SIph7V7hww==
X-CSE-MsgGUID: VLScHFjMSReLtJkqdUNAwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="75070578"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 20 Sep 2024 05:32:49 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1srcoY-000EOX-0J;
	Fri, 20 Sep 2024 12:32:46 +0000
Date: Fri, 20 Sep 2024 20:31:50 +0800
From: kernel test robot <lkp@intel.com>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 3/3] vfs: return -EOVERFLOW in generic_remap_checks()
 when overflow check fails
Message-ID: <Zu1rNpdMj09RwpKZ@483fc80b4b15>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920123022.215863-1-sunjunchao2870@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 3/3] vfs: return -EOVERFLOW in generic_remap_checks() when overflow check fails
Link: https://lore.kernel.org/stable/20240920123022.215863-1-sunjunchao2870%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




