Return-Path: <stable+bounces-60736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F46939C4E
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 10:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB0431F22BE7
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 08:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B054D14C585;
	Tue, 23 Jul 2024 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLeiq4/M"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB17614C584
	for <stable@vger.kernel.org>; Tue, 23 Jul 2024 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721722345; cv=none; b=OawUv2CvgzUjdKcWVgL2+Y3UIILBP9olmIZZrP/AcjUUQZFvdtjMX+atEQpuap9I5EmFv3kDLBNI/ksr1kCOMCTisvIdyDvzikDPJyn37bhSFMhJeRsSx0+IJWbQmrbUzVGxDBKhkeUULk6JPfozAMLQeNuqkpauIoQsgS3W8HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721722345; c=relaxed/simple;
	bh=xx8lAIbvFgZoQgFku36sv/oYjzeQjnJ/n7waI+BikxU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TZ0PzYqLifU6QuPKF5CRusnGw50V2xxL7G3uh/T1on1InNN8/LDYSwQM/oVNnEwzSD3vW0Ju6ey+UELCl4alscU2Lv3jSs0uY0jJQs4RUbgyCJ44Wqe5sGn3mM1JfFxENUqLGU7A4jgFv7ZC1r3a0kAK/PdEBwmKMmyjDUqSkgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bLeiq4/M; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721722343; x=1753258343;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=xx8lAIbvFgZoQgFku36sv/oYjzeQjnJ/n7waI+BikxU=;
  b=bLeiq4/MwVU0AzapSXs+Diau5mj9xELf/0yiZTVtD2tN/0BCvheKKLNS
   vbeiBzrihpds9Gv4BOna0g5pu5jZr0LiPAcworKmXOXvkLAF5kglm7wq0
   C6euCcvowurSiE1WwMVcd7mUQUQqpoRpDA3Xp2fhY5Oiz6R0iPynZVndR
   40CCkZVF4VPvGXDlE4UTBHAAlOXnoJLMM4U85U7LJ3zEWgcTtbN/Ji6Mn
   d3IdIeoyEmBAsj878MX6QHhyIhwaFHfZBzi+wg+vgXmad8+oHOK63cX7d
   70AYOliBufaZK7tiXBIKMPsIN2QmoZGCgP+FkT1u8c4J7Iyeswl29IszO
   g==;
X-CSE-ConnectionGUID: wPE9dwHhTIGw8AScjz0MMA==
X-CSE-MsgGUID: XzfM0r9mRyqu3dv886LygA==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="36774305"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="36774305"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 01:12:22 -0700
X-CSE-ConnectionGUID: d6HQ3ppdQ3CpVm0iSUno2g==
X-CSE-MsgGUID: wP5dXzF3Qqmnd1Jvw6mW3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="52221132"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 23 Jul 2024 01:12:21 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWAd9-000llc-0X;
	Tue, 23 Jul 2024 08:12:19 +0000
Date: Tue, 23 Jul 2024 16:11:21 +0800
From: kernel test robot <lkp@intel.com>
To: Qingqing Zhou <quic_qqzhou@quicinc.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] arm64: dts: qcom: sa8775p: Mark APPS and PCIe SMMUs
 as DMA coherent
Message-ID: <Zp9lqWXhShgZkces@6724a33121ae>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723075948.9545-1-quic_qqzhou@quicinc.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] arm64: dts: qcom: sa8775p: Mark APPS and PCIe SMMUs as DMA coherent
Link: https://lore.kernel.org/stable/20240723075948.9545-1-quic_qqzhou%40quicinc.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




