Return-Path: <stable+bounces-198088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACABC9B88A
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 13:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F4003A7530
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 12:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238F4313285;
	Tue,  2 Dec 2025 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/zVLb7W"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577C3302143
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764680194; cv=none; b=gRd1M9InkHVGHC/tRCwZwTH1oy/uVnPF1L81ykaAJg85Gb2zQqmn3mP4iY6LXPYULvnvvUbwJiJJ9Xgix7b8zHs3SeW7QIO89+n5bZ8/DjP7Xww8YyPjmDilFEADu3XWdr1lg36AY3i4h8H54DoF8hQ7vp6YnM8Zk1PIAES5kdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764680194; c=relaxed/simple;
	bh=X5XptyRg0V6xIXYaH8cGgPYeufNCc32cq0Y7tnm8N0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XITYBqZhkxjfiAL93X+6IsNvkFy9W+x9GNzZoN1jyQ1l/XfRd98xEDeh0mPY9ErK7tjcHWE6ZcXZK/ttxuXWT76M5LzZ7E+lAJ99FgcsgmUcls8uSiwH1T4tZ4PqHyS7t4USyJRZy4xpXlc7jg99MLfq3v30SxS9FP8zEqR0n6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/zVLb7W; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-787da30c53dso52424907b3.0
        for <stable@vger.kernel.org>; Tue, 02 Dec 2025 04:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764680192; x=1765284992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5XptyRg0V6xIXYaH8cGgPYeufNCc32cq0Y7tnm8N0E=;
        b=E/zVLb7WsThlxshIWURSdTMjU2KO0D4xakXOhHZMj6E7yuWjp9/eCiveCk1MdZ9tDw
         ai7Aii3JoZkwlMOOMkmwq8r2iBPFf+9BA4POUREcsdkKm7sIgut/VKIxp2fafkLjGAeH
         3WcESHVqiqaVAzkrSixAO8x0k0efgsOmWz9amtwpw5Y8yNONUx8Sa1ydNfIMSBPajq6+
         Lt5MD6zwtdDei6gsH+FodNIZtPLoxjwYptmdnKasRtT4c6OISRoun/sxXstrhBOcpmx3
         VzVEv9n2gQyH5/SdpNV1JmJVLHjHMTLF1zCtZW1os7CJaNYSlqx3+BQ3tbPWjpmBHAJi
         6vuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764680192; x=1765284992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X5XptyRg0V6xIXYaH8cGgPYeufNCc32cq0Y7tnm8N0E=;
        b=XymCEYzME+onKOCtEZq71oTGKZ6RqUgVl3G1oZ+VszupMqCtKw/b85lyNQpghpVd76
         9Q77IFIQWFwlKolTJLa0rwADWs5xZoWdihqLirRUxwbwKQiV/VmLuJJ0fANoKPlRV+2o
         Q3VsdubwkBPa6QFQ0aHgSgta8eEBH3XjkD+urUYt/x+Cm1T6kmDBJgpBXrs3FrzdlBLi
         QGLIXodqTD3DTxyZ2EpHujAE+zLvMjCXZ5yjZ3i2k4glZDTWyLAb7g1BmiRDaWVeZypR
         qI/RP8eLaZl+Q7x4xP2eR+fpGS2W741Tu+LfasnfIftih3CJSzpRlxVtoZ7ToY/RoEhc
         k5+A==
X-Forwarded-Encrypted: i=1; AJvYcCVeR1hTdSYdUfSgyGcyZhDePPP8WQF5KbEzCDIKyCJKU0JiXPMzA3oNaD2TjAE/CxmyHXgPms0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI59/hmWNGs2ziwH290mHhVPQv+U167sXgZs8zUdZp+0g0tXmE
	KTOYEZkxsj15rxa25x3/5KIk3hldR2Q6inHGcR9oMpvTCwpmIAwW8jPVcfHDff3JsjDNQOChLHD
	HiUVph3HuhTocBy2FnrDAAZz2ELXcxe8=
X-Gm-Gg: ASbGncsWYA9n5/LfrzbujvPytSD9NWDduuG8nRzvEVz/Vyu3m6lA/UDF2GYRmPPnHD0
	jnJSQY+X3XBZlmKCc3hGooktoBmqI8Bn+R4KNFt6aQPJXcyi1lyH8roDbp/Z6QAk4A3Vb90Y0DA
	C3NFKHHfIvVposaSTtV2Mq46i8tSiTbomqZUkjfetuZxyb/+AM60WmGVhhp5qibOcc3wC0vc0Um
	jQX/2su1BxqOSY9frEfV8beo8SNvrTZ5sVR592C45f+/pnael34BrsIdgqeM5kK0gEFQzo=
