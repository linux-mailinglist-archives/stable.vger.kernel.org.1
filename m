Return-Path: <stable+bounces-106788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23727A02173
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 10:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E8F1638F1
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 09:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075A82B9CD;
	Mon,  6 Jan 2025 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NOi6Xr10"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B5715EFA0
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736154453; cv=none; b=tdKzVeCGSLfJuouiY64yVITKy+Wrnt6kk294vP5p/6xuypjvBi0CJOu2w6XSnIAIxDHq0fVEzTHB+ggJ/r65UWrwBMhS/1n6aFSLMo7u85WbDDh0XG3bimKVOuocHQRvZ3EU2c5d+vlDUpf91r+6hoRRk+y6KG/12tvpqWIdWec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736154453; c=relaxed/simple;
	bh=WX/cTI51eExRWKE1duz3/a9PE/4RT3CpYAUg8nb39Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LDGLxzOFx8NDNLiutpUfCiwhThCjS5BPHGacM0ZYO2AHVYso/1U3OzlQMUlIs2deRiECBJJc1zHoyla6SvlheH3GTgKU7bnt1QNTVSXN2puBqscBuZF7Gxpi/Afzp1kJ59x49hVTSHd+yaG3DXZtUXxF10ciGSaqFCrejU3e1CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NOi6Xr10; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736154453; x=1767690453;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=WX/cTI51eExRWKE1duz3/a9PE/4RT3CpYAUg8nb39Q0=;
  b=NOi6Xr10PQlWokVv6+ZuUOms4Wta8wdLL87a/JWXSwLiqVUuykgQ5tpY
   eDo9KuJ17Kwo5gEqMufXnUroK0J8SOMpfIicCiclxFTODRsba+rL70Dl3
   gQz07EMawOZLxGf35lRwtlmUkqAmGB8j2yJkcq7sO7GIllN3C8fEXzWT2
   5c1uNVdFc5o/1j5LNZCKCsUonJ83gNzD5M0aX3PP1+na5yYJ4KZcBtAAc
   NnhxABapbiLW8c94BK1HlxJxRP0dFTvynVln/yAqN4N1LIHuNd8PemW/C
   62kzzLbNUmyQf1GPbBcgnRscheXGyLu+IQtonn3majpyTJ5xVLXieXTdr
   Q==;
X-CSE-ConnectionGUID: BCvP8KuhQvug/UfSH5XAdA==
X-CSE-MsgGUID: Io1fowSWTfukpxNr/I+Gcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11306"; a="36173878"
X-IronPort-AV: E=Sophos;i="6.12,292,1728975600"; 
   d="scan'208";a="36173878"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 01:07:32 -0800
X-CSE-ConnectionGUID: sDaGljBQTOyN5GuzVXgVng==
X-CSE-MsgGUID: ReEg4zVDQz6bcml8UqaRlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="139730985"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 06 Jan 2025 01:07:30 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tUj56-000CR1-22;
	Mon, 06 Jan 2025 09:07:28 +0000
Date: Mon, 6 Jan 2025 17:07:12 +0800
From: kernel test robot <lkp@intel.com>
To: wujing <realwujing@qq.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] sched/fair: Fix ksmd and kthreadd running on isolated
 CPU0 on arm64 systems
Message-ID: <Z3udQDqJnJTaQ6Hc@997da2bbb901>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_44452B098A632CA84FCB293DA658E7BD4306@qq.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] sched/fair: Fix ksmd and kthreadd running on isolated CPU0 on arm64 systems
Link: https://lore.kernel.org/stable/tencent_44452B098A632CA84FCB293DA658E7BD4306%40qq.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




