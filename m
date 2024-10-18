Return-Path: <stable+bounces-86805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BF69A3A89
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 11:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7FBB28450F
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 09:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B73200CAD;
	Fri, 18 Oct 2024 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GyNlub/m"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8194200CBC
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729245206; cv=none; b=hcRIlwHcWIO/4Lg6UJo/TlqSEWL32gIVZ5NW/XfhdvUkxEtwY8sPH4Udqe3IOteR8sUHJixcGpf7rXjjVLHK0fQ+ZyqPZ4ZuC+rCp4+upYH6Y0+fclaZYJUFBZHQ4RTuJo9cbSV7RqYZGCJ4Fm3b+asqXu/qYFatV0ilQoGp2vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729245206; c=relaxed/simple;
	bh=f3Fvwalzig4Xw7bYWqFWf5/T+480AGCq/fMgFd1CL3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OUyjdN7J4nc7F6JGV5vZrsPMhKaPBluQf0MhLCYu2qoI+hrJZKLtTnFzD3dkEJgyXZQvPbwy/PeEsHvsyz/TbcJwUOTDLW3PWfV1MPSrlpZKGUCIAA9QIh8UiYh+nj9aTxtTP5U7YgRfh9kND+Ym3fQ7NN3CwduIxtKS1dq9VJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GyNlub/m; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729245205; x=1760781205;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=f3Fvwalzig4Xw7bYWqFWf5/T+480AGCq/fMgFd1CL3Y=;
  b=GyNlub/mCct1dO7/WcOUF27EwFQGgOU5mxr1SXnC9e1NQBdHFCOMaAoh
   GBXwXTr7w2sk5yTlWqeKJ1S0rfWFUxYWqgWX25RdxqbmvjM1wkYBxrDgh
   qWRiJ09MMuXDQCFxuqYy4Rg4MrjZRK/i1OuicWNF2rFiTLPdLi8pIXg11
   vPdPMaTxHcgcXXx9E3CTvfLHX5tDlrhRTOCdso1WRhWRT7vp97Cxkoas9
   nJrjkkMTG3p+RbaZNXkOSWnOlWnGdJouaSR55Bc7CQCnJyW2wCVSqoe0Z
   gaOCJRtujESA5jJycM/OqkxapqJTugu502fRqdSz3l5OFwDnrIhwS7K/o
   w==;
X-CSE-ConnectionGUID: yLcIDXxcTzSzPvGdxfTPdA==
X-CSE-MsgGUID: LTb0r+tBRBOdrBOFg5ApUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28862487"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="28862487"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 02:53:25 -0700
X-CSE-ConnectionGUID: ON8/I0P2QpOK8NoZhrfjNw==
X-CSE-MsgGUID: /fccewSBSluHARbSyXmTqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="109641206"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 18 Oct 2024 02:53:24 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1jfc-000NZj-3A;
	Fri, 18 Oct 2024 09:53:20 +0000
Date: Fri, 18 Oct 2024 17:52:35 +0800
From: kernel test robot <lkp@intel.com>
To: Daniil Dulov <d.dulov@aladdin.ru>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 5.10 1/1] iommu/amd: Prepare for multiple DMA domain types
Message-ID: <ZxIv469lHr06zCCO@594376e94b8d>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018095122.437330-2-d.dulov@aladdin.ru>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 5.10 1/1] iommu/amd: Prepare for multiple DMA domain types
Link: https://lore.kernel.org/stable/20241018095122.437330-2-d.dulov%40aladdin.ru

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




