Return-Path: <stable+bounces-238542-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IF3nIvUF42kUBgEAu9opvQ
	(envelope-from <stable+bounces-238542-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 06:17:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D4F41FE91
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 06:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DF20300F282
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 04:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FEC33DEFC;
	Sat, 18 Apr 2026 04:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h91FiJXa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0112857EA
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 04:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776485847; cv=none; b=MA5BEBQnYa7/ahapP8trmR+GYVEYKClzzNasxM1bOm8ogdk5qVAvXJ9ljLa59YVpcGezY0uEuDY5gV5wknZf5uVIN77vvo7ZNfenhTNLOoXx6FuxpIbD+z4akUQdfx64WlXnad8w2OsMFh48cupoNDXn/iIsKFvDXb7u9rTrEG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776485847; c=relaxed/simple;
	bh=DNeuuui43Z7WUckyxw1/kPzB8/wmhhyPAn6t/FTVdRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRgXdzrq8Sltt8dDxBf4mW9xiQPKWObWu8rh66mv2L0cEMbvlZJ3QghO/ZOBURAYFAdWaeH/NbY/xKnTnOruqvMZhfAPHyYsrRY7HdzSfW5wzwazgUwPuRFe3j3kHYv8bwRO0lq268sbkJDlcWIURhSCbuiT4Y9UUAHWxnN/RV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h91FiJXa; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f431c0ab6so638635b3a.0
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 21:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776485846; x=1777090646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LhJmNKzbi8lgBR/6qaGu+UXTmOuN+KpkyQcs/Gar+k=;
        b=h91FiJXaMX1ycer1et/ZVCtRWpbDAi0Skejbc3gg4os6SkRZX07Nx/qQJCQ1QA68+b
         MHMD6XO2+PBE+NXpTtLhWd1NmjL90rt/dfL04DFXmH3EzJuX1QCHUfhlZ+zO+5krrr1m
         zbyn4Rp8sqaa19KAxIw0/u/gk7mIjUd3yiJv+fsrk8vNf7KbZakohizxTaetfc8Y0FeQ
         02Z30XdRBSvIGNIcAH6dmpMVQ59DOrIbSr3irbo7cHoMdWLRlwKuJbaQFjAaessqOy9e
         SBy2I2GvxZoVffKmh8S8WgX6AaAxmAcodBDQedv/JbG8rhKhOoOg5A17qNB6p41li29M
         5otQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776485846; x=1777090646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9LhJmNKzbi8lgBR/6qaGu+UXTmOuN+KpkyQcs/Gar+k=;
        b=POtTZCe7xONT1axFP7qT+OHsna6ic+HUpAUXaTmIueELSMu3H1mSQO4Fn9+5nmF4Oa
         PonB9wNQh+GH7ulMf1IyRPxvfoioA4jwYln0cUX9qAE1Z63TXBHxbzv+I3qgzBQngnH5
         hK/izHFqEh3e7vmi0RYY6ocWMoT+lP6wRdbLI1TGdEUXktTC3A8ZzB/YSQ2qMilZet6s
         UOlbYtBfDEQ1MJe67jZWXcJz8Ky3GtxW1Hp9yQFTM9TAxWzqosvGMETrpxtrWwxCWMcL
         IufXTFZjwYyQm1weHEYm5v5zC58dmu46CTYaw7pzcZxt0pCMRX2y7g5rq9tqsaROKyVD
         yS6A==
X-Forwarded-Encrypted: i=1; AFNElJ9IENp1pFhVfpnqNXxxUyyd/Kd+JXzCiDCwsQ1Zkg3u1aeDAEARv8GdJm1yc9rLza2o38xX9aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJjQK1iopyDdzDWOACShhiIvrRV7irfcZ+AiOtTnGbfhOQp9ih
	GmmlILXSs33wvoXzAEvKA0npES8qD5zx8bcfOeYZF+l2VE9zOO9xUfhX
X-Gm-Gg: AeBDiesWepsOy/rLoy5L8RVCIF3hScXtWilcr+ezRf8C909Gub29cz6lJfk/Cpbwoj3
	tUokgmFjXiCmgrw0LdH/ZKP7WJ4Z74gBKijdbsYda2KmLSzou2JThO20caJhVcQPtXY36yVYTnr
	YSqYT7EsWjofvX6E7q3jp4hApveDVODY/stEY8m3jYZTfCvT8PYMCj3OFwkWizVlFT4HaWCeatd
	smpymOkiQIWo2FpUSqHbdKt5Ab2qsZg3/WnDrDKaGlUKOJ/AgOovYaKitUIBze0WlENpB1S25jG
	H3DLkZioUj4Kz705HOsxFLrL6PI2gQqVt9PPLZTbnc7XA7qfT2mQFUWe7NE4Vi4Eqt3++kA9H6u
	ryBHq7WIicBwRt2BSEmDcUDNqc2Cnwe9ZFcAQJwUivREhWy/G4qr67q3honi0f9gkczR4qi2IEp
	AimP6/9bOsk4owWMcOlTlSGHyXbbV6DX28KnGieAznF29GGnAhZh282mmFOKYwrQ==
X-Received: by 2002:a05:6a00:3028:b0:82f:6640:7229 with SMTP id d2e1a72fcca58-82f8c91c9femr5819948b3a.23.1776485845707;
        Fri, 17 Apr 2026 21:17:25 -0700 (PDT)
Received: from DESKTOP-MUHC17F.tail07b66e.ts.net ([188.253.121.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981992sm4356787b3a.7.2026.04.17.21.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 21:17:25 -0700 (PDT)
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
Subject: [PATCH net 1/2] tcp: call sk_data_ready() after listener migration
Date: Sat, 18 Apr 2026 12:16:32 +0800
Message-ID: <20260418041633.691435-2-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260418041633.691435-1-jt26wzz@gmail.com>
References: <20260418041633.691435-1-jt26wzz@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-238542-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0D4F41FE91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When inet_csk_listen_stop() migrates an established child socket from
a closing listener to another socket in the same SO_REUSEPORT group,
the target listener gets a new accept-queue entry via
inet_csk_reqsk_queue_add(), but that path never notifies the target
listener's waiters.

As a result, a nonblocking accept() still succeeds because it checks
the accept queue directly, but waiters that sleep for listener
readiness can remain asleep until another connection generates a
wakeup. This affects poll()/epoll_wait()-based waiters, and can also
leave a blocking accept() asleep after migration even though the
child is already in the target listener's accept queue.

This was observed in a local test where listener A completed the
handshake, queued the child, and was closed before userspace called
accept(). The child was migrated to listener B, but listener B never
received a wakeup for the migrated accept-queue entry.

Call READ_ONCE(nsk->sk_data_ready)(nsk) after a successful migration
in inet_csk_listen_stop().

The reqsk_timer_handler() path does not need the same change:
half-open requests only become readable to userspace when the final
ACK completes the handshake, and tcp_child_process() already wakes
the listener in that case.

Fixes: 54b92e841937 ("tcp: Migrate TCP_ESTABLISHED/TCP_SYN_RECV sockets in accept queues.")
Cc: stable@vger.kernel.org
Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 net/ipv4/inet_connection_sock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 4ac3ae1bc..da1ce082f 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1483,6 +1483,7 @@ void inet_csk_listen_stop(struct sock *sk)
 					__NET_INC_STATS(sock_net(nsk),
 							LINUX_MIB_TCPMIGRATEREQSUCCESS);
 					reqsk_migrate_reset(req);
+					READ_ONCE(nsk->sk_data_ready)(nsk);
 				} else {
 					__NET_INC_STATS(sock_net(nsk),
 							LINUX_MIB_TCPMIGRATEREQFAILURE);
-- 
2.43.0


