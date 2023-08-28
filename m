Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542FC78ADA4
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjH1KuJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjH1Ktv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:49:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A6ACDB
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:49:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EB9A6439D
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BE7C433C7;
        Mon, 28 Aug 2023 10:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219764;
        bh=Z092d5NLjo7Ug59mMqxLITYylBl62zxmI8w5Fy2htLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VHqNCATkOxTK/sSwX6OLKiFFLhKKbwYxNMrVPOeBJpCYunVL2idJqwjgntcXIhfH0
         1LwU/z4Wrr9ZCdz8nxOLCUW2G5ie9UmQa4LHS0Vut7PgRTm3UeS1F29JYAw57EJ6I7
         qCdGYw2zP/0X+rXYqP+M5YnV4dxXbxrkxYSyxPEc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 5.10 63/84] torture: Fix hang during kthread shutdown phase
Date:   Mon, 28 Aug 2023 12:14:20 +0200
Message-ID: <20230828101151.397401371@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101149.146126827@linuxfoundation.org>
References: <20230828101149.146126827@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joel Fernandes (Google) <joel@joelfernandes.org>

commit d52d3a2bf408ff86f3a79560b5cce80efb340239 upstream.

During rcutorture shutdown, the rcu_torture_cleanup() function calls
torture_cleanup_begin(), which sets the fullstop global variable to
FULLSTOP_RMMOD. This causes the rcutorture threads for readers and
fakewriters to exit all of their "while" loops and start shutting down.

They then call torture_kthread_stopping(), which in turn waits for
kthread_stop() to be called.  However, rcu_torture_cleanup() has
not yet called kthread_stop() on those threads, and before it gets a
chance to do so, multiple instances of torture_kthread_stopping() invoke
schedule_timeout_interruptible(1) in a tight loop.  Tracing confirms that
TIMER_SOFTIRQ can then continuously execute timer callbacks.  If that
TIMER_SOFTIRQ preempts the task executing rcu_torture_cleanup(), that
task might never invoke kthread_stop().

This commit improves this situation by increasing the timeout passed to
schedule_timeout_interruptible() from one jiffy to 1/20th of a second.
This change prevents TIMER_SOFTIRQ from monopolizing its CPU, thus
allowing rcu_torture_cleanup() to carry out the needed kthread_stop()
invocations.  Testing has shown 100 runs of TREE07 passing reliably,
as oppose to the tens-of-percent failure rates seen beforehand.

Cc: Paul McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc: <stable@vger.kernel.org> # 6.0.x
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/torture.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -788,7 +788,7 @@ void torture_kthread_stopping(char *titl
 	VERBOSE_TOROUT_STRING(buf);
 	while (!kthread_should_stop()) {
 		torture_shutdown_absorb(title);
-		schedule_timeout_uninterruptible(1);
+		schedule_timeout_uninterruptible(HZ / 20);
 	}
 }
 EXPORT_SYMBOL_GPL(torture_kthread_stopping);


