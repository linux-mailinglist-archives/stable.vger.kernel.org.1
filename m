Return-Path: <stable+bounces-166779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C16B1D886
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 15:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8EC3A3653
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 13:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E13256C6F;
	Thu,  7 Aug 2025 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="atXwAGoK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BF423816E
	for <stable@vger.kernel.org>; Thu,  7 Aug 2025 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754571923; cv=none; b=cjh6YFiM4JPXE5Ri233JSz+n/MlUgUT3S6mkiiR7pJNK3yg0I3mF0tzIPJqru+Eloa5dULQVmryV2lCf/0yylbua4QQNkDK/+HQJ1W1mZvhvnjLbsQ7ZkRbx0/HVutlEdgHpKIWYqFdmFqDQ+3YwsKv4toTJuHlLVa/vRLDTlJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754571923; c=relaxed/simple;
	bh=oZKi+QW2Pua0PySDPHps8ArHznLnPyJsjq2Yf+e+9js=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=opDwOWKtwoSxzV19JvNQq59XKBEc7RyP2jif3CdoWYts9CtWldvIadOP1W2hyT3kBVkAbv9JcDrn+4B507aVrMl0jJO+7UWkXS2BWYtlKn6rDp23Kf1ylTmCX7yezfFre2dwvSLIxUU4O59CevIMwTCsZBHU1IxsvOMTS6Bxn1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=atXwAGoK; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754571922; x=1786107922;
  h=from:to:subject:in-reply-to:references:date:message-id:
   mime-version;
  bh=oZKi+QW2Pua0PySDPHps8ArHznLnPyJsjq2Yf+e+9js=;
  b=atXwAGoKw0pwMiua1fbh0CNhhFURWrPnfB3AmkCcoS1w77dixubjM1jG
   cq2g75bv/PuBkUSN9zQjS0cSMt08545lEqJ23yCAWo8ZHTLxR8TfMsCVr
   h+l4l5iSmtsEBvGavdA4gc27qFLt8nNQ+wQUNdL3hxabJYP/5U4a03tG6
   bmp9JWFFnVWAGDFhWcqNAVR//H2RmCFzIp/fWF3YPH1fCKpER4m86Dg5j
   EQK+eZvk+Bw/8Kx1vn+edf+f2kOOCnQg6Fsx0JVqTxvt/3UhHs8fwaVJA
   HsqZdVC3HNpxcd8HBljwgvYM05EKlEqSGXZn+7xQy7ZrK7SfKQto1Dju+
   w==;
X-CSE-ConnectionGUID: n4CtLoZKQOGHSEvM+RpJOA==
X-CSE-MsgGUID: o0tcdtC0ST+j9k+ucz5zGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56869508"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="56869508"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 06:05:20 -0700
X-CSE-ConnectionGUID: LU6BV1d4RVCQ8RQtJlMr7g==
X-CSE-MsgGUID: MiYnhfNbSUejuYkKWQCu/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="170318684"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.96])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 06:05:17 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: imre.deak@intel.com, Luca Coelho <luca@coelho.fi>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 stable@vger.kernel.org, Charlton Lin <charlton.lin@intel.com>, Khaled
 Almahallawy <khaled.almahallawy@intel.com>
Subject: Re: [PATCH 01/19] drm/i915/lnl+/tc: Fix handling of an
 enabled/disconnected dp-alt sink
In-Reply-To: <aJShB9ufOBH9AWLY@ideak-desk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250805073700.642107-1-imre.deak@intel.com>
 <20250805073700.642107-2-imre.deak@intel.com>
 <95999d2602067f556dc2e5739758deef7c462e17.camel@coelho.fi>
 <aJSQKu72vVYmUd4Y@ideak-desk>
 <d8e9cabb243cd8bbe7ac942d117146bf7f68b631@intel.com>
 <aJSc9UaVwn132FqX@ideak-desk> <aJShB9ufOBH9AWLY@ideak-desk>
Date: Thu, 07 Aug 2025 16:05:14 +0300
Message-ID: <b8c6a347154b3ad39045c9fd2b805b522609f442@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 07 Aug 2025, Imre Deak <imre.deak@intel.com> wrote:
> Would you be ok with
>
> tc_phy_owned_by_display()

Sounds good to me. Maybe add a brief comment "Is the PHY in legacy or
DP-alt mode" or something above the function.

BR,
Jani.


-- 
Jani Nikula, Intel

