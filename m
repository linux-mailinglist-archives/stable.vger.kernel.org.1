Return-Path: <stable+bounces-180403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DF9B8007A
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 16:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDCB6165FA8
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2651D2EE61D;
	Wed, 17 Sep 2025 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHQdZlm6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4662EDD6D
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758119507; cv=none; b=dVW8X0cB1BeyRT/hbBSHX7fO8BNbRV07hEN/rJOgcbMcPiZR7nS9CSidzoE+XtMd/Ah65J/DcQ7vgCTm1FmY4w3qPTQXhAz6GiaNBdOAjf2uioUrrBTS16ufZrgj4/mTp+U55RKUKSPVZLIAamlLD73c8GEzxI+hp3eQhWYGCdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758119507; c=relaxed/simple;
	bh=pmZTa+8cnY7Efr6/mRZy0dWltDPz1nlF8NdW0P91Y9E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AFOyeFc9MNDmtUC9cd2eqIBoKVdM2ZKU2y8geRDeaPXqVI5uqxYzQ+BTtARkDpHQewNqJErHnpXTGfHzx7abueuPjuw/4dmC4NSKXKWuW8Q7GW83sLnBRb8wz+aGI53M62QZ8cx468w1crkkS8Y5uOaNoraT77YWJNgJ9yGm9GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHQdZlm6; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62598fcf41aso9493521a12.3
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 07:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758119504; x=1758724304; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyY1RV/auovX2uJdCFMa3w6J8/ewCXkxPUNzbeKoZdo=;
        b=UHQdZlm6FfREwgu05wpI5BdkNT31V5dJKYkcA1EaCthiu75PTdoseiV+lM6YMpWRLh
         Z1vNYbS7Wo9ojMxun7qhGvFmX038VqYjBQBrkXoWwRdnw6N449GpQJm8mk0dsRWX9gkl
         czHnw2NKvUfN71vkjglJyuvjUuRs07zCypvFHaz8BR6vVUXNBJf/+i1iOZJPsD7xYfTE
         YbR5A2GZSs8uLoMbxS9ZRtZ3K+C1qIL/BztW/QtQZho73omSFrHWyEaovwmeN7Xo3vBW
         42naUpdLwlkaw7OulfcHc3F7ZoR+yFb8FFYXf+izAiQbV11B/upY3WWuXgxMDhM09vX/
         QGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758119504; x=1758724304;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IyY1RV/auovX2uJdCFMa3w6J8/ewCXkxPUNzbeKoZdo=;
        b=C+Q2FJOccz2NMjP4AqUwLB01y8P1RaSuyjHCFfEtsF6JjIMCM1MMONVA/HH8AzPEgk
         7WI7yCaB+O71SzILuF81DOLqX/5MabBi0Ua6s0dib7ywmu16DnxyUwrmKgHSIgebEMvN
         PKR1Ln2s6FNi+ylwhz5/aPy+LZSCs7L1w9CWuwa6tcgM/OcvnokVcFJ7dYxNd1AlEJmS
         gX7z0Ngd9dVVZ85of2UM3AvzWZ/6WDK1eo7yOL+Om/5bBdvrfUyg8JRx7u89DztXcdwk
         KY9lMfrTrDdnQ4Y9uVuXPScvYvCg8sjSboKEuPrMuzywAkz8gREncZGFN67pPnVTZulQ
         GBow==
X-Forwarded-Encrypted: i=1; AJvYcCXrNxQQNVwIoagrPZFn3E8L9V/v0kIAfHoVb54BL6S+FQu2Btr6lSkSELCQQ/LeHwpiu8evxD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/OmaviZFgcg/jdGLgjMjiLVSE8oMhwFfpDhu0Hqe8bUUO0yO+
	qH+xfYbIGVCbJS/tj3+OQxtr1PqzlV3SoE+zhtDWdjaWKseyd/u2ImDtjf/ew8VRrfc=
X-Gm-Gg: ASbGnctj8AbLPgRFq4TsK22K05dg1mgjIEwWutGi14RzlTNDoSKvLnRqopoLMaarq2z
	Mpuuq0n8S8nmRnYenDBoeSV84xxtmZVWX++i+lQDw8GLg37KL/nvNlBUWFADqbZqUFbAWwqQ1Rq
	jqd9RleA4jh1JZV/0F6kzcBso1Pi7rd78oHyzw9OLHTxpmvuiuhL1YJV7Z45IUrUkQW9A8KI2zT
	R1H5Ex1vThhb+Ilbe7ixpZar3qQ47b6DY+nXIfojd4+wFJ6I/2leYpKLEfLPycBJu+Ynvp8M5/K
	fwp0AQiADyHPPIRQPued9ftDXDYgUewFztnaPUSVlWhgR+YVgeC1TQe4sgVYmmiZMxGKhf8YZP+
	mXCexWHKxtXsEqAGfu6wZM+xCD/DrUEJlQ9tcOX8e4U+hHhc6waLr33NEZQ4+z1fW9jY=
