Return-Path: <stable+bounces-137005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D771AA0460
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 09:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71F431B649AA
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 07:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E199278154;
	Tue, 29 Apr 2025 07:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LQXFI6/q"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271DC21B1A3
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 07:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745911473; cv=none; b=hS0hIukB65SmFpu/HkUww6mcdgK83wV8c9C6sxQ+nkWrV4i/HNDYx4p4lFidc+ag1zDkvo069yEy2hDI5SmYIczxNmtN+xhucRu8bm66YzC3y5Hie1wuUrJXubfSeOlMhe20HKx2TH126hDk7R/5b1yAfiOTWn5OBV9QiCF9DWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745911473; c=relaxed/simple;
	bh=SaXlsyM6PyZ4WGFcQmBiOom1DhkEqxNSeJEBtv+AdPo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YzwwzskLBNjuA6plDOQn+kOwtlTC3ILyfpGHjJwEfwNf8pESzhM1aasrb9rmhMcQRjH+YDzN1JfQgz46A8FgHQA/7POaGn3+Bz8rL3PFeds5XYI0Eb3qvCzbJ1dI+MLyIe9h7rR2yx8eET+odY7xt6NVE4UUjW+sya6iqde7/t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LQXFI6/q; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745911472; x=1777447472;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=SaXlsyM6PyZ4WGFcQmBiOom1DhkEqxNSeJEBtv+AdPo=;
  b=LQXFI6/q+O6I6IqRSziPgrGY58i/IB8dAwPamDFIMssFjTLu50vU0JN6
   +9GiFGroIOQ4BvfegoKtEnzYtplyzMEtw42aQe5c+sVtXIseAKbWEspse
   kLt2Fcb424O9KjGrxQkuFaOU0U0uOSG9WcdfLas9Y4v8nuXws7jjsgr6R
   9yVEm5pl9/ok5nNgyTZk2wnpKhYM1ZXrRi7J59Qnqz9QQQz08QzmbeGDV
   3TeX6OjwCFWgJW5y7xjVSShCdiAsb1lTKvVi9UX0eqzcDC9befaD88HQo
   vA5mUHL2C1aaMuGu+ZUsH306fh1X3a/8tqhhusidqS14sFBaMRJrnoftg
   w==;
X-CSE-ConnectionGUID: MjTlG7quTxmLSKKIDJyakw==
X-CSE-MsgGUID: L7vfzlQxS46n3SfWT2Ra4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58176891"
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; 
   d="scan'208";a="58176891"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 00:24:31 -0700
X-CSE-ConnectionGUID: N4DFNfzzRT6g0Q9ZhWgngQ==
X-CSE-MsgGUID: ggB3pFbHSDGPH6Z84J0NFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; 
   d="scan'208";a="138556710"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 29 Apr 2025 00:24:30 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u9fKO-0000Xr-1Y;
	Tue, 29 Apr 2025 07:24:28 +0000
Date: Tue, 29 Apr 2025 15:24:28 +0800
From: kernel test robot <lkp@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net v2 2/2] net: phy: micrel: remove KSZ9477 EEE quirks
 now handled by phylink
Message-ID: <aBB-rLtmyV-mT70a@32b67a57eacb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429072317.2982256-3-o.rempel@pengutronix.de>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net v2 2/2] net: phy: micrel: remove KSZ9477 EEE quirks now handled by phylink
Link: https://lore.kernel.org/stable/20250429072317.2982256-3-o.rempel%40pengutronix.de

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




