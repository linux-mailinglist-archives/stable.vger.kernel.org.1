Return-Path: <stable+bounces-83110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96391995B0D
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 00:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD0B0B22A1A
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 22:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A12621644A;
	Tue,  8 Oct 2024 22:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cL20ExjE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E8A21503B;
	Tue,  8 Oct 2024 22:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728427518; cv=none; b=XOZal/GeHrzTeVdRxZ5RawwSseSw/PcDI1jW3jWMETe7O+hoKnHepB3rII5xkGRA0UWiNCIVw7wMELFmCKHrqIjb9nzgfPkpkRXiKEQjL3MXiEUdfsptrwb/XQCCGiK7d15r1YrZhjn65cBeVuLTIqtqJu7RJ+ENHKxHCnxFuyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728427518; c=relaxed/simple;
	bh=Gk580rjiDxgF7YwO5s3wxuTmM7IrxPdN+2ai82g118U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSFvG4a+WKcrmmCiCvUdwSwlOqkXyiXLkptpXI2QFcCrh0SmBc2Wxl+nVZA1LAHti4enKrv2tLU9fGj6Auxv8Q3GyFm/CnjonOH3GPGWdKlpwhBnUDcwfa6rf3qBhEX0++5sIqSg8oETXZaZcA1nxxR6hwIIfNk9jVvx9rHTlaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cL20ExjE; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728427517; x=1759963517;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gk580rjiDxgF7YwO5s3wxuTmM7IrxPdN+2ai82g118U=;
  b=cL20ExjE8m/hxlNSNsdCT5L35kcmgGfQ7HDj3frsosHdqfeR7QhvGFUN
   +8ycFziWvSN9pCQdqbNVq/ek/dl7tREDUNZnMSNCpc04hE7TWJjatUp/t
   seC+WfI9jG8gLwTicuByG/XfK1WKVMls5YUrIaNvLc0chv1QydsOGaZVu
   WjO0nSBtJXFRSW8BCRYUheaUQ5KBlNpT70fo/ddOCd2XkQ3BhJZxLpoTQ
   7OfHmshCNo8vkUtPzL+zpT9jwU118YNZ2i4K1TOAXokWRz2nEAdBaT0w6
   3R7ZlVqUVWRxl2WwmogMa9opiab5PM+7cvXxDwjSDg5MovLgk+SU2pfSj
   A==;
X-CSE-ConnectionGUID: zeQ+MD4KRwemeZTfjefxPQ==
X-CSE-MsgGUID: ATPG0/bPR/2FfmgFTjw1qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27810501"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="27810501"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 15:45:16 -0700
X-CSE-ConnectionGUID: xhvqv0qXQxOYbkci+1Si9w==
X-CSE-MsgGUID: taWMAtFRRgiW0/f99iXx3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="99368575"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 08 Oct 2024 15:45:12 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syIx4-0008Rq-19;
	Tue, 08 Oct 2024 22:45:10 +0000
Date: Wed, 9 Oct 2024 06:45:08 +0800
From: kernel test robot <lkp@intel.com>
To: Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Hugh Dickins <hughd@google.com>, Oleg Nesterov <oleg@redhat.com>,
	Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
	Vlastimil Babka <vbabka@suse.cz>, Ben Hutchings <bwh@kernel.org>,
	Willy Tarreau <w@1wt.eu>, Rik van Riel <riel@redhat.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH] mm: Enforce a minimal stack gap even against
 inaccessible VMAs
Message-ID: <202410090632.brLG8w0b-lkp@intel.com>
References: <20241008-stack-gap-inaccessible-v1-1-848d4d891f21@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008-stack-gap-inaccessible-v1-1-848d4d891f21@google.com>

Hi Jann,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b]

