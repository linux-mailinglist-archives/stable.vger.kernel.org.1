Return-Path: <stable+bounces-197027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA0DC8A5F2
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 15:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B97063A8A7C
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 14:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0153303A08;
	Wed, 26 Nov 2025 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Tf/JRJNR"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14CC302170
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764167948; cv=none; b=sxAu9Px36pHKlhMlLgOp+TZxc9tRUaNEIAgmz1+3/29lFPxGbHj+ZU/R7Latqcw/BdvDk1J/H0AoYmAlMXIRY7U9/twA6HeL4+FrQoSiAByrcJZpYO4rsrN1wguXFRXqtNv8tn9mkJUvkjpNG94+nig+J6K5j9j5nBQuxoji9Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764167948; c=relaxed/simple;
	bh=yacBvBYaVY4CpdxU2ivpOumvrEreuCR9cSgT0Y23MFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=te/u3HBtQcvawqaKbVNcvpux46Mw/5oLIySUbhpH+QL7VnytcowcNVqX0Iai77beWAIYbgxTezPmIZ4VxkVt2U3iCv8BCXjG3qRjJc9M0rAlcemC6q+2ZGIo91kPRtCCZBhYJozd3HSXfKvCEzMwtjKfgQlBGhXqDdxF6YfhEIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Tf/JRJNR; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5958931c9c7so8545567e87.2
        for <stable@vger.kernel.org>; Wed, 26 Nov 2025 06:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1764167945; x=1764772745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msBAMbzCaK4P9BYCopufCeh+uY8BrlUveStybrFmxj8=;
        b=Tf/JRJNRdXPW5HiFOnFMm9tk6W6KiDV+cubTpuySsP8E2lbH+kuF9Oh+Sihe0gvciX
         Wxc4PGj8WRr3gtQ2yhu7Ie5k1rzi9etojhLNEmqeWZIlZnReZnozgcVnRuDggAaBr10i
         uUy/YVScj6RO89kxye1qyGWHuDQNvfe/ZB7VAkkZO40P/bqoUiHtorzaRMsBaIbtVssR
         cLbiWyEYhOy1bnmlGCe/70lVNhl8RfAnHnCmuOl+K8ld4WZpbBbLkCwwJ1mw+dzJNFnY
         VEqMjDEstTB4B2+tmt0sUZ/HJWjQLBSEF+zBRV1wPI3Euagn0STQz5BaBF6XTwJLSdrs
         rAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764167945; x=1764772745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=msBAMbzCaK4P9BYCopufCeh+uY8BrlUveStybrFmxj8=;
        b=hOGVl4ZtEyAtLZfNoL9oj9EuHYgyaFjF9j8G7w4eCje1q4XaR2ftgwTURukeraz3y4
         r/mZyL0qOsdHGz+8PK0CmStzF1Bhafu9vq6BTWOJewtyAnQyvuPV/E/Ux6dnsLBK/Au7
         1RBqJBNSJN7wTOKzLLSndSUH/I6Ehq/T3QCX7zP82cUXjPM4SDgEs85lAeUMDGAKcEdW
         ZnSu70uJVSUhyjNDSDVAOky4kSMO9d6vpiljuxJ1nunDksJEVRjMVhZumx2i4SqzN8+4
         HZcPC7zmid3M0Tc6EgzerizIRIEAgHrceBBM9Gqfd5QBcq89xy7Ue4aGT+NlkOoBvBDK
         A9fg==
X-Forwarded-Encrypted: i=1; AJvYcCXs+swLjDwCvAnS6D+b2XuHa8Mgvq0ecGz7m8jMUdIdIQ05dKYSWrw8k70hGRQC8ET1r7CfOaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8SPz01M9KV4F/BhlyPI3dMvohx0GA6zJpSvaNlWAqa79pW7UI
	ovs2LDlYJb0CyR1zsgiSyUMRkg/5G2dRJHvXA3YRNKrEYNWaU90kNOpnnz1jGM8Pt/sYBhWpyu3
	zGGVbuWmsg/Jc0peQ4lXBf0PDnb4P4p7GMgxjkXMFMg==
