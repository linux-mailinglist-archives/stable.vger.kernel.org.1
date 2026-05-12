Return-Path: <stable+bounces-246649-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMjAMt12A2pY6AEAu9opvQ
	(envelope-from <stable+bounces-246649-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:52:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AF3528320
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A65E3105E37
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A772939A06B;
	Tue, 12 May 2026 18:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NYusQ9Y5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCE438239C;
	Tue, 12 May 2026 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778611744; cv=none; b=erUnu8AK5dmHd5XFiOhAO2iCf4aeoie/+hLY/5+KgqQNCtKWN9YUznEEVSQnlJ4fgBM3ap7mSoqILipkSOm51ftgDXEor+T1W0QEdvHQnNDX8CaGdl8e0G3LWAEaNPuBXJ8IcU0KoUYFp6++OwQ6V6JpoEZULGa22gyOQJXTmns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778611744; c=relaxed/simple;
	bh=JDJIg36vmlzCtIsCMqupMO+AdKnTE+IOuPLQpd343tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqBgXL1uvJo+c/hePq9/eUzBwIjBPFekNJmqgtkh6C+ySdVSdi4L26GwSAOyJ0l2mflhfkFRpGGC6SGdIq7Dl3kTlfpxgQ2p66y6iNDruhzX5NMpkcQqGr6VgtfQZFBCkmRGVrHB9v6t2EhwMhEj0dEmMm+Vh6Vlx8TsUcB0pRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NYusQ9Y5; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778611740; x=1810147740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JDJIg36vmlzCtIsCMqupMO+AdKnTE+IOuPLQpd343tU=;
  b=NYusQ9Y5fzi79hHSJ+weD4z4UYGBPWYaQF9YWXWNjPj/2rCcR+rDU/Dy
   dFWtP/DiTneUSbJR91ZQiXd/5IrKxq5pcwtVC03nCKALbrU0dPfd3hCV3
   ukE0RIIDFXZP4gr9eubpHHeTotIckftNGyN8MDKBGTLxQYIyxVy/SLWDI
   fLtq+Y0htma9ytjsyurvt6HnBQQkfFOapqJOy/146ZUFYKAV6n60zRgBy
   DZUAYqaQgKd2rFWIOIJ3HMTziInFVI5EnkpYsw2MNgDld9qljndl/nQhU
   7k/E47lkJ+7eF/l41sFX09g6x+ou16hoUIn72m4qH/3l74pYmJOI2RLrt
   g==;
X-CSE-ConnectionGUID: 6ryW751LQnSBOvVXW5i5wA==
X-CSE-MsgGUID: 9z31ZD4ISl6XsX94a03cGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="78674341"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="78674341"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 11:48:59 -0700
X-CSE-ConnectionGUID: OXmhdwYAQZGxma+o8FT6dA==
X-CSE-MsgGUID: gIXF5nN8RwGeZRBldCDQ5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="268190666"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 12 May 2026 11:48:57 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMsA2-000000002dZ-3vFc;
	Tue, 12 May 2026 18:48:54 +0000
Date: Wed, 13 May 2026 02:48:40 +0800
From: kernel test robot <lkp@intel.com>
To: chalianis1@gmail.com, miquel.raynal@bootlin.com, srini@kernel.org,
	gregkh@linuxfoundation.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Chali Anis <chalianis1@gmail.com>
Subject: Re: [PATCH] nvmem: layouts: onie-tlv: fix read_post_process
 assignment
Message-ID: <202605130223.sNRxfA5D-lkp@intel.com>
References: <20260512025715.50645-1-chalianis1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512025715.50645-1-chalianis1@gmail.com>
X-Rspamd-Queue-Id: 42AF3528320
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-246649-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,bootlin.com,kernel.org,linuxfoundation.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,git-scm.com:url,cell.name:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim,cell.np:url]
X-Rspamd-Action: no action

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus linus/master v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/chalianis1-gmail-com/nvmem-layouts-onie-tlv-fix-read_post_process-assignment/20260512-213659
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20260512025715.50645-1-chalianis1%40gmail.com
patch subject: [PATCH] nvmem: layouts: onie-tlv: fix read_post_process assignment
config: s390-randconfig-r073-20260513 (https://download.01.org/0day-ci/archive/20260513/202605130223.sNRxfA5D-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
smatch: v0.5.0-9065-ge9cc34fd
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260513/202605130223.sNRxfA5D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605130223.sNRxfA5D-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/nvmem/layouts/onie-tlv.c:127:26: error: incompatible function pointer types assigning to 'nvmem_cell_post_process_t' (aka 'int (*)(void *, const char *, int, unsigned int, void *, unsigned long)') from 'nvmem_cell_post_process_t (u8, u8 *)' (aka 'int (*(unsigned char, unsigned char *))(void *, const char *, int, unsigned int, void *, unsigned long)') [-Wincompatible-function-pointer-types]
     127 |                 cell.read_post_process = onie_tlv_read_cb;
         |                                        ^ ~~~~~~~~~~~~~~~~
   1 error generated.


vim +127 drivers/nvmem/layouts/onie-tlv.c

    97	
    98	static int onie_tlv_add_cells(struct device *dev, struct nvmem_device *nvmem,
    99				      size_t data_len, u8 *data)
   100	{
   101		struct nvmem_cell_info cell = {};
   102		struct device_node *layout;
   103		struct onie_tlv tlv;
   104		unsigned int hdr_len = sizeof(struct onie_tlv_hdr);
   105		unsigned int offset = 0;
   106		int ret;
   107	
   108		layout = of_nvmem_layout_get_container(nvmem);
   109		if (!layout)
   110			return -ENOENT;
   111	
   112		while (offset < data_len) {
   113			memcpy(&tlv, data + offset, sizeof(tlv));
   114			if (offset + tlv.len >= data_len) {
   115				dev_err(dev, "Out of bounds field (0x%x bytes at 0x%x)\n",
   116					tlv.len, hdr_len + offset);
   117				break;
   118			}
   119	
   120			cell.name = onie_tlv_cell_name(tlv.type);
   121			if (!cell.name)
   122				continue;
   123	
   124			cell.offset = hdr_len + offset + sizeof(tlv.type) + sizeof(tlv.len);
   125			cell.bytes = tlv.len;
   126			cell.np = of_get_child_by_name(layout, cell.name);
 > 127			cell.read_post_process = onie_tlv_read_cb;
   128	
   129			ret = nvmem_add_one_cell(nvmem, &cell);
   130			if (ret) {
   131				of_node_put(layout);
   132				return ret;
   133			}
   134	
   135			offset += sizeof(tlv) + tlv.len;
   136		}
   137	
   138		of_node_put(layout);
   139	
   140		return 0;
   141	}
   142	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

