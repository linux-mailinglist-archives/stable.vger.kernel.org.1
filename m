Return-Path: <stable+bounces-242546-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FubGdIu9WknJQIAu9opvQ
	(envelope-from <stable+bounces-242546-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 00:53:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FF54B01AE
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 00:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8B35301DE09
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 22:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6416237D120;
	Fri,  1 May 2026 22:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEahbwYm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69DE37C924
	for <stable@vger.kernel.org>; Fri,  1 May 2026 22:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777675977; cv=none; b=l1mNBeWk8pd5OU3tD6jV64euDT+lZPJQamKsAx02/Cc8ixyGtAVcqUQW4mFGdhuH+BjKRpwF2CvkU24VnLLwh8JnlS2pTWbpg0JY05PccyEMz0hva2u/d6eUndQXlhL7pCZiSqitzyTq+znJ2qvkeT7ftu1tMo42cLfzCV2OwA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777675977; c=relaxed/simple;
	bh=KbPF2RtAp5GA4ixDDuFKfIoCxIwrgo/0CFOYS2TseVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OuNa5zG+wXzWTbgPHs/t9yyX5TczREk+vv0ai83/mUT8xdSLL9WJilzL8UphX55/J3ptheARrVm689MJTFMhWyqyPz94h4RLbDyVaxFrIv7BiWPN34sWvIMVmV7w3dkQhuywF8CZlxS8PgAHGJ/ou2gGevca7b/Lk/2CQz+PZ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEahbwYm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso16033715e9.3
        for <stable@vger.kernel.org>; Fri, 01 May 2026 15:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777675974; x=1778280774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1w8ThLqZd25cwWjWBnDyIz33tp+IZal5hIPijMDDLM=;
        b=NEahbwYmHJxrj7a3G42T0LonHxglkL3Ifu6aShWdcOd+5uHT05oajQk154FGs9GHA6
         cH0Rkivwaz+wnenuuCCYti3rpBeEYy6MphelDSR3UNt7GQZaIofmxZzCaSXmOIPkS5bU
         18H2mPWsen1GZGGfUAsFGzUwL+xn/bSctd3PQWfanw0nVZF95XwTQNICG94YTj5o+QoB
         UR1BQRwn9coAbIgneYQ2xUs0qaIpn1OaGabj3Qt8LMfLIoayrtRSoPhRJqWW1veiimrO
         /ejTMFKpD0B/tA22+uF3kpmjp+7oDH4zuNI3dXMsxtjr95s/PCnbzoqg++uYslwSIdMP
         eJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777675974; x=1778280774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u1w8ThLqZd25cwWjWBnDyIz33tp+IZal5hIPijMDDLM=;
        b=oyZmCoontSMxg9c/cdlu0qmrO6aJzJ2vmRCuRhSCDHdEt2WlTwP2q63DVTZXhBVbVT
         V9hk4UYxMada77swxl/9BzPjuONhpXzDgCKaPb17jsil6g4QQ7Qkx8/hbeYPtpWSnEnz
         uhTQZpJll4km7wi7DvpuVINbvjYYi+sueAmGxC779k3DVt6LnbRFM3WDW8Tvnb/9CxhW
         Pi5qUSvhphPw/LGWT3EnDDVgM8EQ6sEtffLvRhWM4z6t8aWUOEq74RKsl9Sp+P1pCifG
         dIIu6dweVjNyObop2HUW2D1N17Eyq+lk5yqy5QGBKsLWPBznu/ZDFUpvzeKG2ljauht5
         TL3g==
X-Gm-Message-State: AOJu0YwJjC21Bytwt5vyhAh3NnsFFJj+XrCEvHISZ1wM3sClUIwi4aIZ
	28ZhOvot0DY/3mW/w+EUbL8q3B1+q1tvvknmGIonroeTWJQv4Jtvy323cDcN4lZO
X-Gm-Gg: AeBDieus+07Nuj36WIK5J62f0wF/Q/1BF1qGL6i2HIe+niMqVU26t/BDDz5jX0ldg/2
	NooZZQIg2D2d0VMeEAyneh7Y16Gvg94mYMvs6lT96MKkN50g7nQVaUzeM7UQyx5X2ZRcCSS/RGx
	V0ICHZdVJ5eZ8KfhUd5k+OpYUb4mafb5Aq8jpcEjtclvsGAde+/Zais/aUbNh2FtWIiXmzIH1y1
	MUunV3UI9jOHibkhMK6T7Id4j26e7xULN5tz82KgZpmbloTWhGFVM8M24IT5Z2DZ7qOMQw34wI2
	awTD6nD/qk+BvrUKfrdsb5ys8cDrpLuWtS0RQFiHQjrbiXXGWSOFz807emmGw5fU8fzP1k7S8ex
	PoevIUNLjiXKvJm7i3JPkLZEv9/Hr61Jjcfzm+pdgr91d9NXWsoBVLh29bn17/u3/SQYtQzn46p
	4je3/JRP5+jXz+jiA3anhhuyOEgc1Y6g+TeMowZ4VymTdvwoBkjk/TEcJHukD+7R5pZq717KJ48
	IvokSO0W4MuLR0Hojk6FxX9Wg==
X-Received: by 2002:a05:600c:621a:b0:488:bfc3:efc with SMTP id 5b1f17b1804b1-48a980fb94dmr14665835e9.0.1777675974024;
        Fri, 01 May 2026 15:52:54 -0700 (PDT)
Received: from localhost.localdomain ([77.124.36.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fe93266sm23857045e9.3.2026.05.01.15.52.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 01 May 2026 15:52:53 -0700 (PDT)
From: Kai Aizen <kai.aizen.dev@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	axboe@kernel.dk,
	io-uring@vger.kernel.org
Subject: [PATCH 6.6.y] io_uring/poll: fix multishot recv missing EOF on wakeup race
Date: Sat,  2 May 2026 01:51:55 +0300
Message-ID: <20260501225250.90152-2-kai.aizen.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501225250.90152-1-kai.aizen.dev@gmail.com>
References: <20260501225250.90152-1-kai.aizen.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 05FF54B01AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-242546-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaiaizendev@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel.dk:email]

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit a68ed2df72131447d131531a08fe4dfcf4fa4653 ]

When a socket send and shutdown() happen back-to-back, both fire
wake-ups before the receiver's task_work has a chance to run. The first
wake gets poll ownership (poll_refs=1), and the second bumps it to 2.
When io_poll_check_events() runs, it calls io_poll_issue() which does a
recv that reads the data and returns IOU_RETRY. The loop then drains all
accumulated refs (atomic_sub_return(2) -> 0) and exits, even though only
the first event was consumed. Since the shutdown is a persistent state
change, no further wakeups will happen, and the multishot recv can hang
forever.

Check specifically for HUP in the poll loop, and ensure that another
loop is done to check for status if more than a single poll activation
is pending. This ensures we don't lose the shutdown event.

Backport notes for linux-6.6.y:
  - In 6.6.y the do-while masks v in the while-condition itself
    (`atomic_sub_return(v & IO_POLL_REF_MASK, ...) & IO_POLL_REF_MASK`),
    so v can carry IO_POLL_RETRY_FLAG / IO_POLL_CANCEL_FLAG bits when
    we reach the multishot branch.  The HUP check therefore compares
    `(v & IO_POLL_REF_MASK) != 1` rather than the upstream
    `v != 1`, to avoid reacting to flag bits.
  - io_poll_issue takes `ts` (struct io_tw_state *) here.

CVE: CVE-2026-23473
Cc: stable@vger.kernel.org # 6.6.y
Fixes: dbc2564cfe0f ("io_uring: let fast poll support multishot")
Reported-by: Francis Brosseau <francis@malagauche.com>
Link: https://github.com/axboe/liburing/issues/1549
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[backport for linux-6.6.y, verified 2026-05-01]
---
 io_uring/poll.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/io_uring/poll.c b/io_uring/poll.c
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -321,7 +321,13 @@ static int io_poll_check_events(struct io_kiocb *req, struct io_tw_state *ts)
 				return IOU_POLL_REMOVE_POLL_USE_RES;
 			}
 		} else {
-			int ret = io_poll_issue(req, ts);
+			int ret;
+
+			/* multiple refs and HUP, ensure we loop once more */
+			if ((req->cqe.res & (POLLHUP | POLLRDHUP)) &&
+			    (v & IO_POLL_REF_MASK) != 1)
+				v--;
+			ret = io_poll_issue(req, ts);
 			if (ret == IOU_STOP_MULTISHOT)
 				return IOU_POLL_REMOVE_POLL_USE_RES;
 			else if (ret == IOU_REQUEUE)
--
2.43.0


