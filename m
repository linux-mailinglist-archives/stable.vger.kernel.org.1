Return-Path: <stable+bounces-240254-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPOaLxMB6GlJEAIAu9opvQ
	(envelope-from <stable+bounces-240254-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 00:58:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BF34405B3
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 00:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0967B30555CD
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 22:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B690E3A6B74;
	Tue, 21 Apr 2026 22:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T1rFC0W8"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8584414
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 22:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776812147; cv=pass; b=Y9GEa9CPmPV8UjWTwu/xlKamk537yv+CmOvP/JnHtEl69u40Ie+J2b5mo7zZ51Z+JzoHz9LAxkhA/AYLfrElrqShQ4CsatitTlg+jBSfwAqchfjiCWcE/+PeOGjvLXyABKatogEWkRcJE83YBGLuUAjikb4R6E3iA0zJrsUBDtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776812147; c=relaxed/simple;
	bh=7g+6Nj4I9wlSgMa6eYN57nLSLjoKXWzdMIwO8KfWfA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSzEnI+hEnhu1xY34Vn4HYnFLu2HYpJHaEE5ouYKmD/yPU/WtxueiuO4JL4ym1jMO3KTMUA9n6dEHTBlBX7ny0hiQ9qi3uG3y21FhhiClPACiJRavHrSXB6+/3pUB0svci2WbReniyzvsy6NMz9hARyyy/HMzKH5A6mq7FyyL1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T1rFC0W8; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c1a170a50so5944471c88.0
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 15:55:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776812145; cv=none;
        d=google.com; s=arc-20240605;
        b=Yoo7lKO2QtyCWaXbx75FTrfHMpbkxYNYFasAKLgekslf/dvsVWTzbuwWtw8Ui8HVNP
         7P7mDBieCRPbUb5NFQAR8ZvVZhb303GXsX8UBFBALIKOxw/5yBX+qphuwYkM2HiESBuD
         P8mVQV7wuQX5zYyUelFLFad5EN0+BhAlOg2UrqYoVophsBY7jG1ZUTP4HQYcV78Ks6V1
         mM4qm1Ve5o837NAaiI0xw3iqbIfv78/7axnj303RjknI+RIv48lLZm9APXycLy7Cyehk
         xoWWHN8QWPQ3Y0fNHNBZ7SBAMlWu52vsBEYxWlCj7sV2Zqet8odc7kjCGGBkLMRUc+Up
         EIIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7g+6Nj4I9wlSgMa6eYN57nLSLjoKXWzdMIwO8KfWfA0=;
        fh=j5lgojJllvzhqxIB9oh04oKdx10KaY+K0X98aIxa76U=;
        b=gCm+02tFy0RE3tkMH/d9FJ4X2Mt2Wc31lPgX6lcK51HEV2c2QrW6yET7Bn9Ny/RtSR
         4rlhSra0sF4o0Ex8QmaE3EkVQCiMn+3trljUVTaWMd4LnPbBYODRNeJl1sQXSvUS6+aM
         OADEKmikCE+cDj+f1+PVL6TOGFc6FufzLn/yTvjUgMfVNfXhlGe0Vhjh82I9hEwSrK4P
         YNxZEz8iWRtou1C1vSKjSRykBFAWpBbBGxvhgwNTtbgYnK2wcc5Wz8qdmk7nq81LWmV5
         NIwINLV2oy9uUib+GQ62F7qKLfo0KFQWF7CoLbeOHvcCitqsB6tNcELcEFyqzoUZNGtM
         peXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776812145; x=1777416945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7g+6Nj4I9wlSgMa6eYN57nLSLjoKXWzdMIwO8KfWfA0=;
        b=T1rFC0W8HJjEU5SYA02Yi58j2YaXzPiQfqL+81p8TaMFaUhTnYnp0fMRhmKsRdY4vW
         ROjCRNiuafgBnFCzoVCuvtgYyZHlGBuJyMB0OQWu73QxEBrHz0WqzkmD/uUgRjCpWLp3
         pfW9IBLsuNEqRRhUcJamdHgV/Ajncj2v8JVDqYQ1vAv2YC5Ui1LmgRpeuqE6w4O0p40+
         xXzSwMO3NaQQZ/tLGkzd3X51HGIAWIg1kjgI5VhsnNGOo6RxU6OFTxAo9TmG4JPmLSHF
         MEiVGFRbNRuBzxyOCM4s+2VlFVXE83XLAAIxgOh7pCrq1Slz6+MuBWHv8tumHp1WgWz7
         JXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776812145; x=1777416945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7g+6Nj4I9wlSgMa6eYN57nLSLjoKXWzdMIwO8KfWfA0=;
        b=IbjPCYJVelYcI+QpfHJFoyTxqcaVS1JiQRdwTakuzLESFipkZg9rjgFF0sOP540Cq7
         WD0lX7pIidhAMv4g/vn/gCc0WkHDHyE6ABdqOZ3l9gldN/YP4jaxODAtNKs/rPaF3HHG
         ND+xCj5CpkW8etK8cgNT4aguV2IEfx/tiPtYkkR3mYikOctYNNjV+AjUzqTGPmrUX+gg
         q3DxcyrGqzYPT8QeuVOQG2XYnASxbL2axbyQphrnXGbyhzePP1lupJfFONvvkUEy368G
         EqPAIlMWjFuNATBGwfvypmjOkN/UPXuVu1kRXL5OEJNXWicUyME8no0i66aK/WVV1Fqu
         nFgg==
X-Forwarded-Encrypted: i=1; AFNElJ/Q9fh3yBQ+mgWXOY4HL8hR+8UOygKgQ+rmmL8K6NRkmGVuLIt6NKw2heiucIhpkAYKoyID6V0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrrpwYTdmraqlF2qdXjaHBuQZ6cGrlAnVuZVqfVE92jUWxi5/7
	h+Qn49XrdTsl3Bmx2p3qjFDyTKKJNSM5YwghLopMaF54trNDkdOMvJ/fr5UF2jL0UKx0PZeummJ
	MS9n6GFq05mpua7oloieHJC0c3tjCuFCg9wjcgV7qy7+NmYwAPfuapMxt
X-Gm-Gg: AeBDietojMpBSAVmZrjnraikHAuUxXx725Rga+neh1WCanBbzSsQN913bT4SsfBuQ4z
	ah9d70dMBnFEYt4vhpHZUyTdZSG4n2MvyMTBO6ta9cLUYB8Nx3Zm9T05nibBf/7brTt6GLH0GIk
	CFNKkTB3qa33wHUWxHdnE0py5lK2H6qUuKRiIg3x2w/NjlPPXAcxKUEjyKUrAhAaUabc/9+/5dE
	214O6ekz0hmWZGk12DPu81E/tTVVnNFrZMY5arPXrTvhyT6m3d6L6SAEn6DDKU2qHaN134vE+xu
	Xvf0WXH7zrRFEPF1nYa8Fvel5KLePe8PGuoy8ROMpaAQ2QpXGxfNoNpL5XVOCHX293U5IXKbUKL
	yYUVhVLRSesGECQQsaCqo18X8gcwv6NQFqi3nO7PcWMYKTkqacBstZzwMfKqOfsG2NDE0sIixRA
	==
X-Received: by 2002:a05:7022:6627:b0:128:ca83:5aa1 with SMTP id
 a92af1059eb24-12c73f9217dmr11175890c88.16.1776812144868; Tue, 21 Apr 2026
 15:55:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421123106.142299-1-jt26wzz@gmail.com> <20260421123106.142299-2-jt26wzz@gmail.com>
In-Reply-To: <20260421123106.142299-2-jt26wzz@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 21 Apr 2026 15:55:33 -0700
X-Gm-Features: AQROBzD2b51gLvsY15bbLEJ6mf5qB0jtCSoEC5dNs0R6RYbWMCDYXu37HOUp92I
Message-ID: <CAAVpQUCW2rAdz47kYM-YN7Er2iKVReyZbFSCJXG04Cw-8y_VjA@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] tcp: call sk_data_ready() after listener migration
To: Zhenzhong Wu <jt26wzz@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240254-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 41BF34405B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 5:31=E2=80=AFAM Zhenzhong Wu <jt26wzz@gmail.com> wr=
ote:
>
> When inet_csk_listen_stop() migrates an established child socket from
> a closing listener to another socket in the same SO_REUSEPORT group,
> the target listener gets a new accept-queue entry via
> inet_csk_reqsk_queue_add(), but that path never notifies the target
> listener's waiters. A nonblocking accept() still works because it
> checks the queue directly, but poll()/epoll_wait() waiters and
> blocking accept() callers can also remain asleep indefinitely.
>
> Call READ_ONCE(nsk->sk_data_ready)(nsk) after a successful migration
> in inet_csk_listen_stop().
>
> However, after inet_csk_reqsk_queue_add() succeeds, the ref acquired
> in reuseport_migrate_sock() is effectively transferred to
> nreq->rsk_listener. Another CPU can then dequeue nreq via accept()
> or listener shutdown, hit reqsk_put(), and drop that listener ref.
> Since listeners are SOCK_RCU_FREE, wrap the post-queue_add()
> dereferences of nsk in rcu_read_lock()/rcu_read_unlock(), which also
> covers the existing sock_net(nsk) access in that path.
>
> The reqsk_timer_handler() path does not need the same changes for two
> reasons: half-open requests become readable only after the final ACK,
> where tcp_child_process() already wakes the listener; and once nreq is
> visible via inet_ehash_insert(), the success path no longer touches
> nsk directly.
>
> Fixes: 54b92e841937 ("tcp: Migrate TCP_ESTABLISHED/TCP_SYN_RECV sockets i=
n accept queues.")
> Cc: stable@vger.kernel.org
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

