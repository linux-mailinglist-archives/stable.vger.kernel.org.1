Return-Path: <stable+bounces-125811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C5BA6CB55
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 16:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 048F91891F6D
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 15:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EFE231A24;
	Sat, 22 Mar 2025 15:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W9HOHBjZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D55A4A05
	for <stable@vger.kernel.org>; Sat, 22 Mar 2025 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742658859; cv=none; b=OrVX6Z7jTzK6B86WICfYGItsfet4u7H1y6+vNdRmgSA2UlfJsFNh3mpCWjGAn99mtTsjipznqnGRx+nHYuCKfBp6SJ923yxX/XHyMlevm+Dw5gV9dqJAj7MM+tQeQXsjWw9WjYK37asyIJwPa8pxX2NMXMrm1Puju7mpeR/1xQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742658859; c=relaxed/simple;
	bh=3kCUWrbGk3EXB7MYSn8M3TjmiKZ7RyFzMdpHMJI/0U8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nwbSU/yXME3zOo73ce4E8RZ12i339u6n8ut1+duIdK9FBJcneDY2/RZV147oRealzt1TOcNBgfR9qUR0yqWa2yib4gqEkQrJB+jBeOZhcEtr0DXfE923km//14T8I0xaPiZ1PeeyXi7Xsq/dX0nSHe7pfGaAWEYb3C26Dd2bsSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W9HOHBjZ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2963dc379so491532466b.2
        for <stable@vger.kernel.org>; Sat, 22 Mar 2025 08:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742658855; x=1743263655; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MOUKsBTl/ZF6yrAbO3winI/gZ8Pc5E1ipNUSHyRrZpc=;
        b=W9HOHBjZj4h8OlLzXI6mJj+PsmhS1NLr4Z0Y6D2eTHMjieYUlHAjyEieuyaRQCHGFp
         NuRVMjx/egFn/tyTdQiRvaP090sWdGv8mmVujQL1u/vtXgMdMbVY5P1haKKCQmIxZNRr
         d60ByGSjFFlQSwLUjpsB8oyKzVFRiNhcSoQuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742658855; x=1743263655;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOUKsBTl/ZF6yrAbO3winI/gZ8Pc5E1ipNUSHyRrZpc=;
        b=LSiTCB67B0j52aW+ayVDIgdcRTEcAc9zxwAQQDCOPCGxYIhvvpnRhDkqptXRAVCvAV
         T8hexlHI0hnwBTNs0wMf7noRFxylKivYQH9AanzVXfgJGU03ex7YWmz93+onRBNsj3qN
         JQ0J/JXmki9mc8qPV7KLcDWOZJ4tv5yI7j7xOPj5cJtMgejexXVuy04dohE3luB0QFUJ
         ApgopO0o448vU+Ot0xJ6QO07yTUNwjafzuJtbWmUmClwLAblFzS18sOs4kgcxwQjNGsX
         yg87yrwbQ5GxFre5ISsu6ndufOSKys5ISbDWq6hym9y56j1CMRYZJidj/Bl709A51xIB
         4F6w==
X-Forwarded-Encrypted: i=1; AJvYcCXQfBmNPLJtdznxzIRjXv3W2CsXv5D+Oq17WWRmIVTuzfMiJw77SJe0aO4WnTs+/xZpLgxlB1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh+BOJGV1ECz+UW16Q94yT2E4PQXZPu9MXQZwrhHq0FpXufEaW
	7il3dg3cJwSr8wfrWJrPW+1jy5Nz+UYfWFzC9r+roR/cTkRym+5kLEn6PiXfGNWCS9kg6Y1hbfA
	szQw=
X-Gm-Gg: ASbGncvEm4kubotkXlCDch2nIYQM1zqCGniTWJ1zCa2agCnckikXgUdEhdlfqWBUn8v
	LQWjToSbhzDVkxMo0x27eaSMTXsaq4Nu7/h8/JQkvXI38Dj9KYYvsUkToOusJb9Zuj0U5Fjez3t
	huVWUYJERqoEkQOu1LwACmC9Tyd5ogowpg/VFc75Ycv9W2Jb2JPq/SwWoVTmQJV4PUxmaIvf3Un
	kTcQWGlF9FHiSye2NYom8BU2rVqz+M4lF+VzqE+4EkMNPz/8WAhKoIYVB71vHiloCI2feq0KzsL
	WOsBm6+3KJaRQp64vOOO3qJm2wGmjIJDIlGaeftq7t9OWqE9R33a3BA/5FyP1utYSETNwlnAa8U
	4e5ilAG2NnaxdTzusk7k=
