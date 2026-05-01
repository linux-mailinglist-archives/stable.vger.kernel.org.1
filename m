Return-Path: <stable+bounces-242547-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GOjBdcu9WknJQIAu9opvQ
	(envelope-from <stable+bounces-242547-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 00:53:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D604B01C2
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 00:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0AB33020A51
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 22:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0EC37CD5F;
	Fri,  1 May 2026 22:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sa/gNfIh"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FCB37CD4E
	for <stable@vger.kernel.org>; Fri,  1 May 2026 22:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777675978; cv=none; b=qFY0Cxfnvrw6TZya5nKH4xpchbAHSK0awG5mYgo1uoNcX1ne17obwLInpcxpSrwPnmmwAbWy9rQkwQYQgpKSXYcctnXDSbvdXttCIPPl00a9CO1mbPSbYh+91F3Na2Y+Ws6fOumaB8GTsd39agBAiQl5OUVornmxA5B1xkrGkTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777675978; c=relaxed/simple;
	bh=eCti1xRsMGpyyZrSZkycdAP+G/8UNY44EFUBVRuS/ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ar/QNmeehb2YTQlO2ZztmzGQ4t6jEtjee381fMiBYJGE8b7HQBJpLa6O3p28q4fNWsJdGZyJnd/FYllcvDX48sp6+bB5WXwWZsUKwKDKgdFhpSIeRh4hplPA4ERGg+tNfo5Ne9SGLoj3YYqIxKNXTxWDOk/WPVDkudc/rDlRRgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sa/gNfIh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so22046365e9.0
        for <stable@vger.kernel.org>; Fri, 01 May 2026 15:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777675975; x=1778280775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oStFlhcdakP6edPipTY7ZxFrfWf7cQBJS3cGZ4Djgkk=;
        b=sa/gNfIhGoU7vNrOsyd6p86c5Hd7D5Pu7SL4q1AoqoNcaRmEPQCdjihlKf/ODIY2Eo
         aLGDkIR9jtEJzoYhAA5iPhc03QQk1UKM21N01c8ZJL+/ncLDz5JnB9IEcLE6hYxxbUzn
         H+JtSFWcveQRf5ww5dZaN14lc2x4u70WlzsB9lYjJuBAuQGAv4a/yDmTT1Ur5bQmeE/u
         cD5T78CpdMjvekrwOEE4fEWqFTwWJspRV2ZM9OFGtkRPR7MCl9UaMhJzxtox2BkzzQkS
         BXmj4Tl4S8NaA5pc0j8FCMTyEq4wJTF97/oZ3L/WBJ9dtNWej7YqIK6uVJyHlWrzkeKe
         HtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777675975; x=1778280775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oStFlhcdakP6edPipTY7ZxFrfWf7cQBJS3cGZ4Djgkk=;
        b=hFRkr24velJCFdhW9xNelBtJVXMwmgQP5/pO9dMpGaSNZN3inbhvcwAoUL7Hfp6Jtc
         WGEfybpCYfRSi4Q/OBax8oO4zikgibeak92fyAySbsDnGy0KpWlEQKX5rnlhIGGdbuJ1
         7J8oq3vw4523B/UlUlfhs9R8YMNTW1TUHN08/A/LzFBzCHgosA3AWb0MUuiF38tY0vaI
         fQth6jKM5w1EEAtEvMU6ouO4kjfrqwkh0zbF/9lRn7OBdPcoPFHqSaS8a3FUxh6Y8OPd
         jvUrSbV4MfPC/Qk9fBC83T3xbKATdhhXud1Nc2CVPbTuXCfcRXNa5QoH30FwE7txLGP8
         PIIA==
X-Gm-Message-State: AOJu0YyCwMZ40thcOo8qGnu5alwLhMFlVoX0PJ9JdTxvn6X0TB/El9sZ
	yAd9sGGe0MlDYB6K0n1bkpwULPwsROvxvbLhcyVr5MpcKn1cKwcCTaOUYeE3r7JG
X-Gm-Gg: AeBDieusecfiLNY9wn1x9zXZEXJ82kuO5XttT+xPn/sFtFQmycW6UFbXOsJMF9u+BbY
	6Mjm/gNEyoQknwxBQiT29g9+L258t2KVR4ibQCMUyMRnILa03zenovCOjwCkquVKuyBY6Llztra
	gm0lZabwnRjQriIWD2lLWRq7yj0dq/x8xhmugPbfFbJYsJUxzkl+ECLUcxVMtG+ESznqBpnl0Pl
	Heo1Ws9YYwjX+DB97ir081TnfttEIcZh8cKwDK0tqxtfUbL5hq70bnj3LFR2tW7hW7JXHg9rRZL
	cv4MF+o3ev2Q0Gb7YYARJqnMRFT3hRgHE4z7+4N5KC+LnVP7d2pN3MJ6Pj1MWQegn2WLlqtiNwQ
	QgvNFusbl39ZNH0QI4Nop25lCea/rQkv2YDQXJfrQe8sMnqYNy7QkGpTQBxtK6vFDHk5U+saD9j
	iXgFXMOSO1bn6qI3c16DSEMcZqoX5xYugwygP/gQ2zIDYsvuZuU0WAMrXtK5hIrY4ijM30qQzeg
	peXdZ2SH0prBWHB8xuYnt0yQQ==
X-Received: by 2002:a05:600c:800f:b0:488:ffb1:494c with SMTP id 5b1f17b1804b1-48a9863a372mr14640435e9.12.1777675975040;
        Fri, 01 May 2026 15:52:55 -0700 (PDT)
Received: from localhost.localdomain ([77.124.36.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fe93266sm23857045e9.3.2026.05.01.15.52.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 01 May 2026 15:52:54 -0700 (PDT)
From: Kai Aizen <kai.aizen.dev@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	axboe@kernel.dk,
	io-uring@vger.kernel.org
Subject: [PATCH 6.1.y] io_uring/poll: fix multishot recv missing EOF on wakeup race
Date: Sat,  2 May 2026 01:51:56 +0300
Message-ID: <20260501225250.90152-3-kai.aizen.dev@gmail.com>
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
X-Rspamd-Queue-Id: B1D604B01C2
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
	TAGGED_FROM(0.00)[bounces-242547-lists,stable=lfdr.de];
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

Backport notes for linux-6.1.y:
  - In 6.1.y the do-while masks v in the while-condition itself, so
    v can carry IO_POLL_RETRY_FLAG/IO_POLL_CANCEL_FLAG bits when we
    reach the multishot branch.  The HUP check therefore compares
    `(v & IO_POLL_REF_MASK) != 1` rather than the upstream `v != 1`.
  - io_poll_issue takes `bool *locked` here (renamed to `ts` in 6.6+).
  - 6.1.y has no IOU_REQUEUE return path; only IOU_STOP_MULTISHOT.

CVE: CVE-2026-23473
Cc: stable@vger.kernel.org # 6.1.y
Fixes: dbc2564cfe0f ("io_uring: let fast poll support multishot")
Reported-by: Francis Brosseau <francis@malagauche.com>
Link: https://github.com/axboe/liburing/issues/1549
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[backport for linux-6.1.y, verified 2026-05-01]
---
 io_uring/poll.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/io_uring/poll.c b/io_uring/poll.c
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -303,7 +303,13 @@ static int io_poll_check_events(struct io_kiocb *req, bool *locked)
 				return IOU_POLL_REMOVE_POLL_USE_RES;
 			}
 		} else {
-			int ret = io_poll_issue(req, locked);
+			int ret;
+
+			/* multiple refs and HUP, ensure we loop once more */
+			if ((req->cqe.res & (POLLHUP | POLLRDHUP)) &&
+			    (v & IO_POLL_REF_MASK) != 1)
+				v--;
+			ret = io_poll_issue(req, locked);
 			io_kbuf_recycle(req, 0);

 			if (ret == IOU_STOP_MULTISHOT)
--
2.43.0


