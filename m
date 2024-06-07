Return-Path: <stable+bounces-50021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93456900DD4
	for <lists+stable@lfdr.de>; Sat,  8 Jun 2024 00:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9671F23B85
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 22:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6F114F9D8;
	Fri,  7 Jun 2024 22:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCHOzLV5"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ABD12B93;
	Fri,  7 Jun 2024 22:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717797676; cv=none; b=Xesl4FzJ5azBFgwP3YRvOnMKRywEpDjBVKLC311PFSE8zKpu+LnIPEuZIBWf4C8dIX3Cl5L3ZA3iODghp8lzZj7svZ4pThkbSuEKeCTgNA2YdikyYCgM6EI+xWvAhaHvwDNMjW87wSEpVpPTZ7DDhy1BBX8MRGqcTQGghnuRpJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717797676; c=relaxed/simple;
	bh=IDFRZUCaRgT+IPHYguEUg6g4GU6L1L1720EL+LDGYqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZ1xDJkziff/o8pCwQR9c6bw1A1CSE960ZHFMa7DoXMVplD2h5zwn1rz/uV1gbeVbF7E9LWdhAjezM9CeWvLl80PyuAiFOO+egLdaz6XePtXqPMhmIQ2gWtaS+BqdVTx8xsu5x7lP/sJfRNpIDk9VXV/4v9Fh3bSpNvCd+SLjS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCHOzLV5; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eacd7e7b38so27691751fa.2;
        Fri, 07 Jun 2024 15:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717797673; x=1718402473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDFRZUCaRgT+IPHYguEUg6g4GU6L1L1720EL+LDGYqs=;
        b=dCHOzLV59f8/q9/KOp/eSJtI7jl1yiWPRWVt25SmW75xQN/+ONwGqKkrVVYErKqBOM
         dmVyxXVS7lhIFwlpNFZqyXSrqYpNhAg/NZID6OIIqUW1rWm5yueIANZTndKR6isv1ME5
         Gi6bYBvu6RG0AyFAk55ZLYnu8odTfdnSBqCM0WGk3VQPP3AH4F/5a6b4MXmLiuvScWPy
         PZ7cnMf7Y2Y5xCn3fmfCoTd+ylBqmoaJ3FbBTCWyWzwD5vZlzET1d4TkCEYyV/ZKUVE1
         zOOTwjN4vg2mBprQNON6lHmr/E50Osek1mrWXTdGnWdieI48v8etY29BM82S5Ll3hvkK
         GYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717797673; x=1718402473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDFRZUCaRgT+IPHYguEUg6g4GU6L1L1720EL+LDGYqs=;
        b=fkuOV47CxJXYpa876y8n+wtGdZeOepkXry2jmLuWvEWHxOEDbrtY5eGqRQAAXyPz2b
         5AQ/AN46eLvzDy35emFZbe7opWiftfaPzhPBZEvAd3e39Jevh6xIlBnsILEFD0DxVH5q
         F8VsMNX3e4lmlT8D4myBYkMLVyLzpi++2ruq5hPlt6KWJ+cp+1kTRuHDnvt20IANwDl/
         0zoEWb/0V9aWHF3PECA6Ez0rzlrsNIIzZuglJptVz7yGeD7mCnj8cHWfIitvVoHjE/XP
         vl1A1qF4znVykvAjbtYOUTxQCUWy/JeYdyrDSsWp8sahhRSpc2LFZh4L/Pd3pgEITAli
         /tHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEw6L0pxROmefuPYqip7DEUlqQr/1/nyqHae34sKol9s2p6vGa0FQ+ttDvZXHIPkeVmEc5QjlmfvkrH54cd7ZXmlm1AqXh3+99um27OcGs3g5GMTRMAZefkS8jTtjv5N7VLzvp297m
X-Gm-Message-State: AOJu0Yz8I2gwi7bGo9we+kFMTMobinBDDFTBuMS6+3xYsufd5cbKXhMV
	qv6yAMz9WWsSgOei2FdfQjGB2/cGhITBgyoJYqCVVfZJKfRLa/wdTOz1Pzduae7WVZyDNacuyfI
	BWSsbUiWjttBQqN4dmxypFgQFnTs=
X-Google-Smtp-Source: AGHT+IGZWRAamM1ugdxv9EnS9P+taqCrpoBBWYjXXXoAHxBvCQeQ0pVGsKHPxoHzv/iJ8bkc0F7OlA/lltsppFMR4Zc=
X-Received: by 2002:a2e:8ec6:0:b0:2eb:4d6a:76f8 with SMTP id
 38308e7fff4ca-2eb4d6a7c34mr5549651fa.40.1717797672179; Fri, 07 Jun 2024
 15:01:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGew7BttU+g40uRnSCN5XmbXs1KX1ZBbz+xyXC_nw5p4dR2dGA@mail.gmail.com>
 <CABBYNZLE9uYiRM-baoBt=RQktq__TguMETgmVWGzfeorARfm4w@mail.gmail.com>
 <212fca4c-fc1f-4da4-b48e-c6a4b64a2b35@leemhuis.info> <CAGew7BseJ18yjTu5AFWr=B3c41gXe4T=B0JqFWvXjQYvcDPfTA@mail.gmail.com>
