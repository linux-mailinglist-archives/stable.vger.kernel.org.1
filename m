Return-Path: <stable+bounces-249418-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Pf/KeWzC2q2LAUAu9opvQ
	(envelope-from <stable+bounces-249418-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 02:50:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 289FA575BEF
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 02:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 534AA300DD6D
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 00:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B056927A92D;
	Tue, 19 May 2026 00:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="AtSx4k1S"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6739275AEB
	for <stable@vger.kernel.org>; Tue, 19 May 2026 00:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779151840; cv=none; b=LM51TgDCIO0TDBzD4YA95+DMRMg4JkJm3QpUiiJptNSOg661+N/R/NtvqoMQROYg8rRQDMI/FwPNgjOZj7lgnVHOIaVs4uEGls6yCg4g2hUXrswKtSTXLC+LdGt5D4OOF5+3VVWxtaF21O4dWW2lN4rzc5lnwnlvhIoQ2k+ntTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779151840; c=relaxed/simple;
	bh=PnOorzYYabHeSc3XxBftXhuC64icwN+rEkBLBJ5Sddw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=eq5E9W8mekENs32uSCesfR4fH2C60HWGRBhl8P48RxvOjPUz/izqQ3xolSZFLUah60uBg9moPuo5IPoiGw+z8Mt6PaoQTUxIfw51zloUQNPUbb65QUVtWf6RHC7slU2mU634w4jtLJhQGV7KiIx5Ee4KiRiE2kufk0zamc9aYoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=AtSx4k1S; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2f3c623322bso9321064eec.0
        for <stable@vger.kernel.org>; Mon, 18 May 2026 17:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1779151836; x=1779756636; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tXl/22rkVvhZ4nUM4MbQlEreFWYdxVzxn1gtAZs1eA=;
        b=AtSx4k1S/w4HtbRht68BANm4Se3ny9ye+1bDz738CYbmowcNhTd+eawQPKsji13bh2
         Q1HiGT7EDb5DgWh8o76LC3JfPOkp4fk9e9S4ThVoz63Cm+ZFrzlTJ/XVu0gOlXO8gfzP
         TtwYD8skqLMq23vqI3ljKLyiljdlR9hePg4QNyFxP0iHqyFVDQZwDOd+xe0BLbpv6tvq
         O9pViAtqamwce0nE8h955nImgrk4D8qjY/t7gkkvd3Q0PoJPH5/Kru+zSNYUPCU5JFqc
         ojySzmukTH8rxRW6A3VLJRiQbTfSOR0HnyAKcM1D79QcH7SttJx+lJcoVi58jO1nwQsL
         y/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779151836; x=1779756636;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7tXl/22rkVvhZ4nUM4MbQlEreFWYdxVzxn1gtAZs1eA=;
        b=pI8m9JAyqCyISroSGruugFL36vaZUbAD4gDWKycSN0zKARBXG+RJP6FTCTey8eQLDR
         a8+tRFlv7p7jy9gnwVpNtPWfkjdU+c02lolu5MZc3sdM0oID/ABTSPAmUjxd66nskoci
         Ol0EE24S49v0nPW61RJ1+NYsVL03AALa5Mqxj3e879Rys2JRNvYbXYHIzWrlOwXan8Z6
         1ZtwB+dkmPkWTzaMXGNYjKFR0Xul356gPuAMZpALfMl18U6qD3AaTsyP2Na91R7e6TOB
         lpuUKZ2ck7DHDvyQiemx+IJ+yET0GU/6nivx291e5V+l8qqyDrvyH6sPvmP/4VfU+lOx
         lxOw==
X-Forwarded-Encrypted: i=1; AFNElJ9ilrWKo4m4RGJGrkCtN6Y9YOxObzsqPKG8w+4SMlKrU8NOr+EFmRSjjlOhub4JrftOtTYrtNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YybS6BKnGh9z4VTyf0l6vR5jagMwuQofzqQ+KM/plh8RIHLjV5d
	xnlBaT4ccUtPWawaZtvYEzlY2qG48o2mP0g8/AhLvYnGUwkefXH2zc6k2Nlb3GuArak=
X-Gm-Gg: Acq92OEMWYajn3JxeKkXaQgjyVDNRTtvggiTitJKBGwQT4rHdYb+sA7TqJWf6kVWjnz
	tN9nGyqi16C8bIUjQK+Q76PLKnlwqt7DZQ2d6vrXw3NUl3vVTl3egRQuKk0Mu1FVGvM1KsFKR0/
	/ah/r+A9dzSbpoedncfmLYlu9COQ2mwAdBzjm6lEUUjUlDCSiKxClcclhDK5q0ImnE63sQ5paaY
	fuxqx3TExo1+DQkq9pGj0dOKs8Bi2YYjth1seyCumaobkYJNW0+IdvOxcMOvrqCKhv8dgInL4aL
	nt1cRL/AmIxhE9fv28qzSSjvtd8If80OLL2WBEbawZD0LAv44nHYI03OrfMOzE43ng+PTVwoltG
	EKcizw1Fpzj6aHtWiKUtKMTJGGSSaLvPWlbCy+ipUnTbQswevgUOHnEegGISMsVSJwrj0eIknF8
	5WDX7SpPvxNgk4IEfEaso45ks=
X-Received: by 2002:a05:7300:fb83:b0:2ed:ff78:2c12 with SMTP id 5a478bee46e88-303986b7f00mr8980852eec.34.1779151835662;
        Mon, 18 May 2026 17:50:35 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978afe8dsm15256199eec.27.2026.05.18.17.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 17:50:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 May 2026 17:50:34 -0700
Message-Id: <DIM8OTDD82P1.V7SRZ5IA5CDL@nexthop.ai>
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Guenter Roeck" <linux@roeck-us.net>, "Abdurrahman Hussain"
 <abdurrahman@nexthop.ai>, "Alexandru Tachici"
 <alexandru.tachici@analog.com>, "Linus Walleij" <linusw@kernel.org>,
 "Bartosz Golaszewski" <brgl@kernel.org>
Cc: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, <linux-gpio@vger.kernel.org>, "Guenter Roeck"
 <groeck7@gmail.com>
Subject: Re: [PATCH v2 0/5] hwmon: (pmbus/adm1266) GPIO accessor fixes
X-Mailer: aerc 0.21.0
References: <20260516-adm1266-gpio-fixes-v2-0-801f13debcb2@nexthop.ai>
 <6ec6270c-595e-49b2-8465-31b5019de87c@roeck-us.net>
In-Reply-To: <6ec6270c-595e-49b2-8465-31b5019de87c@roeck-us.net>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nexthop.ai,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[nexthop.ai:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249418-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nexthop.ai:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abdurrahman@nexthop.ai,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 289FA575BEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon May 18, 2026 at 3:08 PM PDT, Guenter Roeck wrote:
> Hi,
>
> On 5/16/26 16:18, Abdurrahman Hussain wrote:
>> Five pre-existing bugs in the adm1266 GPIO path that all landed when
>> GPIO support was first added (commit d98dfad35c38).  Each is
>> reachable any time userspace queries an ADM1266 GPIO/PDIO line via
>> the gpiolib char-dev or sysfs interfaces, or reads
>> debugfs/gpio-<chip>.
>>=20
>> Patch 1 caps the PDIO scan loop in adm1266_gpio_get_multiple() at
>> ADM1266_PDIO_NR (16) instead of ADM1266_PDIO_STATUS (0xE9 =3D 233, a
>> PMBus command code that ended up in the bound by mistake).  As
>> written, the scan walks find_next_bit() up to bit 242 across a
>> 25-bit caller mask, reading out of bounds and -- if any of that
>> incidental memory contains a set bit -- driving a corresponding
>> out-of-bounds write to the caller's bits array.
>>=20
>> Patch 2 drops a redundant "*bits =3D 0" reset that sits between the
>> GPIO and PDIO halves of adm1266_gpio_get_multiple().  As written,
>> the GPIO bits the first loop populates are immediately discarded
>> before the PDIO loop runs, so any caller asking for a mix of GPIO
>> and PDIO lines sees the GPIO half always reported as 0.
>>=20
>> Patch 3 adds the missing "ret < 2" length check after the three
>> i2c_smbus_read_block_data() calls in adm1266_gpio_get() and
>> adm1266_gpio_get_multiple().  A device returning a 0- or 1-byte
>> response would otherwise compose pin status from uninitialised
>> stack memory and leak it to userspace via gpiolib.
>>=20
>> Patch 4 moves adm1266_config_gpio() past pmbus_do_probe() in
>> adm1266_probe() so the gpio_chip isn't registered (and reachable
>> from userspace) until the PMBus state the GPIO accessors depend
>> on is initialised.  This is a prerequisite for patch 5.
>>=20
>> Patch 5 takes pmbus_lock at the top of adm1266_gpio_get(),
>> adm1266_gpio_get_multiple(), and adm1266_gpio_dbg_show() so the
>> GPIO PMBus reads can't land between a PAGE write and the paged
>> read pmbus_core does in another thread.
>>=20
>> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
>
> Sashiko reported a number of additional problems. As far as I can
> see those are real. Would you mind fixing those issues as well
> as part of this series ?
>
> Thanks,
> Guenter

Sure -- v3 (sending shortly) folds in everything Sashiko flagged on
v2 that isn't already covered by the "buffer-bound and timestamp
fixes" series you applied to hwmon-next:

  - New patch 5: register the nvmem device after pmbus_do_probe();
    same probe-ordering hazard v2 patch 4 fixed for the gpio_chip.
  - New patch 7: take pmbus_lock in adm1266_nvmem_read().
  - New patch 8: take pmbus_lock in adm1266_state_read().
  - Patch 1 commit-message wording fix (Sashiko corrected the
    "27 unsigned-long words" arithmetic; no code change).
  - Reviewed-by tags from Linus Walleij (patches 1, 2) and
    Bartosz Golaszewski (the rest).

Thanks,
Abdurrahman

