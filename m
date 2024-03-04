Return-Path: <stable+bounces-25941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8CA87051B
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 16:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D66C1C2036F
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 15:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F10482D3;
	Mon,  4 Mar 2024 15:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=khvoinitsky.org header.i=@khvoinitsky.org header.b="Jk1r27iD"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70BA47A48
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709565167; cv=none; b=ERXozzoZ+TwUnNDfs+mwds4sYt74u0HgSRXdvfWax8dXubNW32GdlSSvqJgz7wAuAwQUUJEUhrQZlolPE8K96zSk2KoI9Ihc295N02Ji7O9pc7jmzqtdpyUVJ+jXqqRLN9yUZmb7jUxgUbLFOAnAeaSVhQWnQxLDT8Vr6RA5S4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709565167; c=relaxed/simple;
	bh=ANeFn0Vl19JA8TowDhr8E9cVOSbKmBckjJC7ISr9KYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUIGTsCK0QIUxIC07cyMSWYOIqUD60bnNUoq74OorauY8Mvay+aulNah76xF57ueYmTU9jxfKZF237PizlZvzZZSVACw8I6eLmxnzUNQmYD/DWnVVtW2Rn1xL+Pz4cF7JYMuqz01nloxtv3Mo4BZu6hoMRwlj3bqCl/yP3uV8M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khvoinitsky.org; spf=pass smtp.mailfrom=khvoinitsky.org; dkim=pass (1024-bit key) header.d=khvoinitsky.org header.i=@khvoinitsky.org header.b=Jk1r27iD; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khvoinitsky.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khvoinitsky.org
X-Forwarded-Encrypted: i=1; AJvYcCXSpqhSw8c2luH7SYGQgJQ+Sa3CgkBG4QgyMygF1j0frIk0GSJKqgWj9jSpYyjk/oJhAZPKW/VZxtFpD0RKiOk8Ei2u2aUIggMX7acVmQOO087N1olxpmIIlwsR3fNCKK0DPiY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khvoinitsky.org;
	s=key1; t=1709565162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ANeFn0Vl19JA8TowDhr8E9cVOSbKmBckjJC7ISr9KYc=;
	b=Jk1r27iDwONCuVcaZJyyp3/XDvqSV+WlP3jFMe3NmgqNr5RCxekoWgj14R63nkAfrlrt1I
	zF4kvtqw3xDyWBWYsXIA0lBEM3lNzz/hHW4eTPF9WthyE7/jDI+1Lh4HN0EHxOSGmG+MqK
	Czw8ncuaz0B8qBQIOiVyem/GoxaD624=
X-Gm-Message-State: AOJu0YwZZcTs+kfoiYlQDgVFD9pqKe7tWoUJu9HrcY7cwXJ66yS9Qi7G
	54sOsJdHNFTJBI+2Nih99KYvDVRzUxxWCeNPr97j8YCM8Yjd4iExmRCt26FqCZxRDfvqtjo1Dqm
	SULwmYli2st9nP71qPlk5DOlaUqU=
X-Google-Smtp-Source: AGHT+IFZiTc6XQ3gEJ5lwVog5csOwbE54OhnpzQYOO/02vEVnkVNrSEs9bBKpXOwO+iF9WTpihpZIhlIgCbCPU/cIvw=
X-Received: by 2002:a05:6512:3c8d:b0:513:30fd:2985 with SMTP id
 h13-20020a0565123c8d00b0051330fd2985mr5648347lfv.0.1709565160554; Mon, 04 Mar
 2024 07:12:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a29d56d2-c440-4a26-a9ac-014595d2ae8c@gmail.com>
 <21370dc5-94a3-442c-ae04-76f9f94b1b96@leemhuis.info> <c8986411-2bf7-4b7d-8ac1-f702dc7c725a@gmail.com>
 <7a5fc584-1520-4e52-9c77-d67a656524c6@gmail.com> <10022b0c-89c3-43e1-89ba-00e458fe1dfd@leemhuis.info>
 <7a8d9d60-a151-4b25-882b-48e6929339a4@gmail.com> <9db59ae4-be28-4ab3-a2ae-0b0f661f56be@gmail.com>
 <3bb95fcd-65cf-45dd-8d81-1a41b1ae0288@leemhuis.info> <CAMMabwNo_yT4S3LaMV16Rmj6MiWL=TRYtB9wspfs_LWVgM=U8Q@mail.gmail.com>
 <b30dc4a1-57aa-4ff5-ae52-7a01203b8be9@gmail.com>
In-Reply-To: <b30dc4a1-57aa-4ff5-ae52-7a01203b8be9@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Mikhail Khvoinitsky <me@khvoinitsky.org>
Date: Mon, 4 Mar 2024 17:12:29 +0200
X-Gmail-Original-Message-ID: <CAMMabwNVwapthrDkCLOQsWkObzvTKVzDMiod3KPVa1hoy0CzRA@mail.gmail.com>
Message-ID: <CAMMabwNVwapthrDkCLOQsWkObzvTKVzDMiod3KPVa1hoy0CzRA@mail.gmail.com>
Subject: Re: Regression with Lenovo ThinkPad Compact USB Keyboard
To: =?UTF-8?Q?Rapha=C3=ABl_Halimi?= <raphael.halimi@gmail.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Jiri Kosina <jikos@jikos.cz>, 
	Linux Input Mailing List <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	Linux Stable Mailing List <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

> I'd be glad to test the module with this patch applied.

Sure.

> What's the default setting ? Should I set any parameter in sysfs to get
> the desired result (apply workaround) ?

Default is 1, so you don't have to change anything.

On Mon, 4 Mar 2024 at 17:07, Rapha=C3=ABl Halimi <raphael.halimi@gmail.com>=
 wrote:
>
> Le 04/03/2024 =C3=A0 15:52, Mikhail Khvoinitsky a =C3=A9crit :
> > Hi,
> >
> > Sorry for ignoring this thread. I've submitted the fix [1] quite a
> > while ago but it is now in hid tree targeting 6.9. Maybe we can
> > redirect it into 6.8? Jiri, what do you think?
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/=
?h=3Dfor-6.9/lenovo&id=3D2814646f76f8518326964f12ff20aaee70ba154d
>
> I'd be glad to test the module with this patch applied.
>
> What's the default setting ? Should I set any parameter in sysfs to get
> the desired result (apply workaround) ?
>
> Regards,
>
> --
> Rapha=C3=ABl Halimi

