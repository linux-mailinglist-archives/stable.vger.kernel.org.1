Return-Path: <stable+bounces-77073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7F79851C3
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 06:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8D0AB21EC9
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 04:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9409314B08E;
	Wed, 25 Sep 2024 04:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nA88GzKs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EFE13AA53
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 04:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727237063; cv=none; b=Iw/rn+8zn9XSOCVWQTGZb/hIAl6baOnKnyQRJNZqL7BC+5FQOcsWw1eAWAh+bZUXUalaO9qtDKYkA/kCZtN+LS0gxFd3nKMqFCIZeUxljU1m56J0kla87fLFiO8vDutOEQZK9oPRGyl1T6jBfWeQgOiRweUzegK93eGkCStAWiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727237063; c=relaxed/simple;
	bh=p6aXdQCsCQDb+qv4Oe0hGSlkljpbIyMoGX6UwtO7y4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PGQYv1X05FcbF1n1Zku3qoG2TL4rOSLbRMNpVbgSq4t1dwilkFidy9/715/pQuHp+JZ0n26jD9cOXJU3KbDC37gC/f5/52H2H10ldNkJKHCNnqSHDPuH/w141F1er0m5T4rjUoAEwxo6ZS6KYuU1C3dQ718wODK5GI9SbiDlQVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nA88GzKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C754C4CECD
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 04:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727237063;
	bh=p6aXdQCsCQDb+qv4Oe0hGSlkljpbIyMoGX6UwtO7y4I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nA88GzKs5XmLWrndPrDBLIlm2YKSyzxjfTMeUcwyCTPPvNIylFyR9KPMoFnsRigln
	 N5p5eiokmbwRNFB8e1m7FQtXltuKRfr6os8y9ARhe/aWfV6h/haikvrl4Vnew+Ouoa
	 LYkNp9zgCqUA1VhD86WOVRzQRxKTrhSFhCkV6HIezFfP8yxytc51u8eyJWw4/FVgOQ
	 FAcE5YV6H8NBTr+d4cd7x4TMq1Ptr874yhL8hO36EixErjyAzRw+6C+IlpFukgHbx5
	 t1fHJ134zbPhaxJNFyuegXX2IdAnkA0bWqp+3dBgXajEbIxKGZEb4XX+N2N9pDrXJ1
	 juJlN63g8Fiqg==
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a1a4f2cc29so83785ab.1
        for <stable@vger.kernel.org>; Tue, 24 Sep 2024 21:04:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW14Vd7q03IhJcSo48Vv6WkbpkQFww544C4kvjb6z7UdShJu2M369bcT/6h8lx4TmNtnQgsWwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVdTD6M5gFv6DfH0qyFWZic98vDcssxux2Ho6aPiw1/PrKNmxr
	k8Yx/Imd8O4nxUsG4y1INY5t7fABamD+QodaxFoYaZybw84jHlxnkHHzaxM9axFo3dAgKSymERW
	/lCs6H2gFCih0MyrwofdkRWuAqzCnKufvyylD
X-Google-Smtp-Source: AGHT+IELrtiyu4mKIo4xDH5TOC5IAATMzMKE7/IoB9tmPJ03N/88XGcxL4jb93lXI1QLJzXHw4dM7zmW4R0m7d9um7c=
X-Received: by 2002:a05:6e02:1fec:b0:376:3026:9dfc with SMTP id
 e9e14a558f8ab-3a2703e74f4mr1275375ab.24.1727237062258; Tue, 24 Sep 2024
 21:04:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923164843.1117010-1-andrej.skvortzov@gmail.com>
 <20240924014241.GH38742@google.com> <d22cff1a-701d-4078-867d-d82caa943bab@linux.vnet.ibm.com>
 <CAF8kJuPEg1yKNmVvPbEYGME8HRoTXdHTANm+OKOZwX9B6uEtmw@mail.gmail.com>
 <CAF8kJuOs-3WZPQo0Ktyp=7DytWrL9+UrTNUGz+9n9s6urR-rtA@mail.gmail.com> <20240925003718.GA11458@google.com>
In-Reply-To: <20240925003718.GA11458@google.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 24 Sep 2024 21:04:10 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNDzk21jZR1+TkGdMOrXdQcfa+=bxLF6FhyuXzRwT4Y9Q@mail.gmail.com>
Message-ID: <CAF8kJuNDzk21jZR1+TkGdMOrXdQcfa+=bxLF6FhyuXzRwT4Y9Q@mail.gmail.com>
Subject: Re: [PATCH v3] zram: don't free statically defined names
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrey Skvortsov <andrej.skvortzov@gmail.com>, Minchan Kim <minchan@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	stable@vger.kernel.org, Sachin Sant <sachinp@linux.ibm.com>, 
	linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 5:37=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/09/24 11:29), Chris Li wrote:
> > On Tue, Sep 24, 2024 at 8:56=E2=80=AFAM Chris Li <chrisl@kernel.org> wr=
ote:
> [..]
> > Given the merge window is closing. I suggest just reverting this
> > change. As it is the fix also causing regression in the swap stress
> > test for me. It is possible that is my test setup issue, but reverting
> > sounds the safe bet.
>
> The patch in question is just a kfree() call that is only executed
> during zram reset and that fixes tiny memory leaks when zram is
> configured with alternative (re-compression) streams.  I cannot
> imagine how that can have any impact on runtime, that makes no
> sense to me, I'm not sure that revert is justified here.
>
After some discussion with Sergey, we have more progress on
understanding the swap stress test regression.
One of the triggering conditions is I don't have zram lz4 config
enabled, (the config option name has changed) and the test script
tries to set lz4 on zram and fails. It will fall back to the lzo.
Anyway, if I have zram lz4 configured, my stress test can pass with
the fix. Still I don't understand why disabling lz4 config can trigger
it. Need to dig more.

Agree that we don't need to revert this.

Chris

