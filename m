Return-Path: <stable+bounces-108564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B10AA0FE55
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 02:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35A27169BAD
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 01:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251BF1FA147;
	Tue, 14 Jan 2025 01:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1GWAZIM"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441991C54A7;
	Tue, 14 Jan 2025 01:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736819787; cv=none; b=kPgPat3+BL3PyCj2P57GjiwIMh0+05MEpX0H0FC8yNdCdv083lHhFLH0H9UonkfgKSwF5WWAIUihA1cWvJv5XCaaYfq5xcN/R1tFAFSA1QDZonzQao+3gS7GvVeP9CqTHNIloBN8+W80GQEdus6peElDUhkRlX04LOpFf0vuqhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736819787; c=relaxed/simple;
	bh=3M3MZYN7Sj4EH0969yosQdu1K2pz/j995ISyaaDQTys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=teQQ/I6ZyCwJ9jT1RntkKEUnBTKhrMOkp5Xib0yZyzy5SNun6xh2UxH1gLSMF6qN3Fq7bOug37NY/C+2LsLuu3WGuOO3KBp71an3TgxBlzWdRV65SStvvMmDB+uBXW39j4HPZGhenjtG4zF0LJcZszkBIcQLAWjpLGwB0KSNxno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1GWAZIM; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso877676966b.1;
        Mon, 13 Jan 2025 17:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736819784; x=1737424584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3M3MZYN7Sj4EH0969yosQdu1K2pz/j995ISyaaDQTys=;
        b=H1GWAZIM8ApVN7+RZRKxShcBionWOnK14hSw9DkIezviT/aJybZBkjpZjVa7yX7t9h
         tcwkca+G/5CH9Nko343kOELNXghxeP29Urvy+NUsXww7GcV5k2xB1oKCI4XXjQPBE7Km
         TN96xTKnZN4WRWhJDkGCQk6HIOQ7rOfSqsg3aSpQLgaBLkG+ZidJObGchU/KpgMlY89o
         Q6s5v4tFUYilX4dzZCgS6XGbMjmmMZlp318kdrPDsmWoHBLv7/yR5wpC9yKPlk/kYJbm
         jC9AnA3EAgD9N05/kaEglktNAhrMMaOP2A20e5/9g/gTwKHxbH6ouPT/3KU/fjt1pl9B
         f/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736819784; x=1737424584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3M3MZYN7Sj4EH0969yosQdu1K2pz/j995ISyaaDQTys=;
        b=TtFHAJNwlVD6QowI9Yu0z9l6fTtrQWsxPrOzYbUNWwBqGWvBEquWICjY95zAIzjB0l
         eKIBvdqqWK4CGJlwGSeHqDoMe6fDYAmH9XdHFaLe/gIr4wnvSW4r7hfyaZopE12x0a1G
         AzSv1KKiop2nRYVPgq2VQWSQStU6gUQUTGeX4DB66AwsDNxGk01hYLl53GGF39lbdEth
         htWv71pMeP/tYED9k2YxWW4ZlTvHxq582bmcwDzjxPMVpeJVgq4LM8aA5SnGS27xp+Jr
         SiWfv9Hw5Ltl5GB834XAQ/fB9nXznBOIATwmvHX+ItH+gNJObjl+9IofY+mShpW8YErP
         mExw==
X-Forwarded-Encrypted: i=1; AJvYcCUU4nl4HQ7DSPR+JffGOhHmdI+xLeL2YFNJC7sVaiE+IAlaUTCeSg7MSPqa8mfE7eiauI7NORDj@vger.kernel.org, AJvYcCUdZLXCZjGmpaa4AmEbv7RV9n49Jio8QZoGduR9nPaK1alK3XuSV0P4E4Ql9gGUgpELpwYUdEsarMORyqY=@vger.kernel.org, AJvYcCX8p3zpifK9qhr79ousEU4oGvaoW9/oMEI8xgQre8NSWViC7KUZizR1JlLLWGejgnutPzasMjmz@vger.kernel.org
X-Gm-Message-State: AOJu0YwSm943TvcJUpQXW60bogsPjYJORaodySGKqTonLhp1ptOsWFrM
	GENKR39MdSzs+WYkt4m2jw8s8bktyub0q8oJ21myMtZ/fllGt7a3E5SrB6J5PHkyt//08Ui6S9+
	mJTUBnpkmS+Q3bkuQaidqQPh2ILeEzAkh
