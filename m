Return-Path: <stable+bounces-249387-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGqtBQ9oC2qnHAUAu9opvQ
	(envelope-from <stable+bounces-249387-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:27:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A3B572DDC
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D12AE3031CC2
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 19:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5711138F233;
	Mon, 18 May 2026 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nBv4RbjX"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9EF1DB13A
	for <stable@vger.kernel.org>; Mon, 18 May 2026 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779132194; cv=pass; b=aHdOD4/VWDUcD06rTGn7i+4OQC11YljGvFGudB+DH8kr7ftWb5jZ0ostQBLHGqphZ8C3JXz2MsREsEIulbQPbkulov/fhtil6Yv9ivN1b5ImE8yirjIEfu2jf1/Hn6OQ/S7q4nxpf2JMRo2r11g0GHgf1TVUKuZDwRs+S1cGWhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779132194; c=relaxed/simple;
	bh=vS7t0kRAjr09rod4LmZRdHDpcGd/IcycfZRao+wlUlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=raB5BU2MWQeoPOV7xdTuiMA+2qHlmC+fiLjrUhAhbd8iRm010W/eAat4iU2ZgT8sKExDP/G6k2/hHwFLq080s+zBjRJMYZzdOvB6wwHwL1H4diLYwtogvB2DxSWFwF66rPiT862gopUKquYf390cHci+KX+FQHfkyCVD66zvGj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nBv4RbjX; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1329fc4bf77so7065523c88.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 12:23:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779132192; cv=none;
        d=google.com; s=arc-20240605;
        b=KiT3FfCwdeFtNS+u+RYRIyZFlN7yJDOYeNrMBT/iXFOuKRGyVE9xJsTA46YsQ4N5UY
         IVPKlTrn5pebmVWR7Jde4qhE9YIgjEVNbl9eOTz2ZsddZ4JJT2iwpCTUUq0wSrlqbCBc
         1isZrgrU4lrjlqR2mxWJ/lq2mlGev2GxnX8WQ44EQF+4IMOzNfXFSQOoi4dFa1UU+xRX
         hOki9yLFKvrr8FXvsRo38Xm42nYwfhoXfkj9HLMkMLFuI+DvyktkUmV/JVpYgJNEMsNe
         meXuYmg1QW8ZkPPni7OSj7Pad2p1QHpHGYUm8EI1lX+Z8UqVKHKTyfWWfYydYjBdNoT+
         rRQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rQ6SSm9GwbeauaWhdvaHaNjv902/olVUN+4y21OZxQo=;
        fh=pe7OhO4ULfkUrVcULcyhI4yhyHsj0Y+q46e87KviF5s=;
        b=WLjPkschdZFWsGigcTOf0s758ENNTZAbsjpI+DUWFMuqCB8a7w/L3DvvLZ50veGw+u
         XUlFI6UqQ7vxdC7Lx5UKX2PL/Xia++62FR0hTUmSZnozLfo0UnLd2XMmAudOX3kG4EUK
         2VjIbAhU6JZbyOMoqJFCZYKdf5UpXy47kNS2rXr7//Jzvn8fSKjG7g2vWH6y+a4LWsyf
         nrw6MOZFYr0T81KL0+t8RHg9fozdT/DG5BEFxBMr3OX5Mjt6Hg5wb92Ij5tbL5VQ+SxX
         gXtAK99+NWErzjbgzATryCfORaACeWMCfCHAQ40lLr70b5lApei5UQnBbU+xHWlyDbaB
         kTAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779132192; x=1779736992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQ6SSm9GwbeauaWhdvaHaNjv902/olVUN+4y21OZxQo=;
        b=nBv4RbjXRmE7TnMNymmVORfjV22nS2uaTnD/n/n7k/5OePpEosmZ1NWruLm6vMY6B2
         eTKalGwB6njvpMvSO/TiTMYn8iynGhBUuBNyJ0zrbfPiEcyg9yttDmF3xyOTOeAsGzIw
         l5YfoysaxUNsF/cG9t873hdtvhkHgt1hAUmsEja/+FVao5tvWIiKHWDGC9IfL5n0s/hR
         e6zNx7WfKC1+sFKqdMMno4CfzUwV51pnOfNustc66cPOhLO1Y1dsYNf1NLoFr8GVK02B
         s+m14iyd+y237JYBY9uk/oh4KFzRMjZ8mSkIlwwF/HvYczbpq/XapwU5HI5iTtExren9
         ztLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779132192; x=1779736992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rQ6SSm9GwbeauaWhdvaHaNjv902/olVUN+4y21OZxQo=;
        b=VZ65mDsgeXWjPFM/2tG7IX81WrMFlWm5WbuCL1G8ZFqV39b9OD5o4j4E7cX00whZDa
         9E3FreXrCA4g+C1UC1aTDw4JWH2fy8ZPe8HVSBU3UgaGLOaMn6unXqBzaA3out8tCcGS
         JobBPvPzno4xnLch5GkT2TX3N5A3/ELi/2tuI5F2twhUcyUfYgEIYVMDy9BbANndpAUn
         SEh+7sX912B/l9fA7bqd+txqCEhuguNIsxKFjxB+Q/SqeEUBICJHl7NkDefpwRo/K1ro
         CFTw8jSyvgmxvCCMSClPyYL1dM+SqhfRsjxA5SD57KiGt7k6rxs+GWNZulUQLQ4K7ekQ
         d4ag==
X-Forwarded-Encrypted: i=1; AFNElJ99D3fVhM/ES7+grK2SwMocwfp/nQf6JMc42YE0F078ta0wf7JL9lXSKc95C+MwqC1PIoOPUGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcf57XfC3cdf2P1gcnK2DHs87pbpRC6qxLFi3PVw3O5HmvEg6j
	m/7KojI3Hj9DA8feWAz23fd4qhybHQD4dzSwNCzM3GQF+im395laJdpj8eS/ew7QNl3ZROOtblg
	GGvOF8Wehl3I3hU5YHnzV2IZYUDW7yNBfiSt1K9vn
X-Gm-Gg: Acq92OEctUwfIu9ZxMzmN9j4Ib/8vI4AILbt/eLRhFF+hLffVQ66aag4U5yGlER47/0
	zZDvWNuvIk7jH1faioZ/UxzxO/UIXDzQmaQgT2Xf+78qQ4hj84VohhEpvxtuSNa9eLx5NHRL5GW
	6rewzHC0pt6NY2veNa0b6GDPQtu+Y4+jRD4DkMKyYO3enmUHf/7FWE2h64far4vnB/alekWEsHT
	2I6wTibhhkfmKtO8LpUpT9io++KtS572qwrf9zuNoJPXylHOFCr+TDqHg83PuaMsU5U+ZkPBXhe
	gdBiqSL5b638orhCXK3NtXAR7FLN1W+52eY/nRBhrWcu1oC2MGaxn1SNYl3spnDl6jq2kBFOB4V
	krI1rHSGapy6PbivS0EmIroxTe3IFZmT7BWMVpmuHWFTFrUPRxFKePEHzI78=
X-Received: by 2002:a05:7022:1e11:b0:12b:fc21:874d with SMTP id
 a92af1059eb24-1350484e801mr7468645c88.19.1779132191080; Mon, 18 May 2026
 12:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-b4-unix-recv-wait-hotfix-v2-1-83e29ce8ad31@google.com>
In-Reply-To: <20260518-b4-unix-recv-wait-hotfix-v2-1-83e29ce8ad31@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 18 May 2026 12:22:59 -0700
X-Gm-Features: AVHnY4LsKtOPIZP-oDaTngNmJs5H7FpqNGa_FGOaCijUbnrkv-tVkauHd7iASQA
Message-ID: <CAAVpQUC5Qr4FR=7z+suDW6kukpHLMRBW2zhrs98YLHVtHDMTeQ@mail.gmail.com>
Subject: Re: [PATCH net v2] af_unix: Fix UAF read of tail->len in unix_stream_data_wait()
To: Jann Horn <jannh@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-249387-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 72A3B572DDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 9:51=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
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
> which can no longer happen.
>
> Kuniyuki explained:
>
> > When commit 869e7c62486e ("net: af_unix: implement stream sendpage
> > support") added sendpage() support, data could be appended to the last
> > skb in the receiver's queue.
> >
> > That's why we needed to check if the length of the last skb was changed
> > while waiting for new data in unix_stream_data_wait().
> >
> > However, commit a0dbf5f818f9 ("af_unix: Support MSG_SPLICE_PAGES") and
> > commit 57d44a354a43 ("unix: Convert unix_stream_sendpage() to use
> > MSG_SPLICE_PAGES") refactored sendmsg(), and now data is always added
> > to a new skb.
>
> That means this fix is not suitable for kernels before 6.5.
>
> Fixes: 2b514574f7e8 ("net: af_unix: implement splice for stream af_unix s=
ockets")
> Cc: stable@vger.kernel.org # 6.5.x
> Signed-off-by: Jann Horn <jannh@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks !

