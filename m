Return-Path: <stable+bounces-104412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C58C9F40CF
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 03:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8077A166B3A
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 02:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AB34644E;
	Tue, 17 Dec 2024 02:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXRyHpf6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208C424B28
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 02:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734402712; cv=none; b=rVcodWFvULHxvT0iAX28Dtvx9sQKGB6HN6EJuXQV1uKSLwMEvR1rHF+qIBdJvYIaYDSjCM6sMLTMzdhCIB84UptvRKZ5ipeieQcQ4AGVyJHF8s5WLNva0cOJRDzjFRjL1a/bVdCDAViw7v15S6EXGiUSfY/7dXb6MjaKb10foRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734402712; c=relaxed/simple;
	bh=nbqMtWyeYG4rVYb1vtsQcvffTHPmH72DuHVjeOHkvs8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DRh5M9yTuVbCI5/IK+ZcGNLIcYds567ufDhFAezGkxO8rkLFnaQx3FZsn6EmejFIdisW8CKmIY3YV/zGwLoHCWyybfUwFHJdPLE95jM2BkkvxYgD9BXDO8qIabrdRyWqVEk1U51OHZbrhfQfkcSBG1j10QINcWfBmzd6B4TRr/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YXRyHpf6; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734402710; x=1765938710;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=nbqMtWyeYG4rVYb1vtsQcvffTHPmH72DuHVjeOHkvs8=;
  b=YXRyHpf66Yo4pw/jHE4gEnLpj9HfrYfLTW4cGpyek8GCsM4V9N84Cmwi
   9a+qUoJofrKZnS7mRBB5vAeKkDWkgBPZyNw2vdJDSvbvmocutGzfmGW8Q
   m4Par9mPfTvhn/xkyvMEo8Db7f8SOK41RvyQBK9N1JFmd0LzfMhYaNs2r
   RgqWX+SE3E5dOC7BqPbRjiK42/EVG1oXz7sEvI1vCFnt6gFr77MYwvBgK
   XdMLLxRSXAYVWJtYoKIZVqAAo+acfB2sku4brBa1HMumvx3o+K3I1XAXO
   e/GqyfrmPCtX2i1G9e3b21Edd2NtsDQM2HOYQ4x4JcLlDSrG+P1T8zpZ9
   g==;
X-CSE-ConnectionGUID: tTxqpMZXRWOlPcUyJSsn5A==
X-CSE-MsgGUID: pTpJ7OoNRteJFNAq9TvdxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="38589522"
X-IronPort-AV: E=Sophos;i="6.12,240,1728975600"; 
   d="scan'208";a="38589522"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 18:31:50 -0800
X-CSE-ConnectionGUID: IplhZCn2TAe1c5bkg2062A==
X-CSE-MsgGUID: dmZw2pEcTk6hrXq3cbgvvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,240,1728975600"; 
   d="scan'208";a="102245869"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 16 Dec 2024 18:31:49 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tNNNC-000Eei-21;
	Tue, 17 Dec 2024 02:31:46 +0000
Date: Tue, 17 Dec 2024 10:31:36 +0800
From: kernel test robot <lkp@intel.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] mm: compaction: fix don't use ALLOC_CMA in long term GUP
 flow
Message-ID: <Z2DiiODXOk_m78Rs@0d54cbd93456>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217022955.141818-1-baolin.wang@linux.alibaba.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] mm: compaction: fix don't use ALLOC_CMA in long term GUP flow
Link: https://lore.kernel.org/stable/20241217022955.141818-1-baolin.wang%40linux.alibaba.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




