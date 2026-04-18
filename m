Return-Path: <stable+bounces-238543-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI3jJnIe42nOCAEAu9opvQ
	(envelope-from <stable+bounces-238543-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 08:02:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 416BA420175
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 08:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD291302BE26
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 06:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B87833F59E;
	Sat, 18 Apr 2026 06:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rK84Jq0F"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ACF1482E8
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 06:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776492138; cv=pass; b=LqePkhrRbBcBRVTzZKveRid+sYQf8Of/Lqs4Si2DHoGh5Jwy0VoMUEX2YQ1idkMwUHjs3qTewjNQ2CpZ3eXiYsH6r8l2ma9+LJK7SmB5Z3If5uMFJngBvzsJ1AQNbE1RHhyR1w+YkkHPRf6XmkvRN6dTmP9MF9UfeqH9WvA0II8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776492138; c=relaxed/simple;
	bh=+DxAgjOGYsbq78L0ygJnRzmXFkqF5BzidbIYSSplQ98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhSizKgfV6sr/pGqEzipSE6Vla/3OWQqhlYOY5Nf/MddkS3KmBFo9k4bKcQ3lDPuv1gvJySdsCa3qxa3S6UeR0HyqF052SaRxQJxK0DPWeCqL/eSzXoW4K2em3FsFhCChwihDqMAgxV/UU5RfQ8oWKm6nD+N9mE8/vkC9dDmx20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rK84Jq0F; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8aca0469204so15426896d6.2
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 23:02:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776492136; cv=none;
        d=google.com; s=arc-20240605;
        b=Dua/2P2yIFKlLpRpO7pfNldDcEgxh5DkqHHl0cl6oNyPeepQujEKFXJgLKRZAtWlW9
         GZz7yLRIb/6yCI59ztL40zwJPOpzXX7cEhIWe3ap1QLs2REROkUyqDoelIV16/vhOpAF
         6P295ZO/xYFrRlz0NptGOz8IpxmjtUAkOQ0kH/KIbndDUjlVLnlUWmbBchriBVxQWCP3
         q7PCRNtqiTGTrR5ZTWGxffpu2CDMMK5g9s8nDqWq8I11OcPeIwLJ/D7ED0c4SkDAsvxg
         L/RHncik+NH4fawbOcK9zCO+rSJTYZK5TYMSYhojUMfcq4RLgIQ32DBSgcBXcTjvnasm
         EjCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D8Cw2/LxkFW8q0BKiXupLWBPBKSpdwnTq/LIei0Fzfc=;
        fh=qKtWT3hhiveenc79pqXV6Lg2Z4vTFp/CJGeVItK3+1s=;
        b=AuJDYhYMOcTI1TotymcbwUSIMqXWrkpxKDERabbYK/wqcnH/IT2IFeT/Y1ohuu1fnC
         R2NHcrBvgcjmOnEUk8oAaVtejwfyee5QswvRteY2Kef0mkkqgC0mtcDCrKozcZXUzx5G
         g8LeaRljHnBt8rwnbnmHg9fLYcCEwo+RmVj+OhPQBL3mykHiKQasZ/OseelljBjE3Xyg
         YbK/AgMiKAwVO27KQPAiLELiZwn7Kyc0H5al5O4KjgbmIvtpu+59K1+QDPLokgi8+TDJ
         /oAFjUExNrx5hf3ALa+BrqEK2bk3RrMWSoBEJLbAgBYcuZMC1Mz5lqM8PPPepJ91QoQI
         tFmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776492136; x=1777096936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8Cw2/LxkFW8q0BKiXupLWBPBKSpdwnTq/LIei0Fzfc=;
        b=rK84Jq0FT1tYluOd8vbtfXAC10Qs9byzVsz6z0XwZdY0qmt0Q7SDK8sw4Hc2tfiweP
         sXTUgDzb5H8kpMCOGQooa8XvvELGL0txWrO9CP7gyVimrDL6Ov05YAKYABm/6LIuSPm4
         1drGyZdMz6XLmgLVZt1hIpWgF7k0y3bjllAkWiQhxzcO8nS5MMtxMB0LlQNhgdiH6AuW
         dai/E4nVrgioJWmlHOZWXUp5CPOEUTxLgUYj0g/F455C4jcQTh6gQOQbb7nLvUqIMzGf
         wjXiCigFI0iYIWyTyG2iBG0QPUeNP3QSzDfi1rCp5Kr78IXp9RWZ5l1kYFHmT99su8Md
         ESDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776492136; x=1777096936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D8Cw2/LxkFW8q0BKiXupLWBPBKSpdwnTq/LIei0Fzfc=;
        b=k4pK2/VsrSMHIjZXcWhTIeIQYL4NsVaoOVk0CRU08LEf4DkI2U7El6ztOLsQwD201C
         lJRCBkDaY5lpEbWknjw3KWm9asnYNafJpe/5w5mgLd/syVlT4e/kwRGRypc44sA6SYu7
         DpJGuTpP4dZ+Ourquocm/mTC6ZmMKWqh/1VbwBYXYk28UE9kv4xPPmAH+a1Pw5kiNjgo
         rBtlD+xu0SsMNt4lgwHl+PncYnTCRaLm1U+BCJ5JCtkMaq1+FwQMO/6rKGcu5Ge96Nbb
         XL6yShixEwMDq+OnBgR0nh107nJTH8W1NJBaH0LydHdz06yx32i5PQtzsjAwSxgXotc1
         izQA==
X-Forwarded-Encrypted: i=1; AFNElJ8l9DA4ClrvCr8gUe4BaUKPTWMAC+r2+aM2lUA0coUcuAOV1FTiQeivdC+JpSXP5rwitbXol+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiPExfXwo+AnKpGwQ1/+2M83ZkoAn52xfXHbTIT2PpZRjP4041
	kG0XQxpID0rhSylSPs0K4NIQZZSy830tqQu/Ub948GQ2jF8NBVVM2wWdI5R/E9BXfr85gbM2AKy
	3E3jrbeCYYnLPQNawM07gTzEDxSQUxSL32dLb/t8z
X-Gm-Gg: AeBDievkRJa/acKoDfSSSex0H0viZSHE0YwaRuzC3C+cz98BG7efyUoPYwGzUh61MsX
	pNsr5LcS/hDQBodsqEO19rEzqbffktgZUJSg+fCaKXidGBL6zFGPcxygsuH6P1/Y8m25RQJfB9m
	YJCCvc6OlS5utlzHpVO/BXc/JfJrKUAYJfSWTO9v04pk+YhrxvDeu/sXzb1F9YzHGiFbCBIgZ5t
	5Mfi4SAMJGYm+or+HBhMae2a599dLr7aCvsnVvFLYZdwOMYTHixwLrkZP7lCI/yCyX4uCk/eQUP
	Hl4f88DG+fVzzTLS9OuQnbiSXWMmGaffm1VsYdo8R0evXeC63RUxaZesn3jAugZt/qM88Xl/cru
	KV1TDazN1
X-Received: by 2002:a05:6214:4e14:b0:89c:eabb:f58d with SMTP id
 6a1803df08f44-8b02813b256mr81180536d6.47.1776492136072; Fri, 17 Apr 2026
 23:02:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418041633.691435-1-jt26wzz@gmail.com> <20260418041633.691435-2-jt26wzz@gmail.com>
In-Reply-To: <20260418041633.691435-2-jt26wzz@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Apr 2026 23:02:04 -0700
X-Gm-Features: AQROBzA36i8s0WTRa6QsFOr6av2JTG94HxbtoID-4rUHJyFb0GkqUURu9fQz6kk
Message-ID: <CANn89iJOfDB+5oORjWPbP7Z1SyqUhMzVR8u8i+8P8MPDgg_EGA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] tcp: call sk_data_ready() after listener migration
To: Zhenzhong Wu <jt26wzz@gmail.com>
Cc: netdev@vger.kernel.org, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, tamird@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238543-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 416BA420175
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 9:17=E2=80=AFPM Zhenzhong Wu <jt26wzz@gmail.com> wr=
ote:
>
> When inet_csk_listen_stop() migrates an established child socket from
> a closing listener to another socket in the same SO_REUSEPORT group,
> the target listener gets a new accept-queue entry via
> inet_csk_reqsk_queue_add(), but that path never notifies the target
> listener's waiters.
>
> As a result, a nonblocking accept() still succeeds because it checks
> the accept queue directly, but waiters that sleep for listener
> readiness can remain asleep until another connection generates a
> wakeup. This affects poll()/epoll_wait()-based waiters, and can also
> leave a blocking accept() asleep after migration even though the
> child is already in the target listener's accept queue.
>
> This was observed in a local test where listener A completed the
> handshake, queued the child, and was closed before userspace called
> accept(). The child was migrated to listener B, but listener B never
> received a wakeup for the migrated accept-queue entry.
>
> Call READ_ONCE(nsk->sk_data_ready)(nsk) after a successful migration
> in inet_csk_listen_stop().
>
> The reqsk_timer_handler() path does not need the same change:
> half-open requests only become readable to userspace when the final
> ACK completes the handshake, and tcp_child_process() already wakes
> the listener in that case.
>
> Fixes: 54b92e841937 ("tcp: Migrate TCP_ESTABLISHED/TCP_SYN_RECV sockets i=
n accept queues.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
> ---
>  net/ipv4/inet_connection_sock.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index 4ac3ae1bc..da1ce082f 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1483,6 +1483,7 @@ void inet_csk_listen_stop(struct sock *sk)
>                                         __NET_INC_STATS(sock_net(nsk),
>                                                         LINUX_MIB_TCPMIGR=
ATEREQSUCCESS);
>                                         reqsk_migrate_reset(req);
> +                                       READ_ONCE(nsk->sk_data_ready)(nsk=
);

I think this is adding a potential UAF (Use Afte Free).
@nsk might have been freed already by another thread/cpu.
Note the existing code already has similar issues.

Untested patch:

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_soc=
k.c
index 4ac3ae1bc1afc3a39f2790e39b4dda877dc3272b..287b6e01c4f71bfec3dd2a708f3=
16224d9eb4a64
100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1479,6 +1479,7 @@ void inet_csk_listen_stop(struct sock *sk)
                        if (nreq) {
                                refcount_set(&nreq->rsk_refcnt, 1);

+                               rcu_read_lock();
                                if (inet_csk_reqsk_queue_add(nsk,
nreq, child)) {
                                        __NET_INC_STATS(sock_net(nsk),

LINUX_MIB_TCPMIGRATEREQSUCCESS);
@@ -1489,7 +1490,7 @@ void inet_csk_listen_stop(struct sock *sk)
                                        reqsk_migrate_reset(nreq);
                                        __reqsk_free(nreq);
                                }
-
+                               rcu_read_unlock();
                                /* inet_csk_reqsk_queue_add() has already
                                 * called inet_child_forget() on failure ca=
se.
                                 */

