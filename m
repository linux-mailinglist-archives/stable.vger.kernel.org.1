Return-Path: <stable+bounces-166772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779D6B1D7BE
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 14:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED7E3A164D
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 12:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0DB22126C;
	Thu,  7 Aug 2025 12:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jWR3G7j9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE398224AEB
	for <stable@vger.kernel.org>; Thu,  7 Aug 2025 12:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754569165; cv=none; b=gHuSntcJIdvpApv9GGaYQHRWDy9Pu3DDy5PEWh5G4hbB7ZKlz+UwtN2Qnkk8i/dSLdiWcgaHTq86KoQgRlhEXGazLN2PXtz0AWEyslJF534YpXgDl9dF3hOa5kT2hqfgllKTjrO8YVXpnDNbhEDnDDyXiWjAqmAeRqrIbtLMJBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754569165; c=relaxed/simple;
	bh=wpfQYs2R/Srz86OmlghcfoY5IcTWlEu5/UAtk74IDhM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CEqTnzEGEFCQWlhKwkYLZUJ9DT5/HseR7Gh57JZq/7c/7JpTHfnuOMcsoRU7ekego5JkzUeumLPAsDumd6/obNkok5diLpm8P2S6aDPUC+F9G/nYqx9pmWCyVhvry6x770gJT7LvaqPPDNevyOYadl7jPuH1YRh1BTy/jQnHaEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jWR3G7j9; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754569164; x=1786105164;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=wpfQYs2R/Srz86OmlghcfoY5IcTWlEu5/UAtk74IDhM=;
  b=jWR3G7j9UclH6ERZTRMOiCqKy8qk+WKoJtf1Y5Er1jkz0vma91oh68xq
   T8vr8BHAFePNC+vezQ9O5z5C3pCSC/UnjU57c/7chD6ySzH/6gMv8CzKP
   aMCakwJcRa3IZRe2RSsMgvGorQkJA+lRr6S/4PYPVKA2PqyRfhcm8gPXC
   lduOnseMN2MBtqhx1SoHuBmiDvDlgYckBHXt1r1/8yzhQLFhdiai4fIzX
   ODdiedQphMo/4nncvO36bBEGStRi0fgShCxGFHxD7AQeTcGEp76Q8si91
   RLe7A5rVIz6QUnDv0Lmx4qSNFLhIjBrCyZQZ61eIcOwQMQncHpgaXn96E
   w==;
X-CSE-ConnectionGUID: t14d8yQISuyUOEg3K94aXA==
X-CSE-MsgGUID: efXd1939SAKC5POkNgVlrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="55938622"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="55938622"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 05:19:23 -0700
X-CSE-ConnectionGUID: 2UB5wCxJScuaAYpPhubO7g==
X-CSE-MsgGUID: mJad/twUR++T+ZfDQyvQzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="169302046"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.96])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 05:19:21 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: imre.deak@intel.com, Luca Coelho <luca@coelho.fi>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 stable@vger.kernel.org, Charlton Lin <charlton.lin@intel.com>, Khaled
 Almahallawy <khaled.almahallawy@intel.com>
Subject: Re: [PATCH 01/19] drm/i915/lnl+/tc: Fix handling of an
 enabled/disconnected dp-alt sink
In-Reply-To: <aJSQKu72vVYmUd4Y@ideak-desk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250805073700.642107-1-imre.deak@intel.com>
 <20250805073700.642107-2-imre.deak@intel.com>
 <95999d2602067f556dc2e5739758deef7c462e17.camel@coelho.fi>
 <aJSQKu72vVYmUd4Y@ideak-desk>
