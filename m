Return-Path: <stable+bounces-249342-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFoaKapDC2qsFAUAu9opvQ
	(envelope-from <stable+bounces-249342-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:51:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 53227571370
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30C2B3015891
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 16:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEB7494A04;
	Mon, 18 May 2026 16:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p/2CR2u3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292314921A4
	for <stable@vger.kernel.org>; Mon, 18 May 2026 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123103; cv=none; b=gI8JMc95Z8r1Jm3lCsDwV+Mev6Zir9SetuY7A5Etc+hDewfeu+djZJmcwOizwrQvyhvUA09+WMHe7FQS3LYoYzm/jgkScAGTl1Ca0c7RyN6/h0dLp+LLbJrHcNFB71AAZziabz/GLR6P4j6OI0Ue9H6DS58SysUi0j8a+qFkwaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123103; c=relaxed/simple;
	bh=54HD6WkoU9E2L7AOGhuR8sDuLpt8IOaDZS6a/rdTjMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I85uHiz/ow2BNLbJntmTcSHN7okKsWkj883dY7o44MNg1hgdibdtOvfanDQWjfrNp4G+YrTgjEk9WpiFvOuYZ33KGNWbYKW16w2K0bDJJv9bv91lsBiZ0FcCbmKuIVoE1fkhB1nPltVHhUfpRM7301rtdK4p2/YpNcDOA7Ck7g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p/2CR2u3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48d1c670255so3795e9.0
        for <stable@vger.kernel.org>; Mon, 18 May 2026 09:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779123100; x=1779727900; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QUGzTv1DHoDq83W4njAaCPU00dav/zccykg7KzVApdE=;
        b=p/2CR2u3oXVtLSO7FQsNftLmRV3+JGfLC+kAL3QBN/DLZf+iNMGb7ZZXfh0Pp9Hube
         v0joDRbs0TvU7yOMRe3gvCQdKZgSIRdi+ArXILcEQCkgGRsbSIQ8mVT1jaW44PS9AKoL
         jHqnPot69ni3rGqzcQdQxi/ne88dBCjfDgg5MXP0xh7/rotywNJpgX4YKntvDg+4LrW4
         nGoa+HWH7WzLIeGG3NF8sgzlR9I/MlpNgTE8aLh0fQTR0pnItIUzb8D9mu9k1XV5Gc0N
         uZ3gDH111CvQIs+cbVrK1qnhsryR9EBqPzBJ6+fAArTYBdix1RGVNMroRSXbJcxjk5bE
         Cn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779123100; x=1779727900;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUGzTv1DHoDq83W4njAaCPU00dav/zccykg7KzVApdE=;
        b=PBBdZZLpS00V7xdHro85zJDLvfeOPwYYvUcUaovtyA0nENEdaOdUkWbb0RoV+y+mJS
         P3PsmRJwWCqk9safDtNfdgoQAkhWbvlzMlLCiUe1tDtYN8IEDiBhk0nKfuu1PvdpVkND
         XeehWz7uxoSqorYm0P+XY/ze6ceI3PBDm8t2tiNMngP4PYOTnXmIOPu7MR0Cp5Z7+Ol4
         C8E2IhJHLSeYIPXA1VvltDsj7BfChgpQQQsDJ54sb8LZqUSTSZKeHc4bqZZLpGVDbTAS
         hYTv9ktWy0eHU2fVVPPsym0UOw/uQwoXS7yFNP8P0/vF9GfnIw6+2A9x6FzwRd+Y3aG3
         PUSQ==
X-Forwarded-Encrypted: i=1; AFNElJ90VtxCYFs9rSN16iygUnFlyq01LVJpGt13KnNmu55DabcEmo/IGAylRjwiRCyoAjyy+XI6efE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJmx25/wsZuKzcVDO2XFnU01ImNU56AZwMpEYK9Y5ykyRNFlzF
	HTPwiJy21cw2s/YJc3jzbjIbDAmDbPjbLKvvxp4wHNQVLCL8pSyIQP4UNIWZ5OE3Qw==
X-Gm-Gg: Acq92OGExWklJXz0qWQZM9YqfK53evAR/Kvga2tAvpBB8XrqRawlykSc9bcesd4yNkJ
	VFZLRRKcANUeCL2a1qZU6A8N8y3QZBwapvjc6GyLWru7BJPBT4fvAr8ZmegDbqmCqPmvQYol5/c
	k2hmisOAVOToD10LlxYyobAxclUfjT6fVFBPRcuQ5xi2MdQLwnqOgLJsquAA8pvDyWn1cZ18H2O
	fFmE9TWwo+A+L8Gq5O4VHvW2PwUfSSh2P+D9bysJI74xTI8a5zCp6FYckNi+k6cHUACUlbdJRdJ
	PTRgJV87dIzyjyCjlTpCTJxXfsuVZ+0nAqQYBdUz4e/VXZCRv7ScvEzPW7UEUN+eDNqKP53KQZv
	mfUSJr+oPiY5o/B269/h7cAEpBqaQBhnumN/P3LZ7O/YqLXj6iAA/JWUX9vHVpkuX5vXP5xK6x6
	X2rhsnUYXgNVS4vL8wfKJfa9A/8pwmVfcNxF1rs0A3dojNYt9T7APqdtA4lMK+
X-Received: by 2002:a05:600c:418b:b0:488:960f:60b8 with SMTP id 5b1f17b1804b1-48ffa5e1272mr1613485e9.6.1779123099979;
        Mon, 18 May 2026 09:51:39 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:866a:e549:273b:bc0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5694fcasm247128945e9.5.2026.05.18.09.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:51:39 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 18 May 2026 18:51:30 +0200
Subject: [PATCH net v2] af_unix: Fix UAF read of tail->len in
 unix_stream_data_wait()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-b4-unix-recv-wait-hotfix-v2-1-83e29ce8ad31@google.com>
X-B4-Tracking: v=1; b=H4sIAJFDC2oC/x2MSQqAMAwAvyI5G2hLFfUr4sEl2lyqtHUB6d8NH
 mdg5oVIgSlCV7wQ6OLIuxcwZQGzG/1GyIswGGVqVekGJ4un5wcDzRfeIyd0e1pFUKutUpPVptI
 g+RFI9L/uwVOCIecPb39W6W8AAAA=
X-Change-ID: 20260518-b4-unix-recv-wait-hotfix-e91400b41251
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779123098; l=6494;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=54HD6WkoU9E2L7AOGhuR8sDuLpt8IOaDZS6a/rdTjMw=;
 b=KFcmSeJwQW72Yr5iXq8iiTqf0xvrDeRaC+IySSWIzUO7MBc8V9G+gugvf3YybFObLQQ/YC4H3
 Cu1aD4RIY1kDOwIpmP43dr9KNLldxQfJ3abSQh9d/rBRzsjIP5s8htd
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249342-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 53227571370
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
which can no longer happen.

Kuniyuki explained:

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

That means this fix is not suitable for kernels before 6.5.

Fixes: 2b514574f7e8 ("net: af_unix: implement splice for stream af_unix sockets")
Cc: stable@vger.kernel.org # 6.5.x
Signed-off-by: Jann Horn <jannh@google.com>
---
sending as a separate patch as requested at
<https://lore.kernel.org/all/CAAVpQUDJa0=h+iFqr6ZEJ72b5nYTX3Ay-Vbkk0-7Y-KZB_3SBg@mail.gmail.com/>.

Based on the context provided there, I have changed the CC: stable line
to mark the patch as only being suitable for kernel 6.5+. If we want to
fix older kernels, I guess we'll need something different for those...
---
Changes in v2:
- limit stable backport range to 6.5+
- Link to v1: https://lore.kernel.org/r/20260515-unix-recv-wait-v1-0-76adb5f063d5@google.com
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

---
base-commit: aaec7096f9961eb223b5b149abe9495525c205d9
change-id: 20260518-b4-unix-recv-wait-hotfix-e91400b41251

--  
Jann Horn <jannh@google.com>


