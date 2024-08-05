Return-Path: <stable+bounces-65460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67931948544
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 00:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912211C21CDF
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 22:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B59A155351;
	Mon,  5 Aug 2024 22:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mt0eA8uO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4844D14B06C
	for <stable@vger.kernel.org>; Mon,  5 Aug 2024 22:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722895532; cv=none; b=tFJc/p+6pi+UXCDb0PbBDD/vUfnaZNH22wnhmmnnNEXkO1vcS15Nza+Tp74jswmBDVYju1EHMKknLiyG0LHrxptkf6+Pepo/XtfV6AJEMyigFjOjdnsOYBem0dCMk+6eBnadkwboGF5YjMEufIuaxcfia8pr5LHa9bMExu1tX3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722895532; c=relaxed/simple;
	bh=ZD14Eo0suUZ0QIzkvHNR5rVSu5F4tZx+GiFNaMloX0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEaNeeo7NpOfhC9WFdtag8m/5NNoNP/ie5+lfi4SSTlLuByRyLHLiO7z28m2vIp+tyGZfLYn02deEanvnYXLhC8bet8BIuut3ffScYp/DmVYLjtTTGbhcA+syyNv62DB9sU7uOs+krAMf6yZGy9F1gyWDL0F5GiTe9d5+M97Fms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mt0eA8uO; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722895531; x=1754431531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZD14Eo0suUZ0QIzkvHNR5rVSu5F4tZx+GiFNaMloX0w=;
  b=Mt0eA8uOttHADHEvRjKcy8lW8XLV7jKWitm84AJOINrdCTc2WHHv2ohU
   91+1gHJsnRr0g6NrAh8BX641u2LPVUXpBJGrNCe0emKU2K2FAzMx2gTjx
   1Cw+9LDrZiGkS0L4sHPQ54A5LUAWXT4+PoVAOpCVA0Kit8k3mPda0ainj
   UBDHMdcx+ez15quoyAzmlpHdvBQV+KAfLPdGNsFU6f9gHrS+lL1YovW62
   HuSzm9edi8q6KRYLIrO3RED5RI4MDP2RuNC+g5ZOMCPemweCE4U0itMUP
   IoDNTsaaZiNIv3yhwif9NWSVJZS5MWvLaXihMZl836UXBH5pOcM9wZ/hA
   A==;
X-CSE-ConnectionGUID: PuEc3VYWQCqXWr79Yc3QbA==
X-CSE-MsgGUID: 93aQ6BoPRre9Y4jCWN7Z3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="43412701"
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="43412701"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 15:05:31 -0700
X-CSE-ConnectionGUID: lJ16Q2MzSuePMsvgjCL0zQ==
X-CSE-MsgGUID: 1qoiBIVjR/SHwxlLjUalEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="60445817"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO intel.com) ([10.245.244.45])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 15:05:26 -0700
Date: Mon, 5 Aug 2024 23:05:22 +0100
From: Andi Shyti <andi.shyti@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>, stable@vger.kernel.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>, Jann Horn <jannh@google.com>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Krzysztof Niemiec <krzysztof.niemiec@intel.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH v2 0/2] Fix mmap memory boundary calculation
Message-ID: <ZrFMopcHlT6G7p3V@ashyti-mobl2.lan>
References: <20240805102554.154464-1-andi.shyti@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805102554.154464-1-andi.shyti@linux.intel.com>

Hi Greg,

> Andi Shyti (2):
>   drm/i915/gem: Adjust vma offset for framebuffer mmap offset
>   drm/i915/gem: Fix Virtual Memory mapping boundaries calculation

I have forgotten to Cc the stable mailing list here. These two
patches need to be merged together even if only the second patch
has the "Fixes:" tag.

Is there anything I should still do here?

I could have used the "Requires:" tag, but the commit id would
change in between merges and rebases.

Andi

