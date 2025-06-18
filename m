Return-Path: <stable+bounces-154705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14D2ADF741
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 21:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF6F4A3982
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 19:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF9221B9D8;
	Wed, 18 Jun 2025 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fWvdLZ6j"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933F521B1BC
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750276283; cv=none; b=R2MBYdLeUoXv/kXreeOVv3McSlXsOMDrl6w3YLKWcAIHeGGC/H+65p3r4i3ZE5cGoHjkG0oDIe224oguZgGQwPrlp0Ug2ycJao8OMLFYP6BgnChyNmBnr6aPiqMDLTdoviHu/rpdkAu2Ny4bzf6GWE2N8tEi8/4W8k6mzpSdLNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750276283; c=relaxed/simple;
	bh=UTLZOaZ2JeTEzlyrHZPOY39LJCB2vtCfCzaXCGwQODg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iVTbtKWI5LHG+rHg5aDujIEhfUJMSotIHdNnM0nN4/VXK5K7pgPdGT/DusB0efH2SpsVajCc2YewI4BsaNaVLEzJ/9F+bZvb10pvRaJebj9l2U7l9VaypWkUeKzuBNVCWIE4XytskxMaJUEFKAjKQKHhWwQDWwHnWKPldeHv5mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fWvdLZ6j; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750276281; x=1781812281;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=UTLZOaZ2JeTEzlyrHZPOY39LJCB2vtCfCzaXCGwQODg=;
  b=fWvdLZ6jNDHJrPdIX/JYwi3nTeCY7GtjSBkgSM+HUnLPYm9dRVviAild
   1mEe31uQMCDfGV9VtYjyje883VzXT64y8YRoJF/dXxEHhk530oZ7IeC8y
   hoAic1SnboG4UFklHGJQFrt7lj4i7VHaGLyqpOh5uoZJEaA5VGK7C+lPH
   p98S2Cc3C+jPHzFZozDnbXBOWY+PsxRAe2TKC/ltsZKQZW221LZcrQLCX
   MNDgkVlyTRrRqMm75tCdF0xjI7QjCBRv8Qdi+P0X6s84Wkb4jIMDnnZ7o
   aNz2lr61t0NQUBsrNabQOj7bkfactcqg9fLZMF+Zz9WTmHhWdF4vb50Uq
   Q==;
X-CSE-ConnectionGUID: ZgMys77dQo+ptbEdcT1WeQ==
X-CSE-MsgGUID: hm7aAITsQ6SohNK3BDNE2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="51744067"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="51744067"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 12:51:20 -0700
X-CSE-ConnectionGUID: 7/u56lu+QlK3H4t39ukVKg==
X-CSE-MsgGUID: pOMyiV4mQzC70tds7f35Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="149720080"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.161])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 12:51:18 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, suraj.kandpal@intel.com,
 stable@vger.kernel.org, Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: Re: [PATCH 0/2] Fixes in snps-phy HDMI PLL algorithm
In-Reply-To: <20250618130951.1596587-1-ankit.k.nautiyal@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250618130951.1596587-1-ankit.k.nautiyal@intel.com>
Date: Wed, 18 Jun 2025 22:51:15 +0300
Message-ID: <2e0169d6e2d533e4b0175937961d91ae8da4799e@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 18 Jun 2025, Ankit Nautiyal <ankit.k.nautiyal@intel.com> wrote:
> Fixes/improvement in snps-phy HDMI PLL algorithm.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

>
> Ankit Nautiyal (2):
>   drm/i915/snps_hdmi_pll: Fix 64-bit divisor truncation by using
>     div64_u64
>   drm/i915/snps_hdmi_pll: Use clamp() instead of max(min())
>
>  drivers/gpu/drm/i915/display/intel_snps_hdmi_pll.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

-- 
Jani Nikula, Intel

