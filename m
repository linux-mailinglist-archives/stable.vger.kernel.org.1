Return-Path: <stable+bounces-224682-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEP0F3xfsWl/uQIAu9opvQ
	(envelope-from <stable+bounces-224682-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 13:26:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9B2263964
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 13:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0889F3037E5A
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 12:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EB03B3899;
	Wed, 11 Mar 2026 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HxgEmYWU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FB43E0242
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 12:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773231973; cv=none; b=mFhR9AIWP+/IkkHStJH4KPbSt8+pq32xs7oGmiGCaIo8zZGNm4HXnjX4Y1AFPUrytfmlgKpNX5oN5BHfA2p2IweO5I+E0ks22oLWLnpk68mtJnbOxOGKNnf9HyqmcdOm9f90/LIHVxGVGbZ9+vIXbYMdrZ/6NMPZVsudfXi6FHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773231973; c=relaxed/simple;
	bh=KdP4kjaCpXAymNN+Yhi2z2CE8+D8Ime3bG2PjPe+Gr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZ9svDZePTys2itxXuPGO0HhgVt9CpqyKIjKTo7WxrZWE4JPwtSZmUdH6V/LrXZHEL1YpCWA4EsfzYIxkGjqrcGOVjcqjR5evz589qIgkhncEPUH5cT3GbZ+QbPCYNJGHfFgRLhfcuybX1vCv0kvRvGiuF+085GsAcs20c/oBdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HxgEmYWU; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773231970; x=1804767970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KdP4kjaCpXAymNN+Yhi2z2CE8+D8Ime3bG2PjPe+Gr8=;
  b=HxgEmYWUlkFx+7rNy8EGn5sDZX5WdgP3bB9/V7MHkPL83UXVpgytfQ9k
   sPBc5mpiiOR76Gzub11m+aS5u+Xk0wkj3fJqYvy44/2LsjmthCu2/DaIP
   5/x9VAZQvM6WtX1/dXz0qfm8DwxPZBk9FiZt3ngxC1rDnH+UHhMDDXdt6
   B2/SF8ZahE82k5bInvj+7X/IEkAD8IbKkc/0q7O2awKHZXmA6SgG57rJo
   I90Xo2BRO3mQspxNDkoDGxDIp9sd144IFde6+rFbT1kcSur048M5bg2O3
   82e+AbQoSRjIYWmhMtPQ8vxkBrqEUvvlA/4gb7BxpjqraLWYTvBSUEBDb
   Q==;
X-CSE-ConnectionGUID: mCKCAKEJQYG/Ep/Gfwye6w==
X-CSE-MsgGUID: XU6ydYWeQRSjk9fsdDhbuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="85002387"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="85002387"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 05:26:10 -0700
X-CSE-ConnectionGUID: cSmEKEC5RxC2TMxDHEnkcA==
X-CSE-MsgGUID: hSuucEqvQVukaUlExU3HCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="216712898"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.252])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 05:26:07 -0700
Date: Wed, 11 Mar 2026 14:25:54 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Imre Deak <imre.deak@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	Mohammed Thasleem <mohammed.thasleem@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Tao Liu <ltao@redhat.com>, stable@vger.kernel.org,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [CI] drm/i915/dmc: Fix an unlikely NULL pointer deference at
 probe
Message-ID: <abFfUhF-bvNmmZDn@intel.com>
References: <20260309164803.1918158-1-imre.deak@intel.com>
 <aa_Y7shwd1Vqiy3i@intel.com>
 <aa_j1Gxa7iWEEYHi@ideak-desk.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa_j1Gxa7iWEEYHi@ideak-desk.lan>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
X-Rspamd-Queue-Id: CE9B2263964
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.53 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-224682-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ville.syrjala@linux.intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 11:26:44AM +0200, Imre Deak wrote:
> On Tue, Mar 10, 2026 at 10:40:14AM +0200, Ville Syrjälä wrote:
> > On Mon, Mar 09, 2026 at 06:48:03PM +0200, Imre Deak wrote:
> > > intel_dmc_update_dc6_allowed_count() oopses when DMC hasn't been
> > > initialized, and dmc is thus NULL.
> > > 
> > > That would be the case when the call path is
> > > intel_power_domains_init_hw() -> {skl,bxt,icl}_display_core_init() ->
> > > gen9_set_dc_state() -> intel_dmc_update_dc6_allowed_count(), as
> > > intel_power_domains_init_hw() is called *before* intel_dmc_init().
> > > 
> > > However, gen9_set_dc_state() calls intel_dmc_update_dc6_allowed_count()
> > > conditionally, depending on the current and target DC states. At probe,
> > > the target is disabled, but if DC6 is enabled, the function is called,
> > > and an oops follows. Apparently it's quite unlikely that DC6 is enabled
> > > at probe, as we haven't seen this failure mode before.
> > > 
> > > It is also strange to have DC6 enabled at boot, since that would require
> > > the DMC firmware (loaded by BIOS); the BIOS loading the DMC firmware and
> > > the driver stopping / reprogramming the firmware is a poorly specified
> > > sequence and as such unlikely an intentional BIOS behaviour. It's more
> > > likely that BIOS is leaving an unintentionally enabled DC6 HW state
> > > behind (without actually loading the required DMC firmware for this).
> > 
> > Wasn't the original case some kdump kernel thing?
> 
> According to Jani the original issue was a KASAN run in QEMU, see [1].
> Not sure if that also resulted in kexec/kdump.
> 
> However the case reported by Tao later is related to kexec/kdump indeed.
> 
> > I think that has a few issues:
> > - loading full GPU drivers for a kdump kernel after the real kernel
> >   has crashed seems a bit risky. Who knows what state the hardware
> >   is in after the crash...
> > - we should probably try to unload DMC at kexec time (to the extent
> >   that DMC can actually be unloaded)
> 
> AFAICS that involves calling the pci_driver::shutdown which (for both xe
> and i915) ends up calling intel_power_domains_disable(), which disables
> DC states at least (hence the kexec'ed kernel should still not see DC6
> being enabled). The DMC FW event handlers are not disabled though in
> this case (which would be what you refer to unloading DMC I presume) as
> opposed to system/runtime suspend, where all the DMC events are also
> disabled.
> 
> I agree that the kexec->shutdown, driver remove etc. handlers should be
> synced at least wrt. the above DMC unloading with the suspend handlers.
> However, I consider that as a separate issue to the one fixed in this
> patch, which is using the HW DC state (which is unreliable) incorrectly
> to track the DC6 allowed counter (the correct way being using the SW DC
> state instead). So are you okay to go ahead with this patch still for
> now and follow up with syncing the above shutdown/driver remove handlers
> with the suspend ones?

