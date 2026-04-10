Return-Path: <stable+bounces-235632-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAGwHYgf2WkQmggAu9opvQ
	(envelope-from <stable+bounces-235632-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 18:04:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C73D83DA094
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 18:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AA5D31421DB
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 15:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A1A3DE42B;
	Fri, 10 Apr 2026 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kV1bw3Ch"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8289F3DDDDB
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 15:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834919; cv=none; b=sowhYSbhvg+WDRd7yFuLqx5AWCpLZFgHjE0JbHZRs60dtZexNRkhjNrvIwlJWVG14BYrUgsK117HcG2/I0787iBJDAQnclzAvSGgTFW7F234bVEM6b3TCeS/4P8c/32w6P9u5mJj78gN6jyjRU4u9b14a1Ip/wWn0alhmvcM/Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834919; c=relaxed/simple;
	bh=kbA7PR4neyNPM4QG9vJCntSEbumLjaB3stBsnOiOhns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTQcq2pFmTxGIXxHvLx7OyB1+d5ZwnEX1rkzlpDzHBsIEsbJSYyaWhNs4hfBbjerFwmjblup+sen0TPBTkrNTTyeGh6dDOPkN+RBhaIeB1ECknphwubXdGrTIG3VvWYFRacb6mw0ldY0QHYzRq1lBJRzMFvv6LF7O85Mijt53Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kV1bw3Ch; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2cf1646bd11so3795318eec.1
        for <stable@vger.kernel.org>; Fri, 10 Apr 2026 08:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775834918; x=1776439718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JghhKcmcjJXB0Gwm3GfsIN1qKN146rmMPnlKpn3tqi4=;
        b=kV1bw3ChPORis8x0QDRmnt/DRlSQac54ogHkkeHALFQpHq1NzqKSdKW4/ylBLjEjhw
         PuGZw3uLSfG8/IVHu2T0N3Ph7056tMoJumt4EHEqtX8OE6+YcrMS12MXGM8kjoQ+w+qa
         uPvo87inS3JolWjz8GUOvyrIEXLQy88bV5ayqjS5yJmv2hfze/skL/m2yfcEPW+gT3zI
         OM1wV3O96qsUpovSR7d5dZKxl+cPoV++qZKFunUrrUq+ovgcmc60TZI6cEXm5WlQIjaq
         T+V2M05i+c6FAjZYB8NKPWZQJ9/CkoZGFKjb8sZ7wDcoVlrRTn+Co1BhZcE1UmfUQN7g
         kvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775834918; x=1776439718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JghhKcmcjJXB0Gwm3GfsIN1qKN146rmMPnlKpn3tqi4=;
        b=g/V/4I95s1toWKcDNHai+dxISEjQsjnTSk/bgHB/cjEYSx3Plvw3e3xxlnPaSt3k6O
         fgRY6K/MHOshAUgbreK5KbFApa0ffzfHO6tVnQAIobElYHMnHIMiAYUW2J1GXGmdOyvC
         r/DCvxm00zWve+jOxEI2m6SSo9iQqqllr0VZRoKm9fp/IwSu9El1vkk6CyptFRolPSL7
         SBPuUTBC7x2ezt2NNqLHgareX7KDJIZalw+emujUvQef+dd3VImpbt9IIX9WIqvzMLYg
         +XmMH1AfCfAClG5dJ5FAsXUyB073iZvyE3rjaw8sT+ovZSV97Oln7074MG8kvGfpZW7N
         afow==
X-Forwarded-Encrypted: i=1; AJvYcCULyiknXvP5nqCQVvz22yV8J60kMUSDBPpFXqxhDlAseqi/esjVAE7Ksp4XCVAPtqjv8aCzijs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2B+QeCP5DIPJD5fabZt2DyD+yMYVoFINQQ9zXpuTpDvI1uxWS
	zYTVG9FPDsxXr1dX/PBowihl4oUEnJ1FffPaLMm8EcoPIA583eRHQsy4BFBxQw==
X-Gm-Gg: AeBDievVa2IBC81iugD1uYf55uBHjLUeaVLfhbEFvL4cTFZlEKDQCLz+FrhxsBfQK3O
	eM3GkAIVOsZNG+oQi/1FMYEo+xnexsiwT4kbNZeHexLfLb2kuAF4wL0FQ/mKp+4huD6Ll1RbTg5
	wi1vmfkZzQW0H8Zm3HAtyX+wK7x37aYLIM0xPy2xYrP7/ADHfYHM2BV2RtMtSILikW/Xf5USfUn
	gBhcPGd2q438B6SHiMsft5q3G5saXzFJ/xnPuVDwOl6VhyGn09QJcVx1RBbC37CAiQWo/Byek8y
	cXBOzdMZYHRpbtw+I4dFAG4NLeWi2mMyLBaELZRVrNkjtSKUOhYV49lyCKDlBUvzEC98h/lmr55
	cbTq2cHq2vL3LJgJeX6EhFoTso1ErHUqqLy1jEafYBeHk/NMTJd3wQ8JCk6p8D/0h24hXi1JJNl
	qBSFK1oosbH6ur9bmi0m3rNFOrfgZPivQZ7Bes
X-Received: by 2002:a05:7300:3721:b0:2cc:2125:9332 with SMTP id 5a478bee46e88-2d58a494b40mr2196877eec.27.1775834917647;
        Fri, 10 Apr 2026 08:28:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561bde717sm4713751eec.19.2026.04.10.08.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:28:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 10 Apr 2026 08:28:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
Cc: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux@weissschuh.net" <linux@weissschuh.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sanman Pradhan <psanman@juniper.net>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] hwmon: (powerz) Fix use-after-free on USB
 disconnect
Message-ID: <d7988826-251f-4bd9-8d46-91f925b5a64f@roeck-us.net>
References: <20260410002521.422645-1-sanman.pradhan@hpe.com>
 <20260410002521.422645-2-sanman.pradhan@hpe.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410002521.422645-2-sanman.pradhan@hpe.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235632-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,juniper.net:email]
X-Rspamd-Queue-Id: C73D83DA094
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 12:25:35AM +0000, Pradhan, Sanman wrote:
> From: Sanman Pradhan <psanman@juniper.net>
> 
> After powerz_disconnect() frees the URB and releases the mutex, a
> subsequent powerz_read() call can acquire the mutex and call
> powerz_read_data(), which dereferences the freed URB pointer.
> 
> Fix by:
>  - Setting priv->urb to NULL in powerz_disconnect() so that
>    powerz_read_data() can detect the disconnected state.
>  - Adding a !priv->urb check at the start of powerz_read_data()
>    to return -ENODEV on a disconnected device.
>  - Moving usb_set_intfdata() before hwmon registration so the
>    disconnect handler can always find the priv pointer.
> 
> Fixes: 4381a36abdf1c ("hwmon: add POWER-Z driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanman Pradhan <psanman@juniper.net>

Applied.

Thanks,
Guenter

