Return-Path: <stable+bounces-114040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA1EA2A2A9
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 08:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B5E1885297
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 07:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0115225A59;
	Thu,  6 Feb 2025 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9fVOtFE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4997C225A4C;
	Thu,  6 Feb 2025 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828351; cv=none; b=ngwG1BEdyx+UOgvE+qySrLSsHTaOhiUmJnZ/gsYrCT4l6lIUQ02zWrC7FI515k5HBwuw8aDCoPUM603EKHpz8YfycJOISa/Oarfda6x1UlgKtYB41vABTfxV/TNbXuMNdcfEMrRvsDXUie35CwCF6z1nKZH7UoHay5XPkXN3g24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828351; c=relaxed/simple;
	bh=JNGdLVOeh2u3LfPFwDeakrrHIl4B6WTrzvbCBTqoGeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ds4v4p3puQt/75hISuraQvw+EOapVHV+Jg/vFxcOaYvfi+Ld4p9uoCjSyYttsWwXn8fOaclAhXjFx4S/MvM2T3yMUY5wnUXhquNUYnX/5TzCLSV3Z8AIApvTgyn265Jzd7UG9Amtta8pGXul/KRDw5y3SY9V9O1lEUdJoboQvwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9fVOtFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF1FC4AF0B;
	Thu,  6 Feb 2025 07:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738828351;
	bh=JNGdLVOeh2u3LfPFwDeakrrHIl4B6WTrzvbCBTqoGeY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m9fVOtFErGQpnJf5/iN5CB1c0VupczSJaRHZaDv2SOKgQV7lqNh8LA0QBEoXhlgg6
	 YBQmHjIonQrlf/Z8zr/h9bbXNzln+SaFYPyqeD+nrNunWuP1aQF40o38u6SZz5QAxt
	 ZKFRZ+MSugUteJtAXmnal48H0sX0XwE0aOodcb63EWtOuCR1hQdMCFH5xgwoiJF2Mq
	 PCigyV1dDo2eoXbnmY9TYVqsMwQsPXisHncM5P4G7Q+XS9W0je3rOaEOdCApfFUb+9
	 o/fmQxpPFQuPA4UrfjQ13VgtWmxZE615O41KGTAdkcSzZg9/hbYa+xsctSjLZAUV0Y
	 JF7cGdGA84W5A==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dcdb56c9d3so1129294a12.0;
        Wed, 05 Feb 2025 23:52:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUIWwlJIUUyGFbk8+EuO6CvwwJA5X5tbUauzVVirldbBG70HKv30MBNsYgmCBriYRfnTzaToEHz@vger.kernel.org, AJvYcCUfFiqZY5u/EthgWNd5S3tS4KTX1KByFUbRVwOeqmUNFQm6FmerhYoH7PxVnGpX+F9fOeO/3Y+qQDUogDk=@vger.kernel.org, AJvYcCVs894KtmQwqo32ltsoYqDoqf5tUZBS33OTHXSJ65sh7zYrfM5IJBLQ8cjnd7IIl1JkSL0ijVXO@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh9wU7Obsvh1acgHWUFGV6H4sENHnqjvM9/K2Yzhb6r916Dw5l
	Cix8IAJRklQ8gztAqI8n9IASsd274v0wEnkyld4fZcclWwmtRCr+8f8amNKkc35aB/4ndmblArF
	G8KZ91Md3gEW6BNz5YI0RrBU2PB0=
X-Google-Smtp-Source: AGHT+IH24vRXBYoqM/jKh3fYrGtREWzXUQuxr3aqDKc+0gt0XoP0E0jPFsfdnTA3uGJugs8u05hHKqeHbKBb9kMpP9U=
X-Received: by 2002:a05:6402:4486:b0:5dc:74fd:abf1 with SMTP id
 4fb4d7f45d1cf-5dcdb728ea9mr15097911a12.15.1738828349606; Wed, 05 Feb 2025
 23:52:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121093703.2660482-1-chenhuacai@loongson.cn> <20250127140607.6b3617df@kernel.org>
In-Reply-To: <20250127140607.6b3617df@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 6 Feb 2025 15:52:21 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6oGvixPkPJ+fr8edxAu8rgjPwgaDh508cSzdAFG8Hrqg@mail.gmail.com>
X-Gm-Features: AWEUYZm2wkOOP8qw23WLa1Zx8_PUScQBUh61vYQPDWNLR3cFPdaLul3L2ZbvAK0
Message-ID: <CAAhV-H6oGvixPkPJ+fr8edxAu8rgjPwgaDh508cSzdAFG8Hrqg@mail.gmail.com>
Subject: Re: [PATCH] net: stmmac: dwmac-loongson: Set correct {tx,rx}_fifo_size
To: Jakub Kicinski <kuba@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, loongarch@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Chong Qiao <qiaochong@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jakub,

Sorry for the late reply.

On Tue, Jan 28, 2025 at 6:06=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 21 Jan 2025 17:37:03 +0800 Huacai Chen wrote:
> > Now for dwmac-loongson {tx,rx}_fifo_size are uninitialised, which means
> > zero. This means dwmac-loongson doesn't support changing MTU,
>
> Please provide more details here than "doesn't support changing".
> Does it return an error every time, but the device is operating
> correctly?
>
> Do the flow control thresholds also get programmed incorrectly?
OK, I will give more details, the root cause is stmmac_change_mtu()
fails if txfifosz is zero.

>
> > so set the
> > correct tx_fifo_size and rx_fifo_size for it (16KB multiplied by channe=
l
> > counts).
> >
> > Note: the Fixes tag is not exactly right, but it is a key commit of the
> > dwmac-loongson series.
>
> Please pick a better one, then. Oldest commit where issue can be
> observed by the user is usually a safe choice.
Emmm, the commit I picked is the oldest in the "stmmac: Add Loongson
platform support".

>
> Please use 12 chars of the hash in the tag.
OK, will do.

>
> > +     plat->tx_fifo_size =3D SZ_16K * plat->tx_queues_to_use;
> > +     plat->rx_fifo_size =3D SZ_16K * plat->rx_queues_to_use;
>
> Is this really right? 16k times the number of queues seems like you're
> just trying to get the main driver to calculate 16k.
> What if user decreases the queue count? Maybe you should add a way to
> communicate the fifo size regardless of the queue count to the main
 > driver?
Here {tx,rx}_fifo_size is initialised before stmmac_dvr_probe(), so it
uses the maximum {tx,rx}_queues_to_use to calculate.

If we use ethtool to decrease queue count, stmmac_change_mtu() will
get txfifosz larger than 16K, but stmmac_change_mtu() can still work
because there is a condition "if ((txfifosz < new_mtu) || (new_mtu >
BUF_SIZE_16KiB))".

This is not perfect, but it seems a perfect solution needs to rework
the main driver, and dwmac-intel also uses {tx,rx}_queues_to_use to
calculate {tx,rx}_fifo_size now.


Huacai

> --
> pw-bot: cr

