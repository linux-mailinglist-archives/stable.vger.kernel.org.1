Return-Path: <stable+bounces-146109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7B0AC1203
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 19:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 701503ADA2A
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 17:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B351D19D8AC;
	Thu, 22 May 2025 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DwlKrwD1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D724C19ADA2;
	Thu, 22 May 2025 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747934474; cv=none; b=OkaMvqE1fpvmAGk19WqaEAsmHFkGdKZMkSny9ykAq64zDBcmeWRQmhF5YyjLDZYa03Z6VORAKSW8pwHM2UId0I3r1o03uefZQwImQaa3Fm96PDT+jKXL4YwahgbfLpaUGsMVlZ2ZGev25ARQYF6l1Pd0XhuipYUhEUouJhgArQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747934474; c=relaxed/simple;
	bh=jRhI6mNMqW4aCK+zaS2xWMJWg0sThwYybWKRyZTWHd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3Gn72i5LR2Z4zX9RvgSO1Iffymco06fo/envRkYIT4u14vuVC42PdKGaMID3s0IDfGwi9+eZL0RXzlLZvfpFuXEtLhZomHPeY/vmVTKVpLeb56i3dOQ593YrIahdFvycv5pT3XT2ihFI6FoBqPMCjNqsHmRFbMDoAoR14LrvU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DwlKrwD1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747934473; x=1779470473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jRhI6mNMqW4aCK+zaS2xWMJWg0sThwYybWKRyZTWHd4=;
  b=DwlKrwD1ikVPkbkPeIPpqeIdi2VosC8RVNACgZAmzQp1cZ727USyWfAI
   QsLqH/nGeYnbbLzY2bh7TGMfj7La/D2fYWvWChEkTbIlvSG7umEjxgSCr
   8PyD5uP3ZzrH+SzaxruraAUApXfiVlmw55Yd/92QqZN+plrmeQ209JfuR
   0FKmq1GUW0X3fFwrlwchkzr//LhdaQMh1gzaTery+UF5sp+AGplfplm2t
   UWCmwkXsZsV6aCixt9S8BEbR9I8yuLSKvi6rTC9EBOM3Aqg/DC86lWSZF
   KdYYgOuD6tIBmU99ffBHAjDrI7kmzqu3LaMZJd6oLmIRZmhjVbnHNR0h8
   Q==;
X-CSE-ConnectionGUID: j3KkLsFUSgK2rTOYLrzNAg==
X-CSE-MsgGUID: HHwQHdVIQEeSe24A5KAQjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="53639000"
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="53639000"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 10:21:13 -0700
X-CSE-ConnectionGUID: KM+Gcn/3Truqm25Vc/G7Bw==
X-CSE-MsgGUID: vtqoCIuuQu62amGJbMlDaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="140560505"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 22 May 2025 10:21:09 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uI9bP-000PYO-0m;
	Thu, 22 May 2025 17:21:07 +0000
Date: Fri, 23 May 2025 01:20:32 +0800
From: kernel test robot <lkp@intel.com>
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, peterz@infradead.org, andrew.cooper3@citrix.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 1/1] x86/fred/signal: Prevent single-step upon ERETU
 completion
Message-ID: <202505230141.4YBHhrPI-lkp@intel.com>
References: <20250522060549.2882444-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522060549.2882444-1-xin@zytor.com>

Hi Xin,

kernel test robot noticed the following build errors:

[auto build test ERROR on 6a7c3c2606105a41dde81002c0037420bc1ddf00]

url:    https://github.com/intel-lab-lkp/linux/commits/Xin-Li-Intel/x86-fred-signal-Prevent-single-step-upon-ERETU-completion/20250522-140954
base:   6a7c3c2606105a41dde81002c0037420bc1ddf00
patch link:    https://lore.kernel.org/r/20250522060549.2882444-1-xin%40zytor.com
patch subject: [PATCH v1 1/1] x86/fred/signal: Prevent single-step upon ERETU completion
config: i386-buildonly-randconfig-003-20250522 (https://download.01.org/0day-ci/archive/20250523/202505230141.4YBHhrPI-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250523/202505230141.4YBHhrPI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505230141.4YBHhrPI-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/signal_32.c:32:
   arch/x86/include/asm/sighandling.h: In function 'prevent_single_step_upon_eretu':
>> arch/x86/include/asm/sighandling.h:44:21: error: 'struct pt_regs' has no member named 'fred_ss'
      44 |                 regs->fred_ss.swevent = 0;
         |                     ^~


vim +44 arch/x86/include/asm/sighandling.h

    26	
    27	/*
    28	 * To prevent infinite SIGTRAP handler loop if TF is used without an external
    29	 * debugger, clear the software event flag in the augmented SS, ensuring no
    30	 * single-step trap is pending upon ERETU completion.
    31	 *
    32	 * Note, this function should be called in sigreturn() before the original state
    33	 * is restored to make sure the TF is read from the entry frame.
    34	 */
    35	static __always_inline void prevent_single_step_upon_eretu(struct pt_regs *regs)
    36	{
    37		/*
    38		 * If the trap flag (TF) is set, i.e., the sigreturn() SYSCALL instruction
    39		 * is being single-stepped, do not clear the software event flag in the
    40		 * augmented SS, thus a debugger won't skip over the following instruction.
    41		 */
    42		if (IS_ENABLED(CONFIG_X86_FRED) && cpu_feature_enabled(X86_FEATURE_FRED) &&
    43		    !(regs->flags & X86_EFLAGS_TF))
  > 44			regs->fred_ss.swevent = 0;
    45	}
    46	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

