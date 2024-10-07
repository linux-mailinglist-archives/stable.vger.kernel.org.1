Return-Path: <stable+bounces-81221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C29C19927AB
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 10:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E4C2812AA
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 08:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4332C18B462;
	Mon,  7 Oct 2024 08:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cW9dHO6j"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D7818BBA6;
	Mon,  7 Oct 2024 08:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728291451; cv=none; b=m5dNPoKRAY0iqzvRH1IYEvQ4f4de7eCQuoMD9bvEL4EGPxNlyIfsEQ2BEDAVzMPQSTJwAOE9+INwGvq5m8nEFvzRPmf0NzVW+w0AnFaGw/o0x92sHhBBbQgMWKrjd0okMMZl8gfWp946s04hL9Dbn4OQ49Dg/Z0TcyzqhWyUzVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728291451; c=relaxed/simple;
	bh=kpGCHjdO/uo/RWuVF3NujSAO+/m1dj9JeJMwnwS0k20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7PqvPFsgCJnKQTC9ZdJNJo8/oCqD+r9DxJ9v6wm60hlonsjYNsFYS3ytgclYl5kDYA0Dh/O+GKFf8Rrv0Kk5VUQKv79zyxixhFxwroMoxkcacmmI87ONTaJ2edCQTnOjDVlhVlIos+GstN3Q0kHx6QnR3De+GgwSAqTLT+4c4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cW9dHO6j; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e137183587so3463287a91.3;
        Mon, 07 Oct 2024 01:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728291449; x=1728896249; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BItnmLiFpdp+oHJs3c/Wx0gYeM6qW5xxVzKlwJ1FPGY=;
        b=cW9dHO6jUTTrXjpl82Y0ca8dnuo5zOYM/qHQ3vOAEukmTB5RLShonQrbF6De76JNQY
         AnsQPayRzceYepQsWT1SvnVB9VDeQ6Ebwin6J8xPYSMQtOT3bU2kHWqptGEwTlpjpaoQ
         DmXLz9qJMzgBPQNns4lRqx6Jsj2EpC3S87JyitZ92Xy/sHngvxsSaVD24u4QTp7eVHCS
         TKyYCZ402Xy+G1kIvbq0MhnCXP8AkyhYd3UxoU0Gy48jr5htJV1WBdyUfHb1tUFd9ZNQ
         uCfLYWM6AHRTuAEcrsehpzSWmlkWF2UwCbk7onVBAUVQwwxxOXe5CpNluKQbnVNoP1U6
         A1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728291449; x=1728896249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BItnmLiFpdp+oHJs3c/Wx0gYeM6qW5xxVzKlwJ1FPGY=;
        b=Wmy/vqcziIxP+7BArlSXfK1VHqfuCnR2uStSigIrn5E08g11YaJSIOWFfh1to5b7OG
         HF/yjAO3uhbn7WaAUsaRubxCGE/0gDd7Xra41oWISNdwoXKNACJ0EYB3SxUVWHlhoi2r
         IJSj0UbTZw8TFKdDaMW4+4pYmWGk/d4598Pl23z7LCdU59TaC3bbF6035o3oBZ9wnRBe
         43x0b18/HSnH/Hp0l9CVWaTvNkOwOGzJ3/YMBNzhb4PqUOgqh6WYi0wrGOlqzyNxD0b2
         BQFIFSJxdoj+wvw1jZ4E7zf1kjXY3yjYfExG+ohKkdSsDAc8Qfgjx/AC+UgmsabRh48h
         gIGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbN3/P5UMyw5F0HKM1NHqq8KJz3Kjt5GZesW9fuw1yb/xATAb00KXxPH9AJxARCQzRPb0bI0nj@vger.kernel.org, AJvYcCWe8w1Tu1XGxm3KZJ75AHdGRLuyhekU6tz92JrSg6WHbukPXbCYz7X1qFo5eKxd0T3yr42LRilXJNbvV+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlJAmU7WFa4hU/K1yhN9zGq/G7XsOA7TLZW5yudgQBkatgAq0W
	hmetEzqluskA0NpJqR2cNqn0nlDiyhZPNbc8FFn1jZDhbci7qJW9ZVwndsH238hHS0lTaQ/sTdC
	6+UtOu0CvUU0cmbCHIMC921dxUdw=
