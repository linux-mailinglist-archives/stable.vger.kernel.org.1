Return-Path: <stable+bounces-154673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B74D1ADEDB4
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 15:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F81F188C529
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 13:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AB6274FC2;
	Wed, 18 Jun 2025 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mrO1Xm61"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123F62E8DF7
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750252910; cv=none; b=at/qMtAPfThLxeVOnyVPiuOEXe3khIbD4RSdqt5XXpoLG7ktoAS6UhUZrD8PrdKXjkrd/L+tXLLFqSsxT5xq9na/5dbMp1BVXp7eHyXZGfSHco9+jNb9U+H/HB7xWH8wJsIWt6mruKJLaF970R/Y/5w2Bi4fb8/weHHjpA/Wu5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750252910; c=relaxed/simple;
	bh=RwNO66zeuarIR50f5lkI8wvvb1onf0eDqTgIb2LGNww=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=M6RKttr2Z9P7HWA6K07e+z4cMnvO2a6x+AP2BSFyARWj/kO+zBqIy4dMo2649nvKigOvhNx+W8yCTMI06CsQpJcad6zYI7mfeftexc7QAKYCJ/NfRF7RuicrzKPv125TaYY8H8UXc3TJEE29Baa/QZhJjSIUMl2JDZli/rQKEw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mrO1Xm61; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750252909; x=1781788909;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=RwNO66zeuarIR50f5lkI8wvvb1onf0eDqTgIb2LGNww=;
  b=mrO1Xm61F9el+C3mh1ZM7CofOhhZk36HAIDHuEF1NDc0OhEYgq+k+cie
   4hyHWhiyyb49Ifh8fpAi5DtTRWugRzIQxkkznIZ3x4Xm8x8A6V+JTu7gJ
   EQXUkjjt9Hlr6N4P62Maxnfnvcp0leCma5iofvMTN0NvRzGO+7Yu6LLTR
   mpKlRy1JCsxdvKae4/sXLWPnUEGrgPCuMPNXxFQcA8FqB4IA5Tq6yb6uc
   czkUaOC0w97DJyYxvOM7W6/IRcvWkRfIsY7TYjIuJXFOS1SQzcAL/QuV6
   BGu+vqqhD+US+j613c9bnv2ufW8uxanhFu6EDWWUZICJtjjrLLDGwpLEy
   w==;
X-CSE-ConnectionGUID: 7McQsXJNRsKWC2u7of6NUQ==
X-CSE-MsgGUID: FUbMfKIMSFydszfelisifA==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52389536"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="52389536"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 06:21:48 -0700
X-CSE-ConnectionGUID: ZOQbAmVZTNaSi/JbF39AjA==
X-CSE-MsgGUID: 2DR7lx1wShWiBkDqXpMqrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="149361029"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 18 Jun 2025 06:21:47 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uRsjY-000JoQ-2X;
	Wed, 18 Jun 2025 13:21:44 +0000
Date: Wed, 18 Jun 2025 21:21:27 +0800
From: kernel test robot <lkp@intel.com>
To: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] drm/i915/snps_hdmi_pll: Use clamp() instead of
 max(min())
Message-ID: <aFK9V7_jQE9aExj9@d8702eadd420>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618130951.1596587-3-ankit.k.nautiyal@intel.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 2/2] drm/i915/snps_hdmi_pll: Use clamp() instead of max(min())
Link: https://lore.kernel.org/stable/20250618130951.1596587-3-ankit.k.nautiyal%40intel.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




