Return-Path: <stable+bounces-72654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D3D967E18
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 05:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620F21C20A2D
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 03:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182833A8E4;
	Mon,  2 Sep 2024 03:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hVs5KkkD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E225D3A1C9
	for <stable@vger.kernel.org>; Mon,  2 Sep 2024 03:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725246760; cv=none; b=bNHtNowzTl6IuVECeqps4LuXCC7pa7D/jZ8aApv6uE9Lzac+QvePh3+O8pvatlESoWIhSmFDzsFAuwEY42c+p8dKRoeQk21FTxINCLH+E6VkekctI3/nG7qiqyGTx80iblOfb/GYoOAvlSVKOY29LZD381WNn20QjY0O+ln/wHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725246760; c=relaxed/simple;
	bh=HPPTbkJdcONTlDBJlH3MfZr/mcPf5dHy38cFBOnAOxE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jescwpU+IDL7yEK4rH1mDcqFm5MU51TsVC8xM/TtW8VTO+5y+j3/2Zq/WAhOKYIzazeGkAhKfVprfVoLu6j/iO5TsCN/IaZrGXU3jbrMjx+y9aVe4t39mfvk7n3hADD6UrJi4A8Mgh/aPb+4hTWRG76L9KUxzOZEGUvINef1NEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hVs5KkkD; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725246759; x=1756782759;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=HPPTbkJdcONTlDBJlH3MfZr/mcPf5dHy38cFBOnAOxE=;
  b=hVs5KkkDHuNVvFqJxpXaT00UpVtr7zsRiWiaJWtcR2JHgpS14pI9JBvK
   XG1iWhOSPjJH6yZTU3df8HVXqjBHacohJLzpacDKKUMdLTcznpMCLL3TX
   R9vunYZ6/gUHsW1i78Dm95wpgxo0iq1+uhvoBcGZYSt1CtI+tl4STOEtJ
   n6n5wDmCXlh7qgo+6+6z5QMi3KemiS8UKW+eFAPRkd7wLHs84NMhgl1yG
   yGa0QpmRR2ViYbKzZFMSt/pmOq0AKMkOMyxiWmYKP6g38qZOdKSuxp0rv
   SFs+UgtrjQJWqP4YFFo55fZiWpnAMB05Z3Zaq8u9Iarxt8OCmVE4hy2e8
   g==;
X-CSE-ConnectionGUID: vKjgmzz7Tr+PvupnoRlqfg==
X-CSE-MsgGUID: +SjQ2qsjRcSrGeasbogZUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="23971827"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="23971827"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 20:12:38 -0700
X-CSE-ConnectionGUID: sKMt+NPJQd2RZoTtclkeeA==
X-CSE-MsgGUID: TD3ltq3DSXmCJyRDufyaOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="65203568"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 01 Sep 2024 20:12:37 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skxUY-00054s-0p;
	Mon, 02 Sep 2024 03:12:34 +0000
Date: Mon, 2 Sep 2024 11:12:09 +0800
From: kernel test robot <lkp@intel.com>
To: Yenchia Chen <yenchia.chen@mediatek.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 5.15 1/1] PM: sleep: Restore asynchronous device resume
 optimization
Message-ID: <ZtUtCTTnGr1EU5_V@bcffd8c2c65a>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902031047.9865-2-yenchia.chen@mediatek.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 5.15 1/1] PM: sleep: Restore asynchronous device resume optimization
Link: https://lore.kernel.org/stable/20240902031047.9865-2-yenchia.chen%40mediatek.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




