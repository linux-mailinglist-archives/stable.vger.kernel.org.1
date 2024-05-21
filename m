Return-Path: <stable+bounces-45490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C89868CAA82
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 11:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1462831FB
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 09:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D8355C29;
	Tue, 21 May 2024 09:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdasMsdr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6575A56454;
	Tue, 21 May 2024 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716282743; cv=none; b=N2xRdzeWZ3LRhg7zhlsY01sGp10t5YaT08TKE8YNgymjkwt7I+Js+IlOBJWxSsi86bAJRex3lZy0cusudt5o0xTpRQr/FWU/cjZUFUXpc/mRpFTVkA8pZsmk8LAwCk7AluN0jV7n4rPTWQUW/kZtnpPCHl6yQXpqtuEvxGoC/Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716282743; c=relaxed/simple;
	bh=2wjs3mdw4rOGvrIqoeda4h5sOrmnWs3RpnJdlvtjnio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHh03O2ExUpx6wuB+2ZRpztJtVGWQESu5FJSwsrIh5t5XdFlgb/nQtB0UdycXM8Hy2/0XOb1ZuTLP9pdTk0s82pIf8fn07DwmyWp4o031mxFDRdpHg7DbUhI2z/ajqBWzlhcxCApT34wO1b9wMWItEPnNqQJULOzVYej4DUHkxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdasMsdr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ed835f3c3cso34011295ad.3;
        Tue, 21 May 2024 02:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716282742; x=1716887542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFFc8dkP7sP+uu3rw1v9YarWpJd2vkJbAvnBTD0BiKI=;
        b=jdasMsdrwlrLKhIfGg4S7APIzsdpU5MNdgxIIkCjwMr6zeKOeVuoRkWWaAo5nqvopz
         nXXbpKvxAGDvC0gcybTxMuTqo5pi819f8/R3O7Wjt8FEHXfgND+x6NQ5Ti5KluKRcjyn
         Wu68FKTYedcJ26d8qL6w1u7iSSGDOVOcG5FV+o7PJwondyhx0tjND2+6z1M4VvxjXwmo
         s8OQI/WHOFb+xTViuj66ozuTCDxMocg7NS8o7mnyUHNx1dGfkfpEFc6/1QgjWG/O/MIz
         ER2cnpLYMMWBU12bjUEZTBckrw73nxzIBa872FoSxJAmiQJgydKmNO8e2xhFf5ps8hJy
         010g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716282742; x=1716887542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFFc8dkP7sP+uu3rw1v9YarWpJd2vkJbAvnBTD0BiKI=;
        b=vDY/xbmyZsr25flD/rIyAJ+5SiyFHpuEjSPQBDJt60b7RK8YHhs82Dx5WLDpA+YQ5d
         CITzz0Hgy799R3xRLvL+RtKfYwqP2odyBNoaDk6+hoKfK35J895PbA7WmD/ushm+YhrM
         a3k+E4Sf1N+UMq8qkaDFM84jy9YG/u9p+IEqLl8UdMbJVeFMRcBNTIgXlstz+lw6lRsi
         P690W+ijJ2TQZS2ks1caswz10xpcVF5hLAeZquxrmDwGbQoATt3i9PdTggmI1muZzf4s
         YiYJVA/jfirnI3NOqIsJU56Xa/z544esNZDFXhpaJbpdobFq4izc75X5UxikS4yaG8q6
         driA==
X-Forwarded-Encrypted: i=1; AJvYcCWZgFltBoG6TI6VloHxuaaS8cBkl135yJ0Pmha8aX2IMOWYa54o7qfHcuckEPSD3/D4QThIqzO6miWAQP1Hn8SRUduSiQMjEgyxGfdPg7lZdYOgPExT/fzCOVEVZ2nqN2EBzgQvAFO9NmACwj3HpSgFcDpYAoHSuOXhl2gbB0Za
X-Gm-Message-State: AOJu0YyE9UEC2zt5jQy0GpJaI8gAKerZfZq4NMm9e05UwKwKDb7YsjdW
	3sj5Pi/3c+qiA2rzQYoeaNYKL7Hy1GFeWceLyjYPYBBWhTvDyB9DZsg4SCBpamOT+VzVZ1PuCRB
	BJf6JA5OwSYZDNmd2nuXu2CPGcb4=
X-Google-Smtp-Source: AGHT+IEZhwsCyczFPZJb/vjIbSf+CiTU9TdOAlzSwjvUCGMcHTAml6sMLqSnnpQ2+kd26Ga3oom9L2K9e7gZCCGVCrU=
X-Received: by 2002:a17:90b:2305:b0:2b1:782:8827 with SMTP id
 98e67ed59e1d1-2b6cc564325mr28630098a91.20.1716282741684; Tue, 21 May 2024
 02:12:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHe5sWavQcUTg2zTYaryRsMywSBgBgETG=R1jRexg4qDqwCfdw@mail.gmail.com>
 <38de0776-3adf-4223-b8e0-cedb5a5ebf4d@leemhuis.info> <lqdpk7lopqq4jn22mycxgg6ps4yfs7hcca33tqb2oy6jxc2y7p@rhjjbzs6wigu>
 <611f8200-8e0e-40e4-aff4-cc2c55dc6354@amd.com> <61-664b6880-3-6826fc80@79948770>
 <20240520162100.GI1421138@black.fi.intel.com> <5d-664b8000-d-70f82e80@161590144>
 <CAHe5sWazL96zPa-v9S515ciE46JLZ1ROL7gmGikfn-vhUoDaZg@mail.gmail.com>
 <20240521051151.GK1421138@black.fi.intel.com> <CAHe5sWb7kHurBvu6JC6OgXZm9mSg5a2W2XK9L8gCygYaFZz7JQ@mail.gmail.com>
 <20240521085926.GO1421138@black.fi.intel.com>
