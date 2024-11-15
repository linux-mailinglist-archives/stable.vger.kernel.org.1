Return-Path: <stable+bounces-93512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0299CDCA7
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 11:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F731F21ADD
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 10:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A7018FC86;
	Fri, 15 Nov 2024 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B9eT05MK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE95713D51E
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731666804; cv=none; b=Dj3hfrTISC4OnGtwFBCDHWWz/gsz8SqkYyGGDfN2dO+YUnyi6ANduXhoUABwKOHt5Syj2HC4Hs6PUq07Xi00aAK91pIPOnE7z3TC3U/o6rwZp8P/OyHTu+6MEOtUEMos+436BS1tDTG6PdNf01Kwr8a2Rl5+cYBEcV2cgauDoJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731666804; c=relaxed/simple;
	bh=OfdAe11W5vquQNWMkQLn1b/4XBWf+3RcA7JAeVly6+0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=edjjHIyw4xqeft5IFYoRaZ/lgUpTpn77rENWfTt04MmIZz0d0RZggzUy0Zip6r3udQq2Pnew+foh34SJ1dvHRueOWTD5FYChc5UsX3ous4PUDGv8BPjsvMiw/6axjZkiYDmcslCBY/E5UQO5WywNlcW5ZkaVMTXVj803BXEeun0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B9eT05MK; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731666803; x=1763202803;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=OfdAe11W5vquQNWMkQLn1b/4XBWf+3RcA7JAeVly6+0=;
  b=B9eT05MKkHwd2f/OelyBT+9wijI65tTnU10JJjSR/AbYM55qKzt2C2Te
   zRHPJCSuzXqy0uNdQnw3Mpp13tlKBm5w7Z8pixw8qi0JBBMHnxqr5pUy8
   OAPYPijF6jjws/0eZ59um5nqx8mxsgKeR3xm7J+tfp+bf6PXXW8q6iTUp
   gdgnExhjBTPonsev3HMycrhJTHs63y9sxRJGgUqSKdEAp+C74fuViiIkR
   yJ1uMAGCiofj5zneWb7X2Y3WA4IZqvJ1jVduG5O3hhA9NwUTqPlJj6g/m
   Boe9xrB5jSxWcpE1GkpaCiOQuntJgfCD6E/xu64J9Ngn5fkyKJAeyXW4f
   Q==;
X-CSE-ConnectionGUID: 8pvlcIXZRw+vduLZdcHowQ==
X-CSE-MsgGUID: pQBLusOrTOOonMwSBF8lPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="49198157"
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="49198157"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 02:33:23 -0800
X-CSE-ConnectionGUID: Ju40c+3HTzGbpk4mgLjwAA==
X-CSE-MsgGUID: 50KtMn17R7uk1l5iXywO6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="111819426"
Received: from lkp-server01.sh.intel.com (HELO 27edf348a570) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 15 Nov 2024 02:33:21 -0800
Received: from kbuild by 27edf348a570 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBtdf-0000Y5-1G;
	Fri, 15 Nov 2024 10:33:19 +0000
Date: Fri, 15 Nov 2024 18:33:06 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 4.19/5.4/5.10] ceph: fix possible overflow in start_read()
Message-ID: <ZzcjYqn4TePx7tvp@a3007fd3cfe9>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115103124.1361582-1-dmantipov@yandex.ru>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 4.19/5.4/5.10] ceph: fix possible overflow in start_read()
Link: https://lore.kernel.org/stable/20241115103124.1361582-1-dmantipov%40yandex.ru

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




