Return-Path: <stable+bounces-211457-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCXPEKK9dGlI9QAAu9opvQ
	(envelope-from <stable+bounces-211457-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 13:40:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D53F07D9E6
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 13:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D342C300D94F
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 12:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46E82F12AC;
	Sat, 24 Jan 2026 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="h4Zu5Tlt"
X-Original-To: stable@vger.kernel.org
Received: from smtpcmd0756.aruba.it (smtpcmd0756.aruba.it [62.149.156.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C578024290D
	for <stable@vger.kernel.org>; Sat, 24 Jan 2026 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769258391; cv=none; b=UARUR2H4LgmU/h0QRKEi9KbIVd6FFT/HDsxNsRKZWF6Ise+HeKx3A/STAdVq6RbIWkw3KmJI6/i0S0dWWNLFIygL57SQvMJigvEfTsv/7z4ueGLc+QOJsSNrGHzN9+DI1nsnCAxhS6yx+DlwoiXgTBgYM4PJWKDLRwrEHbaPo7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769258391; c=relaxed/simple;
	bh=x/eJxJGd1gyBi9S1EfkrWwk+V8EKavFqy+bQ5AnJzL4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=IxWA5j1P5wEIdThEvO5VO6okrrpMTjnmGNoiiZ+PqYeirauTRHizev760Le+f2IdJct+sHgt542J8UMX5215puqiegsc7+i7ay2BAzqePMgIgRc1+oZS0WptJlmvSVk0Sxpsz4xrH476qbe0DOHu82CgzR8kPIrdPvhsIr0hadY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trentalancia.com; spf=pass smtp.mailfrom=trentalancia.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=h4Zu5Tlt; arc=none smtp.client-ip=62.149.156.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trentalancia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trentalancia.com
Received: from [192.168.43.2] ([93.34.57.197])
	by Aruba SMTP with ESMTPSA
	id jcsXvFMrotpTfjcsYvRLuG; Sat, 24 Jan 2026 13:36:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1769258199; bh=x/eJxJGd1gyBi9S1EfkrWwk+V8EKavFqy+bQ5AnJzL4=;
	h=Subject:From:To:Date:Content-Type:Mime-Version;
	b=h4Zu5Tlt07RQWIdNj/Q6GVJGmAj1tgROaL7fdyctqJSXytQCM2EdQfiIhBJKXSEs7
	 q26OXhh9xpy5dn8NOSZ1ujoZxe59FPi0gSfbOBMR9oVvsgrp0uyK6amYnZgAq4agGJ
	 xf0PUgtrGOuXxOLAbNuhiRQahzc6dDgay7BmCMBYho7PYVtnQjzianK2SDpnpSGxa/
	 I0vIuO60pBbCEnfsP1CqSk/hjktGxb5sQJfopUTP4R13o9EPaOZWijJ/wb1FH4XC5+
	 xOdB9sxNeKWfZKGy9DNU557grS70ycDLNCmuc/+4PNd2uS/Db1KQd4T4AhJ05P0RPt
	 fHxV8hWwZd8Hg==
Message-ID: <1769258197.8360.4.camel@trentalancia.com>
Subject: Re: [PATCH v2] pinctrl: intel: Add code name documentation
From: Guido Trentalancia <guido@trentalancia.com>
To: Raag Jadav <raag.jadav@intel.com>, andriy.shevchenko@linux.intel.com, 
	mika.westerberg@linux.intel.com, linusw@kernel.org
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Sat, 24 Jan 2026 13:36:37 +0100
In-Reply-To: <20260124081708.1141884-1-raag.jadav@intel.com>
References: <20260124081708.1141884-1-raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfH7zfPhbxqx8KiPweXVOqFw7odvfvE/G5J3L2Rzx5NcjjxNPQ+sv4SUo208HBQX8tsnIHY0YEa4I5YWxS1F3IY6bI6sJcz5D43TLm+z92R4UBneOFPa3
 OpayOQiydRYXodOrj5OK4etbvvYCNmfxLA23Leb6VmuEP8vz7mj9zEI6YY7PliaPOWw4lgmmhYyN7ZLSnFPvuz1T3Fm2cbOPMBXp7vex/FkdmVBgDR7MGaHg
 0HzO2JEioLAKw3Wi5wX4MaRr5trpcuRuETECcgbGhnx5R6Py5IfGZk8WPeef7aAEvMqL1o8sJNTUGLzqHSK/XIWAzK2BQpy1UYjb7kt9CYcZSvK01wUJTv4Q
 nnBz7bpT+v4XwuSCpzKLX+PTl8n8d1SmaHM6rKVi6IdBzxU8BJkyai6DId2bImx+rDhn9VV4GqdUYw2jPadT1WgTLoRTmw==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	DMARC_POLICY_REJECT(2.00)[trentalancia.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[aruba.it:s=a1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[aruba.it:+];
	TAGGED_FROM(0.00)[bounces-211457-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guido@trentalancia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trentalancia.com:mid,trentalancia.com:email,intel.com:email]
X-Rspamd-Queue-Id: D53F07D9E6
X-Rspamd-Action: no action

On Sat, 24/01/2026 at 13.44 +0530, Raag Jadav wrote:
> Intel pinctrl drivers support large set of platforms and the IPs are
> often reused by their different variants, but it's currently not
> possible
> to figure out the exact driver that supports specific variant. Add
> user
> friendly documentation for them.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Guido Trentalancia <guido@trentalancia.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220056
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Guido Trentalancia <guido@trentalancia.com>
> ---
> 
> v2: Also document for other similar drivers (Andy)
> 
>  drivers/pinctrl/intel/Kconfig | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pinctrl/intel/Kconfig
> b/drivers/pinctrl/intel/Kconfig
> index e4dc9ba899bd..488344f53d45 100644
> --- a/drivers/pinctrl/intel/Kconfig
> +++ b/drivers/pinctrl/intel/Kconfig
> @@ -53,7 +53,10 @@ config PINCTRL_ALDERLAKE
>  	select PINCTRL_INTEL
>  	help
>  	  This pinctrl driver provides an interface that allows
> configuring
> -	  of Intel Alder Lake PCH pins and using them as GPIOs.
> +	  PCH pins of the following platforms and using them as
> GPIOs:
> +	  - Alder Lake HX, N and S
> +	  - Raptor Lake HX, E and S
> +	  - Twin Lake
>  
>  config PINCTRL_BROXTON
>  	tristate "Intel Broxton pinctrl and GPIO driver"
> @@ -137,15 +140,17 @@ config PINCTRL_METEORLAKE
>  	select PINCTRL_INTEL
>  	help
>  	  This pinctrl driver provides an interface that allows
> configuring
> -	  of Intel Meteor Lake pins and using them as GPIOs.
> +	  SoC pins of the following platforms and using them as
> GPIOs:
> +	  - Arrow Lake (all variants)

If the next entry refers to Arrow Lake HX and S platforms, this one
(METEORLAKE) cannot include "all variants" for Arrow Lake, I suppose.

> +	  - Meteor Lake (all variants)
>  
>  config PINCTRL_METEORPOINT
>  	tristate "Intel Meteor Point pinctrl and GPIO driver"
>  	select PINCTRL_INTEL
>  	help
> -	  Meteor Point is the PCH of Intel Meteor Lake. This pinctrl
> driver
> -	  provides an interface that allows configuring of PCH pins
> and
> -	  using them as GPIOs.
> +	  This pinctrl driver provides an interface that allows
> configuring
> +	  PCH pins of the following platforms and using them as
> GPIOs:
> +	  - Arrow Lake HX and S
>  
>  config PINCTRL_SUNRISEPOINT
>  	tristate "Intel Sunrisepoint pinctrl and GPIO driver"
> @@ -160,7 +165,11 @@ config PINCTRL_TIGERLAKE
>  	select PINCTRL_INTEL
>  	help
>  	  This pinctrl driver provides an interface that allows
> configuring
> -	  of Intel Tiger Lake PCH pins and using them as GPIOs.
> +	  PCH pins of the following platforms and using them as
> GPIOs:
> +	  - Alder Lake H, P, PS and U
> +	  - Raptor Lake H, P, PS, PX and U
> +	  - Rocket Lake S
> +	  - Tiger Lake (all variants)
>  
>  source "drivers/pinctrl/intel/Kconfig.tng"
>  endmenu

Thanks,

Guido