X-Google-Smtp-Source: AGHT+IEXWmQV0bh6jO3MKbhqkKxGQEjbmFmz4MGs5ETbgrmLuMpRzBG54K0IsT96JLIWKcCQ8RsDwafu2u4Z7SklZGk=
X-Received: by 2002:a17:90a:b015:b0:2e1:ce67:5d2e with SMTP id
 98e67ed59e1d1-2e1e6213b03mr16405915a91.5.1728291448818; Mon, 07 Oct 2024
 01:57:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007065307.4158-1-aha310510@gmail.com> <2024100748-exhume-overgrown-bf0d@gregkh>
In-Reply-To: <2024100748-exhume-overgrown-bf0d@gregkh>
From: Jeongjun Park <aha310510@gmail.com>
Date: Mon, 7 Oct 2024 17:57:18 +0900
Message-ID: <CAO9qdTFwaK36EKV1c8gLCgBG+BR5JmC6=PGk2a6YdHVrH9NukQ@mail.gmail.com>
Subject: Re: [PATCH] mm: remove the newlines, which are added for unknown
 reasons and interfere with bug analysis
To: Greg KH <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, usama.anjum@collabora.com, peterx@redhat.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Oct 07, 2024 at 03:53:07PM +0900, Jeongjun Park wrote:
> > Looking at the source code links for mm/memory.c in the sample reports
> > in the syzbot report links [1].
> >
> > it looks like the line numbers are designated as lines that have been
> > increased by 1. This may seem like a problem with syzkaller or the
> > addr2line program that assigns the line numbers, but there is no problem
> > with either of them.
> >
> > In the previous commit d61ea1cb0095 ("userfaultfd: UFFD_FEATURE_WP_ASYNC"),
> > when modifying mm/memory.c, an unknown line break is added to the very first
> > line of the file. However, the git.kernel.org site displays the source code
> > with the added line break removed, so even though addr2line has assigned
> > the correct line number, it looks like the line number has increased by 1.
> >
> > This may seem like a trivial thing, but I think it would be appropriate
> > to remove all the newline characters added to the upstream and stable
> > versions, as they are not only incorrect in terms of code style but also
> > hinder bug analysis.
> >
> > [1]
> >
> > https://syzkaller.appspot.com/bug?extid=4145b11cdf925264bff4
> > https://syzkaller.appspot.com/bug?extid=fa43f1b63e3aa6f66329
> > https://syzkaller.appspot.com/bug?extid=890a1df7294175947697
> >
> > Fixes: d61ea1cb0095 ("userfaultfd: UFFD_FEATURE_WP_ASYNC")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > ---
> >  mm/memory.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 2366578015ad..7dffe8749014 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1,4 +1,3 @@
> > -
>
> This sounds like you have broken tools that can not handle an empty line
> in a file.
>
> Why not fix those?

As I mentioned above, there is no problem with addr2line's ability to parse
the code line that called the function in the calltrace of the crash report.

However, when the source code of mm/memory.c is printed on the screen on the
git.kernel.org site, the line break character that exists in the first line
of the file is deleted and printed, so as a result, all code lines in the
mm/memory.c file are located at line numbers that are -1 less than the
actual line.

You can understand it easily if you compare the source code of mm/memory.c
on github and git.kernel.org.

https://github.com/torvalds/linux/blob/master/mm/memory.c
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/memory.c

Since I cannot modify the source code printing function of the git.kernel.org
site, the best solution I can suggest is to remove the unnecessary line break
character that exists in all versions.

>
> Also, your changelog text has trailing whitespace, ironic for a patch
> that does a whitespace cleanup :)
>

Oops, I forgot to remove the trailing space in the patch description.
If you absolutely must remove the space, I'll write a v2 patch and
send it to you.

Regards,
Jeongjun Park

> thanks,
>
> greg k-h

