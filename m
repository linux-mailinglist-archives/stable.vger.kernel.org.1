Return-Path: <stable+bounces-100449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1669EB5B7
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 17:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE711882D26
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 16:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC281BD9F9;
	Tue, 10 Dec 2024 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODwTq95q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1453E1BDABE;
	Tue, 10 Dec 2024 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847028; cv=none; b=qqmMT9W8KN5gFxT9wrwV4vyI/IIjWLBJA+7qO5YlLld43MWyStwr7f8if26ELQxeiKrowGxtoqW14ZxKmwCG/ZBs6PUP8wHjkP6I8FQBBJ07x1uvpdASw0sYoTx5RH3gvUO4D3P9qp1ipb8D6zETyz1EqlxFWruh8Q6Rh1HDiA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847028; c=relaxed/simple;
	bh=aAV1ttlGf9XkPkPC37hCTTwpTpgbklabITddkLKpu3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1wWfowVcn/ngvR7EjWjPCJFNtpDQnuX9XTitg4JyDFWOydf/3CB6X8XlQruwfoNmtLDwqXcD1Q8YUtO5PAOdq/dGwTJiYP6aVFPp8baFIqOT8QmWU9w8Jm2lOqNYRitdcx6T652SXZ/2xT2I6LQrHiAXZC7hQr5FI3G9/42RlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODwTq95q; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-728ea1573c0so438796b3a.0;
        Tue, 10 Dec 2024 08:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733847026; x=1734451826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nG2ao3wocTl4ojmZx0A0uC7NWJk+M9hRa4s4yysqSkY=;
        b=ODwTq95qyGtVgEuqgS0ilHqQINOY3guU34sTYkLvXBkUq3OijK8q4pl+pcp3OOkfMM
         gYMHAGzo6qXv1CoJsuHdAWvXJsYEA+CV9w7uQWu3ljHOrC8zub4D6bWvxgsyLUQHCyl3
         jBFlYigcVK9gM9FBAI0u9eQfoEJOL3XwkndWZE90rBkeOYjNjwe7HBUtGq68uRp7cvnt
         orTNH6GcMFJe7Jr3GoQRWymV6iZ/B8Np7QJABoyrovFMFWLEwSM8UgoGVgrSwgp/aNzs
         z5juZGBoTgFd8k29z5/n9Wz7xscKplad3oi72fT5ItG7EnJyBsVpS7c4K+QM6FE9tHPE
         ZKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733847026; x=1734451826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nG2ao3wocTl4ojmZx0A0uC7NWJk+M9hRa4s4yysqSkY=;
        b=A6q7r6zh0UJidUu4Ls+e5xpSZ0mP2ZDPPV7q4a6Dj+M3jM95uP2EXm5ozVbAUrsu6U
         wTRCJ1/uT0qOmgnp10qFR8LLqYQfd+ayyN1X4TC3uXofnXdd20ri5a8LNXBszUQm+cgJ
         /1eshvpa1lv6kNPEQFLLC+Nklbj5w5AxY1By9bc1IWHioB7whL9qJgLj328cDPwia2Gm
         9cDjQbZQtOmojOiCYZAM8zaqwPm9XAD6cmYQcjqmij4/hseAp1P1MV4r0yx0zP1jogbm
         TNQEhwlvD23kHsJeoC8A9XtX2UMtcHGvUc86gOjceFYsfs5+A0oPvm22phiz1/BLD2XV
         9+pg==
X-Forwarded-Encrypted: i=1; AJvYcCUWDXdA3Toti3I6G/gOHGjahrCI7D0+UGMxcHK/k9qbtg8oIKEzQoNyZP0CZpg0DiD9vZKP+KXV@vger.kernel.org, AJvYcCVsY8b+P/CVrpnFT7WCc3wB1RAetIuwz52JVa6NEEv3twU5y6FfVkxWHg2YG6jbCdScI61RAg0Q@vger.kernel.org, AJvYcCWMcOkSRESzHPaIj3q28lh9Aq6lkOButOhMvCipFhoSANPfhOS9o02Psq4iklndTXn8Ixyjfz7jCn+Webc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8AU4A5CfQaLs6GxoczVDZlN6uX9y5ttgvDd+BT8g1PInR2CPe
	BEvdl0lQKJRLP6W5HwbZrgaMgeYWSw8IKna0sfYepvJW/yHhoI73
