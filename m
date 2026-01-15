Return-Path: <stable+bounces-208445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CE6D25067
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 15:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21C363025592
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 14:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B680A2F069E;
	Thu, 15 Jan 2026 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZehheyHn"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E752EDD74
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768488070; cv=none; b=R+rqYwnKM3wzboTgVOhOskOdgH/Beysa9UG0by51zT2A7gMiD/PTOG5QayVHUJvAUUszwYMx09tcfXT6EMFN0Hchakc0MKWZE8a9yeSrkq/zD7H99A8kIswlS7hAJd/Uii56h0LiYqE9SanzIg/QMxXg2kHXlhkvr0kShgDAnjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768488070; c=relaxed/simple;
	bh=GInh3nUv0oilWh4/RLwMQ0PHdeVF5xMKr3XHFWhjCro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vc3Bzd3EKRGczy9FStkKkQNZld6iPfj0BRFt5iAVkaaJX7zDxHcOeEWQZ1mXijXSNwQ2PKQZ2I6Xj0cc/rnSX/06ea1yLe53RD5N+fqerPKVbBD7r4CYkMwS3hcawqlCjdzsBfmEuh29m118YJkRGR+kj7h3rxBJojzBczoKkNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZehheyHn; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-644715aad1aso1134042d50.0
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 06:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768488065; x=1769092865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z81HGMXqVmwkEbr9DtP4R35AytWB4ncl1E46T6NrNg0=;
        b=ZehheyHn6EuL34hwqiFCUob4fz5uerSfY5hrvx9UfRtYIFGAfpzQeblOT7C7Fx4Lk6
         CXleJje4yWCLMlXjIGJ76QyrkgoxPsLK854p+Odaea+18n+zT5FpiEiGWZmvXDjCq9YR
         tSoyOb2Pr0jOXz7HOGZ88K3DYcloesk51iQZgpIxH/NwEscNgkO7sdXfjI1xa5tTomq+
         eWgg/kHhiflt1XZJG7q7LvIjDkgMtEzq7yuvnzE3N0ZK7/5XT6nS+jGJyV42irHMD7AZ
         MRG5eP4Tnv+Rn2YO412Mrp8EWMibYWeIs/E6Lq87jOqX2z3DhPq1NNQf+2rHinWsglt+
         r8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768488065; x=1769092865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z81HGMXqVmwkEbr9DtP4R35AytWB4ncl1E46T6NrNg0=;
        b=aMaqj8VOl1Ld5EnnetiLhz1kP6CyaVt6JSb2BcvDn3Ip0GY7R5G9hed390h7aBcC8N
         yUVagwf5XbsJvrCdG9f4qutn5IrVI6wGzWAJVPtpWi1RpSE01OO7l9TKm+jrliGjDLoP
         r3P5/gERHV9bNKTi8hgv92U3PDmq8lDCEr2ZyH2YPfKafoOO5J6Oo0qI1jCQdm+QzxnQ
         wP54ElAy/SsPScGy2clH4J2jk7TIxXFGzS3Ow+l0uw+ycvFYutBPX1UsVoniIyydr5lL
         QpLbfIzzxHbC+JkDAPgzH6wx6Cuv160bYcrd5+VMtn3biz4B4B7wIPYGYVgq3JT8NKIp
         XfWA==
X-Forwarded-Encrypted: i=1; AJvYcCUa/n7xzDx2ZwM6jMyvLwE/kjRIjtRxsmBeeQRk/KPTR3gLsPHTeZJaQ8zvf1MAxrdclUuxj6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLkl9z5WxUuBcWPU+SATokXoc5dh731PF2cPcFmIyDyvO5PsWi
	Q6jXtQvMEacPgGMPbiXHRc0W3THqtOd4vYK3V+uQ/Fh1G6mIKWNK7TIyZgHVhiNg+HZYSXStLSP
	2OZf+wKXR2r4PFhRzdhVvTd8rBPONub0=
