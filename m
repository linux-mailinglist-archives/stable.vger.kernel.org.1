Return-Path: <stable+bounces-151584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6912AACFC66
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 08:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3431755A1
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 06:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A59E24E4C6;
	Fri,  6 Jun 2025 06:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jaP5yzMw"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B9D136E
	for <stable@vger.kernel.org>; Fri,  6 Jun 2025 06:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749190104; cv=none; b=GZFUD/gikS8RbT8Nus4f8hk8O3GJgqX289a0GMUPUrHBvVCN3Fgtpp+9lvanYuO4fBCjiW51txGe9cLN5uK6mUsKNew1fT8CeOJTkt9Vjl+fIN5Tdpza8Lk+lNciTqKnMCjndM7svjqQApYOoQ10MeyQxwBqTRtD0na1njpQ/NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749190104; c=relaxed/simple;
	bh=0bQVlQAkZiktNGRrwzVnwFpZbIiq3nNzG/ksOecik/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I65k9MhWbfc1LUuuoy+2YbS0AeSKVamL1HTf9GKt+pcjY3q0yEBmj5JkDL0o1ABk/Idr9G3gWM5iFvFUi3SGJFUBtynbL797jC+yAtDEn+GxghOw/9UoWlA3eyB/z2Fanfnsk4anvbLMjMxclL5sbQfFnJbP6wiSQOlIpPZGNTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jaP5yzMw; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a589b7dd5fso29245221cf.0
        for <stable@vger.kernel.org>; Thu, 05 Jun 2025 23:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749190101; x=1749794901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKvStmYDfkAOPdQAkmQVzm7vE8Ux/xTu/Lq8EZxk5pg=;
        b=jaP5yzMwsdqxvLfHrGOMnelVMDp/VcUaAyRpHNipSFt3sowjhpFQV5MnlIVze+lyx5
         v3g7tI6ZorPkEUgl7ioy9l/Cucy55UmiHF8QlbIw0zegtaody6MTlidhYLWLlFKTNS0o
         pevIVG76bKpj/b0UBFy7ZKP8SkRo/E+kKulyupxV13ZV/rzN1CO6WT6dwiCWq3sVAwrB
         qBdqvkvjuPQGKjqCJldVA9j/XHgVgPPPxwB66E2kd2YWmA1p2HZ+3DQ/AbDUoRLfN6tR
         NlU0h6uIishE7QXqz3FX42ZTfm/BkHXm6yWTPj0Mq3pJHemEgU8UGpFJiaiZBZJeblee
         qvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749190101; x=1749794901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKvStmYDfkAOPdQAkmQVzm7vE8Ux/xTu/Lq8EZxk5pg=;
        b=BEfZE5LNypfFRnp3ALylEPw62eicpD/Hm8rr8W5NSmU1wxX5jAlv106shiWXLP3AX1
         V/COoDzZzoSSyBTYjG0fEZDoDHyDH4DZTmIx/9zn/DGnh6txayQNWPU3ixDT4JTRZhno
         DiZ+M3ULBT6dHT6KKqEC0AXo/88utdST60hQjM1Qt0zGXwPvdGEx0T07g3Zx2V2KsN6I
         mZEqEYBGCfsm4sD2jKn0QQucmGpG+B4kgA7E/+Gcw6s2gF7zKlAriPRpkhQlHlynDpuj
         ySGPjDyjSYqE6gjXuOeUWQ8CKrQdY7h/HR625EUq9uHnJWTDN/KOz7bLpgEPHay0MAW/
         KYbg==
X-Forwarded-Encrypted: i=1; AJvYcCUDerl1B+suopBPRIYZ8HbiJABQceyv/rX7AIEts+v7vaKstEzhM/mafKm+s7YPVBYh8i5R2l0=@vger.kernel.org
X-Gm-Message-State: AOJu0YywixnErruSj9vKNxk2a1GbwOK2R19IGm/Qepgg7g+UyoVznc5m
	DPv5fKAq5DU0iH+cUxK+iyO3I996tA9LFFga+UEegABec7Gfd79OUL4yc/amQjfthWajBzrrCpf
	LZk1JDllfSyIi43pkKw5yk5DsdriRx1/srMQrlpGu
X-Gm-Gg: ASbGncvsuPe9ciSCwBaEDzDgt31SVtzns14CYuh9i85QfzkdSXpmUgZeiC6ZmikFJNr
	SQ8c0ThX0h5+HwLzwNi56oEs2UWRhhyPbI5zcOOO/9onK2D8I3OECOUrcvruCkakzkW4/1etk2L
	gLu/4jjZ8e92kbovRdLAZQxN+aB4b29qp6jGSrvwNCEilMDi7Ew9yadEJYo3fqiNc2/jUFtf6N
X-Google-Smtp-Source: AGHT+IFNLf8kiaoxiVhlcZHxWQipk57Pwx1NjDf59/NaBKuvZ9xKQtErzz+1d8bwORt3x1wf4IaR5TD3NK/vee4duoU=
X-Received: by 2002:ac8:6f08:0:b0:4a1:511a:b99f with SMTP id
 d75a77b69052e-4a5b9a00f7fmr43119931cf.3.1749190100655; Thu, 05 Jun 2025
 23:08:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606052301.810338-1-suleiman@google.com> <20250606053650.863215-1-suleiman@google.com>
 <2025060650-detached-boozy-8716@gregkh>
In-Reply-To: <2025060650-detached-boozy-8716@gregkh>
From: Suleiman Souhlal <suleiman@google.com>
Date: Fri, 6 Jun 2025 15:08:09 +0900
X-Gm-Features: AX0GCFsRvL-wnGhd79Wc0undNc8c43NKvrHNdqcadxOFKESr_qPXBVorv1nNUwA
Message-ID: <CABCjUKA-ghX8MHPai5mfC4dZgS8pxi3LAvh3Wnm0VCt4QmU2Hw@mail.gmail.com>
Subject: Re: [RESEND][PATCH] tools/resolve_btfids: Fix build when cross
 compiling kernel with clang.
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Ian Rogers <irogers@google.com>, 
	ssouhlal@freebsd.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 3:05=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Fri, Jun 06, 2025 at 02:36:50PM +0900, Suleiman Souhlal wrote:
> > When cross compiling the kernel with clang, we need to override
> > CLANG_CROSS_FLAGS when preparing the step libraries for
> > resolve_btfids.
> >
> > Prior to commit d1d096312176 ("tools: fix annoying "mkdir -p ..." logs
> > when building tools in parallel"), MAKEFLAGS would have been set to a
> > value that wouldn't set a value for CLANG_CROSS_FLAGS, hiding the
> > fact that we weren't properly overriding it.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 56a2df7615fa ("tools/resolve_btfids: Compile resolve_btfids as h=
ost program")
> > Signed-off-by: Suleiman Souhlal <suleiman@google.com>
> > ---
> >  tools/bpf/resolve_btfids/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> You forgot to say why this is a resend :(

I wasn't sure how to say it. It didn't occur to me that I could have
replied to it with the reason.

It was because I had "Signed-of-by:" instead of "Signed-off-by:".

-- Suleiman

