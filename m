Return-Path: <stable+bounces-60801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4ED93A475
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 18:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78F43B2206D
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 16:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF61157E9B;
	Tue, 23 Jul 2024 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zyXkJ5TT"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23283156F4B
	for <stable@vger.kernel.org>; Tue, 23 Jul 2024 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721752439; cv=none; b=o8Tn2A7IFe2UK/0cBu/ay6rYqKWVG+YPCeEvbNNAq9kJ3+4+S2KuYxQda1t6F167wqUJAZ6Jn5ozRg/JN76dWMCoCN9wIqXu5jMtFrrHfRMl8KT04wSqWlkhXtYeHIFwI/zprKXyHhSRSa/I48Yf614iQiWd9ZWjNlZRkk67EcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721752439; c=relaxed/simple;
	bh=Ac+1VCyIhu31OwQRN6Dne5zrLfVI8B/dVNnBpI0/dsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKz9ArW+NNWQTC+AJV+4pUPsJlzJvVdo/wJdkgYqpYQWxfeQWoNxcs1+tFtHB3hbkovRloWecgzqQoHkcqMrJDgFnJ125xVChVtbDcsfYJi8uko3xXzlRs5iHI6kwQxmwRDjXNp/nYskNl1sS/+pcRhJbbZjKVuYY49act+YM6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zyXkJ5TT; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so18482a12.1
        for <stable@vger.kernel.org>; Tue, 23 Jul 2024 09:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721752436; x=1722357236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiHSaiFwYnxeXJNiC6ft2n6E6HnZA5O/Rg0VZMt8MPE=;
        b=zyXkJ5TTSZZH2tNdQZ9I/k9S1wiAbhr0NKTbzJCkXo3Iq3NKu0Vvbg4o8KEgeLjnSy
         msqAEuHPRzTVj0rlTr4FP4P8Jbi7CskHIklTGxDzNWPpNs+HzorkJVYW6Uw7xMbBv9BF
         B2ZC3Bs0VQtvEXfrUnwZAllh+RonoksunmK75wAz2wv8xWa4B3WWGocwlybZlV6C1kZ8
         i6FANX2OYe1kAQ/MjTbNlzMSwyRYiiwGekpktFd5SUklZ5j0XhC7aOQg5PLu0CqiN52r
         8cM6o+63i5e+hfywypF/xcHLfFqkmsRPfJ9+qokdHYJEEUi/V2UHAt9tbVSr5woAu97t
         OSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721752436; x=1722357236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiHSaiFwYnxeXJNiC6ft2n6E6HnZA5O/Rg0VZMt8MPE=;
        b=tPVEfTjVx46765T9lgteAEsH6YBrnL8QjYhUtNsfKM4zk1KB29rRVM4g5XfIJm0S17
         LqdFCt2yGYPWzk/tRERcntYqRcovJsjpjEk1JKr7wmm//PqIg706wMKxhl2azxbKv26c
         FNP42GYj97TvqohaFuKgKgQQ83FQJGlrobCApDlDtXIMfxsZJ8ORBo9Vr8IYvdGmbr9m
         VfXApY+4fXaSrX8w5eH3iyjmVCmpXpPlMuZwGRAmIQ41HS3uaJ8qZ/ieAhL0VsFUNuEU
         3nnLRpXfZ0aRJrr3x6S/cWdm1mCrO7r3PqgfIgVV6dqtUYSPfKhB2OIFnA8F6uXphkIJ
         6d3w==
X-Forwarded-Encrypted: i=1; AJvYcCWKDfGkfZ//cOzRCoVBgytbCmngmxlyioQCBxY6cpnekFD6r3LOus6TVw9aGsSVR2OsX5Jh2xqQHW8671bqSZ5NagYpXhJv
X-Gm-Message-State: AOJu0YzdRBIu4iG217/kExDQxiFY1SFgIiN/5aHudDf1ZS6ZqJ8OveZA
	pzsoIxbgNdAmZTNiJhWL/FUgvQ1dtUVWS1KuqZ26rHtmgVxqjcmP79qx0hFCBQhpWk0g69IwAaF
	8450xNapEhfWL8mjZ2OEnPYxK5JO590asruMT
X-Google-Smtp-Source: AGHT+IFkcnxlwSrfASAm2b5oqxdiNNK+NxUsk7wv3nDfPHaSyqG2E4MLZ+C7g0N20H/g2abqr2ueJJZjIFXzbC4wLao=
X-Received: by 2002:a05:6402:2747:b0:59e:9fb1:a0dc with SMTP id
 4fb4d7f45d1cf-5a456a628aemr729704a12.6.1721752435997; Tue, 23 Jul 2024
 09:33:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720173543.897972-1-jglisse@google.com> <0c390494-e6ba-4cde-aace-cd726f2409a1@redhat.com>
In-Reply-To: <0c390494-e6ba-4cde-aace-cd726f2409a1@redhat.com>
From: Jerome Glisse <jglisse@google.com>
Date: Tue, 23 Jul 2024 09:33:44 -0700
Message-ID: <CAPTQFZSgNHEE0Ub17=kfF-W64bbfRc4wYijTkG==+XxfgcocOQ@mail.gmail.com>
Subject: Re: [PATCH] mm: fix maxnode for mbind(), set_mempolicy() and migrate_pages()
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jul 2024 at 06:09, David Hildenbrand <david@redhat.com> wrote:
>
> On 20.07.24 19:35, Jerome Glisse wrote:
> > Because maxnode bug there is no way to bind or migrate_pages to the
> > last node in multi-node NUMA system unless you lie about maxnodes
> > when making the mbind, set_mempolicy or migrate_pages syscall.
> >
> > Manpage for those syscall describe maxnodes as the number of bits in
> > the node bitmap ("bit mask of nodes containing up to maxnode bits").
> > Thus if maxnode is n then we expect to have a n bit(s) bitmap which
> > means that the mask of valid bits is ((1 << n) - 1). The get_nodes()
> > decrement lead to the mask being ((1 << (n - 1)) - 1).
> >
> > The three syscalls use a common helper get_nodes() and first things
> > this helper do is decrement maxnode by 1 which leads to using n-1 bits
> > in the provided mask of nodes (see get_bitmap() an helper function to
> > get_nodes()).
> >
> > The lead to two bugs, either the last node in the bitmap provided will
> > not be use in either of the three syscalls, or the syscalls will error
> > out and return EINVAL if the only bit set in the bitmap was the last
> > bit in the mask of nodes (which is ignored because of the bug and an
> > empty mask of nodes is an invalid argument).
> >
> > I am surprised this bug was never caught ... it has been in the kernel
> > since forever.
>
> Let's look at QEMU: backends/hostmem.c
>
>      /*
>       * We can have up to MAX_NODES nodes, but we need to pass maxnode+1
>       * as argument to mbind() due to an old Linux bug (feature?) which
>       * cuts off the last specified node. This means backend->host_nodes
>       * must have MAX_NODES+1 bits available.
>       */
>
> Which means that it's been known for a long time, and the workaround
> seems to be pretty easy.
>
> So I wonder if we rather want to update the documentation to match realit=
y.

[Sorry resending as text ... gmail insanity]

I think it is kind of weird if we ask to supply maxnodes+1 to work
around the bug. If we apply this patch qemu would continue to work as
is while fixing users that were not aware of that bug. So I would say
applying this patch does more good. Long term qemu can drop its
workaround or keep it for backward compatibility with old kernel.

Thank you,
J=C3=A9r=C3=B4me

