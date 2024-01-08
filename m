Return-Path: <stable+bounces-10331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7228274F3
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 17:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA582826BD
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0900552F67;
	Mon,  8 Jan 2024 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BdjM9lAB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31D952F6C
	for <stable@vger.kernel.org>; Mon,  8 Jan 2024 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704730874; x=1736266874;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=7HyE+K0X28aRFjrrczkfhlRAD/YyaDO08/pFbFwWrCQ=;
  b=BdjM9lABR5DhyOLBreZFIEAdYb75jimDVNpZLR5q2Idi0OC+69InHurA
   ONGhwHwRNmRKK7/DelghyKkExJN8sW2d2sAjLdbOLBWJP8kX34ZSNbSfE
   0bMvCcBWBwSw4ApHkOY0zpffYDM9Y8fkx7fKYP0DnqEofJc+e4N0Tknpo
   W0Jgqmk5q7nGxJAiCfdjIXfDcA8p9Y1dauz3LI3WewWedknjcbQiCQ14G
   2TbSw05S3TLYZP9COYs6cBKAoemRz0RymMJENOXWL66yPnDa2kKxGJIfx
   YGFOT7MEv5m8ZPUTb1X3jhzel31zOO6jWJSmHEvHSqXbvZXSLhTpr6Gk8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="396808493"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="396808493"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 08:21:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="15956549"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 08 Jan 2024 08:21:12 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMsNC-0004rs-0u;
	Mon, 08 Jan 2024 16:21:10 +0000
Date: Tue, 9 Jan 2024 00:20:32 +0800
From: kernel test robot <lkp@intel.com>
To: Sean Anderson <sean.anderson@seco.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v4 1/2] soc: fsl: qbman: Always disable interrupts when
 taking cgr_lock
Message-ID: <ZZwg0Lv30zTPBc7P@c3f7b2283334>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108161904.2865093-1-sean.anderson@seco.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v4 1/2] soc: fsl: qbman: Always disable interrupts when taking cgr_lock
Link: https://lore.kernel.org/stable/20240108161904.2865093-1-sean.anderson%40seco.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