X-Google-Smtp-Source: AGHT+IGSu0kLCnKgEdILIwXArUGLgXbeJB2AOyLfpHxUrOACUzPlxCRqec4ro27CMYP0cvBESnTAKA==
X-Received: by 2002:a05:6402:3252:b0:615:6a10:f048 with SMTP id 4fb4d7f45d1cf-62f8443a507mr2008537a12.33.1758119504155;
        Wed, 17 Sep 2025 07:31:44 -0700 (PDT)
Received: from localhost (public-gprs292944.centertel.pl. [31.62.31.145])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f70984065sm2433229a12.33.2025.09.17.07.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 07:31:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Sep 2025 16:31:40 +0200
Message-Id: <DCV5CKKQTTMV.GA825CXM0H9F@gmail.com>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, <stable@vger.kernel.org>,
 <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, "Lukas Wunner" <lukas@wunner.de>, "Russell King"
 <linux@armlinux.org.uk>, "Xu Yang" <xu.yang_2@nxp.com>,
 <linux-usb@vger.kernel.org>
Subject: Re: [PATCH net v1 1/1] net: usb: asix: forbid runtime PM to avoid
 PM/MDIO + RTNL deadlock
From: =?utf-8?q?Hubert_Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>
To: "Alan Stern" <stern@rowland.harvard.edu>, "Oleksij Rempel"
 <o.rempel@pengutronix.de>
X-Mailer: aerc 0.20.0
References: <20250917095457.2103318-1-o.rempel@pengutronix.de>
 <c94af0e9-dc67-432e-a853-e41bfa59e863@rowland.harvard.edu>
In-Reply-To: <c94af0e9-dc67-432e-a853-e41bfa59e863@rowland.harvard.edu>

On Wed Sep 17, 2025 at 3:54 PM CEST, Alan Stern wrote:
> On Wed, Sep 17, 2025 at 11:54:57AM +0200, Oleksij Rempel wrote:
>> Forbid USB runtime PM (autosuspend) for AX88772* in bind.
>>=20
>> usbnet enables runtime PM by default in probe, so disabling it via the
>> usb_driver flag is ineffective. For AX88772B, autosuspend shows no
>> measurable power saving in my tests (no link partner, admin up/down).
>> The ~0.453 W -> ~0.248 W reduction on 6.1 comes from phylib powering
>> the PHY off on admin-down, not from USB autosuspend.
>>=20
>> With autosuspend active, resume paths may require calling phylink/phylib
>> (caller must hold RTNL) and doing MDIO I/O. Taking RTNL from a USB PM
>> resume can deadlock (RTNL may already be held), and MDIO can attempt a
>> runtime-wake while the USB PM lock is held. Given the lack of benefit
>> and poor test coverage (autosuspend is usually disabled by default in
>> distros), forbid runtime PM here to avoid these hazards.
>>=20
>> This affects only AX88772* devices (per-interface in bind). System
>> sleep/resume is unchanged.
>
>> @@ -919,6 +935,16 @@ static int ax88772_bind(struct usbnet *dev, struct =
usb_interface *intf)
>>  	if (ret)
>>  		goto initphy_err;
>> =20
>> +	/* Disable USB runtime PM (autosuspend) for this interface.
>> +	 * Rationale:
>> +	 * - No measurable power saving from autosuspend for this device.
>> +	 * - phylink/phylib calls require caller-held RTNL and do MDIO I/O,
>> +	 *   which is unsafe from USB PM resume paths (possible RTNL already
>> +	 *   held, USB PM lock held).
>> +	 * System suspend/resume is unaffected.
>> +	 */
>> +	pm_runtime_forbid(&intf->dev);
>
> Are you aware that the action of pm_runtime_forbid() can be reversed by=
=20
> the user (by writing "auto" to the .../power/control sysfs file)?

I have tested this. With this patch, it seems that writing "auto" to
power/control has no effect -- power/runtime_status remains "active" and
the device does not get suspended. But maybe there is a way to force the
suspension anyway?

> To prevent the user from re-enabling runtime PM, you should call=20
> pm_runtime_get_noresume() (and then of course pm_runtime_put() or=20
> equivalent while unbinding).
>
> Alan Stern