X-Gm-Gg: ASbGncuRG53pb3Mh6zmerlr0J9OydGwLzkb+966gyul0Q0oRFcsS3CnQEmT0lvgXLYK
	EesmyYr56HI81bS1aINdZ+OmcJ77Oqy8+FHLRUcNIIt1lZuxMxBDxjQb+1ECBTryFrbsA/Gbfxs
	d9wVPO4T1gB4m4Mw7DjesZhStEUJDKctvR7g82529Agjxe3ZnzubwVmQnzj1Zz0G40Qo4fTGd5l
	9amRlOdT0xGHxrZ+t5FUDZ4f8N4kyFeYqhzgkk0ccND8F7VIc0YPwFR96uJtKu+q8Z/21DeEnlX
	wqT+O9HoEzNq2xcUxL3VGm0KsfI=
X-Google-Smtp-Source: AGHT+IFDxRVt50Oa/O/Cj0BOmm4XYwCMA0ik9gwSJjdf5XFhmE6eJiaVMJCla8GLSwR5pSXLEUBXG1Du99AsBWpILQY=
X-Received: by 2002:a05:6512:304e:b0:595:8052:110f with SMTP id
 2adb3069b0e04-596b4e529b0mr2876479e87.6.1764167945036; Wed, 26 Nov 2025
 06:39:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126122219.25729-1-brgl@bgdev.pl> <gy6ycgcld2moccjjl7x7h72riwfm4ymhnkhlgau53fl4eu3e6q@qp5lrwx57jin>
In-Reply-To: <gy6ycgcld2moccjjl7x7h72riwfm4ymhnkhlgau53fl4eu3e6q@qp5lrwx57jin>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 26 Nov 2025 15:38:53 +0100
X-Gm-Features: AWmQ_blncx36kZC3fH6WyyuMqAepzKDyy1dWzU4Yz0s9JWV27nROSI0p6FrG_AU
Message-ID: <CAMRc=MdXXNaMVK5q+yNSZcLjjoQLwPmDnMW90gGK+uk77F+3ZQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: lpass-lpi: mark the GPIO controller as sleeping
To: Bjorn Andersson <andersson@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Srinivas Kandagatla <srini@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org, 
	Val Packett <val@packett.cool>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 3:35=E2=80=AFPM Bjorn Andersson <andersson@kernel.o=
rg> wrote:
>
> On Wed, Nov 26, 2025 at 01:22:19PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The gpio_chip settings in this driver say the controller can't sleep
> > but it actually uses a mutex for synchronization. This triggers the
> > following BUG():
> >
> > [    9.233659] BUG: sleeping function called from invalid context at ke=
rnel/locking/mutex.c:281
> > [    9.233665] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 5=
54, name: (udev-worker)
> > [    9.233669] preempt_count: 1, expected: 0
> > [    9.233673] RCU nest depth: 0, expected: 0
> > [    9.233688] Tainted: [W]=3DWARN
> > [    9.233690] Hardware name: Dell Inc. Latitude 7455/0FK7MX, BIOS 2.10=
.1 05/20/2025
> > [    9.233694] Call trace:
> > [    9.233696]  show_stack+0x24/0x38 (C)
> > [    9.233709]  dump_stack_lvl+0x40/0x88
> > [    9.233716]  dump_stack+0x18/0x24
> > [    9.233722]  __might_resched+0x148/0x160
> > [    9.233731]  __might_sleep+0x38/0x98
> > [    9.233736]  mutex_lock+0x30/0xd8
>
> As far as I can see, this mutex only protects mmio accesses.
>
> Is it preferable to mark the gpio chip can_sleep over replacing the
> mutex with a non-sleep lock?
>

I'd say let's do this as a fix and convert the driver to non-sleeping
with a spinlock next cycle?

Bart

> >
> > Mark the controller as sleeping.
> >
> > Fixes: 6e261d1090d6 ("pinctrl: qcom: Add sm8250 lpass lpi pinctrl drive=
r")
> > Cc: stable@vger.kernel.org
> > Reported-by: Val Packett <val@packett.cool>
> > Closes: https://lore.kernel.org/all/98c0f185-b0e0-49ea-896c-f3972dd011c=
a@packett.cool/
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> If we stick to the mutex, the patch LGTM
>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
>

