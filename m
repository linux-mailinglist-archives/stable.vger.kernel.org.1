Return-Path: <stable+bounces-52101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDFE907CD1
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 21:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3116B1C23E5B
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 19:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A551509A2;
	Thu, 13 Jun 2024 19:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="acDwYpG3"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6610714D6FA;
	Thu, 13 Jun 2024 19:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718307663; cv=none; b=AcbThi9NECnS6z1L8FEua0UyDy6rfBo7TcYOHxloyDv3ClOYCCMeldZvRELuohyWhihOsSZVdoOkhLVOygzQ6ahUvMPhgbanl1AfLC79VNNBxuU+YB+HsBeKoXTc7danI26luWt61MTruhjgN+rjvFpH15F20E+zdGWFx4avhKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718307663; c=relaxed/simple;
	bh=krDJ0efxWuTgHMl52r7hlgXIBjsj6i/SwlWapzZJpyE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T1tEEEsbuVSTdWYM2SYgm6X+j0OuigUvXJAi+5luWWwz/jazDNu6oDzVFEtUIaxflP0gLp/Dp0BxQC6ZtZ+iKjpA9zxzjnPnwWiO4ZrP3EJZUgA8yW0P0yV51zP6mM/rd12kTT9kUIMvWgzBLYZTnBIG6DxENepMuW5eNCSdwuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=acDwYpG3; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718307661; x=1749843661;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NV7Lhmej4Lxe5+Y6UUlma1D1VKEYEqQOtLkFv+lMdpQ=;
  b=acDwYpG3LKqOQUhSL3oxXSBYrCVJj3WhhiwtTlsbOAgCRFU5PjtLlxHw
   sYidVwAUkX++te5PGcouj+qXpvyo4WPxG70SXdD4rL06WAugySum2o3FS
   QDB/hH+kQVoJpqz//looDx8GzL8hyGHO+9iZOljuYQ2xe5iPrEibDsmx2
   Q=;
X-IronPort-AV: E=Sophos;i="6.08,236,1712620800"; 
   d="scan'208";a="302057957"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 19:40:59 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:7470]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.96:2525] with esmtp (Farcaster)
 id a010f6d4-7be5-4303-9392-ad0c8cfe3f17; Thu, 13 Jun 2024 19:40:59 +0000 (UTC)
X-Farcaster-Flow-ID: a010f6d4-7be5-4303-9392-ad0c8cfe3f17
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 13 Jun 2024 19:40:58 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 13 Jun 2024 19:40:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <ignat@cloudflare.com>
CC: <davem@davemloft.net>, <dsa@cumulusnetworks.com>, <dsahern@kernel.org>,
	<edumazet@google.com>, <kernel-team@cloudflare.com>, <kraig@google.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] net: do not leave dangling sk pointer in inet_create()/inet6_create()
Date: Thu, 13 Jun 2024 12:40:47 -0700
Message-ID: <20240613194047.36478-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CALrw=nEVktSeq4HcLqM0VfTrdHCLHeqi71-fKD8+UcBjtoVaBA@mail.gmail.com>
References: <CALrw=nEVktSeq4HcLqM0VfTrdHCLHeqi71-fKD8+UcBjtoVaBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC003.ant.amazon.com (10.13.139.198) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Ignat Korchagin <ignat@cloudflare.com>
Date: Wed, 12 Jun 2024 14:22:36 -0400
> > And curious if bpf_get_socket_cookie() can be called any socket
> > family to trigger the splat.  e.g. ieee802154_create() seems to
> > have the same bug.
> 
> Just judging from the code - yes, indeed.
> 
> > If so, how about clearing sock->sk in sk_common_release() ?
> 
> This was my first thought, but I was a bit put off by the fact that
> sk_common_release() is called from many places and the sk object
> itself is reference counted. So not every call to sk_common_release()
> seems to actually free the sk object.

sk_common_release() is called

  1. when we fail to create a socket (socket() or accept() syscall)
  2. when we release the last refcount of the socket's file descriptor
     (basically close() syscall)

The issue only happens at 1. because we clear sock->sk at 2. in
__sock_release() after calling sock->ops->release().

So, we need not take care of these callers of sk_common_release().

  - inet_release
    - ->close()
      - udp_lib_close
      - ping_close
      - raw_close
      - rawv6_close
      - l2tp_ip_close
      - l2tp_ip6_close
      - sctp_close
  - ieee802154_sock_release
    - ->close()
      - raw_close
      - dgram_close
  - mctp_release
    - ->close()
      - mctp_sk_close
  - pn_socket_release
    - ->close()
      - pn_sock_close
      - pep_sock_close

Then, the rest of the callers are:

  - __sock_create
    - pf->create()
      - inet_create
      - inet6_create
      - ieee802154_create
      - smc_create
        - __smc_create

  - setsockopt(TCP_ULP)
    - smc_ulp_init
      - __smc_create

  - sctp_accept
    - sctp_v4_create_accept_sk
    - sctp_v6_create_accept_sk

we need not care about sctp_v[46]_create_accept_sk() because they don't set
sock->sk for the socket; we don't pass sock to sock_init_data(NULL, newsk)
before calling sk_common_release().

__sock_create() path and SMC's ULP path have the same issue, and
sk_common_release() releases the last refcount of struct sock there.

So, I think we can set NULL to sock->sk in sk_common_release().


> Secondly, I was put off by this
> comment (which I don't fully understand TBH) [1]
> 
> On the other hand - in inet/inet6_create() we definitely know that the
> object would be freed, because we just created that.
> 
> But if someone more familiar with the code confirms it is
> better/possible to do in sk_common_release(), I'm happy to adjust and
> it would be cleaner indeed.
> 
> > ---8<---
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 8629f9aecf91..bbc94954d9bf 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -3754,6 +3754,9 @@ void sk_common_release(struct sock *sk)
> >          * until the last reference will be released.
> >          */
> >
> > +       if (sk->sk_socket)
> > +               sk->sk_socket->sk = NULL;
> > +
> >         sock_orphan(sk);
> >
> >         xfrm_sk_free_policy(sk);
> > ---8<---
> 
> [1]: https://elixir.bootlin.com/linux/v6.10-rc3/source/include/net/sock.h#L1985


