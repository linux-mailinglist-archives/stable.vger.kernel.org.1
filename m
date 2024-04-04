Return-Path: <stable+bounces-35930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BCA898940
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 15:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA272838D9
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 13:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216A6128385;
	Thu,  4 Apr 2024 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKF/TXCr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CDD18AF6
	for <stable@vger.kernel.org>; Thu,  4 Apr 2024 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712238759; cv=none; b=Hs7lfZJScVdaJEXM76uiH1qi6ifKE0DWcjbD5Vf3rvQisOEQWyYMPmlrVofi7C725OUJRhkbH5Hysd4IFKP9IjhwnGfMaUnxCH97yyoNz1CFX/lsE7X9pwxqVhUGTFv7zrl6JiofDe0wsZK3aewE3YnPOHJWtgn2EjNGHrCsD3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712238759; c=relaxed/simple;
	bh=ir2RpPBcr5kNfpYbEVWyFv+HfUO7vw2TRu07cRbMxak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJc84czqRknGMA5bYF/yHCtm0th57JS1jy7B+bCrYG9V/qxsDt+OwzNQySfoSTNVwzJIODo/TOcRPNLSI0ItaXUoMjgL8eIV6U8CzfoNex1wrXdz4W4Fee4VoMjf7Bu/uRNtzjmj7r0WejJYqwR6iY72VlTl6/VZGo5JT/JIjyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NKF/TXCr; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712238758; x=1743774758;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=ir2RpPBcr5kNfpYbEVWyFv+HfUO7vw2TRu07cRbMxak=;
  b=NKF/TXCrO0Wcbttd+doWWoR8INljEW+pERWZvIIMd+UX14dS7Wv0F9Fg
   iqSSfveU7l9/7Ge9l/acJm5Qo6C3uKMuxO3/aMgieVQkxb82yJPy0K2OS
   WdbBmGUqbt9G2DbphwI4KUFDM2Md4+Jbhlr0wT+92ShDGzCILcP+3C+Qw
   NDGXwiSNz9urLNOO5s7KjESF37rsxMNNZWSCH4hL/GEaQJvZYEDiRgZaC
   L4aaa9jXqpf2S8OOBPI0TeYVTugfyQszVlCbiCee5HUaGsN3FRX9oi02t
   v+SO3LOJMofyyS8HYWsr7m2F1R2TVCfoH1HXLNDcY7UUyuIGUSs/InLyN
   Q==;
X-CSE-ConnectionGUID: 3WLQC3cDRhqTYgEbtUurGw==
X-CSE-MsgGUID: 9Qh9/0eKS3y4Zv4cVKAHNg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="24972855"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="24972855"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 06:52:37 -0700
X-CSE-ConnectionGUID: VdvDI+otRGe3/tsUEqBWuA==
X-CSE-MsgGUID: IymS3cigSMyma9UbsaUwng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23286501"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 06:52:36 -0700
Date: Thu, 4 Apr 2024 16:53:07 +0300
From: Imre Deak <imre.deak@intel.com>
To: stable@vger.kernel.org, intel-gfx@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: v6.8 stable backport request for drm/i915
Message-ID: <Zg6ww+JomUKR//nh@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <Zg6rIG0idN3NSTbP@ideak-desk.fi.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg6rIG0idN3NSTbP@ideak-desk.fi.intel.com>

On Thu, Apr 04, 2024 at 04:29:04PM +0300, Imre Deak wrote:
> Stable team, please backport the following upstream commit to 6.8:
> 
> commit 7a51a2aa2384 ("drm/i915/dp: Fix DSC state HW readout for SST connectors")

Just noticed that the above commit is not yet upstream, still only
queued in drm-intel-next. I presumed patches will be cherry-picked from
drm-intel-next to drm-intel-fixes based on the Fixes: tag, so I only
pushed the above patch to drm-intel-next; maybe the cherry picking
doesn't (always) happen automatically.

> Thanks,
> Imre

