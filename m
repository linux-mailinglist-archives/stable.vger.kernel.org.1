Return-Path: <stable+bounces-91662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1A09BF111
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 16:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73A60B2592E
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 15:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385291F9ABC;
	Wed,  6 Nov 2024 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPWuX5PO"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A50B190470;
	Wed,  6 Nov 2024 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905377; cv=none; b=adMA2jpmAe/X4lquZPEm8WccEuEN+SCdcSEppkwhIkUmOJIzkGylbAqPgDKbRwHxw7EY5DYjh9y0VTgWheGzQaOBMcaMcLDWvgmMZDnvuA6MX86UeNUD8KYj7u0LYzCHQoeq4PN5iaTZS6LAMraIwFOEc9cpwwADqo/GBFmeXVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905377; c=relaxed/simple;
	bh=xt8xrg9Nw7zYftpN2TsUBqt+zTEi4h4vrGilPKIcQ6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g9c6IkyaTDzQ8FP/V23bpxHosOTB8H56+D+MvxMpQAr2kuyKCyIbgUXMrqeXCAvjiiDvRphxa43e3jc6CnEPgNQgzZhZD8WglKDjjniLoiuo14ydX0K+lV0y/bVm0Ye6Q5aV8SpWepwyHWtpLmTXQzY68/R5RgSGfEzlWssp2kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPWuX5PO; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fc96f9c41fso11686001fa.0;
        Wed, 06 Nov 2024 07:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730905373; x=1731510173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cTAkvAt1GTT5JhiHrne6cf0l+gqjvi/U391LxCXcj8=;
        b=kPWuX5POsH/1WC9jt36yubMQ85UnIOgfAnrXLaASuVbpLTSSnUfqZk7IuskCAJIa3P
         pRJW74XbF9AjC3vMFm/9qCcnZVB1uZeFdH5eHBq+bn6iLX+ygSDOzWJ89MWUAzE3ty1D
         wyxREvLy0WzgD2+wyuEzAqk6FbjOVKb3KsbpICZkF8VVFkFWwe3g7rMd1/bzh2HQH9H3
         cU7vIxqdsRfFMtljMWeyLqxbrdFKKhUphV/rR4Y2SIQosIr+iCS9xgixQz3wBDA4mVVp
         UKcbnirmUp9Z+tTpV1OeTXTozwQY4YafPcl/MCI2eWeP0T91bQeKvBxewbGTapYFculT
         RAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730905373; x=1731510173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cTAkvAt1GTT5JhiHrne6cf0l+gqjvi/U391LxCXcj8=;
        b=eYunTpRycUnp8lD3rD6z91JBELyNWPvfoa18A+/lNMCIizqRLSvOQ+AV7IsujtFgh+
         Cu7BjtDynjNUf/bvRlArB1sjNG4qZwzTxSjQ0gLZfSEmRxoKYb8wfq4suHLLYFOtHu3R
         50kLzAFM/SXzcwJC/rmPUSx5bXtFVZQluAjmNpoJj8uyLKdbr5w7MvEEGTx9YmSqNORo
         j4j9SHMzDrM2JD18pdxP3hef4mHS3tuudgzDRXq9AhcLmAffj9pyk8Rtw+N0CEaLs5ay
         970No8m3tc5jhUCGZfgyAxZpdOtxi1dRG5cG1Aqy0Pg4SxFed6CnRoQ1xyh+k5dSMN+5
         Wrdw==
X-Forwarded-Encrypted: i=1; AJvYcCU752U0QaftcHg5OMBWEhslyRP3tydeAgwbINP2MDZJIzedTfRyX0PISQYSKKX3E/CDmsmwFMOIMj61fw8EYgs=@vger.kernel.org, AJvYcCXyAgdDw7Kkm3SY8JJqE3i56o5/WnolVZ7vVU/uBGuJto2ifoMalZTLy1RDpnhemzk3rlgcMgzr@vger.kernel.org
X-Gm-Message-State: AOJu0YxC/jY5q63sfWK5LcZHifHzFGx0xzvqMtKgG0VA/iG/fUVkMNxF
	vGyInYIv4O8T7EHWuMQy6xrs6egj3mA3pTbNeM8NNsQAeowb0VDR9SXBLYuSGBEO7fTbgf/yNEK
	8cT4uy0CdzTIWO+JG1CbrdQ5ID7U=
