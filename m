Return-Path: <stable+bounces-166744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4968B1CF01
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 00:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2273A912E
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 22:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31723233D85;
	Wed,  6 Aug 2025 22:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m13tuVNp"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D93A22AE7A
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754518327; cv=none; b=H1S9erpGoWMTyCCbyItgl7GMc5R+K8AwP8ZmZhJtC+y4ZsCTsYjg2HEXSIOyA5s9EXwq5jcrPxQ+A8JDdW/Tv5fIgJX+5HFbSNxbEXK0dCHEKmB9aB5b7eqk8ydoi8/WwTfWKMG+PN8EMD/3M2YSio9QijJz4w5AjzXF2aoAMJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754518327; c=relaxed/simple;
	bh=+Ox9zRYolOnHtwT3PUcx67G94JDxZP2kTORZOpqtIMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dy45myJ1XsYQQGozMiJPas4OtsY/Vd7VwxLZFTqvVWNKB38+ZQPsWoYYbjYS9jSvZeQY8R8C0tVYJhlIkasDLA08JvZXlOISE1YUnP8UthBhIITxGp1u0TSWT6o1vH88PEZ1ifEPr/ladJ9MooYPKO/8sOTDwwXIvpoX523jD0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m13tuVNp; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b07a5e9f9fso137561cf.0
        for <stable@vger.kernel.org>; Wed, 06 Aug 2025 15:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754518324; x=1755123124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FiWvRl7qqXkQNDBUdlT6ON4d+ifpSBHPrNy6qGGUHk=;
        b=m13tuVNp4wL1iulVqvCbGipbqXBm1HmZaOy1EHfHjwqeZi9iB1ZHen8t0QolNfnkOT
         6OdckBM4mOrUl74rxJaf6FdypPqz/fGc7Cc+4B4aAtF77sDoYTwDEdd1IvqW+UBNn9uX
         nXKPN4n47WHj5ixzbdtUzeUCADkilBzZLDvGocZ76KWZcEJZIUMgebPMdKfy0lVWcrD8
         YJvrdRVk6z3rCZ23x6EyaooEErvXPe8hhXmmZIl6rH+E4wJN0JuDfeZqg3t5GrpxvqYm
         +pxiqb5pXYtUEy3DDhWAP49rO4ra1D0d9hY+dP2NLrZMULloSleudOVGLTMiaQVjWBWq
         50xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754518324; x=1755123124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FiWvRl7qqXkQNDBUdlT6ON4d+ifpSBHPrNy6qGGUHk=;
        b=VI4EVODQpXYWM5JeCIfSrMGsO0Fodk9yTK3wZzKT1lga/fuQ9gSz+QExBkK6UYrebr
         XMuuRhGJSVZ9SkuZZSE89ILmXxWXghcUuDE6mqawoYcUTNfzkmUrTB5ehGVfJbvqJHF6
         BfcSqceK8PIuCTp09hzt4RSWiJdMZ7QvWI2zKdpq3vBsQnPLNLVDDJ3K2q7Wre6f19VG
         BV8y1+D5oR5Yv0MyZU9xLJsd4jvOSvTmWFQnnpNz9wnd5mYRLr04dVzcGrEJ+fE/pkwN
         i8rXRrRBP9gRwITMa6zYCouWRj2yILBd+lE7AbUQ7GCpqut+p3JkUpjQfJKaUlO/E6vN
         yLGg==
X-Forwarded-Encrypted: i=1; AJvYcCW6EejW8ucL3UXP394MKuqmDAHJy9BdyQCO9Jv01luPOUiELFrYGx29qQCNiRs8SZNnYg1NNUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh8Oi07rfVoQgezLSHR0jltKM9DoRBM+Lb00ryRSbvSVybxEk7
	Rum6S36nJ0DgAyqe9UUsnDgMfQI+Rm+wRdDc3pTulmtamWVoDTtwaKjWhcZeGeCvUG048NHOMlz
	6wFuM7ML5oiOkX8e18gwwfZpQgcitsYtwg7EwCURL
X-Gm-Gg: ASbGncstgWbslT8W2gfJ1Y2E4VsKTROo85Egu6q1G9odiCvr3G2yxiAyOWw7dcpOSaD
	9wGxTWw9CloUIoP8ZKJNdUHH0mK0x0Yzl0z2TT8NBWFWQDy4oemksuNXKxpljBQ43jLu1qpenQ2
	WryVgsaYCk/G1jvZ5IRZ9pv+Kvsb6a54bt7OjJXxaCVq/T6tPqDXNYkXVvdSUoS2/QAZXlXFdN3
	3L6wQ6IeXmt0q5c
