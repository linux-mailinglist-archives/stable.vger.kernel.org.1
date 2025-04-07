Return-Path: <stable+bounces-128515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA435A7DC18
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 13:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CFEB3AFAFA
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 11:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0355C23AE64;
	Mon,  7 Apr 2025 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ULup7bcu"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2808E235375
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744024885; cv=none; b=lljKHyXzS1IhfuNuSf4MRdn3B0IcH4bR8DF0Pr+kqgX2hVlD8X8l78SR+MtTQSHuTfwWkoW454scbn9uiFUYTdSCo+Sc2AsCjclJIObPir573R0aU8TvBJBAOuxw+B1uckdAGC1hM+M8B7Gib7JDtBQepHmPRPTZgGg1BoZpIPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744024885; c=relaxed/simple;
	bh=11prt/gCV715SBQ0ZOh1/VbypqW+YjEr9rmshQ6HfYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPgujlOsrLjYQXqGIKD0EUmYfyk4oqPj6OOmtfUKz2E2zpiVlGnkuy/08pEOB5sLTK2Am2O44SfO8+zP2epsmyLY14DsLAnh1+ovkDvxKFuPMejqzd4OquDH3YJZhI2CPcfrSgyw7i9K6rohGcsSA563lTAyVuSQwAuYL7kh5q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ULup7bcu; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-476a304a8edso40800051cf.3
        for <stable@vger.kernel.org>; Mon, 07 Apr 2025 04:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744024883; x=1744629683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5UYeCEh2Uy28vzmXLGJt3AaKdB31pSjQ00eMVa3MY0=;
        b=ULup7bculEUYNatzobNByfjUVvWrZ1wbbThbv1lyZ+NsU5vFT294AYjskVl0FOkhBb
         pL6DZCGuUOD6HMDjv1D3y4jU0iQMK83tFxuWODLQMtPFDjoj/goeTQivxbHwgaJwMUET
         lVTViVpjBwlp1hjc9ps4x8EV3iZ1YvPnrBH89N7QUzlCCZuTtr4QpufwxGzxR/pFaEDg
         nOS0P0DKbhA0FVOvD5NeXR5+HbK8SNeQCo/S4zn4alNVKbOU0wxItAGDTjQRQRIsFyAD
         PdLLZckx92kiNXISS6kXmivg1gddffLEBDI8t2ElWrsCWd7jsFYXhWcVnJV2heEsZypw
         6beA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744024883; x=1744629683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5UYeCEh2Uy28vzmXLGJt3AaKdB31pSjQ00eMVa3MY0=;
        b=AIThlMUY20EDk7MNLiYP18U18fDEmdGgZ1R/V/NTPIGzgsG74EgfkTy7G3DxY45lnz
         Bqzo+cvyVX+pwd+2TWvycJWZ1fsB5+XDyXOW7vGdbPIYrjXRPDCeUM8/25KxCZCICmXj
         6qucdQ2iBz86OADoFmqUCvdSoRuKi2Xm+Q7Tj8NG0X1P6nnuQ75xFLiHS60sdJW0k1bB
         dIrhRls0/n65gZTcDEMFmVWsLToC+/8VOEb0Zyoq3mnVON9NQDufniinDjsjATmGSodA
         ZnAyEpj2Re0nejfNfvDK92gn2LTwi83QzaQQtl+w/iczurMLDFdITs1SWlNECfjFu0Zu
         G+Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWiODKFCc8m6Y2e5f1SG+khlXgv66Wuzif4LzMxB1c5onTMl2r5F4PdQh6p/w6fLVw5z7vddyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+G34p2QVo18qpAFqLsvY0yFSYdK+XI1qTdUfvWJFOFa22e/AL
	pr0tRU8Hkb1jJzoGDd2mnlHSydmyz7TWLjBi9ykjfCKfhGEiUFfiNP/mQenbD8/lrpyU0CM/O9V
	utv3QdqIJ44ye4EQJkELcn424GvE+7eoAtgD0
