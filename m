Return-Path: <stable+bounces-112012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC01A258FE
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 13:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B928E18827F7
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 12:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B9920409A;
	Mon,  3 Feb 2025 12:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkFFi2OZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F3A200115
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 12:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738584498; cv=none; b=qqpMKTrpBgGWlFGA31phb+aY9mt4bIYurWkNI8bpBZtTEaP1xkDU6JUBNt37MZ+R53yStU176gGXUt+fwiVCP20uMgZQ0KGNPpRvhex8RPanGaVI6WRE1e1FNH0EgnsbJXYm9aQChl9bANNJzxTaoi30iYZMrqiRZv9SZbwpkH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738584498; c=relaxed/simple;
	bh=Jq+Ko1RPKlrDwtKFvVOTAACALwTV26Kr1joQfpRL7EA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rqp0ffkj8rtoHSWkwk3CryHWkO4BxyQrUWrJLQ1RNeaaLAo61pz1jBLriCpw0T3do21dHvGAKRykoCei0FFg6LyKksd3kO91enCjbL5E1IpcG7nD9G2DsHFhe8QNXiwSwmNbLiVvv+lvKQwCPDFUsPlB/60gMz9Zn/9UMhvWfew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkFFi2OZ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738584497; x=1770120497;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=Jq+Ko1RPKlrDwtKFvVOTAACALwTV26Kr1joQfpRL7EA=;
  b=MkFFi2OZkFmdPA86kkGsbIGyo9eevf0nq5ZWQwpCGKn9nkIwNlVuDadY
   u17Lrk3WQT7tEkeMdDVQkqE5KPhMLHI2tVuC0JrcESLQtg7vF8+BHa5Yl
   y2wAMYS9LrI2AWz6qtxuuAYNNskDfJ3PxtsA7BQqs6IcaR/PLMjMBwLCj
   wHVVlb02nP1m+R+bO+6vsbvCcKeniwP8FtnwVnH37QPoRQoReQnzZQeij
   3ALfl49dVBaBQ1sx7pFuF7ofmUoY/k2H5T9Q2FTjYoFrYPyd9eyvJKfHl
   apzpVJpFAiixC3W5tbOGURMzvCniA7yvdZcNCkMDuneTGdwLoU2jId2mX
   Q==;
X-CSE-ConnectionGUID: gWHjqjv+QkqPSkD0alKYzQ==
X-CSE-MsgGUID: uRtHzUFTQmqU3gXzSpLBnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="56609830"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="56609830"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 04:08:17 -0800
X-CSE-ConnectionGUID: chMNEhk3TpSeu4ytM7/bnw==
X-CSE-MsgGUID: 5UhwIlo0RG2aJA98cFc9Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110099785"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 03 Feb 2025 04:08:16 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tevFN-000qtH-2m;
	Mon, 03 Feb 2025 12:08:13 +0000
Date: Mon, 3 Feb 2025 20:07:42 +0800
From: kernel test robot <lkp@intel.com>
To: nb@tipi-net.de
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] usb: xhci: Restore Renesas uPD72020x support in xhci-pci
Message-ID: <Z6Cxjv7b88r59ITi@f9d63055f2c6>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203120026.2010567-1-nb@tipi-net.de>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] usb: xhci: Restore Renesas uPD72020x support in xhci-pci
Link: https://lore.kernel.org/stable/20250203120026.2010567-1-nb%40tipi-net.de

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




