Return-Path: <stable+bounces-155272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DD8AE333C
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 03:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E6D169785
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 01:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB1D8BEE;
	Mon, 23 Jun 2025 01:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZosGyPtb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F4AAD5A
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 01:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750641183; cv=none; b=FgQRgMAH+NblUu+AoMAyUKK6riIetfGzb4cRw060Lhr3j3f9MaeFdvn+Wa57ElnBQhlBMjl0V/CkoIsBIca5yx5zwPlyPIdyfQQddItDCA4Pw3guAcqO9DZqfjADp3Kp3FFab6hs8oCsj1rijl5eDDEq8815ZI4vRLIbvw5IYXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750641183; c=relaxed/simple;
	bh=C7sFeVQPcHhNAm4C+yucZSdrwMkLdpe6waABIOaF5uw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uV4PkTgnBlYnAqDMH0RAUbqjIojKwUiH6ETImZrsz7c0NbyTZm12zkIFi21U7XlObfMWv7Jdb8/LkSmtBRUW7VI4D/tLzzV+9rL0J5Y7bDcf0h5RHzqSHk3LFUPNyxEiAmkA+cSUP+FQ00BEyEActuvikTFkpJQf1X7esqisohg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZosGyPtb; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750641180; x=1782177180;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=C7sFeVQPcHhNAm4C+yucZSdrwMkLdpe6waABIOaF5uw=;
  b=ZosGyPtbmqouWARQYGO66Lxf7l/8yncMmoCAA+mbFa4zU+8DnUCDArcG
   XNMGAYfIb3bH+YZvItyv/VLsvz+T0RlKMq9kRET12BYHScj677hOIi0Yw
   QZiXZkxqtOQ6SgBlBKFgWjQ6Uq/n+zMU4RhXf/cEA2YAe90a4fRSj+3jY
   d77ayubLpR582Af3nGrfcqvAy+G3Xl7bP5xqJiW+iMHbnrxHba9er6CDC
   WBjObTvABFFYgAR4pa3jnW0nsQmllapzDuENvZcpYMG761aRvTGWJ77zt
   ZXuAfI3vnQU1v63EDKQCaI/Mbv2CVYo6eanLHV1WqDfUewwPxSMAUI786
   g==;
X-CSE-ConnectionGUID: vUkE0dc2Th2HW6UcS+3l8Q==
X-CSE-MsgGUID: rcZtliZvR7+iUuOiLX9tww==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52062130"
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="52062130"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 18:13:00 -0700
X-CSE-ConnectionGUID: 734vf1XaSCSD3RKCqQHR6g==
X-CSE-MsgGUID: nR7yXi61SzuHcfrNgvgzWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="156946049"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 22 Jun 2025 18:12:59 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uTVk0-000Nbu-2q;
	Mon, 23 Jun 2025 01:12:56 +0000
Date: Mon, 23 Jun 2025 09:12:21 +0800
From: kernel test robot <lkp@intel.com>
To: Simon Xue <xxm@rock-chips.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] iommu/rockchip: prevent iommus dead loop when two
 masters share one IOMMU
Message-ID: <aFip9aoMII64R2zZ@a8873d419552>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623010532.584409-1-xxm@rock-chips.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] iommu/rockchip: prevent iommus dead loop when two masters share one IOMMU
Link: https://lore.kernel.org/stable/20250623010532.584409-1-xxm%40rock-chips.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




