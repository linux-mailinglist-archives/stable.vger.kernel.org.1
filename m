Return-Path: <stable+bounces-238588-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH6hAuWH42nAIAEAu9opvQ
	(envelope-from <stable+bounces-238588-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 15:32:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A411942133F
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 15:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2525C302F274
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 13:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B45037D120;
	Sat, 18 Apr 2026 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqe4POKP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE0837CD3B
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776519074; cv=pass; b=VYrxG9tdlMvq9/QgO4mHhecYbtk3AVPTpak5+hheQyNJ6sS4mtohuEPUx++Z8FoeW3W5kibmINejewussM2FvBOrKK0suQ1fep1Btb52JL/ALmq4Bl0LtF9h58Qu+d0MJF1XUelmUe2Nevnxl7DtC8t9CiiZ2gPRs0Ifekw79LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776519074; c=relaxed/simple;
	bh=bCwZZOAmrkF68yCBfWzlCLDNALt2LE2uQMq0wLsUN6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAWMQFm2VqVC/pkTteGgtmO5wQPclj+1NX4lwNz335546l1uCOCotJHNen2h8GoYOfYJvWA6TkGF5arhJ5c1Dxs/cYf20TB+fBADs2ByJmijjj1RO4oFywscgZ0VzbxZkgwsuOeSnQf6lPqAapodF82SUA9mb9wsusDSqT7JCmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqe4POKP; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso14614375e9.3
        for <stable@vger.kernel.org>; Sat, 18 Apr 2026 06:31:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776519071; cv=none;
        d=google.com; s=arc-20240605;
        b=PE7G7puixgVKEltMd9Gg+fbYtEdRYZxW4Athl58GicKoFZ4peLreCVaLCVNmnsy1hp
         cx5ul1izzc0AoLH8DprsjZDCnSEUS0h6RdnsA1a7FvWE0WQHdjFp2JZ+SVVh9xYNjPwU
         YuYr7Y8FaiNNYwr5N8j1EZr+eatr1/3d+fxhO1LF3vidtJLK3gL5mWCwgj8uxWWU5z+M
         l1kE6S5nUqqW6VAx4NVNlf+GB0fYOxAn6xUlhtRdK0Lr4jrrBgNG3cxS+ykwh0kMBiI9
         hToBhLVox5rqYoKqkrzPFyWh1MQs/Uvn7SHB8Rh1GwGuqELzP2bU3zxoye5OrcerOj8f
         jbtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oPxDtIL/dHAuVmHL3LN6nRPtuUfUzQdagiPbu8rpFsA=;
        fh=wo6A0ekB/CZ/lxYJJEImty708f9dHI36H9Xw8pJk6Bs=;
        b=LRO/GpDQNY5IXAeotLGM0Dr0O2lJ2tKYNdztXpTml+jpz92OoJG7Bb9zwzdkACuXdD
         v1unTsTEKtaWo19u7j3iegrX9eU/KAUt/pRw6LCQxI9uVXbrUvC/SY9XF/EQxH3iSC39
         /vVqIR12XitYQgtAf58e+WSirO3AavWL3H23C6RyiOJioU6ASuSS+bVhKePgPSTWfeaL
         DIae88+cDhG5Gh1wfoyaRNb43phDhBkKccNmrLPbzVqvWd3Ppy8+G6oSYZbHyURnZk6h
         wWCVnQwxVaQigDU0WJiApIo1JY0LRU59gqyXAEtNXGCQ1xCCTTYamshOUSRHBuI9Ug4k
         RQLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776519071; x=1777123871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPxDtIL/dHAuVmHL3LN6nRPtuUfUzQdagiPbu8rpFsA=;
        b=nqe4POKP7hoaHZ8oWFfDPaz142h+NbFtqH1qbrCD9UaeVjceH3DFvvFVb0SZLddFRu
         tdJMv88aj3YnsKkhQg3VuZdHxMbQtDoEhjFy0wGp2Wr3pmxKM6iMX244fjXew+BHThLF
         4GUQOycULtcyXDWRi8XtMUYQ3FyS1nx4/old23+QyBAB1lkd3lpRrNYyTcSD845kYrcP
         SmEEPpWr1NiX+ypuC9YRqKQwxE9D5+QTLF78WVcZyB4834e0X6Z3eWcDLOP0op6JR+jK
         Dg1VOSnAPK9k/KACbDawDVpVIQOSyWXTJkB6kGLN2UzJ5B0GWcLPOYKS8/atD68RQSzb
         b+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776519071; x=1777123871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oPxDtIL/dHAuVmHL3LN6nRPtuUfUzQdagiPbu8rpFsA=;
        b=VR5SYSUVp/920g5aO9aEnuQUkD2NiLWYhB8JysrprH8EY7gVkDfZzcP03QEhDBi8Q7
         naFX2fLZM1TP+f7f2NTcW8SF0YtLGl8mfyp/+XCXFN41dUwUw8YShWLaSB5FxPtU5oOJ
         kXuAPXM6oT0PczTStBlDzWiJeTgo4gYFXs9cls6vInrTh1eNrCm2OYDkTejRbTaavgoc
         fZVfDCeyKghDiXABgUthzGUEhM//01A7a5nheZT+ulADkyIelwjsy40AQhoWDgQfUSwX
         hcELJSFmetHrkppTSaeb46We5TgyKboPWBkYFckEanBAJPJt+cNQPKc7Zda2q9BNdxE0
         aQaQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Y+kFRS+/VXtEpho343oOYx8YD1oc2HM4lFFBq+Mhr6yx6DZW3F/ywx9vnBXe62i9GLfW7V5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Q4DQeiIwpuUKWYB+lLVCZtCM0i0Uvoz0VirmL0+Duu2GDVJJ
	pZ6AC/qNyaZWxNo7zhppFKQDAFuJWuXvKmXgivPdsreGPYFwX9DY+H7AmXGaKRczybredF6Q7lM
	qwZH9cWYGE+J9XJ7YXgydPz+cJe5RpGFC+Trz1zgEeyKH3Oo=
X-Gm-Gg: AeBDiev4VOQBJh4lPdvAwCfTBmtrbn21za6hasFFQz6DtPmV/nYbFXPDf3kMxgjGpK7
	0IpfsJVQF2NcrRcFFZ3UXYW0+fjcQ5dWvjHuaSEXdheN2Snw9VtboipzLmMtIvvhvz+0v4sNOna
	6RP5b6KPa2V6bqfnxmizl/ZyIwpFnkJBQMfJA9I06KL8I5ph4mnNzqGht7FAModMfNsZ0h1kh9V
	aDYLeouo6DL0vMnJqg1KcCz21ZhlD3XHfT645NDyf3BB3mODbuPeCzxI4gYyWlYmJ8nKlcBJC98
	5qBDHIWbVOHheOEfpS8+
X-Received: by 2002:a05:600c:c090:b0:488:c744:49b with SMTP id
 5b1f17b1804b1-488fb74a53dmr69112185e9.7.1776519070984; Sat, 18 Apr 2026
 06:31:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418041633.691435-1-jt26wzz@gmail.com> <20260418041633.691435-2-jt26wzz@gmail.com>
 <CANn89iJOfDB+5oORjWPbP7Z1SyqUhMzVR8u8i+8P8MPDgg_EGA@mail.gmail.com>
In-Reply-To: <CANn89iJOfDB+5oORjWPbP7Z1SyqUhMzVR8u8i+8P8MPDgg_EGA@mail.gmail.com>
From: =?UTF-8?B?5LiK5Yu+5ouz?= <jt26wzz@gmail.com>
Date: Sat, 18 Apr 2026 21:30:58 +0800
X-Gm-Features: AQROBzC_Q-GZ8-zgpzaaVdMpWl_DnGJZTBYhOtWPKNJNKNL5h8rrfVmdaVjYoyo
Message-ID: <CALgi0XnEePV0WukxhkYr5-anFRTAQFMEGKOGX7pHa-g+56O37w@mail.gmail.com>
Subject: Re: [PATCH net 1/2] tcp: call sk_data_ready() after listener migration
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, tamird@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238588-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jt26wzz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A411942133F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks Eric, you're right.

After inet_csk_reqsk_queue_add() succeeds, the ref acquired in
reuseport_migrate_sock() is effectively transferred to
nreq->rsk_listener. Another CPU can then dequeue nreq (via
accept() or listener shutdown), hit reqsk_put(), and drop that
listener ref.

Since listeners are SOCK_RCU_FREE, the post-queue_add()
dereferences of nsk should be under rcu_read_lock()/
rcu_read_unlock(), which also covers the existing sock_net(nsk)
access in that path.

I also checked reqsk_timer_handler(): reqsk_queue_migrated()
there is only accounting, and once nreq becomes visible via
inet_ehash_insert(), the handler no longer appears to
dereference nsk.

I'll fold this into v2.


Eric Dumazet <edumazet@google.com> =E4=BA=8E2026=E5=B9=B44=E6=9C=8818=E6=97=
=A5=E5=91=A8=E5=85=AD 14:02=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Apr 17, 2026 at 9:17=E2=80=AFPM Zhenzhong Wu <jt26wzz@gmail.com> =
wrote:
> >
> > When inet_csk_listen_stop() migrates an established child socket from
> > a closing listener to another socket in the same SO_REUSEPORT group,
> > the target listener gets a new accept-queue entry via
> > inet_csk_reqsk_queue_add(), but that path never notifies the target
> > listener's waiters.
> >
> > As a result, a nonblocking accept() still succeeds because it checks
> > the accept queue directly, but waiters that sleep for listener
> > readiness can remain asleep until another connection generates a
> > wakeup. This affects poll()/epoll_wait()-based waiters, and can also
> > leave a blocking accept() asleep after migration even though the
> > child is already in the target listener's accept queue.
> >
> > This was observed in a local test where listener A completed the
> > handshake, queued the child, and was closed before userspace called
> > accept(). The child was migrated to listener B, but listener B never
> > received a wakeup for the migrated accept-queue entry.
> >
> > Call READ_ONCE(nsk->sk_data_ready)(nsk) after a successful migration
> > in inet_csk_listen_stop().
> >
> > The reqsk_timer_handler() path does not need the same change:
> > half-open requests only become readable to userspace when the final
> > ACK completes the handshake, and tcp_child_process() already wakes
> > the listener in that case.
> >
> > Fixes: 54b92e841937 ("tcp: Migrate TCP_ESTABLISHED/TCP_SYN_RECV sockets=
 in accept queues.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
> > ---
> >  net/ipv4/inet_connection_sock.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection=
_sock.c
> > index 4ac3ae1bc..da1ce082f 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -1483,6 +1483,7 @@ void inet_csk_listen_stop(struct sock *sk)
> >                                         __NET_INC_STATS(sock_net(nsk),
> >                                                         LINUX_MIB_TCPMI=
GRATEREQSUCCESS);
> >                                         reqsk_migrate_reset(req);
> > +                                       READ_ONCE(nsk->sk_data_ready)(n=
sk);
>
> I think this is adding a potential UAF (Use Afte Free).
> @nsk might have been freed already by another thread/cpu.
> Note the existing code already has similar issues.
>
> Untested patch:
>
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index 4ac3ae1bc1afc3a39f2790e39b4dda877dc3272b..287b6e01c4f71bfec3dd2a708=
f316224d9eb4a64
> 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1479,6 +1479,7 @@ void inet_csk_listen_stop(struct sock *sk)
>                         if (nreq) {
>                                 refcount_set(&nreq->rsk_refcnt, 1);
>
> +                               rcu_read_lock();
>                                 if (inet_csk_reqsk_queue_add(nsk,
> nreq, child)) {
>                                         __NET_INC_STATS(sock_net(nsk),
>
> LINUX_MIB_TCPMIGRATEREQSUCCESS);
> @@ -1489,7 +1490,7 @@ void inet_csk_listen_stop(struct sock *sk)
>                                         reqsk_migrate_reset(nreq);
>                                         __reqsk_free(nreq);
>                                 }
> -
> +                               rcu_read_unlock();
>                                 /* inet_csk_reqsk_queue_add() has already
>                                  * called inet_child_forget() on failure =
case.
>                                  */

