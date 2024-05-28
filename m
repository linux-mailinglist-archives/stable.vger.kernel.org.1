Return-Path: <stable+bounces-47549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AED8D1332
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 06:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C3181F226A1
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 04:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E24317C7F;
	Tue, 28 May 2024 04:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJbnZWW2"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA9117E8E4;
	Tue, 28 May 2024 04:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716869323; cv=none; b=Bk4/M0w7BG/mD2qhkjZ2aLJIRlV+mh5TEV1uysfmlJi+SRK3by2VCB3fm7K+GAU5UFQfMaZvCiwiqwJBFj9vdrf0/Aj0xYk5Bo02WS+LPrmQ+2D0n/ypt/d7F7aIoljpWXHjunqhOUUgotz6/musM+3JelQ5mfiQXbQzAslSQ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716869323; c=relaxed/simple;
	bh=1zQlRYQXYa6k6CCPf33lK1Df7v5lDyubYaYJYb2isv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apZPQm/u3pi6Up5boDgtXHlcTCHRTzwf+nLBxLr8j/95fOV9LthpIZNy3yfvfqRIC4gdsVEqofRhGU35jrrrakt3Q6dJyJynoMaLrx4sqtexppch+/sVwoPap8k/OxeGdYoLugmqdeo8a5B7zqzQlrCenRjdxYm6jvKfAVG2GTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJbnZWW2; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e6f33150bcso3283641fa.2;
        Mon, 27 May 2024 21:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716869320; x=1717474120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMyc3pRbel0bshffcEecjOn4iWU9YutUkHwlm4EbsFw=;
        b=IJbnZWW2kEgxbrN+HgJviZ+yC+ib49+2Qk4saCIgbVfCrXp/BbwSFfHRYV6FUc+UD4
         XgevKtfKGohqpMRga9P0l8h6C32clnBMlr0MM4JLBlllAudgPLCbShkenIN7AGT7wVK5
         rC5ZWDAuzU2u02FOv/35CH1s/768H2bto0ZObotjkKDkyXdoGj32sEU/AAQLSI35HeQi
         OAc/JRUo8Tq/QO2pRbebSk2KPxN9GtFmbHTb7xZCdyKD5pw1iXp/p0UISqSG3VFTFIPz
         lUBPsQow9rtYAW4RTcUcPxuSnNPakXazfIYehfb5bAbBLxPwtMvHloJP7Vlh1tk8Trle
         WeUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716869320; x=1717474120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMyc3pRbel0bshffcEecjOn4iWU9YutUkHwlm4EbsFw=;
        b=BVmrgquyBKng5/hYiOKIxLvjpMHJOPxCAO2ahe30+1T455yydp7cnvYQRAO6OcjASs
         4DeHD2WE/phFbB2SBph/d+61JFDx0fiq87oC3tQqBnP8UlQzkCs989uZ9RJByQBzFNh6
         jTdrpETTEKeFcIROq9pLGnSdgUiiHM/7wo2qpNMpUNpMEREtrJ2DFnMxp/IVbNf419M8
         HuhPb3kDxFboUaydSl13r+jGm5XHNC4ZwVRuX2ugiYW5N6DmRwQsE43+8cdZdAXZFl/J
         dcdr0touxgyMCPDYX8rm5t6qfo1/GM+CJ6QR5kXEKvUpkiSEUBqXVC/yUNmAJrfFHv1K
         20DA==
X-Forwarded-Encrypted: i=1; AJvYcCV+IIpAVW2ijt7PZSbNPvgligBmMH57Va4e8ut0kK3om3+1W76yQGAt/mC54jBa9fn7uOSPiuJzBgknZPbrD5Z//4cHBGR5MJ3FapR5iyU0iG2+QRf7isnpZQKulW98umOneui16scrTrC6UE8UaPflN2VrRoc9F0Ow9vL598Xqi3TrOCcL+GLF
X-Gm-Message-State: AOJu0YydFYaEqahgVIY32VXFiMATInnFiYm6JheW0dawwvK/7lyIInd5
	wBoO+WPaQgBXzjXmRkttyVHbFs72/tuQF9Cxdh37UCiQ03gfbYrkxLOgNU1hnOO+/xEGXSQCq5d
	0GzH8zeNeb3al9BoBDJrZs3LptKk=
X-Google-Smtp-Source: AGHT+IGJiavREr3NWLKOzpRZdqUHa7q77BL+5YFsloQz18KBti8Zw39zdX1RWbJfMYba295OwGrClZrngVMi829iwIM=
X-Received: by 2002:a2e:800f:0:b0:2e9:6306:8a51 with SMTP id
 38308e7fff4ca-2e963069082mr58708411fa.52.1716869319348; Mon, 27 May 2024
 21:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE4VaREzY+a2PvQJYJbfh8DwB4OP7kucZG-e28H22xyWob1w_A@mail.gmail.com>
 <5b79732b-087c-411f-a477-9b837566673e@leemhuis.info> <20240524132008.6b6f69f6@gandalf.local.home>
 <CAE4VaRF80OhnaiqeP9STfLa5pORB31YSorgoJ92fQ8tsRovxqQ@mail.gmail.com>
 <CAE4VaRGaNJSdo474joOtKEkxkfmyJ-zsrr8asb7ojP2JexFt-A@mail.gmail.com>
 <2024052710-marsupial-debug-febd@gregkh> <20240527174424.75625921@rorschach.local.home>
In-Reply-To: <20240527174424.75625921@rorschach.local.home>
From: =?UTF-8?B?SWxra2EgTmF1bGFww6TDpA==?= <digirigawa@gmail.com>
Date: Tue, 28 May 2024 07:08:03 +0300
Message-ID: <CAE4VaRGzvMU7ZuNwHq1SE0t+Z02Aa5QO44tBH8YgvSYX5ByRwg@mail.gmail.com>
Subject: Re: Bug in Kernel 6.8.x, 6.9.x Causing Trace/Panic During Shutdown/Reboot
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tried 6.10-rc1 and it still ends up to panic

--Ilkka


On Tue, May 28, 2024 at 12:44=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Mon, 27 May 2024 20:14:42 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
>
> > On Mon, May 27, 2024 at 07:40:21PM +0300, Ilkka Naulap=C3=A4=C3=A4 wrot=
e:
> > > Hi Steven,
> > >
> > > I took some time and bisected the 6.8.9 - 6.8.10 and git gave the
> > > panic inducing commit:
> > >
> > > 414fb08628143 (tracefs: Reset permissions on remount if permissions a=
re options)
> > >
> > > I reverted that commit to 6.9.2 and now it only serves the trace but
> > > the panic is gone. But I can live with it.
> >
> > Steven, should we revert that?
> >
> > Or is there some other change that we should take to resolve this?
> >
>
> Before we revert it (as it may be a bug in mainline), Ilkka, can you
> test v6.10-rc1?  If it exists there, it will let me know whether or not
> I missed something.
>
> Thanks,
>
> -- Steve

