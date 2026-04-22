Return-Path: <stable+bounces-240265-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KiiCVM46GkbHAIAu9opvQ
	(envelope-from <stable+bounces-240265-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 04:54:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D07E441A3E
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 04:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29706301F5D8
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 02:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B141B3939B6;
	Wed, 22 Apr 2026 02:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlCKI4rc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CE72505AA
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 02:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776826003; cv=none; b=EBhy1tr4Pq4sUbkGBy4uWmzKhqzeix3Wjwx/aQGrGkWS/t4qwivyyNtow5bjy+jYQMjzBiEKjExOkRQMZTv1G8tomlhPeycmtmVXIkADP3RmNhrbSWOMGzGJyp1AKE7qYuS+1xC1Imnq35U27gLbaw0T5NTkEsBV5nMl+I97ip0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776826003; c=relaxed/simple;
	bh=54mdUmpSfgqjXDGwvG814qjfvfFiFaCFWzugdgFYZ/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1pCgV9iXdpivUXf3KO1Ze5SEN9Zl+IDdlQ3kG8zlwkhSevGmFqPRylauBuIaZuC/2OioKIE+c+o6iuOpR3bC6VLXtOU/sRqT2eZNvQhKu47CPsevbGu450h7jyAPUKBuC6VpxXy8qCbhl2CxFOtZSEBaJWOl+VRK1nnR4e6nR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlCKI4rc; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35fb16e56efso3248812a91.2
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 19:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776825992; x=1777430792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fcd+LZFK9AMyl2emRFE9iJQXg1L+/s8eBXtgz15uq2o=;
        b=HlCKI4rcIT6GzPAm1eX0Dxdabz54vsziUFvzkUy73YnLUgbD8Ia/n8B8aqzSiKj8s5
         aK9uYActb3pA6MwqlsO6lFSYkCpDap7nfZDhe0YKmHJmfpdt5+z5m7Kq0T+3Y4JafZHG
         gx2OgQ4yPXDOXSDFbn1IrabDS2Aa1OILkds2ImPDKvV3f3Q2glXQVLm6Tb/7DJbJU/S1
         AMojfLiJlwxw8y8w9ZEsDSlTJ6Wap6Jt4s1bPs/GUPGC5EB7D8peYKvzxJLTccbag96n
         Ne5tGr5DaymAMfBM/iVjMhVqk3H0hHj7XBM4MIhPkk1PJTgOF5dtrHjkGG8XJmxg3zsJ
         AJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776825992; x=1777430792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fcd+LZFK9AMyl2emRFE9iJQXg1L+/s8eBXtgz15uq2o=;
        b=DOAjdjCjQdnXvkCKSCznIXe/AnBrMxsXJDF8eP6dDGSzT9nu6SdGwoDsknUlhQel6V
         HNFy5w1nRBFs8LFyj2NTXNnSKkI3i1xLYMU6wp2WwK44V/Bf7U4uX/R7I6dV0kETHadO
         zv+2rgKcwxw6xQi2MSclpwK3fthvUBLzjwp5uMuPGyvRgrvSGiVFaEsP129n2BBBGg3f
         ftQPG7BXC4vDYd8HQBEo4FQiKcrmq0TOJBRyeCKwad0ikCafvzgf0BPoe5aHMshlJh4n
         06TNjjxJRNAFm4dw/AqvXFN18z5HuWG9NGk6njhICPugicn2HPIVhiRgFAeqtWH0VUMR
         EP+A==
X-Forwarded-Encrypted: i=1; AFNElJ8f9MenxAJB9Ak9OC3TTCOxwwyejbQ++xw/JaUR+TD7L8Zabipu5YEC+lGVbJwjxkMtN56QAok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuWXSPnc4GPw2Koefp/s6Q6nIr1ge7q1H1Tm7BTjykyBy5mN2B
	S3HNjCVIxI/0I746BFfrgF6nubnjOLMHJFi/1leOPRcTi1AglpDZ5w3x
X-Gm-Gg: AeBDiesdHw7LK+pV+KS2dRFd/b8DG/NZTdPdmQ7XoqunLojL6g0LTphIUhKltLwg5pi
	4MF2EJyH1qkEoGJtRgBgj752P9pb61Kx7L1wQAkpaje7FKH0bnRVW1nuLTNf9Y074yy+CYLi02f
	A+4BRGF9N80vXegg2fojQZH47kMEwHVKvufy37hq7thUKaug4F4Er0zeg9HduJ/krDHMcLDKDev
	OKx+TnKqG5q7j5blM+wqaEf4X7E7JafeQ0WOhepgbfvKG9Sloy2bPBkIPEHTdjlUXaZAKd5ZNDN
	OMGxL8cWWb+mUZwjnVXI/m1eReqdpfu5t8+o/vZvbekp0KMSjhNp8Y0/BLHzKoiRpgvy0c2F/GF
	ErJmM4GXlY8gCkqK5dfJ55Q6JPdaHmtYNwMw/0zIAIaGeEety/51taO+yUZeSa+7mWzfeMKT7M9
	x4nVnpEzemHI22U+fuXixYcYw17NRN+iqZ2Rv4AgMhdw2CfkhMsffOn8n/twI9Ug==
X-Received: by 2002:a05:6a20:9187:b0:3a2:dd8a:5084 with SMTP id adf61e73a8af0-3a2dd8a5be1mr8799899637.37.1776825991972;
        Tue, 21 Apr 2026 19:46:31 -0700 (PDT)
Received: from DESKTOP-MUHC17F.tail07b66e.ts.net ([188.253.121.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f92183sm10656632a12.3.2026.04.21.19.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 19:46:31 -0700 (PDT)
From: Zhenzhong Wu <jt26wzz@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	tamird@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Zhenzhong Wu <jt26wzz@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4 1/2] tcp: call sk_data_ready() after listener migration
Date: Wed, 22 Apr 2026 10:45:53 +0800
Message-ID: <20260422024554.130346-2-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422024554.130346-1-jt26wzz@gmail.com>
References: <20260422024554.130346-1-jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-240265-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jt26wzz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6D07E441A3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When inet_csk_listen_stop() migrates an established child socket from
a closing listener to another socket in the same SO_REUSEPORT group,
the target listener gets a new accept-queue entry via
inet_csk_reqsk_queue_add(), but that path never notifies the target
listener's waiters. A nonblocking accept() still works because it
checks the queue directly, but poll()/epoll_wait() waiters and
blocking accept() callers can also remain asleep indefinitely.

Call READ_ONCE(nsk->sk_data_ready)(nsk) after a successful migration
in inet_csk_listen_stop().

However, after inet_csk_reqsk_queue_add() succeeds, the ref acquired
in reuseport_migrate_sock() is effectively transferred to
nreq->rsk_listener. Another CPU can then dequeue nreq via accept()
or listener shutdown, hit reqsk_put(), and drop that listener ref.
Since listeners are SOCK_RCU_FREE, wrap the post-queue_add()
dereferences of nsk in rcu_read_lock()/rcu_read_unlock(), which also
covers the existing sock_net(nsk) access in that path.

The reqsk_timer_handler() path does not need the same changes for two
reasons: half-open requests become readable only after the final ACK,
where tcp_child_process() already wakes the listener; and once nreq is
visible via inet_ehash_insert(), the success path no longer touches
nsk directly.

Fixes: 54b92e841937 ("tcp: Migrate TCP_ESTABLISHED/TCP_SYN_RECV sockets in accept queues.")
Cc: stable@vger.kernel.org
Suggested-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 net/ipv4/inet_connection_sock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 4ac3ae1bc..928654c34 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1479,16 +1479,19 @@ void inet_csk_listen_stop(struct sock *sk)
 			if (nreq) {
 				refcount_set(&nreq->rsk_refcnt, 1);
 
+				rcu_read_lock();
 				if (inet_csk_reqsk_queue_add(nsk, nreq, child)) {
 					__NET_INC_STATS(sock_net(nsk),
 							LINUX_MIB_TCPMIGRATEREQSUCCESS);
 					reqsk_migrate_reset(req);
+					READ_ONCE(nsk->sk_data_ready)(nsk);
 				} else {
 					__NET_INC_STATS(sock_net(nsk),
 							LINUX_MIB_TCPMIGRATEREQFAILURE);
 					reqsk_migrate_reset(nreq);
 					__reqsk_free(nreq);
 				}
+				rcu_read_unlock();
 
 				/* inet_csk_reqsk_queue_add() has already
 				 * called inet_child_forget() on failure case.
-- 
2.43.0

