Return-Path: <stable+bounces-89911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0239BD3CE
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 18:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7554E1F2375A
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C66184523;
	Tue,  5 Nov 2024 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJhe/yoh"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9E384D02;
	Tue,  5 Nov 2024 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730829247; cv=none; b=P+9QdetcL2gSiB+5xt5/4Cs0KLBu5nAZPLuRkz3/YA8M5Sv7oL8yVGfXhsqEEOGHOZs9twfUgVQD3wEy2jjWvjzToKaDKWYBDkr+vLefbZVlaaEIcbU1707w5OLQU0NmqqZsld6g1QjFD2dCybOIVUgmJd87PLHI1XrD1OzmWgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730829247; c=relaxed/simple;
	bh=nxRGfdKu402C7VQamMw8fwDXVn8rXiAjwz8nAg5lvSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrxUhXRPFcm7sGB5zlcOIrhrOyaVuuIg0wC6MdDTL9WJSSP2WVguL5ndZ8NNilFfYKAQWqPdzLcDAOW9XmseZ4tBXrgJyMsxxsWHK3D1WlMIjvAcNxLLHAvv9rn4EBdTK6qrfvVh+mB1FQeU6amjatOifj6LQM8wuuZVVlXu/yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJhe/yoh; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb5be4381dso54584261fa.2;
        Tue, 05 Nov 2024 09:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730829243; x=1731434043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kXhkkwOqtZ3i9+hpxeg/zIGdRdlhB56p/0BEtcthVk=;
        b=YJhe/yohEHkBnFBH2huwg8Vkgaixs2mjAjzR7VRQoEmlFgf/0u9OikeKITGX0ZRtaB
         VWZ93KycnZWrvM47LdnkEXzszoIAbNnvBhIm6Uv2pv/wfVzMYv92FFcDY7Ys+LiwCLQo
         5Yv+IJf0QMCNBdn20z9Jrv3oRdmb8XiyxYQ/fEYe/BAEEyQ1i6DVQJDfSOMN+nHIrlb/
         Re+Mq9/URBHySfUt1vQoWxRzMCZkdeK0YLflAWLj6QanlhSLGbESktjdPmAnsn2os+z0
         Mq4U6gH/eNS84m0yiVFTQJAlcuYeF33TINdKoj2OaYv8ZWsPv7sHFVcZjoJqKyJZwe/4
         2dIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730829243; x=1731434043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kXhkkwOqtZ3i9+hpxeg/zIGdRdlhB56p/0BEtcthVk=;
        b=BRWZyjy5QB8t5Wa4M1KRjZkmH9MEB3ZFdJfmsBgv9TKEJh5721if237BDBM65YSyjM
         gNNxeAGEvir+HTlzYvG7h0PPKrjhdjxP6sv184XLDRJiUcn71rod2f6YJQRxHaEBTl4J
         Rq6NBnbC/ICv8bbJqu7haJpNtclK6z4sLZWp9hATpgWMzYJtjM/GtzCWt0H7YNSLtjJX
         WRzELTEfMf/GbR2TM9BtIAx6awxB8o4YA6UCHKhqHYNHiU2lPVhx6VRqrhXBfYVzJKzD
         4Hc1MRk6HV/rY5Q10++cX+2DLJhbqPr1mmbdvT2M9izhqFpkce+AHAkHIUwgCwTSAQVD
         6UJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2j47Tq00GtophMP0LYeYfYnDOZ4FhvGDnX2QcNejxaSlrWNPWkiQ0QSQZFPlM14XKayWUQGBgiIY4KC3HbyE=@vger.kernel.org, AJvYcCW457mhI2AypfyLmngty4sOlQR443OzJ2kIq75Gla2AvTVSjm99RmKmeihMvihVMqDsXSRi/SaB@vger.kernel.org
X-Gm-Message-State: AOJu0YxKkPraztozfw7O3FuEg42l0B5EbzYj1KG1zvfj7sCq+La+NkMj
	QliBGMK/k5/OCDmo4gToazGjw7452FMelAElzYZgrEebD65f9rxRA8UyrwZW8VvFBfJDGPuc/Gd
	tezTry5D1T6HuHjrVt4QZS1CFRS8=
