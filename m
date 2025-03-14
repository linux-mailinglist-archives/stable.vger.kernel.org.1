Return-Path: <stable+bounces-124398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFEBA6069B
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 01:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C303BF181
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 00:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C9C5228;
	Fri, 14 Mar 2025 00:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B2Pe2e83"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1A92E3360
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 00:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741912689; cv=none; b=DtFxmSu1rhXF3Z5FhHdK/Imgd/YRDvvhb6B1I7nczpsPbBYlfxHeU/+sa5hQ8pK0Dukn5/HQJ0zXNi2piHNFkcayPLOb20TSmEFXBHImmNz9ssZuQkUlGHzlZY0YHduWbIz4b3RjcV3/L63slXJARE6bXLXGlfHwKAcaadFlXvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741912689; c=relaxed/simple;
	bh=2gR/bhqg69QZeYmNMbCHpL1+gWLSq6SL1aiUDJK2jCo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=k9o9TWl3nbr6MD5PCTLkvv5kFxJYS4zjT2pMRv2CCkXWZNDO7BUD+oHt4sC6FxGd2u6T4AN9Cte6CJmbLkcD1cuS+PVNeBH0N17XYggE9zO6IXfms+XXOI344alrPlh5CeZwuT0C03FSdl1u/GOfT8DsBvL3UVcMh1quflgbhCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B2Pe2e83; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741912688; x=1773448688;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=2gR/bhqg69QZeYmNMbCHpL1+gWLSq6SL1aiUDJK2jCo=;
  b=B2Pe2e83eVCLMF5HCfK/fuMz3b6646L0Kok5hkYYTeZ8A4SvJeTj89Qm
   3DBiHLWmntzwhBubGIMDxxVqdYj0guRPrcvC0ND95FnPiwq10QYjvDJ4b
   l9RaTSvBDyCfhlIh48Kf1AsSggEIWEqGNrZfdw09vJITr6504llGr+fAI
   IbrbGakd4kGBCzHwhVc3Ja03j2AaA53KN2hzPtYF90uCyb4rD/3b4IwfU
   BPrMH0V1scyfO7RUIGZaeCqA73PO9g4ma93C2lqZH6SIRDwn9Wl5XjjU3
   cgtIyraGvaLtllUARIbi6TTo+pSicmtOGn9E/hIEUMTK2J7SlHcSY5Ids
   Q==;
X-CSE-ConnectionGUID: c6jglyZbRq2/uoGXqFN1tQ==
X-CSE-MsgGUID: 7zwAb9azTwCevHLCqKAUug==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="54050635"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="54050635"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 17:38:07 -0700
X-CSE-ConnectionGUID: KHGlGqi7RdiA1VM3gp/6Iw==
X-CSE-MsgGUID: yyCZ6jeVTaq+v5YhcCcccQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121818813"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 13 Mar 2025 17:38:07 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tst3r-000A2K-2Z;
	Fri, 14 Mar 2025 00:38:03 +0000
Date: Fri, 14 Mar 2025 08:37:54 +0800
From: kernel test robot <lkp@intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.12 3/8] KVM: arm64: Remove host FPSIMD saving for
 non-protected KVM
Message-ID: <Z9N6YiQcZZNQy0Vu@32d88535ca07>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314-stable-sve-6-12-v1-3-ddc16609d9ba@kernel.org>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 6.12 3/8] KVM: arm64: Remove host FPSIMD saving for non-protected KVM
Link: https://lore.kernel.org/stable/20250314-stable-sve-6-12-v1-3-ddc16609d9ba%40kernel.org

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