X-Google-Smtp-Source: AGHT+IEpuEOm8iNLXsM5Gsl5m7y2iA3iKf6cj5kdBBIB3ggcJKBIi+dCCD3Lik87gcUJqjzCJ9xP6B4uwW/IS3T+Re8=
X-Received: by 2002:a05:651c:1590:b0:2f7:6371:6c5a with SMTP id
 38308e7fff4ca-2ff0cce821bmr9288271fa.16.1730905372761; Wed, 06 Nov 2024
 07:02:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <30f4b18f-4b96-403c-a0ab-d81809d9888a@gmail.com>
 <c09d4f5b-0c4b-4f57-8955-28a963cc7e16@leemhuis.info> <2024061258-boxy-plaster-7219@gregkh>
 <d5aa11c9-6326-4096-9c29-d9f0d11f83b4@leemhuis.info> <ZyMkvAkZXuoTHFtd@eldamar.lan>
 <ab5e25d8-3381-452e-ad13-5d65c0e12306@leemhuis.info> <CABBYNZKQAJGzA8th8A7Foiy7YaSFZDpLvLZqDFsVJ3Yzn8C_5g@mail.gmail.com>
 <Zypwz65wRM-FMXte@eldamar.lan> <2024110652-blooming-deck-f0d9@gregkh> <Zysdc3wJy0jAYHzA@eldamar.lan>
In-Reply-To: <Zysdc3wJy0jAYHzA@eldamar.lan>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 6 Nov 2024 10:02:40 -0500
Message-ID: <CABBYNZKz_5bnBxrBC3SoaGc1MTXXYsgdOXB42B0x+2dcPRkJyw@mail.gmail.com>
Subject: Re: Bluetooth kernel BUG with Intel AX211 (regression in 6.1.83)
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, Mike <user.service2016@gmail.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org, 
	Paul Menzel <pmenzel@molgen.mpg.de>, Sasha Levin <sashal@kernel.org>, 
	=?UTF-8?Q?Jeremy_Lain=C3=A9?= <jeremy.laine@m4x.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Salvatore,

On Wed, Nov 6, 2024 at 2:40=E2=80=AFAM Salvatore Bonaccorso <carnil@debian.=
org> wrote:
>
> Hi Greg,
>
> On Wed, Nov 06, 2024 at 08:26:05AM +0100, Greg KH wrote:
> > On Tue, Nov 05, 2024 at 08:23:59PM +0100, Salvatore Bonaccorso wrote:
> > > Hi Luiz,
> > >
> > > On Tue, Nov 05, 2024 at 12:53:50PM -0500, Luiz Augusto von Dentz wrot=
e:
> > > > Hi,
> > > >
> > > > On Tue, Nov 5, 2024 at 12:29=E2=80=AFPM Thorsten Leemhuis
> > > > <regressions@leemhuis.info> wrote:
> > > > >
> > > > > On 31.10.24 07:33, Salvatore Bonaccorso wrote:
> > > > > > On Tue, Jun 18, 2024 at 12:30:18PM +0200, Thorsten Leemhuis wro=
te:
> > > > > >> On 12.06.24 14:04, Greg KH wrote:
> > > > > >>> On Thu, Jun 06, 2024 at 12:18:18PM +0200, Thorsten Leemhuis w=
rote:
> > > > > >>>> On 03.06.24 22:03, Mike wrote:
> > > > > >>>>> On 29.05.24 11:06, Thorsten Leemhuis wrote:
> > > > > >>>>> [...]
> > > > > >>>>> I understand that 6.9-rc5[1] worked fine, but I guess it wi=
ll take some
> > > > > >>>>> time to be
> > > > > >>>>> included in Debian stable, so having a patch for 6.1.x will=
 be much