In-Reply-To: <20240521085926.GO1421138@black.fi.intel.com>
From: Gia <giacomo.gio@gmail.com>
Date: Tue, 21 May 2024 11:12:10 +0200
Message-ID: <CAHe5sWb=14MWvQc1xkyrkct2Y9jn=-dKgX55Cow_9VKEeapFwA@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] "xHCI host controller not responding,
 assume dead" on stable kernel > 6.8.7
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: =?UTF-8?Q?Benjamin_B=C3=B6hmke?= <benjamin@boehmke.net>, 
	Mario Limonciello <mario.limonciello@amd.com>, Christian Heusel <christian@heusel.eu>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "kernel@micha.zone" <kernel@micha.zone>, 
	Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, 
	Yehezkel Bernat <YehezkelShB@gmail.com>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "S, Sanath" <Sanath.S@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Here you have the output from the dock upstream port:

sudo tbdump -r 2 -a 1 -vv -N2 LANE_ADP_CS_0

0x0036 0x003c013e 0b00000000 00111100 00000001 00111110 .... LANE_ADP_CS_0
  [00:07]       0x3e Next Capability Pointer
  [08:15]        0x1 Capability ID
  [16:19]        0xc Supported Link Speeds
  [20:21]        0x3 Supported Link Widths (SLW)
  [22:23]        0x0 Gen 4 Asymmetric Support (G4AS)
  [26:26]        0x0 CL0s Support
  [27:27]        0x0 CL1 Support
  [28:28]        0x0 CL2 Support
0x0037 0x0828003c 0b00001000 00101000 00000000 00111100 .... LANE_ADP_CS_1
  [00:03]        0xc Target Link Speed =E2=86=92 Router shall attempt Gen 3=
 speed
  [04:05]        0x3 Target Link Width =E2=86=92 Establish a Symmetric Link
  [06:07]        0x0 Target Asymmetric Link =E2=86=92 Establish Symmetric L=
ink
  [10:10]        0x0 CL0s Enable
  [11:11]        0x0 CL1 Enable
  [12:12]        0x0 CL2 Enable
  [14:14]        0x0 Lane Disable (LD)
  [15:15]        0x0 Lane Bonding (LB)
  [16:19]        0x8 Current Link Speed =E2=86=92 Gen 2
  [20:25]        0x2 Negotiated Link Width =E2=86=92 Symmetric Link (x2)
  [26:29]        0x2 Adapter State =E2=86=92 CL0
  [30:30]        0x0 PM Secondary (PMS)

On Tue, May 21, 2024 at 10:59=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Tue, May 21, 2024 at 10:15:28AM +0200, Gia wrote:
> > Here you go:
> >
> > 0x0080 0x003c01c0 0b00000000 00111100 00000001 11000000 .... LANE_ADP_C=
S_0
> >   [00:07]       0xc0 Next Capability Pointer
> >   [08:15]        0x1 Capability ID
> >   [16:19]        0xc Supported Link Speeds
> >   [20:21]        0x3 Supported Link Widths (SLW)
> >   [22:23]        0x0 Gen 4 Asymmetric Support (G4AS)
> >   [26:26]        0x0 CL0s Support
> >   [27:27]        0x0 CL1 Support
> >   [28:28]        0x0 CL2 Support
> > 0x0081 0x0828003c 0b00001000 00101000 00000000 00111100 .... LANE_ADP_C=
S_1
> >   [00:03]        0xc Target Link Speed =E2=86=92 Router shall attempt G=
en 3 speed
> >   [04:05]        0x3 Target Link Width =E2=86=92 Establish a Symmetric =
Link
> >   [06:07]        0x0 Target Asymmetric Link =E2=86=92 Establish Symmetr=
ic Link
> >   [10:10]        0x0 CL0s Enable
> >   [11:11]        0x0 CL1 Enable
> >   [12:12]        0x0 CL2 Enable
> >   [14:14]        0x0 Lane Disable (LD)
> >   [15:15]        0x0 Lane Bonding (LB)
> >   [16:19]        0x8 Current Link Speed =E2=86=92 Gen 2
> >   [20:25]        0x2 Negotiated Link Width =E2=86=92 Symmetric Link (x2=
)
> >   [26:29]        0x2 Adapter State =E2=86=92 CL0
> >   [30:30]        0x0 PM Secondary (PMS)
>
> Thanks this looks fine (although the link is still Gen 2). Can you run
> the same from the dock upstream port too?
>
>   # tbdump -r 2 -a 1 -vv -N2 LANE_ADP_CS_0