X-Gm-Gg: ASbGncvMwBQDWup/rEGht94jVJT4aQ3nYErnmsNxCayaiJQUKGfYxmEMi7NAq5jBZRB
	AgZp1X2z3+vhsZcRLWIDABNOrJVRHcL0+RTUglaBhXfaEr04z1M2D8aj62jqF3l5YFk9X4U3FjP
	gmGK5GK1W+jCRgoTLkyoTqxPfqAA==
X-Google-Smtp-Source: AGHT+IGCSvzTLVJbZTlsgEcGeITrM+ZPQa5PiZLrqW6dw/cEt6aJAAMsg21OT3L1vkCMraFX1Ys9mirDTc4syuaA8mM=
X-Received: by 2002:ac8:5f95:0:b0:476:ff0d:ed6c with SMTP id
 d75a77b69052e-479310aa684mr110266311cf.40.1744024882689; Mon, 07 Apr 2025
 04:21:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403203619.36648-1-kuniyu@amazon.com>
In-Reply-To: <20250403203619.36648-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Apr 2025 13:21:11 +0200
X-Gm-Features: ATxdqUGL77PiWGRjRLcx9J9ZyqpR6P-RpxxvsJoKF9g0EDuwDxExG5vZK153Z-8
Message-ID: <CANn89iKc_7RNordD-YcZv9DPw8CNubnDVkhgYGma20q4cxgAdw@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: Fix null-ptr-deref by sock_lock_init_class_and_name()
 and rmmod.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steve French <sfrench@samba.org>, 
	Enzo Matsumiya <ematsumiya@suse.de>, Wang Zhaolong <wangzhaolong1@huawei.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 10:36=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> When I ran the repro [0] and waited a few seconds, I observed two
