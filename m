Return-Path: <stable+bounces-84916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A499199D2D8
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67EB7287148
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3681CB531;
	Mon, 14 Oct 2024 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J0wSZSHz"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BD51AE00C
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919664; cv=none; b=SBUTU+cflRXJHgz9BuB4FMhzkHkGpF7gj7fFJWJB3Fo1R2J6v+kA/GCWWxPd8oNHxRWqTiGctA1dSKugbs8OnhgqEWAWXOLz4l/4d52igikXqQF1YzoqsAtDR/dSJ8YpRyTYew5MLRUyTt3Z79US3WePx+9ypqonGOEF5PMXBsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919664; c=relaxed/simple;
	bh=b6yahaVdr8hTpYrymapwr8Gi+VRT/0jILQ68OOYwggY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFVqvyzV4jQC2l5euEb1aKmZqPhM/FXX8krZDi7l7I8B/TS0cQCiPBqh8QJC6MDbhpNVcA58dbPr94eByUtVPEaV9jf4cORv7dJl2ZMrMW9EcvCvfWtOs5+yWB38y+hp7Xq28PCQ62/VcbwaXLFPaUg0MAjbqxJkkgmx0nwu+JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J0wSZSHz; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-716a5b30089so264268a34.3
        for <stable@vger.kernel.org>; Mon, 14 Oct 2024 08:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728919661; x=1729524461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9yIRP/KsLjcxcxII5/lXPcFtxtuaU6xnyFBDOKX70k=;
        b=J0wSZSHz7jfKiplh5hlAMnwHZL6GVkmQ8aiu9dFw0U9pD7W+XLAQHziBcXfwsbUqEC
         SpS4BdH2SsGQhZqG7u6ilWq5h1ejCeIUSP9ufg/ywf9+aJTAiAi6prF83OW45YYahMcg
         +5/g7ly9pStnPj403BWMsDGzVtim8teltumtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728919661; x=1729524461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9yIRP/KsLjcxcxII5/lXPcFtxtuaU6xnyFBDOKX70k=;
        b=JD0UB156eR9E8heI5ZY2iMIVKGKBvvnBtZdfwnwjlkJ7dpNBfG/Y7r9kGeHBETPN8k
         d2/tk+JS2+DUmsZksEIbkU4pAMJDIn0j/1AM4g7Nv9uRnLxgeAJyY2gr4wYYTbAJLfgE
         5mVKUYbTQ/E96dc5tUZE5YjRol2NYgHheEai1L+YP8AGkUpv8gHOIcEF+oLD0c12Ewsh
         +DT66vBhy830oqYdRBKW12Qw6fm1Bkhy2oumUhDo3ja8rLGRxVcCFqsOnI2M3oa8wgwp
         e7/NQPTR4wjEUUaHOwcXGjA/UCdy835aocKcCIWZVXefu8vI9lx9lc6uU9kZNw8xDPUB
         /hyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtABBgN2PszBE7bTkjPrYs5hldWNPZAo7H0o29fjadTJse7T61K6kNMnYvGlO2P62IuuMBc+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0bbRqWzpBpuydK7oqb7ChfthiOM8MnsMCtC/7zp+K0NyoiBMV
	KJv4rXDqofsIjFZjQk6jY8TrbSKd8nJy0MIurJOW1N6lkZUJvwBkCfaoYj61z+TTAQL/iaJnIv7
	tZDlPePHtUIZ06LlsbhO+JDna5GLjSpHFT4NGa9i6+o9U/a8=
X-Google-Smtp-Source: AGHT+IEziAPSxkdF8eMOp1RXN7d7s544AwYMwxr/wUwFC7ODFvd8sIDGR1p6z81kLbwviBR4qLmSxoKaxW0zWGIF+0c=
X-Received: by 2002:a05:6870:e416:b0:27b:73dd:2a85 with SMTP id
 586e51a60fabf-2886dd50b7amr2143445fac.1.1728919661579; Mon, 14 Oct 2024
 08:27:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABi2SkW0Q8zAkmVg8qz9WV+Fkjft4stO67ajx0Gos82Sc4vjhg@mail.gmail.com>
 <2024101439-scotch-ceremony-c2a8@gregkh>
In-Reply-To: <2024101439-scotch-ceremony-c2a8@gregkh>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 14 Oct 2024 08:27:29 -0700
Message-ID: <CABi2SkWSLHfcBhsa2OQqtTjUa-gNRYXWthwPeWrrEQ1pUhfnJg@mail.gmail.com>
Subject: Re: backport mseal and mseal_test to 6.10
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Pedro Falcato <pedro.falcato@gmail.com>, 
	stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Oleg Nesterov <oleg@redhat.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 10:54=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Sun, Oct 13, 2024 at 10:17:48PM -0700, Jeff Xu wrote:
> > Hi Greg,
> >
> > How are you?
> >
> > What is the process to backport Pedro's recent mseal fixes to 6.10 ?
>
> Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.ht=
ml
> for how all of this works :)
>
> > Specifically those 5 commits:
> >
> > 67203f3f2a63d429272f0c80451e5fcc469fdb46
> >     selftests/mm: add mseal test for no-discard madvise
> >
> > 4d1b3416659be70a2251b494e85e25978de06519
> >     mm: move can_modify_vma to mm/vma.h
> >
> >  4a2dd02b09160ee43f96c759fafa7b56dfc33816
> >   mm/mprotect: replace can_modify_mm with can_modify_vma
> >
> > 23c57d1fa2b9530e38f7964b4e457fed5a7a0ae8
> >       mseal: replace can_modify_mm_madv with a vma variant
> >
> > f28bdd1b17ec187eaa34845814afaaff99832762
> >    selftests/mm: add more mseal traversal tests
> >
> > There will be merge conflicts, I  can backport them to 5.10 and test
> > to help the backporting process.
>
> 5.10 or 6.10?
>
6.10.

> And why 6.10?  If you look at the front page of kernel.org you will see
> that 6.10 is now end-of-life, so why does that kernel matter to you
> anymore?
>
OK, I didn't know that. Less work is nice :-)

Thanks!
-Jeff

> > Those 5 fixes are needed for two reasons: maintain the consistency of
> > mseal's semantics across releases, and for ease of backporting future
> > fixes.
>
> Backporting more to 6.10?  Again, it's end-of-life, who would be
> backporting anything else?
>
> confused,
>
> greg k-h

