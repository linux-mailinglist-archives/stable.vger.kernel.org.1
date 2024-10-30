Return-Path: <stable+bounces-89340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAEC9B66F3
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 16:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96F9D1C20306
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 15:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723B920823E;
	Wed, 30 Oct 2024 15:05:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2476C1FDFA0;
	Wed, 30 Oct 2024 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300725; cv=none; b=p5+xBLSk56xvmDHcfT1iHnShWXen+EjWvVsaX7PwBnf7kMnGMQsZRCCU8KH5NnfAUZwUl0Eh6mFO2SqHo7F8T1rUDPn2Nx5GEIMfvBVM2q3+XLxeMMTMmTiQfkkE+dYLQowPxLYyPbXbfwnpC0xaA7C7VAMGH7URIozXMiLnTuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300725; c=relaxed/simple;
	bh=goD+pGiQ0rQVe2pgjoni/ZwmQIGCuuYK5AaP0rfWv34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fixnNdt5yaD+A7xig2wpzuHiG1dx7dl8OtE0lKCMRqv5qwMArVLn25TSFCQg63PeVREpGiKEDJefZHqZuzTpeQTX7pIPb3dbHhcR6OrS1TII0wtYpRU9W/03sPmbMfEHUaFsxn2Q3yX6mHkeUWUEiw0ZmeVCL+lOMqTt0/RRJM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so486360266b.3;
        Wed, 30 Oct 2024 08:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730300721; x=1730905521;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JsliBAqPxcmrKVPgDw8B1SlwFR9KYGJogW4u3jch/nA=;
        b=dYgdVehC+o9arDyIp1iypWZ7uRhHo3AEdydANQxIq17hyuIK+xRBzfxlc59crIFMc+
         4/K7B4CK6SqApeuMb7b37hV74yKJ1rNbfOhO2WRBzxO0pP6glpCo/Y6yThr/c11r706Z
         Ot7uoL1w0WgZFs0BkqnEjpZi18TK3EaqKIyA9s2KfZ2Z+ScKKrsdPo2caY2nXFfpnhdk
         Kz5PKSvpiNZVMdJNqovPKC/dJMtQI6REf9knKvvmy8Tr3e5w4NoyV1Z0TcnPKwuiiloE
         mlHn3Qk4slq5CZjilEFo57tbkct0n+BzAq7Koyh7Mqzcx7c5is2jo99053r5BfRiwfyl
         dJlw==
X-Forwarded-Encrypted: i=1; AJvYcCVEx+eFE83/1pmhYSnM9euHuCNzRNG+Bu5EYFQ/LFbISVaxyr9Cdm2xvBf3hrjHchgJsjuOiOQdBdLAtaw=@vger.kernel.org, AJvYcCWP0OacbBOJw4bq8Jz8sA4QL9j42VVJHZ6d1/GFy+UwrRHu8nc+/PHMYYbPT0A8jbGc0IKclHpk@vger.kernel.org, AJvYcCXulw7482hpklJkLbUSE5jcED9zGCGVgdouogi5tg3eGl/ebmybDM/RAm7z38lwQwxM87cebQCN@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4iq20uBusHXdDiiqDmz4FMfr1PTdvz6+gCURY42Pgn2P85nlS
	r++AAEtrEq8PP2BGf+Bwlj61HgiDqbcjqoU33G6vr9rquZVU35yw
X-Google-Smtp-Source: AGHT+IFwv5tYlaHMsIZ+p3GmjDzFyvvMxeVJcS1ooiACmmXEJ/AH7Zp6UzqKlykAB7fpZidVS9XvLw==
X-Received: by 2002:a05:6402:1d4c:b0:5cb:e6c3:d2c6 with SMTP id 4fb4d7f45d1cf-5cbe6c3d308mr10047483a12.15.1730300721025;
        Wed, 30 Oct 2024 08:05:21 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb629c250sm4837003a12.27.2024.10.30.08.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:05:19 -0700 (PDT)
Date: Wed, 30 Oct 2024 08:05:16 -0700
From: Breno Leitao <leitao@debian.org>
To: Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, horms@kernel.org, davem@davemloft.net,
	pabeni@redhat.com, Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, vlad.wing@gmail.com, max@kutsevol.com,
	kernel-team@meta.com, aehkn@xenhub.one, stable@vger.kernel.org,
	"open list:NETWORKING [MPTCP]" <mptcp@lists.linux.dev>
Subject: Re: [PATCH net] mptcp: Ensure RCU read lock is held when calling
 mptcp_sched_find()
Message-ID: <20241030-keen-vicugna-of-effort-bd3ab8@leitao>
References: <20241030140224.972565-1-leitao@debian.org>
 <CANn89iLbTAwG-GM-UBFv4fNJ+1RuUZLMFNDCbUumbXx3SxxfBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLbTAwG-GM-UBFv4fNJ+1RuUZLMFNDCbUumbXx3SxxfBA@mail.gmail.com>

Hello Eric,

On Wed, Oct 30, 2024 at 03:18:14PM +0100, Eric Dumazet wrote:
> On Wed, Oct 30, 2024 at 3:02 PM Breno Leitao <leitao@debian.org> wrote:
> >
> > The mptcp_sched_find() function must be called with the RCU read lock
> > held, as it accesses RCU-protected data structures. This requirement was
> > not properly enforced in the mptcp_init_sock() function, leading to a
> > RCU list traversal in a non-reader section error when
> > CONFIG_PROVE_RCU_LIST is enabled.
> >
> >         net/mptcp/sched.c:44 RCU-list traversed in non-reader section!!
> >
> > Fix it by acquiring the RCU read lock before calling the
> > mptcp_sched_find() function. This ensures that the function is invoked
> > with the necessary RCU protection in place, as it accesses RCU-protected
> > data structures.
> >
> > Additionally, the patch breaks down the mptcp_init_sched() call into
> > smaller parts, with the RCU read lock only covering the specific call to
> > mptcp_sched_find(). This helps minimize the critical section, reducing
> > the time during which RCU grace periods are blocked.
> >
> > The mptcp_sched_list_lock is not held in this case, and it is not clear
> > if it is necessary.
> >
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Fixes: 1730b2b2c5a5 ("mptcp: add sched in mptcp_sock")
> > Cc: stable@vger.kernel.org
> > ---
> >  net/mptcp/protocol.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 6d0e201c3eb2..8ece630f80d4 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2854,6 +2854,7 @@ static void mptcp_ca_reset(struct sock *sk)
> >  static int mptcp_init_sock(struct sock *sk)
> >  {
> >         struct net *net = sock_net(sk);
> > +       struct mptcp_sched_ops *sched;
> >         int ret;
> >
> >         __mptcp_init_sock(sk);
> > @@ -2864,8 +2865,10 @@ static int mptcp_init_sock(struct sock *sk)
> >         if (unlikely(!net->mib.mptcp_statistics) && !mptcp_mib_alloc(net))
> >                 return -ENOMEM;
> >
> > -       ret = mptcp_init_sched(mptcp_sk(sk),
> > -                              mptcp_sched_find(mptcp_get_scheduler(net)));
> > +       rcu_read_lock();
> > +       sched = mptcp_sched_find(mptcp_get_scheduler(net));
> > +       rcu_read_unlock();
> 
> You are silencing the warning, but a potential UAF remains.
> 
> sched could have been freed already, it is illegal to deref it.

Thanks.  I got the impression that the scheduler list was append-only,
and the entries were never freed.

