Return-Path: <stable+bounces-163341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2FCB09E1E
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 10:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2E11AA2F66
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 08:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F47628C5CF;
	Fri, 18 Jul 2025 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nL1JbOgd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68646EEDE
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752827742; cv=none; b=cu+7ijgdDToqQKw/xsOrxxBw4nsD4HTF1sJWC2U3CcH+M0URPBRPyFvIxTBJNKgeaDgEzRXS6Qimjmj3kJdY+fNVNw5jAq5oGsIaA/jbh+/lIyUXpCUa331CQzo7GEkfEsPZDCxXR+AzjeiY9EwHTv7GToxtzW2WV2E5+RkQp/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752827742; c=relaxed/simple;
	bh=TWsknORm3ZLeHfMxdHLg3cJ0/9KGjglk6P5ewhVgjZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DUD7W5/SJ7gIpyKk8qWJN38DBj9n6vLINoU19GMSNGs0jRdc2zZQGDXjE4wCeh6N1xvaZi0POe3QtkEoi3QL7vSaaQcadUSJ407retm10Vw0C/s81LDtSSICdCQJ/K/6Pi/F/8LjHf0pACyya+AOfMpiZcnRcOM3zTsMRY5HCb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nL1JbOgd; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752827740; x=1784363740;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=TWsknORm3ZLeHfMxdHLg3cJ0/9KGjglk6P5ewhVgjZ0=;
  b=nL1JbOgd9bg+ozzKQBPB8jTT3nfk5yPrtt5Y++/vlRSF5h97iBZD+TR4
   nTWltj0eXkx+lSbGu9x/bAb273PtjSLTkK5vaMDZh2uhG9kwMbz7SvB/s
   2I8sgvqJI090fiTafrp9QbYFmk9cA7+Lyow9DpgilK71E49KTRi8LtJ1f
   4vPNnKOSZ23gMmrD8ckLoMyGEW1APv1S1ZQdQki9EI88c1xUai5ZfEol0
   zdCsAm3cJlT/649HgoRPF9Kp2Ru/feOFjyfBTqg/RJOm3Ftaf7Ybq9bei
   kb9uIIA49TsRq6cJlrkHofZbV+p/8egif50Z8hTTSFTYj7KXqdMNvEsyS
   Q==;
X-CSE-ConnectionGUID: nQDB2pVVTVGTiRX1VAFhpQ==
X-CSE-MsgGUID: 4gTbc8u3RSm5I/yriDG46g==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="66566329"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="66566329"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 01:35:40 -0700
X-CSE-ConnectionGUID: f5Fa1VqLTlS8RFlvr4vT1A==
X-CSE-MsgGUID: jCoibxkvTU2AogCR9HR76Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="158573617"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 18 Jul 2025 01:35:39 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucgZ6-000ERz-2Z;
	Fri, 18 Jul 2025 08:35:36 +0000
Date: Fri, 18 Jul 2025 16:34:50 +0800
From: kernel test robot <lkp@intel.com>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 4/4] arm64: defconfig: Enable UFS support for MediaTek
 Genio 1200 EVK UFS board
Message-ID: <aHoHKqXboY5WIXGy@c1a0ab53bc35>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718083202.654568-4-macpaul.lin@mediatek.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 4/4] arm64: defconfig: Enable UFS support for MediaTek Genio 1200 EVK UFS board
Link: https://lore.kernel.org/stable/20250718083202.654568-4-macpaul.lin%40mediatek.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




