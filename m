Return-Path: <stable+bounces-201048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06949CBE41B
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 15:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBB20301A344
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 14:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E0226B95B;
	Mon, 15 Dec 2025 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oo8NS+pb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482062DE709
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808563; cv=none; b=GMVcyOIfDOZAu1NzzMrnwbc3mqVu8qKK4ECKSDWmpwZnvskqKFyWXKG/J8n6BzL020nhbiqIVvtjj0FxuC1FZ3NQCcbstzyXA19Dft8mkmX7UChY4N5b+jd94BkHVtvEy3z5JEQlNqegpTj0mglzk9Sh9m4Wo0HtqMIljU32bEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808563; c=relaxed/simple;
	bh=ioGpwopOeCj20OGZYQ3fjwkEjMkwoLwc3lmzjGnBi8A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SJq3XDcD72mYMLvbFklbHjWTEdhE7M9OakLR5VWKY4qvrsLPWdKHQB1ez7SgJf9jT8eiFywtyrYI2DCWOEI89NRlCgL9N8aSRc4HTWJ3KdhFywAMBqcGJ+PdhP9eRPtWrkeiUUGVpQ3Zze/bb5/gKZLyC4Sm+TINC6Pjl0O2qMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oo8NS+pb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765808562; x=1797344562;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=ioGpwopOeCj20OGZYQ3fjwkEjMkwoLwc3lmzjGnBi8A=;
  b=Oo8NS+pb41NR2Tzu7Q5ag+O6VKgkwIirgtAAu4K7z0RTXALMABAU0zpj
   BhYvj4rAg3J8vtKf50pFiLfraVm8l60IBxcK6aLavGDJRxAzWryrNoN49
   yCQSpBAhd3srYZ0UyzH5jLMZ+lUN/+o/qaSDEt1diZC111UZxD4bn/5kj
   Lwa9Tz8Sfs2EYXnf5mFAXVAGNVVUqsOHgQrNac6o1CplZBNYngODzrWp2
   S9UgUZsqa6Jd+x+iWMCwuQMrmqMK7dlTJF03wHp7ifDtedcp0YZgr0luS
   7ai4UwRG6MompG2UcVNz+YtsIoE+OSfv0lsbMMh0o3fVLbxGOu1m6B3qg
   g==;
X-CSE-ConnectionGUID: mkRaLgnzRwGJnF3G6vi7/g==
X-CSE-MsgGUID: T74bnji/TquYsqVSvWap/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67465001"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="67465001"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 06:22:41 -0800
X-CSE-ConnectionGUID: OW1dqh5xT/2iGZqigsiBnQ==
X-CSE-MsgGUID: 72XAYDQZQGehXZq2Ah3Nmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="202842134"
Received: from lkp-server02.sh.intel.com (HELO 034c7e8e53c3) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 15 Dec 2025 06:22:38 -0800
Received: from kbuild by 034c7e8e53c3 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vV9Sr-000000000Mb-2ztC;
	Mon, 15 Dec 2025 14:22:22 +0000
Date: Mon, 15 Dec 2025 22:21:18 +0800
From: kernel test robot <lkp@intel.com>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] mm/readahead: read min folio constraints under
 invalidate lock
Message-ID: <aUAZXjLr4_d99FDI@73f44f95d416>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215141936.1045907-1-wangjinchao600@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] mm/readahead: read min folio constraints under invalidate lock
Link: https://lore.kernel.org/stable/20251215141936.1045907-1-wangjinchao600%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




