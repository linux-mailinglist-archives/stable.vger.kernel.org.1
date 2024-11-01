Return-Path: <stable+bounces-89499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DCE9B941F
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 16:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193D41F21B72
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 15:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A206F1B532F;
	Fri,  1 Nov 2024 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aDgksXqR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0E41ABEB5;
	Fri,  1 Nov 2024 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730474091; cv=none; b=ladSpMYX5uxcW8bubyyKrH+lkFrmaWIJaXiMGA/E8dafTZaSvMJS3dc/RJ2v1F2ot/oLKFCQz85jGbcS4tGnXrlKGzjFRnmGXLADcxw0fQoiGDyhnr5xN/oA1YLNp5UegTyOUf8INm5Edsi6tLFU9ZqFVaugwTa/TumMv48R1B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730474091; c=relaxed/simple;
	bh=3kwKaT3UasmcB/0WMGK9/KJzS+/Wl2q/KOjXAZBuqNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nm0JzUxcuErp1KQSL0Z4qHzOkZGF0KKYdlT5h3+59xPRvSSoHXt4Yo23KEFfRJ6WqTZXMaIZP+6M8KHU0gGmwFw9rBjC4aklcgjxQ6CKO+YG3lqPQuaKhrYS/iurqtSb+IPsCVniBnhxCVuvorJnCv/xw8pIL0ykidenRilVizA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aDgksXqR; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730474089; x=1762010089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3kwKaT3UasmcB/0WMGK9/KJzS+/Wl2q/KOjXAZBuqNw=;
  b=aDgksXqRUvkwisdgaDtRXctWHPuDCVixrH+CsO1qad5FsfAH/tCCNPVO
   vj0fRIDdIOFY/fFUF6Py6CCxhl43I0Yd02303HH+m9wbHsjlRpmGGpz6T
   8aKtycgA3tGffDX/Q3UkrA0nVrdN5Em6IUco9J+hBSS//KIpQTNUWSz18
   Ofot/V/Wa0xXuOdKtOvOCsJ0Q/JOxZkRXAw6rjCDY5CihneGypIHMouQv
   0FI1AAfCw1zH0w9+8BnyH4z4pgW43e76VWDNaqwQyQZERZkHV5grqHG6z
   7lp+inuze0ZUYu1cV1FWurTiwisutO38/0pYUMgqpYkkp/nZ4/W2zWxNI
   A==;
X-CSE-ConnectionGUID: es6ezWvWSQ6yCTU7qm/fOw==
X-CSE-MsgGUID: qp7CmeC4RCODFShs3Vayrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="30454112"
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="30454112"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 08:14:48 -0700
X-CSE-ConnectionGUID: Xy9InalVTQCrt2N2k8lTrw==
X-CSE-MsgGUID: bqQv/g45TD+MyJ4TNLP+8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="82914855"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 01 Nov 2024 08:14:44 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6tMH-000hgl-2Z;
	Fri, 01 Nov 2024 15:14:41 +0000
Date: Fri, 1 Nov 2024 23:14:18 +0800
From: kernel test robot <lkp@intel.com>
To: George Rurikov <grurikov@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	MrRurikov <grurikov@gmal.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Israel Rukshin <israelr@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, George Rurikov <g.ryurikov@securitycode.ru>
Subject: Re: [PATCH] nvme: rdma: Add check for queue in
 nvmet_rdma_cm_handler()
Message-ID: <202411012252.e1ChG1dy-lkp@intel.com>
References: <20241031173327.663-1-grurikov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031173327.663-1-grurikov@gmail.com>

Hi George,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.12-rc5 next-20241101]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/George-Rurikov/nvme-rdma-Add-check-for-queue-in-nvmet_rdma_cm_handler/20241101-013611
base:   linus/master
patch link:    https://lore.kernel.org/r/20241031173327.663-1-grurikov%40gmail.com
patch subject: [PATCH] nvme: rdma: Add check for queue in nvmet_rdma_cm_handler()
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20241101/202411012252.e1ChG1dy-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 639a7ac648f1e50ccd2556e17d401c04f9cce625)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241101/202411012252.e1ChG1dy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411012252.e1ChG1dy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/nvme/target/rdma.c:8:
   In file included from include/linux/blk-integrity.h:5:
   In file included from include/linux/blk-mq.h:5:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/nvme/target/rdma.c:8:
   In file included from include/linux/blk-integrity.h:5:
   In file included from include/linux/blk-mq.h:8:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:95:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/nvme/target/rdma.c:8:
   In file included from include/linux/blk-integrity.h:5:
   In file included from include/linux/blk-mq.h:8:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:95:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/nvme/target/rdma.c:8:
   In file included from include/linux/blk-integrity.h:5:
   In file included from include/linux/blk-mq.h:8:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:95:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/nvme/target/rdma.c:1775:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
    1775 |         case RDMA_CM_EVENT_ADDR_CHANGE:
         |         ^
   drivers/nvme/target/rdma.c:1775:2: note: insert '__attribute__((fallthrough));' to silence this warning
    1775 |         case RDMA_CM_EVENT_ADDR_CHANGE:
         |         ^
         |         __attribute__((fallthrough)); 
   drivers/nvme/target/rdma.c:1775:2: note: insert 'break;' to avoid fall-through
    1775 |         case RDMA_CM_EVENT_ADDR_CHANGE:
         |         ^
         |         break; 
   drivers/nvme/target/rdma.c:1789:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
    1789 |         case RDMA_CM_EVENT_DEVICE_REMOVAL:
         |         ^
   drivers/nvme/target/rdma.c:1789:2: note: insert '__attribute__((fallthrough));' to silence this warning
    1789 |         case RDMA_CM_EVENT_DEVICE_REMOVAL:
         |         ^
         |         __attribute__((fallthrough)); 
   drivers/nvme/target/rdma.c:1789:2: note: insert 'break;' to avoid fall-through
    1789 |         case RDMA_CM_EVENT_DEVICE_REMOVAL:
         |         ^
         |         break; 
   drivers/nvme/target/rdma.c:1802:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
    1802 |         default:
         |         ^
   drivers/nvme/target/rdma.c:1802:2: note: insert '__attribute__((fallthrough));' to silence this warning
    1802 |         default:
         |         ^
         |         __attribute__((fallthrough)); 
   drivers/nvme/target/rdma.c:1802:2: note: insert 'break;' to avoid fall-through
    1802 |         default:
         |         ^
         |         break; 
   19 warnings generated.


