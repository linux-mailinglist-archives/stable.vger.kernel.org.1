Return-Path: <stable+bounces-9658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D62B4823E4B
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 10:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84BFC2842A8
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 09:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B787C20321;
	Thu,  4 Jan 2024 09:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WH2uEpoi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A911EA90
	for <stable@vger.kernel.org>; Thu,  4 Jan 2024 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704359318; x=1735895318;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=/wYipIGq+npbriTi6Kfvy6fxaJvrY7QsjNqSSvxMIjg=;
  b=WH2uEpoiHrEwzw13zilxuAXR0100Vqe6ocqIAi+9SQyVfdg/Y83hnuhk
   1DzCQoMRkYpEH5p6q30SlZnkVFQshd/StwvSIDtV2Q6M1wVL3vQTG8hp0
   twM8dXa6AYr4Z3rxwQJa+ku0ixzym0PYfzHx5pdtQjrnO2DH7QTT57onH
   vgNl/BAhLPLlORHhA7Zwv/LYxteslnOf14/V85baW+XJdaDyCtr/bR0zq
   Rzy7ah7hT1UxvgKBPMYvL33aYkvdk0AkiCwxCsZlW6FGYypznoY2IvQ8a
   /pmVWD6SxbKvjWaxoqDp240NN8Y45/qaHaiOb7Nu8suNy553Q3AxOSVVm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="10563905"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="10563905"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 01:08:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="1111661926"
X-IronPort-AV: E=Sophos;i="6.04,330,1695711600"; 
   d="scan'208";a="1111661926"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jan 2024 01:08:36 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLJiM-000N6K-05;
	Thu, 04 Jan 2024 09:08:34 +0000
Date: Thu, 4 Jan 2024 17:08:23 +0800
From: kernel test robot <lkp@intel.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 2/5] lib: move pci_iomap.c to drivers/pci/
Message-ID: <ZZZ1h4Gd5YW5pj1P@89a6bd94b8e8>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104090708.10571-4-pstanner@redhat.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v5 2/5] lib: move pci_iomap.c to drivers/pci/
Link: https://lore.kernel.org/stable/20240104090708.10571-4-pstanner%40redhat.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




