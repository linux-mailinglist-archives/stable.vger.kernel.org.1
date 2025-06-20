Return-Path: <stable+bounces-155075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB739AE187F
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 12:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C582E7A8099
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957302868B4;
	Fri, 20 Jun 2025 10:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLULznh3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC78A21ADA2;
	Fri, 20 Jun 2025 10:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750413783; cv=none; b=ZjQ7leaAZ46d+I6PoT6Z6U60WKfxlMEnK2H2mIPzR5F/5h2GUnGzkFk08gJLv5k0uTlqYmZf6VD6r3DmMX99xJ738WwTs1a8BJmuyWN1JchcRUdbc8Ul+gmhwE/dyx0uRL9tNiLukCAQym1k2XufC8t8IpFSQLb40eRi/RyyOXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750413783; c=relaxed/simple;
	bh=yuGYBq5P7T9uK5hiNxqj8ozObL4626Y0Njl5hIt8vS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkfSRnsQRsukecgL63K7wK48qw+4e2h2v4iFwbGy/2vAHnDkd4o73haqJCJ70y6ePKKcVYFR53DFhRliuaShyYyzhmK9QmTJqEtS+iPECfO1w4J5SfqgsnHhxITQ+rysofViokD1ReEbcYrQy1nbZaHo2TcnRVg/qcLZgeYw4vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLULznh3; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750413782; x=1781949782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yuGYBq5P7T9uK5hiNxqj8ozObL4626Y0Njl5hIt8vS4=;
  b=gLULznh3zxCcu10Dt6hoyVOrYkOLX+RluUmWBb6F5wBW7jtT7aNxOuR7
   VT1lgFxEieouwhGUqrTp8WwDzGO4L32w7STOtuFTwkZ1VHX41v1QIeheS
   sPM/mLaTNDCDWSeYtxav702Q2bqsJ7SQJTCImC3DG0dbbZEKgoWidLUQ3
   wEnqvcZ54ABm7JOTNEOb430UwL667MokrY9m6Ha6nDlomeJVn65+gIbT8
   iH/Nxl/+G3liz+2cvWcgwbfiqorI0mZrwoIfukHej7WWE8nqLPGDLTSz1
   GdKOaQkThSMK7jepnRQa8ApokmF7VCtjflo2FGJa3HcGdOQRDCRxph64J
   Q==;
X-CSE-ConnectionGUID: AO8LoelDStC0CH5SRSRA2w==
X-CSE-MsgGUID: FKJjdWFiQQaLDE+Hx4TWWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="63277714"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="63277714"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 03:03:01 -0700
X-CSE-ConnectionGUID: 5ZZa8p2ESG+dSjMp+x/O8g==
X-CSE-MsgGUID: hecw/N26Swu8ocsSBftMpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="151081615"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 20 Jun 2025 03:02:58 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSYaF-000Lb4-0K;
	Fri, 20 Jun 2025 10:02:55 +0000
Date: Fri, 20 Jun 2025 18:02:52 +0800
From: kernel test robot <lkp@intel.com>
To: Dominique Martinet via B4 Relay <devnull+asmadeus.codewreck.org@kernel.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	stable@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH v2] net/9p: Fix buffer overflow in USB transport layer
Message-ID: <202506201706.IUsC9LOI-lkp@intel.com>
References: <20250620-9p-usb_overflow-v2-1-026c6109c7a1@codewreck.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620-9p-usb_overflow-v2-1-026c6109c7a1@codewreck.org>

Hi Dominique,

kernel test robot noticed the following build errors:

[auto build test ERROR on 74b4cc9b8780bfe8a3992c9ac0033bf22ac01f19]

url:    https://github.com/intel-lab-lkp/linux/commits/Dominique-Martinet-via-B4-Relay/net-9p-Fix-buffer-overflow-in-USB-transport-layer/20250620-052411
base:   74b4cc9b8780bfe8a3992c9ac0033bf22ac01f19
patch link:    https://lore.kernel.org/r/20250620-9p-usb_overflow-v2-1-026c6109c7a1%40codewreck.org
patch subject: [PATCH v2] net/9p: Fix buffer overflow in USB transport layer
config: i386-randconfig-004-20250620 (https://download.01.org/0day-ci/archive/20250620/202506201706.IUsC9LOI-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250620/202506201706.IUsC9LOI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506201706.IUsC9LOI-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/9p/trans_usbg.c:257:23: error: use of undeclared identifier 'req_sizel'; did you mean 'req_size'?
     257 |         p9_rx_req->rc.size = req_sizel;
         |                              ^~~~~~~~~
         |                              req_size
   net/9p/trans_usbg.c:234:15: note: 'req_size' declared here
     234 |         unsigned int req_size = req->actual;
         |                      ^
   1 error generated.


vim +257 net/9p/trans_usbg.c

   228	
   229	static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
   230	{
   231		struct f_usb9pfs *usb9pfs = ep->driver_data;
   232		struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
   233		struct p9_req_t *p9_rx_req;
   234		unsigned int req_size = req->actual;
   235		int status = REQ_STATUS_RCVD;
   236	
   237		if (req->status) {
   238			dev_err(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
   239				ep->name, req->status, req->actual, req->length);
   240			return;
   241		}
   242	
   243		p9_rx_req = usb9pfs_rx_header(usb9pfs, req->buf);
   244		if (!p9_rx_req)
   245			return;
   246	
   247		if (req_size > p9_rx_req->rc.capacity) {
   248			dev_err(&cdev->gadget->dev,
   249				"%s received data size %u exceeds buffer capacity %zu\n",
   250				ep->name, req_size, p9_rx_req->rc.capacity);
   251			req_size = 0;
   252			status = REQ_STATUS_ERROR;
   253		}
   254	
   255		memcpy(p9_rx_req->rc.sdata, req->buf, req_size);
   256	
 > 257		p9_rx_req->rc.size = req_sizel;
   258	
   259		p9_client_cb(usb9pfs->client, p9_rx_req, status);
   260		p9_req_put(usb9pfs->client, p9_rx_req);
   261	
   262		complete(&usb9pfs->received);
   263	}
   264	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

