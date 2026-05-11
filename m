Return-Path: <stable+bounces-245296-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GsDFoIVAmrangEAu9opvQ
	(envelope-from <stable+bounces-245296-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:44:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3243513AF6
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F93031542E4
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C0A43900F;
	Mon, 11 May 2026 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3QdqWOg"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEF042EEC1
	for <stable@vger.kernel.org>; Mon, 11 May 2026 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518294; cv=none; b=JkJ/ST9ZEwJ+MiTvseXPZ2aMEcLDm3zXBSSq2PoSNfvTUdJCDXntzsfsI5dhj8Ll8J9pPeNlIzWgfuFoST9iuYi9DbnkZPNeysmhq0EwvwsoYwSInrPS3H/qA0JeoP0H+sIDhfw8lMKZR/Z7Ee2Nec+Lz3blBLoy6zPhddzn9W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518294; c=relaxed/simple;
	bh=sDOXYBEUZnUtmSTyT3uL3mtKxvhVKKfeSDiOOL5ymVk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IThKPrpks9T7vH4epD+kWuGIFLHzKgL2SbaEjGDhAK+dThl8q8bp/sfnu7EsT0HRucDpn7JiYMj4L5SQfaYlhg2TvCxAEeOGao3CN+PhzlyidmXBhPF++RJUAZZoRi9/9glVtfCmkyNH6LNY8RoXq0Uv9do0iLCp5/IWbt6fIKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3QdqWOg; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so11809355e9.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 09:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778518291; x=1779123091; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sDOXYBEUZnUtmSTyT3uL3mtKxvhVKKfeSDiOOL5ymVk=;
        b=E3QdqWOg2BKPr/FYoDt8DAu09qtFo73BEYxpFCONlytSAqxTMuaFBd6ZamuHmVPd4V
         xCte/QzP4zzZ/J1F5lUbUm7OMA8ar8rnFU4jmjn++xfcR8irQMnyx+sH9FEvB2QQkr+8
         ygJQLzSn/YQyvAxDLWAwIzKY2RtPHyvku36JhQocReMCZTTD8xJhOmJ07Zehp1i22sSq
         tfbdlu/J85M2IOwUu7n/aLYexNrnFslNCuRtzZAmksAeNoNLRKY+yBbBX6N4TJIVw5EQ
         N/YK/Tm2JfjBvLI2JsqwD9vLhEhDjkA2gTDOarANEN8FGL0kMgZSQaDsDZNAUGBWc93O
         4/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778518291; x=1779123091;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sDOXYBEUZnUtmSTyT3uL3mtKxvhVKKfeSDiOOL5ymVk=;
        b=kWVwEGt7mERNAQG9b7gzjf5Bt8OUPWWXmtE+AEW1sogbm2r82qD0uLub60Ni+H64sB
         vLogc2+FhJIyh87l4VZL1dX36xSGwQqfnWq6N6S9te7muMotKQUXo8dpvKqsP7XF6yfh
         pYFk+H/Uy3WcVjWPfVtpfokF4jcQ4hVVhRsdSZuWKoXNr85o7XxydOSVqDnsHpDy5F83
         sUN1DCVMhlEUVEKPaD9bXlR1HeVNFcIRKtbY658r/O00ACygPCBFZAC2y0exLJwpuwJX
         X2tHNswgUBZhcY5W49BRgNDMXxXGoE61X+KQkiilgUfEj8yoLc8OoFf5Z9wnAj0RAc9y
         a5dA==
X-Forwarded-Encrypted: i=1; AFNElJ9JcmTSMJFfQdwPHjyekNsL/tntpa7iysbpZ7hxFnZsUcg9GdWxkB3hOd319TOYlmCJJf12Wdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAWmYuYinWqtxdHMbGnI24tXSJl/V7m9yaGGnNr1CCWdVrP9yC
	O2gdlY+iuXDXHmhWYswYL9L5XzM9/XWJPktCQvTCTajG5GRjm5L19BhU
X-Gm-Gg: Acq92OHrqnvTMM5gUuXcgBHM6PKXPnyUkMnxqa7rP9tLJtNbsWOaKanBYfF5sdnND5i
	WAQUajJ6TwTatRgY2KLT0WTDj7xNX3zit1u4k1Sl2f5aiyqKYFEmK28r5YoOkXUd3MhatPdjKpO
	6frjpXNHwPQelfoSo5WeE8aUZGis3JsATiHlnF6ktFI60ZMAeYalRaiw909813WSSgd1dNj093e
	axyqbTHnJtA5gQINz0iPzuXfuQhwOAkB043WUj8KPpAbbhtP/X0AHpRvEgbI80Dc4HFL7JJz6DQ
	nUUuYjfyHpxjFrOalZh3xkm8devLY1wEvKM1fR2mTwE8fmy8ET/sqECCWExWFAheAtm7Y+4l4YO
	2gxqe52pGcS0TQUW2Sfb3H9KsrYvl3Hxp6Y+FXaXgq3W2A8rfgT8b0ewukRKQFpo4m/S7mxeXbG
	QyU0jDp9ytfw/ZW3zXqHMJgDCBXc03W0QpXYMZ2d8a69odwL9VDzQUvCBlJlk=
X-Received: by 2002:a05:600c:a08b:b0:489:1ba8:5bf0 with SMTP id 5b1f17b1804b1-48e51f4119bmr388918855e9.21.1778518291069;
        Mon, 11 May 2026 09:51:31 -0700 (PDT)
Received: from vitor-nb.Home (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8e62a2desm452865e9.9.2026.05.11.09.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:51:30 -0700 (PDT)
Message-ID: <becb54adc0bea88578c8fe4c7c1b7b68bf5cc6d4.camel@gmail.com>
Subject: Re: [PATCH] pmdomain: ti_sci: add wakeup constraint to parent
 devices of wakeup source
From: Vitor Soares <ivitro@gmail.com>
To: Kendall Willis <k-willis@ti.com>, Nishanth Menon <nm@ti.com>, Tero
 Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Ulf
 Hansson <ulfh@kernel.org>, Kevin Hilman <khilman@baylibre.com>, Dhruva Gole
 <d-gole@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	tomi.valkeinen@ideasonboard.com, sebin.francis@ti.com, devarsht@ti.com, 
	vigneshr@ti.com, vishalm@ti.com, vitor.soares@toradex.com
Date: Mon, 11 May 2026 17:51:29 +0100
In-Reply-To: <20260506-wkup-constraint-v1-1-0a4bce791b29@ti.com>
References: <20260506-wkup-constraint-v1-1-0a4bce791b29@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: B3243513AF6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245296-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivitro@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Kendall,

On Wed, 2026-05-06 at 22:16 -0500, Kendall Willis wrote:
> Set wakeup constraint for any device in a wakeup path. All parent devices
> of a wakeup device should not be turned off during suspend. This ensures
> the wakeup device is kept on while the system is suspended.
>=20

Thanks for the patch.

I tested it on our Verdin AM62P. As expected, suspend now fails cleanly wit=
h "-
19" when an SDIO WiFi module is registered as a wakeup source, instead of
crashing on resume:

ti-sci 44043000.system-controller: PM: failed to suspend: error -19

I did not test the IO daisy chain wakeup path, since that is out of scope f=
or
this patch.

Best regards,
Vitor Soares



