Return-Path: <stable+bounces-203237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE95CD70E1
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 21:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F31C43013398
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 20:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AA62F39B1;
	Mon, 22 Dec 2025 20:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cKg+wnB3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C9427E05A
	for <stable@vger.kernel.org>; Mon, 22 Dec 2025 20:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766434729; cv=none; b=XOfaBO1U2QpAccz2FaFV8cLhWJQs65MtLBV1o54R148ddy3AaEgxIwN0S3Q1zwWtDArV6MObAlNUW1q9ZI3B3X3RzbYKF1PYdzqt7VDyq/HVr2B3cFZwxiBbGWJLNKq9v0xPujQLQ8hdE7V177G3V76lyGpfinOzqpk4cMYCjbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766434729; c=relaxed/simple;
	bh=s5g1M7ASUPGtsz/ukcH8wpUAsY/+CWsCNL66LhghGtM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lt+o9zIHj6u2460drJ+cgvm3m7hDqKtdBqz+1oY7uooms1ZhqdCRmG5BQo5THEmZTHUiBRq9BNHHrP+KfbX5nvG9GGGbmbFWuhMmBQl5GoBABNiTA95MG5/lD/x0YAs211ydM1mF05BaYqI480u/Hxi9hCSg2+WzTjjJkBqKY0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cKg+wnB3; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766434728; x=1797970728;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=s5g1M7ASUPGtsz/ukcH8wpUAsY/+CWsCNL66LhghGtM=;
  b=cKg+wnB3SF5a+6tgouoUdWbIVRHSCZO56eQhU+5sf58nP7JsmGQfobjS
   +mzOU6oZ+YMVkQhm3KBQerM5u6x2Yv48L8RZSyTxc08SiyF9UNjEZqMpu
   dVPFppyHEAlYl3kSLB3OJzk4ZcILEBNxnCvtc0sVJFqcbakl3VaWDYMpN
   6JKM7MmCSaKPmjNnzLT6dz+Eze7P4oiV0goXb2CiEfTEtHVA/nJtu450E
   RJ2csY57uOgFW6XJoiAykSgDAmJahmsL1rdeEvGSqsjORy/fMfIBxDjz/
   Ms5yZTaQB2VatMrG5IEDdsa+dnpl0dglWy5JkW/aRuHr9/Y3zEhTnBNzC
   g==;
X-CSE-ConnectionGUID: sOL66s0KSGK7hTujDK8KmQ==
X-CSE-MsgGUID: WX2SgYEzTaqKmkJUPrXymg==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="78924473"
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="78924473"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 12:18:46 -0800
X-CSE-ConnectionGUID: p1ZZCoQSQauXkUmCfs7Aww==
X-CSE-MsgGUID: xuHBzkFYSWCBI68xzLusfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="199637323"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 22 Dec 2025 12:18:44 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXmMc-0000000014X-2B9O;
	Mon, 22 Dec 2025 20:18:42 +0000
Date: Tue, 23 Dec 2025 04:18:39 +0800
From: kernel test robot <lkp@intel.com>
To: "Ionut Nechita (WindRiver)" <djiony2011@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 2/2] block: Fix WARN_ON in blk_mq_run_hw_queue when
 called from interrupt context
Message-ID: <aUmnn5Lk5bs5O5xV@a397199831b6>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222201541.11961-3-ionut.nechita@windriver.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2 2/2] block: Fix WARN_ON in blk_mq_run_hw_queue when called from interrupt context
Link: https://lore.kernel.org/stable/20251222201541.11961-3-ionut.nechita%40windriver.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