X-Google-Smtp-Source: AGHT+IEuJss1H2TDyZFHF4s6A2vFgZN643nW8qqCGWXUY/wRprW/gA8nuKhIsi9ZAexkhXe1T2ZkHA==
X-Received: by 2002:a17:907:3e26:b0:aae:e52f:3d36 with SMTP id a640c23a62f3a-ac3f241bb3dmr729232766b.6.1742658855133;
        Sat, 22 Mar 2025 08:54:15 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef869f89sm368744366b.11.2025.03.22.08.54.13
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Mar 2025 08:54:13 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac298c8fa50so544366466b.1
        for <stable@vger.kernel.org>; Sat, 22 Mar 2025 08:54:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUoTrNvNi5b4ozsKBz0aQpgWoA6AI8iXQjw3NcVivZ2OIzikq6+HAZUdcrgSq+Wve16/PTnOq4=@vger.kernel.org
X-Received: by 2002:a17:907:f50a:b0:ac3:45c0:6d08 with SMTP id
 a640c23a62f3a-ac3f1e4a8f4mr730939266b.0.1742658853274; Sat, 22 Mar 2025
 08:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001210625.95825-1-ryncsn@gmail.com> <5e7ad224-651c-41aa-8d9b-b9ac43241793@gmail.com>
In-Reply-To: <5e7ad224-651c-41aa-8d9b-b9ac43241793@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 22 Mar 2025 08:53:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whVD8B=jJveFQGggyHD7srr_43aR96qZicETSNBJ65Akw@mail.gmail.com>
X-Gm-Features: AQ5f1JqsE449Qo9trjqc4RAO_R7lDsf4I61J8bZUDP0Rp_CskgJAtYvmI8tVx0A
Message-ID: <CAHk-=whVD8B=jJveFQGggyHD7srr_43aR96qZicETSNBJ65Akw@mail.gmail.com>
Subject: Re: [PATCH 6.1.y 6.6.y 0/3] mm/filemap: fix page cache corruption
 with large folios
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ryncsn@gmail.com, axboe@kernel.dk, brauner@kernel.org, clm@meta.com, 
	ct@flyingcircus.io, david@fromorbit.com, dhowells@redhat.com, 
	dqminh@cloudflare.com, gregkh@linuxfoundation.org, kasong@tencent.com, 
	sam@gentoo.org, stable@vger.kernel.org, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 22 Mar 2025 at 05:17, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> At this point, XFS large folios appear to be unreliable in the 6.1.y
> stable kernel.

I suspect it's a bad idea to start using large folios on stable
kernels. Even with the page cache corruption fix, 6.1 is old enough
that I don't know what other fixes have happened since.

It's not like the large folio code has been _hugely_ problematic, but
there has definitely been various small fixes related to it, and maybe
some of them have missed stable.

So I think stable should revert the "turn on large folios" in general.

That said:

> We would appreciate any suggestions, such as adding debug messages to
> the kernel source code, to help us diagnose the root cause.

I think the first thing to do - if you can - is to make sure that a
much more *current* kernel actually is ok.

Without a consistent reproducer it's going to be hard to really bisect
things, but the first step should be to make sure it's not some new
kind of issue that happens to be unique to what you do.

By "current" I don't necessarily mean "very latest" - 6.14 is going to
be released this weekend - but certainly something much more recent
than 6.1-stable.

Because while the stable trees obviously collect modern fixes, subtler
issues can easily fall through if people don't realize how important a
particular fix was. Sometimes the "obvious cleanup patches" end up
fixing things unintentionally just by making the code more
straightforward and correcting something in the process.

Without any real clues outside of "corruption", it's hard to even
guess whether it's core MM or VFS code, or some XFS-specific thing.
There has been large folio work in all three areas.

So I suspect unless somebody has something in mind, "bisect it" to at
least partially narrowing it down would be the only thing to do.
Bisecting to one particular commit obviously is the best scenario, but
even narrowing it down to "the issue still happens in 6.12, but is
gone in 6.13" kind of narrowing down might help give people more of a
place to start looking.

             Linus

