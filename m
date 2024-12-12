Return-Path: <stable+bounces-100859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E946F9EE1EE
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 09:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D673284270
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 08:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5A320E325;
	Thu, 12 Dec 2024 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SbEVLHWc"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113CB20E03B
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 08:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733993614; cv=none; b=P/Kr7AVQJ42kL3YCseCRaxGdLUPzCTmWQsWVeU6S10QERRo+XqtAzYS5duvYbcxY7R5BxMe1M0KpQlZVzN3ZHULvuCe8Ipxdjn95WYmVoGXfB/KsdvxhBqrUDLRo5Gb+Ir1+8vqXrTSVhJctVEgKTSmzA+2Itak1UyZKfckESfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733993614; c=relaxed/simple;
	bh=w3b8p5pId723s8apGEqRiRPGF/XIl9RTYQEEC3QeUe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJbJUe7Cw0JhAkoiMklW4UNyI55/F/p9NYEEreqsjbSeMMc0lWqKzcDOnJepjqhuAQT66zHWGT4LxRzYdDlkmKQF9d+ALsNTFw3VqJIm2aLICyPRjbcZzLG9ZnTS31BBYnOb1Y0q/PC7vJ9HGfIFDm1wfboHTYYtz5Bv0Z0HLIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SbEVLHWc; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa67333f7d2so47487566b.0
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 00:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733993610; x=1734598410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3b8p5pId723s8apGEqRiRPGF/XIl9RTYQEEC3QeUe4=;
        b=SbEVLHWcXutoigyl/7qXFyQbT9DylN3xupgNoOdAyxSOu7lxnUeZOm/sbZ+bAK5OMS
         RNWJDzQLkm/2cU8qndkclgdG3yWjolK81TcHofz6AaaAd7MuAciAilWXlCt25V1SQzFz
         +LSv6P56rlX8tYvBEJv1B86Eazlnfzn9sFwLy01CuzEqBYehCHairzWLZB0Y6jOXw3eY
         Z7sWw5UodWisPWnEJdra0+JSGDt8W5HMKJIigVklB9QSL4eTo3pZWTn42RlusnFC+HIl
         1Pnzp6leWr0IWIYKAoketeoqhUkHmRznLaJuive/OAyiGLamBSs17e7N6Nv9cyK+jal9
         Iurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733993610; x=1734598410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3b8p5pId723s8apGEqRiRPGF/XIl9RTYQEEC3QeUe4=;
        b=hZVtMeMiuX6OWWMCZg6WK0HeLMrsin/A63W1o4agJYzbjDEsPQr5z+DmOeUEuLjcEl
         2ZgctROnqzDC/ZEkeKZGrixHvHAvgeJc5SdSKzX4QLgbX/ACSNMIjFefzP+4pU+Jb/44
         Xg/VAZe8/S/fGT7ZSY431Ab+lIRY3e2iN9Y0sPhOlO4U0Rxp8IqEBXsDCpXwAtZcqkuk
         TyEJNGxQ+PbcIhXCQep2mffRD2sm/RrsgEXxScR6GLYBtNH0nnuZFfo/ps0+iifBuCgD
         1rdIU2yoxLy174gTDfm2TvgBAIKDksnTzN6kE2gmrsIsqqdTAPAUwkIcSVDipt+SJsHe
         0ZlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzT7vkGs9s/JzxpuQ2Q87WspvLOlEyR6MIyYOWhLpiCeWzl/uaVoC1yR7dyBy18VL0Vi7KcS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOOC8fSsMqNJTqCSS2cUKWKaypygGnlHHTVolWrqT14gfBtgUp
	KnZfDvLx7B5q+UyKYQrT4zkHP7Qo8ZOwli0xAJ2Ru0HcVcJh72s6x7r1Dl8ppvN9N/euzqDrDsG
	1Dp0AujOhmXg+tLT66y3J1ozIL9gLMjTMUiP5+Q==
X-Gm-Gg: ASbGncvinXYxq3lUbb2xA/ceEKHNnrryKd6h+DHk+4Nftq6HbZs6wWPyo7cMm95tC90
	3HxOruQxNttiBtaHLzuo8GbnbmPfElDU4z7t+
X-Google-Smtp-Source: AGHT+IGfU6rtOHJOHdj57SSVfLI9f6Fq/2KuTXoPZHJiIsnpZhdomXumhthcwf+ID3geTKkQc3OpcXoAOkvCd9M9EK8=
X-Received: by 2002:a17:907:b8f:b0:aa6:a9fe:46e5 with SMTP id
 a640c23a62f3a-aa6b13d1a29mr485360666b.53.1733993610333; Thu, 12 Dec 2024
 00:53:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212075303.2538880-1-neelx@suse.com> <ac4c4ae5-0890-4f47-8a85-3c4447feaa90@wdc.com>
In-Reply-To: <ac4c4ae5-0890-4f47-8a85-3c4447feaa90@wdc.com>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 12 Dec 2024 09:53:19 +0100
Message-ID: <CAPjX3FcAZM4dSbnMkTpJPNJMcPDxKbEMwbg3ScaTWVg+5JqfDg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix a race in encoded read
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Omar Sandoval <osandov@fb.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 9:35=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 12.12.24 09:09, Daniel Vacek wrote:
> > Hi Johannes,
> >
> > On Thu, Dec 12, 2024 at 9:00=E2=80=AFAM Johannes Thumshirn
> > <Johannes.Thumshirn@wdc.com> wrote:
> >>
> >> On 12.12.24 08:54, Daniel Vacek wrote:
> >>> While testing the encoded read feature the following crash was observ=
ed
> >>> and it can be reliably reproduced:
> >>>
> >>
> >>
> >> Hi Daniel,
> >>
> >> This suspiciously looks like '05b36b04d74a ("btrfs: fix use-after-free
> >> in btrfs_encoded_read_endio()")'. Do you have this patch applied to yo=
ur
> >> kernel? IIRC it went upstream with 6.13-rc2.
> >
> > Yes, I do. This one is on top of it. The crash happens with
> > `05b36b04d74a` applied. All the crashes were reproduced with
> > `feffde684ac2`.
> >
> > Honestly, `05b36b04d74a` looks a bit suspicious to me as it really
> > does not look to deal correctly with the issue to me. I was a bit
> > surprised/puzzled.
>
> Can you elaborate why?

As it only touches one of those four atomic_dec_... lines. In theory
the issue can happen also on the two async places, IIUC. It's only a
matter of race probability.

> > Anyways, I could reproduce the crash in a matter of half an hour. With
> > this fix the torture is surviving for 22 hours atm.
>
> Do you also have '3ff867828e93 ("btrfs: simplify waiting for encoded
> read endios")'? Looking at the diff it doesn't seems so.

I cannot find that one. Am I missing something? Which repo are you using?

--nX

