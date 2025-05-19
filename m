Return-Path: <stable+bounces-144862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5ECABBF58
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 15:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538C83B1632
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 13:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D742777E2;
	Mon, 19 May 2025 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lN/9gE8/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1343154BE2
	for <stable@vger.kernel.org>; Mon, 19 May 2025 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747661996; cv=none; b=EOc/HMGPnU69E4JBd9W3k8538gS/v7imvXly0oqfDyfkzrwU/gTsohzGCFIM8z9K9T6b9V82ic9hi+wcHHooyShJzcoyejCD99jRr/2oHB/pllYPmKoIy8yPGgGcf3+rgIqZ1Jv1aXmBvexRvo/qUHeY78tyMfWhoRLYQLfrrRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747661996; c=relaxed/simple;
	bh=p77BJ1A0XYXe1YK84cAeUqoR7zmC4AjZUO0nh+qjfIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m54ihHNpZS5LMaF8tFV8OCdHx/udJPrUGVuW1cEkT2LuVMdJBDXQCOi2DfjPbwuWFoof6pdthqXtUlsCg2gAfhJAVRHDXz5Z77zvpJU2iTWme9ZAMkJL+GiciV4usAwCMp4JZHqw4BqJ5DcceFR7P7cUNDBMmaOerd9ZUCzp39o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lN/9gE8/; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747661995; x=1779197995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p77BJ1A0XYXe1YK84cAeUqoR7zmC4AjZUO0nh+qjfIA=;
  b=lN/9gE8/MwgqmxoEHLQVQMyHCdCiT/7EbajFYhbEZNCr43SXhnv4WUvy
   GOOsI6m8PJmvnhbyTerGL5dd3jgGEQ065tWpBJv0W+zqS9Bfc+udvXhyy
   jvf0tQY+pg1QUVhEMO27N0Hb2+JVx9YdxO9jMBUatlm3BINkdKthV81bU
   oRsUFeHxJt2nBcHuiDz4tidJNRR53LoRRGn70LkUjwcORtz+4ql+oGlVG
   LhstimyTRYbZ0UFPHFJGJBvarzPiu6f6z9mX50zaTQJvm7RrNTSCc7U0u
   jqZ+ncaLSKEK8hc7mksmnIixC+d4/arQZwu+Owt9AWToJxtHooHCLurY1
   A==;
X-CSE-ConnectionGUID: 0dzHkgoTRuGlVLZL3k4gIA==
X-CSE-MsgGUID: GIhhfRuFRwSjtfkjxqiSAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="52194460"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="52194460"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 06:39:54 -0700
X-CSE-ConnectionGUID: 4tW6cBNJTlWFmnxRzdK/Pg==
X-CSE-MsgGUID: bvD2LyN0SuGnkTd2JnezaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139212719"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 19 May 2025 06:39:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 369B5256; Mon, 19 May 2025 16:39:51 +0300 (EEST)
Date: Mon, 19 May 2025 16:39:51 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Imre Deak <imre.deak@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/i915/dp_mst: Work around Thunderbolt sink
 disconnect after SINK_COUNT_ESI read
Message-ID: <20250519133951.GD88033@black.fi.intel.com>
References: <20250516170946.1313722-1-imre.deak@intel.com>
 <20250519133417.1469181-1-imre.deak@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250519133417.1469181-1-imre.deak@intel.com>

On Mon, May 19, 2025 at 04:34:17PM +0300, Imre Deak wrote:
> Due to a problem in the iTBT DP-in adapter's firmware the sink on a TBT
> link may get disconnected inadvertently if the SINK_COUNT_ESI and the
> DP_LINK_SERVICE_IRQ_VECTOR_ESI0 registers are read in a single AUX
> transaction. Work around the issue by reading these registers in
> separate transactions.
> 
> The issue affects MTL+ platforms and will be fixed in the DP-in adapter
> firmware, however releasing that firmware fix may take some time and is
> not guaranteed to be available for all systems. Based on this apply the
> workaround on affected platforms.
> 
> See HSD #13013007775.
> 
> v2: Cc'ing Mika Westerberg.
> 
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/13760
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/14147
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

