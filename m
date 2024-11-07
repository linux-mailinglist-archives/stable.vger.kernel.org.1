Return-Path: <stable+bounces-91842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1749C0916
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 15:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80911282E07
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 14:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A75F212D0B;
	Thu,  7 Nov 2024 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DBwmKfWY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C537E20CCD1
	for <stable@vger.kernel.org>; Thu,  7 Nov 2024 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730990359; cv=none; b=blwG1xyAOmg05k2rox5/A/h49hQLcb7/tQPcuwP/n6ZJPL0AZSvQiqi8AG/tPg3Nqk2+tWv+HKcieHjieachlC5nKPQI7dDfg6n/HqxDSjDIsubd4tpWpYMtxRa5aHuURK9iOn6jT3Hjk6qhbGajKdOlStESCiXZ6OoRtvBuWvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730990359; c=relaxed/simple;
	bh=8NMMvEO8fhMlRoGClmBk+gr70ISSSyGxfjVPmVpK8CE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kQn3tOfoIOrkr4lV/EuHF+qF5J/Hb8KzwTOtGrupw3/L6EOugB15LCVkU32tiD9ZZyhcPpRajoPDOqoZvhxaS98v8YKs0BTYvwV/7ArZ9tytOIw3S4yANPENfmXxoo9WOW6gXBNbPn5vxudN0nUgAUugHS4dOAq00jgaW0CDMXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DBwmKfWY; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730990358; x=1762526358;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=8NMMvEO8fhMlRoGClmBk+gr70ISSSyGxfjVPmVpK8CE=;
  b=DBwmKfWYNNLlmhE8R4XiSVrTVUcRu7iiE8BFupp4rGfJhwSmgZ79Yxq6
   xv31r4bQqgEU0mruHh1qbBK3LYj73x+Xb7sGDazws9QYVxyiclSSgWe1P
   GZTT9ALkPR+6y63U30mViudY8Wd/8yZH9ETMxQsXChZcJ6IrJuBPy6NXC
   vEbQljY8ZPUgezrjlwZ/nwopF43B1GmjCCprA2K0lpLLNEDhBE/TT0Qi6
   jXBP4bmfklH7NgmbqQuCYPwRhD6mjpQYGc2g+98Yvi1tQNCyiJNWRqfay
   Fl3g6iB2LQkFpkP7DHJi/Z1tyAcBNIMcYyQOvLLZ9htQPVOhtx++e1xvB
   Q==;
X-CSE-ConnectionGUID: NUoThDfxStq1bPqcr0sN/w==
X-CSE-MsgGUID: G5J8eN4WSgihk1CKyaUq2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="30939297"
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="30939297"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 06:39:17 -0800
X-CSE-ConnectionGUID: 2ZoDf7LoTM29TrhTNf0IVg==
X-CSE-MsgGUID: aThFD8mbRTCMAjG0Bxug4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="85440702"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 07 Nov 2024 06:39:16 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t93fG-000qMU-0n;
	Thu, 07 Nov 2024 14:39:14 +0000
Date: Thu, 7 Nov 2024 22:38:45 +0800
From: kernel test robot <lkp@intel.com>
To: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [RFC] PCI: Fix the issue of link speed downgrade after link
 retraining
Message-ID: <ZyzQ9eCmWhYxnNVq@1f03459cf6fb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107143758.12643-1-guojinhui.liam@bytedance.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [RFC] PCI: Fix the issue of link speed downgrade after link retraining
Link: https://lore.kernel.org/stable/20241107143758.12643-1-guojinhui.liam%40bytedance.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




