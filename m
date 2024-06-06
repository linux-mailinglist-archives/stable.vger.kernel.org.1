Return-Path: <stable+bounces-48272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943288FDF0F
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 08:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1618FB257DF
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 06:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B9A73472;
	Thu,  6 Jun 2024 06:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mja/a6U2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C2E3A8F0
	for <stable@vger.kernel.org>; Thu,  6 Jun 2024 06:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717656327; cv=none; b=d0ucknfsKeVr/IXdZpEStdysJyEMsbr4o70I4AmEHwGuVLzsOloK5u2Q+/RbtXJkxsPZqwhg6naRSdLVDpUv3njNBwTkoCFCHktRamiTDQknDKAbdz7zqOhS/vfisqqhPYoGmaTzNCfBbhIBFhcK3u6NgzN0bPh5y17cwJStVho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717656327; c=relaxed/simple;
	bh=3q4wzSJm4vMmM9zMczMTuQYF13hwlu2zwEVuOIjRjiY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SQf3f1K4oPWc9VYmSwC9zVUntBmaiZGbNkUG+FTMKPP6O8Iv0unLI1/5/ZLSAnkF3wYDWnJf/oRxC0lAFz1RNqPtxfEeV6q3Xsmk34BtCBmYCfQptP1x/y9A2ukaqO3T+ybPnDdv/lO6otbX+wmxMjKV4z3CY/xfuQHxoD3Lbdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mja/a6U2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717656326; x=1749192326;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=3q4wzSJm4vMmM9zMczMTuQYF13hwlu2zwEVuOIjRjiY=;
  b=Mja/a6U2gWAfVlKtj8O1/d+ulnv/uWyWSkJ89wyBo7YqZoMj1lfgndFV
   0rVBVV+wG4DwXIOv5v5dNbVAh/3VK0kjMJlnSHUo31BTQug8rGp4b/o1J
   +1aCR8d7VSVmvKMJi857dHaBRokHYTtuA1zGJk8MIbdNQ4C8yf5K3qhQ0
   5IQy6xWV4rOOyuwSTA7nG44R34FfgYIrPZiFE4MvCVmupgLrXRrpJZLoH
   7BI3pjN5bXITRG+wtq7ZFSUVxWHJTNM2X0U+GiEVnBf91Hj/WU611y3Ke
   FhgWZzGaMzwuw8NCp+69GRxFPPXfHzZCbeaJT8ttp0P+JlTa3yJuHS7NZ
   Q==;
X-CSE-ConnectionGUID: c9wKaadORnyV3niI8mYdfg==
X-CSE-MsgGUID: 5MP9XwbrR9eyyP6Mvpd/Tg==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14437767"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="14437767"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 23:45:26 -0700
X-CSE-ConnectionGUID: Ttl83260S7Oo3PRphhIn1g==
X-CSE-MsgGUID: Fwle9UYpS+2QFHluCC1p8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="42804582"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 05 Jun 2024 23:45:24 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sF6s4-0002lc-1c;
	Thu, 06 Jun 2024 06:45:21 +0000
Date: Thu, 6 Jun 2024 14:44:38 +0800
From: kernel test robot <lkp@intel.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/2] docs: stable-kernel-rules: provide example of
 specifying target series
Message-ID: <ZmFa1jSIiGmykc8t@242c30a86391>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606064311.18678-1-shung-hsi.yu@suse.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 1/2] docs: stable-kernel-rules: provide example of specifying target series
Link: https://lore.kernel.org/stable/20240606064311.18678-1-shung-hsi.yu%40suse.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




