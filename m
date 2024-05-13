Return-Path: <stable+bounces-43692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0454D8C4370
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 16:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993721F222A5
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 14:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE813211C;
	Mon, 13 May 2024 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W6BgtLeV"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD01817F0
	for <stable@vger.kernel.org>; Mon, 13 May 2024 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715611508; cv=none; b=lzTz4oXlxdT8UIxiC9B6WklnPyMD9d36NNbFQLJIKc4ZAR3W2Spm4Pq3PPU+rLU90woI87wpps1vdZDl/ivAzvbIm0nSEGoVHy3RTehtMMJbtq+CjNvLM1Zx6LlbuzKhqir7gysKR5U+1shj37h3NnUE2FboMrDoWOgHTxXdtK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715611508; c=relaxed/simple;
	bh=NSx+zP8XeovamK63c50JPXEzA5hDA93t0eYU6ZyUPmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQ2wGwMwRazpsrXVDDzCJPN/VD5okzBSMfP4X8mqhG84VjbQ8W8K2CWLSOujBEQ1C56egQwsmi+05DM5C+5rXnMXAiSZY7RHVlvjPU0sIVf+IE279ul38tnIHRbplhvoaKyzwLX6chtYF2Y5XjKTWSUrYsRoRa4CcmOzIWscE34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W6BgtLeV; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e1d6166521so45457091fa.1
        for <stable@vger.kernel.org>; Mon, 13 May 2024 07:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715611505; x=1716216305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTZJYMReQhFia27UMzTEYm5SexG39nNAGMcReZbdde0=;
        b=W6BgtLeVFO5SE24cH3Uhue9ZtSt2Jvb2So4Y2Yjwbios2Zl4nhmz8BpgwCrVaNPRO/
         VK0biKKX2TYH0+qQrUQDKQacolCPPZvwOteYwPzCjtIrGxRWezxOo5CcFSx2xhR/s/ea
         qnyMCuxbYKBh7YSr9gWItoMqFRMhy8Y2HeW7Xk8AKoKqG3ShY/FiLsZZh/QEA9nBckB4
         M6UslPQJtOwhMfX+ztINImxA1rNm67vxOY6QcS7C+wHKfhCUsW/am7EVld1qjgsjKUIQ
         Md/RIksWnDyMGjaKE/ZIYUBuz0cQRdm7wqRBGYr3bpPa0R07yu8L/vQqAxG+KkMZXLot
         sokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715611505; x=1716216305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTZJYMReQhFia27UMzTEYm5SexG39nNAGMcReZbdde0=;
        b=IT14tLivmPkXf4WMeWzqxUqC/drT+YbosI1VD/68d7ElgeVibW8svnr5EQNrc55rTk
         XASNadFHgYe0Q326YEDLbvnXRt3bc2T/Rpp5S8Pd3vjDPGWoHZqLL/eaqRWSqm5H7dbU
         guwZ1cfJY0V1DBgrbfqV51nwFP06wMPe68cU9VOad2kYbZ2Qo5HvE6q38Y2thhHyfWhJ
         MpIluU2LE3UIkAGneQlXCNiHw0RwWBCWOkxOJdAFFh3zNJUWk4ueVFGjd1hHiqXnV4qd
         OMoO1DuoUVFSQoFwKF2CQJltvlClw2szDYc6KOqpt7mk3v1NDRKSL99FM/DBm6iB73Vv
         a5ag==
X-Gm-Message-State: AOJu0YzYINurNASNJbgw7Q9d62m0q9rUaH9kfvnJbWH2s0UJjQqhjn43
	Y0hwJDOi/uTr5FxKACocqppnxNt3BnXvRZpIAfdUdX+KAG6QkYXsMEPo1pBo7ZTuhO7++sU1ptI
	/a9xAJUD0dR3HWihTfL8/wxz1zdIUARgO0VrXtg==
X-Google-Smtp-Source: AGHT+IEnt0spJuHvzyzuz9GwdDDbLgAUfgoWouoL1LfHdtiIr8bc7KSvVtTX233PuwrZ9NP1JV0pVQLAiKn5RoB983g=
X-Received: by 2002:a2e:812:0:b0:2d4:535a:e7a with SMTP id 38308e7fff4ca-2e51b4784b6mr31818921fa.24.1715611504895;
 Mon, 13 May 2024 07:45:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506193025.272042-1-sashal@kernel.org> <ff1189d7-afb3-4567-a8ce-627cf57f3690@baylibre.com>
 <2024051357-jimmy-smasher-0359@gregkh>
In-Reply-To: <2024051357-jimmy-smasher-0359@gregkh>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 13 May 2024 09:44:53 -0500
Message-ID: <CAMknhBGNeK51xdcMpRNQ1eRnLrLQFY9dVYFL2LjsL5Gj+nQiSg@mail.gmail.com>
Subject: Re: Patch "spi: axi-spi-engine: fix version format string" has been
 added to the 6.1-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org, 
	Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 7:54=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, May 06, 2024 at 03:47:02PM -0500, David Lechner wrote:
> > On 5/6/24 2:30 PM, Sasha Levin wrote:
> > > This is a note to let you know that I've just added the patch titled
> > >
> > >     spi: axi-spi-engine: fix version format string
> > >
> > > to the 6.1-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-que=
ue.git;a=3Dsummary
> > >
> > > The filename of the patch is:
> > >      spi-axi-spi-engine-fix-version-format-string.patch
> > > and it can be found in the queue-6.1 subdirectory.
> > >
> > > If you, or anyone else, feels it should not be added to the stable tr=
ee,
> > > please let <stable@vger.kernel.org> know about it.
> > >
> > >
> >
> > Does not meet the criteria for stable.
> >
> > (only fixes theoretical problem, not actual documented problem)
>
> It fixes a real problem, incorrect data to userspace, why wouldn't you
> want it applied?
>

As discussed in the other thread, if you prefer to take this patch and
all of it's dependencies to keep things as close to mainline as
possible, I guess that is fine.

