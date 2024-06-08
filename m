Return-Path: <stable+bounces-50029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2418E901172
	for <lists+stable@lfdr.de>; Sat,  8 Jun 2024 14:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161591C20E66
	for <lists+stable@lfdr.de>; Sat,  8 Jun 2024 12:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4289D1779BB;
	Sat,  8 Jun 2024 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7ihe5fL"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB1F11718;
	Sat,  8 Jun 2024 12:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717849502; cv=none; b=CcCEtq5EvG+ZLq9k+FH1q5mcYhwWCPzggjikmvECeM3zRPWnbLIjp2Ho4/09OoVDRdKuxtp6zEBuPG1Q9EPiXgbG1MMaTWRdRkQZgGKyU1yHx0m/tNXQMdstTwG13E4XnqmE5+TpmLEnSVQgXpzHlfChJ7GOm2IyxrGkzNMae3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717849502; c=relaxed/simple;
	bh=QoinzhZ0NTt2RazVwLGKw0mPLwu4odIDkMio21l5+mU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mopuIC3sHGkQ/j9hlCV6YaHpB3E0ar+q7r4LLoDmOydSJyb04cfP1I/YWO31gGu6BC3pmOPgh+y9okfgQ48MVE/qd2iIAvMRFvYJusFtuIDS+Pwp0CAy19kxSGwtrbwhwciygs6gvLZI+10LMvqcvd8EaN+uG6Tk/E7QY3Ylplo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7ihe5fL; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7952a920e13so3718085a.2;
        Sat, 08 Jun 2024 05:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717849499; x=1718454299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoinzhZ0NTt2RazVwLGKw0mPLwu4odIDkMio21l5+mU=;
        b=j7ihe5fLLe/RUQdS6tgxDvo2U6XpYFY43vIj7WCGJ+VXR8EFsUGu8tCJbFS/nwO6VX
         Y3IXUYuynBlOGz4oC1XSotcv5kMryGI/zH4ifGL3KqA4CsCbeWwJ6IyZp5y/65So1fXz
         Thxy3o8BK6tIfUI73/EQ0ySqaJd+YcxQKH4xrgPuKfftL+9G1vJcqEJVQnC3P0qYo4V9
         d0opg47v8I4MaYjIGmDlTjbuTXEBibrrAYejFYFbAjLRv1YFl/7dXfYHe1TxJ/B6rW76
         jiMOmI/t3oVzOqFJNkaQ4jMADpIUuEzOwHNFgkMdhr9zpXoMJdw3SGqBos1GsOKTd0hR
         DyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717849499; x=1718454299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QoinzhZ0NTt2RazVwLGKw0mPLwu4odIDkMio21l5+mU=;
        b=C0gDBPS+MhAPYqCIwk8On211Y2IqnDfHZ/8aebOq1mmVKnkXRixONk9PPVTdAMxjy8
         eL9Ymm/zWHDorvCEjCeNMBTs8Rq6LVCsJpuMjjbTZVb+1xomXVj2efQ0FXs+JxXvMSfz
         6CK2PIgPfTOfAuLjy+fRVeZTaXEhcKlQt5yjY9+uFjKvwDRV7V1N0tgqybKrzIXJrbby
         dUn19s44Sm4Hvgv9TkSkuSrTczetZwtiTYGhDZmq/srIiAOxD15+zGT71aLQckzdstvW
         WbwBZu2ADXQso2s6xfVQZN0R4Y/2DtzM3hwRxLiizfFlSVwwCPbnIUxymqj8USG30yWt
         AaiA==
X-Forwarded-Encrypted: i=1; AJvYcCWzCwolpg0f9TTXwRYSFOI9ZgUX907R/QfJ8DT38rdqeaDniJ9Y0QQhE0Fgn0kg2qr7pJoJ3Ivw2I5KXx4SoHWEQ/IjOwecPhL631R1j/qrPqhmOntyuTZbcM0MREcuebJRq5/p+Xww
X-Gm-Message-State: AOJu0YwkhJZjhN/3cEc5hq6eWt7PtpoHI+5gKBWTfWlYW/lBdXq4rDnc
	wmuRk5xCJETx1T79Do+EfxvYpMoftdvC6/howPb4Bwvtj4VC6ZfbdsYGpfgnEoEW54TR8W46K/n
	CfW/2NsnvMUIZzl01c7Q0n7/c1ZiBNLRYtc4/1g==
X-Google-Smtp-Source: AGHT+IFzVyQrf/hm5K3mdu8pWgHJLLh8th/uXE0cNXLmjwJDQLLEinNWXgKtNEL7KXbD5e5wZHkVVgBzgM73hlOOh1A=
X-Received: by 2002:a05:620a:2853:b0:795:4bfb:fe2f with SMTP id
 af79cd13be357-7954bfc037emr370896785a.1.1717849499349; Sat, 08 Jun 2024
 05:24:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGew7BttU+g40uRnSCN5XmbXs1KX1ZBbz+xyXC_nw5p4dR2dGA@mail.gmail.com>
 <CABBYNZLE9uYiRM-baoBt=RQktq__TguMETgmVWGzfeorARfm4w@mail.gmail.com>
 <212fca4c-fc1f-4da4-b48e-c6a4b64a2b35@leemhuis.info> <CAGew7BseJ18yjTu5AFWr=B3c41gXe4T=B0JqFWvXjQYvcDPfTA@mail.gmail.com>
 <CABBYNZJqULvfnafB5vA4PHPtzs_qmEQK8JZ3C09Q=wmvSZqwBA@mail.gmail.com>
