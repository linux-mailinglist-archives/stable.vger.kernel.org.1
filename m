Return-Path: <stable+bounces-189765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D551FC0A59A
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 10:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251693A9910
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 09:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B731288505;
	Sun, 26 Oct 2025 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ovp5fpfj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE0E17BA6;
	Sun, 26 Oct 2025 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761471847; cv=none; b=d1FO2hNYHTu0wV89Fsn6THtb1UnsMMFuGTT8vHBEXG9jZZE/VkBc4AEUtIzu9tzYnolzqOafVesfYXuiClsYpo70pLWQtkaI7mp1XeiyQQ7AuadFHVyWgD6BRmovwY9lDz+078+SZgoFWssXPdzLUviZHB0VczA+bl2JhNZaSX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761471847; c=relaxed/simple;
	bh=MyRDkkeM1WniRrNwIECJAWX6rR/HsGtbFOS5K7hsaLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyUTwQgb9ZM7c5nXnk8B8epmnlGi54Sum6Q6thMSduA7TqhC7UzmPVkcLzVyuMn7vN0iw2r5yJHYVmwVgm0EMEfWnmqWuFUOaT5Pfiyi4nQcibL/b4Kg6ccJErE2tehm60zBb9mevI7jHxZwQWzPg4PUX1yaAlY6kuGeQdXuLdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ovp5fpfj; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761471846; x=1793007846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MyRDkkeM1WniRrNwIECJAWX6rR/HsGtbFOS5K7hsaLo=;
  b=Ovp5fpfjKoj+Go/AhTv9LrRreDjFLLLAKWKxcFGrEonSqX4Y82zz4+Ol
   syh1m0Wkzmi14i5+R6twZ8uIpUZI5Dm63aM2f8lMJHgfCNEu+wuELgXZL
   y+4dVWyS/nvVK6V2LR08M6S6gke/3pdBWaN5ndvS4pEfoUFKmisQww65q
   XBpgAKybvLDu3zyBvkx3ZEvtJACf8feb6f8HP2LO3WHSZNwl7koDTakFs
   W8Us4FnV6mMOSFijmoki6UOmdArevFpeGa25S7GhbZ4I1+wh99LslNbA0
   HyFq717/VzwnQiJBNhqn0BwYXp4+PFam8v9lzlqNPLPDfVIx0/Z/xpXzr
   Q==;
X-CSE-ConnectionGUID: rU81IqelQ6OQupZgFBx7uA==
X-CSE-MsgGUID: xt7tB2iTQn2Ftk3k8LX/ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63730916"
X-IronPort-AV: E=Sophos;i="6.19,256,1754982000"; 
   d="scan'208";a="63730916"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 02:43:52 -0700
X-CSE-ConnectionGUID: RJXJrLBXRruANBTCQE/mPQ==
X-CSE-MsgGUID: sgB1CLxGQzyoEeuxq8N8/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,256,1754982000"; 
   d="scan'208";a="184877434"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 26 Oct 2025 02:43:46 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vCxHr-000G1x-2v;
	Sun, 26 Oct 2025 09:43:43 +0000
Date: Sun, 26 Oct 2025 17:43:09 +0800
From: kernel test robot <lkp@intel.com>
To: Coia Prant <coiaprant@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Coia Prant <coiaprant@gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Add devicetree for the X3568 v4
Message-ID: <202510261750.glZ5VRca-lkp@intel.com>
References: <20251025203711.3859240-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025203711.3859240-1-coiaprant@gmail.com>

Hi Coia,

kernel test robot noticed the following build errors:

[auto build test ERROR on krzk/for-next]
[also build test ERROR on krzk-dt/for-next linus/master v6.18-rc2]
[cannot apply to rockchip/for-next next-20251024]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Coia-Prant/arm64-dts-rockchip-Add-devicetree-for-the-X3568-v4/20251026-043855
base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git for-next
patch link:    https://lore.kernel.org/r/20251025203711.3859240-1-coiaprant%40gmail.com
patch subject: [PATCH] arm64: dts: rockchip: Add devicetree for the X3568 v4
config: arm64-randconfig-002-20251026 (https://download.01.org/0day-ci/archive/20251026/202510261750.glZ5VRca-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project e1ae12640102fd2b05bc567243580f90acb1135f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251026/202510261750.glZ5VRca-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510261750.glZ5VRca-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: missing overlay file(s)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

