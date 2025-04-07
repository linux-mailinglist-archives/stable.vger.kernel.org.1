Return-Path: <stable+bounces-128582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794B4A7E581
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8800C442DB0
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 15:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A8B2066F4;
	Mon,  7 Apr 2025 15:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="U2EGV97b"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5272B204694;
	Mon,  7 Apr 2025 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041143; cv=none; b=u3CC5K5vQRDbjuo+QGmWvQzd+RER8lu+syPOmNjtXLRBKOp4xNjsaJDc99aTd0/USc5bTmN2yQkOtJhsIB9qpjwOeUeAIt+lYIH8sRNi68SulNpuNpTOqIxraj2/UYSsJrYy+BklYRc6NePDQzX+whjr22RjgccHOFjs0dif+eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041143; c=relaxed/simple;
	bh=RO9vA3rEiMpXY2A/myUPJ8wWD9WvtX3M47OGtLYdyvk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZmQyoscEK62h7NMukfvE7w9wbAUfe2TEmG2+U9q1ZF2xO0EAXU1fpn2ikzKj12fQ+8rIrw7kB0tTN0pgNmZnfNE+SQgWx6sAd27tUHMCU5+2XprD+dtA+t1+xClYkdFltxlyLqWrh2gPFVTGHpTKtDpYb8qnUlEwPRNdFR3A4Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=U2EGV97b; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744041139; x=1775577139;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3kLBT+4Y+IiY2wVdsPc5x6Fuj1savLAG8Rp99+8Cz/Y=;
  b=U2EGV97bamTA5gVvu2Km6Ei228VXQkqFFk3C9/09GOMhPxAOhYs5bFpG
   I2bB1MAKh46DA8RJroibOJUv6fjyusCj4SzaGqcsKjPSpqkGjzYPFs0Ha
   dovr8gxr+YkBm7lWF1FhZHNygXRjQ3oaje6+V58iSjMPdwkTaCoulLu9h
   s=;
X-IronPort-AV: E=Sophos;i="6.15,194,1739836800"; 
   d="scan'208";a="188970982"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 15:52:17 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:46015]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.57:2525] with esmtp (Farcaster)
 id f69cf136-479c-4502-a43c-d0c57a16572b; Mon, 7 Apr 2025 15:52:16 +0000 (UTC)
X-Farcaster-Flow-ID: f69cf136-479c-4502-a43c-d0c57a16572b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 15:52:16 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 15:52:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <ematsumiya@suse.de>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <peterz@infradead.org>,
	<sfrench@samba.org>, <stable@vger.kernel.org>, <wangzhaolong1@huawei.com>,
	<willemb@google.com>
Subject: Re: [PATCH v2 net] net: Fix null-ptr-deref by sock_lock_init_class_and_name() and rmmod.
Date: Mon, 7 Apr 2025 08:52:02 -0700
Message-ID: <20250407155204.16501-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <CANn89iKc_7RNordD-YcZv9DPw8CNubnDVkhgYGma20q4cxgAdw@mail.gmail.com>
References: <CANn89iKc_7RNordD-YcZv9DPw8CNubnDVkhgYGma20q4cxgAdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Apr 2025 13:21:11 +0200
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 323892066def..d426c5f8e20f 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -2130,6 +2130,8 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
> >   */
> >  static inline void sock_lock_init(struct sock *sk)
> >  {
> > +       sk_owner_clear(sk);
> > +
> >         if (sk->sk_kern_sock)
> >                 sock_lock_init_class_and_name(
> >                         sk,
> > @@ -2324,6 +2326,8 @@ static void __sk_destruct(struct rcu_head *head)
> >                 __netns_tracker_free(net, &sk->ns_tracker, false);
> >                 net_passive_dec(net);
> >         }
> > +
> > +       sk_owner_put(sk);
> 
> I am not convinced that the socket lock can be used after this point,
> now or in the future.
> 
> >         sk_prot_free(sk->sk_prot_creator, sk);
> >  }
> 
> Maybe move this in sk_prot_free() instead ?

Makes sense.
Will move sk_owner_put() to sk_prot_free() in v3.

Thanks!


> 
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 323892066def..9ab149d1584c 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2226,6 +2226,9 @@ static void sk_prot_free(struct proto *prot,
> struct sock *sk)
>         cgroup_sk_free(&sk->sk_cgrp_data);
>         mem_cgroup_sk_free(sk);
>         security_sk_free(sk);
> +
> +       sk_owner_put(sk);
> +
>         if (slab != NULL)
>                 kmem_cache_free(slab, sk);
>         else

