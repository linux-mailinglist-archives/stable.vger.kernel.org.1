Return-Path: <stable+bounces-254109-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LTlFxQLFGr6JAcAu9opvQ
	(envelope-from <stable+bounces-254109-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 10:40:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D10415C7E87
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 10:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56F4B30268B8
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 08:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104073D8132;
	Mon, 25 May 2026 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STo8Ewap"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711EC3E3C73
	for <stable@vger.kernel.org>; Mon, 25 May 2026 08:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779698224; cv=none; b=RvoaByiI+B6+61x7DoXzqRLet003nUiwSGOPFH34pMAbYSawHGX8aWAcVb2XxJqdF8hTktCYRa3kJfgD09d//tvf9kjETI71rCPjL6cYIjp2kFieAa/iNQ9W50ONB7vymioB8OpWAnSJTUDVM3WooxgIQn73kqcyOBWqaCLyWIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779698224; c=relaxed/simple;
	bh=IEiv6ppFYux2Sd53XihNqei/CAFoKAVx3MrnHuAZjxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJw7Ih9/jPbrcp4nmzCwttxSrs1DNkkggeuj5J0Io/KLnACTf/o3pP0k/NZmmjt2W7KKEoazAquC4hySy4w2mGePybXRPc+Oe+bWm0whSwOlx7HrdRf4imGc8fOTJwQFxpfWT8f/6I7Ws31pl6sS+gB6B+LcZrinxrhSQpArp+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STo8Ewap; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4D21F00ACF
	for <stable@vger.kernel.org>; Mon, 25 May 2026 08:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779698221;
	bh=IEiv6ppFYux2Sd53XihNqei/CAFoKAVx3MrnHuAZjxw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=STo8Ewaph8yEAbcCVRqpS77EFgKwNXQa/J981+WY+PMPKRzYpcb60uC1DQx+eqVun
	 UVbgab92pqiy3i/OG1wYwZlEjiukNAb5wpbzaFLkEVl792gaV4zVNnoUaPG3yZj7tA
	 za9+i4U92VQ95b9NBws7YL7Oh+OnD1bCtKA2WkA8zB3p18PAAEO63HlQygs2Ig05y4
	 D1p6r0aVysolpAc42jT9xyM+C02SdUqab9gC2Trnbpk6zuc3+BJR8C2hoXbG+qQl/L
	 SjkSemEDs/u3u50PKQxGZhdknCxnUmFbV13WOlWkg1VjNn6DzI/8zpISzpfMwvvxP/
	 +App7kR59caKg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a8721851e2so10569687e87.0
        for <stable@vger.kernel.org>; Mon, 25 May 2026 01:37:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8hi/EBFUUOvDyy1HbbyfbajFuVYd0y3i3D78OMYWROjOzgs2R75549QpuyaSk5YGUY2mUuPnw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk27cd0WhH64nqtc+yqxvNhlUF/dnDRxoZ5Bh4bxn6EM17npZY
	w9RuyU596I6uMkvQS9E2RcyTT0bRG/8mt6vh4/oJhVJfnhGWgF3dLEkyoDtEqi6499xZwBowwvs
	G0nyPp7tje+7jJO8uT1mEDNqk843JqSw=
X-Received: by 2002:a05:6512:1082:b0:5a8:96cf:c8c4 with SMTP id
 2adb3069b0e04-5aa3232a140mr4367217e87.15.1779698219721; Mon, 25 May 2026
 01:36:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516-adm1266-gpio-fixes-v1-0-38d9dd39b905@nexthop.ai>
 <CAD++jL=rasuYTot3M8u75PXRgrhbCzpue=pY2Yxx7ymVwhgGGQ@mail.gmail.com> <8855d587-8351-42f4-8f79-9e763f56ccf0@roeck-us.net>
In-Reply-To: <8855d587-8351-42f4-8f79-9e763f56ccf0@roeck-us.net>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 25 May 2026 10:36:46 +0200
X-Gmail-Original-Message-ID: <CAD++jL=TV-UEJD1dZVfWhv3rCG4B_9A7bA56ZXOiLmaYGysYQw@mail.gmail.com>
X-Gm-Features: AVHnY4J4wRuxqubn3frRZE4rkZoNRmpScnrgJSL-JsP8y2yZAjddaBh2LbJNBeM
Message-ID: <CAD++jL=TV-UEJD1dZVfWhv3rCG4B_9A7bA56ZXOiLmaYGysYQw@mail.gmail.com>
Subject: Re: [PATCH 0/2] hwmon: (pmbus/adm1266) adm1266_gpio_get_multiple() fixes
To: Guenter Roeck <linux@roeck-us.net>
Cc: Abdurrahman Hussain <abdurrahman@nexthop.ai>, 
	Alexandru Tachici <alexandru.tachici@analog.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254109-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,roeck-us.net:email]
X-Rspamd-Queue-Id: D10415C7E87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 12:25=E2=80=AFAM Guenter Roeck <linux@roeck-us.net>=
 wrote:

> > 1. Convert this driver to use regmap
>
> That would mean to convert the pmbus core code to regmap,
> plus all the pmbus client drivers.
>
> PMBus uses a mix of registers/command with different size, plus some
> block commands. That would be a difficult task. Byte registers can be
> mapped to word size, but for block registers that is difficult,
> and then there are commands with zero data length. Maybe someone
> managed to do this somewhere. I tried some time ago and could not get
> it to work.

I didn't know PMBus was that complex and honestly thought it
was something simple that had been regmapp:ed ages ago ...
allright, definitely an exercise for another day.

Yours,
Linus Walleij

