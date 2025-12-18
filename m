Return-Path: <stable+bounces-202966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF1CCCB947
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 12:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CDA33006A50
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 11:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057262853EE;
	Thu, 18 Dec 2025 11:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oFVOvXAM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48526184
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 11:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766056600; cv=none; b=EceMK4BIoWWHwOKJJfUuUd8s9KNA6Svqx65qFA9PGaAv8J2SV1aApPk25FzZKT8ONspKrYz4F3XmdkAq8IoTP9+p20DcScS3rp1JfoaqQGikBJYQx9u0uk5y8mgLINItYnq/deRzcpZOGFQkVgNBrcCxH3FuDZrKwvMJ/ipeI28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766056600; c=relaxed/simple;
	bh=KztlaeGaKnd/OAfSmunex5j7GqNA94eUF0mYNucDr+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajv2QOj1etE0u5QGzbpcLmGWvzTFtQy3gWjas+iZVEiNdrLlzusSzlAZo42PEg6gkt2DYGSAJxmMY85oIHObDkKFWAWQcXqhSVTYKgYd3ihYgDak2jhbE+qSu9sSUoWPhfLoqxHeU+zaC11FgOTIKpCvXxehYOHJUp8yObsC5U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oFVOvXAM; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42e2e77f519so316920f8f.2
        for <stable@vger.kernel.org>; Thu, 18 Dec 2025 03:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766056598; x=1766661398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOXkpA8lYBVLvZTCg8IrEbi29SdqOpQhJylQGG6roho=;
        b=oFVOvXAMF8hxSEcwv80N6KIQ+TW8wwmGs9xaVH9RcJ/ELWfgZy+gAWG3fa06EK7lEQ
         nm7yLHc6479YjcNE4xWojXpkf9lJ498DQBQ3ZC3/m6Nrx+YnR/lcPAjIE1+y/x0/H8tg
         kOtbmHGuDbP2j5X1pvj2/p4o3cj885fLSKgsUYF64M/v64u6AcNJZZStSGrqLvOvk8w3
         C9ftA2fhzLrOv/9I1gJjkh+i6MRwo+GNvETtafOLNLC4HRwDLvjpAhD6UypdV8Ek3L52
         b/62YbTufkYUYHVByHMdrNZR0LSPqN+SkE7oIjpzFHLgF0UU5+ZzIg9dg+9S6ysPtR62
         HaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766056598; x=1766661398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uOXkpA8lYBVLvZTCg8IrEbi29SdqOpQhJylQGG6roho=;
        b=trh1xaxj5xvfhWwq9tmdOeRA5cq9alKDO5S81MAlwIRJ++1zzoeGoSW51cVAmAEcj6
         QZVOPWqqgDpEPLBUcxDa+lQow+h4V6eJbr1CEU341RTtG63BS66kFcDRN8NY6CPRTcVS
         /gz7cdyDi/lQqTWbv3Hhkd4z319evIPihCjM8NTm/CSP8qlZBM8L6PgMSyLFNw5mkWa8
         7DeUL9g9zV4FbPPZwQBnY4RGnPDQk7m+bSxtF/b8zEaxtl0YB6D9RPJAOJiRPs7q0/8f
         Ky9arVj00p2e62JWIptYbVvs8wqQHP4n6eEvaSVxWy0cmRwvfUB3XG4TYsFgnk8/M3zz
         0o/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUO/WaWHleVftKmcJJ2LM6kpSHkwPy9Gy+6OvCv94i7LKwDue6lELr53oyh1cWhz65oaQhQYY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfcrhZOOnUoUkgKXwH81PiY2n4ffUhWGRGyBDpuGpFZqYMamdQ
	gwOQtaZNoCGfY9zBTWesyktHDnADJHbUUpXe6y3YOtp/FriI+T0WQ7bVWu2+hHVVPz13rihlYvc
	i6dSJI5ColIr8tvptWjsFngOWtYJU+mIji45UHzPU
