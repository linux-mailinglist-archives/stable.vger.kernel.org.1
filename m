Return-Path: <stable+bounces-98300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE8B9E3D02
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 15:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECC1A1638A1
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 14:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582C620A5D9;
	Wed,  4 Dec 2024 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y4FMXz+H"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B06209F5B
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733323399; cv=none; b=cNttQVBOl6lHpTpkuTsoQDjJ5p2Y99oIHDstiqHRLHxTpjg0x9C8OCMJA9ajO3WnWkHKE4Hfrh8POQlbJnrR2MFs9qvw0dj8NpR2ao09QRTl7wUtl7GY5Dy/GgbC9S8ZFlshxL8tWAjpg203q9scyPszXZ8t8uT1W5GvtHmptqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733323399; c=relaxed/simple;
	bh=XRDQJ3uJ35zN6R8kc7/26DL0yooR1NcyHn5Pmxt6jag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brwjXw0z71SDfl8dW//OjUnAgswzx0xS097ptbtb9QLQFQc3CE+OvwDHWdPo6NKyDSlK1b/WFQQYw+yCJ85+ts4q1lx/zRSO3+dvYJx1Us0gCoXDXfgiSpuWSNgm5nVLCQOXs2WB4kfwvmfgR16Vkhb7yL7HMODeyopiRasE//o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y4FMXz+H; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733323397; x=1764859397;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XRDQJ3uJ35zN6R8kc7/26DL0yooR1NcyHn5Pmxt6jag=;
  b=Y4FMXz+HPuKLkJ779BE2UlaKHBZb6PIaw2UYzkCyzUW/5pGI8ud7DFim
   bFmOmWkq5N5YbWqZ3HU8JkE2i38zRiyfGnvBuKbrD7Jyw5b9e+dOqKCnv
   oXEHR8JQ4ahZhrljTwQaPLVgnYi33ojFXB7drhFN3LyIRyr5KZ+wF3Bn/
   /fRBc/2boRvNWMCasEvXgghjQV/l/YTM2wPYqwZaeWWrZ1AAY2O43J7JL
   F/n/GZBZXnFU4n15ZnV31c0l+L3IB9Yp9es/4LuqZWx76knTz04m6JWrc
   yt2ra+WRjTtFfXtXzhphoGk8IfJqv8OFdr0dryu9JwUrOTUm3WcTRIt24
   A==;
X-CSE-ConnectionGUID: BfEG2ezmSMSgJU5EnQgsuQ==
X-CSE-MsgGUID: TFGFd2s7S6KbLEdlBs0TrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="44984477"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="44984477"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 06:43:16 -0800
X-CSE-ConnectionGUID: N7iyW4ZpSymDoMrssnhieQ==
X-CSE-MsgGUID: Xso6M9BuS/OxRImf2CLMNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="131235692"
Received: from slindbla-desk.ger.corp.intel.com (HELO intel.com) ([10.245.246.225])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 06:43:14 -0800
Date: Wed, 4 Dec 2024 15:43:09 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Eugene Kobyak <eugene.kobyak@intel.com>
Cc: intel-gfx@lists.freedesktop.org, John.C.Harrison@intel.com,
	andi.shyti@linux.intel.com, jani.nikula@linux.intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v6] drm/i915: Fix NULL pointer dereference in
 capture_engine
Message-ID: <Z1BqfTErA4t9L7Tc@ashyti-mobl2.lan>
References: <xmsgfynkhycw3cf56akp4he2ffg44vuratocsysaowbsnhutzi@augnqbm777at>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmsgfynkhycw3cf56akp4he2ffg44vuratocsysaowbsnhutzi@augnqbm777at>

Hi Eugene,

On Tue, Dec 03, 2024 at 02:54:06PM +0000, Eugene Kobyak wrote:
> When the intel_context structure contains NULL,
> it raises a NULL pointer dereference error in drm_info().
> 
> Fixes: e8a3319c31a1 ("drm/i915: Allow error capture without a request")
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/12309
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> Cc: John Harrison <John.C.Harrison@Intel.com>
> Cc: <stable@vger.kernel.org> # v6.3+
> Signed-off-by: Eugene Kobyak <eugene.kobyak@intel.com>

merged to drm-intel-next.

Thank you,
Andi

