Return-Path: <stable+bounces-164713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBBBB116BE
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 04:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C98697AC09D
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 02:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908F5235061;
	Fri, 25 Jul 2025 02:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SZBNdGUN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F66021B9FD
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 02:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753412017; cv=none; b=Mnrb+0rpOBH64OuiM49cWtp6xJnL0Ql+Qg4UmvxbrvaEFwPQ3igm9216cBUsZ7FuWjyFus5SgMw16bjefn3L5RdW1dQhMijlZvphYP5JDyOhiArQsYqJAv8SdhQJng4kej0zZ7j23p0QrdMBoitiEiYSurtfJThfKUQyfMkwTAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753412017; c=relaxed/simple;
	bh=ZbvmdWM01voV/RHKOHPy7qqMj3Y6NHh7aFUoYre1Zww=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aw/4Y5albbM9d+OpwtKwMacnMryiJg/uLJ8+cdWSEti/oou/dZq958T1uZ/hnoO36jFEuOVwxlqlLKBcXD/2/wlGj2jd53gq7rz5Wcil55RykIekAUPOHys9nSe6SKYDkGw3nb1u8mKSpyJODZSqaWzyVR+/LFUAClDMGiB2mC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SZBNdGUN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753412016; x=1784948016;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=ZbvmdWM01voV/RHKOHPy7qqMj3Y6NHh7aFUoYre1Zww=;
  b=SZBNdGUNzUuVGlX+trKSETkx2jsJii+WBrPilTjuRxO/1ar/xP0hCP6I
   4BrY5ufpb3qVo7mVz5+GRyUwVzBf/s9pyDF2PlLa2nzZMRV0nLPi+u+2Z
   Dq4HD1lbjwl6qbmH9uW5Xs23dT0BpJI5aVgVd4MhpycbtJ04XJ5xK8K6F
   NKtgvq4SShnbANOcdrlFSp300+A/EHQkr+7DsHwquyWFoI5bef6BgIc1Q
   KKr2y8phqTtVJx88A9aIKSDNJ3GRL7A4yFismRvbG2SZceHBI+XpF/HiV
   P0fvquFLPP/ID2waJbUe5LkR1NeregcFF9m+Ottkpjeyi3vQAHrZ3mtOk
   g==;
X-CSE-ConnectionGUID: 9LlkDGo9QM22+MWGV3hm1w==
X-CSE-MsgGUID: /AbB3ni5QWqXbfa4On8Nmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="67183372"
X-IronPort-AV: E=Sophos;i="6.16,338,1744095600"; 
   d="scan'208";a="67183372"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 19:53:35 -0700
X-CSE-ConnectionGUID: WZnvsPHiSkiSCJszbXXX8Q==
X-CSE-MsgGUID: sx3DPzc+RWmeUn6Gt7vgew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,338,1744095600"; 
   d="scan'208";a="191547249"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 24 Jul 2025 19:53:34 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uf8Yt-000KzX-2P;
	Fri, 25 Jul 2025 02:53:31 +0000
Date: Fri, 25 Jul 2025 10:52:31 +0800
From: kernel test robot <lkp@intel.com>
To: Li Qiong <liqiong@nfschina.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] mm: slub: fix dereference invalid pointer in
 alloc_consistency_checks
Message-ID: <aILxbxcnrd5emETI@eafdfd67401a>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725024854.1201926-1-liqiong@nfschina.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] mm: slub: fix dereference invalid pointer in alloc_consistency_checks
Link: https://lore.kernel.org/stable/20250725024854.1201926-1-liqiong%40nfschina.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




