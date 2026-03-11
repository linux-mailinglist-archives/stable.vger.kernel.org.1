Return-Path: <stable+bounces-224690-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IR9JZ1qsWnsugIAu9opvQ
	(envelope-from <stable+bounces-224690-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 14:14:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 500EC2643C2
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 14:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C8DC301F79C
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 13:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDD430AD10;
	Wed, 11 Mar 2026 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bStZEc5b"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480A62FFF90
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234826; cv=none; b=pVwn6nJI1yqqX8AYNktgykrbfne+fJt1SiLtjH3/EE7zSAV4d3yygh62aHBjyZlsYRAz8Ejm4Yg0Aa+9cCZnW+gYi9LlNbxwyjZ6MHeTLS1UcijjM2dvuZ0syHDC9Q5A0UTOh6Ao5RrG2EMkuP0y7Ri19RreVjqHN/uKUjMcapc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234826; c=relaxed/simple;
	bh=YIo57N2vcHVypstNB2cXBU3r9AT7FE4ZbnUQ6vqutMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWV5Mj/u606ee3zcdKFcDR/jZ+qZgtX3GqfWH7C1STgaeVxVU6hoKKlnBOvQgRdYlP7suo7iDGcsbHgRxAziOqebdaAp2e5YwjlZzctxPoKr1WKHA7iyezQ4GhpX1/r7iTHj4fkDEsr2wL8D+yq45Lw2RiniGku/QiptIhgOq5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bStZEc5b; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-41708f6aa5fso2712766fac.2
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 06:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773234824; x=1773839624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UT/m7GaBXVbUKRMg37ABmfjMs9kKM0kDkv8WvMSyIRg=;
        b=bStZEc5bEbj8+pARWmCwMlaLxfXHJG1mZrbOgdkShRx/cGMKdvzX5F5kKn/TRr02sE
         Ob1ID38c5nd5BtevF9WvKTYlk9FQEs1Qq+14xgXwFFPBdMzxq5njHhH5uRKkQPwCNlqe
         auHQtDJSyrMfo567WcUHJrYaOsiZNB25k+DWQzO5NE//kz0moiMOZit1Eo/V9cYsq9GL
         CNWHZhlU0lIms9P8AnG3hHn9sHBRXJHNmoy4ExKng3VhQP6CJ7FoXX2+H5BjPAJ6e+QQ
         rI6hmgz4+CCobXXRvrbgoFO9kZ6aKjdM/1dv39IWKQsm0tNiXSG9IDUSbZ2MwaNbovrA
         I9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773234824; x=1773839624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UT/m7GaBXVbUKRMg37ABmfjMs9kKM0kDkv8WvMSyIRg=;
        b=g8NXY8Uqu+eKXZIt0nMfWZnHRRjQ0V4Gp1iXwCK03TsO0nbm3nxr76BQa1RY/XsrfT
         yuAADJvCqi0UhnzNYyu9PIuIYjbcfzSWDqg62RUwtJhYJtBuKzo/rrkresm2mZEEhKBI
         DmLHCHJuIdqT18w76pIxz++i+qZesH3LZJT+tBzSlVe/Pw2gtWS/QAr7KUWwg9oavxyk
         CQaw/gbdMdkxZblmVEgzmwMru+t1N1T+C6WzvybkdNkhsa/IsutIRFwMM1FXQhLkR4lL
         5FtD7m4Nw3d85T8tik6NVcaRF69urXfdoWepSCCArGsYSBHsBiZyYtkV4GBNDDRlHXp/
         fwJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7Ve+KQdewhOY6+vYqe9J5zsH1Fx+0VjtPP9CKCE1vdkITotLISEURJ+h7GziVQY9xQcBltRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBIGm5Po/S6lwEqfm7tkJY2L09qK7YEA4uUjFKOxhPjef82VSt
	4/gSo2fJzT0qr1/FeNTSfA6fCdSsf5PaBlRdRvacTSXs5bCk9Nfjp4/g3W3tybJxsJA=
X-Gm-Gg: ATEYQzxLduPUoUzIjuHqwEdhqtO4UJGLNvuwW0y1P8OQW2yNi37qtF6z0LCrGzjAwKo
	F93JO+T1kqCqHsW59kyTvdU7JCUQPoD/iLNtfMk7jURMYXre7f+jBk6tCY9/XHG9aiKA81o/d81
	rF3byyXN7zxeYjta/RWoyJkASajn+1Umrt/NNVmE0s3PfRskIDIxMlUYUq2/aM4WNoP3i3W73j0
	Uv9NF2E/KaW/vj6Ak9Ck9S5dvWMBlvCJUnQpDgs/XsNc8QnXJmFvqw5U1BqBQWR0VB0Bfrrr7SH
	xSa5qr/pr0LmqWE8dqnsnrrnCP9J47E9S9ghjMWorlP3PPTvNuJ8RE1oUlXQZGx0TT8Ac5dVds/
	GluUbPNKDbVaYF//+FqxCtIqkKz+K6/V6UQSvbYUqzFPCG7Tzgzj0g+3s/VwYYlVAujT9R+1c+G
	hihwW+bkFTgUd3HMSCVvu6WLNPr2+zcV+o5BnTQ6V8v0Lr78YvBD+pcJRtectNcQsqH1wJ
X-Received: by 2002:a05:6871:7291:b0:417:4a1a:4376 with SMTP id 586e51a60fabf-4177c8d0c1dmr1527742fac.13.1773234824160;
        Wed, 11 Mar 2026 06:13:44 -0700 (PDT)
Received: from m2max ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm2286127fac.12.2026.03.11.06.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 06:13:43 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	naup96721@gmail.com,
	Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] io_uring/eventfd: use ctx->rings_rcu for flags checking
Date: Wed, 11 Mar 2026 07:11:56 -0600
Message-ID: <20260311131336.197028-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311131336.197028-1-axboe@kernel.dk>
References: <20260311131336.197028-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 500EC2643C2
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
	TAGGED_FROM(0.00)[bounces-224690-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,kernel.dk:mid,kernel.dk:email]
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


