Return-Path: <stable+bounces-230117-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePI3NYJywmmncwQAu9opvQ
	(envelope-from <stable+bounces-230117-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:16:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F17030720E
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFF0E3042994
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622E53E8C62;
	Tue, 24 Mar 2026 11:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mkuk0eIH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E623DFC9D;
	Tue, 24 Mar 2026 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774350574; cv=none; b=KHUpgbflioj7X6VUVaZdN+EafbQLaKloU19BiFsYzVga3i2PucmMRkZf1f7l66j1qO/Vp1ECkh4aAHMiILtvmHwBvaqZAACjDWj+FGJ29lsLd4o8uEkI8ZMA40nXwb+jos8MCqOeSgPA+sh3HSFRsb8c5N84mmXQR1M1ze09Ik8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774350574; c=relaxed/simple;
	bh=iOR1h4fcZWeV6zkcSAkDK7aDf13M07RsodIPR4ByCSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwJAuMYkWvoV2JDrGucOFCsZ1gyXJyWAfXS+bAeWaHiG9or2Nn00bMm3x7qzM25uRMHtYQtvpe02sA72AmfgWGOlsiyczBJ8JT6ZaYyiFs8YDuczqokfAzlq/Tle0la3tI/LGE/JurAUUiq1SFU7bj76G7G3wuFoQW1ksSuyzfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mkuk0eIH; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774350572; x=1805886572;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iOR1h4fcZWeV6zkcSAkDK7aDf13M07RsodIPR4ByCSk=;
  b=mkuk0eIHNa0kKA8v8awlwucrXRELaXAirzUOh3hn33ybDilXlBlDsCcI
   do3akbtpmJEO52aknNGBx1MuPHwVH2Bnlv7Fy3RwUqvuLBeIsdxSwdowm
   B5RII6ZVP39wcymiqB3Xv48519zx59rKo4aTBVNRqDsUUyGAhfaWmxX3I
   9qQjopxrdFL1UZeHgSQFQ9MU3KNo/jSV8le/ZKXgY2QrmZ7dlf5b/3Ae1
   52yEGZe54ELBWEowICgp4+MmC/kEamCBbH/GnWS1kpWERZakZLyGV0gjS
   m+kG0dboP7jholPynEt1vxeN28AogcrmJGx9jvIEu1tm3NMaMSU5YQ9p0
   w==;
X-CSE-ConnectionGUID: Jh0nCzw9RZOPc5gUfxtA9A==
X-CSE-MsgGUID: UwIGDrwXQjSKBTHwjA4MeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="100807671"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="100807671"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 04:09:32 -0700
X-CSE-ConnectionGUID: usaXSFn1TdG0jwqW0DAUuA==
X-CSE-MsgGUID: ejoi2VIOS7iZOgXip8Ubjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="254805065"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 24 Mar 2026 04:09:30 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 0B03A95; Tue, 24 Mar 2026 12:09:29 +0100 (CET)
Date: Tue, 24 Mar 2026 13:08:43 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Madhu M <madhu.m@intel.corp-partner.google.com>
Subject: Re: [PATCH v2] usb: typec: Remove alt->adev.dev.class assignment
Message-ID: <acJwu-kjdGsrf4Pr@kuha>
References: <20260324102903.1416210-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324102903.1416210-1-akuchynski@chromium.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230117-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heikki.krogerus@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F17030720E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 10:29:03AM +0000, Andrei Kuchynski wrote:
> The typec plug alternate mode is already registered as part of the bus.
> When both class and bus are set for a device, device_add() attempts to
> create the "subsystem" symlink in the device's sysfs directory twice, once
> for the bus and once for the class.
> This results in a duplicate filename error during registration,
> causing the alternate mode registration to fail with warnings:
> 
> cannot create duplicate filename '/devices/pci0000:00/0000:00:1f.0/
>   PNP0C09:00/GOOG0004:00/cros-ec-dev.1.auto/cros_ec_ucsi.3.auto/typec/
>   port1/port1-cable/port1-plug0/port1-plug0.0/subsystem'
> typec port0-plug0: failed to register alternate mode (-17)
> cros_ec_ucsi.3.auto: failed to registers svid 0x8087 mode 1
> 
> Cc: stable@vger.kernel.org
> Fixes: 67ab45426215 ("usb: typec: Set the bus also for the port and plug altmodes")
> Tested-by: Madhu M <madhu.m@intel.corp-partner.google.com>
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in V2:
> - Marked as a Fix
> 
>  drivers/usb/typec/class.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 8314309094719..0977581ad1b6e 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -686,10 +686,6 @@ typec_register_altmode(struct device *parent,
>  
>  	alt->adev.dev.bus = &typec_bus;
>  
> -	/* Plug alt modes need a class to generate udev events. */
> -	if (is_typec_plug(parent))
> -		alt->adev.dev.class = &typec_class;
> -
>  	ret = device_register(&alt->adev.dev);
>  	if (ret) {
>  		dev_err(parent, "failed to register alternate mode (%d)\n",

thanks,

-- 
heikki

