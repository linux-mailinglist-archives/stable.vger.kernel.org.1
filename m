Return-Path: <stable+bounces-238604-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPWvNfbJ42kEKwEAu9opvQ
	(envelope-from <stable+bounces-238604-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 20:14:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9DC421EEB
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 20:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 245633016506
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 18:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37780331220;
	Sat, 18 Apr 2026 18:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IU0QsECp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D3C2C3259
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776536041; cv=none; b=lpqBlesMLM3sE5urQU/3YFBMYsxl10YuZvSv+RZtogc0iOdupO5I0VVNcPj7jZiwNS05iqlP7PTf1UH5jmCSSo5yukxP+n2lfMJpa8XhtHT4/h4PoO1NpQf901nVycVD3o8an4av3vwLFIb3Um7ZRb2qi5XwJg6TXxg15f4uMFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776536041; c=relaxed/simple;
	bh=usACHL7JFJ+Iojq2WMGOR+XEp5pZozfvJwRKATA+b/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cT5gBYDVPLXIzOpk9ZTA3Dvuug/vTulY2N1P9lS7iyCbpGD8yOWEcaF9q9Bo8QnXXD7W1dEZSZhH3x0Xok/WOY6YY6X7sdvKZp7CtI3qx3q9IkV+226XKsxKlT9l/fFntg64ZzM9fvZAUlVAk6FZr3GV0cUtAQ/i0gREAGMzwZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IU0QsECp; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82f68b3aaf7so620598b3a.0
        for <stable@vger.kernel.org>; Sat, 18 Apr 2026 11:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776536039; x=1777140839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qCHQt+5njpxpDnHvEMfTt2VrNOBnIxuj1+x6opPunc=;
        b=IU0QsECpAAiIVvNubSknYTQ4142KJvFFTxblP+0la2iD2AePiIK+V4TSAgNOx1bihu
         DWvTfc2YRjcKIGHXV38X78IMzLQfEasQc44j9POU0YSrYO9k1SttNj75r/NNul5sV6JG
         8Cr25l4GxFH3lDwAcQB3r8wWxZXTtJG0X3Fura4VMA0FDYsUmE2Pje4HYaIxZ77C627w
         gNOEXZZP8AtFZD7NM3zjl5WD8KxRdloxDWc652YqVXBkLO+LCRPTIhdTjMZhX4HoEbky
         oh8eiufk7LQfKLPYs2r2pQP3szqdAnDJbTJb0Xgp+q5jC2Wh9A8tXq/Fm5RXFFBVCUCf
         U4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776536039; x=1777140839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2qCHQt+5njpxpDnHvEMfTt2VrNOBnIxuj1+x6opPunc=;
        b=nTyapzxZAETnC+LtkSyqgnH3N33X3Zia8vci+jdYDw07V7UgbEA/KX8LggTJ28ggG+
         skwcW3nue4ck9IEysXoHzhLdw6Yak8jsSyW2J5CI9O1bkLBylDEc58q4Fe/HFvhhyPap
         HH3ZEF1SPfcxTxYsn0AAx8+7t0NPBGHds17Cfu27M2221DMhMVTga0x19BMbbKU9s/Xg
         1mwDo36dvnp6fw1XSAPmqqeYq+TJMpyO76Mrc+rrq2+BpOREusKhXqgLruoTiRxeQQK2
         cZmIXEXz4hSMkDtd6J3eE7o3+ws7tRjDeOGNncoso/e7sRqjLmMdkJpWasK6ATXGDX3b
         msMA==
X-Forwarded-Encrypted: i=1; AFNElJ8KboUs+d1aaqIFjW8+c5ZZDjrJQBdk2lT6u63j03IIKZ6f2KLVo7mOXJv/cFywgCxo3nMdV8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWKrmwDDwvc743mVH7zF+hykitziK33VGSX+IgcqjzmqKdULOK
	B4fs2QzuUjtneUsiyixftKUj3Mqh3xOgC7v5hnA6pr3IWiFvsXkj7B2K
X-Gm-Gg: AeBDiev0qyfW/8O0yDlm6VQMKrpXTHz4lUBM1JOhXt5RtG/SZpmDZ5vPj6eKk2FnDzu
	vWeYMAeQUMG3FGRiDiimeLIFVewYifWdqYOvhTV9pZdyN6f4lmB2uXzjk/tvJJEou13+GbVBT8q
	4ojbG7u2Q24NVHkHFjn5WgH6BZTAcfmth4nQE8qzW7VE/pPhLsIKsH8z1Gv8u/Vlr70uz/pRfbg
	q9SoT50DDVzkq9Bj+pzom87vP5lkTdX/ucHJ+ywKbFfaVon6xHDhAuYYSmV605pBP9NpMnT41BN
	glBgD5/VXazRUnIhMxkJlYlXNo02CLX9X09xqZ/qPqb8vsgyEm3BGEPAhYWMgJ6TD9vMvcaYIis
	7v248XY1jhb8GutQx5BirfRD2WVuzpxY0T6Kxr8eG99Q3tMFCCsEISZD6mfba80HJusXfcjQNWF
	nSHoNIdzmNBJIQk5CsswXqeIWc0j4hv2WhCh8Gj3dj5KhimcCX3tUfStPWMX9iXg==
X-Received: by 2002:a05:6a00:3397:b0:82a:6852:559e with SMTP id d2e1a72fcca58-82f8c82165amr8311427b3a.12.1776536039025;
        Sat, 18 Apr 2026 11:13:59 -0700 (PDT)
Received: from DESKTOP-MUHC17F.tail07b66e.ts.net ([188.253.121.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9f7735sm5659402b3a.21.2026.04.18.11.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 11:13:58 -0700 (PDT)
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
Subject: [PATCH net v2 1/2] tcp: call sk_data_ready() after listener migration
Date: Sun, 19 Apr 2026 02:13:32 +0800
Message-ID: <20260418181333.1713389-2-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260418181333.1713389-1-jt26wzz@gmail.com>
References: <20260418181333.1713389-1-jt26wzz@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-238604-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jt26wzz@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F9DC421EEB
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


