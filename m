Return-Path: <stable+bounces-186260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955D5BE73E9
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 10:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4FB586028
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 08:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0648129E0E5;
	Fri, 17 Oct 2025 08:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="USH3g03Q"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6310A26F44C
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 08:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690688; cv=none; b=pbah/cNhueEeoKuSr200XUuqNEy+wstZb21BgXa2Bxl/rv8hyptUOGQUBofo7S9Gz3Bz6S97XitUurMQwTi8Q0vu0yrttpPXXeHfa7PLd7JF7B1u1iVD2sfvvygLIGccI/XASme2uYSKx2nAKRDZvTfZZ3TF9HWFPkM8Xr9YRhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690688; c=relaxed/simple;
	bh=Y98ZKLF+7BjByi5cyVpSHwAEzXBXyJ5zb5RbjsR4cSo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uc/u+NQj8WoUmd5an4exIgGqFe7+rRYcOtNNZhW+irVJgBgpQ8X+sAwYaZWOGHcCpRVqhpHaipyza1gFINj4t4wmzGk4tXCFj9tUguuUW2w53wPWB6Td23sDMtHN4j/Y8aN7v8bSMUwuvBBBGahrjyqAwe4p+onGD0orO2pmdt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=USH3g03Q; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760690688; x=1792226688;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=Y98ZKLF+7BjByi5cyVpSHwAEzXBXyJ5zb5RbjsR4cSo=;
  b=USH3g03QgbsB76qty2rrqsx6ahF2qLuegfSW2zU7fyP/Yg2IPJjAmkfx
   SZra2I/G/wXKRlVr1YK0W8WIE5m2Lui48Hdd3XsevSakt5MEzcDA6h87J
   K0bK4CXD8Cepd1pm70RR3Fm+bVx4KZGtc24gdyvhSs7V4AnIdFfLQhfbo
   mOrnsVdlzc5oVMlTbk8GkSuZRijVX8OuDHn8K6fZJu3TwGGN+amwgMQ2U
   ypiWca1zSNi7I2s9Mr6eJ8kcK2e5+NB+TIvjnCT9bX4Mw7iXs15ipVVkN
   gy8BJ4oxkIZw10AAB8sRtRaVYdjrEHspYeLSDWwe/TnBcblL9MiyeyvC1
   g==;
X-CSE-ConnectionGUID: hoOPrZn/ThSDCy6cpPouHg==
X-CSE-MsgGUID: x6gNC/DMS4u2Dp4CewJX1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="62608729"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="62608729"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 01:44:47 -0700
X-CSE-ConnectionGUID: 27xKFFBxTKm/1VdrlZPgIg==
X-CSE-MsgGUID: k5o0Zs2MRSudQj/qo6dA2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="182617930"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 17 Oct 2025 01:44:43 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9g4A-0005ln-2E;
	Fri, 17 Oct 2025 08:44:19 +0000
Date: Fri, 17 Oct 2025 16:43:22 +0800
From: kernel test robot <lkp@intel.com>
To: Junhao Xie <bigfoot@radxa.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] misc: fastrpc: Fix dma_buf object leak in
 fastrpc_map_lookup
Message-ID: <aPIBqrFFUfK8j94F@0fa591faaba7>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48B368FB4C7007A7+20251017083906.3259343-1-bigfoot@radxa.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] misc: fastrpc: Fix dma_buf object leak in fastrpc_map_lookup
Link: https://lore.kernel.org/stable/48B368FB4C7007A7%2B20251017083906.3259343-1-bigfoot%40radxa.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




