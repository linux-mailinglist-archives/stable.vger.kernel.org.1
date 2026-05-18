Return-Path: <stable+bounces-249333-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id W8/sN1w+C2pQFAUAu9opvQ
	(envelope-from <stable+bounces-249333-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:29:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1C3570EA9
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 110F1304640D
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 16:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A200480963;
	Mon, 18 May 2026 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="avu0BJwD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB0344E02A
	for <stable@vger.kernel.org>; Mon, 18 May 2026 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779121133; cv=pass; b=P/ewAggWR4bG0EQi88P+YSPqaCfusAN44JNiHrMsCESBmwRdeoshT8LU55Vv+/lFLOraaCFx04TRa+dKibfJgdNV5yfqty2ET5RE7i4HGmDDadNVROL6SM/6iCQUGmSsKYii2X71kNXaiS3RLV2MQ134wbfNlQViH3rHCqTJBR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779121133; c=relaxed/simple;
	bh=mATkwyC8CsfmbtEjXmliiX1cfrfLq4a/zwucAwJrrMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1M0GXBfAmB3MxZMhcJdSh00s+zlIfV1TcyA6Bkldb8dhOfxMndsgN8wruu/xc7iyBA+pHeQtDZh5E1JIvr1RfebU7qZMUqZ3+38x8oxFUixsi5TAKbW1oGEpkanZGON9mf0pLALNl0ABIsyKyhhxuDJcj1nmB3+4nNXJ2eZBLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=avu0BJwD; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-671588ab0cfso379a12.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 09:18:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779121125; cv=none;
        d=google.com; s=arc-20240605;
        b=WTOtlQjf5b79/0kqywkqdDnQsZByan5jwP14m0Qg8sj3mI0cVN0DqTMZC+RGhb/lue
         M+ZMIgY0OJbF/rTYyuHWKRhe7QjC7r9bBWfeQWthDpleBXG1T6uT+0t81YdNDV8z2xcA
         wAoJ52NKEuOzxUEok2A/hEdqXkbuDngE7kjzKg7dyI/FXWaap4rvnZu0vv1c/54PPRc5
         0eRelCtFGvTwpXngf1bW16mhw1WgeXtfcroKKwkbTUxITQWksSt3536SzBlVeqBiZ5SD
         kcWwc5465W03P/90hBFcZiwExARND2t2EPd680MQoLVLrXfLXLRnYJsr+ELrnYu9LTKM
         +9FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Liio1b6VDv5RScP6X+DOlI3EAYq4cFP5JNSZNtRc1oU=;
        fh=t1+iTbkP+4WQs9FjCtd55XDKmOBv740kr3DyjGvIbMI=;
        b=Jfqw2hnaVmWT5KHnyRjHfb8r7m/wnDqTzG5565MScla7SCZUAIvsg2NMUdyQWwVZoB
         5VdkSx6XfDgqrOQG+GyKr3S6mV+jQPhAovZiGHSdokFdAah9srKyAyau7EGj8YIEQf54
         OcQ9wcIi+IkFJ2vM1PXcf9uQTRuZHgIBarwYxZpZ43zd8q8h1RXTISRNi0z73+1dRmx0
         w4IVqDBt6OUjfDsZwMjXpN2ZdU9GmYN3iNgGbop8nH5SuVqUmH9qEcu3ihUnD/FGNL3M
         dx9Xw5Zze13LCCG+KN+/HnlW0bOjAtpN241vlkj43uVAVCcAgNN7SWTphSZSDIjmAJIf
         wTXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779121125; x=1779725925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Liio1b6VDv5RScP6X+DOlI3EAYq4cFP5JNSZNtRc1oU=;
        b=avu0BJwDBgBEO8lQSkc/1hffUI3CsBJxP2u/6vcvB8cQYAr6Hk/wveAp5i5YOAoXPi
         lbh6bGQM9f3o3k5KRIoi2SyJdUTGLmLtkKGM9Ze20e9Hmz0hi6lAIn3W6JZhAP9RIP2m
         pcotPfL4MasHRZaVZ6hfNzixxTDMH0dOMgY2gmiwMl4mjLD1iPdZh0kYe4ppxrX5febC
         E8E4Qzwxj53nTaSj4S1QupzQHLzbDrP7x9S3d87Wy0dlJlFKsVgIPpJCJAUDBYVKOpfr
         9ZtiyLGEjVhxo1sK4HAwzS9ZPpIbPukMhoGsvJOc7zmsDBaOqnXJtJVKApO4J5U9c1G6
         Bjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779121125; x=1779725925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Liio1b6VDv5RScP6X+DOlI3EAYq4cFP5JNSZNtRc1oU=;
        b=L8lM4P8zfN32WQVRGuwpX1UvtbHHD4f8K3/aiMG/iz2KZmVel9AIaWlf5DOcxRqCYL
         QG7WhpxUc6QDhGYyf44iqTx2ecBUQcKF+FnLe9hyxVFHz5EXV1MGA24qpR0ygBLAWO7L
         7v2kGuDjn3+lJOBf13xlwHrFNVa2lX2Ykf6HRWikboEMI4hqXYiaFEbuBp8rnltuuXev
         mHZdTyBNkVvYFHevxxWD0DxaRushgbmBYbz5ajOR2Avj8UZZQfs96dQz5SuNbEAvRIQW
         Tm2el/LPTg69/SEiRp+ZsaY2RXlaoiA7Yo33FVwMPk1+EpPig223E4/TP7MtttFj95Y8
         aBeA==
X-Forwarded-Encrypted: i=1; AFNElJ95NmR6DN7JSssf0m/OPpt9p4eZNKAsOJEDni2SQvF5Gp4hrdlFEECoeg9F7u84zpb0y3wm3Ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YymRw/PlZjmeWPccxkhikB5zhkCn8VonEUckF5jLnx0I7xBZ4qo
	yXmRyXgLKs5LisfsY2285F6uGCRGXmUcebSLN+pRYZXURSLIKbnIu/Pcu9khkpJCGrBHQQT7V5K
	6H5J0VMnLk1iSzAxU8GKzgB39XvRl5csCt1gNhjLH
X-Gm-Gg: Acq92OEwa5/G9KfJ5rOPRTOsUMLI63by+NKXaOpSOLHumNg3QKQa1fyvTFeD3k1p4qb
	t2Q6NFEvMKwIK7hUOJM17VKCtBctLQwqNKMcDW8L30eo2sDygqRQehJvOeBEBL1CknEksOVStqW
	QFlNc3i/8lGtb379BYVjllhQAeHqiE/Hi5JgSzTqXl6WHTzpL2tmK5qGNeUCrQKXrsF2GjUJW+G
	lf2Bp1ll5o9MzS+yFsuUmXYC+BgUb1ygZVlPyXd6Wh3GyiL1meUZIQGbYa9/vpqpAlEo9hULoq1
	EKdXslf09yor728BDnkIpY5tLP/NEJu1OQHcu12j1Uy+4yk=
X-Received: by 2002:a05:6402:4c9:b0:678:8834:1b49 with SMTP id
 4fb4d7f45d1cf-684985e96ebmr76245a12.1.1779121124779; Mon, 18 May 2026
 09:18:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515-unix-recv-wait-v1-0-76adb5f063d5@google.com>
 <20260515-unix-recv-wait-v1-1-76adb5f063d5@google.com> <CAAVpQUDJa0=h+iFqr6ZEJ72b5nYTX3Ay-Vbkk0-7Y-KZB_3SBg@mail.gmail.com>
In-Reply-To: <CAAVpQUDJa0=h+iFqr6ZEJ72b5nYTX3Ay-Vbkk0-7Y-KZB_3SBg@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 18 May 2026 18:18:08 +0200
X-Gm-Features: AVHnY4JEW223kfoVSQDlfwCDKkPQOQR08O4FxFyX9fT-m-RsU3KiMfxz6iu40fQ
Message-ID: <CAG48ez08P0mRcbdiYAZaQCmbG-OcN8JZYT72wkC77zXHn1BV7A@mail.gmail.com>
Subject: Re: [PATCH 1/3] af_unix: Fix UAF read of tail->len in unix_stream_data_wait()
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Hannes Frederic Sowa <hannes@stressinduktion.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-249333-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 5C1C3570EA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 17, 2026 at 9:21=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
> On Fri, May 15, 2026 at 11:54=E2=80=AFAM Jann Horn <jannh@google.com> wro=
te:
> > unix_stream_data_wait() does skb_peek_tail(&sk->sk_receive_queue) witho=
ut
> > holding any lock that prevents SKBs on that queue from being dequeued a=
nd
> > freed.
> > This has been the case since commit 79f632c71bea ("unix/stream: fix
> > peeking with an offset larger than data in queue").
> > The first consequence of this is that the pointer comparison
> > `tail !=3D last` can be false even if `last` semantically refers to an
> > already-freed SKB while `tail` is a new SKB allocated at the same addre=
ss;
> > which can cause unix_stream_data_wait() to wrongly keep blocking after =
new
> > data has arrived, but only in a weird scenario where a peeking recv() a=
nd
> > a normal recv() on the same socket are racing, which is probably not a
> > real problem.
> >
> > But since commit 2b514574f7e8 ("net: af_unix: implement splice for stre=
am
> > af_unix sockets"), `tail` is actually dereferenced, which can cause UAF=
 in
> > the following race scenario (where test_setup() runs single-threaded,
> > and afterwards, test_thread1() and test_thread2() run concurrently in
> > two threads:
> > ```
> > static int socks[2];
> > void test_setup(void) {
> >   socketpair(AF_UNIX, SOCK_STREAM, 0, socks);
> >   send(socks[1], "A", 1, 0);
> >   int peekoff =3D 1;
> >   setsockopt(socks[0], SOL_SOCKET, SO_PEEK_OFF, &peekoff, sizeof(peekof=
f));
> > }
> > void test_thread1(void) {
> >   char dummy;
> >   recv(socks[0], &dummy, 1, MSG_PEEK);
> > }
> > void test_thread2(void) {
> >   char dummy;
> >   recv(socks[0], &dummy, 1, 0);
> >   shutdown(socks[1], SHUT_WR);
> > }
> > ```
> >
> > when racing like this:
> > ```
> > thread1                       thread2
> > unix_stream_read_generic
> >   mutex_lock(&u->iolock)
> >   skb_peek(&sk->sk_receive_queue)
> >   skb_peek_next(skb, &sk->sk_receive_queue)
> >   mutex_unlock(&u->iolock)
> >                               unix_stream_read_generic
> >                                 unix_state_lock(sk)
> >                                 skb_peek(&sk->sk_receive_queue)
> >                                 unix_state_unlock(sk)
> >   unix_stream_data_wait
> >     unix_state_lock(sk)
> >     tail =3D skb_peek_tail(&sk->sk_receive_queue)
> >                                 spin_lock(&sk->sk_receive_queue.lock)
> >                                 __skb_unlink(skb, &sk->sk_receive_queue=
)
> >                                 spin_unlock(&sk->sk_receive_queue.lock)
> >                                 consume_skb(skb) [frees the SKB]
> >     `tail !=3D last`: false
> >     `tail`: true
> >     `tail->len !=3D last_len` ***UAF***
> > ```
> >
> > Fix the UAF by removing the read of tail->len; checking tail->len would
> > only make sense if SKBs in the receive queue of a UNIX socket could gro=
w,
> > which AFAIK is not supposed to happen.
>
> I posted the same patch 2 years ago (and forgot to respin),
> which has the historical context.
> https://lore.kernel.org/netdev/20240530164256.40223-1-kuniyu@amazon.com/
>
> ---8<---
> When commit 869e7c62486e ("net: af_unix: implement stream sendpage
> support") added sendpage() support, data could be appended to the last
> skb in the receiver's queue.
>
> That's why we needed to check if the length of the last skb was changed
> while waiting for new data in unix_stream_data_wait().
>
> However, commit a0dbf5f818f9 ("af_unix: Support MSG_SPLICE_PAGES") and
> commit 57d44a354a43 ("unix: Convert unix_stream_sendpage() to use
> MSG_SPLICE_PAGES") refactored sendmsg(), and now data is always added
> to a new skb.
> ---8<---

Ah, thanks, I will integrate that context in the commit message.

> > Fixes: 2b514574f7e8 ("net: af_unix: implement splice for stream af_unix=
 sockets")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jann Horn <jannh@google.com>
>
> Can you post this patch separately to net.git by specifying
> [PATCH net v2] in Subject ?

Will do.

