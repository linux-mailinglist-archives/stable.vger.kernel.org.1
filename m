Return-Path: <stable+bounces-248897-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLBrOhBsB2rY2gIAu9opvQ
	(envelope-from <stable+bounces-248897-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:55:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5B5556865
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AB6A3045EDE
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396BA376BEC;
	Fri, 15 May 2026 18:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e5Cnek7F"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A60633688C
	for <stable@vger.kernel.org>; Fri, 15 May 2026 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778871266; cv=none; b=MgUM5emHLeVBH1fOK3Mpwrk/sn/JRz+N/abJVrd+9atRAwknSgajHHwRcYwYlOnrF32/4qK6vOTyx8M+6E9L3RueKDEa31vbBSPmivN37lNFEtuoshGH+8ITNlhKvfN06JFz6dqtRCagPxWdRhcZ7pQ4zyaGHklcck7cWqWRk2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778871266; c=relaxed/simple;
	bh=1ep5ZLVgq0P6ZOuRIHNhve6Q35NR/xV4JtQP4fUWqVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dNTi6Q/mh1plKQCcQimJqKrbn+U72Bkxan/MRojYrGMTiPlI0Zcq4KRjkEKQ7pGSYRdxqfu4C3AR3+M4GlBn0T41wiXlHOLXuqXrIoNz2JWQ6XudC0I3rumzIKS97fGWGabG+sTyf5PJYiiTuPTBd8apba24s06piUN0BPz2STE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e5Cnek7F; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso975e9.0
        for <stable@vger.kernel.org>; Fri, 15 May 2026 11:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778871262; x=1779476062; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SuHPlWmIOJ+p8xvCO2qGzAHb3LeLHxGU5jkoCFo5buk=;
        b=e5Cnek7FNN6wB4gRgZEqeaHt5Oi9Uz0dym7Vn4/rOHsyReunpz3VaS7I5UaZCOtEII
         Lb8gFFmw7i3jvifD7lfHnLXvxTl+pF6BqE4sJMXkg1gTQiNCVwiKg/rTQ8Zjn2r7lwlf
         pE1NcaFm5ycl1MJHrjnEiAbGLssOcteP2fxphlIMaVnkKAf+2lptTedpmD8ew1boUU7h
         rRoKD2CX4lyuCZj5P7/j8r/UtBalHpi44oHPLCeB1Ey/lRoM6ksLhF9OnVbSw7gjQT79
         7yZZLMzI0cb0Upc3dxEV7s5nWNUgrEruffQtWSd0mQnkqkPv9ZJARAkSskbS5hzU1hps
         sZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778871262; x=1779476062;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SuHPlWmIOJ+p8xvCO2qGzAHb3LeLHxGU5jkoCFo5buk=;
        b=sL7SpqTpdovu1xfl10K33ePMkluQywRBoHy3hqnYvNYTK7a2PPeNtZvb/ct1+cFIVJ
         0YsOOiRO4/WCO9K1BK+Asx02J5OfdkI4y4S10sfUpOUSzUQj22jgUXWcUvJkGpXt5rij
         Cr+F4wKy4FAMLnMV2lr1j3Fh8xzqAkV8nFsNV+FXyypUp39Phs2UjI0Td0zOokZIyPD4
         WodUzTjf946QMR6t1YOHqfMFRFofX/zTqzZO7sGb9256Nu1fm22Ehy7ZKRmCsvebwL+m
         UmE6xIMZW27dIr33aU/PjgG4AGWdWob/K8VpclM1IDQAYv8IPJ1lnQV2lsIkGbbReePD
         CFKw==
X-Forwarded-Encrypted: i=1; AFNElJ9YqS2wvw81Ls6IXhtQ+CFSdlhimgmVDb4Afm9bqEaZHdJJJKI1Tlclpdw/6zlLB+2sTMHSSdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjNjZROLCdf3vGIryoFuhDbfv+bturUnGaYYZPhxp9IwIJlUCg
	YUz9fjBEshIxtr43L0VH93hWiW/cerC3hR60aF0NaCsjTDR8nQy243T1+0rIk/ZbiQ==
X-Gm-Gg: Acq92OF6P8y7UjbSIfIicHbQTQRuKt+dEqZ1sviuyyClzIFKqwdJUKtLPEINtFGgom9
	hb2EFqey+Lw+s77ymnGW14ct2bf86ozcqZRKeU3R8orz1t9/UjRnSk5QF/aP9p8YyPx13smd9Vg
	OV+r8HAA24sF7pGd6gModatjqKGgurD9biZ4ymimCWCGjFc7HQSgN8TB50sjUGmxC7pzqh8+f6a
	d2q0G0mj9jzcdIE/pFTtuvX8kvqbubnLTSOE+UOE/z6E+SlNWvj9OzjcP6/ntoWE7BYc4oMH0kw
	Ih2rQ1PDIWZwJdnUjESbTbTY2ee6MNpbT1NvmqJmnCeIB9aw3b7wbFmZzRrk7Tz+oCTblOh1yd8
	+Vh8P4SzKb+8r32k06lA6YpF7wgqZcIvpg7pPikjUup0fxlXSGFWxOFG0ltqJ8hJiI5PJdsdKEG
	NRQ0Yxui1Ddoy9uuiZ8Vr7cAB7H7fPN4E57OXxEFk7mZmd8vBmEzKOx3lEURc5zQ==
X-Received: by 2002:a05:600c:4ed3:b0:48f:de33:777a with SMTP id 5b1f17b1804b1-48ff4c84507mr85275e9.11.1778871261929;
        Fri, 15 May 2026 11:54:21 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:7481:4dac:8e80:6e9b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe57943b2sm79586725e9.8.2026.05.15.11.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 11:54:21 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 15 May 2026 20:54:08 +0200
Subject: [PATCH 1/3] af_unix: Fix UAF read of tail->len in
 unix_stream_data_wait()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-unix-recv-wait-v1-1-76adb5f063d5@google.com>
References: <20260515-unix-recv-wait-v1-0-76adb5f063d5@google.com>
In-Reply-To: <20260515-unix-recv-wait-v1-0-76adb5f063d5@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778871255; l=5214;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=1ep5ZLVgq0P6ZOuRIHNhve6Q35NR/xV4JtQP4fUWqVQ=;
 b=biFR0H5BnKM6bLseIWGzRNTfIvRlm/vD4ABNpEGL50UdomtRVOj4eqEfC+9PyYKMKMdKTjh0A
 rAlLz7dcLkAC2zvT+3nOa1m74jTU89NiW9kWrw5r0IALbjgMEdzGlgb
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=
X-Rspamd-Queue-Id: 8D5B5556865
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_FROM(0.00)[bounces-248897-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

unix_stream_data_wait() does skb_peek_tail(&sk->sk_receive_queue) without
holding any lock that prevents SKBs on that queue from being dequeued and
freed.
This has been the case since commit 79f632c71bea ("unix/stream: fix
peeking with an offset larger than data in queue").
The first consequence of this is that the pointer comparison
`tail != last` can be false even if `last` semantically refers to an
already-freed SKB while `tail` is a new SKB allocated at the same address;
which can cause unix_stream_data_wait() to wrongly keep blocking after new
data has arrived, but only in a weird scenario where a peeking recv() and
a normal recv() on the same socket are racing, which is probably not a
real problem.

But since commit 2b514574f7e8 ("net: af_unix: implement splice for stream
af_unix sockets"), `tail` is actually dereferenced, which can cause UAF in
the following race scenario (where test_setup() runs single-threaded,
and afterwards, test_thread1() and test_thread2() run concurrently in
two threads:
```
static int socks[2];
void test_setup(void) {
  socketpair(AF_UNIX, SOCK_STREAM, 0, socks);
  send(socks[1], "A", 1, 0);
  int peekoff = 1;
  setsockopt(socks[0], SOL_SOCKET, SO_PEEK_OFF, &peekoff, sizeof(peekoff));
}
void test_thread1(void) {
  char dummy;
  recv(socks[0], &dummy, 1, MSG_PEEK);
}
void test_thread2(void) {
  char dummy;
  recv(socks[0], &dummy, 1, 0);
  shutdown(socks[1], SHUT_WR);
}
```

when racing like this:
```
thread1                       thread2
unix_stream_read_generic
  mutex_lock(&u->iolock)
  skb_peek(&sk->sk_receive_queue)
  skb_peek_next(skb, &sk->sk_receive_queue)
  mutex_unlock(&u->iolock)
                              unix_stream_read_generic
                                unix_state_lock(sk)
                                skb_peek(&sk->sk_receive_queue)
                                unix_state_unlock(sk)
  unix_stream_data_wait
    unix_state_lock(sk)
    tail = skb_peek_tail(&sk->sk_receive_queue)
                                spin_lock(&sk->sk_receive_queue.lock)
                                __skb_unlink(skb, &sk->sk_receive_queue)
                                spin_unlock(&sk->sk_receive_queue.lock)
                                consume_skb(skb) [frees the SKB]
    `tail != last`: false
    `tail`: true
    `tail->len != last_len` ***UAF***
```

Fix the UAF by removing the read of tail->len; checking tail->len would
only make sense if SKBs in the receive queue of a UNIX socket could grow,
which AFAIK is not supposed to happen.

Fixes: 2b514574f7e8 ("net: af_unix: implement splice for stream af_unix sockets")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 net/unix/af_unix.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 1cbf36ea043b..dc71ed79be4a 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2711,8 +2711,7 @@ static int unix_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
  *	Sleep until more data has arrived. But check for races..
  */
 static long unix_stream_data_wait(struct sock *sk, long timeo,
-				  struct sk_buff *last, unsigned int last_len,
-				  bool freezable)
+				  struct sk_buff *last, bool freezable)
 {
 	unsigned int state = TASK_INTERRUPTIBLE | freezable * TASK_FREEZABLE;
 	struct sk_buff *tail;
@@ -2725,7 +2724,6 @@ static long unix_stream_data_wait(struct sock *sk, long timeo,
 
 		tail = skb_peek_tail(&sk->sk_receive_queue);
 		if (tail != last ||
-		    (tail && tail->len != last_len) ||
 		    sk->sk_err ||
 		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
 		    signal_pending(current) ||
@@ -2921,7 +2919,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 	int flags = state->flags;
 	bool check_creds = false;
 	struct scm_cookie scm;
-	unsigned int last_len;
 	struct unix_sock *u;
 	int copied = 0;
 	int err = 0;
@@ -2967,7 +2964,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 			goto unlock;
 		}
 		last = skb = skb_peek(&sk->sk_receive_queue);
-		last_len = last ? last->len : 0;
 
 again:
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
@@ -3001,8 +2997,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 			mutex_unlock(&u->iolock);
 
-			timeo = unix_stream_data_wait(sk, timeo, last,
-						      last_len, freezable);
+			timeo = unix_stream_data_wait(sk, timeo, last, freezable);
 
 			if (signal_pending(current)) {
 				err = sock_intr_errno(timeo);
@@ -3019,7 +3014,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 		while (skip >= unix_skb_len(skb)) {
 			skip -= unix_skb_len(skb);
 			last = skb;
-			last_len = skb->len;
 			skb = skb_peek_next(skb, &sk->sk_receive_queue);
 			if (!skb)
 				goto again;
@@ -3094,7 +3088,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 			skip = 0;
 			last = skb;
-			last_len = skb->len;
 			unix_state_lock(sk);
 			skb = skb_peek_next(skb, &sk->sk_receive_queue);
 			if (skb)

-- 
2.54.0.563.g4f69b47b94-goog


