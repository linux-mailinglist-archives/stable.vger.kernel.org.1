Return-Path: <stable+bounces-109217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 775D1A1337D
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 08:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F9C1886BCA
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 07:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FE8273FE;
	Thu, 16 Jan 2025 06:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cMGz46Gt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D201D934B
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 06:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737010761; cv=none; b=DnousFLoSI1V9ETiekhQyp+qs8TNuEaFVQaTLqBBwZ214zapOuAztDG5iKm1DWGwUqHF12jZH67WvjprgWZADW346RKuUji3TvMnWdqy8l2OkZEBFqZDv4psLtA4CDAkTgpS9HcSvhbdfDewdwD6Iroi1P2g+h0w7n9MHYR8mh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737010761; c=relaxed/simple;
	bh=IiZEnuHLgcsEuqA7jZRn+5UMwq+yL/TGc8SgEVdR5mI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cu4zTFyzHmsGiyoIzxWC8X0UTACDFnATiqSYVGVvezCOaDC85Y2aG8sCCUGRFJojNAoBy13cTCF/+ClhQokuUpcvwosw0yf/N4bLpQZCFDrv6p6LJrMyvPV/8NgPM69pbPjD/Nd6RnbY2PhJdmeKKq9GbGYibz9YjfnczjKDXYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cMGz46Gt; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737010759; x=1768546759;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=IiZEnuHLgcsEuqA7jZRn+5UMwq+yL/TGc8SgEVdR5mI=;
  b=cMGz46GtpS0/B9ZrobKnboXFzI+WCrP4hG61Y/V1w+LIJf7mu3Tv+xJe
   6bkD6lkWRyY/Wj8Y8wKbUo0rnoMY6mK/N3ZeuNyH1zuIofuBOB3tTsknS
   n6o0hT0PyNy6EuItl2Ttiwexu7T7vQ47tKlP9VcVz39leuV52CCheJZLP
   nUD1xeJe2hq2veIq3FQVSF6pQj6bS9VQbNndw8hGEOFftxwQNHJ0XrYna
   J4+1r8M5t+hon98zz7+aJavrGUMrvOEsbcJm6FzY+bC+RMwGL0laDaN8M
   ai37lgOt+nEm3XALLl2T2ouVy6euSsJcs0fjgKHdtp3PENUJFslrwUjIw
   g==;
X-CSE-ConnectionGUID: NuZzu8N3S0yQpE7DiktP9A==
X-CSE-MsgGUID: 3lYuQglGQrSkstqmqG/pZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="48382668"
X-IronPort-AV: E=Sophos;i="6.13,208,1732608000"; 
   d="scan'208";a="48382668"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 22:59:19 -0800
X-CSE-ConnectionGUID: 77fmqFYwSKOviU4tTo76Kw==
X-CSE-MsgGUID: oJc9YAHoS8Kqukc9zQrjmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,208,1732608000"; 
   d="scan'208";a="105440745"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 15 Jan 2025 22:59:18 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYJqW-000RVD-0W;
	Thu, 16 Jan 2025 06:59:16 +0000
Date: Thu, 16 Jan 2025 14:59:07 +0800
From: kernel test robot <lkp@intel.com>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] x86/fred: Optimize the FRED entry by prioritizing
 high-probability event dispatching
Message-ID: <Z4iuO6OJeuR2pmln@971a9ca124d8>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116065145.2747960-1-haifeng.zhao@linux.intel.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] x86/fred: Optimize the FRED entry by prioritizing high-probability event dispatching
Link: https://lore.kernel.org/stable/20250116065145.2747960-1-haifeng.zhao%40linux.intel.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




