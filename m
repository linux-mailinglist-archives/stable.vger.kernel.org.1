Return-Path: <stable+bounces-191371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2156CC1278F
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 02:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6555E2C47
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 00:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F13258EDB;
	Tue, 28 Oct 2025 00:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hbfWnq0Q"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4593F1F4CB3;
	Tue, 28 Oct 2025 00:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761612747; cv=none; b=Ph9+yfXhVvsOxuhYCKvlv2gadKnhcyLP5LzknM6qJK7ixUwpzIaOSgiVfRcC//uV4MMTdnv+44J4DwpFrCDbPFq6YZTrWntZHlPAAjf/FudsU9qQ09fZSMZKk+QzKuWSV1RNpjydUXehX75VNmaj8JZNcSmDLcmpvGlFKtdGWGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761612747; c=relaxed/simple;
	bh=w7zS/Rxbd2Ot04z+qhtf2Kt5+S/gx85Bie+qXzvTKLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzpW0dzRc2MrgnzFMw75qYKdx/MOxzJDeFA9n1Mwey49UneSo/U/hV0reE+wULFrbtush/hipQunJTQi5dfVQO2EgTBdy6tb7OL5pRiRG068MYEc31vF7RDfRWVCJx/iNzR9Trb85F6E3h6spmnbibWtg81cQnIA9ZgO9sBR89w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hbfWnq0Q; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761612746; x=1793148746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w7zS/Rxbd2Ot04z+qhtf2Kt5+S/gx85Bie+qXzvTKLc=;
  b=hbfWnq0QKwFfshK115fYOwiH3llsu7zrHc7YoFZL7PXIBWeR7jkEPl+/
   OmOR46hFap+MWXE3WpfPo/MSiRSbSZ6JVwkLEKokjFnqRkvqo6IUHsAaq
   HDMMFatUTbkNJh+1qcT3Z09mIgt4GhyAi2F9cwKApXanijG4VdSasBRud
   M/IoZT+ilTlOeCmhXoq1hgNriAT6vMusgNt3fdCriekHVZDO2u6RRvKf9
   RCSDhDJILUg340LHe/T/M/DrTUeDwMCsmH0F05vfjOWDrF6DGJ9mdCkZF
   VItg4S6zMKgTYGRt9GU6zHXUk8tWgg72cHiQNmvKyIzc86WNqV7gm4XRV
   g==;
X-CSE-ConnectionGUID: UOQhubnpTrOl2axRxhDG0w==
X-CSE-MsgGUID: AWqbq4lyS2G4Ib08HB2ZvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="75049315"
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="75049315"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 17:52:25 -0700
X-CSE-ConnectionGUID: iliyoV3HSiWz4WHQBxJ1yQ==
X-CSE-MsgGUID: hTZAPswWTDKoA9uQQVALaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,260,1754982000"; 
   d="scan'208";a="185103061"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 27 Oct 2025 17:52:20 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vDXwb-000Ibx-1L;
	Tue, 28 Oct 2025 00:52:16 +0000
Date: Tue, 28 Oct 2025 08:51:48 +0800
From: kernel test robot <lkp@intel.com>
To: "Nysal Jan K.A." <nysal@linux.ibm.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Nysal Jan K.A." <nysal@linux.ibm.com>,
	Sachin P Bappalige <sachinpb@linux.ibm.com>, stable@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Laurent Dufour <ldufour@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/kexec: Enable SMT before waking offline CPUs
Message-ID: <202510280824.Fe2D1Sbw-lkp@intel.com>
References: <20251025080512.85690-1-nysal@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025080512.85690-1-nysal@linux.ibm.com>

Hi Nysal,

kernel test robot noticed the following build errors:

[auto build test ERROR on powerpc/next]
[also build test ERROR on powerpc/fixes linus/master v6.18-rc3 next-20251027]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nysal-Jan-K-A/powerpc-kexec-Enable-SMT-before-waking-offline-CPUs/20251025-160821
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/20251025080512.85690-1-nysal%40linux.ibm.com
patch subject: [PATCH] powerpc/kexec: Enable SMT before waking offline CPUs
config: powerpc64-randconfig-001-20251028 (https://download.01.org/0day-ci/archive/20251028/202510280824.Fe2D1Sbw-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project e1ae12640102fd2b05bc567243580f90acb1135f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251028/202510280824.Fe2D1Sbw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510280824.Fe2D1Sbw-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <built-in>:3:
   In file included from include/linux/compiler_types.h:171:
   include/linux/compiler-clang.h:37:9: warning: '__SANITIZE_THREAD__' macro redefined [-Wmacro-redefined]
      37 | #define __SANITIZE_THREAD__
         |         ^
   <built-in>:353:9: note: previous definition is here
     353 | #define __SANITIZE_THREAD__ 1
         |         ^
>> arch/powerpc/kexec/core_64.c:220:22: error: expression is not assignable
     220 |         cpu_smt_num_threads = threads_per_core;
         |         ~~~~~~~~~~~~~~~~~~~ ^
   arch/powerpc/kexec/core_64.c:221:18: error: expression is not assignable
     221 |         cpu_smt_control = CPU_SMT_ENABLED;
         |         ~~~~~~~~~~~~~~~ ^
   1 warning and 2 errors generated.


vim +220 arch/powerpc/kexec/core_64.c

   204	
   205	/*
   206	 * We need to make sure each present CPU is online.  The next kernel will scan
   207	 * the device tree and assume primary threads are online and query secondary
   208	 * threads via RTAS to online them if required.  If we don't online primary
   209	 * threads, they will be stuck.  However, we also online secondary threads as we
   210	 * may be using 'cede offline'.  In this case RTAS doesn't see the secondary
   211	 * threads as offline -- and again, these CPUs will be stuck.
   212	 *
   213	 * So, we online all CPUs that should be running, including secondary threads.
   214	 */
   215	static void wake_offline_cpus(void)
   216	{
   217		int cpu = 0;
   218	
   219		lock_device_hotplug();
 > 220		cpu_smt_num_threads = threads_per_core;
   221		cpu_smt_control = CPU_SMT_ENABLED;
   222		unlock_device_hotplug();
   223	
   224		for_each_present_cpu(cpu) {
   225			if (!cpu_online(cpu)) {
   226				printk(KERN_INFO "kexec: Waking offline cpu %d.\n",
   227				       cpu);
   228				WARN_ON(add_cpu(cpu));
   229			}
   230		}
   231	}
   232	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

