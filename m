Return-Path: <stable+bounces-95713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC13F9DB849
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 14:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DB08B208B3
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 13:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F1E1A08B6;
	Thu, 28 Nov 2024 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YV+tslAY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7EF13B7BC
	for <stable@vger.kernel.org>; Thu, 28 Nov 2024 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732799358; cv=none; b=iw4JDTTIfMN/Q1OOIluMSAbQ7bmFR9UHpit+ODiWuIvj1+c8TAzyP48zxeN/CXCxAgDNlnQwJnHsgx6O0k5U7DrP8t3yVZs/FfHhRrQzclD6p2Wk1Z/mZr6xxvsL/9o6pKKIw0CcQawVbD9DPZMZ3hs1ocTz3JrpREDzYHtqD7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732799358; c=relaxed/simple;
	bh=Xk1LmFLX5Cl0DbFiAm5KSvHGT3yyHRmzLUqdYfSZWRA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HcH+8UzmjhzKqa7sE9Q0KPRbMbabENS8ujrs5gQUcgoPPQhVHvYOLJ4VwCy3wRGgd6xX39zgt1ohxJRTVnKmW7ECkuaekUX3n961rb13JiY4gIGFrn5HTv7+ToqVkyRJ00c1JJQrBTeXfng65nBQZhWq1RZNkHcThp2C5jLLCBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YV+tslAY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732799357; x=1764335357;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=Xk1LmFLX5Cl0DbFiAm5KSvHGT3yyHRmzLUqdYfSZWRA=;
  b=YV+tslAY0/GMAr49fk2ch03j1oZmKvmkW/jcuLFLOVFO9xrbHKlcXOcc
   FabO89JKGym+GgV97ZXuTbJE3SFM0VydgcomFrUWgaLvO+TVU5RvysRYG
   Q7rdiAk0I77EUn66hjE6AMEWO5hINiSoVs1HKBM/S6anpSh72OemC7UlI
   qUHa/mP8+5E5AA5JP1jQE1PoefvTUnNk127EuCLw3KDBw7vbR6UHdrYUQ
   GUoMf+U3qiM/rcBTDj9TEZUEOUUWQN/pGP+jGko/BiHBf7zDs0u0Mzkak
   83UBX/LLQ8X0EAY8m1OmuI+g6K4spp5N577hU0xf1BJzmBkdOzfSAl/m0
   w==;
X-CSE-ConnectionGUID: qWbxjp+uQXy5Ez81ifYrPg==
X-CSE-MsgGUID: FdQNLiLqQPK/4NvgdzzO0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="43519450"
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="43519450"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 05:09:17 -0800
X-CSE-ConnectionGUID: qyCBTyI1R9CQbjOQZD9L+A==
X-CSE-MsgGUID: QZU2cjE+TfKz4Iv/iy1uCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="92104746"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 28 Nov 2024 05:09:15 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGeGf-0009bH-1c;
	Thu, 28 Nov 2024 13:09:13 +0000
Date: Thu, 28 Nov 2024 21:09:05 +0800
From: kernel test robot <lkp@intel.com>
To: Cosmin Tanislav <demonsingur@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3] regmap: detach regmap from dev on regmap_exit
Message-ID: <Z0hrccgbyS6ZQWqe@137e00dabd5e>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128130554.362486-1-demonsingur@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v3] regmap: detach regmap from dev on regmap_exit
Link: https://lore.kernel.org/stable/20241128130554.362486-1-demonsingur%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