X-Google-Smtp-Source: AGHT+IE58c8RrLqWVAWSA89xnMLA58Wcvs22tjEvVXSzyBbScgVGdTpLFJhTGLaInSIHVWyChoGSfE8AA7WkFHFQ4CE=
X-Received: by 2002:ac8:5a42:0:b0:4a6:f525:e35a with SMTP id
 d75a77b69052e-4b0a372b51dmr520041cf.9.1754518323701; Wed, 06 Aug 2025
 15:12:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806154015.769024-1-surenb@google.com> <aJOJI-YZ0TTxEzV9@x1.local>
 <CAJuCfpGGGJfnvzzdhOEwsXRWPm1nJoPcm2FcrYnkcJtc9W96gA@mail.gmail.com>
 <aJOaXPhFry_LTlfI@x1.local> <CAJuCfpF0RJ9w0STKFaFA7vLEA5_kEsebuowYWSVnK-=5J2wsPQ@mail.gmail.com>
In-Reply-To: <CAJuCfpF0RJ9w0STKFaFA7vLEA5_kEsebuowYWSVnK-=5J2wsPQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 6 Aug 2025 15:11:52 -0700
X-Gm-Features: Ac12FXwLQmNTg-sw4wFVsfQATsP_wqhDZus6Cjpz3UpRH3cR-tLTiKJsZP0WDZ0
Message-ID: <CAJuCfpFhcfK4E_Q8QMqG51GOMrJPehddeU4pt3uo1qNfVU5__w@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] userfaultfd: fix a crash in UFFDIO_MOVE with some
 non-present PMDs
To: Peter Xu <peterx@redhat.com>
Cc: akpm@linux-foundation.org, david@redhat.com, aarcange@redhat.com, 
	lokeshgidra@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 11:21=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Aug 6, 2025 at 11:09=E2=80=AFAM Peter Xu <peterx@redhat.com> wrot=
e:
> >
> > On Wed, Aug 06, 2025 at 10:09:30AM -0700, Suren Baghdasaryan wrote:
> > > On Wed, Aug 6, 2025 at 9:56=E2=80=AFAM Peter Xu <peterx@redhat.com> w=
rote:
> > > >
> > > > On Wed, Aug 06, 2025 at 08:40:15AM -0700, Suren Baghdasaryan wrote:
> > > > > When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES an=
d it
> > > >
> > > > The migration entry can appear with/without ALLOW_SRC_HOLES, right?=
  Maybe
> > > > drop this line?
> > >
> > > Yes, you are right. I'll update.
> > >
> > > >
> > > > If we need another repost, the subject can further be tailored to m=
ention
> > > > migration entry too rather than non-present.  IMHO that's clearer o=
n
> > > > explaining the issue this patch is fixing (e.g. a valid transhuge T=
HP can
> > > > also have present bit cleared).
> > > >
> > > > > encounters a non-present PMD (migration entry), it proceeds with =
folio
> > > > > access even though the folio is not present. Add the missing chec=
k and
> > > >
> > > > IMHO "... even though folio is not present" is pretty vague.  Maybe
> > > > "... even though it's a swap entry"?  Fundamentally it's because of=
 the
> > > > different layouts of normal THP v.s. a swap entry, hence pmd_folio(=
) should
> > > > not be used on top of swap entries.
> > >
> > > Well, technically a migration entry is a non_swap_entry(), so calling
> > > migration entries "swap entries" is confusing to me. Any better
> > > wording we can use or do you think that's ok?
> >
> > The more general definition of "swap entry" should follow what swp_entr=
y_t
> > is defined, where, for example, is_migration_entry() itself takes
> > swp_entry_t as input.  So it should be fine, but I agree it's indeed
> > confusing.
> >
> > If we want to make it clearer, IMHO we could rename non_swap_entry()
> > instead to is_swapfile_entry() / is_real_swap_entry() / ... but that ca=
n be
> > discussed separately.  Here, if we want to make it super accurate, we c=
ould
> > also use "swp_entry_t" instead of "swap entry", that'll be 100% accurat=
e.
>
> Ok, that I think is our best option. I'll post an update shortly.

Posted at https://lore.kernel.org/all/20250806220022.926763-1-surenb@google=
.com/
Thanks!


> Thanks!
>
> >
> > Thanks,
> >
> > --
> > Peter Xu
> >

