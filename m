Return-Path: <stable+bounces-17600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F50845B53
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 16:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11894291CD9
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 15:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E3362141;
	Thu,  1 Feb 2024 15:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CnXgDL55"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FB162160
	for <stable@vger.kernel.org>; Thu,  1 Feb 2024 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800896; cv=none; b=sQcU/kei9ZH0yz2uJwaenctSy7TN++y7GiUJabAZ0C++gzRVpoST2Tn4EEHbEdmVF3pSghdYMb3uW9jr0vGWwSLUB0DSqnxis88ZXWaZg4TuUHQRQMouXaCz+Le8plBNRLY+wJkyL1s6rO4XcWXtouDhxhphYS7n6ZSfSgpgG2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800896; c=relaxed/simple;
	bh=Rz1ISlQvXK7se5VfKnwD+BIm7CixEnvyuGtUH8hcAuo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=M0CflkFA40bTjqsCAgMifbDTqmzXPc/PcyrPEc7MosHGybLl93wCb07eK3TBFKQoXYHUZqcb6nZqGshGWOgQpXr1YIPwJ3J5qPoAcUbc4pMTpse6qd6N36fgVC3GQLjMsNBiSjZo/CrIUdMCEkYiXFZ40eRnmiYjpgDgKdQ6124=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CnXgDL55; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706800895; x=1738336895;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=Rz1ISlQvXK7se5VfKnwD+BIm7CixEnvyuGtUH8hcAuo=;
  b=CnXgDL55PeD005usg1a20QYkyR217rU7VxakI8ESAIiFxl1701OyQET4
   dd7M/rVnilNwsvrZs32K0Lq/0CFsd2WF4lb3tnGkE1RkO2ytadOQzEUCW
   NXvm7of1SjBRlUw70KXyPXXmA7S+jy2yzSKjVK+WmynMN4ag3rqKynuPB
   w/ijGt26O28pgoUe1dzIy+ca6b/d2Tu35bXowBTkKgvvvnIf44BNf688X
   sSE+Y+yZsKp9K4ghW3Z9OWzIerc+QlwbSx2kyzLZozbjt7ezGI2U99Mcr
   DYZl5llicSNNiuYKy3hixyPGL1e9PorOd4zHj2Gs++9O2dcqXS86FFLE1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3784544"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="3784544"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 07:21:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="23122079"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 01 Feb 2024 07:21:32 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rVYsc-0002tW-0a;
	Thu, 01 Feb 2024 15:21:30 +0000
Date: Thu, 1 Feb 2024 23:20:37 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] tracing/timerlat: Move hrtimer_init to timerlat_fd open()
Message-ID: <Zbu2xc_hrGtyPwRe@ad1fec2ed832>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7324dd3fc0035658c99b825204a66049389c56e3.1706798888.git.bristot@kernel.org>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] tracing/timerlat: Move hrtimer_init to timerlat_fd open()
Link: https://lore.kernel.org/stable/7324dd3fc0035658c99b825204a66049389c56e3.1706798888.git.bristot%40kernel.org

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




