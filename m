Return-Path: <stable+bounces-209946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C55ED281A5
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 20:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D2E4304F88F
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 19:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF22530AABE;
	Thu, 15 Jan 2026 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="Ifib+84y"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434A1309EEA
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 19:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768505404; cv=pass; b=eJGTC2KAcUQbCHzuJAgYrYBYHIfd9D8H0atp4j6UIF7AEUCWcZ0P/0BU9BwN2qxZ8/zyqoT3L383NaetPw5wWywtVPQK9C12+vrZbN0+pJeW9o0Z9nK7I15n7L8ESBeBAI2FgjwhmCEsvFeg1dp1h99rGDWmhUVGXc2UIAvAOac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768505404; c=relaxed/simple;
	bh=xpAe4VquDRlbvhlajgDJdW88OXpSMesEONtyCKGlhWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=neAoOZJr9imSe1m8G3MBJROR8FHpoC7vhNIp4B9P644hBKhqlIKqXxnCrj1+9nhbZgY3T1Uw9Oqwg/FaFgnPwGmPryaRhpnOF81e5DNGmLzrEjdO85ZVAcrGNwUuAUKnrAEFJ2R5w2ScIbIdMQybptF64tCvV8gNpDASQiclnOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=Ifib+84y; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64baaa754c6so1956027a12.3
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 11:30:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768505398; cv=none;
        d=google.com; s=arc-20240605;
        b=b6sqzIFdm7i9LQJOOi3W/zw6OdY6gFE5eLN/9S893ip4bwJpHtBLLvfGAr0nK/DaxN
         woFeykg0DnUB2UfGBuAYRNMzCZvYMsJ7JQqPGBr74WaFRw9IdvT3vs9XbiZxYOt4/cXl
         MhPkC8AI60tmB39ai9vge57so2aR6d0lVqnOLOxH0yZons+oGS0PjtewBx3brVhozrqC
         jLm4ZN4EDWZ4cNhbPk3pTGBL06WEUqymAbZJ9Gqp53sa3pp7qk2LU/G0MgN65YFzAK9G
         fVDOMtSdbxEAYwQzT0zFxq+z/Nz7/UAaXo6JvZ7bz0kMMkAvW4sTi1qpa3gJSnirHfxs
         CEhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RLeW5LqW4wx788qexxNJwmsPJ9CgRqRlygUR7u9scY8=;
        fh=Y74f01YznQtICCoVpDtu65QsUfM3VPu5xLIo3JzpQ/I=;
        b=VIBtoOn59Lr7MbfXfVlSGGF7N2h4rcqkuieOfGQha2JTlxOUiKH/D0XExD2O/HlmPM
         aezQ+DITCve9rV2vfa+9mpkhOmBh1yIpFWr/n8pBAupEuZO4jne91YgzIFIiZZMTpZ6A
         nsYHx401KZgor2T9q4FnBtjyUFNIkyO8AoqLxaLOYd7rsWQ0jqI5esYGvxbh/5hr4jGt
         HpRk2/G4dKO1rfkMNOD+qtPtbt2jjptJ/vJr+iwkISdzOm6p0nmRkzf+i7wJ72DU5XfW
         s7AHuePt0mQ5KXoTF3pHmS50SJyO/cqMuR+urAywiIPPU8649vpgauVcYDzmcJIHisOe
         dD9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1768505398; x=1769110198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLeW5LqW4wx788qexxNJwmsPJ9CgRqRlygUR7u9scY8=;
        b=Ifib+84yFmSZAGvmyWnPeovvWcyXQ5F7tmgZH6xUnlHO61FNFtbRCjHe1n0szAFjQf
         unlUcvkh32R7t1VZGgq2XW0Xb5zRPuVo+MZPxgj6BRN+vPQgssVWMcRUIJy9/Wygtqt6
         4fGei2y4KC32F8Z0ZqoluFxoAAXljgKl4mXV/F+1SI+tNp0r5YYVF6/fttyJdrrafqMl
         BmKbFf9+vHAFg1EwUZ9i55aRsWecfCM8mOArh1lSTQGxnvXfDwYGryIHMFskF2/7F1HD
         KipEVmTyYTgGC3obvBYLoUc/Vy2cm4O6JPVOmAKJkVa7II1cIr8O1KQdi7iOTrh86Ci4
         H+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768505398; x=1769110198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RLeW5LqW4wx788qexxNJwmsPJ9CgRqRlygUR7u9scY8=;
        b=Q4ApMrUTNI3rAG4YnZikdBEyU3vcrAvauPyAzpUi+yWvImDsllrnblLblOKeMRdRc5
         IGP44KKBnnRqedOfRFmSZcUg3NE6OoSlim/qVQqZhDSZ+pVVnwqiCNyop6txXHu39bvM
         g9C5HQBK5YtGgpa1uBLuICdkajxKEyd5QB+KQMHtTVDpynjzjZ+KsbWM0hVlu3HGPXhF
         /w2G6Ct2EG2/Gws+MJq66mBeTcdOf/EcqTjZVqgCxzxYJ/9DyO6LFZU3GyNvatHfG5nU
         tZx1AkoYamfhlgZBxJwX4Z8vy3+NX3PUFgxXOKKTRV5mKWvpOEDfdL9OLSBjki1CSLuQ
         mUJw==
