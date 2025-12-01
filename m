Return-Path: <stable+bounces-198004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB83C995AB
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 23:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B3D2E347158
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 22:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EB82C159C;
	Mon,  1 Dec 2025 22:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JAqL3g/q"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57C328642B
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 22:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764627101; cv=none; b=cVGtJwuzD+FRT/cBVt46/0f1MyD0lcbYqNYPhBVTsIe4VKPN6FSEv1RuOG6OQeOInD6sCOoo22UYTq1zrnrOZim10MiSSydh7qpdhGNF57Yr0hK3dvVm5EvqNBU67VY8SZYLU/RNfTfvD+cWJkg/4pza2EPrrYd7aV172Dxtwv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764627101; c=relaxed/simple;
	bh=zM5zL4ZH0X5e+aoYJf0BBh5p2kFeFcfgPBfnzps3Hwk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qXCAq+0HoFl+lcTEcvyAegAhM4K3uQz1OyTzSGy2oUgg5h/mXjrL7gJUcEUzznqBzMWpSM06NP9mqozS1DHMG7XEPzufnfaN64x85Hvi4KsZO2VFHLhEM3khVMozpshGknaXFTosbyhyZ2pHsJUYr2h7fJYsC73F+LhxnvTRvlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JAqL3g/q; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764627100; x=1796163100;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=zM5zL4ZH0X5e+aoYJf0BBh5p2kFeFcfgPBfnzps3Hwk=;
  b=JAqL3g/qSyOfr+xE+PDGcEDldB6v4RaLvMDeLmUneYM/pmbpaDLsGeZd
   Ts/V6P26jtk5RMSj1EaZ+7xfov1/vUxM1e+m1OI1HAc2ZNQvuCSeW/TiQ
   urkslGxTNOoIKzG7mXOznDMuQG4nQdHuQfvfyHf5+nKr3hwW+ACrMJC82
   PLBIy7XzEShsfikpmfwhza+Z/1aYyBVa2ShBnYZ0aTgW8qfKLnsJQj2j+
   imh9fUaOSSX0lCJeHMJcG346cq0Zx0KoUnzHvlamgFUswiDfErjhqMvl0
   vA2Tt113z+4sGVJquroIq0pqOFAXuyINw5DDY26VNanhPnveCeHsCAYOu
   Q==;
X-CSE-ConnectionGUID: w7sEcEXKSOuqOnqf4CeV0Q==
X-CSE-MsgGUID: MLXWqyEzSgWKnlPqlTNezA==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66529036"
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="66529036"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 14:11:39 -0800
X-CSE-ConnectionGUID: jyhZjJBnRPmfFIncZEMQgw==
X-CSE-MsgGUID: BaUbqutOThaaXxeW0aezbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="198568345"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 01 Dec 2025 14:11:38 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vQC7M-000000009BJ-0WGY;
	Mon, 01 Dec 2025 22:11:36 +0000
Date: Tue, 2 Dec 2025 06:11:24 +0800
From: kernel test robot <lkp@intel.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v6 2/9] s390/pci: Add architecture specific resource/bus
 address translation
Message-ID: <aS4SjMrgP4NugXOo@656a63d76ae5>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201220823.3350-3-alifm@linux.ibm.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v6 2/9] s390/pci: Add architecture specific resource/bus address translation
Link: https://lore.kernel.org/stable/20251201220823.3350-3-alifm%40linux.ibm.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