In-Reply-To: <CAGew7BseJ18yjTu5AFWr=B3c41gXe4T=B0JqFWvXjQYvcDPfTA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 7 Jun 2024 18:00:59 -0400
Message-ID: <CABBYNZJqULvfnafB5vA4PHPtzs_qmEQK8JZ3C09Q=wmvSZqwBA@mail.gmail.com>
Subject: Re: Bluetooth Kernel Bug: After connecting either HFP/HSP or A2DP is
 not available (Regression in 6.9.3, 6.8.12)
To: =?UTF-8?Q?Timo_Schr=C3=B6der?= <der.timosch@gmail.com>
Cc: regressions@leemhuis.info, stable@vger.kernel.org, 
	regressions@lists.linux.dev, linux-bluetooth@vger.kernel.org, 
	luiz.von.dentz@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Timo,

On Fri, Jun 7, 2024 at 5:43=E2=80=AFPM Timo Schr=C3=B6der <der.timosch@gmai=
l.com> wrote:
>
> Am Fr., 7. Juni 2024 um 08:10 Uhr schrieb Linux regression tracking
> (Thorsten Leemhuis) <regressions@leemhuis.info>:
> >
> > On 06.06.24 23:23, Luiz Augusto von Dentz wrote:
> > > On Thu, Jun 6, 2024 at 4:46=E2=80=AFPM Timo Schr=C3=B6der <der.timosc=
h@gmail.com> wrote:
> > >> on my two notebooks, one with Ubuntu (Mainline Kernel 6.9.3, bluez
> > >> 5.7.2) and the other one with Manjaro (6.9.3, bluez 5.7.6) I'm havin=
g
> > >> problems with my Sony WH-1000XM3 and Shure BT1. Either A2DP or HFP/H=
SP
> > >> is not available after the connection has been established after a
> > >> reboot or a reconnection. It's reproducible that with the WH-1000XM3
> > >> the A2DP profiles are missing and with the Shure BT1 HFP/HSP profile=
s
> > >> are missing. It also takes longer than usual to connect and I have a
> > >> log message in the journal:
> > >>
> > >> Jun 06 16:28:10 liebig bluetoothd[854]:
> > >> profiles/audio/avdtp.c:cancel_request() Discover: Connection timed o=
ut
> > >> (110)
> > >>
> > >> When I disable and re-enable bluetooth (while the Headsets are still
> > >> on) and trigger a reconnect from the notebooks, A2DP and HFP/HSP
> > >> Profiles are available again.
> > >>
> > >> I also tested it with 6.8.12 and it's the same problem. 6.8.11 and
> > >> 6.9.2 don't have the problem.
> > >> So I did a bisection. After reverting commit
> > >> af1d425b6dc67cd67809f835dd7afb6be4d43e03 "Bluetooth: HCI: Remove
> > >> HCI_AMP support" for 6.9.3 it's working again without problems.
> > >>
> > >> Let me know if you need anything from me.
> > >
> > > Wait what, that patch has nothing to do with any of these profiles no=
t
> > > really sure how that would cause a regression really, are you sure yo=
u
> > > don't have actual connection timeout happening at the link layer and
> > > that by some chance didn't happen when running with HCI_AMP reverted?
> > >
> > > I'd be surprised that HCI_AMP has any effect in most controllers
> > > anyway, only virtual controllers was using that afaik.
> >
> > Stupid question from a bystander without knowledge in the field (so fee=
l
> > free to ignore this): is that patch maybe causing trouble because it ha=
s
> > some hidden dependency on a earlier change that was not backported to
> > 6.9.y?
> >
> > Timo, to rule that out (and it's good to know in general, too) it would
> > be good to known if current mainline (e.g. 6.10-rc) is affected as well=
.
> >
> > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat=
)
> > --
> > Everything you wanna know about Linux kernel regression tracking:
> > https://linux-regtracking.leemhuis.info/about/#tldr
> > If I did something stupid, please tell me, as explained on that page.
>
> Hallo Thorsten, I tried with 6.10-rc2 and it's the same problem on my sys=
tems.

Could you please create a issue at
https://github.com/bluez/bluez/issues and then attach btmon traces and
bluetoothd? This is a really weird regression, also is your system
using pulseaudio or pipewire?

--=20
Luiz Augusto von Dentz

