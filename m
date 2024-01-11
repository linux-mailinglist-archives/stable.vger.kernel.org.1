Return-Path: <stable+bounces-10478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D8382AA1E
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 10:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 632791C25BA3
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 09:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E5D10798;
	Thu, 11 Jan 2024 09:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A3ac63Mu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F7E15E88
	for <stable@vger.kernel.org>; Thu, 11 Jan 2024 09:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704963635; x=1736499635;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=o1vI5mT2uCtYoRjBjp700Xz1Ms9vYBnPxC7L8P8Pyxc=;
  b=A3ac63MumRLgqFC97c9u5fnWtnM3KVbpVgIeO+wqUYkA4jQfKdcxnw6j
   J3pQMJV3aXXbp7XikbgR/1qexwyKXzaEElNGLy/MUSKWa8VMLCcWb9keP
   W5Il5M7JRkBIt6a2B7tXbx13MryFmtPj2jMrOgeT/HjHQKIwGKfEeb3Da
   TryzC0ctZicbffjBQHZ/mF1dHjwbB9X5lsNtLr2IFuXgIyjd3q3j6OMof
   RCihMvY4gdghXUJrRVEmog/q+bUY26woG+Nv2jrvCTIlk2BuVk0rPk6fF
   LbIflg9t6SN9ZuFuA6gbpTkUZkfQe2DRTrM1kAK9Dhkt8Os6WbGf1E5FW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="12142698"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="12142698"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 01:00:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="30930550"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 11 Jan 2024 01:00:32 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNqvO-00082w-0t;
	Thu, 11 Jan 2024 09:00:30 +0000
Date: Thu, 11 Jan 2024 16:59:49 +0800
From: kernel test robot <lkp@intel.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 RESEND 3/5] lib: move pci-specific devres code to
 drivers/pci/
Message-ID: <ZZ-uBdw3BkWT77hh@c3f7b2283334>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111085540.7740-4-pstanner@redhat.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v5 RESEND 3/5] lib: move pci-specific devres code to drivers/pci/
Link: https://lore.kernel.org/stable/20240111085540.7740-4-pstanner%40redhat.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




