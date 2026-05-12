Return-Path: <stable+bounces-246644-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AxBNwB2A2pY6AEAu9opvQ
	(envelope-from <stable+bounces-246644-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:48:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 433A25281CF
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6825930B7025
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD876364959;
	Tue, 12 May 2026 18:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g3h5iXmU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464D6352C2B;
	Tue, 12 May 2026 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609818; cv=none; b=nWCtonMgtihBfH6oKE5pobmkcaoIM+jlq/WtKO+eOjyobrnSoWeYjbFvXITlcHkXYeSQMh+50CfoeeCUxbyBkXLmoT2gHB1FPfGFNrBnW8nhcSd6bZU7daX8Cv3m4HN2nKr5rqQanghnJq47Uq0ZAXRO6WClJmcqvDR64UaX4ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609818; c=relaxed/simple;
	bh=1iccbtAqZZcwdZiQkb7nq0mWmcb2aFWAuiobN/rw3LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RR9whdxZ+4XtGQM6Q2wVh+YmdnddH2gbD5fKoMQg+Q/NuarO/G8PiTgEhRXY3vNh+Hfq+NkjX2lqjlw/zOLfTOluGRdL2ETLBq0ux1/xeb+XU9Q4Emfa/rhFsDraMrgKm0tDqxBXEjUG6slC+COWqBDJ//2jmL3Tuv5ZXAJbApI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g3h5iXmU; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778609817; x=1810145817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1iccbtAqZZcwdZiQkb7nq0mWmcb2aFWAuiobN/rw3LI=;
  b=g3h5iXmUjm3tmg8whYiCV6kZWo/94v75lpiegej78Icg6pZFjJ7ZbVed
   CkUPDXx5J2Whg44KNQKpFDRmz2/gW8i0FIT2wHdswXzTJIWC/wbUcMO3W
   7rCWqD02a1OxCyCQ1C7cL6ISRkL9oQhcvpA15hhEzV2J2Ih4T4g9xIEzp
   +JXVyVeBq3hUIpHtT0OuwkBpuTt0FNjzKNPrrYwBl4UG/GwpwgIXip/OJ
   hyybOHq385vZvt8gBIbxhg4c0BSm0tnpPeAmYXYDDDZ/lvfNGFlICtCBF
   eLmr58iU+ANxGoDSdtRKwEcxZP2lJmoH2JXKe0ooBhoOebgQOx3TNOe6+
   g==;
X-CSE-ConnectionGUID: UTlLF723QX+9enkyc7y2Vw==
X-CSE-MsgGUID: x6bT2xbzSOmOHjhiLFmgyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79243367"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="79243367"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 11:16:57 -0700
X-CSE-ConnectionGUID: zOtref1/SxyOg6eLbwIfbQ==
X-CSE-MsgGUID: N23V6en5S328Aa+0UaFF2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="239654370"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 12 May 2026 11:16:55 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMrf2-000000002Zz-21cu;
	Tue, 12 May 2026 18:16:52 +0000
Date: Wed, 13 May 2026 02:15:57 +0800
From: kernel test robot <lkp@intel.com>
To: chalianis1@gmail.com, miquel.raynal@bootlin.com, srini@kernel.org,
	gregkh@linuxfoundation.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Chali Anis <chalianis1@gmail.com>
Subject: Re: [PATCH] nvmem: layouts: onie-tlv: fix read_post_process
 assignment
Message-ID: <202605130229.IIa8Bfjl-lkp@intel.com>
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
X-Rspamd-Queue-Id: 433A25281CF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-246644-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cell.np:url,git-scm.com:url,cell.name:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim]
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
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20260513/202605130229.IIa8Bfjl-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260513/202605130229.IIa8Bfjl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605130229.IIa8Bfjl-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/nvmem/layouts/onie-tlv.c: In function 'onie_tlv_add_cells':
>> drivers/nvmem/layouts/onie-tlv.c:127:40: error: assignment to 'nvmem_cell_post_process_t' {aka 'int (*)(void *, const char *, int,  unsigned int,  void *, unsigned int)'} from incompatible pointer type 'int (* (*)(u8,  u8 *))(void *, const char *, int,  unsigned int,  void *, size_t)' {aka 'int (* (*)(unsigned char,  unsigned char *))(void *, const char *, int,  unsigned int,  void *, unsigned int)'} [-Werror=incompatible-pointer-types]
     127 |                 cell.read_post_process = onie_tlv_read_cb;
         |                                        ^
   cc1: some warnings being treated as errors


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

