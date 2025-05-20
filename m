Return-Path: <stable+bounces-145000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701CCABCE0D
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 06:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F753AC228
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 04:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEFD2586CE;
	Tue, 20 May 2025 04:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d9obrhuc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDC9B67A
	for <stable@vger.kernel.org>; Tue, 20 May 2025 04:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747713829; cv=none; b=BuVujLGCZsE4q5/mmA8I6FN4Y6oIcXHWqTwhBftZoPKLw8O1YNt6rkmVKnUhle8ZQU5fdoWkYlpDMkV7hd6gbrXN/XlHsMh8OnddloiphwRzphskx1CToonXN3ps3SiTUvZP0WMA2nSscVU9kH26KBAVRRelZVZKnDEoiJnKNdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747713829; c=relaxed/simple;
	bh=3BSxXLrjVb6zhk6/rua5gnyhtd3MPcC0kIvLbjCs7QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YNG6IEzb3Xdjhj0b9nBZ+xhyBqHNh4o6LtiJpzStfJMvM/ePblLqUR9TZj98AsJENg1vv8m+R6pM2iZde9sehGF2RP0SQ34QpcRMarC8as5/o9MQRHR4B8J7jvvbGSGmJFgzirG5svthPg+DL3rgURvjmz3nca2n6T6cv7heRpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d9obrhuc; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747713828; x=1779249828;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=3BSxXLrjVb6zhk6/rua5gnyhtd3MPcC0kIvLbjCs7QQ=;
  b=d9obrhucMgqCpmE2io8OscMyGlvekcmXJAVEmKSwftnuuzzlUJeb7n+z
   WE0Z08cwDy/0xjpBEWNthh4oo5MsN04JYmCJ6RiboAcXucbrmd0krdcbd
   mHAqKX6w2osGBj941xPO7X0H2NCIER8nR3DVmtWgwyt6Fz4QT+umpI9u1
   lBPnA4cKL3vZK+5Ey/78qWxlxVFcAmqB5Abip9tjvziiB61WQbEPvTU+k
   dKHy96ZZQWbXhXN0lGNWtBDHSYbuG3M/qVvXDzfh+L7DHutpXf5VcFya2
   0/QmcMYez1Ja/NeNPLsUqAcl8zk+etPKe25/ZbBchoWj3wvYUySFwrjVq
   A==;
X-CSE-ConnectionGUID: l//yT3DBQ2C1yjxjMlbbow==
X-CSE-MsgGUID: C0l7d98wSM+NdFJa12swCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49506437"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49506437"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 21:03:47 -0700
X-CSE-ConnectionGUID: XRw5gldAS6GSUKydk1CIJw==
X-CSE-MsgGUID: PSC1XjQATkOjlje704HtSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139454304"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 19 May 2025 21:03:47 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHECd-000M92-0l;
	Tue, 20 May 2025 04:03:43 +0000
Date: Tue, 20 May 2025 12:02:45 +0800
From: kernel test robot <lkp@intel.com>
To: mhkelley58@gmail.com
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 1/1] Drivers: hv: Always select CONFIG_SYSFB for
 Hyper-V guests
Message-ID: <aCv-5dhgFWrQjuq3@99c60fc626cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520040143.6964-1-mhklinux@outlook.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2 1/1] Drivers: hv: Always select CONFIG_SYSFB for Hyper-V guests
Link: https://lore.kernel.org/stable/20250520040143.6964-1-mhklinux%40outlook.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




