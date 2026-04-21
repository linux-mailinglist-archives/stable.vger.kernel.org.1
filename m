Return-Path: <stable+bounces-240182-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BjGBxKN52m89wEAu9opvQ
	(envelope-from <stable+bounces-240182-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 16:43:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A6C43C395
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 16:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 172C03030EA6
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 14:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511563D8134;
	Tue, 21 Apr 2026 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BDK6A7pw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA43B387590;
	Tue, 21 Apr 2026 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776782256; cv=none; b=oaPO3pKFxAIX5GtFWt0lDkNeadSn0aFbOaox7MkIu/omt9s5aQ8s5t3z+KSbty+xY4tUXZZqbFcEl/mDtlWYdP9VW2DlTEr/twwFkPgY8MnhP3RHK1GkapKjc9xtzoZJRLqJhqfwOTkDLJiBNXBSNJY+3M1ykcEy8eSkPQ8DuEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776782256; c=relaxed/simple;
	bh=Jc1r7WiTMzlzZpAR8gpYFiGbgq1zu4/YSPRVmKk3eB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3Xkq87jM7RjUq6xfzBJqBDepsbH/gjfkUZmNj87Hlscs4FmurIieKr/wGsdVYPY+XTV7eL+Qu4kgoBJRjKdWdoULTlyXGLkFhQJyW8ik58xlWBMTtiLGoY524yPgaMEdnOQYiqIuWjAe4axoaNiz3zdLJBXp/9KImdnJPqB7uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BDK6A7pw; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776782255; x=1808318255;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jc1r7WiTMzlzZpAR8gpYFiGbgq1zu4/YSPRVmKk3eB4=;
  b=BDK6A7pwuiviAjoLYy5gDzccGnafRw4R99hfgBP/DoCV/X05h3VfAek+
   Ewx5GJ4HxWf8t+YEvQTPvkT00KnTafwndm7/SPjbA3X9B4OV5h+3/dYYA
   Zqi4H3wWk9uOPNih+wwFXRrAB4dVPDFbmwN5cDxtKxredHGhXq0k2AQQy
   Sli1Pj0oo/uKzq6kBGFwKLi9rOuF9KMLaHGG8QxOBaYXw+03Vn3d6yE0a
   MVyCal2EymsgqZuuqKeHp4I/Z5zuGDce+xL5SGGucea4RFLBnjU9MwQMe
   X/zOz6cLdt4FUgzcC7KTeMoMcZJR5jcO19bqm2j227BlhpSQoe/NpLjwB
   Q==;
X-CSE-ConnectionGUID: NUJwpAkTQJix4KQK172M/Q==
X-CSE-MsgGUID: a9uplsiSStatYM5j0iAl3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="100373430"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="100373430"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 07:37:10 -0700
X-CSE-ConnectionGUID: PYeFdFnCTU+49WDFjXKZ+g==
X-CSE-MsgGUID: p2vpNJ3bTUCon9nd1F/utQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="227725225"
Received: from lkp-server01.sh.intel.com (HELO 7e48d0ff8e22) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 21 Apr 2026 07:37:07 -0700
Received: from kbuild by 7e48d0ff8e22 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wFCDo-000000003dg-37uZ;
	Tue, 21 Apr 2026 14:37:04 +0000
Date: Tue, 21 Apr 2026 22:36:24 +0800
From: kernel test robot <lkp@intel.com>
To: Tristan Madani <tristmd@gmail.com>, linux-bluetooth@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	luiz.dentz@gmail.com, marcel@holtmann.org, sven@svenpeter.dev,
	marcan@marcan.st, asahi@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v3] Bluetooth: hci_bcm4377: validate firmware event
 length in completion ring
Message-ID: <202604212248.Sek1Tdfg-lkp@intel.com>
References: <20260417104639.2608008-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417104639.2608008-1-tristmd@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,gmail.com,holtmann.org,svenpeter.dev,marcan.st,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-240182-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 61A6C43C395
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Tristan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on bluetooth-next/master linus/master v7.0 next-20260420]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tristan-Madani/Bluetooth-hci_bcm4377-validate-firmware-event-length-in-completion-ring/20260420-161359
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20260417104639.2608008-1-tristmd%40gmail.com
patch subject: [PATCH v3] Bluetooth: hci_bcm4377: validate firmware event length in completion ring
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20260421/202604212248.Sek1Tdfg-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260421/202604212248.Sek1Tdfg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604212248.Sek1Tdfg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/bluetooth/hci_bcm4377.c:11:
   In file included from include/linux/dma-mapping.h:8:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:1209:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1209 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> drivers/bluetooth/hci_bcm4377.c:761:15: warning: format specifies type 'size_t' (aka 'unsigned long') but the argument has type 'u16' (aka 'unsigned short') [-Wformat]
     760 |                          "event data len %zu exceeds payload size %zu for ring %d\n",
         |                                                                   ~~~
         |                                                                   %hu
     761 |                          data_len, ring->payload_size, ring->ring_id);
         |                                    ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:156:70: note: expanded from macro 'dev_warn'
     156 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                     ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ~~~    ^~~~~~~~~~~
   2 warnings generated.


