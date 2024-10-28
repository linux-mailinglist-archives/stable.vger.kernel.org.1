Return-Path: <stable+bounces-89086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CBB9B33FE
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 15:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EA43B2338D
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 14:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9641DDC3C;
	Mon, 28 Oct 2024 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CtWXKWdk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2051DB360
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 14:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730126968; cv=none; b=CJ6DsuJBkNlHN28EIzZq1cXmb41s0KQ+OFU5b0wqLBvEtnt6/6r1hg7K+KUuZl8QAxA4P/GlFFbcRC7I+M/StTf50RzT3GjjcMakgIPLDgVokv2fXz0DoetJn39JAVUNbJx+9x3GKeZamJXoimQse9lEjpVHysmshcumt/g2zcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730126968; c=relaxed/simple;
	bh=poBwEQ4qfo5vGmhV0BdTgGT6DemPfW5FKvTX3/f3UFY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JmSL5RNPaByGcqtjaqC48nD3MAz2/Xk3991s9xBZsEp48eNhYeDL6xuYfZgBG2EsG1EfKd71/OtfvaZ9BO8dHXMJ/mcxOQghitmG+1LwvqMt1dol5d6G0pkOiWr9fqLVOchLPQsjCSIUEW7uFcOSz5F41t4Qyx0OLT04+dtv8Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CtWXKWdk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730126966; x=1761662966;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=poBwEQ4qfo5vGmhV0BdTgGT6DemPfW5FKvTX3/f3UFY=;
  b=CtWXKWdkJNllFWi/4eCBsAXEJy8wQDo2bxZvypNgl/hGJMfpVUdcASbB
   GRj1H/Xfdq9notK1J26JLs8tEVyu6uIkWz2+2o/KsH+Tkd44TCKOvCSd7
   tgzhgNHcHqys2GYMAuC2dxnmJ6AXzD2ZipFCIJxfkuNfqe84Mv+0IdHXU
   Ev3TCcGm7gL3LO3LNQ0SR1FZD5Vd+wZXUg8vlUqLi3QZ7x0EFob6hYbqO
   locIG3n/WwkruXCIhURfoUAc6ZmSZ485Fc3Vw8pd+BPhY4xYuncVNYxJd
   KeirkW8PrJoitkSB6oZUow9Up4wKXAVZWIHAz7KoevlOGlrul7BAfT0oK
   Q==;
X-CSE-ConnectionGUID: Ki8U0U4sQ+eZcFOYkl6VBQ==
X-CSE-MsgGUID: 4czbObvzTLe+RgMp5FQjww==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29156091"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29156091"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 07:49:26 -0700
X-CSE-ConnectionGUID: ZubovXBeTticiIFZO5EU+g==
X-CSE-MsgGUID: 7aZX99OXSrOPHcoctHQRAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="104957830"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.21])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 07:49:24 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>, Imre Deak <imre.deak@intel.com>
Cc: intel-gfx@lists.freedesktop.org, Tejun Heo <tj@kernel.org>,
 stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [Intel-gfx] [PATCH 1/2] drm/i915: Schedule the HPD poll init
 work on an unbound workqueue
In-Reply-To: <vgkma7lsnlajc2ttvk3zrfzfqw4uclyjvjq3qlb54pmrcuolvd@7xdf4nzxxdcx>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230901140403.2821777-1-imre.deak@intel.com>
 <vgkma7lsnlajc2ttvk3zrfzfqw4uclyjvjq3qlb54pmrcuolvd@7xdf4nzxxdcx>
Date: Mon, 28 Oct 2024 16:49:21 +0200
Message-ID: <877c9sp9ji.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 28 Oct 2024, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
> +Jani
>
> On Fri, Sep 01, 2023 at 05:04:02PM +0300, Imre Deak wrote:
>>Disabling HPD polling from i915_hpd_poll_init_work() involves probing
>>all display connectors explicitly to account for lost hotplug
>>interrupts. On some platforms (mostly pre-ICL) with HDMI connectors the
>>I2C EDID bit-banging using udelay() triggers in turn the
>>
>> workqueue: i915_hpd_poll_init_work [i915] hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
>>
>>warning.
>>
>>Fix the above by scheduling i915_hpd_poll_init_work() on a WQ_UNBOUND
>>workqueue. It's ok to use a system WQ, since i915_hpd_poll_init_work()
>>is properly flushed in intel_hpd_cancel_work().
>>
>>The connector probing from drm_mode_config::output_poll_work resulting
>>in the same warning is fixed by the next patch.
>>
>>Cc: Tejun Heo <tj@kernel.org>
>>Cc: Heiner Kallweit <hkallweit1@gmail.com>
>>CC: stable@vger.kernel.org # 6.5
>>Suggested-by: Tejun Heo <tj@kernel.org>
>>Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
>>Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
>>Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/9245
>>Link: https://lore.kernel.org/all/f7e21caa-e98d-e5b5-932a-fe12d27fde9b@gmail.com
>>Signed-off-by: Imre Deak <imre.deak@intel.com>
>>---
>> drivers/gpu/drm/i915/display/intel_hotplug.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>>diff --git a/drivers/gpu/drm/i915/display/intel_hotplug.c b/drivers/gpu/drm/i915/display/intel_hotplug.c
>>index e8562f6f8bb44..accc2fec562a0 100644
>>--- a/drivers/gpu/drm/i915/display/intel_hotplug.c
>>+++ b/drivers/gpu/drm/i915/display/intel_hotplug.c
>>@@ -774,7 +774,7 @@ void intel_hpd_poll_enable(struct drm_i915_private *dev_priv)
>> 	 * As well, there's no issue if we race here since we always reschedule
>> 	 * this worker anyway
>> 	 */
>>-	queue_work(dev_priv->unordered_wq,
>>+	queue_work(system_unbound_wq,
>> 		   &dev_priv->display.hotplug.poll_init_work);
>> }
>>
>>@@ -803,7 +803,7 @@ void intel_hpd_poll_disable(struct drm_i915_private *dev_priv)
>> 		return;
>>
>> 	WRITE_ONCE(dev_priv->display.hotplug.poll_enabled, false);
>>-	queue_work(dev_priv->unordered_wq,
>>+	queue_work(system_unbound_wq,
>
> This 1y+ patch doesn't apply anymore and now we also have xe to account
> for.  I'm reviving this since we are unifying the kernel config in CI
> and now several machines testing i915 start to hit this warning.
>
> Looking at the current code for xe we have:
>
> 	drivers/gpu/drm/xe/xe_device_types.h:
>
>          /** @unordered_wq: used to serialize unordered work, mostly display */
>          struct workqueue_struct *unordered_wq;
>
>
> ... which is, actually, just display.
>
> Jani, should we move this wq to display where it belongs, with the right
> flags, rather than queueing it on system_unbound_wq?

I think the general answer is:

1. Never use i915 or xe core workqueues in display code.

2. Use system workqueues where appropriate for display, and cancel the
   individual work where needed. While there are legitimate uses for the
   dedicated workqueues, I'm guessing a large portion of their use may
   be cargo-culting and/or the result of system wq flush going away, and
   not based on any real analysis.

3. For display stuff, add the minimal necessary workqueues in display
   code, and use them where appropriate. Also cancel the individual work
   where needed, and flush the entire workqueue only when really
   necessary. The entire workqueue flushing is also cargo-culting and/or
   the result of system wq flush going away.

4. Finally move the display wq init/cleanup to display code.

Now, I don't know what the answer in this particular case, or many of
the other cases, is. And that's probably one of the reasons we have the
status quo. :(


BR,
Jani.


-- 
Jani Nikula, Intel

