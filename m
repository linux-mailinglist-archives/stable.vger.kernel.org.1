Return-Path: <stable+bounces-89087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD1B9B3429
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 15:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF48E281711
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 14:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D211DD88F;
	Mon, 28 Oct 2024 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hS+4PmpZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DAF18E354
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730127532; cv=none; b=XKB0USIDxwpmsmc391ss3F7NJHbFbWKbtIa8UYu1PXTq5cxfLWyXgZlfDhYV5NrTS6iFHh1EbBAzkrifiHAy3V2gZ1YJ0t8iNXWfikYI+r+WxKHz4XzMz31oH7pqF3XiMsmG3yApsO2iFPRCi80Fk4Yir+a6JoKO1kp65JSmNsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730127532; c=relaxed/simple;
	bh=jImTaeYwwyLs8osHwS1+vxJzmzjApVEncEzUCUIxmDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzPS6F+DvOFKndLxHQ2bvUJSioMjwLgQTJLDSOqrNkdo8PtYAuPCUgnUu44NjLcEheG+W5Gh98ImOFCg4o2xRN1nA3SY01uaVIF0sLULP57TJ2PEnoyAHbWBR7fcSw9gMOTWO3NMPFBjPyfJXPt0DDORwa9Ow1/yPkCZDj+peFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hS+4PmpZ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730127530; x=1761663530;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=jImTaeYwwyLs8osHwS1+vxJzmzjApVEncEzUCUIxmDI=;
  b=hS+4PmpZ1BtNtzV567sXVpNAxrU2BNk+Z8dk5CcUJwLxhbQUY1LPbZsF
   bQJNS9U5BQ+jLL0K3RqxrGr0xVzljqciyqMwJSewxVtuYsRsuOfk/cupR
   thsUHoOpQie1Wx0clwm9d9JgHVxoRJ+dtNnzK0mM5IpRUGoj8Kxtlcwq7
   3nxCxyQFrXyYfMCWyR5J6wDUMTehZwjRB7oeRC2+PoZpW+gHBGXuEzvka
   QmD5Gqcz+AJ46Ix9L8k67ybaIT4f+sG9tw96IW/fsQk45rsndvfcGrkak
   FTTSD1ghddi3w4KszdB/vnBDb/EzQFvsOZbOhGxSgpm94ce/8BN9Tpsby
   w==;
X-CSE-ConnectionGUID: kLdMdc6kQMShQZ1N1Yr/nQ==
X-CSE-MsgGUID: f+jBxoyIR7meL6UQEpaJUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40264292"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40264292"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 07:58:50 -0700
X-CSE-ConnectionGUID: E8cDDvjSR+SgPZ8bsuM1sg==
X-CSE-MsgGUID: yhJmQ5NLQOO8qsospD9VXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="119102136"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 07:58:49 -0700
Date: Mon, 28 Oct 2024 16:59:20 +0200
From: Imre Deak <imre.deak@intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Cc: intel-gfx@lists.freedesktop.org, Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [Intel-gfx] [PATCH 1/2] drm/i915: Schedule the HPD poll init
 work on an unbound workqueue
Message-ID: <Zx-myBLnx49hR-fy@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <20230901140403.2821777-1-imre.deak@intel.com>
 <vgkma7lsnlajc2ttvk3zrfzfqw4uclyjvjq3qlb54pmrcuolvd@7xdf4nzxxdcx>
 <877c9sp9ji.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877c9sp9ji.fsf@intel.com>