X-Gm-Message-State: AOJu0Yw6F8TJ6wmfzBdzbbhJoL+mVcJN1Uz9UAYAZ3Ydr4nQahw8Hbow
	qCsP3YHXeyiHpEuVkry+up0oAcvwtBfsbmJbUNRAoSIFMo4EIsdw/0yYikubtosZ90QSo2uG9G6
	nWWUF6eDdc3+HI0fGayKDQl/Kd8DAs/LoYOEjAz0zQVZHnA8uREcNE1Vn1tBRcCyGuXcjziebhR
	llLNM/sKALa6af1ipqBytv+wfGvYs=
X-Gm-Gg: AY/fxX6mbZsns/9V03l5BC0ozFWR312VylJvfCA2zqdDfv+Loz/4cJkxHb/IoPEBf61
	Lvu6N82uqzUk8bOIv+ojulY/yrhWyTCUoC4hhk+fZfivm/Mbvg10pQdR9Lzn+KFgqcKzG05CBV5
	2AItu3rplELFsFyeRomIMx/BT97GwlnSAU2HUvAMG5jTyDGOuPSB2JhqhpcMaEt7xUaKb6Id5MY
	fJN9fdMFcegoJ3MsKPcafpMAG7YYygzNfPIC1BcNbG09eQadLm3K2Mj6jL9JtTjLdVL66QwAmyr
	0OZ1TpT/PmQeTHP1JrWkCIOTUgDH
X-Received: by 2002:a05:6402:1ec2:b0:650:891f:1c07 with SMTP id
 4fb4d7f45d1cf-654526ca179mr478548a12.14.1768505397625; Thu, 15 Jan 2026
 11:29:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115164230.864985076@linuxfoundation.org>
In-Reply-To: <20260115164230.864985076@linuxfoundation.org>
From: Slade Watkins <sr@sladewatkins.com>
Date: Thu, 15 Jan 2026 14:29:46 -0500
X-Gm-Features: AZwV_QjqLkCgApoRuKv35Ai4LvCRp9OylMJtBpKdZNvHB7wDFP7nb5QcJ6zDEls
Message-ID: <CAMC4fzKeXhgotO=3nB=csqZ=gaF9xRj2+AtfdqpLYE6j8dGQ7g@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/451] 5.10.248-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-SW-RGPM-AntispamServ: glowwhale.rogueportmedia.com
X-SW-RGPM-AntispamVer: Reporting (SpamAssassin 4.0.2-sladew)

On Thu, Jan 15, 2026 at 12:40=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.248 release.
> There are 451 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 17 Jan 2026 16:41:26 +0000.
> Anything received after that time might be too late.

5.10.248-rc1 built and run on my x86_64 test system (AMD Ryzen 9
9900X, System76 thelio-mira-r4-n3). No errors or regressions.

Tested-by: Slade Watkins <sr@sladewatkins.com>

Thanks,
Slade