X-Gm-Gg: AY/fxX75O0ei41Lh2Q7w706AlGR4rv67NhD3zt+ny48Ea35EcTwOvara44vlNbq2yqw
	MbJ9pLJg6mAMdpPX9guzhnemz1Qov8Vj/3bcIBQkTCdkJ+SSl+SjfJIArHVTlVVc2JMscNX2DmE
	g8Yoc2NEv7eBvZkVaPDd6CUlSv3n0x3gXYyXm1geU0n6dr8om5NlhWrHgT3IcEbAU7IYPy7Uz8o
	9+pwDnKQjT1YagqVof1yLl0LRZu19y5jxiGGtlJ9Liq0N2GT/0w2qSL0dATTsnGTMvdz48=
X-Received: by 2002:a05:690e:bc5:b0:644:50c7:a50f with SMTP id
 956f58d0204a3-6490a6349c2mr2227428d50.24.1768488065507; Thu, 15 Jan 2026
 06:41:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215004145.2760442-1-sashal@kernel.org> <20251215004145.2760442-3-sashal@kernel.org>
 <CAPnZJGD0ifVdHTRcMzKBFX8UEf_me1KTrkbwezZrhzndcTx-3Q@mail.gmail.com>
 <aV5Ap8TgMEDLucWR@laps> <CAPnZJGCJ1LZRzfzO=958EfcrLm4Z3pYdtHZEpp812fstsUcOAQ@mail.gmail.com>
 <2026011119-stadium-trilogy-22ac@gregkh> <CAPnZJGAXLEgqKx+XA3RugES1kcawtqMEYPTzFERcf2kgRjNbFQ@mail.gmail.com>
 <2026011237-stage-cognitive-53c0@gregkh>
In-Reply-To: <2026011237-stage-cognitive-53c0@gregkh>
From: Askar Safin <safinaskar@gmail.com>
Date: Thu, 15 Jan 2026 17:40:29 +0300
X-Gm-Features: AZwV_QgBhEkHg8G4nrRtDlicjTzqS5qOFrS_cH_u9ZI-9GPpebn_HVcGMuB8Eec
Message-ID: <CAPnZJGCPM2hjbjX6_V5ko0KZ4m1gQ_fA2bL8R51UwiwQ3=ForQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.18-6.17] ALSA: hda: intel-dsp-config: Prefer
 legacy driver as fallback
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, patches@lists.linux.dev, stable@vger.kernel.org, 
	Takashi Iwai <tiwai@suse.de>, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
	kai.vehmanen@linux.intel.com, cezary.rojewski@intel.com, 
	ranjani.sridharan@linux.intel.com, rf@opensource.cirrus.com, 
	bradynorander@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 1:54=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
> On Sun, Jan 11, 2026 at 07:01:53PM +0300, Askar Safin wrote:
> > On Sun, Jan 11, 2026 at 3:24=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > > Why?  I see no context here :(
> >
> > Please, backport 161a0c617ab1 to all stable kernels, which have 82d9d54=
a6c0e.
> >
> > 161a0c617ab1 fixes bug, reported by me here:
> > https://lore.kernel.org/all/20251014034156.4480-1-safinaskar@gmail.com/=
 .
> >
> > I did bisect and found that 2d9223d2d64c is the culprit. But then Takas=
hi Iwai
> > explained that the bug appeared earlier:
> > https://lore.kernel.org/all/87345iebky.wl-tiwai@suse.de/ .
> > Iwai said: "the bug itself was introduced
> > from the very beginning, and it could hit earlier".
> >
> > I assume "the very beginning" here should be interpreted as
> > "commit, where intel-dsp-config.c appeared", because the fix
> > modifies "intel-dsp-config.c".
> >
> > "intel-dsp-config.c" introduced in 82d9d54a6c0e, so
> > 161a0c617ab1 should be backported to all kernels, which
> > have 82d9d54a6c0e.
>
> This only applies to one tree (6.18.y), can you provide working
> backports for all of the other stable trees?

I just sent backport to 6.12.y.   I hope this backport will also apply
cleanly to older trees.

--=20
Askar Safin

