Return-Path: <stable+bounces-95869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D63D9DF081
	for <lists+stable@lfdr.de>; Sat, 30 Nov 2024 14:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EE3EB211AC
	for <lists+stable@lfdr.de>; Sat, 30 Nov 2024 13:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C60F1494B3;
	Sat, 30 Nov 2024 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mx22Laq3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C231DFF7
	for <stable@vger.kernel.org>; Sat, 30 Nov 2024 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732973563; cv=none; b=NOE4D58NlQW4z01dkQmPpdVK7EOGoksCRdeWTDlreE8wCfDblxGPgPRbXsaaXiaQT9mCzZSrNQP19eGJG7F/RE83HUBY3BQYQ3yGP2VqF4mbN4cIQChRtPP7U7Gk3bcO31/39gDF9p3eYnEi3IklwQn5NFSvZzOw0PkaQw20bnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732973563; c=relaxed/simple;
	bh=WTj1lwkWjVN0i0IOZUq99tt+uM/w/gpKvAiB1yUAFeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uSDRA9t5TpWg/COOR1dDhS0lulsBWeC8u6TNBOFdHho2uyLxGU8+dxO8vhwLoTCzoqEbhgo6CryGTBLPxD6NVclJmWKb3HsB5xHB5JQHCux3nXzGDpJq7VZABstW7staMRD3XzHltHwz9aws/TsaW36IuTcDylekpalEDhAr7SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mx22Laq3; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732973561; x=1764509561;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=WTj1lwkWjVN0i0IOZUq99tt+uM/w/gpKvAiB1yUAFeQ=;
  b=mx22Laq3pQp7kPpHVjeAAwU8RLP6+3yLFTKFKj1ByPFGUeGpSO25kTfm
   CEOMUjat+N4QZGze8SqqvmYN9glglHu5UGZJchtFT5QtloVDOjvjq0CGR
   p5Unr0iyTYkyO/BP6Zyn5a9ht/IU3gc5ODheOedFRJzk7o8phGlCTFdn5
   dggMFtUNQl62ln6UrFmh725+U6C8KEmHWbR6T0noZF3t2EYMFKfNkoJkl
   C2d2eB44xXEviL2Hx1TCSsasIZw/5w7WLgulOv3MLWhf9XeCvlv4+oBCB
   0AeievSFrDNd5Tvh25P3I6IXWNrHtPqJiaYDHV2JYiqWgTwvYTuqjz/lE
   A==;
X-CSE-ConnectionGUID: Q6Nig7jSQYaJK+Hq+sdSFA==
X-CSE-MsgGUID: Yv3I/qWETIGiQe420dEBqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11272"; a="20767931"
X-IronPort-AV: E=Sophos;i="6.12,198,1728975600"; 
   d="scan'208";a="20767931"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2024 05:32:41 -0800
X-CSE-ConnectionGUID: HvBtBlogSdK3V1C7tUWVKw==
X-CSE-MsgGUID: 427upFbsQpCWXVj31vBNhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,198,1728975600"; 
   d="scan'208";a="92852496"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 30 Nov 2024 05:32:40 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHNZa-0000hP-2T;
	Sat, 30 Nov 2024 13:32:06 +0000
Date: Sat, 30 Nov 2024 21:29:10 +0800
From: kernel test robot <lkp@intel.com>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.6] KVM: x86/mmu: Ensure that kvm_release_pfn_clean()
 takes exact pfn from kvm_faultin_pfn()
Message-ID: <Z0sTJs1lfeIENOv0@ff21b5d8d570>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130132702.1974626-1-kniv@yandex-team.ru>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 6.6] KVM: x86/mmu: Ensure that kvm_release_pfn_clean() takes exact pfn from kvm_faultin_pfn()
Link: https://lore.kernel.org/stable/20241130132702.1974626-1-kniv%40yandex-team.ru

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




