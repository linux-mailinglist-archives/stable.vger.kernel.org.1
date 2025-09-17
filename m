Return-Path: <stable+bounces-180424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2073CB8125C
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 19:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF837587EF0
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 17:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7465F2FB0A0;
	Wed, 17 Sep 2025 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AVgTlUEO"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A561E2F99BD
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758129632; cv=none; b=kjx7nQ73yCjh6gKxRPYQ4KAWdJvNUyHxP7QWr1+waS9ganUiCIbBtWIrJgS2ayQtQpYbetFq3sIcZIIQh/ksoBp/WlLVVYUQ7MTnMlCKJmK1JelbeyfLhdXxp5hZWNZ9ZVqaQziIaGw6NcBZEsYP/qUvv0uFWkkIpRIxD4VVJ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758129632; c=relaxed/simple;
	bh=/vy1AWwaIm2CnLmZbXU2CpyIRzkKxxughA8uZl7Q2M4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=byWGolKUw6hN0WdFmt5RAowWdW7AoL5smTJnbk4DYo0agdQM6PumDWHke97a9Pqq8j2sIUGcOJ/Pp9aa6SSWZ0H0RHE0KnydqAOyQUEtj8UchrnnU5zKnNxJvHmmy4spQAgtSRUJRzX8uqCcAGt+hzG+ihTfhvaM8W6Qm/DFmvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AVgTlUEO; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b7a8ceaad3so640551cf.2
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 10:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758129629; x=1758734429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+LfTPWxGtESwfNdYqgO0bM4lV3SAmEoBrc7Qa6udhA=;
        b=AVgTlUEOFXUZvlOD5kzof+jZH9Szy9DQ/fbsuSBs+4llvk32vRp32MiURE39FFovC7
         T+COX7JRDYVj6dd/Y/qk7Y6h0p0jea48nMbjaPj5WGJu8tngpwdr//gO3AIRwIl4Nigz
         tOM1r00ZkI8IkbUBBgV9N772ZAeXVmLKRdbWULkjhUFFng29bfmh/HpuhECn1J6KiLS0
         eKLMPwsY7rVVuuTd4xIdti/kK1dlfkAlJBfpvAX9+iLdhpAou6RObMCbIO8sRYwIfgXM
         ZXxMguktQb7PvAyp0m+KvshMZ+1l5XM3UcKhH366UzwkavzXJXlCBrcwXJwpCDpPbO3W
         nK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758129629; x=1758734429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+LfTPWxGtESwfNdYqgO0bM4lV3SAmEoBrc7Qa6udhA=;
        b=KCYNCqn90GI9LAgVGOtfgVXFVsCQwcxSok9xD9OZcU7jbbxpO8I5QspvG6kzCUyY24
         cSEV0RmBliQPN0AxykMKuiatIe28UWrq6ScDWzurpVkaNgEUmj9v1e7M08vhgkJLVYrI
         4yMN75oXCKm2wjezsBc3vKNlcHas3u7cKdGVCZ3VAC6UJ1uaTUzRhEPOZf2u7XHs1SE+
         SjBu3q8j4TqDypdTBGneIgWnJNS+OvVUykq8I8nDDBs70ZUAHnlUVjbqr5/+VYkVKnWv
         ldlVZVEWmOHbJUJ3WPkpHzQM0hrCZfGrbPw+hophumMskqPPz1Juot2kfS3r8f9FKzRf
         9Oyw==
X-Forwarded-Encrypted: i=1; AJvYcCX9qDxIZFmkEcuXVmVFq7hkl6YG3SB40otttcDUADWbooqQ2ZfPiLnC5CmQ31AkGHwi+ogCgrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnO39FMPpNmwI03GDDzgJV5SOAEHnao71OujdPf5OSNAUPYPE7
	/gBMHIjV7/vdL7+g3gjnWK5RZakqmkyldd55nBjqYj8wbXLrYvg3wgAZAXclTc2+b9+ekcpTLp6
	ZVMKsiNf70Su7lv1VrgBwqA3spIpJZ30ALLH8Ajwv