X-Gm-Gg: ASbGncv6hVl6Ny3mNwT/XDYQZ0lNJnGrVIFhPbBTu7tCwlsr9tEvBBxdHTPfhV0wDwz
	kJGF7nFC//14fJ24K956cO0fur/bo1d539YtX+cObZY93c6zPzrLVXSGTO3i4K3wBdY/ZCWQgN5
	NAU37lPG+PHAv2WPwYAXCL+rdpTMTmWOyR9YRQAS46EXbJtmeArycU/YwFtSQAYviW4y/Kxkhox
	mPOZ3hrEiuQuA586t52vVAKfgR/DDJw7lASHK/CEbzPXKCOFSPOviMifLefSKWSFwjc6xR2dXnI
	PWNKX0AfFYD9
X-Google-Smtp-Source: AGHT+IEAkBsbIsMo38CZywg50F4iK7XY9L0JeGmqbkviqzpzFb8HQ1tBYdBVreKjLDfyfZK7ZLEh1w==
X-Received: by 2002:a05:6a20:244f:b0:1e1:bf3d:a190 with SMTP id adf61e73a8af0-1e1bf3da46bmr964419637.30.1733847026107;
        Tue, 10 Dec 2024 08:10:26 -0800 (PST)
Received: from xiberoa (c-76-103-20-67.hsd1.ca.comcast.net. [76.103.20.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725f19a6197sm3432996b3a.198.2024.12.10.08.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:10:25 -0800 (PST)
Date: Tue, 10 Dec 2024 08:10:22 -0800
From: Frederik Deweerdt <deweerdt.lkml@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: David.Laight@ACULAB.COM, davem@davemloft.net, dhowells@redhat.com,
	edumazet@google.com, horms@kernel.org, jdamato@fastly.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org, mhal@rbox.co,
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org,
	xiyou.wangcong@gmail.com
Subject: Re: [PATCH v2 net] splice: do not checksum AF_UNIX sockets
Message-ID: <Z1hn7p4T7_NTVbzN@xiberoa>
References: <Z1fMaHkRf8cfubuE@xiberoa>
 <20241210081721.66479-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210081721.66479-1-kuniyu@amazon.com>

On Tue, Dec 10, 2024 at 05:17:21PM +0900, Kuniyuki Iwashima wrote:
> From: Frederik Deweerdt <deweerdt.lkml@gmail.com>
> Date: Mon, 9 Dec 2024 21:06:48 -0800
> > When `skb_splice_from_iter` was introduced, it inadvertently added
> > checksumming for AF_UNIX sockets. This resulted in significant
> > slowdowns, for example when using sendfile over unix sockets.
> > 
> > Using the test code in [1] in my test setup (2G single core qemu),
> > the client receives a 1000M file in:
> > - without the patch: 1482ms (+/- 36ms)
> > - with the patch: 652.5ms (+/- 22.9ms)
> > 
> > This commit addresses the issue by marking checksumming as unnecessary in
> > `unix_stream_sendmsg`
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Frederik Deweerdt <deweerdt.lkml@gmail.com>
> > Fixes: 2e910b95329c ("net: Add a function to splice pages into an skbuff for MSG_SPLICE_PAGES")
> > ---
> 
> For the future submission, it would be nice to explain changes
> between versions and add the old patch link under '---' here.
> 
Will do, thank you.

> The patch itself looks good to me.
> 
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 

Thanks!
Frederik
> >  net/unix/af_unix.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index 001ccc55ef0f..6b1762300443 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -2313,6 +2313,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
> >  		fds_sent = true;
> >  
> >  		if (unlikely(msg->msg_flags & MSG_SPLICE_PAGES)) {
> > +			skb->ip_summed = CHECKSUM_UNNECESSARY;
> >  			err = skb_splice_from_iter(skb, &msg->msg_iter, size,
> >  						   sk->sk_allocation);
> >  			if (err < 0) {
> > -- 
> > 2.44.1

