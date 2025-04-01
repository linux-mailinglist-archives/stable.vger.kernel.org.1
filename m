Return-Path: <stable+bounces-127348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F54A7818E
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 19:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B43C1667A2
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 17:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793A0209F31;
	Tue,  1 Apr 2025 17:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jwGErzgl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E81C20C016
	for <stable@vger.kernel.org>; Tue,  1 Apr 2025 17:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743528858; cv=none; b=PNgWJxexNt4cwF0+YMITpuKCIS7hyx4QjXzMZlVSHnjRUEHO+Y1AI7hGp0O7SE0z2cqQiHr6tfHSQFbkmAXwI1K/v/C0jSO+kI5C0OyfkaMA8ns3sUUHFiBXZqBdvz9LnqJso/qY+1BrWPxP/B3BolXKAfvSTgFUP3sZVxawrYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743528858; c=relaxed/simple;
	bh=271T6Tt2WB/NC5oosgLSmUTNNvXmvPhHIC6gsMI1SOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CunnHYfjH3ylbKCShgS7J/EPa8y8xTir1DwvbhTw736Il/55cVRZasBYRW2VW1bys5a0MKvLVUgh+WJMV9s/Wm/5I6Otp6lsx6H7Ae++PSgD4gP1BbyhnEMqHmvtWMVbMPD7Tv9dYEkwaO2DyfRjPJbEqoJLyLAsjEwLzE9KMI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jwGErzgl; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743528857; x=1775064857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=271T6Tt2WB/NC5oosgLSmUTNNvXmvPhHIC6gsMI1SOo=;
  b=jwGErzglwDN/KqkARkfQsNjgxEG9ej780937yLavVA6M5OrJzQO//rSY
   nPR+njue9Ze/fsfdnNwEQf/3R8+sW3b/B3RV6SUrzKgj7zJgAki8lcJE5
   TDbFFtoRE4ZGWYUB/RtOpeB26Bp4N0P55L0NJ5i5UcSlIrs940s0Dcjr8
   SDp+3PXVAzTMY12er5KebZ9vbwQjLQVgm8xm26n+EoyiYut2/QgWl6o9z
   R2t0CXzGI0nnOjwPF7ebYMhcM+pNQNhioaHYaLMwFERSwziLaEOb2H0Bo
   W4HqcILofr0ib6XNf4AIuKyzT7HQ52DZZCCFfCd5QAV/mmvw4YANnvTAX
   Q==;
X-CSE-ConnectionGUID: 4ehkK+oUTH2FIqJS6mkD9g==
X-CSE-MsgGUID: vCQzeL5/Qn2DMEV2/qqCBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="44118630"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="44118630"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 10:34:16 -0700
X-CSE-ConnectionGUID: I91eMb71SBWDaDgI1ZYf+g==
X-CSE-MsgGUID: ek8a9ItnTUaq4mmxORw5zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="127358999"
Received: from ettammin-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.184])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 10:34:13 -0700
Date: Tue, 1 Apr 2025 19:34:11 +0200
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, stable@vger.kernel.org,
	Matthew Auld <matthew.auld@intel.com>,
	Thomas =?iso-8859-15?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 3/4] drm/i915/gem: Allow EXEC_CAPTURE on recoverable
 contexts on DG1
Message-ID: <Z-wjk-9ZVEpBVw0G@ashyti-mobl2.lan>
References: <20250401163752.6412-1-ville.syrjala@linux.intel.com>
 <20250401163752.6412-4-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401163752.6412-4-ville.syrjala@linux.intel.com>

Hi Ville,

On Tue, Apr 01, 2025 at 07:37:51PM +0300, Ville Syrjala wrote:
> The intel-media-driver is currently broken on DG1 because
> it uses EXEC_CAPTURE with recovarable contexts. Relax the
> check to allow that.
> 
> I've also submitted a fix for the intel-media-driver:
> https://github.com/intel/media-driver/pull/1920

...

>  		if (i915_gem_context_is_recoverable(eb->gem_context) &&
> -		    (IS_DGFX(eb->i915) || GRAPHICS_VER_FULL(eb->i915) > IP_VER(12, 0)))
> +		    GRAPHICS_VER_FULL(eb->i915) > IP_VER(12, 10))

How is this is more relaxed than the old version?

Andi