X-Google-Smtp-Source: AGHT+IHnTvioO+ZZYHqdqnt/q19K68C9bX7vrHrZYEHzFcmtHZberBg5omsQ24nYxgr66Thn3hL5+2edxzlCnjBjP7I=
X-Received: by 2002:a2e:b88e:0:b0:2fa:e658:27b4 with SMTP id
 38308e7fff4ca-2fcbdf5fe55mr177137061fa.4.1730829243022; Tue, 05 Nov 2024
 09:54:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <30f4b18f-4b96-403c-a0ab-d81809d9888a@gmail.com>
 <c09d4f5b-0c4b-4f57-8955-28a963cc7e16@leemhuis.info> <2024061258-boxy-plaster-7219@gregkh>
 <d5aa11c9-6326-4096-9c29-d9f0d11f83b4@leemhuis.info> <ZyMkvAkZXuoTHFtd@eldamar.lan>
 <ab5e25d8-3381-452e-ad13-5d65c0e12306@leemhuis.info>
In-Reply-To: <ab5e25d8-3381-452e-ad13-5d65c0e12306@leemhuis.info>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 5 Nov 2024 12:53:50 -0500
Message-ID: <CABBYNZKQAJGzA8th8A7Foiy7YaSFZDpLvLZqDFsVJ3Yzn8C_5g@mail.gmail.com>
Subject: Re: Bluetooth kernel BUG with Intel AX211 (regression in 6.1.83)
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Salvatore Bonaccorso <carnil@debian.org>, Mike <user.service2016@gmail.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org, 
	Paul Menzel <pmenzel@molgen.mpg.de>, Sasha Levin <sashal@kernel.org>, 
	=?UTF-8?Q?Jeremy_Lain=C3=A9?= <jeremy.laine@m4x.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 5, 2024 at 12:29=E2=80=AFPM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> On 31.10.24 07:33, Salvatore Bonaccorso wrote:
> > On Tue, Jun 18, 2024 at 12:30:18PM +0200, Thorsten Leemhuis wrote:
> >> On 12.06.24 14:04, Greg KH wrote:
> >>> On Thu, Jun 06, 2024 at 12:18:18PM +0200, Thorsten Leemhuis wrote:
> >>>> On 03.06.24 22:03, Mike wrote:
> >>>>> On 29.05.24 11:06, Thorsten Leemhuis wrote:
> >>>>> [...]
> >>>>> I understand that 6.9-rc5[1] worked fine, but I guess it will take =
some
> >>>>> time to be
> >>>>> included in Debian stable, so having a patch for 6.1.x will be much
> >>>>> appreciated.
> >>>>> I do not have the time to follow the vanilla (latest) release as is
> >>>>> likely the case for
> >>>>> many other Linux users.
> >>>>>
> >>>> Still no reaction from the bluetooth developers. Guess they are busy
> >>>> and/or do not care about 6.1.y. In that case:
> >>>>
> >>>> @Greg: do you might have an idea how the 6.1.y commit a13f316e90fdb1
> >>>> ("Bluetooth: hci_conn: Consolidate code for aborting connections") m=
ight
> >>>> cause this or if it's missing some per-requisite? If not I wonder if
> >>>> reverting that patch from 6.1.y might be the best move to resolve th=
is
> >>>> regression. Mike earlier in
> >>>> https://lore.kernel.org/all/c947e600-e126-43ea-9530-0389206bef5e@gma=
il.com/
> >>>> confirmed that this fixed the problem in tests. Jeremy (who started =
the
> >>>> thread and afaics has the same problem) did not reply.
> >>>
> >>> How was this reverted?  I get a bunch of conflicts as this commit was
> >>> added as a dependency of a patch later in the series.
> >>>
> >>> So if this wants to be reverted from 6.1.y, can someone send me the
> >>> revert that has been tested to work?
> >>
> >> Mike, can you help out here, as you apparently managed a revert earlie=
r?
> >> Without you or someone else submitting a revert I fear this won't be
> >> resolved...
> >
> > Trying to reboostrap this, as people running 6.1.112 based kernel
> > seems still hitting the issue, but have not asked yet if it happens as
> > well for 6.114.
> >
> > https://bugs.debian.org/1086447
> >
> > Mike, since I guess you are still as well affected as well, does the
> > issue trigger on 6.1.114 for you and does reverting changes from
> > a13f316e90fdb1 still fix the issue? Can you send your
> > backport/changes?
>
> Hmmm, no reply. Is there maybe someone in that bug that could create and
> test a new revert to finally get this resolved upstream? Seem we
> otherwise are kinda stuck here.

Looks like we didn't tag things like 5af1f84ed13a ("Bluetooth:
hci_sync: Fix UAF on hci_abort_conn_sync") and a239110ee8e0
("Bluetooth: hci_sync: always check if connection is alive before
deleting") that are actually fixes to a13f316e90fdb1.

> Ciao, Thorsten



--=20
Luiz Augusto von Dentz

