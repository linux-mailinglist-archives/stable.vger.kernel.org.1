Return-Path: <stable+bounces-163427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C1EB0AE9F
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 10:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335531AA5F5A
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 08:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D099B2356D9;
	Sat, 19 Jul 2025 08:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ULgNTuR2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE46123507E;
	Sat, 19 Jul 2025 08:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752913556; cv=none; b=X/PezLXEbbz+llHQbA3AtVHKfB36q+/Jj59JuqqbjSavxdpZuK+hLBarSNTK05Y7ihswCg+/3qajFb0R7/X5oAsiJ0etUrRf4grYWEM+DDADm0hDEb4ZmnlYqCW4poxdVmrdI1FwB9COrw7Qg0vshcZVg09M9qnICi5/v/SKdqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752913556; c=relaxed/simple;
	bh=4eRGrkNw5Cb+IWU2kFLOeD/+YDj6S0Mo45vQlVKl17o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6zGAsNIop7/EBpGTMSj9ATMJLbhafQDo492I+LQI3qNqWD/EJgl76BzbfN+JsxoxEWSIvGkf8HjqjLTGh9pqxQVH+wwb2+wsQZtY0pc004iigUwx2DBZ2VdyhfQsWBse4finsLAlYXe7HOe3tqDFg5kP9+Vt/12ZzOC8W0y32o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ULgNTuR2; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752913555; x=1784449555;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4eRGrkNw5Cb+IWU2kFLOeD/+YDj6S0Mo45vQlVKl17o=;
  b=ULgNTuR2iRGRyt7z630yGLQ44K3JXH352WWDuQhjOgaSx1oOcdp1Lit7
   IspcKHL7hr3aQMs4tSwYVpu0uVsyVKwg4pGHQNRJBdCUNti/pi/QahYG4
   Lb1bMlm2hhzD10VvcWDaGkWeKEGAF9YSOj5vZgV0oKD5AxGaE1/zt5fzh
   kBsfKJEVaSeCwZwpDsi+3QX7sHv/c3c8wA34+XsAS7s/AiwFzxTYiV7At
   tXc1qXrB4sP8LkLFZEfjjtx2hMh8EwcS5NyZgJhHk0YkniXktRHa/g93T
   LovCu4yVkxmdKvK/TQjqX8e8w5NSmOErKtrBBn17bh5apHKTiExetk++U
   w==;
X-CSE-ConnectionGUID: 171Tw5J8TwqhoqlPsvpY6g==
X-CSE-MsgGUID: sic/X45ETZWfDXbttkpYkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="59011639"
X-IronPort-AV: E=Sophos;i="6.16,323,1744095600"; 
   d="scan'208";a="59011639"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2025 01:25:54 -0700
X-CSE-ConnectionGUID: +7S6gRYbTFKNwAB/ImkwEw==
X-CSE-MsgGUID: K0XQRP2vRl6ZkaKXZaYvSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,323,1744095600"; 
   d="scan'208";a="164052562"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 19 Jul 2025 01:25:49 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ud2t9-000FLL-05;
	Sat, 19 Jul 2025 08:25:47 +0000
Date: Sat, 19 Jul 2025 16:24:47 +0800
From: kernel test robot <lkp@intel.com>
To: Macpaul Lin <macpaul.lin@mediatek.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Sean Wang <sean.wang@mediatek.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	openembedded-core@lists.openembedded.org, patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Bear Wang <bear.wang@mediatek.com>,
	Pablo Sun <pablo.sun@mediatek.com>,
	Ramax Lo <ramax.lo@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH 3/4] arm64: dts: mediatek: add device-tree for Genio 1200
 EVK UFS board
Message-ID: <202507191640.Ghk47rXu-lkp@intel.com>
References: <20250718083202.654568-3-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718083202.654568-3-macpaul.lin@mediatek.com>

Hi Macpaul,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on arm64/for-next/core krzk/for-next linus/master v6.16-rc6]
[cannot apply to next-20250718]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Macpaul-Lin/arm64-dts-mediatek-mt8395-genio-1200-evk-Move-common-parts-to-dtsi/20250718-163459
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250718083202.654568-3-macpaul.lin%40mediatek.com
patch subject: [PATCH 3/4] arm64: dts: mediatek: add device-tree for Genio 1200 EVK UFS board
config: arm64-randconfig-001-20250719 (https://download.01.org/0day-ci/archive/20250719/202507191640.Ghk47rXu-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250719/202507191640.Ghk47rXu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507191640.Ghk47rXu-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk-ufs.dts:10.1-8 Label or path ufshci not found
   FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

