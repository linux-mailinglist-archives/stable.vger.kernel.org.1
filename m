Return-Path: <stable+bounces-224512-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ENJLIA8sGmohQIAu9opvQ
	(envelope-from <stable+bounces-224512-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 16:45:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E465253D82
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 16:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91B5732293A5
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 14:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805733002C8;
	Tue, 10 Mar 2026 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ui5Fef64"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8252F6577
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154530; cv=none; b=Bf5hRhiltxj6UKio+sEaJzx1OgW07x+eJfabiIJlgegEIsn0eMOmNaVoJDTR0AKwzF5hvnbukwtV6u3hGKg6cda+k6Uv0mbMu8iA6Qu1enfYQ6cauDYA3ksmUuYdkGg22XJIdR5bu9770BuNQZlTXncVxEO4I7oQJrWE0m6RpNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154530; c=relaxed/simple;
	bh=YIo57N2vcHVypstNB2cXBU3r9AT7FE4ZbnUQ6vqutMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwIdBGFJpea01RmIQd082dEiY7XCIgPQOvN/+X3rzzCBcj1OsRw6h2fwH81aKR34qXeMSNCNjzAmmCqqLF2mGrDnP9XuI71cfcJ+IBoGy3be1b99uH8KiBPbn9baGtfJuwGXSVXmahspGO1iBuhOMEG6Xjd7lQFUgQiVAU7+8Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ui5Fef64; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-466ebbf7ff7so929587b6e.1
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 07:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773154528; x=1773759328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UT/m7GaBXVbUKRMg37ABmfjMs9kKM0kDkv8WvMSyIRg=;
        b=Ui5Fef64Y7cc1vXZ2PqSKmIZVxSdRCWkS0Lg6mwe1iUfsq9KANbRNCnZ/FMQJMxATj
         QHFymeG9Tl/r1HOMgPXJreePTXYCip9Stf7oS0jZev52t1jnsEHab6Wq6n3yLTdHpSj8
         633geDe8muKV9jVjl6m0Cql/On6hwZW3qRdQArM/jkkWUzUcccHCHAnA+E4shE75h+dS
         P78+eRjU0w5pQWLWUb8FR7q3XFs7xsbOM5GVVVIWofXYPDJZXxIxhfdAu2HHZh2Hx6PQ
         ypVIG5HXJPclqZCLo1PTNMH/IXXLkPEde8Nqppi+xd69t9jvfudtTa04goMf2xgYSryh
         kZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773154528; x=1773759328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UT/m7GaBXVbUKRMg37ABmfjMs9kKM0kDkv8WvMSyIRg=;
        b=wzssQc2kqMR119JbOjLFFr25b5UVPqHlEIgpOWRtaS0VkLt44h4coY5UmGbaaGHCXU
         kP1T6aRippk1wKxQJLz8AOUl58Y8SXblDBFFae65Mp6lS/1TXj1iVljUQttxyj72BfZP
         z58SShkLGgYPzUAHwodlZRtVqABVvzzZAboXX8UZj8CQZxYiXmwTniYG3vtxGl6uO0tH
         DiHl37FTGOOXfZh+hQVdBBxnJaAmeZEoY/ystgMHeprLlr2VuWiqyrJoA8qsn4zeKZXt
         3/Q4u+fdc6/BzfGBFaY3hzCXMo3ASOb5f44IjYl17Y2zU0sXrZPHaCx2AOz/8+M9liDG
         MjcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjo/jDpn+v85tz1q9KdCwrkh2Qm3V1ontnbFLSgdRNmAzuXfOagshCmdKwbd4AziuLgzRNmy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz09dx0pl0rupbb/xCQYAi17rLP0E3UxhpJkmpWklZrEhCp1wU/
	X1mNNQtZOZ7teB4YV6F9GAv8LubAU+/5/d8V7zbVKHFdvE5HXSUpqX2/WH/PSP1/OPk=
X-Gm-Gg: ATEYQzwrLlwh67RBpz1QENeEBRmsLrtEUu6h8s8ZMJPui3RfGT0Wr6LvvSxannMV2fR
	frfcrqZuJH8QoAV7ahQAMHukjWaF1pVlDvobgXcuYvp3u2P0nvmhGD5P2D6D3VOzeuN3EPBVxyR
	k0X5Beu3VvvZj9YaDVjEtA24Ocrhsb6YwPJK/NT0Qd043ce0fgQF8sj8HnGj1Mtx/QAhzG0hOUN
	rXPkdSUeCpV2+vU2qlh0mHR5c9RFO8UD+vCl4fSAbR418BWBu4CqQr56nDERJrcpIr/1LrAAOWS
	w+SEZwt053ANy070IKeQ+zw8EoFCngSbzX33d/8n328X6PMc+jflKcjGXub9/gkyRz+CoxD5eCx
	v8lZWs3GZ7fOhg0eqxIpcCFWI9P0tXpOaqL7plG1T6knqfHhaE98H/ofgnYgYWrioCp+NAp5ZtZ
	rux5FBZZ5A8R9o0i9MN5sCROkFdcadjmOKUcBFriaWj8hHmNNaNRd7HywBgGCR/JJ1gQbt
X-Received: by 2002:a05:6808:c145:b0:467:b0f:997 with SMTP id 5614622812f47-4670b0f13a5mr4283225b6e.34.1773154527823;
        Tue, 10 Mar 2026 07:55:27 -0700 (PDT)
Received: from m2max ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466f429c7fcsm5786865b6e.9.2026.03.10.07.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 07:55:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	naup96721@gmail.com,
	Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] io_uring/eventfd: use ctx->rings_rcu for flags checking
Date: Tue, 10 Mar 2026 08:45:49 -0600
Message-ID: <20260310145521.68268-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310145521.68268-1-axboe@kernel.dk>
References: <20260310145521.68268-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0E465253D82
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224512-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,kernel.dk:mid,kernel.dk:email]
X-Rspamd-Action: no action

Similarly to what commit e78f7b70e837 did for local task work additions,
use ->rings_rcu under RCU rather than dereference ->rings directly. See
that commit for more details.

Cc: stable@vger.kernel.org
Fixes: 79cfe9e59c2a ("io_uring/register: add IORING_REGISTER_RESIZE_RINGS")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/eventfd.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/io_uring/eventfd.c b/io_uring/eventfd.c
index 78f8ab7db104..ab789e1ebe91 100644
--- a/io_uring/eventfd.c
+++ b/io_uring/eventfd.c
@@ -76,11 +76,15 @@ void io_eventfd_signal(struct io_ring_ctx *ctx, bool cqe_event)
 {
 	bool skip = false;
 	struct io_ev_fd *ev_fd;
-
-	if (READ_ONCE(ctx->rings->cq_flags) & IORING_CQ_EVENTFD_DISABLED)
-		return;
+	struct io_rings *rings;
 
 	guard(rcu)();
+
+	rings = rcu_dereference(ctx->rings_rcu);
+	if (!rings)
+		return;
+	if (READ_ONCE(rings->cq_flags) & IORING_CQ_EVENTFD_DISABLED)
+		return;
 	ev_fd = rcu_dereference(ctx->io_ev_fd);
 	/*
 	 * Check again if ev_fd exists in case an io_eventfd_unregister call
-- 
2.53.0


