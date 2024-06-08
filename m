Return-Path: <stable+bounces-50028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE69901170
	for <lists+stable@lfdr.de>; Sat,  8 Jun 2024 14:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88FAB281BB9
	for <lists+stable@lfdr.de>; Sat,  8 Jun 2024 12:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175911779AB;
	Sat,  8 Jun 2024 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgUp+6NJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727225339E;
	Sat,  8 Jun 2024 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717849439; cv=none; b=nvpPFIYlfhhpVgOQOcW+AK0UIqKMwBtX+01v68HF113zuHqFMF1uYlQoMzUR1uC8IOI+zGtkT9Qwxu/YZOwUH3DLp6TCwUHWuZbhFvlcC0FStIlBBuhlD712usDrPviSUj+2QwJKLrWdNShv9VajmTmdiHL9CvJYm+KXZWVFSZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717849439; c=relaxed/simple;
	bh=paZzNIoNWPwjSqLSOF56SVpfrbPEzA1C//TqL2Fbck4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtjdYktYubTjlDYg0JhiSltoHlk8mnfsL23njCmSENmW/WasU1Nc8RZnWcVSdSw9BY9Nz42ENhlvy97t/YQ7ACAJBn6DYfAN6hFUA4gNXN8Mpd5rpbypDky3QG257JsIXNOah6VPe2cUYQR6Nl52Ig01kiT4C2Uf4NTPXtwmuU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgUp+6NJ; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5b3356fd4f3so357620eaf.1;
        Sat, 08 Jun 2024 05:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717849437; x=1718454237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paZzNIoNWPwjSqLSOF56SVpfrbPEzA1C//TqL2Fbck4=;
        b=WgUp+6NJpGrdGj3bonBJ1MrnxcLPwNFcBw5qQlgZ2S7fK1/GwEVaVEfiZLP+ICr9co
         A+RyuhqMgJ1MOI9NEew9N68XmQR087BnJ9TJ6iVUZRdTzougQ2ToIqXs6P/BYWbbsuWz
         502Fzjjn+3sThcNcGWufWTtNw9JB/dkUItJwDZlP0cPpkz59FoHrSBx8B0P9L3lfFrFb
         x55dU5Z62vNkDOiTWW+F9QzXxpCATyz1Ud69eDJAyCEc3RAhPI4JSpYQCGDqMeJGOqE6
         8SGKUO7CIpIKsb2ZBArPEnlsgEukZR791UzCAUHf5JtqULwgVPab3884oDtABoRoVxTG
         xWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717849437; x=1718454237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=paZzNIoNWPwjSqLSOF56SVpfrbPEzA1C//TqL2Fbck4=;
        b=k8/bcDs0GcpYX1psmp5pIV+Trx1AW45GD+2F6cJ5LDHToy+/LluxzN4OVisO0RVTEu
         jkdNbyvVDF72OSFhXIel8o+fdNBNhI/gwE6gUfjUatF2ieMnyyQb56qD4i16kYvehY+4
         Hu9mYocYdNXwdFcEXFkesB956bQvax2h4eezt1hucLX5xl5DOWDt8MR93rZAGpK6m60k
         RO6pzMeqa1rMTasB9p1Y+ghzEVlEUslMqRJSNPzLKSOrsT3lcE+0uOHVKTfq62z8vyLG
         8zENWXCF7Iix+nbqUfSJl3ZZW4+kIbMFgFF6HyXDETqh5XXzYWIRqi+xloSC/UooVyLx
         sexQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFjgbSVfMLblXPlMRt7Vm7shE9la6pJmOyaPWEEt0ijHJMKB79HZdkL2Btcrwpwzvc3JhBB8BjUqkkqczUAIDQbG3HC2bABLIZTQDmPWR/
X-Gm-Message-State: AOJu0YwtjwZe/ZCEiP1l0k5sBi0vFqf0aLL3rV8YNSPYl7LCVZwMi4eh
	Kb6O9jKsnU/oPdJ0RqMX0zYUYiONDR6EP5WgiSZwpPmbNNkp39p+inopatIcWAQ59JEQEMNOHvw
	wBdk7km4Hkf4vVSHMjZNtUoWjmPI=
X-Google-Smtp-Source: AGHT+IEpsTRlGjAU78qvzAR1ygY8g4G5Pv2AiwukygGOg5uryjd4qMs+dMhsrnbGKnXwlF7m08kKbB5o7zN5KYpn9sQ=
X-Received: by 2002:a05:6870:d626:b0:24f:e599:9168 with SMTP id
 586e51a60fabf-25464811013mr5131493fac.1.1717849437334; Sat, 08 Jun 2024
 05:23:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGew7BttU+g40uRnSCN5XmbXs1KX1ZBbz+xyXC_nw5p4dR2dGA@mail.gmail.com>
 <250a5988-271a-4a64-8fee-5aa48592c6ef@molgen.mpg.de>
In-Reply-To: <250a5988-271a-4a64-8fee-5aa48592c6ef@molgen.mpg.de>
From: =?UTF-8?Q?Timo_Schr=C3=B6der?= <der.timosch@gmail.com>
Date: Sat, 8 Jun 2024 14:23:46 +0200
Message-ID: <CAGew7BtfCWty-eG08svByD7wGFj7COPLpfL=eApS2Vkj2cTxCA@mail.gmail.com>
Subject: Re: Bluetooth Kernel Bug: After connecting either HFP/HSP or A2DP is
 not available (Regression in 6.9.3, 6.8.12)
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
	linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,
I built kernels with bluetooth-next and it's the same problem on both
systems. After reverting 84a4bb6548a29326564f0e659fb806
4503ecc1c7 the
problem is gone.

Best regards, Timo

Am Fr., 7. Juni 2024 um 05:55 Uhr schrieb Paul Menzel <pmenzel@molgen.mpg.d=
e>:
>
> #regzbot ^introduced: af1d425b6dc6
>
>
> Dear Timo,
>
>
> Am 06.06.24 um 22:46 schrieb Timo Schr=C3=B6der:
>
> > on my two notebooks, one with Ubuntu (Mainline Kernel 6.9.3, bluez
> > 5.7.2) and the other one with Manjaro (6.9.3, bluez 5.7.6) I'm having
> > problems with my Sony WH-1000XM3 and Shure BT1. Either A2DP or HFP/HSP
> > is not available after the connection has been established after a
> > reboot or a reconnection. It's reproducible that with the WH-1000XM3
> > the A2DP profiles are missing and with the Shure BT1 HFP/HSP profiles
> > are missing. It also takes longer than usual to connect and I have a
> > log message in the journal:
> >
> > Jun 06 16:28:10 liebig bluetoothd[854]: profiles/audio/avdtp.c:cancel_r=
equest() Discover: Connection timed out (110)
> >
> > When I disable and re-enable bluetooth (while the Headsets are still
> > on) and trigger a reconnect from the notebooks, A2DP and HFP/HSP
> > Profiles are available again.
> >
> > I also tested it with 6.8.12 and it's the same problem. 6.8.11 and
> > 6.9.2 don't have the problem.
> > So I did a bisection. After reverting commit
> > af1d425b6dc67cd67809f835dd7afb6be4d43e03 "Bluetooth: HCI: Remove
> > HCI_AMP support" for 6.9.3 it's working again without problems.
>
> Thank you for bisecting the issue.
>
> > Let me know if you need anything from me.
>
> If you could test the master branch or bluetooth-next, and, if
> reproducible, also with the upstream commit
> 84a4bb6548a29326564f0e659fb8064503ecc1c7 reverted, that=E2=80=99d be grea=
t.
>
>
> Kind regards,
>
> Paul