X-Google-Smtp-Source: AGHT+IFWvd/Jg2PHJ8dCgKfCqITnGuYDu5UIS8p468SFhsPj2lrZIUJDqHaziM8xR41qt/h2TwW0PHnbJjWSJlr4uGg=
X-Received: by 2002:a05:690c:b9a:b0:786:5620:faf1 with SMTP id
 00721157ae682-78a8b54d499mr343901027b3.46.1764680192362; Tue, 02 Dec 2025
 04:56:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201034058.263839-1-lgs201920130244@gmail.com>
 <7917b0db-82b7-4a75-91cd-d3b6b0364728@molgen.mpg.de> <CANUHTR9o-wzkSzYeRwQvu-MEdYXQ4tbNXvDD2WyCfA1MGCG=Bw@mail.gmail.com>
 <a4ea0043-9ee1-4b9d-a2b3-811c36b12ab8@molgen.mpg.de>
In-Reply-To: <a4ea0043-9ee1-4b9d-a2b3-811c36b12ab8@molgen.mpg.de>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 2 Dec 2025 20:56:19 +0800
X-Gm-Features: AWmQ_bmBqFLvXwPU5QvquqBV9IKbR5CvMxyKznfoWOr_JLhm-lwBZGfYAbm6Z6E
Message-ID: <CANUHTR_6AgpsZszMAOvtbRYBbh+_uvvLmjrHyG_HsNQkY4=9=g@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v2] e1000: fix OOB in e1000_tbi_should_accept()
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Jesse Brandeburg <jbrandeburg@cloudflare.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Florian Westphal <fw@strlen.de>, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Tony Nguyen <tony.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

Thanks for your reply.

To run the reproducer, you'll first need to download the PrIntFuzz
project from https://github.com/vul337/PrIntFuzz and set up the
environment. Once that is done, you should be able to run the attached
syzkaller program to reproduce the issue.

Kind regards,
Guangshuo


Paul Menzel <pmenzel@molgen.mpg.de> =E4=BA=8E2025=E5=B9=B412=E6=9C=882=E6=
=97=A5=E5=91=A8=E4=BA=8C 19:53=E5=86=99=E9=81=93=EF=BC=9A
>
> Dear Guangshuo,
>
>
> Thank you for your quick and insightful reply. (No need to resend this
> often.)
>
> Am 02.12.25 um 12:34 schrieb Guangshuo Li:
>
> > thanks for your comments.
> >
> > ----Do you have reproducer to forth an invalid length?
> >
> > Yes. The issue is reproducible with a concrete system call sequence.
> >
> > I am running on top of a fuzzer called PrIntFuzz, which is built on
> > syzkaller. PrIntFuzz adds a custom syscall syz_prepare_data() that is
> > used to simulate device input. In other words, the device side traffic
> > is not coming from a real hardware device, but is deliberately
> > constructed by the fuzzer through syz_prepare_data().
> >
> > The exact reproducer is provided in the attached syzkaller program
> > (system call sequence) generated by PrIntFuzz, which consistently
> > triggers the invalid length and the crash on my setup.
> >
> > (The attached program is exactly the sequence I am running to
> > reproduce the problem.)
>
> Thank you for attaching it. Excuse my ignorance, but how do I run it?
>
> > ----Should an error be logged, or is it a common scenario, that such
> > traffic exists?
> >
> > In normal deployments, I don=E2=80=99t expect such traffic from a well-=
behaved
> > I2C device. In my case, the malformed length only appears because
> > PrIntFuzz is intentionally crafting invalid inputs and feeding them to
> > the driver via syz_prepare_data(). So this is not a =E2=80=9Ccommon=E2=
=80=9D or
> > expected scenario in real-world use, but it is a realistic
> > attacker/fuzzer scenario, since the length field can be controlled by
> > an external peer/device.
> >
> > Given that, I think the driver should treat an invalid length as an
> > error and fail the request instead of trusting it and risking memory
> > corruption.
> >
> > Regarding logging, I=E2=80=99m fully open to your preference. From my p=
oint of
> > view, logging this as an error seems reasonable, because it indicates
> > malformed or buggy input from the device side. However, if you expect
> > this condition might occur more frequently in practice and would
> > prefer to reduce noise, I can switch it to dev_dbg() or even drop the
> > log entirely.
> >
> > Please let me know which logging level you would prefer, and I will
> > update the patch accordingly.
> Then I=E2=80=99d suggest to add an error message with error level so peop=
le
> notice and can take a look.
>
>
> Kind regards,
>
> Paul