On Mon, Oct 28, 2024 at 04:49:21PM +0200, Jani Nikula wrote:
> On Mon, 28 Oct 2024, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
> > +Jani
> >
> > On Fri, Sep 01, 2023 at 05:04:02PM +0300, Imre Deak wrote:
> >>Disabling HPD polling from i915_hpd_poll_init_work() involves probing
> >>all display connectors explicitly to account for lost hotplug
> >>interrupts. On some platforms (mostly pre-ICL) with HDMI connectors the
> >>I2C EDID bit-banging using udelay() triggers in turn the
> >>
> >> workqueue: i915_hpd_poll_init_work [i915] hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
> >>
> >>warning.
> >>
> >>Fix the above by scheduling i915_hpd_poll_init_work() on a WQ_UNBOUND
> >>workqueue. It's ok to use a system WQ, since i915_hpd_poll_init_work()
> >>is properly flushed in intel_hpd_cancel_work().
> >>
> >>The connector probing from drm_mode_config::output_poll_work resulting
> >>in the same warning is fixed by the next patch.
> >>
> >>Cc: Tejun Heo <tj@kernel.org>
> >>Cc: Heiner Kallweit <hkallweit1@gmail.com>
> >>CC: stable@vger.kernel.org # 6.5
> >>Suggested-by: Tejun Heo <tj@kernel.org>
> >>Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
> >>Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
> >>Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/9245
> >>Link: https://lore.kernel.org/all/f7e21caa-e98d-e5b5-932a-fe12d27fde9b@gmail.com
> >>Signed-off-by: Imre Deak <imre.deak@intel.com>
> >>---
> >> drivers/gpu/drm/i915/display/intel_hotplug.c | 4 ++--
> >> 1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >>diff --git a/drivers/gpu/drm/i915/display/intel_hotplug.c b/drivers/gpu/drm/i915/display/intel_hotplug.c
> >>index e8562f6f8bb44..accc2fec562a0 100644
> >>--- a/drivers/gpu/drm/i915/display/intel_hotplug.c
> >>+++ b/drivers/gpu/drm/i915/display/intel_hotplug.c
> >>@@ -774,7 +774,7 @@ void intel_hpd_poll_enable(struct drm_i915_private *dev_priv)
> >> 	 * As well, there's no issue if we race here since we always reschedule
> >> 	 * this worker anyway
> >> 	 */
> >>-	queue_work(dev_priv->unordered_wq,
> >>+	queue_work(system_unbound_wq,
> >> 		   &dev_priv->display.hotplug.poll_init_work);
> >> }
> >>
> >>@@ -803,7 +803,7 @@ void intel_hpd_poll_disable(struct drm_i915_private *dev_priv)
> >> 		return;
> >>
> >> 	WRITE_ONCE(dev_priv->display.hotplug.poll_enabled, false);
> >>-	queue_work(dev_priv->unordered_wq,
> >>+	queue_work(system_unbound_wq,
> >
> > This 1y+ patch doesn't apply anymore and now we also have xe to account
> > for.  I'm reviving this since we are unifying the kernel config in CI
> > and now several machines testing i915 start to hit this warning.
> >
> > Looking at the current code for xe we have:
> >
> > 	drivers/gpu/drm/xe/xe_device_types.h:
> >
> >          /** @unordered_wq: used to serialize unordered work, mostly display */
> >          struct workqueue_struct *unordered_wq;
> >
> >
> > ... which is, actually, just display.
> >
> > Jani, should we move this wq to display where it belongs, with the right
> > flags, rather than queueing it on system_unbound_wq?
> 
> I think the general answer is:
> 
> 1. Never use i915 or xe core workqueues in display code.
> 
> 2. Use system workqueues where appropriate for display, and cancel the
>    individual work where needed. While there are legitimate uses for the
>    dedicated workqueues, I'm guessing a large portion of their use may
>    be cargo-culting and/or the result of system wq flush going away, and
>    not based on any real analysis.
> 
> 3. For display stuff, add the minimal necessary workqueues in display
>    code, and use them where appropriate. Also cancel the individual work
>    where needed, and flush the entire workqueue only when really
>    necessary. The entire workqueue flushing is also cargo-culting and/or
>    the result of system wq flush going away.
> 
> 4. Finally move the display wq init/cleanup to display code.
> 
> Now, I don't know what the answer in this particular case, or many of
> the other cases, is. And that's probably one of the reasons we have the
> status quo. :(

The work scheduled for hotplug events (like the above poll_init_work)
are flushed explicitly, so I think the system workqueues should be used
for those (as opposed to driver specific workqueues).

> BR,
> Jani.
> 
> 
> -- 
> Jani Nikula, Intel