X-Gm-Gg: AY/fxX7Jw2HoAKC0dcHNM0Rg241AEL/6z+iFZkImHG74O7M2ich3M5j2RU4mshoJBoc
	m648VRKbSExECb682c8P671o8QKMEfB+O8Z8re6UfWrk/tU4dlMFISFsuU4DOqVcze8NbqsHIda
	7BNp/+bAcKc5vaBcP0D+av5pHpz1f/avpMZipOfMm80miM2C6FZRsDt/fEqCG43Sbmky9wVhGav
	ifbPe9FqxSpsDVsbtNyvcan8i+PBKAApLD2fYOarUQdVKDJ7zRJMw0C22gyuxoyhQT+HTQseu2m
	iIvH3OOwURCVbPdJaaKYdIY0DQ==
X-Google-Smtp-Source: AGHT+IFrXoEzEmVRVSzOzT1YZ+gWxS6eF1Sdu95x/QMJlgrz+t1Ee2yozvEWMo/cVsiyiwqvxXVU3aGVoS8tAA05mWI=
X-Received: by 2002:a05:6000:d82:b0:42f:b9c6:c89b with SMTP id
 ffacd0b85a97d-42fb9c6caccmr19207847f8f.50.1766056597425; Thu, 18 Dec 2025
 03:16:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218-task-group-leader-v1-1-4fb7ecd4c830@google.com> <aUPYIm6jhceRC4J7@redhat.com>
In-Reply-To: <aUPYIm6jhceRC4J7@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 18 Dec 2025 12:16:24 +0100
X-Gm-Features: AQt7F2rMx8pc5mdf6C10I1W6Z_S5-bI58P6NNbu4f_kBP2JBUttYy3TkZlHcKzA
Message-ID: <CAH5fLgjhBZRn_gPcFK41RTRgQzqOscD+tKms0QrXdYrSZ-g+Vw@mail.gmail.com>
Subject: Re: [PATCH] rust: task: restrict Task::group_leader() to current
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 11:32=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wr=
ote:
>
> On 12/18, Alice Ryhl wrote:
> >
> > The Task::group_leader() method currently allows you to access the
> > group_leader() of any task, for example one you hold a refcount to. But
> > this is not safe in general since the group leader could change when a
> > task exits. See for example commit a15f37a40145c ("kernel/sys.c: fix th=
e
> > racy usage of task_lock(tsk->group_leader) in sys_prlimit64() paths").
> >
> > All existing users of Task::group_leader() call this method on current,
> > which is guaranteed running, so there's not an actual issue in Rust cod=
e
> > today. But to prevent code in the future from making this mistake,
> > restrict Task::group_leader() so that it can only be called on current.
> >
> > There are some other cases where accessing task->group_leader is okay.
> > For example it can be safe if you hold tasklist_lock or rcu_read_lock()=
.
> > However, only supporting current->group_leader is sufficient for all
> > in-tree Rust users of group_leader right now. Safe Rust functionality
> > for accessing it under rcu or while holding tasklist_lock may be added
> > in the future if required by any future Rust module.
>
> I obviously can't ACK this patch ;) but just in case, it looks good to me=
.
>
> Although I am not sure this is a stable material... Exactly because,
> as you mentioned, all existing users call this method on current.

Well, I suppose you are right that it isn't. I would like it to land
on Android's fork of 6.18 somehow so that nobody makes this mistake in
future Android drivers using 6.18, but I can always do that separately
of upstream Linux.

> > I don't think there's a clear owner for this file, so to break ambiguit=
y
> > I'm doing to declare that this patch is intended for Andrew Morton's
> > tree. Please let me know if you think a different tree is appropriate.
>
> If Andrew agrees and nobody objects this would be nice. I am going to
> send some tree-wide changes related to task_struct.group_leader usage,
> it would be simpler to route them all via -mm tree.
>
> So far I sent the trivial preparations
>
>         [PATCH 0/7] don't abuse task_struct.group_leader
>         https://lore.kernel.org/all/aTV1pbftBkH8n4kh@redhat.com/
>
> and I am still waiting for more reviews. Alice, perhaps you can review
> the (hopefully trivial) 1-2 which touch android/binder?

Done.

Alice

