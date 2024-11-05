Return-Path: <stable+bounces-89818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E68E9BCB38
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 12:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6028B1C21042
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 11:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB1E1D1745;
	Tue,  5 Nov 2024 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fe2VPpYm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C56D1D27A9
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730804667; cv=none; b=qXCvLNl3QyMJpx3E+nx7ypVEf8mqpKzrnpA8p/VzLxpt2j/XUvM/DYmUm8cQ7S9We6b6/6H8vyoQRyvQPo6OKmlIpRQ79jA4Y93dD6hSWWwTzLm4tE4K5UFIrKTlv+8QlyFYSb2hXz0uupaDK2v2x6s3XGCqcSeR6GsHV71Bdn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730804667; c=relaxed/simple;
	bh=Am2HiPzi+5I2f+M71/t6uKwmLB+b8/k2z9KBQhH7mP0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YckNxwf0uohJXS9PBYY9jgK8fNnAhBc3oDRbfSkw2rwMrbCttqVeBcbxCesjiVhqUvLJ+Q8tdcjAJ4s44NsBPj5ISJ2BW+NiaSND++ImUUARSrDIv4StEy+lbhBXZy5ApfjuDt8znhuNrW/U0O27AhY8v1LfKZVGSxf6YaTMTgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fe2VPpYm; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730804665; x=1762340665;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=Am2HiPzi+5I2f+M71/t6uKwmLB+b8/k2z9KBQhH7mP0=;
  b=fe2VPpYmHaKxP/gV3TACuX/nV0yxiNjLYP9h6E8XV+fId55AZsjZPDoK
   nzmoJh9qp0J3/w5SchiM6tEna/8YVkzv+CuoQLPmnXhclSbJph36NzEQA
   plPojCm1+vv0ueZjZOWVh+FiUCEH4F4jLWoNDBlXcKSwhILqHdU+qhU86
   PbJDDAuPwqlIIFHEQKU+RSrzkXMCUtPHyAi1/D38NSLY6XnmJsncMq3uZ
   NjLvTVeeyJJBSomYYKVEPGQUq03WoI8Qm3r3FfluEHPknzDFp5xxus88k
   GsVoYDPl2LQHqgb/sjYPykvPe4QnE2x4wu8MOZiNRISs3qfm87iGgkOXQ
   A==;
X-CSE-ConnectionGUID: FnvAt0+MQUa2DMxv8j/bdQ==
X-CSE-MsgGUID: MveEIALvRYONcQvkjZhOFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30395527"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30395527"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 03:04:25 -0800
X-CSE-ConnectionGUID: FJUef2OISV2dnsaUOCra6w==
X-CSE-MsgGUID: it7xsxM/R0KIQpA7Bhg9Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="114758634"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 05 Nov 2024 03:04:24 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8HMD-000lwp-14;
	Tue, 05 Nov 2024 11:04:21 +0000
Date: Tue, 5 Nov 2024 19:03:57 +0800
From: kernel test robot <lkp@intel.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/2] drm: adv7511: Fix use-after-free in
 adv7533_attach_dsi()
Message-ID: <Zyn7ndiHqU80Froa@7f78dee4e976>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105110236.112631-2-biju.das.jz@bp.renesas.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 1/2] drm: adv7511: Fix use-after-free in adv7533_attach_dsi()
Link: https://lore.kernel.org/stable/20241105110236.112631-2-biju.das.jz%40bp.renesas.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




