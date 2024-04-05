Return-Path: <stable+bounces-36152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E2A89A4C2
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 21:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CB31285E2E
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 19:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058DF172BAB;
	Fri,  5 Apr 2024 19:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J2f6PwsZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB9D172793
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 19:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712344629; cv=none; b=oYFx+EsB5ZickST4cfChs7/kJ1M6TTEwtA2JHTywkAXIylpMHFgdUUsleCQyDTYDuryKeln1snspL7oNYt4FC4Ghf2oqS4iGWY1CW61BOGXNl1u4Z0ypZlIG904ytgInVH0bLx47/IvgnS1DWckVBR6q+0yl5S48sIUHHml0Rvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712344629; c=relaxed/simple;
	bh=4+Bux30dqLXg6KuK0fUec4K9aBNqA4+JiCmn0NOpEU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojoQVzGtdCJP8333d7Q56oQ1Jjx+w9CFswjgER6esuabifQ6Vg38W5vZ+2C4i44tXt1QJA0PvlkULlwdctQXc0M2ASjJHexl5sAKazXHFcefVfyljhf9BfFvatQj5ZSaZPsLe6bgngOrBVAzyNJ3Ybt0IgxLgIuKEYgTTY+I1j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J2f6PwsZ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712344628; x=1743880628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4+Bux30dqLXg6KuK0fUec4K9aBNqA4+JiCmn0NOpEU4=;
  b=J2f6PwsZn7QS2zRIKXslZlqcwihRMB+CZYvpZKSe2O4/cJE+5wR+1vi6
   xpo/GzAvBSA9oWlms+lrWIx5vNxs+Ggufe8oSppcVKF+iyoxyyZriTURt
   oeyXzwjwsUsY25qXfdS+Ah8M8uuI3y1wfDHspBmfDLJgI5NLWb/ReM/wD
   qOR3qtX12C6NR+9hjMpB/I/jiyxRTjgzas0/5McNiWhLpYW1fwiRP6O2s
   ZMmbKeqZXU2QTe0mlyUJ1oLdv+Amh3J5eCfaGe55HNgK/v8rfvsWDtF6Q
   TP+3N8YEb0ona5gleHIH5WQmMN74N3us+TtUmI9+pgIDJDcb/O386n5qj
   g==;
X-CSE-ConnectionGUID: vE4uBZ0qQJ+ABY/ChMIKYA==
X-CSE-MsgGUID: vlGN3JYDSCG2E98VZqIluQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7549313"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7549313"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 12:17:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="827790993"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="827790993"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 05 Apr 2024 12:17:03 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 05 Apr 2024 22:17:02 +0300
Date: Fri, 5 Apr 2024 22:17:02 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 01/12] drm/client: Fully protect modes[] with
 dev->mode_config.mutex
Message-ID: <ZhBOLh8jk8uN-g1v@intel.com>
References: <20240404203336.10454-1-ville.syrjala@linux.intel.com>
 <20240404203336.10454-2-ville.syrjala@linux.intel.com>
 <jeg4se3nkphfpgovaidzu5bspjhyasafplmyktjo6pwzlvpj5s@cmjtomlj4had>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jeg4se3nkphfpgovaidzu5bspjhyasafplmyktjo6pwzlvpj5s@cmjtomlj4had>
X-Patchwork-Hint: comment

On Fri, Apr 05, 2024 at 06:24:01AM +0300, Dmitry Baryshkov wrote:
> On Thu, Apr 04, 2024 at 11:33:25PM +0300, Ville Syrjala wrote:
> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > 
> > The modes[] array contains pointers to modes on the connectors'
> > mode lists, which are protected by dev->mode_config.mutex.
> > Thus we need to extend modes[] the same protection or by the
> > time we use it the elements may already be pointing to
> > freed/reused memory.
> > 
> > Cc: stable@vger.kernel.org
> > Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/10583
> > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> I tried looking for the proper Fixes tag, but it looks like it might be
> something like 386516744ba4 ("drm/fb: fix fbdev object model + cleanup properly.")

The history is rather messy. I think it was originally completely
lockless and broken, and got fixed piecemeal later in these:
commit 7394371d8569 ("drm: Take lock around probes for drm_fb_helper_hotplug_event")
commit 966a6a13c666 ("drm: Hold mode_config.lock to prevent hotplug whilst setting up crtcs")

commit e13a05831050 ("drm/fb-helper: Stop using mode_config.mutex for internals")
looks to me like where the race might have been re-introduced.
But didn't do a thorough analysis so not 100% sure. It's all
rather ancient history by now so a Fixes tag doesn't seem all
that useful anyway.

-- 
Ville Syrjälä
Intel

