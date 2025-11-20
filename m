Return-Path: <stable+bounces-195247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1DAC73952
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 11:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 723CE2F91D
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 10:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3713D32E123;
	Thu, 20 Nov 2025 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nDTVVDlS"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D234254AE1
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763636146; cv=none; b=m/IHQckBAMwix1bHocykGcctRlJ8YwzvB9mG3wPauTKki3q73fAMR1OzvZQV0m1q5BZK2szI/Sed0eHEU/HFeKDWRf2Zjd6X+PmixlPBhGwJeD9VfSiTWH7vmiA/IUC++zpDjT4cl1vXzJdsyUXYhKXIlWv9sVRVwRnEIMxchMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763636146; c=relaxed/simple;
	bh=cvbHrmgf08XIYn3vUZdntoO4zAMQE+fQWmkHA4zq24U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+b5cZrT5K+9o+D0ovGdGM0ed8xf8TIlgltiu9eGxqrAM+1fLGhY1MLpcwxtA9lvQAY7fmVqCkXmHpVxPa6y5s70GUonvrksUaVP+3l0K0kSy8Br0qewHzY726HL+kaM9yfX/H5os+ZV/F9F5abkh0ozM/mDc4JRPjRilKePdN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nDTVVDlS; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64149f78c0dso991499a12.3
        for <stable@vger.kernel.org>; Thu, 20 Nov 2025 02:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763636142; x=1764240942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sEvhisOEOg0eUGED/5mmqd5Rh7K5bewJZQlOmHEK/fk=;
        b=nDTVVDlSwyINAUYdz+nL+UspcRrPimaw6grB0wXSi9DKrNw13nboKdfmGbtVFgez/j
         L8NE6F9tfRxicsqLoxA5wyMKOjVz8gRS5tOLXKcRqfI4UsT/WXDpVBeM4aCOzZSMY09R
         zE3Y+F6Xt8MR4191119DN2Mobc0Q46EO2wIkuKzDFUtaP2/NqdGFYr0UE5ANB+IfCErs
         nTPlcM3J0XoPEP1SjSoMOr2xN/Fd92QicfkktG82CbB+3Tpjed8/ebpL2P9jD5qum3lu
         NzRV+g7cVTfgDy0GCqE902VDgQOfXL/vN6ovEIJUfhSIYZAQgrxndjDj0QCpRQRPgWYh
         0Kyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763636142; x=1764240942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEvhisOEOg0eUGED/5mmqd5Rh7K5bewJZQlOmHEK/fk=;
        b=AqetZMw0eXWJj+LHVxzkPG4ge8VNAfrw9+7eV54a1jvnRRVqfuFpyJAcCFPugwT59F
         iRtrimfdG1aZp7jmHEqByT4YPkHZg6/Q0cAHKZvPj+8cfpUr8QNn757+Zof9or2xcmjp
         tjzkM1EAoXBCaEuyjozewDF24SyPRU+XRWzafehq8Ru3Rjd2p1ml6FFPtWTf7w0qzBIJ
         thJjagcjVEqs6hC7E2Laou4OenskK5jkk/E/y/tAVKDssXzLf0ev1bwUI0U0cqC8jSuO
         PWoliop6WoRPzPJr/gclBoGj/TRQG5DH5WAUjvRZKagMLjkQRCDSX+Q+drWKiUV3KDTv
         kVUA==
X-Forwarded-Encrypted: i=1; AJvYcCXMi3rbS4z2UJlITgZiL1edgu7hdkBJ/fUhrFaw7QULAyjS1iVzywcgpxoqJ1j9rkcYOuutWPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb8kS8OVPGG3siCs8fOXkAnOeAqBLDmv12gi4m1xotuPq9NWXx
	t+4BLwTkwsYmq4IVCYb065pO4NK1dztgoKZ+gJbkAeJjmMuXbwjEeIy99xiScRc6g8BFD2/pK6o
	9BQsnTdzxER9Wjr/Rs+/t6oH4C0SrBCnVfAhBntb/lA==
X-Gm-Gg: ASbGncsVeGO6mpd9s007RtAA0JJxJlge/AYH5QmK6BmnLS5xlSIy+yo4DxC1sQc5INO
	7F+vPI7fnh0diuuE81w7LkgaZvcAiVu0iHsvVom4S2JAWgdXY0t1QkI1notvQ0Z+ua8zoQ5FWJ1
	iifINFb7bd9nyRf1aqj4DQA8JMPO+z+mS46PecHXO0SAcAGdwh3UC8Uwcl38jNztUiVzMcyMQ3S
	Kjf6ZY/hwbfA0hRzzjA4mgd4HEbjz9ikGPGG6g5HVVjVf2OAIxxOhBrEbPgvOlX5/voWcrcCqdA
	glnGWUGGVaFgEhld+DkxY2I=
X-Google-Smtp-Source: AGHT+IEEbNQPl4pHbHNC71Fe8G1/2uwl/krtAuMVOHWxz3fLv34NYSeDkLKF82fimJciS4w0Rmz8whpk90sogY49m7w=
X-Received: by 2002:a17:907:9403:b0:b76:5393:758d with SMTP id
 a640c23a62f3a-b7654eaf6a7mr35795766b.34.1763636142531; Thu, 20 Nov 2025
 02:55:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <q2dp7jlblofwkmkufjdysgu2ggv6g4cvhkah3trr5wamxymngm@p2mn4r7vyo77>
In-Reply-To: <q2dp7jlblofwkmkufjdysgu2ggv6g4cvhkah3trr5wamxymngm@p2mn4r7vyo77>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 20 Nov 2025 11:55:30 +0100
X-Gm-Features: AWmQ_blAIbaFsVzIrvLzF0Uj_TD5xSQkMIO9nrj7gb4Q7GJzX0PkQO_vz47YO58
Message-ID: <CAKfTPtAkYfCYc3giCzbDFLBDNTM-nXjkE8FXMZhvJj_im+Qz0Q@mail.gmail.com>
Subject: Re: stable 6.6: commit "sched/cpufreq: Rework schedutil governor
 performance estimation' causes a regression
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yu-Che Cheng <giver@google.com>, 
	Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Nov 2025 at 05:45, Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Hi,
>
> We are observing a performance regression on one of our arm64 boards.
> We tracked it down to the linux-6.6.y commit ada8d7fa0ad4 ("sched/cpufreq:
> Rework schedutil governor performance estimation").

Do you have the fix ?
https://lore.kernel.org/all/170539970061.398.16662091173685476681.tip-bot2@tip-bot2/

And do you have more details to share?

>
> UI speedometer benchmark:
> w/commit:       395  +/-38
> w/o commit:     439  +/-14

