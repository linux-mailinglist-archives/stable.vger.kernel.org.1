Return-Path: <stable+bounces-89328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C79A9B657A
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 15:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D9B282517
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 14:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6027E1EBFFF;
	Wed, 30 Oct 2024 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BCkBbO1V"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF2C1E47B2
	for <stable@vger.kernel.org>; Wed, 30 Oct 2024 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297912; cv=none; b=qWTkOkK/6c+UrgMAXuBiPNQ8k2FWmzz/cJgpwGdgNwgsrxfoIQYsi01VM2PFOxqW4Zj2WYVUx22BfoFz8RfK6aPoOrsdlqORkzIRgcAQ1rLMZE0i5mTG+ABCpbUV+OlmOgyPMHgCp+wHfoeazWy+VpsR/Yahio70TfLZoLwu+gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297912; c=relaxed/simple;
	bh=ZCOoHIRMbKIZGLHZWE5qwSr0CwEqLtaGujX1YBNvVxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lffh6a370c1JH0YVIdj4D3ByMqrBhqsl8fQH7ddDJOB1KEPtKEgEAQpY1TfR3X/NRq8jSdFs2BdekKe0CLpCK8ikXxFNdMEzN7Sep3qXpTVzYfX+tbUteyyhTWtxeeATL6WI5q+LRN/Am5AYxJsSjLBLteV+IxuF5weCPGeh8jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BCkBbO1V; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb5638dd57so62647311fa.0
        for <stable@vger.kernel.org>; Wed, 30 Oct 2024 07:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730297908; x=1730902708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZI1Q7iFFALyNWdb6YnYTA6RNW062i2zYDoz0ifkHGFk=;
        b=BCkBbO1VvrIOmm0ba1Z8TM+ZxiOzS+sCS9d0tCDgjfBjUkVZG7wcHyu5uNNQXIlyB3
         2hHwyCEtRDanwa8N0OQ8rZ52pCBPHfjqDBcz8atNC4J6HxoGEhNyznRD59tURWFRFruk
         qJ2v2u9AevTjlkK8dYD6HaP8cq0z/PfEjffHSWkST6weBEbl6vNKmD6zG+G6f12hEdEx
         qlkWuKaW9TRdRcTh0E3dYa69aIUhlMrLqK2vyLIzg6SsEgouJBoyxw7fZ3N15tO6QtmJ
         bXl9Ovuf9bjEcwcCmfL1tiT/KhEg0KzsEKvQKOeHq1I4bONLwCRR4kPzNkV6eexIHlE8
         rFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730297908; x=1730902708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZI1Q7iFFALyNWdb6YnYTA6RNW062i2zYDoz0ifkHGFk=;
        b=BAcpLfmPoQpcX9zFqnu2delDP8LIn9Y9ZqHDayhSBAh8zFijqg7izdsDcW5PmN4H4X
         lbxr8WlE1bh47MAFaoq06b6PSwd+JAnfYJpRsxT81XM0EoXOxz1iYfb/7lMnANwFMd1Q
         KSnAverN47TQM3mxWJXid8Ec50yKA11cR2dSdvHLA9/5B2FbndGEuDmoqOe+q/GTc09J
         2ntLRxbZt3r49XCg+8FghZEFRH6OrVung7AazOuMFagKAQhOCTUSB9yn9uVloVHZmYWU
         BnT7s30djInE3eVnynUVQ7V1czY2oEeqY9IOCBJUnuiVtMc3UYeyQ04zBe+7pNjg54VA
         UGTg==
X-Forwarded-Encrypted: i=1; AJvYcCWZDys5V80uFGci7A7+CobMUjYPCjBT+qegokbwaolILUuJeQrKzX29fSxcIvgMXTppz/FRbeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhtRGmclKHeY3rlBRvzVk7oDq6h/AjKql5Ov6ot2PpTzi7USQd
	0tzBEfK9dI+AI4eg2BFg1koY/drpSj90PAUpLb8gBcZLvoUrovhfA5kh0iZekfaOSYHFKG185oz
	XBturY8QMGyX+6jvAV458hcevgpo2J2NsAGnL
X-Google-Smtp-Source: AGHT+IFBilfUkzHEmS6+o84sCK1y4uKaB4NO7YNRFJquAc77QKxj0moVYTFp7ObaLzboY+vQGnMMw+U412cqHiD5QrU=
X-Received: by 2002:a2e:b88e:0:b0:2fa:e658:27b4 with SMTP id
 38308e7fff4ca-2fcbdf5fe55mr73102971fa.4.1730297907852; Wed, 30 Oct 2024
 07:18:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030140224.972565-1-leitao@debian.org>
In-Reply-To: <20241030140224.972565-1-leitao@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 30 Oct 2024 15:18:14 +0100
Message-ID: <CANn89iLbTAwG-GM-UBFv4fNJ+1RuUZLMFNDCbUumbXx3SxxfBA@mail.gmail.com>
Subject: Re: [PATCH net] mptcp: Ensure RCU read lock is held when calling mptcp_sched_find()
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, horms@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vlad.wing@gmail.com, max@kutsevol.com, kernel-team@meta.com, aehkn@xenhub.one, 
	stable@vger.kernel.org, 
	"open list:NETWORKING [MPTCP]" <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 3:02=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> The mptcp_sched_find() function must be called with the RCU read lock
> held, as it accesses RCU-protected data structures. This requirement was
> not properly enforced in the mptcp_init_sock() function, leading to a
> RCU list traversal in a non-reader section error when
> CONFIG_PROVE_RCU_LIST is enabled.
>
>         net/mptcp/sched.c:44 RCU-list traversed in non-reader section!!
>
> Fix it by acquiring the RCU read lock before calling the
> mptcp_sched_find() function. This ensures that the function is invoked
> with the necessary RCU protection in place, as it accesses RCU-protected
> data structures.
>
> Additionally, the patch breaks down the mptcp_init_sched() call into
> smaller parts, with the RCU read lock only covering the specific call to
> mptcp_sched_find(). This helps minimize the critical section, reducing
> the time during which RCU grace periods are blocked.
>
> The mptcp_sched_list_lock is not held in this case, and it is not clear
> if it is necessary.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Fixes: 1730b2b2c5a5 ("mptcp: add sched in mptcp_sock")
> Cc: stable@vger.kernel.org
> ---
>  net/mptcp/protocol.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 6d0e201c3eb2..8ece630f80d4 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2854,6 +2854,7 @@ static void mptcp_ca_reset(struct sock *sk)
>  static int mptcp_init_sock(struct sock *sk)
>  {
>         struct net *net =3D sock_net(sk);
> +       struct mptcp_sched_ops *sched;
>         int ret;
>
>         __mptcp_init_sock(sk);
> @@ -2864,8 +2865,10 @@ static int mptcp_init_sock(struct sock *sk)
>         if (unlikely(!net->mib.mptcp_statistics) && !mptcp_mib_alloc(net)=
)
>                 return -ENOMEM;
>
> -       ret =3D mptcp_init_sched(mptcp_sk(sk),
> -                              mptcp_sched_find(mptcp_get_scheduler(net))=
);
> +       rcu_read_lock();
> +       sched =3D mptcp_sched_find(mptcp_get_scheduler(net));
> +       rcu_read_unlock();

You are silencing the warning, but a potential UAF remains.

sched could have been freed already, it is illegal to deref it.

> +       ret =3D mptcp_init_sched(mptcp_sk(sk), sched);

The rcu_read_unlock() should be moved after this point.

This means that mptcp_sched_ops ->init() functions are not allowed to sleep=
.

>         if (ret)
>                 return ret;
>
> --
> 2.43.5
>

