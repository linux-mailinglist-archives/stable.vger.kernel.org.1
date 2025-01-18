Return-Path: <stable+bounces-109436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C82A15CA8
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 13:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD7BF7A2207
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 12:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6915318C00B;
	Sat, 18 Jan 2025 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y9sKpKXo"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E791885BE
	for <stable@vger.kernel.org>; Sat, 18 Jan 2025 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737202749; cv=none; b=GMBchod2ZuLa0l6WGZAh5X2p4d/cbIB2q2hadGo6ZViPdZY75ZrCewAacH7P03Jk6m29rUW80dmjeJI3Ra0ewSwZB3f/X1eGGLF1nIFMiaxhARPYP7HIgutm52DwIFhmGoHfGBlgLsFsWSLsvKWKcpT7zcp5nRkR56qn0Irho6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737202749; c=relaxed/simple;
	bh=jF7job/4IiNjKEmUPRQTPfFbzbqmdeS8TbRMvWMAIjM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=u43EvonYOSRnbR9A7SNHxb1UWQzSoJKSnmd6XuMpXGZ9A7YMhq1eUNDaZcTTdW7T1GRIjOUXB0TXpSJmlJd5HOnx/XFYs61Dbm+tXxn4mEmHtEdQwKchlnkeKUpJlHBsURQC/Zx+Z5vgtOMzJOhxogc2klmWA1woMy4zy+rfDMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y9sKpKXo; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737202748; x=1768738748;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=jF7job/4IiNjKEmUPRQTPfFbzbqmdeS8TbRMvWMAIjM=;
  b=Y9sKpKXolR4IT7rkdLKDD++3HAqdAfokmzvcOeFuE7ZNGrc7y07tMFYU
   0jOF/U/jmOlYYDo8WAbXXjYhasNS5nDVFLUWnUeKAIfGzJYUYc1LsslOn
   OeRruM+6lBEGZ3G9uDkcN5tVuu5AMH1+SdjTs52zS0ASJsBkTdEAaWrP8
   Eev/f+1CevqWIAe/8Ys6lkgfVVFnJsu/LmngnObwDABpl8joPqTh60UNJ
   J/izLpBAwICq/Ng360zS8jglEZUBHL730LUVQBZT3p1k2cCiPY3A7wD6X
   NB5jS8iTXN1hMt0aLDqqlQ891dafJ1sNlRf8lS0LBtYBvFio5/uktKEH8
   g==;
X-CSE-ConnectionGUID: tqPp/qRlRxmdketd9aOmMQ==
X-CSE-MsgGUID: GPSyHtj3Q2K02TnNP7HciQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11319"; a="60098836"
X-IronPort-AV: E=Sophos;i="6.13,215,1732608000"; 
   d="scan'208";a="60098836"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2025 04:19:07 -0800
X-CSE-ConnectionGUID: rGgbg5NBTbqGxrgbv4YX2g==
X-CSE-MsgGUID: z6TH9XlGRTS2rvoFmnChQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143330131"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 18 Jan 2025 04:19:06 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tZ7n5-000UPP-2J;
	Sat, 18 Jan 2025 12:19:03 +0000
Date: Sat, 18 Jan 2025 20:18:51 +0800
From: kernel test robot <lkp@intel.com>
To: Ron Economos <re@w6rz.net>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.1] Partial revert of xhci: use pm_ptr() instead #ifdef
 for CONFIG_PM conditionals
Message-ID: <Z4ucKzQG2xU0EIum@9bc2624f7252>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250118121505.4052080-1-re@w6rz.net>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 6.1] Partial revert of xhci: use pm_ptr() instead #ifdef for CONFIG_PM conditionals
Link: https://lore.kernel.org/stable/20250118121505.4052080-1-re%40w6rz.net

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




