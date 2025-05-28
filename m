Return-Path: <stable+bounces-147917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B25AC6376
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 09:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 779B5188850D
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 07:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAB024469C;
	Wed, 28 May 2025 07:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RB495mPk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DA03C01
	for <stable@vger.kernel.org>; Wed, 28 May 2025 07:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748419007; cv=none; b=KxPTrsymVySA4nz4AGb9twm7hyGkoIEJ0XbQATexOOFLBajY3z+DaBHV4zg8mRgwTuwgQ/YvPb5+lJXpui6VMkK+afLeukymjT7EmO+GnrM8GsL9L64MAkf9zEjskEwbcVVPdgh0PXV/Z3A/q+1Dtc3YxDHE7p6zZpe42Lt0Qt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748419007; c=relaxed/simple;
	bh=2quF1TzNm3eSr0sTmh6xXHshy2hAs3WrpOYb+S87YN0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JiUmkxa1OVEw8rJA+XOZ89nA+bavhzccKvtGRO7xswZahtBJf1+Jdz2SfjKYCDJECeIpbsV4/VDr9p+geq4te2oyOsrIKNRcxKuIOOU5R4y1vfaamMtd2POMLxshcBcZN44oC9F/sZS2B4JKsyr/ij+0xsxGxyx6RBTKLHUoN0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RB495mPk; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748419006; x=1779955006;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=2quF1TzNm3eSr0sTmh6xXHshy2hAs3WrpOYb+S87YN0=;
  b=RB495mPkXq4FepoEsjhwmqKfKGtTiIKXlVcDGFEkWhk4NKDzQJvqn7YR
   MFpA4KKhT/9BkHTMGjCpBB9uzvvR0m/IjHym8XL2Da9Qkwqk1pBncNnr2
   il+877U7rVu84wWByPTGS6NcbDJdypCdPgKma8yoDpUWG15ntw1nWVk1J
   kbRPvRmkMktqUUpxTO5TjuNRjHyBn9+26+zw1DqRzTIKujCD8LKpj2Ie+
   v3rD/Sp7gGQG8FP4XCsHhyR2ujwiWaphy0bATx4QN4GBcOTpgYyHKTT0A
   DW5JpkJrlmmg6GjdMaLhqNqXv7ySFsHovkNe4FxGRgc45+CO+RlXE4VDK
   Q==;
X-CSE-ConnectionGUID: +Vi9vCLVRgawXViXIQBfoA==
X-CSE-MsgGUID: eiKBgt4ZRl2JCNVDz3bZlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50427557"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="50427557"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 00:56:45 -0700
X-CSE-ConnectionGUID: JVd578ZSQWK+XMChPfEAyA==
X-CSE-MsgGUID: Oet0+pOQTx+Iuu4tZM7g1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="174054574"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 28 May 2025 00:56:27 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKBeD-000VOy-0s;
	Wed, 28 May 2025 07:56:25 +0000
Date: Wed, 28 May 2025 15:56:21 +0800
From: kernel test robot <lkp@intel.com>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] driver: net: ethernet: mtk_star_emac: fix suspend/resume
 issue
Message-ID: <aDbBpYQcbf3miamI@695863d2c026>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528075351.593068-1-macpaul.lin@mediatek.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] driver: net: ethernet: mtk_star_emac: fix suspend/resume issue
Link: https://lore.kernel.org/stable/20250528075351.593068-1-macpaul.lin%40mediatek.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




