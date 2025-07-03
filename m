Return-Path: <stable+bounces-160087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 113EEAF7C66
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 578B77AC695
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C59922069F;
	Thu,  3 Jul 2025 15:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f0bZ5DsE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFA1FC0B
	for <stable@vger.kernel.org>; Thu,  3 Jul 2025 15:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556943; cv=none; b=sbRjADqUiyfDxIM+02gv2aC9OOJPV60JSPfohv0BB4astyO54GbhA34ERoP968MJ+v89QnEj8YJ5QgVIqnHuLdu5xpWSjHJmAErkqSiHSNZuh1/mf47JbJM9bW/122DCj7nc3m0mH2LLeQsYVYf2b4pSeX62ubRkWPYM9n5WOhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556943; c=relaxed/simple;
	bh=4hmK8hn+Rv8R6FQYtUawlrkRbbn4TakLst5+moB1oSU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Wacujv47zPJZNKUoyaO6rifc6A9UAb95z8GzVynipMNJaX7CdB5tNx9PAEgd/R5ZsRLmbHT3yuudN3YtpcPsW3yKpo9C0Yp49i+XlSQ7OX25Hajo5PIx90zz/wZ1t3QNuSKzOcC4X56IFebApLUf47PNfph9br7FNL5DOsytc7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f0bZ5DsE; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751556941; x=1783092941;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=4hmK8hn+Rv8R6FQYtUawlrkRbbn4TakLst5+moB1oSU=;
  b=f0bZ5DsEAzTEVCHcaPsDJTu9GZlpnadTxu5895Z9Nq2LpWxFlwFrelY7
   G5IaZCfyrv4keXbasOjj6p3KuxzTW5Mnjt49c/Ljq8MAXLHZw6xqWAC4P
   q83JPtCk8wms3qzZM+8OY/XiLdVd/U/BhWudUGNt4bzyGpR0irerpGBan
   ZKtLOMGAwTIezEoDmHg45ZxorQytPBaJ0LHMd0eSJ/+P7w0lR0/MSKEwX
   Zk41mSfoFS3oZDiw2Ei8+1ADDFP/J5C4mSYZVI0MvsIf2mwuBjCg5PQtZ
   iBWvymVi4JosOt6DTMvpiUEx68SZYC9T3hYj4fpfkjroD8mY9VSZSQJbo
   g==;
X-CSE-ConnectionGUID: vNedeL1BRvaYvKAETaCObw==
X-CSE-MsgGUID: D1OnjKQFSsCTlRfmA1AICA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53983904"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="53983904"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 08:35:40 -0700
X-CSE-ConnectionGUID: MP/y1R+3QRqtZGF7UZbRGQ==
X-CSE-MsgGUID: KWmAoqZAQ4GMmBlepAuNzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="185346844"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 03 Jul 2025 08:35:40 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXLyL-0002jT-2S;
	Thu, 03 Jul 2025 15:35:37 +0000
Date: Thu, 3 Jul 2025 23:34:50 +0800
From: kernel test robot <lkp@intel.com>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net v2 1/2] net: ipv4: fix incorrect MTU in broadcast
 routes
Message-ID: <aGajGp-Hu5S2k73L@909f0290d8b6>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703152838.2993-1-oscmaes92@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net v2 1/2] net: ipv4: fix incorrect MTU in broadcast routes
Link: https://lore.kernel.org/stable/20250703152838.2993-1-oscmaes92%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




