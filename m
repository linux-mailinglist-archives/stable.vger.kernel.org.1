Return-Path: <stable+bounces-61294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CE893B321
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 16:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C7401F2272E
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 14:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1ACD15F32D;
	Wed, 24 Jul 2024 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wf9jxroh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EE715B12F;
	Wed, 24 Jul 2024 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832663; cv=none; b=KWp/lw6mXpNp+uVBYiNKlM+lp25GJBrRJv1Krxl1LTqReQh8yqR8hNq7VBm36WLJibVd0wm6TNeM4PBX2tVZpLnBT6euMlbAwV7B6HzlL9pSOfeY94jq1PvCf0aIKOCwadMSDw9TTdVFGOsQsp0nm3zvzintVz8SjW7OZNZ7PKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832663; c=relaxed/simple;
	bh=bjLDQzZfw4xW/reuySijNClaossK1D/OHY9Pjl913No=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=endQeQre1xcVbgLEbAbF+1paDMSyTEmYWT9N3N8Qvtt2FjEW7Ee7pO1gmyuN7FEI85E3zy33qR+3yYQzBkCbbhqp76QG+YMZe01fkHiQLKh6fEGXlBDyUoxZEgMUC/+EEJd8uRCVjGO0QLx86kHcXVjceeVLOJw3eqOGVoUwMV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wf9jxroh; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721832662; x=1753368662;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=bjLDQzZfw4xW/reuySijNClaossK1D/OHY9Pjl913No=;
  b=Wf9jxrohphuzNVwhKZrsJZdcmQdr5Vsv964002ef7rxvFCV98+2CJXqw
   gQOrauVuBnZLHQuXzf+CYZRVOSn4nqmU71hWYHXgyx/W8c3S/UUsRRa/k
   w0ClLL6FJgmom/RL4n6JAJzrejp8RnXknL8+H9ZOpzi8CCz7MPX9zQa/o
   iEFRdM7Jw2sdOWXD1zf+OdVPJFZfo7LOZEjAtMw/r6db6tKPZLUAAvMvF
   PdCsS1M3LbY5KHXEYUmG2V+5v/1f7bIeeL0MuQV+lHyg89AmlcUvOB2sy
   M8RMyzI9yQ/gk7jqfHwmyISxGhhe/hvAWamuIAu2rKh/ZJ6tWzMbNWFLD
   w==;
X-CSE-ConnectionGUID: e9H7offXQRSWaABksVQh0g==
X-CSE-MsgGUID: SWPm4ahjRVe/UO/t1rPghw==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19653044"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="19653044"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 07:51:01 -0700
X-CSE-ConnectionGUID: oYO7cn40Q9y3SmfvsC+BEg==
X-CSE-MsgGUID: lCg1yNbCQ5uQghJ7uOOqsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="83218555"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.197])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 07:50:57 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 make24@iscas.ac.cn, mripard@kernel.org, noralf@tronnes.org,
 sam@ravnborg.org, stable@vger.kernel.org, tzimmermann@suse.de
Subject: Re: [PATCH v3] drm/client: fix null pointer dereference in
 drm_client_modeset_probe
In-Reply-To: <20240724105535.1524294-1-make24@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <87ikwvf6ol.fsf@intel.com>
 <20240724105535.1524294-1-make24@iscas.ac.cn>
Date: Wed, 24 Jul 2024 17:50:52 +0300
Message-ID: <87jzhakfn7.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 24 Jul 2024, Ma Ke <make24@iscas.ac.cn> wrote:
> On Wed, 24 Jul 2024, Jani Nikula <jani.nikula@linux.intel.com> wrote:
>> On Wed, 24 Jul 2024, Ma Ke <make24@iscas.ac.cn> wrote:
>> > In drm_client_modeset_probe(), the return value of drm_mode_duplicate() is
>> > assigned to modeset->mode, which will lead to a possible NULL pointer
>> > dereference on failure of drm_mode_duplicate(). Add a check to avoid npd.
>> >
>> > Cc: stable@vger.kernel.org
>> > Fixes: cf13909aee05 ("drm/fb-helper: Move out modeset config code")
>> > Signed-off-by: Ma Ke <make24@iscas.ac.cn>
>> > ---
>> > Changes in v3:
>> > - modified patch as suggestions, returned error directly when failing to 
>> > get modeset->mode.
>> 
>> This is not what I suggested, and you can't just return here either.
>> 
>> BR,
>> Jani.
>> 
>
> I have carefully read through your comments. Based on your comments on the 
> patchs I submitted, I am uncertain about the appropriate course of action 
> following the return value check(whether to continue or to return directly,
> as both are common approaches in dealing with function drm_mode_duplicate()
> in Linux kernel, and such handling has received 'acked-by' in similar 
> vulnerabilities). Could you provide some advice on this matter? Certainly, 
> adding a return value check is essential, the reasons for which have been 
> detailed in the vulnerability description. I am looking forward to your 
> guidance and response. Thank you!

Everything depends on the context. You can't just go ahead and do the
same thing everywhere. If you handle errors, even the highly unlikely
ones such as this one, you better do it properly.

If you continue here, you'll still leave modeset->mode NULL. And you
don't propagate the error. Something else is going to hit the issue
soon.

If you return directly, you'll leave holding a few locks, and leaking
memory.

There's already some error handling in the function, in the same loop
even. Set ret = -ENOMEM and break.

(However, you could still argue there's an existing problem in the error
handling in that all modeset->connectors aren't put and cleaned up.)


BR,
Jani.







>
> Best regards,
>
> Ma Ke
>
>> 
>> > Changes in v2:
>> > - added the recipient's email address, due to the prolonged absence of a 
>> > response from the recipients.
>> > - added Cc stable.
>> > ---
>> >  drivers/gpu/drm/drm_client_modeset.c | 3 +++
>> >  1 file changed, 3 insertions(+)
>> >
>> > diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
>> > index 31af5cf37a09..750b8dce0f90 100644
>> > --- a/drivers/gpu/drm/drm_client_modeset.c
>> > +++ b/drivers/gpu/drm/drm_client_modeset.c
>> > @@ -880,6 +880,9 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
>> >  
>> >  			kfree(modeset->mode);
>> >  			modeset->mode = drm_mode_duplicate(dev, mode);
>> > +			if (!modeset->mode)
>> > +				return 0;
>> > +
>> >  			drm_connector_get(connector);
>> >  			modeset->connectors[modeset->num_connectors++] = connector;
>> >  			modeset->x = offset->x;
>> 
>> -- 
>> Jani Nikula, Intel

-- 
Jani Nikula, Intel

