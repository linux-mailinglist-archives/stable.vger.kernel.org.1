Return-Path: <stable+bounces-35913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B3F898480
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 11:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC8D7B27B4E
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 09:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB85074E10;
	Thu,  4 Apr 2024 09:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jqu7y5uH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A43874BE2
	for <stable@vger.kernel.org>; Thu,  4 Apr 2024 09:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712224725; cv=none; b=OggV7uVcrOJxvpMYJPSPXViWD4SooBlR4OerUt1naaIR0+5TpU3lgZUctqj+YZFVjTj2jNSktLYqH0DJdCIR5muDX79KfUajSBF1+hILfdrvdWuoLBs7bWJYa0lg+0YWZ1U3PV+bbnH5RHzycdW9XJYWNYTBSQAcSP7kEKocwcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712224725; c=relaxed/simple;
	bh=r93kZGE8lq9CvqdCkrxuuyYjexfZ/0/ktYPyHndCINE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=riTLid7QLRgWfJ0ZUMcaYn8bmftfkri9ZhZnoT7a0eJUL58bOvhVjD7IAN04yrlocVGEJoAp9wnfg7Mn4HMoxK21kUe4RGIp1cT9MAOc2Y7GRj/cnRv8XU/IbnRFiQbSpbq35gmvb18J9soudL8MBauwgyDZ1pPCF5VraozjSTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jqu7y5uH; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712224722; x=1743760722;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=r93kZGE8lq9CvqdCkrxuuyYjexfZ/0/ktYPyHndCINE=;
  b=Jqu7y5uHlO8Q3HVBXlA0y+uwQLdEmCQ02UhMfDnvGc53Mp87sIFbcyYz
   8JD4GRY8EUR8a30SP20dxjCFatyz9DZpQJKaNUOneNctzu2cY2j4Epcf4
   vxTAF+vo+MBBbzQGZOdyoRaRx2E0iXmDx6QfYJZAyTcAXEaEcxXEuwKGN
   RGsXp3HA3Ft6z8tQ5od6HkAP0nvL6EbKOVA86w7UObOxGL6zLuhvjHe+u
   aBKKzGC9qq4Bkdsriu+oHFawkVg7lwlpEyfv29NeGU0QIWNGJq3ZIlkPI
   v5EBnscTR0sLAfROuLBHB39LJmBICfkk6N3puBAbwwEVuqYoc1fo4si5K
   w==;
X-CSE-ConnectionGUID: d8lm+FibTS2EbPpK7TiyTQ==
X-CSE-MsgGUID: L+JqobTFTd6i3K9cBgfFng==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18850611"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18850611"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 02:58:42 -0700
X-CSE-ConnectionGUID: FvtEOqmSRq+zhEBOky5iRQ==
X-CSE-MsgGUID: rrCBSCIhRFSjezZavJa16A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18842247"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 04 Apr 2024 02:58:41 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsJri-0000t2-31;
	Thu, 04 Apr 2024 09:58:38 +0000
Date: Thu, 4 Apr 2024 17:58:19 +0800
From: kernel test robot <lkp@intel.com>
To: Mikhail Ukhin <mish.uxin2012@yandex.ru>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] ext4: fix i_data_sem unlock order in ext4_ind_migrate()
Message-ID: <Zg55uwi6wI9OIRbT@92629a18465e>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404095000.5872-1-mish.uxin2012@yandex.ru>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] ext4: fix i_data_sem unlock order in ext4_ind_migrate()
Link: https://lore.kernel.org/stable/20240404095000.5872-1-mish.uxin2012%40yandex.ru

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




