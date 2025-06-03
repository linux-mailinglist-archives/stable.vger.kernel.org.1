Return-Path: <stable+bounces-150698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B9AACC535
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 13:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5053A4063
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 11:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB391CAA7D;
	Tue,  3 Jun 2025 11:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fEph8XmJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CD5433C8
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 11:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748949542; cv=none; b=fklF+AhVFJ3y9nUNhG5dqocyL4sXd3Zlj6j3YKTSqqimCM0pCVNuYm4LvepGenjF+riaxbwGv87Or+/QuMIdoC79NXD8IwYdSR8Mv8p2dcOCkpMtNrkrnidRL6QQ4jeLcmYLXTD9YGOYVgfsfuhJJz0iA2exiLXokBjcm/O5mqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748949542; c=relaxed/simple;
	bh=PyR99QWDfoGuEFemAEbTXvfQIMCSSxO1rCgcKSYgnIE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=clTZqGJS+X/wgDqwnw+N8U0glgETSuaS+bLNSBncJt7qfngcskCcIC4R0DmVge5kCfs2U9AvJ9Agxn8N/LJLiWzsJi3nE3QFFivc/c5u0Xq9lpS/pzNWb3xEIe8YDLyPBQOARG0fOnBodZEQz6h2O+PpmjKfWkH3xRNZkeGZkWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fEph8XmJ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748949541; x=1780485541;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=PyR99QWDfoGuEFemAEbTXvfQIMCSSxO1rCgcKSYgnIE=;
  b=fEph8XmJABLXswfqre4xE1iI/S5Kv+qn/bg97gS90iraGAlojmganwdd
   aQ+HNIU+l1AjZLPQbgirRaR650oiz1N5VS65QSlREfEc877xTDa094C3P
   cmM+XQaEA2eGkZ79mla3V+ztRwoaSdGWwp1D+PW7P3a+VBIoSNgGUswpK
   JptSQNvWrjl21ksyXn9FZqFzDCDMe2eGaiYh2jji2uXdqHCvSOBg9MXlF
   idcktUsbuq5yTLj4LNuewbIDPQNHumXD6mJy8X3fKb9XYuX1bIqyC09N+
   4JqrqVnxLAIWCiOA/7Bjs4fJsrGgTFAzTZphtF03DxP3ws9sseuypWxvM
   w==;
X-CSE-ConnectionGUID: mPikQMCMTpGx3jLyi8Os/Q==
X-CSE-MsgGUID: KDv9uqIgSpaJ/ppzhIu2eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="76378328"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="76378328"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 04:19:00 -0700
X-CSE-ConnectionGUID: Gdhvhi3STaau91cUeDvwQg==
X-CSE-MsgGUID: CtfOkSM4RbOukFTSX2BZhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="144712254"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 03 Jun 2025 04:18:59 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uMPfU-0002Ob-2a;
	Tue, 03 Jun 2025 11:18:56 +0000
Date: Tue, 3 Jun 2025 19:18:56 +0800
From: kernel test robot <lkp@intel.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 3/5] x86/its: move its_pages array to struct
 mod_arch_specific
Message-ID: <aD7aIL7ZO6S_QXWI@acd742588394>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603111446.2609381-4-rppt@kernel.org>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 3/5] x86/its: move its_pages array to struct mod_arch_specific
Link: https://lore.kernel.org/stable/20250603111446.2609381-4-rppt%40kernel.org

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




