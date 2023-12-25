Return-Path: <stable+bounces-8462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AC881E23C
	for <lists+stable@lfdr.de>; Mon, 25 Dec 2023 21:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8280D282117
	for <lists+stable@lfdr.de>; Mon, 25 Dec 2023 20:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C103B53801;
	Mon, 25 Dec 2023 20:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ad1EtLH0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B18537F7
	for <stable@vger.kernel.org>; Mon, 25 Dec 2023 20:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703534798; x=1735070798;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=u+/6sjY7VpctZDfTPh6njcbYZ+rQHCi2Ibvf8Yz1nC4=;
  b=ad1EtLH09K7GNyc1d2RqF6Il3u7ViOe5Zuf+wHp9Zwpffc1H/cRAdIK+
   +v4E05TiFKQ2KHrQQtpVlLfjezVxuX2rABOAWLsbRhD4mILCcLykMks39
   /e3U2VQC+FbOiFrUAA1+4azvTPdrQ5T98WTl7yhv6L6W6O5Sw35Z4GLky
   MTGRroQk024KEYgDBPU3leSIpvN/7lKjQFSixDnCKoRq7qiHFKCLVOiv7
   5LkVWdyIN3TvSwOjRsUAljG1JkH0HYdou4Iej2SyrgIAuxOCe/ehJEgqY
   gUlDAfWyUDDXb5hkCOkMLn8iRSPbh2xGepNhrFMrFnco3PLXXBiKsEY7N
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="381278098"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="381278098"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 12:06:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="896381098"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="896381098"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 25 Dec 2023 12:06:36 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHrBs-000De4-1u;
	Mon, 25 Dec 2023 20:06:20 +0000
Date: Tue, 26 Dec 2023 04:03:19 +0800
From: kernel test robot <lkp@intel.com>
To: Felix Zhang <mrman@mrman314.tech>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3] Bluetooth: Fix Bluetooth for BCM4377 on T2 Intel
 MacBooks
Message-ID: <ZYngB6txVLiaGBQt@89a6bd94b8e8>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77419ffacc5b4875e920e038332575a2a5bff29f.camel@mrman314.tech>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v3] Bluetooth: Fix Bluetooth for BCM4377 on T2 Intel MacBooks
Link: https://lore.kernel.org/stable/77419ffacc5b4875e920e038332575a2a5bff29f.camel%40mrman314.tech

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




