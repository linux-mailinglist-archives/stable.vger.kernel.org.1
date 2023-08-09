Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD26775931
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbjHIK6b (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjHIK63 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:58:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC471FFB
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:58:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B5AC63137
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8574DC433C8;
        Wed,  9 Aug 2023 10:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578705;
        bh=GXqGhnLt4xJRGT2DNn9pmvJ0byxo4tddCFaDbYeDtAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pa8owROvznooUMr/kGyziTm/uyTej10z14lfySv7brenKYnxN2f4Eaz8sK9g7/EFg
         yNokAzhsGAw0lsbIV0m/dDVkwN+V/8Ou6wfqoxVn5mgRoC8sfF+hSt2c/Ts/o1SH9Z
         iQXsc+ypV9BP0XhDADFnReBEWCJ/wq9BLRhkbS2A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Phil Elwell <phil@raspberrypi.com>,
        Andres Freund <andres@anarazel.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.15 01/92] io_uring: gate iowait schedule on having pending requests
Date:   Wed,  9 Aug 2023 12:40:37 +0200
Message-ID: <20230809103633.545449838@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103633.485906560@linuxfoundation.org>
References: <20230809103633.485906560@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

Commit 7b72d661f1f2f950ab8c12de7e2bc48bdac8ed69 upstream.

A previous commit made all cqring waits marked as iowait, as a way to
improve performance for short schedules with pending IO. However, for
use cases that have a special reaper thread that does nothing but
wait on events on the ring, this causes a cosmetic issue where we
know have one core marked as being "busy" with 100% iowait.

While this isn't a grave issue, it is confusing to users. Rather than
always mark us as being in iowait, gate setting of current->in_iowait
to 1 by whether or not the waiting task has pending requests.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/io-uring/CAMEGJJ2RxopfNQ7GNLhr7X9=bHXKo+G5OOe0LUq=+UgLXsv1Xg@mail.gmail.com/
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217699
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217700
Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Reported-by: Phil Elwell <phil@raspberrypi.com>
Tested-by: Andres Freund <andres@anarazel.de>
Fixes: 8a796565cec3 ("io_uring: Use io_schedule* in cqring wait")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.c |   23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -7802,12 +7802,21 @@ static int io_run_task_work_sig(void)
 	return -EINTR;
 }
 
+static bool current_pending_io(void)
+{
+	struct io_uring_task *tctx = current->io_uring;
+
+	if (!tctx)
+		return false;
+	return percpu_counter_read_positive(&tctx->inflight);
+}
+
 /* when returns >0, the caller should retry */
 static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 					  struct io_wait_queue *iowq,
 					  ktime_t *timeout)
 {
-	int token, ret;
+	int io_wait, ret;
 
 	/* make sure we run task_work before checking for signals */
 	ret = io_run_task_work_sig();
@@ -7818,15 +7827,17 @@ static inline int io_cqring_wait_schedul
 		return 1;
 
 	/*
-	 * Use io_schedule_prepare/finish, so cpufreq can take into account
-	 * that the task is waiting for IO - turns out to be important for low
-	 * QD IO.
+	 * Mark us as being in io_wait if we have pending requests, so cpufreq
+	 * can take into account that the task is waiting for IO - turns out
+	 * to be important for low QD IO.
 	 */
-	token = io_schedule_prepare();
+	io_wait = current->in_iowait;
+	if (current_pending_io())
+		current->in_iowait = 1;
 	ret = 1;
 	if (!schedule_hrtimeout(timeout, HRTIMER_MODE_ABS))
 		ret = -ETIME;
-	io_schedule_finish(token);
+	current->in_iowait = io_wait;
 	return ret;
 }
 