vim +761 drivers/bluetooth/hci_bcm4377.c

   734	
   735	static void bcm4377_handle_completion(struct bcm4377_data *bcm4377,
   736					      struct bcm4377_completion_ring *ring,
   737					      u16 pos)
   738	{
   739		struct bcm4377_completion_ring_entry *entry;
   740		u16 msg_id, transfer_ring;
   741		size_t entry_size, data_len;
   742		void *data;
   743	
   744		if (pos >= ring->n_entries) {
   745			dev_warn(&bcm4377->pdev->dev,
   746				 "invalid offset %d for completion ring %d\n", pos,
   747				 ring->ring_id);
   748			return;
   749		}
   750	
   751		entry_size = sizeof(*entry) + ring->payload_size;
   752		entry = ring->ring + pos * entry_size;
   753		data = ring->ring + pos * entry_size + sizeof(*entry);
   754		data_len = le32_to_cpu(entry->len);
   755		msg_id = le16_to_cpu(entry->msg_id);
   756		transfer_ring = le16_to_cpu(entry->ring_id);
   757	
   758		if (data_len > ring->payload_size) {
   759			dev_warn(&bcm4377->pdev->dev,
   760				 "event data len %zu exceeds payload size %zu for ring %d\n",
 > 761				 data_len, ring->payload_size, ring->ring_id);
   762			return;
   763		}
   764	
   765		if ((ring->transfer_rings & BIT(transfer_ring)) == 0) {
   766			dev_warn(
   767				&bcm4377->pdev->dev,
   768				"invalid entry at offset %d for transfer ring %d in completion ring %d\n",
   769				pos, transfer_ring, ring->ring_id);
   770			return;
   771		}
   772	
   773		dev_dbg(&bcm4377->pdev->dev,
   774			"entry in completion ring %d for transfer ring %d with msg_id %d\n",
   775			ring->ring_id, transfer_ring, msg_id);
   776	
   777		switch (transfer_ring) {
   778		case BCM4377_XFER_RING_CONTROL:
   779			bcm4377_handle_ack(bcm4377, &bcm4377->control_h2d_ring, msg_id);
   780			break;
   781		case BCM4377_XFER_RING_HCI_H2D:
   782			bcm4377_handle_ack(bcm4377, &bcm4377->hci_h2d_ring, msg_id);
   783			break;
   784		case BCM4377_XFER_RING_SCO_H2D:
   785			bcm4377_handle_ack(bcm4377, &bcm4377->sco_h2d_ring, msg_id);
   786			break;
   787		case BCM4377_XFER_RING_ACL_H2D:
   788			bcm4377_handle_ack(bcm4377, &bcm4377->acl_h2d_ring, msg_id);
   789			break;
   790	
   791		case BCM4377_XFER_RING_HCI_D2H:
   792			bcm4377_handle_event(bcm4377, &bcm4377->hci_d2h_ring, msg_id,
   793					     entry->flags, HCI_EVENT_PKT, data,
   794					     data_len);
   795			break;
   796		case BCM4377_XFER_RING_SCO_D2H:
   797			bcm4377_handle_event(bcm4377, &bcm4377->sco_d2h_ring, msg_id,
   798					     entry->flags, HCI_SCODATA_PKT, data,
   799					     data_len);
   800			break;
   801		case BCM4377_XFER_RING_ACL_D2H:
   802			bcm4377_handle_event(bcm4377, &bcm4377->acl_d2h_ring, msg_id,
   803					     entry->flags, HCI_ACLDATA_PKT, data,
   804					     data_len);
   805			break;
   806	
   807		default:
   808			dev_warn(
   809				&bcm4377->pdev->dev,
   810				"entry in completion ring %d for unknown transfer ring %d with msg_id %d\n",
   811				ring->ring_id, transfer_ring, msg_id);
   812		}
   813	}
   814	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

