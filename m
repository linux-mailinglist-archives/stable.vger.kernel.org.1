Return-Path: <stable+bounces-136689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C790FA9C4C8
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 12:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6DA71BA861E
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 10:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEAA23A564;
	Fri, 25 Apr 2025 10:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJzMSo/v"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE8B235345
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745575802; cv=none; b=HmIhz7FN++A4oPDpZrD0tiuaKIaBT4OG2HXjXEUWpss4cX2bq9s7LV0xnVPdoSTmKs6tHkslG3dv8W/MqmpEpfaaGzrDbnn8Z7F83PexVJKiqh6xlivI6a1L+gnlLhf7zs444VMmzPADYEUqusqV1JlQDBsI7thtfg++hsrkR+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745575802; c=relaxed/simple;
	bh=elJJ6eaB5v4IgVePJbf76temLrVk7nVkMxypqJ3zwT8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mcKeijIIkmFDtowI5msppJTOxxcn/Kdw/lnIQpcgiq+7uGPxF6dNAyYghMeq9OnCLw/4FUdAF3ECDmm+EEeLBQequLVRPjwR+lqLlpokWLT5IViKsHXdIheVlVYsSCH7Q+wSGlgP3Q/f4voIhmVD1wHnsLc4oqHb23vmlJaWwKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJzMSo/v; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745575801; x=1777111801;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=elJJ6eaB5v4IgVePJbf76temLrVk7nVkMxypqJ3zwT8=;
  b=OJzMSo/v0sYKqbwFZ0eoDNnM7XvTORdapqz9veZMxltUfrewkUIawlv9
   Rs4QAQ9ynxCDauk8H5eI/QxyZRok2pqTNAlhtToa6uwbXHbbYdOQetOVr
   qnSIJVnG24evyZGB26HmaNicGa0uUfN4Hpx4AdWBvuv4qX7IfJlxayEwN
   IdRV6j5In6jlaagbaMxHyFkNE5MAMQ5uYsQ2h0X5g8zamVdEEMbOL6xkp
   PQ6lzJ+jDNbTUOzpVHPI0Ax492n+yeKtN9U9icuyyLDv8pgPzb3JtjjAy
   hm8klkAj+Y6IwyBLCD6jdr57MegCdPz4YraSZhmhf096Sv1XJ065Z8k81
   Q==;
X-CSE-ConnectionGUID: D1uyF4s3Q/Gj0H2G/sPB3A==
X-CSE-MsgGUID: KwQPZ2QRQy2YCqLvUWbQZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47107150"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="47107150"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 03:10:00 -0700
X-CSE-ConnectionGUID: IrJ0JcgoRI+wS0xX63zpxg==
X-CSE-MsgGUID: 0clo3yO0S5yl+L0qR/YL/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="133179275"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 25 Apr 2025 03:09:59 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u8G0L-00053J-0M;
	Fri, 25 Apr 2025 10:09:57 +0000
Date: Fri, 25 Apr 2025 18:08:57 +0800
From: kernel test robot <lkp@intel.com>
To: Dongcheng Yan <dongcheng.yan@intel.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 1/2] platform/x86: int3472: add hpd pin support
Message-ID: <aAtfOZYUV3Ef1cIK@5d75f5d2dfb3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425100739.3099535-1-dongcheng.yan@intel.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2 1/2] platform/x86: int3472: add hpd pin support
Link: https://lore.kernel.org/stable/20250425100739.3099535-1-dongcheng.yan%40intel.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




