Return-Path: <stable+bounces-3875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7429A803329
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 13:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18089B20AAD
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 12:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1F5241F5;
	Mon,  4 Dec 2023 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KwmX8Zsn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D42197
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 04:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701693594; x=1733229594;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=SCGFojozvEvZyHypC1y+qu0KYosoWv57wd1JHn6tOKI=;
  b=KwmX8ZsnPx6O/CNse6xppmgy0C+Kz/MBODynr4uo1Keoi42mjoE1AF6j
   08oWbeVQdHKe0Aw4m/dEOfBhzcW9gcDMhpm/nIn4fdTomjoyaacGKRv+w
   sKkfNWcxnKEgyOVKccVWnzglLs9ic9W1N9MvouKTu3orOHUU2SK7SoouE
   ZSWeRO+ZiEhCORACQ1KnyQHjlLrtwYSzmPrQbIivorZAr0KI8ee4EkCL8
   6qM2FJ02Lz78m3LipNXVCXMNebaSayetrkYWgiEKUOIr6DKZN9BrU4cw7
   uU6MvTb5/CWQwYyMxZzcd+XR3hq16Yq68nvj8Ayw2m6u5n+d0D3hmezPK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="390885150"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="390885150"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 04:39:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="943868273"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="943868273"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 04 Dec 2023 04:39:52 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rA8Eo-0007je-1I;
	Mon, 04 Dec 2023 12:39:50 +0000
Date: Mon, 4 Dec 2023 20:39:33 +0800
From: kernel test robot <lkp@intel.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 2/5] lib: move pci_iomap.c to drivers/pci/
Message-ID: <ZW3IhaB6GIyi49Fy@5b683c117983>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204123834.29247-3-pstanner@redhat.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v3 2/5] lib: move pci_iomap.c to drivers/pci/
Link: https://lore.kernel.org/stable/20231204123834.29247-3-pstanner%40redhat.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




