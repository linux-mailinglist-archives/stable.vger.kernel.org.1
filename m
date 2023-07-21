Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6503775D34F
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjGUTJS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjGUTJR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:09:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E8F30E1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:09:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30D3D61D76
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4450CC433C7;
        Fri, 21 Jul 2023 19:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966552;
        bh=1Py5AHatNU3Bh007LbBLqzwgglpFtI8aSaLBIBVeL6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WTLnTjv3IhAB6WPq4WuJMppslYW8WqQf7hYbfFId80dGEf7PIcZJ6JUK1CAN2zcB0
         8j/nN7hC54a+5xUyRVpCJS9vMF2Th8nSKv0+YaWiC84VK3bn94U2+RwkL6I42N+JU3
         /soPX2TyUSYBWSY516fA0OYfoNWiSjAj5fRhSISk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.15 345/532] io_uring: wait interruptibly for request completions on exit
Date:   Fri, 21 Jul 2023 18:04:09 +0200
Message-ID: <20230721160633.150447529@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

commit 4826c59453b3b4677d6bf72814e7ababdea86949 upstream.

WHen the ring exits, cleanup is done and the final cancelation and
waiting on completions is done by io_ring_exit_work. That function is
invoked by kworker, which doesn't take any signals. Because of that, it
doesn't really matter if we wait for completions in TASK_INTERRUPTIBLE
or TASK_UNINTERRUPTIBLE state. However, it does matter to the hung task
detection checker!

Normally we expect cancelations and completions to happen rather
quickly. Some test cases, however, will exit the ring and park the
owning task stopped (eg via SIGSTOP). If the owning task needs to run
task_work to complete requests, then io_ring_exit_work won't make any
progress until the task is runnable again. Hence io_ring_exit_work can
trigger the hung task detection, which is particularly problematic if
panic-on-hung-task is enabled.

As the ring exit doesn't take signals to begin with, have it wait
interruptibly rather than uninterruptibly. io_uring has a separate
stuck-exit warning that triggers independently anyway, so we're not
really missing anything by making this switch.

Cc: stable@vger.kernel.org # 5.10+
Link: https://lore.kernel.org/r/b0e4aaef-7088-56ce-244c-976edeac0e66@kernel.dk
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -9714,7 +9714,18 @@ static void io_ring_exit_work(struct wor
 			/* there is little hope left, don't run it too often */
 			interval = HZ * 60;
 		}
-	} while (!wait_for_completion_timeout(&ctx->ref_comp, interval));
+		/*
+		 * This is really an uninterruptible wait, as it has to be
+		 * complete. But it's also run from a kworker, which doesn't
+		 * take signals, so it's fine to make it interruptible. This
+		 * avoids scenarios where we knowingly can wait much longer
+		 * on completions, for example if someone does a SIGSTOP on
+		 * a task that needs to finish task_work to make this loop
+		 * complete. That's a synthetic situation that should not
+		 * cause a stuck task backtrace, and hence a potential panic
+		 * on stuck tasks if that is enabled.
+		 */
+	} while (!wait_for_completion_interruptible_timeout(&ctx->ref_comp, interval));
 
 	init_completion(&exit.completion);
 	init_task_work(&exit.task_work, io_tctx_exit_cb);
@@ -9739,7 +9750,12 @@ static void io_ring_exit_work(struct wor
 		wake_up_process(node->task);
 
 		mutex_unlock(&ctx->uring_lock);
-		wait_for_completion(&exit.completion);
+		/*
+		 * See comment above for
+		 * wait_for_completion_interruptible_timeout() on why this
+		 * wait is marked as interruptible.
+		 */
+		wait_for_completion_interruptible(&exit.completion);
 		mutex_lock(&ctx->uring_lock);
 	}
 	mutex_unlock(&ctx->uring_lock);


