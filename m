Return-Path: <stable+bounces-179226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A882B5253E
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 03:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A76B83B3E04
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 01:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8AF134AC;
	Thu, 11 Sep 2025 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CCaRkaHT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AA31B808;
	Thu, 11 Sep 2025 01:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757552428; cv=none; b=aYXkhciO9H2LtqvuIjPxjoNvjkGjT0CNNWX2RE47HTw+0lWVi4tF7GJP/8zVHGvtZuOlIdwL1H8goa9WCcihDWeACPvNup4RUvREPEdj0/8qJewnp56RzlGlg1WL170LxHMthGcBWUw1BKfIzJh1UDWvNYIje+ylvfZ6BoRSR8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757552428; c=relaxed/simple;
	bh=+bhHql823hbcrhTOWrfcISWPZx1qkjDnhhO46bZSMb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGV4r0cp66hqtO43E3y5OJ+7kyLQcD7jG4C+CbRmSkNH/1mOeeQG7TE0DRISwNmifQER5DcL1WjF0MD53yQYTEPV/16hgB9XXuD6ptfkLT+7URz3FgKK90lA2bAmerGdlL/gcdPxqSaIm1GQaBDMKfXaYw9mC8Jb684igUKZHVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CCaRkaHT; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757552426; x=1789088426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+bhHql823hbcrhTOWrfcISWPZx1qkjDnhhO46bZSMb0=;
  b=CCaRkaHTN++dxJLGwahtgED0Hg/eVWsm4Qq/1ol0WSffU/4DTDSQkwz9
   oCc/DE/2+MSDgAiSGI/Rqufxv0Z1xs5tLAxbWE/xzya4kGFW1oNWYiceu
   LMqtwiWcU9svnAB7gKyoar1l7C3oHmHf26huPv5817MAAwdPYOHjKLAA0
   mojb6efmtTy8MZzjOcsm0UrTuELqjyu+FaCRBvow3ZUWVQZZpIFUNT3+O
   UhwYNk+zQpTdMGBPpFCWBO7+IPF65koxhSlxGuwlB/Rw2DcPPLqiCCmLQ
   efPevnd/JcFmzQ8S7XpjAjmVIttVdQyqjaXmKyoCENLldwZC1XXS5s7iN
   w==;
X-CSE-ConnectionGUID: HG9fCU1iT7iw9cUbMYl4WQ==
X-CSE-MsgGUID: OSYsxB9aRJSdVUKLZAuvLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="59731930"
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="59731930"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 18:00:25 -0700
X-CSE-ConnectionGUID: DGor5ZY9QKqD6kZ6mbjwew==
X-CSE-MsgGUID: 6YPltiFsTZaSpBM7B1hb9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="178758040"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 10 Sep 2025 18:00:23 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwVfg-0006OR-11;
	Thu, 11 Sep 2025 01:00:20 +0000
Date: Thu, 11 Sep 2025 08:59:54 +0800
From: kernel test robot <lkp@intel.com>
To: Huacai Chen <chenhuacai@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>, Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>,
	Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH V2] LoongArch: Align ACPI structures if ARCH_STRICT_ALIGN
 enabled
Message-ID: <202509110853.ASZKE1gv-lkp@intel.com>
References: <20250910091033.725716-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910091033.725716-1-chenhuacai@loongson.cn>

Hi Huacai,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.17-rc5 next-20250910]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huacai-Chen/LoongArch-Align-ACPI-structures-if-ARCH_STRICT_ALIGN-enabled/20250910-171140
base:   linus/master
patch link:    https://lore.kernel.org/r/20250910091033.725716-1-chenhuacai%40loongson.cn
patch subject: [PATCH V2] LoongArch: Align ACPI structures if ARCH_STRICT_ALIGN enabled
config: loongarch-randconfig-001-20250911 (https://download.01.org/0day-ci/archive/20250911/202509110853.ASZKE1gv-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250911/202509110853.ASZKE1gv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509110853.ASZKE1gv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/acpi/acpi.h:24,
                    from drivers/acpi/acpica/tbprint.c:10:
   drivers/acpi/acpica/tbprint.c: In function 'acpi_tb_print_table_header':
>> include/acpi/actypes.h:530:43: warning: 'strncmp' argument 1 declared attribute 'nonstring' is smaller than the specified bound 8 [-Wstringop-overread]
     530 | #define ACPI_VALIDATE_RSDP_SIG(a)       (!strncmp (ACPI_CAST_PTR (char, (a)), ACPI_SIG_RSDP, (sizeof(a) < 8) ? ACPI_NAMESEG_SIZE : 8))
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/acpica/tbprint.c:105:20: note: in expansion of macro 'ACPI_VALIDATE_RSDP_SIG'
     105 |         } else if (ACPI_VALIDATE_RSDP_SIG(ACPI_CAST_PTR(struct acpi_table_rsdp,
         |                    ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/acpi/acpi.h:26:
   include/acpi/actbl.h:69:14: note: argument 'signature' declared here
      69 |         char signature[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;       /* ASCII table signature */
         |              ^~~~~~~~~


vim +530 include/acpi/actypes.h

cacba8657351f7 Lv Zheng    2013-09-23  529  
64b9dfd0776e9c Ahmed Salem 2025-04-25 @530  #define ACPI_VALIDATE_RSDP_SIG(a)       (!strncmp (ACPI_CAST_PTR (char, (a)), ACPI_SIG_RSDP, (sizeof(a) < 8) ? ACPI_NAMESEG_SIZE : 8))
4fa4616e279df8 Bob Moore   2015-07-01  531  #define ACPI_MAKE_RSDP_SIG(dest)        (memcpy (ACPI_CAST_PTR (char, (dest)), ACPI_SIG_RSDP, 8))
cacba8657351f7 Lv Zheng    2013-09-23  532  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