X-Gm-Gg: ASbGnctNj+3g+Di+Cm3cCm5Wys1q3ens8/g+a5BFzx0luND9As1wTo0mjGVIbYyKVR5
	zXlngvhU9iLIpGYIDLfm64YJkBa9CNxUfMpMPDUMefq4k93LKW0Mf1Crgu+2fPFGSi5dw9ocxD8
	4PkkCLdf8XNJg/mViY6DUTtWQdWhtEroUW8I3VzOYqIo2WO8g29SYfTpJsDqy5UKqxp9uX7F7I6
	++9JUfrZWsB5BCvKOuuX04=
X-Google-Smtp-Source: AGHT+IFQDui72xfWFBil78fA+RutTLvzXuM23RmVZw5RDPSFC0t/VuO4PKRhCwr70nXCULFwZVkRdnMlqxM9P8muvq8=
X-Received: by 2002:a05:622a:5d3:b0:4b6:9b2:e83e with SMTP id
 d75a77b69052e-4ba66c1e0f8mr31755291cf.24.1758129629027; Wed, 17 Sep 2025
 10:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917135337.1736101-1-edumazet@google.com> <CAEWA0a6b5P-9_ERvh9mCWOgbH6OYdTUXWVGgA20CQ5pfDC2sYA@mail.gmail.com>
 <CANn89iLC+Gr9BbyNQq-udVY-EZjtjZxCL9sJEpaySTps0KkFyg@mail.gmail.com> <CAEWA0a4x4XMZKtpz_pNKruC4zwjETVxUuEMs2m_==Dpib_Jrqg@mail.gmail.com>
In-Reply-To: <CAEWA0a4x4XMZKtpz_pNKruC4zwjETVxUuEMs2m_==Dpib_Jrqg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 10:20:17 -0700
X-Gm-Features: AS18NWBe_Ohe6j0QfjVQ8V4ffOaHdFwMRrHPQuT-vJAPZqZF3jpye1GAnMAEvcA
Message-ID: <CANn89iKZDvL9vKbmDa4ivnrm11e0fc65A-MXs8kY4MxR0CnGTw@mail.gmail.com>
Subject: Re: [PATCH net] net: clear sk->sk_ino in sk_set_socket(sk, NULL)
To: Andrei Vagin <avagin@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, stable <stable@vger.kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:03=E2=80=AFAM Andrei Vagin <avagin@google.com> w=
rote:
>
>  is
>
> On Wed, Sep 17, 2025 at 8:59=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Sep 17, 2025 at 8:39=E2=80=AFAM Andrei Vagin <avagin@google.com=
> wrote:
> > >
> > > On Wed, Sep 17, 2025 at 6:53=E2=80=AFAM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > Andrei Vagin reported that blamed commit broke CRIU.
> > > >
> > > > Indeed, while we want to keep sk_uid unchanged when a socket
> > > > is cloned, we want to clear sk->sk_ino.
> > > >
> > > > Otherwise, sock_diag might report multiple sockets sharing
> > > > the same inode number.
> > > >
> > > > Move the clearing part from sock_orphan() to sk_set_socket(sk, NULL=
),
> > > > called both from sock_orphan() and sk_clone_lock().
> > > >
> > > > Fixes: 5d6b58c932ec ("net: lockless sock_i_ino()")
> > > > Closes: https://lore.kernel.org/netdev/aMhX-VnXkYDpKd9V@google.com/
> > > > Closes: https://github.com/checkpoint-restore/criu/issues/2744
> > > > Reported-by: Andrei Vagin <avagin@google.com>
> > > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > >
> > > Acked-by: Andrei Vagin <avagin@google.com>
> > > I think we need to add `Cc: stable@vger.kernel.org`.
> >
> > I never do this. Note that the prior patch had no such CC.
>
> The original patch has been ported to the v6.16 kernels. According to the
> kernel documentation
> (https://www.kernel.org/doc/html/v6.5/process/stable-kernel-rules.html),
> adding Cc: stable@vger.kernel.org is required for automatic porting into
> stable trees. Without this tag, someone will likely need to manually requ=
est
> that this patch be ported. This is my understanding of how the stable
> branch process works, sorry if I missed something.

Andrei, I think I know pretty well what I am doing. You do not have to
explain to me anything.

Thank you.