In-Reply-To: <CABBYNZJqULvfnafB5vA4PHPtzs_qmEQK8JZ3C09Q=wmvSZqwBA@mail.gmail.com>
From: =?UTF-8?Q?Timo_Schr=C3=B6der?= <der.timosch@gmail.com>
Date: Sat, 8 Jun 2024 14:24:48 +0200
Message-ID: <CAGew7Bu3FBQfUya4vK-qr+D6zRiP4dquXY_0uND9TaHh-VT10w@mail.gmail.com>
Subject: Re: Bluetooth Kernel Bug: After connecting either HFP/HSP or A2DP is
 not available (Regression in 6.9.3, 6.8.12)
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: regressions@leemhuis.info, stable@vger.kernel.org, 
	regressions@lists.linux.dev, linux-bluetooth@vger.kernel.org, 
	luiz.von.dentz@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,
as requested I opened an issue. Please see:
https://github.com/bluez/bluez/issues/865

Best regards,
Timo

Am Sa., 8. Juni 2024 um 00:01 Uhr schrieb Luiz Augusto von Dentz
<luiz.dentz@gmail.com>:
>
> Hi Timo,
>
> On Fri, Jun 7, 2024 at 5:43=E2=80=AFPM Timo Schr=C3=B6der <der.timosch@gm=
ail.com> wrote:
> >
> > Am Fr., 7. Juni 2024 um 08:10 Uhr schrieb Linux regression tracking
> > (Thorsten Leemhuis) <regressions@leemhuis.info>:
> > >
> > > On 06.06.24 23:23, Luiz Augusto von Dentz wrote:
> > > > On Thu, Jun 6, 2024 at 4:46=E2=80=AFPM Timo Schr=C3=B6der <der.timo=
sch@gmail.com> wrote:
> > > >> on my two notebooks, one with Ubuntu (Mainline Kernel 6.9.3, bluez
> > > >> 5.7.2) and the other one with Manjaro (6.9.3, bluez 5.7.6) I'm hav=
ing
> > > >> problems with my Sony WH-1000XM3 and Shure BT1. Either A2DP or HFP=
/HSP
> > > >> is not available after the connection has been established after a
> > > >> reboot or a reconnection. It's reproducible that with the WH-1000X=
M3
> > > >> the A2DP profiles are missing and with the Shure BT1 HFP/HSP profi=
les
> > > >> are missing. It also takes longer than usual to connect and I have=
 a
> > > >> log message in the journal:
> > > >>
> > > >> Jun 06 16:28:10 liebig bluetoothd[854]:
> > > >> profiles/audio/avdtp.c:cancel_request() Discover: Connection timed=
 out
> > > >> (110)
> > > >>
> > > >> When I disable and re-enable bluetooth (while the Headsets are sti=
ll
> > > >> on) and trigger a reconnect from the notebooks, A2DP and HFP/HSP
> > > >> Profiles are available again.
> > > >>
> > > >> I also tested it with 6.8.12 and it's the same problem. 6.8.11 and
> > > >> 6.9.2 don't have the problem.
> > > >> So I did a bisection. After reverting commit
> > > >> af1d425b6dc67cd67809f835dd7afb6be4d43e03 "Bluetooth: HCI: Remove
> > > >> HCI_AMP support" for 6.9.3 it's working again without problems.
> > > >>
> > > >> Let me know if you need anything from me.
> > > >
> > > > Wait what, that patch has nothing to do with any of these profiles =
not
> > > > really sure how that would cause a regression really, are you sure =
you
> > > > don't have actual connection timeout happening at the link layer an=
d
> > > > that by some chance didn't happen when running with HCI_AMP reverte=
d?
> > > >
> > > > I'd be surprised that HCI_AMP has any effect in most controllers
> > > > anyway, only virtual controllers was using that afaik.
> > >
> > > Stupid question from a bystander without knowledge in the field (so f=
eel
> > > free to ignore this): is that patch maybe causing trouble because it =
has
> > > some hidden dependency on a earlier change that was not backported to
> > > 6.9.y?
> > >
> > > Timo, to rule that out (and it's good to know in general, too) it wou=
ld
> > > be good to known if current mainline (e.g. 6.10-rc) is affected as we=
ll.
> > >
> > > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' h=
at)
> > > --
> > > Everything you wanna know about Linux kernel regression tracking:
> > > https://linux-regtracking.leemhuis.info/about/#tldr
> > > If I did something stupid, please tell me, as explained on that page.
> >
> > Hallo Thorsten, I tried with 6.10-rc2 and it's the same problem on my s=
ystems.
>
> Could you please create a issue at
> https://github.com/bluez/bluez/issues and then attach btmon traces and
> bluetoothd? This is a really weird regression, also is your system
> using pulseaudio or pipewire?
>
> --
> Luiz Augusto von Dentz

