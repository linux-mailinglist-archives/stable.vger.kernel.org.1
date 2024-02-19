Return-Path: <stable+bounces-20624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5155985AA1D
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7A01C21F79
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D79846551;
	Mon, 19 Feb 2024 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qnZR8Mf9"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E736944C92
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708364149; cv=none; b=sye1kRPVIl0lvkvYl2JVp7tCP3pGtfls5fkrwjwjY2EEqjX6fuF8tTXc9pa/aeNYDk4h3V7yJamv/zzQLU6vMZBRUWjYf1KDTqnx/Ptc276MBgzkruEe4Gu09vR2G3oC1+xCetH+pCWpKuVHOVCHcQi4m2/jTdN3977YseBkVoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708364149; c=relaxed/simple;
	bh=wJCpYntqq8nCglIkq88Zs9qTSRweYslEK0KjbQBa4Bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luQ0PlJNEckDQkaJTzWmYbuinZytJAaXtcZBN94pCx5/84OsiR7yFYo82gCQWaGaEcpW72N/I+8GiJnq5V1UXIirRYyNaeImCYyqmQfA1X2hNsQNOpEIYo57xxOwd68kaSjsVp3WXd5CzqC4ooON7k/LXTo9ZywcmjXXRxPrzbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qnZR8Mf9; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-561f0f116ecso15853a12.0
        for <stable@vger.kernel.org>; Mon, 19 Feb 2024 09:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708364145; x=1708968945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpH+GG/JxRVKqFjHr33MFZWda+dSzZgj8Xxgn4JwPS8=;
        b=qnZR8Mf9OXg9M88jTqacpGR0VokQ4cl6dxm4BrwfAqkIhovRA2gUuTEyZfLnhAEcFR
         Mo9djPgblUq9mIGUmbSlFtdv61274wgtpdJo05I4wr109y9ULgiAGKw1GPFDscQ/38zk
         YDJ9hkomHCkHZ9UMUWaCflYoPokfEpf/uw5+so3Jo4nbDk9YS8Uq4Ovzq2Bp2q3DGJOt
         8E0azaZNDmTnNKhnMUTpG5osWaTJ0OT9q2jtAn+1o/OxJ63OsK6Vhgi54Wua6AZPXNWO
         ABxCAfNG1ylw8P6sg6xGDNEeQqNm+Su0XA7/FuQ2lOuUtRynVGVJlqxFtcYP67f2bIVQ
         FhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708364145; x=1708968945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpH+GG/JxRVKqFjHr33MFZWda+dSzZgj8Xxgn4JwPS8=;
        b=ISJvzLUCY1j+zfmPnoE0C6SRU0XUhvuUZQ+dg1BDzy++U3n5dzFsSgKop3iubJZ8si
         phlnFfIaZGsuW6BzgWvLd0MRJTwtDKPqEO6iFYwWzcboWYhC997d1NVhMYv6tcMUcKrl
         y1P1prg+5gA/WkQPOGK6X2H0SPQjscHfl65ZSq5M91nSpUf/ahyaXOyaeD0Lv4SkPRKJ
         ctxVPRDlUAcBFIIFS2Ae23xZRVPHNfE2Qw0lROQQ6idCBZOqNh6Xpo8Z1XfeeE6eaZ1G
         vQtbs/TeURRqfUrUZifmGdeNw2WSVPzGnvOAyQuqo+dCwliL8anZvMNl2a2aM7KFxbXh
         SaVg==
X-Forwarded-Encrypted: i=1; AJvYcCW6nVEy/peWPcN+0caunjZq4cT3t1pUMqJMTHkyRLpo6vm2TCzggiLcl07K8eAeBL8yT/RbUbR7p4RRzwofXPu21XwrlOHq
X-Gm-Message-State: AOJu0YxXMH5eTWn5r4mQIVASyxHS7p+v8qh/6zXbBB1D4EwHBqH9tCgV
	Wl19LIpg78R0ELcoqe2Zk3HlccmzQcw4TXg408zlZOnRG9BX4WJzC3Hpoz4BY8HtduzJNnmENnV
	uBDXgzMhXX1gmrSdKpJOYL4jhIxPIQvY0F30o