Yeah this seems fine.

As we discussed, eventually we may want:
- make sure we sanitize DMC(*) early enough during driver load to
  make sure it isn't running while we're initializing anything important
- also sanitize similarly it during shutdown/unload/etc. to make sure it
  doesn't screw up anything for the next driver/whatever
- sprinkle some more asserts to make sure the DC state matches in
  software and hardware, if we don't already have enough of these

* disable DC states and all event handlers

> 
> [1] https://lore.kernel.org/all/43c4d7f0d9fe4ba6acac828306b41d612dd4f085@intel.com
> 
> > > The tracking of the DC6 allowed counter only works if starting /
> > > stopping the counter depends on the _SW_ DC6 state vs. the current _HW_
> > > DC6 state (since stopping the counter requires the DC5 counter captured
> > > when the counter was started). Thus, using the HW DC6 state is incorrect
> > > and it also leads to the above oops. Fix both issues by using the SW DC6
> > > state for the tracking.
> > > 
> > > This is v2 of the fix originally sent by Jani, updated based on the
> > > first Link: discussion below.
> > > 
> > > Link: https://lore.kernel.org/all/3626411dc9e556452c432d0919821b76d9991217@intel.com
> > > Link: https://lore.kernel.org/all/20260228130946.50919-2-ltao@redhat.com
> > > Fixes: 88c1f9a4d36d ("drm/i915/dmc: Create debugfs entry for dc6 counter")
> > > Cc: Mohammed Thasleem <mohammed.thasleem@intel.com>
> > > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > > Cc: Tao Liu <ltao@redhat.com>
> > > Cc: <stable@vger.kernel.org> # v6.16+
> > > Tested-by: Tao Liu <ltao@redhat.com>
> > > Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> > > Signed-off-by: Imre Deak <imre.deak@intel.com>
> > > ---
> > >  drivers/gpu/drm/i915/display/intel_display_power_well.c | 2 +-
> > >  drivers/gpu/drm/i915/display/intel_dmc.c                | 3 +--
> > >  2 files changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/i915/display/intel_display_power_well.c b/drivers/gpu/drm/i915/display/intel_display_power_well.c
> > > index 1e03187dbd38a..f855f0f886946 100644
> > > --- a/drivers/gpu/drm/i915/display/intel_display_power_well.c
> > > +++ b/drivers/gpu/drm/i915/display/intel_display_power_well.c
> > > @@ -852,7 +852,7 @@ void gen9_set_dc_state(struct intel_display *display, u32 state)
> > >  			power_domains->dc_state, val & mask);
> > >  
> > >  	enable_dc6 = state & DC_STATE_EN_UPTO_DC6;
> > > -	dc6_was_enabled = val & DC_STATE_EN_UPTO_DC6;
> > > +	dc6_was_enabled = power_domains->dc_state & DC_STATE_EN_UPTO_DC6;
> > >  	if (!dc6_was_enabled && enable_dc6)
> > >  		intel_dmc_update_dc6_allowed_count(display, true);
> > >  
> > > diff --git a/drivers/gpu/drm/i915/display/intel_dmc.c b/drivers/gpu/drm/i915/display/intel_dmc.c
> > > index c3b411259a0c5..90ba932d940ac 100644
> > > --- a/drivers/gpu/drm/i915/display/intel_dmc.c
> > > +++ b/drivers/gpu/drm/i915/display/intel_dmc.c
> > > @@ -1598,8 +1598,7 @@ static bool intel_dmc_get_dc6_allowed_count(struct intel_display *display, u32 *
> > >  		return false;
> > >  
> > >  	mutex_lock(&power_domains->lock);
> > > -	dc6_enabled = intel_de_read(display, DC_STATE_EN) &
> > > -		      DC_STATE_EN_UPTO_DC6;
> > > +	dc6_enabled = power_domains->dc_state & DC_STATE_EN_UPTO_DC6;
> > >  	if (dc6_enabled)
> > >  		intel_dmc_update_dc6_allowed_count(display, false);
> > >  
> > > -- 
> > > 2.49.1
> > 
> > -- 
> > Ville Syrjälä
> > Intel

-- 
Ville Syrjälä
Intel

