Return-Path: <stable+bounces-189749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56237C09FBA
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 22:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E61724E33B5
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 20:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A872D46D1;
	Sat, 25 Oct 2025 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FYAbwYGm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9533F221DB4
	for <stable@vger.kernel.org>; Sat, 25 Oct 2025 20:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761424735; cv=none; b=eSSUwqKFkdoh2uYcpeNHYyJu50Z/U6edzxCxzXI0rg2T2J1i1fCwogUIyup+UP7/ocfPVEqQ/9u45yA1xhtRU9bzu9iwCC49q0FvnxjkHr+NlAV8oh8HVb8EEF8pYNjqFPrZ68WKjQm1NYtz5e/6u5fJdsJCorlp9TFVCTPtA9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761424735; c=relaxed/simple;
	bh=MJDlof7cUoibv5+Mf0zZkAyysMtBve613Gbu5leud7M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lk48zS/dGAYUBxB4HDjG28UqJ7wW8qENGo+owOYOxAyOw9IOwSBtIr3/zn/hsMjz6XFTWnaatwfGk3CrpFjAXAvLDVKigjqwtv4+Gnx9hSQWFmErNUx4HOSd+xMvRe0Ctlxm76L9YTLDBAFmyHBcBKqmyIzrkcijZdEal5oI844=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FYAbwYGm; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761424733; x=1792960733;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=MJDlof7cUoibv5+Mf0zZkAyysMtBve613Gbu5leud7M=;
  b=FYAbwYGm5T5lINw61fPPVxYOjkG3uDBDvn2pLpj33fUNyK9jZSeIW/jb
   CSfkPb8Ti79uIWWlM4w7Ht9jixBoPUqJyRsy2LtbWoCLHOJXdT4CSwaOg
   MM5s5mWOGL16t114wfofNmNKEHjCIclaIMvmaLgSGtKTk1tjkX9ZFJY+x
   dEjQuTocnqYQug/sdLtJUjTbtD/Z/a/iXIqRe4OXEVngUiZ4H/Aa0nI0x
   oNIdCEs1azbziEzEO9N7qSJf5h2lNx9ByYFEd91ML+JEHK6o+CleKHA+Z
   ePZs9K18XOg9YttYONGSyaO+zoXklkE86at/zH2iMk8XsIv8q417+zv5C
   Q==;
X-CSE-ConnectionGUID: Ljfh1nqYSBCnXRXtgYsxdw==
X-CSE-MsgGUID: bsL5s2N3QA60/Mu97JnArw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74682292"
X-IronPort-AV: E=Sophos;i="6.19,255,1754982000"; 
   d="scan'208";a="74682292"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2025 13:38:53 -0700
X-CSE-ConnectionGUID: VWCsBFQvS4eUnj9Nss6LXA==
X-CSE-MsgGUID: p4dUXTJvTwqI55htG1zn3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,255,1754982000"; 
   d="scan'208";a="185179382"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 25 Oct 2025 13:38:52 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vCl2H-000FZx-2h;
	Sat, 25 Oct 2025 20:38:49 +0000
Date: Sun, 26 Oct 2025 04:38:48 +0800
From: kernel test robot <lkp@intel.com>
To: Coia Prant <coiaprant@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] arm64: dts: rockchip: Add devicetree for the X3568 v4
Message-ID: <aP01WP4gzxAaTyFi@2863c40af373>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025203711.3859240-1-coiaprant@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] arm64: dts: rockchip: Add devicetree for the X3568 v4
Link: https://lore.kernel.org/stable/20251025203711.3859240-1-coiaprant%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