Date: Thu, 07 Aug 2025 15:19:17 +0300
Message-ID: <d8e9cabb243cd8bbe7ac942d117146bf7f68b631@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 07 Aug 2025, Imre Deak <imre.deak@intel.com> wrote:
> On Thu, Aug 07, 2025 at 01:59:21PM +0300, Luca Coelho wrote:
>> On Tue, 2025-08-05 at 10:36 +0300, Imre Deak wrote:
>> > The TypeC PHY HW readout during driver loading and system resume
>> > determines which TypeC mode the PHY is in (legacy/DP-alt/TBT-alt) and
>> > whether the PHY is connected, based on the PHY's Owned and Ready flags.
>> > For the PHY to be in DP-alt or legacy mode and for the PHY to be in the
>> > connected state in these modes, both the Owned (set by the BIOS/driver)
>> > and the Ready (set by the HW) flags should be set.
>> > 
>> > On ICL-MTL the HW kept the PHY's Ready flag set after the driver
>> > connected the PHY by acquiring the PHY ownership (by setting the Owned
>> > flag), until the driver disconnected the PHY by releasing the PHY
>> > ownership (by clearing the Owned flag). On LNL+ this has changed, in
>> > that the HW clears the Ready flag as soon as the sink gets disconnected,
>> > even if the PHY ownership was acquired already and hence the PHY is
>> > being used by the display.
>> > 
>> > When inheriting the HW state from BIOS for a PHY connected in DP-alt
>> > mode on which the sink got disconnected - i.e. in a case where the sink
>> > was connected while BIOS/GOP was running and so the sink got enabled
>> > connecting the PHY, but the user disconnected the sink by the time the
>> > driver loaded - the PHY Owned but not Ready state must be accounted for
>> > on LNL+ according to the above. Do that by assuming on LNL+ that the PHY
>> > is connected in DP-alt mode whenever the PHY Owned flag is set,
>> > regardless of the PHY Ready flag.
>> > 
>> > This fixes a problem on LNL+, where the PHY TypeC mode / connected state
>> > was detected incorrectly for a DP-alt sink, which got connected and then
>> > disconnected by the user in the above way.
>> > 
>> > Cc: stable@vger.kernel.org # v6.8+
>> > Reported-by: Charlton Lin <charlton.lin@intel.com>
>> > Tested-by: Khaled Almahallawy <khaled.almahallawy@intel.com>
>> > Signed-off-by: Imre Deak <imre.deak@intel.com>
>> > ---
>> >  drivers/gpu/drm/i915/display/intel_tc.c | 16 ++++++++++------
>> >  1 file changed, 10 insertions(+), 6 deletions(-)
>> > 
>> > diff --git a/drivers/gpu/drm/i915/display/intel_tc.c b/drivers/gpu/drm/i915/display/intel_tc.c
>> > index 3bc57579fe53e..73a08bd84a70a 100644
>> > --- a/drivers/gpu/drm/i915/display/intel_tc.c
>> > +++ b/drivers/gpu/drm/i915/display/intel_tc.c
>> > @@ -1226,14 +1226,18 @@ static void tc_phy_get_hw_state(struct intel_tc_port *tc)
>> >  	tc->phy_ops->get_hw_state(tc);
>> >  }
>> >  
>> > -static bool tc_phy_is_ready_and_owned(struct intel_tc_port *tc,
>> > -				      bool phy_is_ready, bool phy_is_owned)
>> > +static bool tc_phy_in_legacy_or_dp_alt_mode(struct intel_tc_port *tc,
>> > +					    bool phy_is_ready, bool phy_is_owned)
>> 
>> Personally I don't like the "or" in the function name.  You're
>> returning a boolean which is true or false.  The return value is akin
>> to answering "Yes/No" to the question "Is it black or white".
>
> The question the function is meant to answer is "Is the PHY in legacy or
> DP-alt mode?". The return value is true (yes) if the PHY is in either
> legacy or DP-alt mode, false (no) if the PHY is neither in legacy or
> DP-alt mode. There are many other uses of "or" in function names in this
> sense, so not sure how else I'd name this one. Simply leaving out "or"
> would make it less clear that the legacy and DP-alt modes are two
> separate modes.

What's the opposite of "Is the PHY in legacy or DP-alt mode"?

Would that lead to a simpler name, with the reversed return value?

BR,
Jani.



>
>> This is a nitpick, obviously, so I'll leave it up to you.
>> 
>> Regardless:
>> 
>> Reviewed-by: Luca Coelho <luciano.coelho@intel.com>
>> 
>> --
>> Cheers,
>> Luca.
>> 
>> >  {
>> >  	struct intel_display *display = to_intel_display(tc->dig_port);
>> >  
>> > -	drm_WARN_ON(display->drm, phy_is_owned && !phy_is_ready);
>> > +	if (DISPLAY_VER(display) < 20) {
>> > +		drm_WARN_ON(display->drm, phy_is_owned && !phy_is_ready);
>> >  
>> > -	return phy_is_ready && phy_is_owned;
>> > +		return phy_is_ready && phy_is_owned;
>> > +	} else {
>> > +		return phy_is_owned;
>> > +	}
>> >  }
>> >  
>> >  static bool tc_phy_is_connected(struct intel_tc_port *tc,
>> > @@ -1244,7 +1248,7 @@ static bool tc_phy_is_connected(struct intel_tc_port *tc,
>> >  	bool phy_is_owned = tc_phy_is_owned(tc);
>> >  	bool is_connected;
>> >  
>> > -	if (tc_phy_is_ready_and_owned(tc, phy_is_ready, phy_is_owned))
>> > +	if (tc_phy_in_legacy_or_dp_alt_mode(tc, phy_is_ready, phy_is_owned))
>> >  		is_connected = port_pll_type == ICL_PORT_DPLL_MG_PHY;
>> >  	else
>> >  		is_connected = port_pll_type == ICL_PORT_DPLL_DEFAULT;
>> > @@ -1352,7 +1356,7 @@ tc_phy_get_current_mode(struct intel_tc_port *tc)
>> >  	phy_is_ready = tc_phy_is_ready(tc);
>> >  	phy_is_owned = tc_phy_is_owned(tc);
>> >  
>> > -	if (!tc_phy_is_ready_and_owned(tc, phy_is_ready, phy_is_owned)) {
>> > +	if (!tc_phy_in_legacy_or_dp_alt_mode(tc, phy_is_ready, phy_is_owned)) {
>> >  		mode = get_tc_mode_in_phy_not_owned_state(tc, live_mode);
>> >  	} else {
>> >  		drm_WARN_ON(display->drm, live_mode == TC_PORT_TBT_ALT);

-- 
Jani Nikula, Intel

