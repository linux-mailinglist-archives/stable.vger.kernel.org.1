Return-Path: <stable+bounces-144589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80154AB9814
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 10:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656189E08F8
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 08:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B14282E1;
	Fri, 16 May 2025 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F3k8P/yp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB77221B9D8
	for <stable@vger.kernel.org>; Fri, 16 May 2025 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747385303; cv=none; b=FXzFEXpWrT28R+HXZdvQVr6txUhy7Lk63areda3/ppzLfg2gmb4fCbXTNpU8VvDAfL/Lizu95RI/dLX73rEVI1LhLSxipNf/P33fiNU+YH/WNADiHMfL89j1WUE8oTiBM+ljyB54BcZpw3zLnSwWfpQ8DPO74rQxkK2h2/DyFwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747385303; c=relaxed/simple;
	bh=kDkOm7pGhchT8GKyfSBekrMJI37CilN0rcaf5ViEAps=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ceYJWA8BtiKaUAkRi6Qpsx7eQmaDSoFHa5+4cn1VJWr165PaFUhclvbhF40GyyZjjfZ7ijgAVkmv4ABlVPE4cjc22y1J3ysE4KjwVyngISu+ynMWpa9/0J5fVPlTn66hWsyKWr8cwuGfm1UYwTUlenFH7rLLlRohHbAXzngq7UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F3k8P/yp; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747385301; x=1778921301;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=kDkOm7pGhchT8GKyfSBekrMJI37CilN0rcaf5ViEAps=;
  b=F3k8P/ypNMWBMkFItUgdSizOwP7KE1w+Hxbz8u78x+19ogzz3wHTZUBv
   6B/ZAxdb31gv4lkQO7nfmczBCOljAKN6ErXhUFYqg1YlKwlueAXj5y0pX
   HpbkRRfBVUdWsb7LM7Tla3y07p79+SNderXvz5eT+5/4c2bAkzrFuDFC8
   8LjprEf02USc77/yVhnJW41qSswjk/Ms4mCAORbNa84rdBhhZZTHHtFIK
   wWCkZYt0gA1t8PSEmV7+QhjOSaRxGLV2rG7zqhS04Fg58mIc+sjq/8LYh
   lIrJp+6gY7kUcTgeaRvXgmUj9eDpnuIKPqw7/OPA/1OGXWPrrhBprX6G6
   g==;
X-CSE-ConnectionGUID: VAgc1PUyRxegoHtnNOE3bw==
X-CSE-MsgGUID: kLi8VSY5RbavEWlWBWROGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="49220613"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="49220613"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 01:48:21 -0700
X-CSE-ConnectionGUID: tMnSTwNYRl2AD27EQls5tg==
X-CSE-MsgGUID: iINea8/7RhyC2xr0BfStrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="143862070"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 16 May 2025 01:48:20 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFqjp-000J9z-2t;
	Fri, 16 May 2025 08:48:17 +0000
Date: Fri, 16 May 2025 16:47:24 +0800
From: kernel test robot <lkp@intel.com>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 1/2] crypto: octeontx2: Initialize cptlfs device info
 once
Message-ID: <aCb7nE8gEpmdvpoZ@8c81029db2be>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516084441.3721548-2-bbhushan2@marvell.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2 1/2] crypto: octeontx2: Initialize cptlfs device info once
Link: https://lore.kernel.org/stable/20250516084441.3721548-2-bbhushan2%40marvell.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