> > > > > >>>>> appreciated.
> > > > > >>>>> I do not have the time to follow the vanilla (latest) relea=
se as is
> > > > > >>>>> likely the case for
> > > > > >>>>> many other Linux users.
> > > > > >>>>>
> > > > > >>>> Still no reaction from the bluetooth developers. Guess they =
are busy
> > > > > >>>> and/or do not care about 6.1.y. In that case:
> > > > > >>>>
> > > > > >>>> @Greg: do you might have an idea how the 6.1.y commit a13f31=
6e90fdb1
> > > > > >>>> ("Bluetooth: hci_conn: Consolidate code for aborting connect=
ions") might
> > > > > >>>> cause this or if it's missing some per-requisite? If not I w=
onder if
> > > > > >>>> reverting that patch from 6.1.y might be the best move to re=
solve this
> > > > > >>>> regression. Mike earlier in
> > > > > >>>> https://lore.kernel.org/all/c947e600-e126-43ea-9530-0389206b=
ef5e@gmail.com/
> > > > > >>>> confirmed that this fixed the problem in tests. Jeremy (who =
started the
> > > > > >>>> thread and afaics has the same problem) did not reply.
> > > > > >>>
> > > > > >>> How was this reverted?  I get a bunch of conflicts as this co=
mmit was
> > > > > >>> added as a dependency of a patch later in the series.
> > > > > >>>
> > > > > >>> So if this wants to be reverted from 6.1.y, can someone send =
me the
> > > > > >>> revert that has been tested to work?
> > > > > >>
> > > > > >> Mike, can you help out here, as you apparently managed a rever=
t earlier?
> > > > > >> Without you or someone else submitting a revert I fear this wo=
n't be
> > > > > >> resolved...
> > > > > >
> > > > > > Trying to reboostrap this, as people running 6.1.112 based kern=
el
> > > > > > seems still hitting the issue, but have not asked yet if it hap=
pens as
> > > > > > well for 6.114.
> > > > > >
> > > > > > https://bugs.debian.org/1086447
> > > > > >
> > > > > > Mike, since I guess you are still as well affected as well, doe=
s the
> > > > > > issue trigger on 6.1.114 for you and does reverting changes fro=
m
> > > > > > a13f316e90fdb1 still fix the issue? Can you send your
> > > > > > backport/changes?
> > > > >
> > > > > Hmmm, no reply. Is there maybe someone in that bug that could cre=
ate and
> > > > > test a new revert to finally get this resolved upstream? Seem we
> > > > > otherwise are kinda stuck here.
> > > >
> > > > Looks like we didn't tag things like 5af1f84ed13a ("Bluetooth:
> > > > hci_sync: Fix UAF on hci_abort_conn_sync") and a239110ee8e0
> > > > ("Bluetooth: hci_sync: always check if connection is alive before
> > > > deleting") that are actually fixes to a13f316e90fdb1.
> > >
> > > Ah good I see :). None of those were yet applied to the 6.1.y series
> > > were the issue is still presend. Would you be up to provide the neede=
d
> > > changes to the stable team?  That would be very much appreciated for
> > > those affected running the 6.1.y series.
> >
> > We would need backports for these as they do not apply cleanly :(
>
> Looks our mails overlapped, yes came to the same conclusion as I tried
> to apply them on top of 6.1.y. I hope Luiz can help here.
>
> We have defintively users in Debian affected by this, and two
> confirmed that using a newer kernel which contains naturally those
> fixes do not expose the problem. If we have backports I might be able
> to convice those affected users to test our 6.1.115-1 + patches to
> verify the issue is gone.

Then perhaps it is easier to just revert that change?


--=20
Luiz Augusto von Dentz

