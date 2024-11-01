Return-Path: <stable+bounces-89539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA239B9AE9
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 23:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C644D1C21460
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 22:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA181E571D;
	Fri,  1 Nov 2024 22:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8pEqHLp"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCF91607B4
	for <stable@vger.kernel.org>; Fri,  1 Nov 2024 22:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730501101; cv=none; b=LBvKiE9o+5v2aqCR7vGyzxk0Y7ORmct7MI24bXXIvjQINCkn6dVcb+lUo03Pq2rENHmBaBFjdBkkF5nVTOxH3zmvD1OJQed1+ybFvS03ruKm7EeqM2OII+pGksr7Pi1OYMHjYpBccCVFPUbcAgqUCtj9utq/kJMdDqxgKkEdINs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730501101; c=relaxed/simple;
	bh=tww+CAXs91Qqeg7ehztuvXzkX5L0+hkqCCOc7+Yt2+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VN1UT1dJ12Ou9ZN+HboLv1Ft18CMsGVfXK1iN3icbJrfjR31YyavKiCJlRjvEmDirqgxdqFkL1FNtyiIUqGkx+Jo5vO4kkEOP4PrviayFcj0MkqI6j158rRvDGRJY24KCtW3G1TG31/TWDJ7/b56UfY+QcLnGtoyGLovpfm9ruA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I8pEqHLp; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a4e54d3cefso74145ab.0
        for <stable@vger.kernel.org>; Fri, 01 Nov 2024 15:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730501099; x=1731105899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+OHF9/d5wpYVW+gB/DYvvDEg0LTL3nHbhh0uESfPxk=;
        b=I8pEqHLpdeXkldb51K8P5+zE77enEsOGn8Jfs+ulFCY/xMatB8pwLpSRZvcNkeIVaz
         zElNXwyKXSEwC+/6FvbNEOh57SMxqFbIp8TJroucSAf1GWQtinbq0ioi+Luo167mBN5A
         oLDF9/fjvKr9MQ4uXCffkRDxdZAnJDe9Exg9GGdUnS0db3eN2EKEH6e3pb/HNG5OWtRO
         z+6Rg7SxDxWG224Y88aqdj80tXkP9ciQs5X8jagRUmshnK2nQqJxhBH2hKvj+qYZ12wW
         jxu23jampo2uSH5GNbNVoP01PziLEteQCPgpFk8PZ3qWG6SNUCBkQ/dQzNdUBlvJO/u2
         CsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730501099; x=1731105899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+OHF9/d5wpYVW+gB/DYvvDEg0LTL3nHbhh0uESfPxk=;
        b=VYuvd8GYVE+RpGGxqGuVn9gyHjAA/R4c87tTFvA4CDsqq0HFQVr8yMvYpk5RBJh5hR
         ajV1kp5fZE82zpRf3B+jSeIPydjdgS7gLAOsby6JMA/KdOQJ3hA9I1ow6nX9MEkymxjV
         ns8Ah/uetPP99xzPDUMpsc/dRguiFRR1tg7yoedOPOLCDbPMXt7zz2yaC4N+zbMfSeKO
         fl3UFwh85D2prLkbQ3xDryQgkiCe1bJ80x9rGfbw/Z1tV3IVzQmxvcqHpP3PgbRCZ0A8
         45s4ArlT/w7f4rk18/KXXXtv8JHRvOWLGoX9J9kfUdd7azbQgiyh03vbfnhxc8z6j3f7
         Ibcg==
X-Forwarded-Encrypted: i=1; AJvYcCXI5a3LUnXTFC6bCcwJ3nHG3S2Em7B6+AbH7EZfpl2SETkQg3rf9NSLcaPJbyygFvZtMo49dYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVnk8AS/ITUvi479oTd4opYIft3y+eMBhB4ejtn/ZmElw4YHIZ
	jce/3icBCzBD5EK2TpvIoLsXZ4LVuhSwjy3QUyoIXGe11gcsf4xgNk9QgvQVVLrQOyIN4a1TcHD
	OEK9AEUzdybOcGeEqXqKfiUYPy9/f9chlenR+
X-Gm-Gg: ASbGncsAAg6tK7oiBHUi79UT+pzmXvFh9Atmmg18hskNKmIfMo3aGv+H2xiEH9zaJOC
	AG/o0fjdQkMd1TtnvodZuqo2IGShPCFk=
X-Google-Smtp-Source: AGHT+IGFvTS1CkkUfsRADjGNO9iJPaDQG9w00HkbIAdlhQX201Kv8MVYYPnstfeXKyBBXvjF8WTGZbfmmTcDh2jZZ7k=
X-Received: by 2002:a05:6e02:144f:b0:3a0:aa6c:8a50 with SMTP id
 e9e14a558f8ab-3a6bf22456emr317655ab.29.1730501099375; Fri, 01 Nov 2024
 15:44:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031200438.2951287-1-roman.gushchin@linux.dev>
 <87zfmi3f8b.fsf@email.froward.int.ebiederm.org> <ZyU8UNKLNfAi-U8F@google.com> <87o72y3c4g.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87o72y3c4g.fsf@email.froward.int.ebiederm.org>
From: Andrei Vagin <avagin@google.com>
Date: Fri, 1 Nov 2024 15:44:48 -0700
Message-ID: <CAEWA0a4Kz9exk04Wgx9UZ9YFfURnS-=50TWyhPHm3i-N-D_8DA@mail.gmail.com>
Subject: Re: [PATCH] signal: restore the override_rlimit logic
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Alexey Gladkov <legion@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 1:58=E2=80=AFPM Eric W. Biederman <ebiederm@xmission=
.com> wrote:

> > Well, personally I'd not use this limit too, but I don't think
> > "it's broken, userspace shouldn't use it" argument is valid.
>
> I said if you don't want the limit don't use it.
>
> A version of "Doctor it hurts when I do this". To which the doctor
> replies "Don't do that then".

Unfortunately, it isn't an option here. This is a non-root user that
creates a new user-namespace. It can't change RLIMIT_SIGPENDING
beyond the current limit.

We have to distinguish between two types of signals:

* Kernel signals: These are essential for proper application behavior.
If a user process triggers a memory fault, it gets SIGSEGV and it can=E2=80=
=99t
ignore it. The number of such signals is limited by one per user thread.

* User signals: These are sent by users and can be blocked by the
receiving process, potentially leading to a large queue of pending
signals. This is where the RLIMIT_SIGPENDING limit plays its role in
preventing excessive resource consumption.

New user namespaces inherit the current sigpending rlimit, so it is
expected that  the behavior of the user-namespace limit is aligned with
the overall RLIMIT_SIGPENDING mechanism.

>
> I was also asking that you test with the limit disabled (at user
> namespace creation time) so that you can verify that is problem.
>
> >> The maximum for rlimit(RLIM_SIGPENDING) is the rlimit(RLIM_SIGPENDING)
> >> value when the user namespace is created.
> >>
> >> Given that it took 3 and half years to report this.  I am going to
> >> say this really looks like a userspace bug.

This issue was introduced in  v5.15. The latest rhel release, 9.4, is
based on v5.14...
3.5 years is not a long time...

Thanks,
Andrei

