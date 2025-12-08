Return-Path: <stable+bounces-200370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71039CAE0E5
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 20:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26B0B30A9119
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 19:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B5C2E92D6;
	Mon,  8 Dec 2025 19:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sopcv5NL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D819242D79;
	Mon,  8 Dec 2025 19:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765221123; cv=none; b=eBKD7B3XCJzxjBlbDswHOU9Z+c5yry92DI8P4FeBWL1V/4WFUQCMPTikYfVXcVMHLcSKSR/t9IculEZ1q4dM1Nbqb79TiI3zJYQAx6BR5XTlgnuJsiijFhKGBzQw2g+taADTci4KJ68ZhlACprXdLEoL7jU5IWQVTUvdSGD2AQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765221123; c=relaxed/simple;
	bh=4GJXL/LoLHx7N2a8v5VWshnzbRCiIknwAktZdBjLWzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrBBp6yquQN3jXfK8MF6aWZt8QkIWiKB71XBK1nDV+fTyOwkM4tTEett5DAYxU3NLwGzyy/apMI0ZdHyc5vIifmi3BAeQF5Mb29dXWdlpRu0uTE+2stdw4TWiwLFOPUG1fbifHBhLL3qycYBd5fBqlwHHBgxL+lqFwTSoGDKxfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sopcv5NL; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765221123; x=1796757123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4GJXL/LoLHx7N2a8v5VWshnzbRCiIknwAktZdBjLWzs=;
  b=Sopcv5NLGSAHPJNKJBXF3ygP9IXpr/r/OdnG9uqyHhCfkQGzbEDG4Bx6
   am4VG6TUw/3+36BjyWa05C1OojY9Rgow/ZXhKXo6iB0crN8jqE1EHcPz6
   1PTtt3ceo5sl31ElLzOzX3VwqSHarTfzFEJ/P3MzqGwMHxwIUMrbGpVRZ
   +b7IUpofFVZjQ3VN6k7aLt2LRPmCrR6jBfn/pcqnT7SSgbrUcTr7DPvgN
   iymPCKXwmf72Slj53deR9LoESf52Ra++I5u9dDB116sgzHPJA1rGjcQIM
   B8UTT2L82JtOZLh0TF+F00hGB3p/3SUYfwBeCWIJ+hS5peWzXMKE5X/l8
   A==;
X-CSE-ConnectionGUID: 8y1Zdu/iRWiekjjPwNfphg==
X-CSE-MsgGUID: 4YIA7WshRmCep0LF1DEaBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="54711470"
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="54711470"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 11:12:02 -0800
X-CSE-ConnectionGUID: dIpHVU1eQw2pTfwkXgE9tQ==
X-CSE-MsgGUID: K8sgQq9xRsiatQ/7I2vP3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="200177196"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 08 Dec 2025 11:11:58 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vSgeJ-000000000kR-0L12;
	Mon, 08 Dec 2025 19:11:55 +0000
Date: Tue, 9 Dec 2025 03:11:32 +0800
From: kernel test robot <lkp@intel.com>
To: Prithvi Tambewagh <activprithvi@gmail.com>, mark@fasheh.com,
	jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc: oe-kbuild-all@lists.linux.dev, ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	khalid@kernel.org, Prithvi Tambewagh <activprithvi@gmail.com>,
	syzbot+c818e5c4559444f88aa0@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ocfs2: Fix kernel BUG in ocfs2_write_block
Message-ID: <202512090210.evJEJv5b-lkp@intel.com>
References: <20251206154819.175479-1-activprithvi@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251206154819.175479-1-activprithvi@gmail.com>

Hi Prithvi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 24172e0d79900908cf5ebf366600616d29c9b417]

url:    https://github.com/intel-lab-lkp/linux/commits/Prithvi-Tambewagh/ocfs2-Fix-kernel-BUG-in-ocfs2_write_block/20251206-235042
base:   24172e0d79900908cf5ebf366600616d29c9b417
patch link:    https://lore.kernel.org/r/20251206154819.175479-1-activprithvi%40gmail.com
patch subject: [PATCH] ocfs2: Fix kernel BUG in ocfs2_write_block
config: loongarch-randconfig-r112-20251207 (https://download.01.org/0day-ci/archive/20251209/202512090210.evJEJv5b-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251209/202512090210.evJEJv5b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512090210.evJEJv5b-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/ocfs2/slot_map.c:197:26: sparse: sparse: cast to restricted __le16
>> fs/ocfs2/slot_map.c:197:26: sparse: sparse: cast to restricted __le16

vim +197 fs/ocfs2/slot_map.c

   182	
   183	static int ocfs2_update_disk_slot(struct ocfs2_super *osb,
   184					  struct ocfs2_slot_info *si,
   185					  int slot_num)
   186	{
   187		int status;
   188		struct buffer_head *bh;
   189	
   190		spin_lock(&osb->osb_lock);
   191		if (si->si_extended)
   192			ocfs2_update_disk_slot_extended(si, slot_num, &bh);
   193		else
   194			ocfs2_update_disk_slot_old(si, slot_num, &bh);
   195		spin_unlock(&osb->osb_lock);
   196		if (bh->b_blocknr < OCFS2_SUPER_BLOCK_BLKNO) {
 > 197			status = ocfs2_error(osb->sb,
   198					     "Invalid Slot Map Buffer Head "
   199					     "Block Number : %llu, Should be >= %d",
   200					     le16_to_cpu(bh->b_blocknr),
   201					     le16_to_cpu((int)OCFS2_SUPER_BLOCK_BLKNO));
   202			if (!status)
   203				return -EIO;
   204			return status;
   205		}
   206	
   207		status = ocfs2_write_block(osb, bh, INODE_CACHE(si->si_inode));
   208		if (status < 0)
   209			mlog_errno(status);
   210	
   211		return status;
   212	}
   213	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

