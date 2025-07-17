Return-Path: <stable+bounces-163298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69D4B094B3
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 21:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90B0F7B13C2
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 19:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA552EBDD0;
	Thu, 17 Jul 2025 19:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P08oPNiM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3473215075
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 19:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752779784; cv=none; b=Gqw+QY6V7SpVzptrK09+ScCWVcHFPAmuwiNgy2lwdsP7XdwCUPSJAbIB0LtCmLXDUtSTfeCUQqSOapmFuTgdnrVFMyKVmR7onDX/GPO/p8gdXKKBSLlqbfkWm+cyxtUX3UnTbke92QSZ3vM14NIH7hO4CfM/O+YfUewJRVH+SHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752779784; c=relaxed/simple;
	bh=cprZdmMZC/yvYXglD6rcc0EAaVPoboL90R3XDiy9Hws=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nYTWPStfzGjvF4M6bvthD3AVhC75A/BpYD9kh4VMO8NicZYadMjIXi1ReixZSFFL+cMbz6fBKwMpBC+wj57EWBbbZ1UIpaC3KKor+svYinUarUYtggpnDny+dbLP5cnPHJSyAxsiAjXKnx7NKoXDvFjt04BbH2tKOwbPMo2n0JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P08oPNiM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752779782; x=1784315782;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=cprZdmMZC/yvYXglD6rcc0EAaVPoboL90R3XDiy9Hws=;
  b=P08oPNiMT3rtmkkT71F1/sGszNRUQ2GK2fsgOq0c5cMbfDB0dFAENan8
   2tTgcqY0yWqDaucv7cej9F2eDpAdP0QoziSAIa1lUK2VVz5SrzLV01uQQ
   225REL8IRk+QAUgm4vzSfx7kgZZXkwbHIg466udOm1xJmF91VeGA3Rkt7
   Ak/DJE19pUqvQ82pdc9KSZGAbmGoyrSNIcLjyAq3leg2Dxbz5mZBJFgXi
   5LlljPjoHX6AInFVF7KeXuiYK47M0xEP7ku6xTiY1Ynmu2FDdImT6pGdI
   ycMCfOvXC7chBy44KG7Bto1Ts6xTocfCEujtTyZg7eiDLPxuO3NNuc3u/
   w==;
X-CSE-ConnectionGUID: uwBJn9ZRSgyy5MCBeOfOdw==
X-CSE-MsgGUID: LjZKfXp4R+GxYglvTWg1Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="65760514"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="65760514"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 12:16:22 -0700
X-CSE-ConnectionGUID: yJ6cexaTT2CwGPoYI8IWwg==
X-CSE-MsgGUID: 71xxxmiLTqCTmYzmcfPvgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="158568290"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 17 Jul 2025 12:16:21 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucU5b-000Dx9-0d;
	Thu, 17 Jul 2025 19:16:19 +0000
Date: Fri, 18 Jul 2025 03:15:58 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] iommufd/selftest: Test reserved regions near
 ULONG_MAX
Message-ID: <aHlL7pUaC0b8irgJ@c1a0ab53bc35>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 2/2] iommufd/selftest: Test reserved regions near ULONG_MAX
Link: https://lore.kernel.org/stable/2-v1-7b4a16fc390b%2B10f4-iommufd_alloc_overflow_jgg%40nvidia.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




