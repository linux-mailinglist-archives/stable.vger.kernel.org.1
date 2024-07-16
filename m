Return-Path: <stable+bounces-59401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E6993239B
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 12:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71AA2840E3
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 10:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6FB197A91;
	Tue, 16 Jul 2024 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iGPVdnTy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6113117D372
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721124712; cv=none; b=vFUl3kkLB/xaHm2OE2OhArwSExasKZtiGEItdZ5ePQkZ/KZt89PequHlnP3zixjqHyZa1iMVQmnRtQO5cnKaS7i+67EYMQpZqC72yw0AZU/FQMSD7Ct9RVQgOHcqlRVqjb+QTigilDgiVdYm/gFym/zz77TU6faNwQZWK5Fqn9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721124712; c=relaxed/simple;
	bh=j0AETOJp5nud31QiyxiRoZnyFSz7TCB3y5w71U5iaF8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=k4UqQMqrUAfdyKrJpsoRA6A2SiR8SWR1tZdpQ9e4QmMF0pdCEQAOlkyCM3I8n6YIbL6knz/mtpo5aHOk89cTUcPQAetM/8tOAL5z+txM0dcd1cJbTei4Tn707HxG/0NW7od6oMSeEmj3ZEFsPf4KjnxdmF3pTfWspcJl8MCTXZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iGPVdnTy; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721124711; x=1752660711;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=j0AETOJp5nud31QiyxiRoZnyFSz7TCB3y5w71U5iaF8=;
  b=iGPVdnTyDC4oSL9FfFdCYIqymk+bGFv/u7Ma+LkkhrUkjP0b63Y1k25I
   bXIXBBaGhQPUGy81UbOPibVB/mlKqCt7S5jqx+MXcJD9NM3rTAdZ+Q2P6
   L2IKNoUR7ChZWGJPwKxZ7BZrYqN5OezIr4aGhIv+RnPRO6IIx858hseR3
   f0gGyXCh1WZ+JSueBB4MV49nL1wbcoxSV6oIyCmApn9BBWxWzrbwD3ZnQ
   P8Bzo2WQPhgDII89kFhlmrPnF0cSQT664EJTfF4U0/+WSNHAnnIoekQ/i
   Nj4ypZYCNfy/Z2RRPvISyxmuSQxJeiEksJ7l9rULsdyF9YdlHHL6krt36
   g==;
X-CSE-ConnectionGUID: NNP4G1D5SqC2IhMrVyYbWA==
X-CSE-MsgGUID: FYEDeLvmSV68LCJpcOa0hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="41077305"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="41077305"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 03:11:50 -0700
X-CSE-ConnectionGUID: +fbz4jt3QUuqYC1kvoUrbw==
X-CSE-MsgGUID: ySaUktapSYij5aqB7BokOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="49883367"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 16 Jul 2024 03:11:49 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sTf9u-000f78-2q;
	Tue, 16 Jul 2024 10:11:46 +0000
Date: Tue, 16 Jul 2024 18:11:09 +0800
From: kernel test robot <lkp@intel.com>
To: libaokun@huaweicloud.com
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.6/6.9] ext4: avoid ptr null pointer dereference
Message-ID: <ZpZHPWgCV-J8oKXR@6724a33121ae>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716092929.864207-1-libaokun@huaweicloud.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 6.6/6.9] ext4: avoid ptr null pointer dereference
Link: https://lore.kernel.org/stable/20240716092929.864207-1-libaokun%40huaweicloud.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