vim +1775 drivers/nvme/target/rdma.c

d8f7750a08968b Sagi Grimberg       2016-05-19  1752  
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1753  static int nvmet_rdma_cm_handler(struct rdma_cm_id *cm_id,
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1754  		struct rdma_cm_event *event)
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1755  {
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1756  	struct nvmet_rdma_queue *queue = NULL;
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1757  	int ret = 0;
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1758  
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1759  	if (cm_id->qp)
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1760  		queue = cm_id->qp->qp_context;
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1761  
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1762  	pr_debug("%s (%d): status %d id %p\n",
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1763  		rdma_event_msg(event->event), event->event,
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1764  		event->status, cm_id);
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1765  
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1766  	switch (event->event) {
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1767  	case RDMA_CM_EVENT_CONNECT_REQUEST:
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1768  		ret = nvmet_rdma_queue_connect(cm_id, event);
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1769  		break;
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1770  	case RDMA_CM_EVENT_ESTABLISHED:
554d31ea0a6334 MrRurikov           2024-10-31  1771  		if (!queue) {
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1772  			nvmet_rdma_queue_established(queue);
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1773  			break;
554d31ea0a6334 MrRurikov           2024-10-31  1774  		}
8f000cac6e7a6e Christoph Hellwig   2016-07-06 @1775  	case RDMA_CM_EVENT_ADDR_CHANGE:
a032e4f6d60d0a Sagi Grimberg       2020-04-02  1776  		if (!queue) {
a032e4f6d60d0a Sagi Grimberg       2020-04-02  1777  			struct nvmet_rdma_port *port = cm_id->context;
a032e4f6d60d0a Sagi Grimberg       2020-04-02  1778  
8832cf922151e9 Sagi Grimberg       2022-03-21  1779  			queue_delayed_work(nvmet_wq, &port->repair_work, 0);
a032e4f6d60d0a Sagi Grimberg       2020-04-02  1780  			break;
a032e4f6d60d0a Sagi Grimberg       2020-04-02  1781  		}
df561f6688fef7 Gustavo A. R. Silva 2020-08-23  1782  		fallthrough;
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1783  	case RDMA_CM_EVENT_DISCONNECTED:
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1784  	case RDMA_CM_EVENT_TIMEWAIT_EXIT:
554d31ea0a6334 MrRurikov           2024-10-31  1785  		if (!queue) {
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1786  			nvmet_rdma_queue_disconnect(queue);
d8f7750a08968b Sagi Grimberg       2016-05-19  1787  			break;
554d31ea0a6334 MrRurikov           2024-10-31  1788  		}
d8f7750a08968b Sagi Grimberg       2016-05-19  1789  	case RDMA_CM_EVENT_DEVICE_REMOVAL:
d8f7750a08968b Sagi Grimberg       2016-05-19  1790  		ret = nvmet_rdma_device_removal(cm_id, queue);
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1791  		break;
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1792  	case RDMA_CM_EVENT_REJECTED:
512fb1b32bac02 Steve Wise          2016-10-26  1793  		pr_debug("Connection rejected: %s\n",
512fb1b32bac02 Steve Wise          2016-10-26  1794  			 rdma_reject_msg(cm_id, event->status));
df561f6688fef7 Gustavo A. R. Silva 2020-08-23  1795  		fallthrough;
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1796  	case RDMA_CM_EVENT_UNREACHABLE:
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1797  	case RDMA_CM_EVENT_CONNECT_ERROR:
554d31ea0a6334 MrRurikov           2024-10-31  1798  		if (!queue) {
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1799  			nvmet_rdma_queue_connect_fail(cm_id, queue);
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1800  			break;
554d31ea0a6334 MrRurikov           2024-10-31  1801  		}
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1802  	default:
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1803  		pr_err("received unrecognized RDMA CM event %d\n",
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1804  			event->event);
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1805  		break;
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1806  	}
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1807  
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1808  	return ret;
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1809  }
8f000cac6e7a6e Christoph Hellwig   2016-07-06  1810  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

