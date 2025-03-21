Return-Path: <stable+bounces-125716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5A3A6B215
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 01:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC3C18959D6
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 00:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E381172A;
	Fri, 21 Mar 2025 00:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+S2HePN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952461DFE1
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 00:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742516161; cv=none; b=nwt6RqbaZ8CUcfLC22ddJ0sfgNnEzyegPvX2+gtMvH3Z/Jg4lNV1KSaK772FV0fKPOEPPh6hAGZu8o/bn4rvQtSCIbvMAKjKwLR4J0b6GV4QQOma5RXHCh7ZG1WuUc8iWzebaZyZMhnThJeX9MaYZOlpFiTmlnUDe77by6Flnjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742516161; c=relaxed/simple;
	bh=VKr2TgRBYWwY+2kKSu74dJIZlmZOs1W0q57N7bBa7fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lnt+uoOZddliDoWxBf5+zCom58dFG/SI5q003ghUnYCzlfwM6wVsVDNkoDX2eztG4MpJzGSLtRfvB1Hf3eSik5agfiaHi+0hjYSFK4UfR4NFTQRQaHc+CYyp1BITurnCRo4tYGcS0j43hSqEgB3ChU6EoG0/rbCFy4q9MMBXbxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+S2HePN; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742516159; x=1774052159;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=VKr2TgRBYWwY+2kKSu74dJIZlmZOs1W0q57N7bBa7fQ=;
  b=H+S2HePNRsjVf1b6/nlwe9h5AZ8DKNi051XmplWFdkUyoOXLZK7X588j
   JhXuKL6HKQNRo1tf/OiKvQWLKEMOLLQTG2dBrJ0vpO8TNYE3y1Oz02Ud3
   7xFqAXpWM9dzyhyUi+KHwYGx3OFYe6b0fI4obKsYkU/yfwyh2vn940tD6
   R/U7Tr5L3r8HlRu1nkko2OqXm5UEvy0lBSwAJiuG7qxm8IFFjGzVS6HPh
   hfCHWq7sPqrmquIsIbyM2Ne3ckFcHAqfgsI7kIPbOkslZiMi1QKZNqQOI
   M+A4qL9kPuDIzHUY+75ACu49E5w/jyHY8U9KlUwEoc3cAVo1hV0+gEmvs
   w==;
X-CSE-ConnectionGUID: TYZZneyXSlGxt5bWvkC6Fg==
X-CSE-MsgGUID: teS0uiAvQomiaCeduwBOCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43658534"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="43658534"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 17:15:59 -0700
X-CSE-ConnectionGUID: oV38ajqHQH6jpuKYQ5OFeQ==
X-CSE-MsgGUID: kOoUKp0JSdGQ0PbYdldnXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123236725"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 20 Mar 2025 17:15:59 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvQ3H-0000sx-2v;
	Fri, 21 Mar 2025 00:15:55 +0000
Date: Fri, 21 Mar 2025 08:15:29 +0800
From: kernel test robot <lkp@intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.12 v2 3/8] KVM: arm64: Remove host FPSIMD saving for
 non-protected KVM
Message-ID: <Z9yvoefQbnQxbOjT@b424d92f189e>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-stable-sve-6-12-v2-3-417ca2278d18@kernel.org>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 6.12 v2 3/8] KVM: arm64: Remove host FPSIMD saving for non-protected KVM
Link: https://lore.kernel.org/stable/20250321-stable-sve-6-12-v2-3-417ca2278d18%40kernel.org

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




