Return-Path: <stable+bounces-36156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B502789A5DD
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 22:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A2E1F21CD6
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 20:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E218174EDF;
	Fri,  5 Apr 2024 20:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RjJzB/D+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE16B1C36
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 20:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712350631; cv=none; b=gSsc31Y2ScAN11izwgW8WX71v42mOiwJuvkqAqHjjMpRjuwgfPt6hL/PqjjgtuncRpIXbiF3T6VRNrXNb+iAkvUpcLUZu72dgtpZQ33ElvB8qs8S76O47eynYcCYtPoWJX7g6Q4fiFHM/siLIwpO3nLwwJAenKTMafWWUYpDse8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712350631; c=relaxed/simple;
	bh=duwOo0fb7II8vWLfDLuFnG/5jNYOBJiTcFN/PE4MEZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzW74GZDvn6iFAHC1UVohcv2rkVwAt5fTm9Egn2wQLHFZVwcVwdYThZEQDP/tQ/lwdqaMq0V/yOMwNeSNv8Cz2OnVuROQwbBgndGsxHlsHtpbp8/LeqUf5ZpXgX27o9N1nhmJM8wogzWjMYT1zjOTrmtMnEOZi9ZvWDZmDCSuPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RjJzB/D+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712350630; x=1743886630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=duwOo0fb7II8vWLfDLuFnG/5jNYOBJiTcFN/PE4MEZ0=;
  b=RjJzB/D+OhAKjsYItajtGxowfek3Y83yKBPcPVlXgDYqfIBqVj2gjXFN
   JdsTL+h4JAJUd7QxE9tuAVq+5xZOtXu5O/xi+NE1qxGgE/7eG196DJTym
   /WNeQBE81yqx/kv4xG0CjgVoGhOgBpW1OKdCAQ3zldor0YgHF3Y3sS7gp
   j6EyT2dQ+0Tf8giY0AQfx1BfLFHqcyNshzMTEOj6W2khxoQr1i6kFF+t2
   e64cTzMfjzQukNBk+ZRVSsIAo0QMr06crvGX3JOqac0/BA2oIt6osPO7a
   +oHvHfJlag1y5WyYpLcwL0NRT2k2PqekEjEiz4NR4u3LOxc2gU0fBUJNF
   g==;
X-CSE-ConnectionGUID: uN6gt0PkTD2e8TamSibQEg==
X-CSE-MsgGUID: fUiSoCjYTMm75S0AABIw6w==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="18308091"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="18308091"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 13:57:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="827791022"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="827791022"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 05 Apr 2024 13:57:06 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 05 Apr 2024 23:57:05 +0300
Date: Fri, 5 Apr 2024 23:57:05 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 01/12] drm/client: Fully protect modes[] with
 dev->mode_config.mutex
Message-ID: <ZhBloR59z8_K2YbJ@intel.com>
References: <20240404203336.10454-1-ville.syrjala@linux.intel.com>
 <20240404203336.10454-2-ville.syrjala@linux.intel.com>
 <jeg4se3nkphfpgovaidzu5bspjhyasafplmyktjo6pwzlvpj5s@cmjtomlj4had>
 <ZhBOLh8jk8uN-g1v@intel.com>
 <CAA8EJpoOzKPh1wFfgQy8bZN_jfsrgAcrxM1x1pEFbAwcY9zBUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8EJpoOzKPh1wFfgQy8bZN_jfsrgAcrxM1x1pEFbAwcY9zBUw@mail.gmail.com>
X-Patchwork-Hint: comment

On Fri, Apr 05, 2024 at 11:39:33PM +0300, Dmitry Baryshkov wrote:
> On Fri, 5 Apr 2024 at 22:17, Ville Syrjälä
> <ville.syrjala@linux.intel.com> wrote:
> >
> > On Fri, Apr 05, 2024 at 06:24:01AM +0300, Dmitry Baryshkov wrote:
> > > On Thu, Apr 04, 2024 at 11:33:25PM +0300, Ville Syrjala wrote:
> > > > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > >
> > > > The modes[] array contains pointers to modes on the connectors'
> > > > mode lists, which are protected by dev->mode_config.mutex.
> > > > Thus we need to extend modes[] the same protection or by the
> > > > time we use it the elements may already be pointing to
> > > > freed/reused memory.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/10583
> > > > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > >
> > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > >
> > > I tried looking for the proper Fixes tag, but it looks like it might be
> > > something like 386516744ba4 ("drm/fb: fix fbdev object model + cleanup properly.")
> >
> > The history is rather messy. I think it was originally completely
> > lockless and broken, and got fixed piecemeal later in these:
> > commit 7394371d8569 ("drm: Take lock around probes for drm_fb_helper_hotplug_event")
> > commit 966a6a13c666 ("drm: Hold mode_config.lock to prevent hotplug whilst setting up crtcs")
> >
> > commit e13a05831050 ("drm/fb-helper: Stop using mode_config.mutex for internals")
> > looks to me like where the race might have been re-introduced.
> > But didn't do a thorough analysis so not 100% sure. It's all
> > rather ancient history by now so a Fixes tag doesn't seem all
> > that useful anyway.
> 
> Well, you have added stable to cc list, so you expect to have this
> patch backported. Then it should either have a kernel version as a
> 'starting' point or a Fixes tag to assist the sable team.

It'll get backported just fine without either.

-- 
Ville Syrjälä
Intel

