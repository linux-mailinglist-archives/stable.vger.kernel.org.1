Return-Path: <stable+bounces-269828-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5/5xFPnXQmrjEQoAu9opvQ
	(envelope-from <stable+bounces-269828-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 22:39:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8786DEACF
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 22:39:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=B7oZBJKo;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269828-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269828-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64C4E303ADC0
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 20:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2143845B0;
	Mon, 29 Jun 2026 20:39:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5CA36EA8E
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 20:39:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782765544; cv=none; b=SpDmRhsaxO+PhWm3qkKUXCusIYzUliTiIyUJvZhr/NaqzAafB3G4SzvunvIhX09uiZtNHk7xPGTfXk5tEbkP2E1wXT/9RSgyQP8FwYM088M14cCImRpnzGobKgvNZsf2WovHvsrJxS/B788UpJWEkjW0kZqXcBCQvQ3MwvJG4+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782765544; c=relaxed/simple;
	bh=EwFDPkXT5wkRWplhD6XwRPUDKn9mnoFOIBaT+hv7ofM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ogx0aI8fOA/rLHHg8A6Os4WHjTLP8iwMXHrFT3qQyqZBxE5QSQn55mHr++tmnMbpEDRjhYaH955Nc9Maz9qHD81SSWCTXAG04gOjXY3p0VugEZWEMOyDJQ2REijYV6zyKG27ZUDEwc7QsZdhLY1rPQP/1P1YL9ecQbgt0m93cnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7oZBJKo; arc=none smtp.client-ip=74.125.82.176
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30e7eb50b83so2435458eec.1
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 13:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782765541; x=1783370341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QxGd9JAkUGNcCflM4SNBM1B387rgbM795qSJ3dVw6Do=;
        b=B7oZBJKoHylJ6UKoUMu4C3eKdFcgWsn/MViB2YeqIhsmm6Hk2QNhV2PilkCibEU9NB
         swJoU2iEYJMbjfHMLqjCd2O51jZTGlWHmYFOi1Cn112HBpm6nICfHNPYaIGNuS82FNO3
         fLnvJxMOqy9aVDm2TT6iSQf+C6nHIEKOFLjcUw+JqUVmSmbQRZa9gTCHdvOtLgMgJKpn
         ftW/WcPBB/+2NO5lFcGOqemod5ZTRtPVnngFO94H44zcSRBjbU2+Fnql0XtXmW6oLjLp
         94zMk5FlmHG1Wj+Qmk0wGyG01ChAnd5FA346SqptOuVeZKDktj0coKtuEISdspJWI0ts
         UBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782765541; x=1783370341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QxGd9JAkUGNcCflM4SNBM1B387rgbM795qSJ3dVw6Do=;
        b=mZhGTJLH4iIkAR3ATY7FE2YgdhKtJojw/Kbjn9zt/7LAz0LxBmqm8MsPNh37MoXlH5
         u4QRGJDrGWmeMUXeETUxFwDe5JSFhm9Lvq3SiyptqspcVlXFDZcmoOUiSQ+/6t4xJEmQ
         aVWF93QIz4Hb6BL9NEwRujsoESCESfzQs4/ICXXRpqvpw5+AHBp1T4TrYQD1RcIxhXO/
         Go2SsjIqWm+kCkMjv/KQ3bx09V9/jGvvi5CjNs5vFHLjcoS8zA2OE3XQguLUSzT7c3J5
         PU7HfoDUiHY0S9hE51E7SnkVq3ujtSzwRKb9Rial7F6qEP35OVBpByilt1WlAFmL01YL
         6Iyg==
X-Forwarded-Encrypted: i=1; AHgh+Rp7WQ6QyUgf0ztH1hSIoMqgHvs85VZ7507eoKX+vuFZLEpimm0/9rhEkqO3eY6lLwQ1/B17a50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUlIecXYUyawdT5yYkMUveM5OJcCsdRwQzROPCELtNLLs9ixkP
	VzQpdppwpgs6UC9LzvVrT2K6KK5tfEkIue+n/Esfu9c0nXjVDlHGe/6FrAIuVA==
X-Gm-Gg: AfdE7cmGVmVVK2RaZz6WLF+OqAA8iiMnrVrIGu+YEDiWzbDYd1qmPOf3Qztn0KATV3k
	HH8I0wQZieDIrd/qDMfA8zj/tVhqdbQklGR+d4pF5cDD2wMIFPq3p14gLsSlSeEkcD03JwT1ZF9
	lrhdrMj6Of1sYO2MqE0vWlrTPRIGW6rsGFFSAHrOTIgdRsbKIbmc93lOmwXEjnxEihRpwyj3WG5
	GQAUFb3l16XF/BGBrfqvF2DHWnk3RSHErzuNFDEWlZF5BsteVl5A9YrV33bDcA+pK9/oOHhvEgl
	W1wtSPTSlOBr45VJHqjY0yfiAr7TqzHWCyJiGqM5xnJQ3JIjQqKpQpBHhKmaj7AwefhPR3nnWnP
	DsVNA40W8WgtFsKQJMT8wH4nJ22LnSYno+bhA5EYj5vDhp9L81liXsDOuaFthIugliEAM0rspOl
	pTaG49Aym/Syj02fcWtWjso4BLfQ==
X-Received: by 2002:a05:693c:65ce:b0:30c:9051:e4be with SMTP id 5a478bee46e88-30ee13a1114mr480608eec.35.1782765541259;
        Mon, 29 Jun 2026 13:39:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee3170ee7sm642589eec.14.2026.06.29.13.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 13:39:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 29 Jun 2026 13:39:00 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 3/3] hwmon: (max6679) add missing 'select REGMAP_I2C' to
 Kconfig
Message-ID: <22b58be1-ba09-46fb-93a9-30b342713bcc@roeck-us.net>
References: <20260629-add-kconfig-deps-v1-0-8104df929b1a@gmail.com>
 <20260629-add-kconfig-deps-v1-3-8104df929b1a@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-add-kconfig-deps-v1-3-8104df929b1a@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-269828-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:joshua.crofts1@gmail.com,m:tzungbi@kernel.org,m:alexandru.tachici@analog.com,m:linux-hwmon@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:joshuacrofts1@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,roeck-us.net:mid,roeck-us.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C8786DEACF

On Mon, Jun 29, 2026 at 09:17:41PM +0200, Joshua Crofts wrote:
> The Kconfig entry for the MAX6679 sensor doesn't contain a
> `select REGMAP_I2C` parameter, causing build failures if regmap
> isn't selected previously during the build process.
> 
> Fixes: 3a2a8cc3fe24 ("hwmon: (max6697) Convert to use regmap")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>

Applied, after fixing 6679 --> 6697.

Thanks,
Guenter

> ---
>  drivers/hwmon/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index cc593fbfa4cc..2bfbcc033d59 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1368,6 +1368,7 @@ config SENSORS_MAX6650
>  config SENSORS_MAX6697
>  	tristate "Maxim MAX6697 and compatibles"
>  	depends on I2C
> +	select REGMAP_I2C
>  	help
>  	  If you say yes here you get support for MAX6581, MAX6602, MAX6622,
>  	  MAX6636, MAX6689, MAX6693, MAX6694, MAX6697, MAX6698, and MAX6699

