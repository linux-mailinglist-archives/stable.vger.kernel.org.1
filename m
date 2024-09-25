Return-Path: <stable+bounces-77696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0F69860C2
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 16:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4F26288466
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9BD17BB26;
	Wed, 25 Sep 2024 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T1k15y4h"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6527118C936
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727270722; cv=none; b=hXGzBl3k+K3jkTzgl+FvSBOA2DUStSqLdvK9jsS48+pnTxNjjeKO+cd1N1XG/9cn21rMCAY0kWikw1/9zCL51X6vmx54UYG11JnBSLcbukR4+nNOEcvSF0che7d7c9WrZ4oOGfJexacG0uEfulvxVZwbxlEt1rvmdMcUXC/+fak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727270722; c=relaxed/simple;
	bh=2JteTvAbmc00AHrkef6ooggrZhytJf4QtwqafmPHan8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cMO2GzTI2FSl45kvaQJjIsGvUlMv0jifObdfmQk8ZB1+2PqgEno234SoUpUFk0i+9nCTArO4AyGc+HGKrPEvWinChTYr/RrLNscFhKw9j8DG251qDDhXwb9O9lyk8Jlj6KyIGrcvVqabyNcSB6SSFfGm4NPCn+4MB60D6uK1wXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T1k15y4h; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727270722; x=1758806722;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=2JteTvAbmc00AHrkef6ooggrZhytJf4QtwqafmPHan8=;
  b=T1k15y4ha5edi+5gXXZkcQOVAW2M0msw/KuEKymdV12IvzofD84Ugk/z
   r3HfKXIUgiBrSq68Tf3RidV05gMnZva6qfuRCfpMFJld853HCdU+l4Ona
   2cK3YPz3v+0dYNusfDExub1/TGGAydeoDlffeRozvYmR02uMgHCwC5Ofr
   /B5U9uZNMsVhLhfaOU1AqEHl+29OPuXwAcoza0koq7Nv1Pu5FFN9rKjfI
   f1uXF9i/2adKJKcOkLBXg5rw25cz5haEFNTXldWWBjWPnLrptrTAAgXuV
   AL3q6fjxiYT2jyVswTHoUvsFXDhOkobFOpQo8fUGvtw+EgIpnU43rF7ky
   g==;
X-CSE-ConnectionGUID: IPFQQRVORaqUerN5XDMjaQ==
X-CSE-MsgGUID: NOQavUtGQsO02q9BIbcm9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="37458715"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="37458715"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 06:25:21 -0700
X-CSE-ConnectionGUID: 6yRlcm7tSzaK7ZD0/HIRzQ==
X-CSE-MsgGUID: iqR4b6YXSYaORjTahwRtLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="71915685"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 25 Sep 2024 06:25:20 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stS17-000JZ5-0q;
	Wed, 25 Sep 2024 13:25:17 +0000
Date: Wed, 25 Sep 2024 21:25:03 +0800
From: kernel test robot <lkp@intel.com>
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH -next 2/2] kobject: fix memory leak when
 kobject_add_varg() returns error
Message-ID: <ZvQPL0_3_qEWNLNZ@5849f93d069a>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925120747.1930709-3-cuigaosheng1@huawei.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH -next 2/2] kobject: fix memory leak when kobject_add_varg() returns error
Link: https://lore.kernel.org/stable/20240925120747.1930709-3-cuigaosheng1%40huawei.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




