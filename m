Return-Path: <stable+bounces-249147-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBiOKE4VCmrgwgQAu9opvQ
	(envelope-from <stable+bounces-249147-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 21:21:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2243356381F
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 21:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EBCD301739A
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 19:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3971313543;
	Sun, 17 May 2026 19:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qc+vGuQO"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB16E2E975E
	for <stable@vger.kernel.org>; Sun, 17 May 2026 19:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779045697; cv=pass; b=aeaKPSjJmYyx+ACzLRd7BB0QUgAC+USa2zSrzW29F+tly1Pl6faIHElYVNTgpl+laqUB5hoCFhP9rr+Pgm2zygV+waWJ8kEUmt9SpoaElIhee6rSTqVylIoFy/p3rCOCfGl8UOJQYM0VIlhXJtAh59ZHS5OijcrMtr5+Jifgt4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779045697; c=relaxed/simple;
	bh=1v/XXWFyX1CrqrfCcNCeDqucdVkXIMDW9YfLgDAaYcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvFiBq0mXcsn16Js6ioULVIEoDN1jdge2evNB4+6y9P3h3YfCD0JNIxFmhfAvkprEzKaZB6iSZBYhkmgYGf6Yz3pn5ANwJdCObmrrmsNnaugnlaBZTP13PO15wwxjWcu+OB3Q09TClCOk0QegB77kblnZvZ+J+gdm2LHXtUtrDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qc+vGuQO; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-132c338a537so1667057c88.0
        for <stable@vger.kernel.org>; Sun, 17 May 2026 12:21:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779045694; cv=none;
        d=google.com; s=arc-20240605;
        b=kNMsSICVLaRbeE1hw9LN/YAJ12rBfmCezCvnoRg+gg1i9ntrQD19dAnM+NhC3fJ2tC
         z9ORbxmkPyd0dn050HZL7UDcfQAugV+bOe6OMUvaNxZuxNWJTCgZTx7ofgNSC3TQjyeT
         EAl8SodSnttwYhWnpQJ5fsysfhInQhSQFT4HzdfSerZw0x/g2WWCEm/vH8Gt2z/KpxaL
         +PP/q8DoUn78vUjaqRnYJh6jcT+nhR1J91JN+BPu/9k2lD8flETnjyp7w4NL+9eMcswK
         VDaHwiB6a/w/runx6zQCSuZLS6bvtAp/ug0jYKWbi3L66DQgj++5P5rzcjDvUVVdTnPS
         f27Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T/H79crIpuSG0oi0/XtyKYx+m0KERxP5FdagFIM7P28=;
        fh=+kMip26XOoZYAV+dGeEppKCdwgycktI/DwXKGimTFaQ=;
        b=XgR7AuRqcfxEsbwZvEIVFAG0N5aod8ZDF7RyIReikHrQWNILa+Wac0KuYZM5e2Rbku
         3bZ6dH7Tj5xHTMCZmCOiBt+Zq/7Ol4hCv1y+/aVgM08Y3aHI1OdNB+luOXYwDcygfZkJ
         mKk3/u2RM9sVsZ51Bh5m3bGoHGiwj2RHYpsLE2cUvGPxKOt2Sq4APVDj9PfBWO0FgOEz
         +lbMahosu++3MTUEdZtfCYfWUVMi2eNQdNRMAPEns9cNQ3//+KxTQPaqeKv9PfByRw8K
         llkFe8iQSKJwq8isY/0ahElcdEqb1ZVuZ0NMP8ZUFiqZOsnMTePgMhA7QZKLAAcm94xm
         mmRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779045694; x=1779650494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/H79crIpuSG0oi0/XtyKYx+m0KERxP5FdagFIM7P28=;
        b=qc+vGuQOWP9Prkuk4uvVJs2FeLMDAJobrq7kCCd53I1nGQFiHME0CKBj+1D6cygKiD
         Xp71H5z0FQg8QEC2zbSz3M3YjQRyQ+d2mPILxItGMA225HAaYqN0gAjYpXtr8Kz8qYOJ
         ozrueSpBEhMgfS7XFWLFWpgej1+XhglwssbQft9yKypf83rxZvjxc9gAz9dvBRwE+KtW
         Cu/6gLzYcdBNieNSkkXcqZ+yDHkUgfXH/OVag4wpu1ytF8TeXuRAh2VpasuFB4Y9CxtA
         QrgAy3of9EzCHEL3ULx3PuuJqlKAQIVRxwMy6LsPd6ojX+xGSb82kOdBKyU2oef31rX5
         ZxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779045694; x=1779650494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T/H79crIpuSG0oi0/XtyKYx+m0KERxP5FdagFIM7P28=;
        b=PoKGN3+ebDpbOqDphToxPAWE3rZ8VsvOTBQpBBWAbhQqGXOnNm9mzC1TVbKudnkw+3
         eLODI+b0KH1H9FdZet3c2uylGQQH+7eMKaJh4KlZ2yoQLf8W+JTeKhucIrQjqRAQqcum
         n7J7y4L5uPFg3d8RiLi1iGCsrEI4X/4+v9ptpfYInDb0cRoNda126/+c4O7f4+S7Cvk7
         PGbJRFoRwKM0g0Qfe7SgU/0HMC1lHE8rnHBSP1vTFPc0fd9oWLSPQ/Ox+q+L8nI4Gn4L
         IGOlJjwwcl+knIUVHX+pbza1ohd7Aj9Rc8xpY3rsdZ5Tji2Bjzv5XFouLPWcW152JH0A
         AnUQ==
X-Forwarded-Encrypted: i=1; AFNElJ+fcgfIbxV9NVzxm3RBSGrGwQGQGOffFqRmDdvleKF72VFvQ0hmRWJb/LMsnhn7/TIJItUbSEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxNjz9PBtcjMVlb8mdAZYz0Cx5IULcmGR78+w5PjpJN8MMqI6v
	UKqO/kEfDAZVUW3CIF5rVyYnzl3TyY16kQ2KpnxK6Vla8sWm0j8lhVi5t0Cn0sjO1ktus4vw52W
	U3KyEaWFtqV5zJfgsZWFLxIoeRJdYe1pc+w0fg1Qi
X-Gm-Gg: Acq92OHSniX5+fiGDPyqk1vmvHdHvMhOWlER/76miJDgqFaerlGcDMPsiUltxF+czX4
	o39f3IbX0bKSSc9fb4C16KRmKd/nCvUAD1UpA85Ok4IfPyaxaLMFxqR91sRDT/HpmlRi2c7y6Lc
	O1UTrwKaRNO7gVQErPSxSEZPSt57ZC6Fkk0pjqo5nax7y/qGRv/iJAHnuiwOxnOsy3PNzmSMZt3
	kFwVCBPmPjE1mVI/aBoij24n0GxXzDQrTwgPkSsTYVwCns2AIygVZWOqSD4JfYma0kjFIYFjeGX
	YFwtF2afoNNg4nTXDo3YqDQ/PEzLFDp0mXZOz7sECWNZ5RL0OVGS1IROioZSkUiey1qwmTT8Nkh
	VZshhH6tlZ7LC3kgOOL/ALAyaqjjdY20=
X-Received: by 2002:a05:7022:128d:b0:12d:b8e5:5e2 with SMTP id
 a92af1059eb24-134c8d4f477mr7482953c88.23.1779045693291; Sun, 17 May 2026
 12:21:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515-unix-recv-wait-v1-0-76adb5f063d5@google.com> <20260515-unix-recv-wait-v1-1-76adb5f063d5@google.com>
In-Reply-To: <20260515-unix-recv-wait-v1-1-76adb5f063d5@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 17 May 2026 12:21:22 -0700
X-Gm-Features: AVHnY4JBNg0xjLVUNScPxVzZN0nh0saT-xFzCCVwtR1do4uoeNLyD5M3cMYb7hI
Message-ID: <CAAVpQUDJa0=h+iFqr6ZEJ72b5nYTX3Ay-Vbkk0-7Y-KZB_3SBg@mail.gmail.com>
Subject: Re: [PATCH 1/3] af_unix: Fix UAF read of tail->len in unix_stream_data_wait()
To: Jann Horn <jannh@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Hannes Frederic Sowa <hannes@stressinduktion.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2243356381F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249147-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 11:54=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
>
> unix_stream_data_wait() does skb_peek_tail(&sk->sk_receive_queue) without
> holding any lock that prevents SKBs on that queue from being dequeued and
> freed.
> This has been the case since commit 79f632c71bea ("unix/stream: fix
> peeking with an offset larger than data in queue").
> The first consequence of this is that the pointer comparison
> `tail !=3D last` can be false even if `last` semantically refers to an
> already-freed SKB while `tail` is a new SKB allocated at the same address=
;
> which can cause unix_stream_data_wait() to wrongly keep blocking after ne=
w
> data has arrived, but only in a weird scenario where a peeking recv() and
> a normal recv() on the same socket are racing, which is probably not a
> real problem.
>
> But since commit 2b514574f7e8 ("net: af_unix: implement splice for stream
> af_unix sockets"), `tail` is actually dereferenced, which can cause UAF i=
n
> the following race scenario (where test_setup() runs single-threaded,
> and afterwards, test_thread1() and test_thread2() run concurrently in
> two threads:
> ```
> static int socks[2];
> void test_setup(void) {
>   socketpair(AF_UNIX, SOCK_STREAM, 0, socks);
>   send(socks[1], "A", 1, 0);
>   int peekoff =3D 1;
>   setsockopt(socks[0], SOL_SOCKET, SO_PEEK_OFF, &peekoff, sizeof(peekoff)=
);
> }
> void test_thread1(void) {
>   char dummy;
>   recv(socks[0], &dummy, 1, MSG_PEEK);
> }
> void test_thread2(void) {
>   char dummy;
>   recv(socks[0], &dummy, 1, 0);
>   shutdown(socks[1], SHUT_WR);
> }
> ```
>
> when racing like this:
> ```
> thread1                       thread2
> unix_stream_read_generic
>   mutex_lock(&u->iolock)
>   skb_peek(&sk->sk_receive_queue)
>   skb_peek_next(skb, &sk->sk_receive_queue)
>   mutex_unlock(&u->iolock)
>                               unix_stream_read_generic
>                                 unix_state_lock(sk)
>                                 skb_peek(&sk->sk_receive_queue)
>                                 unix_state_unlock(sk)
>   unix_stream_data_wait
>     unix_state_lock(sk)
>     tail =3D skb_peek_tail(&sk->sk_receive_queue)
>                                 spin_lock(&sk->sk_receive_queue.lock)
>                                 __skb_unlink(skb, &sk->sk_receive_queue)
>                                 spin_unlock(&sk->sk_receive_queue.lock)
>                                 consume_skb(skb) [frees the SKB]
>     `tail !=3D last`: false
>     `tail`: true
>     `tail->len !=3D last_len` ***UAF***
> ```
>
> Fix the UAF by removing the read of tail->len; checking tail->len would
> only make sense if SKBs in the receive queue of a UNIX socket could grow,
> which AFAIK is not supposed to happen.

I posted the same patch 2 years ago (and forgot to respin),
which has the historical context.
https://lore.kernel.org/netdev/20240530164256.40223-1-kuniyu@amazon.com/

---8<---
When commit 869e7c62486e ("net: af_unix: implement stream sendpage
support") added sendpage() support, data could be appended to the last
skb in the receiver's queue.

That's why we needed to check if the length of the last skb was changed
while waiting for new data in unix_stream_data_wait().

However, commit a0dbf5f818f9 ("af_unix: Support MSG_SPLICE_PAGES") and
commit 57d44a354a43 ("unix: Convert unix_stream_sendpage() to use
MSG_SPLICE_PAGES") refactored sendmsg(), and now data is always added
to a new skb.
---8<---


>
> Fixes: 2b514574f7e8 ("net: af_unix: implement splice for stream af_unix s=
ockets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>

Can you post this patch separately to net.git by specifying
[PATCH net v2] in Subject ?

The later patches are net-next material.