X-Gm-Gg: ASbGncs/xxA+yagx+LItuqzh43DS86ZeoPKP0Vmac5LsNP9+yFOtdrgQupiYOhFlwA2
	59TmwN+Dfp3jD4jiVGAZ91JYJ9PERq02SDZ58pwU=
X-Google-Smtp-Source: AGHT+IGFRcQRHulYo39QzcVokskq7ULXOs64DOSqsgLEBDN8VNb4jyHVDzfe2oaia4l5+ro0WhqdfMZda9BrZzKd94g=
X-Received: by 2002:a17:907:9722:b0:aa6:89b9:e9c6 with SMTP id
 a640c23a62f3a-ab2ab6bfa44mr2099934066b.21.1736819784335; Mon, 13 Jan 2025
 17:56:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108192346.2646627-1-kuba@kernel.org> <20250109145054.30925-1-fercerpav@gmail.com>
 <20250109083311.20f5f802@kernel.org> <TYSPR04MB7868EA6003981521C1B2FDAB8E1C2@TYSPR04MB7868.apcprd04.prod.outlook.com>
 <20250110181841.61a5bb33@kernel.org> <CAGfYmwVECrisZMhWAddmnczcLqFfNZ2boNAD5=p2HHuOhLy75w@mail.gmail.com>
 <20250113131934.5566be67@kernel.org>
In-Reply-To: <20250113131934.5566be67@kernel.org>
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Tue, 14 Jan 2025 09:56:13 +0800
X-Gm-Features: AbW1kvZnUmbmr_6IRQgW51L1dj6t_nP3oXmByqhN6P48o_UCS6Kh-2_Tv9RPFzM
Message-ID: <CAGfYmwXKyWrWm5z1Lra0_wX8iVfT8p9BHd3SWZPSvkZ1qfKqLA@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOWbnuimhjogW0V4dGVybmFsXSBSZTogW1BBVENIXSBuZXQvbmNzaTogZml4IGxvYw==?=
	=?UTF-8?B?a2luZyBpbiBHZXQgTUFDIEFkZHJlc3MgaGFuZGxpbmc=?=
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paul Fertser <fercerpav@gmail.com>, =?UTF-8?B?UG90aW4gTGFpICjos7Tmn4/lu7cgKQ==?= <Potin.Lai@quantatw.com>, 
	Samuel Mendoza-Jonas <sam@mendozajonas.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Ivan Mikhaylov <fr0st61te@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	=?UTF-8?B?Q29zbW8gQ2hvdSAoIOWRqOalt+WfuSk=?= <Cosmo.Chou@quantatw.com>, 
	"patrick@stwcx.xyz" <patrick@stwcx.xyz>, Cosmo Chou <chou.cosmo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 5:19=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 11 Jan 2025 19:12:51 +0800 Potin Lai wrote:
> > > > Thanks for the new patch.
> > > > I am currently tied up with other tasks, but I=E2=80=99ll make sure=
 to test
> > > > it as soon as possible and share the results with you.
> > >
> > > Understood, would you be able to test it by January 13th?
> > > Depending on how long we need to wait we may be better off
> > > applying the patch already or waiting with committing..
> >
> > Hi Jakub & Paul,
> >
> > I had a test yesterday, the patch is working and the kernel panic does
> > not happen any more, but we notice sometimes the config_apply_mac
> > state runs before the gma command is handled.
> >
> > Cosmo helped me to find a potential state handling issue, and I
> > submitted the v2 version.
> > Please kindly have a look at v2 version with the link below.
> > v2: https://lore.kernel.org/all/20250111-fix-ncsi-mac-v2-0-838e0a1a233a=
@gmail.com/
>
> Is there any reason why you reposted Paul's patch?
> Patch 2 looks like a fix for a separate issue (but for the same
> use case), am I wrong?
Sorry, I thought the second patch needs to be followed by the first patch.
Yes, these 2 patches are fixing different issues, I will remove Paul's
patch in the next version (v3).

>
> Also one thing you have not done is to provide the Tested-by: tag
> on Paul's patch :)

Tested-by: Potin Lai <potin.lai.pt@gmail.com>

