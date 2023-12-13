Return-Path: <stable+bounces-6589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DC2810EF3
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 11:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DF3F1F21134
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 10:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3E022EF1;
	Wed, 13 Dec 2023 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cthiuZr0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643BED5
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 02:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702464722; x=1734000722;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=azxtPodpWsrfROV8QwGyX4v9jxYAoOU1Lvp6luubsYY=;
  b=cthiuZr0dHWHIot5fiLjWiZcCwXhmR/o2KvmRKgeT4dcfJezHpMI7ugq
   vfSyUEkazuikRNUbiRo4kg/FWeYYjp6QOqjYnhlwcyeLp43AXwezhGiFS
   M/sVD4v4LhfzYJJ6qDPsbFCMijXTiTNspeCNO5S5pOzj7SuJPKXg1q1Vs
   NoLQLDBPHUK4H6QYPUq08fQTfUM71U5oFRQZJn0hd9i1dyTf+KbCGSJTe
   EG6UgwzVnlyqPr6zRBPBROb6QEe91aNIx1H0JbseMNal77Rkv9I2aaJKj
   AnuTzqzDrPclKxz1JKyUx1k8qBDxVBPVJef4ZsnVvqpeUNKRyQjATPTSO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="375100204"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="375100204"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 02:52:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1021068080"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="1021068080"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 13 Dec 2023 02:52:01 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDMqN-000KQl-0H;
	Wed, 13 Dec 2023 10:51:59 +0000
Date: Wed, 13 Dec 2023 18:51:10 +0800
From: kernel test robot <lkp@intel.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 2/5] lib: move pci_iomap.c to drivers/pci/
Message-ID: <ZXmMnhe3YpLOqYam@171f04e7aea4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213104922.13894-3-pstanner@redhat.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v5 2/5] lib: move pci_iomap.c to drivers/pci/
Link: https://lore.kernel.org/stable/20231213104922.13894-3-pstanner%40redhat.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