X-Google-Smtp-Source: AGHT+IE99wN/PQYfiDNakz6zkMQR7kOEOngXX0T7gN2tvc5IjeQakHE9Z1BsxKNQN8jOzpCri2PXj7rsMGF+tGMHWj0=
X-Received: by 2002:a50:a697:0:b0:563:ff57:b7e8 with SMTP id
 e23-20020a50a697000000b00563ff57b7e8mr322644edc.1.1708364145075; Mon, 19 Feb
 2024 09:35:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
 <20240215-upstream-net-20240215-misc-fixes-v1-3-8c01a55d8f6a@kernel.org> <CANn89iJ=Oecw6OZDwmSYc9HJKQ_G32uN11L+oUcMu+TOD5Xiaw@mail.gmail.com>
In-Reply-To: <CANn89iJ=Oecw6OZDwmSYc9HJKQ_G32uN11L+oUcMu+TOD5Xiaw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Feb 2024 18:35:31 +0100
Message-ID: <CANn89iJDypRXX-8S-UdqWgw73eOgt0+D74qUCLDkb0cRpFFXkg@mail.gmail.com>
Subject: Re: [PATCH net 03/13] mptcp: fix lockless access in subflow ULP diag
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Davide Caratti <dcaratti@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 6:21=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Feb 15, 2024 at 7:25=E2=80=AFPM Matthieu Baerts (NGI0)
> <matttbe@kernel.org> wrote:
> >
> > From: Paolo Abeni <pabeni@redhat.com>
> >
> > Since the introduction of the subflow ULP diag interface, the
> > dump callback accessed all the subflow data with lockless.
> >
> > We need either to annotate all the read and write operation accordingly=
,
> > or acquire the subflow socket lock. Let's do latter, even if slower, to
> > avoid a diffstat havoc.
> >
> > Fixes: 5147dfb50832 ("mptcp: allow dumping subflow context to userspace=
")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > Reviewed-by: Mat Martineau <martineau@kernel.org>
> > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > ---
> > Notes:
> >   - This patch modifies the existing ULP API. No better solutions have
> >     been found for -net, and there is some similar prior art, see
> >     commit 0df48c26d841 ("tcp: add tcpi_bytes_acked to tcp_info").
> >
> >     Please also note that TLS ULP Diag has likely the same issue.
> > To: Boris Pismenny <borisp@nvidia.com>
> > To: John Fastabend <john.fastabend@gmail.com>
> > ---
> >  include/net/tcp.h  | 2 +-
> >  net/mptcp/diag.c   | 6 +++++-
> >  net/tls/tls_main.c | 2 +-
> >  3 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index dd78a1181031..f6eba9652d01 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -2506,7 +2506,7 @@ struct tcp_ulp_ops {
> >         /* cleanup ulp */
> >         void (*release)(struct sock *sk);
> >         /* diagnostic */
> > -       int (*get_info)(const struct sock *sk, struct sk_buff *skb);
> > +       int (*get_info)(struct sock *sk, struct sk_buff *skb);
> >         size_t (*get_info_size)(const struct sock *sk);
> >         /* clone ulp */
> >         void (*clone)(const struct request_sock *req, struct sock *news=
k,
> > diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
> > index a536586742f2..e57c5f47f035 100644
> > --- a/net/mptcp/diag.c
> > +++ b/net/mptcp/diag.c
> > @@ -13,17 +13,19 @@
> >  #include <uapi/linux/mptcp.h>
> >  #include "protocol.h"
> >
> > -static int subflow_get_info(const struct sock *sk, struct sk_buff *skb=
)
> > +static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
> >  {
> >         struct mptcp_subflow_context *sf;
> >         struct nlattr *start;
> >         u32 flags =3D 0;
> > +       bool slow;
> >         int err;
> >
> >         start =3D nla_nest_start_noflag(skb, INET_ULP_INFO_MPTCP);
> >         if (!start)
> >                 return -EMSGSIZE;
> >
> > +       slow =3D lock_sock_fast(sk);
> >         rcu_read_lock();
>
> I am afraid lockdep is not happy with this change.
>
> Paolo, we probably need the READ_ONCE() annotations after all.

Or perhaps something like the following would be enough.

diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index 6ff6f14674aa2941bc04c680bacd9f79fc65060d..7017dd60659dc7133318c1c82e3=
f429bea3a5d57
100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -21,6 +21,9 @@ static int subflow_get_info(struct sock *sk, struct
sk_buff *skb)
        bool slow;
        int err;

+       if (inet_sk_state_load(sk) =3D=3D TCP_LISTEN)
+               return 0;
+
        start =3D nla_nest_start_noflag(skb, INET_ULP_INFO_MPTCP);
        if (!start)
                return -EMSGSIZE;

