Return-Path: <stable+bounces-160513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CD3AFCF3F
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B79073AEFB4
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 15:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E382E2EE5;
	Tue,  8 Jul 2025 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="blut8qn3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880CA2E11C8
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988409; cv=none; b=GnR6IcOvowj8xW2lh178tXf2bt+n2y5+SVCej+dlM3ScZetjsN7Y9EfAP59neGboMKdnx0Z32hCNvDdegk0XSXHkCPAhE6sDfvl90K9/hDmg2o5pKz159WiLzbu06KzjMmhcn/1Ar51qrwRESZa92rHlCn9pIXPoYmVYxClpM6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988409; c=relaxed/simple;
	bh=4iV+WsB43o0lQdpXMRojwBPOtp66aR79FZRerRm2PG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVp/eZUusQ/nsgfZiHo+Y59u8CYqX0Lh65VQS9MqXUfLcoOUQQ/A+agDkbnnmGMmI7AxRm/y7+vyATZNRmjleB+vuWXbDN7FEaiZShjKTwL4qF6P+dpZlob8dYYKwCHFC3cWXhbccZU0XANYvrjZ05ffiXAcg0m3P1qTfDhEqXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=blut8qn3; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751988408; x=1783524408;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4iV+WsB43o0lQdpXMRojwBPOtp66aR79FZRerRm2PG4=;
  b=blut8qn3dje5c0T349SG/hD2trQT5GW7/1DX5Dkg+KI32g9EvOx/fYYn
   vnZLlGVU5tigB1QQg6bxoBmMrm5sJJxl2tSZlSRSfK6wUghiPv1mQd9X3
   JOrRRoFoDeuibjYdPkshF7JbfzoJ4nOOBoHhFgGHjn4O1i76a41aaa+Ix
   jnDpmdlwrjnfykJdKfNjeVjut9shHkx+l7nuVyzmsAR9OaSG/yCUWZ4Gm
   3o4DThbiq4pJnJZ2jtuqahx3qkg3aSzDKFt7ecT8NhO5Txq49jxGqntfN
   xYfKMko4jXmjENMjGytBAY9A6Hd11u4QtX3Uyck7Tt+F5Wikc66OCHmZW
   g==;
X-CSE-ConnectionGUID: TJyoXLGPR5m1S5exTsEMqw==
X-CSE-MsgGUID: 3Nesbfr+QimbFM76D7n8gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54363340"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="54363340"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 08:26:47 -0700
X-CSE-ConnectionGUID: 8wsB15r0TYaGNI11WRDMEw==
X-CSE-MsgGUID: JGfo1jxqSDiIGRpPLZVb5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="161170094"
Received: from johunt-mobl9.ger.corp.intel.com (HELO stinkbox) ([10.245.245.55])
  by orviesa005.jf.intel.com with SMTP; 08 Jul 2025 08:26:44 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 08 Jul 2025 18:26:42 +0300
Date: Tue, 8 Jul 2025 18:26:42 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	jani.nikula@linux.intel.com, stable@vger.kernel.org
Subject: Re: [RESEND 1/1] drm/i915/dp: Refine TPS4-based HBR3 rejection and
 add quirk to limit eDP to HBR2
Message-ID: <aG04slRjhkUoKEj0@intel.com>
References: <20250627084059.2575794-2-ankit.k.nautiyal@intel.com>
 <20250706053149.3997091-1-ankit.k.nautiyal@intel.com>
 <aG0nwwRNpH7X7BNg@intel.com>
 <094d5dba-3483-4133-99e8-9e32d42ba2f6@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <094d5dba-3483-4133-99e8-9e32d42ba2f6@intel.com>
X-Patchwork-Hint: comment

On Tue, Jul 08, 2025 at 08:43:37PM +0530, Nautiyal, Ankit K wrote:
> 
> On 7/8/2025 7:44 PM, Ville Syrjälä wrote:
> > On Sun, Jul 06, 2025 at 11:01:49AM +0530, Ankit Nautiyal wrote:
> >> Refine the logic introduced in commit 584cf613c24a ("drm/i915/dp: Reject
> >> HBR3 when sink doesn't support TPS4") to allow HBR3 on eDP panels that
> >> report DPCD revision 1.4, even if TPS4 is not supported. This aligns with
> >> the DisplayPort specification, which does not mandate TPS4 support for eDP
> >> with DPCD rev 1.4.
> >>
> >> This change avoids regressions on panels that require HBR3 to operate at
> >> their native resolution but do not advertise TPS4 support.
> >>
> >> Additionally, some ICL/TGL platforms with combo PHY ports suffer from
> >> signal integrity issues at HBR3. While certain systems include a
> >> Parade PS8461 mux to mitigate this, its presence cannot be reliably
> >> detected. Furthermore, broken or missing VBT entries make it unsafe to
> >> rely on VBT for enforcing link rate limits.
> >>
> >> To address the HBR3-related issues on such platforms and eDP panels,
> >> introduce a device specific quirk to cap the eDP link rate to HBR2
> >> (540000 kHz). This will override any higher advertised rates from
> >> the sink or DPCD for specific devices.
> >>
> >> Currently, the quirk is added for Dell XPS 13 7390 2-in-1 which is
> >> reported in gitlab issue #5969 [1].
> >>
> >> [1] https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/5969
> >> [2] https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/14517
> >>
> >> Fixes: 584cf613c24a ("drm/i915/dp: Reject HBR3 when sink doesn't support TPS4")
> >> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> >> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> >> Cc: <stable@vger.kernel.org> # v6.15+
> >> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/5969
> >> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/14517
> >> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> >> ---
> >>   drivers/gpu/drm/i915/display/intel_dp.c     | 31 +++++++++++++++++++--
> >>   drivers/gpu/drm/i915/display/intel_quirks.c |  9 ++++++
> >>   drivers/gpu/drm/i915/display/intel_quirks.h |  1 +
> >>   3 files changed, 39 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> >> index f48912f308df..362e376fca27 100644
> >> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> >> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> >> @@ -171,6 +171,15 @@ int intel_dp_link_symbol_clock(int rate)
> >>   	return DIV_ROUND_CLOSEST(rate * 10, intel_dp_link_symbol_size(rate));
> >>   }
> >>   
> >> +static bool intel_dp_reject_hbr3_due_to_tps4(struct intel_dp *intel_dp)
> >> +{
> >> +	/* TPS4 is not mandatory for eDP with DPCD rev 1.4 */
> >> +	if (intel_dp_is_edp(intel_dp) && intel_dp->dpcd[DP_DPCD_REV] == 0x14)
> >> +		return false;
> >> +
> >> +	return !drm_dp_tps4_supported(intel_dp->dpcd);
> >> +}
> > This feels like it's getty too messy for comfort. I think we should just
> > revert the whole thing and quirk that one icl machine.
> 
> Alright sure.
> 
> Can this be done is same patch, I mean no need for a revert and a 
> separate quirk patch, right?

Separate revert seems cleaner to me. And then one can actually
backport the quirk without having to also backport the already
reverted commit. Though I haven't checked how far the bad commit
already got backported.

-- 
Ville Syrjälä
Intel