url:    https://github.com/intel-lab-lkp/linux/commits/Jann-Horn/mm-Enforce-a-minimal-stack-gap-even-against-inaccessible-VMAs/20241008-065733
base:   8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
patch link:    https://lore.kernel.org/r/20241008-stack-gap-inaccessible-v1-1-848d4d891f21%40google.com
patch subject: [PATCH] mm: Enforce a minimal stack gap even against inaccessible VMAs
config: parisc-randconfig-r072-20241009 (https://download.01.org/0day-ci/archive/20241009/202410090632.brLG8w0b-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241009/202410090632.brLG8w0b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410090632.brLG8w0b-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/mmap.c: In function 'expand_upwards':
>> mm/mmap.c:1069:39: error: 'prev' undeclared (first use in this function)
    1069 |                 if (vma_is_accessible(prev))
         |                                       ^~~~
   mm/mmap.c:1069:39: note: each undeclared identifier is reported only once for each function it appears in


vim +/prev +1069 mm/mmap.c

  1036	
  1037	#if defined(CONFIG_STACK_GROWSUP)
  1038	/*
  1039	 * PA-RISC uses this for its stack.
  1040	 * vma is the last one with address > vma->vm_end.  Have to extend vma.
  1041	 */
  1042	static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
  1043	{
  1044		struct mm_struct *mm = vma->vm_mm;
  1045		struct vm_area_struct *next;
  1046		unsigned long gap_addr;
  1047		int error = 0;
  1048		VMA_ITERATOR(vmi, mm, vma->vm_start);
  1049	
  1050		if (!(vma->vm_flags & VM_GROWSUP))
  1051			return -EFAULT;
  1052	
  1053		/* Guard against exceeding limits of the address space. */
  1054		address &= PAGE_MASK;
  1055		if (address >= (TASK_SIZE & PAGE_MASK))
  1056			return -ENOMEM;
  1057		address += PAGE_SIZE;
  1058	
  1059		/* Enforce stack_guard_gap */
  1060		gap_addr = address + stack_guard_gap;
  1061	
  1062		/* Guard against overflow */
  1063		if (gap_addr < address || gap_addr > TASK_SIZE)
  1064			gap_addr = TASK_SIZE;
  1065	
  1066		next = find_vma_intersection(mm, vma->vm_end, gap_addr);
  1067		if (next && !(next->vm_flags & VM_GROWSUP)) {
  1068			/* see comments in expand_downwards() */
> 1069			if (vma_is_accessible(prev))
  1070				return -ENOMEM;
  1071			if (address == next->vm_start)
  1072				return -ENOMEM;
  1073		}
  1074	
  1075		if (next)
  1076			vma_iter_prev_range_limit(&vmi, address);
  1077	
  1078		vma_iter_config(&vmi, vma->vm_start, address);
  1079		if (vma_iter_prealloc(&vmi, vma))
  1080			return -ENOMEM;
  1081	
  1082		/* We must make sure the anon_vma is allocated. */
  1083		if (unlikely(anon_vma_prepare(vma))) {
  1084			vma_iter_free(&vmi);
  1085			return -ENOMEM;
  1086		}
  1087	
  1088		/* Lock the VMA before expanding to prevent concurrent page faults */
  1089		vma_start_write(vma);
  1090		/*
  1091		 * vma->vm_start/vm_end cannot change under us because the caller
  1092		 * is required to hold the mmap_lock in read mode.  We need the
  1093		 * anon_vma lock to serialize against concurrent expand_stacks.
  1094		 */
  1095		anon_vma_lock_write(vma->anon_vma);
  1096	
  1097		/* Somebody else might have raced and expanded it already */
  1098		if (address > vma->vm_end) {
  1099			unsigned long size, grow;
  1100	
  1101			size = address - vma->vm_start;
  1102			grow = (address - vma->vm_end) >> PAGE_SHIFT;
  1103	
  1104			error = -ENOMEM;
  1105			if (vma->vm_pgoff + (size >> PAGE_SHIFT) >= vma->vm_pgoff) {
  1106				error = acct_stack_growth(vma, size, grow);
  1107				if (!error) {
  1108					/*
  1109					 * We only hold a shared mmap_lock lock here, so
  1110					 * we need to protect against concurrent vma
  1111					 * expansions.  anon_vma_lock_write() doesn't
  1112					 * help here, as we don't guarantee that all
  1113					 * growable vmas in a mm share the same root
  1114					 * anon vma.  So, we reuse mm->page_table_lock
  1115					 * to guard against concurrent vma expansions.
  1116					 */
  1117					spin_lock(&mm->page_table_lock);
  1118					if (vma->vm_flags & VM_LOCKED)
  1119						mm->locked_vm += grow;
  1120					vm_stat_account(mm, vma->vm_flags, grow);
  1121					anon_vma_interval_tree_pre_update_vma(vma);
  1122					vma->vm_end = address;
  1123					/* Overwrite old entry in mtree. */
  1124					vma_iter_store(&vmi, vma);
  1125					anon_vma_interval_tree_post_update_vma(vma);
  1126					spin_unlock(&mm->page_table_lock);
  1127	
  1128					perf_event_mmap(vma);
  1129				}
  1130			}
  1131		}
  1132		anon_vma_unlock_write(vma->anon_vma);
  1133		vma_iter_free(&vmi);
  1134		validate_mm(mm);
  1135		return error;
  1136	}
  1137	#endif /* CONFIG_STACK_GROWSUP */
  1138	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

