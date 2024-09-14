Return-Path: <stable+bounces-76144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B87F9791E7
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 17:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F2E1F22805
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 15:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9D51D0483;
	Sat, 14 Sep 2024 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZlZRJ4P"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87721D0170
	for <stable@vger.kernel.org>; Sat, 14 Sep 2024 15:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726328889; cv=none; b=k8RuAUH0ZkSSCApe+adqrh59BsMnyJsDMnxQtTrvHBFxaMHPPUqzxkBqkL93PqBJGLkFP0KgyH6+1kC/npv5HzXT2xBObd5CYnMeHsfBl903p6MrOf1Yx2M4ESfyWFICJWSwHMoCImrghx0yaVIzRpz0V9x3oyWe929WA33jb9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726328889; c=relaxed/simple;
	bh=2GjI8rpV1PO0SHIF2lcxxiDXsIoOLM0bA4uc8zLiIK0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jQTZwoJTuQhu31TcaBMCdFEmlVFp/x/ylYGSuUnPX9kij1M3mGgySLbkiwiH/rwlWt/mZvyqzdbDYdxuZtW+3czO7/nqlXd/bxovE40ld3POhVGmIg+8K3MjwjNqdqR9HqDI2MoJH6lrhMk6UNWA2awKJBz9IE1o0lF8TBXo3aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZlZRJ4P; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726328888; x=1757864888;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=2GjI8rpV1PO0SHIF2lcxxiDXsIoOLM0bA4uc8zLiIK0=;
  b=kZlZRJ4PPQKhvosAzhwW9lUYhGYwW0eF3/m1I5l4+8EIN+IcP21xZ0NQ
   VqB6Z7Pc7Ymt9VwxIB1ct5kgKKsrMgnAO/ComdjwYokE1ScmcOpbE0jKA
   J0nuSg7ALUUczvN8V1kuBOtC2aclc5YoBESxU0s3bA/FzSUg66IVAlUjR
   8vOUPSf+a60Ihtcn3Uri4xS3PaMEU6Iw11UICnzRJBaSmMw/w7OmP2SVp
   tfsezLMCzQ0ju+4UajXJFM2qzKL/R/b2UuIqFTyayvcObXhyElB0AhH1w
   Hh9JhryBnYdIEAsBmMNOCsJ3/4q94xVtgRGy5PJqMuRAhE6PGHLz+RGpA
   g==;
X-CSE-ConnectionGUID: 5xv5XBfFQxSzsDMss/vOhg==
X-CSE-MsgGUID: 0K6woIExRIazYChO9AWD4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="25155919"
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="25155919"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2024 08:48:07 -0700
X-CSE-ConnectionGUID: f/iOIJOOSiq7TgguR7dMcg==
X-CSE-MsgGUID: vYDx/JAER3CwP8hdQFp/Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="99097242"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 14 Sep 2024 08:48:07 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spV0F-0007u2-3B;
	Sat, 14 Sep 2024 15:48:03 +0000
Date: Sat, 14 Sep 2024 23:47:17 +0800
From: kernel test robot <lkp@intel.com>
To: Kaixin Wang <kxwang23@m.fudan.edu.cn>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] i3c: master: svc: Fix use after free vulnerability in
 svc_i3c_master Driver Due to Race Condition
Message-ID: <ZuWwBbQJXOcczyfG@452932c7ae73>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240914154030.180-1-kxwang23@m.fudan.edu.cn>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] i3c: master: svc: Fix use after free vulnerability in svc_i3c_master Driver Due to Race Condition
Link: https://lore.kernel.org/stable/20240914154030.180-1-kxwang23%40m.fudan.edu.cn

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




