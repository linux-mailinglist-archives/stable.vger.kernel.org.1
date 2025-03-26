Return-Path: <stable+bounces-126752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 539E9A71B82
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 17:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F6C3A72EE
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 16:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D0E1F4E49;
	Wed, 26 Mar 2025 16:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mC2uUPhD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3881DED5F
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 16:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743005021; cv=none; b=lh91So+61R8iyWQek/mQhtNrsVYei2LaLxsPt3WuBo0SQZ06RZQcR+fhjbtthvGabJVa+Y4lp0bPJRe3Ofip3uwmKzhhPFX08MpATaB+RtI/5XBv3iGe19fDuKgjbeuhlmewKMZVr9NCummQ2Si485LDPhaFSRD1hbWCpxBEExg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743005021; c=relaxed/simple;
	bh=DIGBvEQcDP2OyG0z/2hdZbWOODZ066I5uVepjeYcXZo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=T+3mcecAILNLtz7eI9yWjLJ79oPF39c4v4+gIXXmqW3LSOTDlMNd/fmXwG1AAGkUroZNhTcjUFmWq+8A4ajuc0C4qbXKigbHIwG+AVkaTU4gqaJ/gFYZXNU8LLKfunkXMwDY/g9XXaw8bpOH3Z6x+Guw25/4RW5XQFvJLEaPmGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mC2uUPhD; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743005019; x=1774541019;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=DIGBvEQcDP2OyG0z/2hdZbWOODZ066I5uVepjeYcXZo=;
  b=mC2uUPhDefExiVVGlieVYx4lkxixbHBawyiQbWNEvsMn7UHmOKpd24Bt
   JoPuOkl8BA7ACkUXibi4eNiv42jCgkvQKW16p/31OOSOvb4XhubljnBED
   v08y1gvfR3E55UjlLz/LswmO/4ls4mFbcrulRWA2Te94YtuLBdAh3Sx5M
   bYbq+Z+NWT3j5arDAASmjaAcFXtELpSnMDLKvuERyRW2j8tU8vxa6cPW6
   dhHKWdDTEgNVpcKe5vc1z6HwyC9xaNYh0rXmJfJEkapCFwuPMKMkBPrQL
   xvEPNKe14XxMeJuMDvKlH50fhSxABUaRrMbd5Wv/R6YRqOqI7SkmMwGeL
   Q==;
X-CSE-ConnectionGUID: 0xb/nBtATTWGl9ruGU7syw==
X-CSE-MsgGUID: OiRnMP3QQPqDX3ignn3DpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="61824245"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="61824245"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 09:03:39 -0700
X-CSE-ConnectionGUID: IjPzLKU/REafhqwTZEnHpA==
X-CSE-MsgGUID: t+tr4vzWT8ypo4+9sCP/zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="125326678"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 26 Mar 2025 09:03:38 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1txTE6-0005sZ-2X;
	Wed, 26 Mar 2025 16:03:34 +0000
Date: Thu, 27 Mar 2025 00:03:08 +0800
From: kernel test robot <lkp@intel.com>
To: Sidong Yang <sidong.yang@furiosa.ai>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.14] btrfs: ioctl: error on fixed buffer flag for
 io-uring cmd
Message-ID: <Z-QlPKOqLG7masRH@06395982a548>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326155736.611445-1-sidong.yang@furiosa.ai>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 6.14] btrfs: ioctl: error on fixed buffer flag for io-uring cmd
Link: https://lore.kernel.org/stable/20250326155736.611445-1-sidong.yang%40furiosa.ai

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




