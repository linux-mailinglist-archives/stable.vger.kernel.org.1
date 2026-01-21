Return-Path: <stable+bounces-210896-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMt3GMoqcWniewAAu9opvQ
	(envelope-from <stable+bounces-210896-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:36:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE615C4DE
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF11138D3E1
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1C138B7BD;
	Wed, 21 Jan 2026 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RZd65uTF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E2038BDA0;
	Wed, 21 Jan 2026 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019748; cv=none; b=N0+Smn0FeXHMCnahlF4ncl6rQxCwWB9xAeKY4WZOP3tq+qI6ooim2GkcTXxmDIRAWeVIoUes6UrRvW1qAlmRo1FOoBsllg+pTNSq+lak/GQIZDThyNFTYcJYr4Rz8zvVfoJZdrxwR3q3ryRuYn46wxoW4d0fSUZL/NR5zfuSEdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019748; c=relaxed/simple;
	bh=/3af0CR9KH4II+Z+YiX0dqjgQRaodBBhV01JQQZZkmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGrt1k2pe2A1Gfv2R767Xpvce4ThdW4+cFKGiPB6ryhwxoElsXucUK3qCYDU2lgEvzK0XdmwN+Rj2V9Hk2ba1P7NFWcQO7ac5jQO/YH7E+/WVCO1TC4y2vRPBkSLZFqImy4VbWvXVXPNzaVXCaRd7Uqg9i+8QZKGdlFdwTbybi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RZd65uTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC5AC4CEF1;
	Wed, 21 Jan 2026 18:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019748;
	bh=/3af0CR9KH4II+Z+YiX0dqjgQRaodBBhV01JQQZZkmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RZd65uTF/HA5gQabQSLf1RTj5zNSgZJ3fff/P44dkkuxiSc6cd+ILrMCrb/JZQQeU
	 kz71jcCuVuqUGcmCx1UrTCpUcFIFT9gVF2oJshYAduO1OhUlp4cYHujzxMhjDpbRc0
	 jFS/7ky4nVg9oMK4S6kPv7FZw692B0VbDOMbK/Ag=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.12 063/139] io_uring: move local task_work in exit cancel loop
Date: Wed, 21 Jan 2026 19:15:11 +0100
Message-ID: <20260121181413.721718623@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
References: <20260121181411.452263583@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-210896-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[ams.mirrors.kernel.org:server fail,kernel.dk:server fail,linuxfoundation.org:server fail];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,kernel.dk:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: EDE615C4DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

commit da579f05ef0faada3559e7faddf761c75cdf85e1 upstream.

With IORING_SETUP_DEFER_TASKRUN, task work is queued to ctx->work_llist
(local work) rather than the fallback list. During io_ring_exit_work(),
io_move_task_work_from_local() was called once before the cancel loop,
moving work from work_llist to fallback_llist.

However, task work can be added to work_llist during the cancel loop
itself. There are two cases:

1) io_kill_timeouts() is called from io_uring_try_cancel_requests() to
cancel pending timeouts, and it adds task work via io_req_queue_tw_complete()
for each cancelled timeout:

2) URING_CMD requests like ublk can be completed via
io_uring_cmd_complete_in_task() from ublk_queue_rq() during canceling,
given ublk request queue is only quiesced when canceling the 1st uring_cmd.

Since io_allowed_defer_tw_run() returns false in io_ring_exit_work()
(kworker != submitter_task), io_run_local_work() is never invoked,
and the work_llist entries are never processed. This causes
io_uring_try_cancel_requests() to loop indefinitely, resulting in
100% CPU usage in kworker threads.

Fix this by moving io_move_task_work_from_local() inside the cancel
loop, ensuring any work on work_llist is moved to fallback before
each cancel attempt.

Cc: stable@vger.kernel.org
Fixes: c0e0d6ba25f1 ("io_uring: add IORING_SETUP_DEFER_TASKRUN")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2904,11 +2904,11 @@ static __cold void io_ring_exit_work(str
 			mutex_unlock(&ctx->uring_lock);
 		}
 
-		if (ctx->flags & IORING_SETUP_DEFER_TASKRUN)
-			io_move_task_work_from_local(ctx);
-
-		while (io_uring_try_cancel_requests(ctx, NULL, true))
+		do {
+			if (ctx->flags & IORING_SETUP_DEFER_TASKRUN)
+				io_move_task_work_from_local(ctx);
 			cond_resched();
+		} while (io_uring_try_cancel_requests(ctx, NULL, true));
 
 		if (ctx->sq_data) {
 			struct io_sq_data *sqd = ctx->sq_data;