> LOCKDEP splats: a warning immediately followed by a null-ptr-deref. [1]
>
> Reproduction Steps:
>
>   1) Mount CIFS
>   2) Add an iptables rule to drop incoming FIN packets for CIFS
>   3) Unmount CIFS
>   4) Unload the CIFS module
>   5) Remove the iptables rule
>
> At step 3), the CIFS module calls sock_release() for the underlying
> TCP socket, and it returns quickly.  However, the socket remains in
> FIN_WAIT_1 because incoming FIN packets are dropped.
>
> At this point, the module's refcnt is 0 while the socket is still
> alive, so the following rmmod command succeeds.
>
>   # ss -tan
>   State      Recv-Q Send-Q Local Address:Port  Peer Address:Port
>   FIN-WAIT-1 0      477        10.0.2.15:51062   10.0.0.137:445
>
>   # lsmod | grep cifs
>   cifs                 1159168  0
>
> This highlights a discrepancy between the lifetime of the CIFS module
> and the underlying TCP socket.  Even after CIFS calls sock_release()
> and it returns, the TCP socket does not die immediately in order to
> close the connection gracefully.
>
> While this is generally fine, it causes an issue with LOCKDEP because
> CIFS assigns a different lock class to the TCP socket's sk->sk_lock
> using sock_lock_init_class_and_name().
>
> Once an incoming packet is processed for the socket or a timer fires,
> sk->sk_lock is acquired.
>
> Then, LOCKDEP checks the lock context in check_wait_context(), where
> hlock_class() is called to retrieve the lock class.  However, since
> the module has already been unloaded, hlock_class() logs a warning
> and returns NULL, triggering the null-ptr-deref.
>
> I
>
> Fixes: ed07536ed673 ("[PATCH] lockdep: annotate nfs/nfsd in-kernel socket=
s")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: stable@vger.kernel.org
> ---
> v2:
>   * Clear sk_owner in sock_lock_init()
>   * Define helper under the same #if guard
>   * Remove redundant null check before module_put()
>
> v1: https://lore.kernel.org/netdev/20250403020837.51664-1-kuniyu@amazon.c=
om/
> ---
>  include/net/sock.h | 38 ++++++++++++++++++++++++++++++++++++--
>  net/core/sock.c    |  4 ++++
>  2 files changed, 40 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 8daf1b3b12c6..4216d7d86150 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -547,6 +547,10 @@ struct sock {
>         struct rcu_head         sk_rcu;
>         netns_tracker           ns_tracker;
>         struct xarray           sk_user_frags;
> +
> +#if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
> +       struct module           *sk_owner;
> +#endif
>  };
>
>  struct sock_bh_locked {
> @@ -1583,6 +1587,35 @@ static inline void sk_mem_uncharge(struct sock *sk=
, int size)
>         sk_mem_reclaim(sk);
>  }
>
> +#if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
> +static inline void sk_owner_set(struct sock *sk, struct module *owner)
> +{
> +       __module_get(owner);
> +       sk->sk_owner =3D owner;
> +}
> +
> +static inline void sk_owner_clear(struct sock *sk)
> +{
> +       sk->sk_owner =3D NULL;
> +}
> +
> +static inline void sk_owner_put(struct sock *sk)
> +{
> +       module_put(sk->sk_owner);
> +}
> +#else
> +static inline void sk_owner_set(struct sock *sk, struct module *owner)
> +{
> +}
> +
> +static inline void sk_owner_clear(struct sock *sk)
> +{
> +}
> +
> +static inline void sk_owner_put(struct sock *sk)
> +{
> +}
> +#endif
>  /*
>   * Macro so as to not evaluate some arguments when
>   * lockdep is not enabled.
> @@ -1592,13 +1625,14 @@ static inline void sk_mem_uncharge(struct sock *s=
k, int size)
>   */
>  #define sock_lock_init_class_and_name(sk, sname, skey, name, key)      \
>  do {                                                                   \
> +       sk_owner_set(sk, THIS_MODULE);                                  \
>         sk->sk_lock.owned =3D 0;                                         =
 \
>         init_waitqueue_head(&sk->sk_lock.wq);                           \
>         spin_lock_init(&(sk)->sk_lock.slock);                           \
>         debug_check_no_locks_freed((void *)&(sk)->sk_lock,              \
> -                       sizeof((sk)->sk_lock));                         \
> +                                  sizeof((sk)->sk_lock));              \
>         lockdep_set_class_and_name(&(sk)->sk_lock.slock,                \
> -                               (skey), (sname));                        =
       \
> +                                  (skey), (sname));                    \
>         lockdep_init_map(&(sk)->sk_lock.dep_map, (name), (key), 0);     \
>  } while (0)
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 323892066def..d426c5f8e20f 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2130,6 +2130,8 @@ int sk_getsockopt(struct sock *sk, int level, int o=
ptname,
>   */
>  static inline void sock_lock_init(struct sock *sk)
>  {
> +       sk_owner_clear(sk);
> +
>         if (sk->sk_kern_sock)
>                 sock_lock_init_class_and_name(
>                         sk,
> @@ -2324,6 +2326,8 @@ static void __sk_destruct(struct rcu_head *head)
>                 __netns_tracker_free(net, &sk->ns_tracker, false);
>                 net_passive_dec(net);
>         }
> +
> +       sk_owner_put(sk);

I am not convinced that the socket lock can be used after this point,
now or in the future.

>         sk_prot_free(sk->sk_prot_creator, sk);
>  }

Maybe move this in sk_prot_free() instead ?

diff --git a/net/core/sock.c b/net/core/sock.c
index 323892066def..9ab149d1584c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2226,6 +2226,9 @@ static void sk_prot_free(struct proto *prot,
struct sock *sk)
        cgroup_sk_free(&sk->sk_cgrp_data);
        mem_cgroup_sk_free(sk);
        security_sk_free(sk);
+
+       sk_owner_put(sk);
+
        if (slab !=3D NULL)
                kmem_cache_free(slab, sk);
        else

