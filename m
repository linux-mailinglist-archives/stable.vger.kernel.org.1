Return-Path: <stable+bounces-180730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E3EB8CA9B
	for <lists+stable@lfdr.de>; Sat, 20 Sep 2025 16:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF853B8CEA
	for <lists+stable@lfdr.de>; Sat, 20 Sep 2025 14:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA0527F198;
	Sat, 20 Sep 2025 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cgbfwepd"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B761A2C0B
	for <stable@vger.kernel.org>; Sat, 20 Sep 2025 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758379552; cv=none; b=bzwZ3EPd27C/qpw3j6zhvD/HmEgA6xyHfTudONuuyzxIjJOWzLtcvMeC48SilOLxIhh7DRpxI6o4/deE/dW8MWj+d9lp84ZDsBytTYdEA/7s5R0SVARRJ1jvMA5KGfKlgR8V3wutGG5mY6SEJISO3bwokNvNjbI1eNbkQgiEjgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758379552; c=relaxed/simple;
	bh=prBMWFMAjr7chjhq3P8rvyzynNtcsazQYroaTwzNLjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HamZvEkWycI91OPskK4WRCVyXQHa4o7EfIaPvauq2ddCiIDBGGPf4QYwYGSXPITwPPA1bF4O5Ig0Lt3jvpAFU9PGbxztmRHFFbpCnvE/k8KDSEZXBjZdPjrcBIUk+xCPiADPZmE/rFs8s3odJmaY5AZG/eQCHoxQmtte+k5mH9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cgbfwepd; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62fce8b75a3so2444391a12.1
        for <stable@vger.kernel.org>; Sat, 20 Sep 2025 07:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758379549; x=1758984349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prBMWFMAjr7chjhq3P8rvyzynNtcsazQYroaTwzNLjk=;
        b=CgbfwepdIvIdG+kIvTHvZ3bhrU15DZeNDymrei7KGLcOTrunR1M1LSsArcR74N5qmN
         GSBJdQxqjxaPXKQiH8iO7CMrm9Yrp0jZAP99ptp7a9aG+3P/j0kcK9RCv5ebLmr6kjvL
         DkKjABbATudAZo8FNzhqOqvzTfezcUzooJ+2eAo/BhpYWw/OHgy/lqBEM6Ec77s0vlmY
         hOF+FU1Bb/ZJdUlyUgv5rijGV5dHoS2RU/UP7bkeve1BhaRyntJ6ttuYsAQp89mNSUSg
         Uyu2Q3s5ltbzR6Rf4EH1XitBCnRb2t3chjsOt8LxshlC6gHSy0RTn5/vgdjZ2+y8miZQ
         8Hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758379549; x=1758984349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prBMWFMAjr7chjhq3P8rvyzynNtcsazQYroaTwzNLjk=;
        b=C9IvOPycFkbmNYf7VijNWvLgkgqwVAVRWgLG9fCwuEZDrRt/usBigLyPa8bLT99gLH
         xuSdCHIFE7y3gTBKgVFE3ndt/78hOBX1RllRd3yuQJViWC8KgsZ5MUoT9y/q9GhVfPfu
         JTc7SSUUfsBlUkSuSkR+CLzxOJ9JZ8xQQLvCOY/KO78fv3NFz+cM8EI0bguP2x6GVUFL
         q4dt8kKmmVHDVyvw//Bs1ELiD8jmUmhyb8uJ8PjlD2D3tjkJ44NzOflswD8HaQ4q+1dM
         G9hnwBhdZydo8i3AcK3XBrCcTJCOQzKo35j6Q/S4kpZBqO10+Wjgd7RA14LY8uMzi7Ye
         E9Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWhQOwBOaHPqQy9kNyB9N9Sz2S6zp7cHxak1pExvyRVPxGGRSEY1nwwLKaYYQAoJESoPv1FAeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVR4eejlDqutaOHTOTLP72QDDyLCayohi8SknjY47VlbionYn5
	0LuRzX4k4vrmY47WI986Sah+Gpa17/CNixGYQUyv7VL/31yl7sWdyR+ZonIhEAwKrJjyXmXPr3T
	kglsEMXV4oBVqFFBU52n/Y9AxzLbD3l0=
X-Gm-Gg: ASbGncvjch/THWZbfe+Aw8Vs0bGFknsoZ7DKRwvE1VN7jrLk4Z/hXXW8KSK7ibX0Lgy
	H2cz4Urag2QFXPpA3abfI++tojfz0SBnfX5Km8UAwYtd+CXE2CJClzvVB2p0iv0AZE7yi7LazGs
	kA3eutVx+Cx9ay4pdF2kSXWJl81IVevTUzpEnIih0D6BXLIDepFZyt3bYUkuVtZaLzNgrdQ6+1A
	RqkqCZvld06VwiQSlRUG8K2JKQkSBGk/8Qg9g==
X-Google-Smtp-Source: AGHT+IHprf6sIuf8mcq+DmIUBFqEQvSlyTeJhORDOjRBm1D3ME0hm3yswxncK13S9OfrbZrNkgv0Ra//B/ErT5QPBuA=
X-Received: by 2002:a05:6402:3488:b0:62f:464a:58d8 with SMTP id
 4fb4d7f45d1cf-62fc090a920mr5609831a12.3.1758379548473; Sat, 20 Sep 2025
 07:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752824628.git.namcao@linutronix.de> <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
 <aflo53gea7i6cyy22avn7mqxb3xboakgjwnmj4bqmjp6oafejj@owgv35lly7zq>
 <87zfat19i7.fsf@yellow.woof> <CAGudoHFLrkk_FBgFJ_ppr60ARSoJT7JLji4soLdKbrKBOxTR1Q@mail.gmail.com>
 <20250920154212.70138da8@pumpkin>
In-Reply-To: <20250920154212.70138da8@pumpkin>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 20 Sep 2025 16:45:36 +0200
X-Gm-Features: AS18NWB9O-d4JEBCOZIFX72GOz0-xwuKTumjYGdgLUXXtHzgyf5FekADp6hUP4M
Message-ID: <CAGudoHG9hTwSoordwbMDci5CmnCKMhD330Z0BKfNJ+xUHYC9uA@mail.gmail.com>
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
To: David Laight <david.laight.linux@gmail.com>
Cc: Nam Cao <namcao@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Khazhismel Kumykov <khazhy@google.com>, Willem de Bruijn <willemb@google.com>, 
	Eric Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 4:42=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Wed, 17 Sep 2025 18:05:45 +0200
> Mateusz Guzik <mjguzik@gmail.com> wrote:
> > I can agree the current state concerning ep_events_available() is
> > avoidably error prone and something(tm) should be done. fwiw the
> > refcount thing is almost free on amd64, I have no idea how this pans
> > out on arm64.
>
> Atomic operations are anything but free....
> They are likely to be a similar cost to an uncontested spinlock entry.
>

In this context it was supposed to be s/refcount/seqcount/ and on
amd64 that's loading the same var twice + a branch for the read thing.
Not *free* but not in the same galaxy comped to acquiring a spinlock
(even assuming it is uncontested).

