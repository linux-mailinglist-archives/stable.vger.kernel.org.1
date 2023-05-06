Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FAD6F8F48
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 08:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjEFGj0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 02:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjEFGjZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 02:39:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842D793E5
        for <stable@vger.kernel.org>; Fri,  5 May 2023 23:39:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20E026171C
        for <stable@vger.kernel.org>; Sat,  6 May 2023 06:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3092C433D2;
        Sat,  6 May 2023 06:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683355163;
        bh=Y5McbVfPckTMMK+lJ2L4FnOLYTeXnqYvVirleAiGQR8=;
        h=Subject:To:Cc:From:Date:From;
        b=julqwT9euhZS4N5CIOGhCzW2x+5EgQf3/mA8C6UFHSW8QFjhe6Si57pV28zjwdFs2
         ghlrh/i95/ISYKOt6swwS/j7XkYRcavrMgcnbV228LGqJvopBcmTXCySlN5htCoQPt
         V4VK3gAJ0oZiAVHP6qN7bAF97VhEeq8azwqFC3aU=
Subject: FAILED: patch "[PATCH] ring-buffer: Ensure proper resetting of atomic variables in" failed to apply to 5.15-stable tree
To:     Tze-nan.Wu@mediatek.com, cheng-jui.wang@mediatek.com,
        mhiramat@kernel.org, rostedt@goodmis.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 06 May 2023 11:26:48 +0900
Message-ID: <2023050648-brethren-harmony-6fc1@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7c339fb4d8577792378136c15fde773cfb863cb8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050648-brethren-harmony-6fc1@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7c339fb4d8577792378136c15fde773cfb863cb8 Mon Sep 17 00:00:00 2001
From: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
Date: Wed, 26 Apr 2023 14:20:23 +0800
Subject: [PATCH] ring-buffer: Ensure proper resetting of atomic variables in
 ring_buffer_reset_online_cpus

In ring_buffer_reset_online_cpus, the buffer_size_kb write operation
may permanently fail if the cpu_online_mask changes between two
for_each_online_buffer_cpu loops. The number of increases and decreases
on both cpu_buffer->resize_disabled and cpu_buffer->record_disabled may be
inconsistent, causing some CPUs to have non-zero values for these atomic
variables after the function returns.

This issue can be reproduced by "echo 0 > trace" while hotplugging cpu.
After reproducing success, we can find out buffer_size_kb will not be
functional anymore.

To prevent leaving 'resize_disabled' and 'record_disabled' non-zero after
ring_buffer_reset_online_cpus returns, we ensure that each atomic variable
has been set up before atomic_sub() to it.

Link: https://lore.kernel.org/linux-trace-kernel/20230426062027.17451-1-Tze-nan.Wu@mediatek.com

Cc: stable@vger.kernel.org
Cc: <mhiramat@kernel.org>
Cc: npiggin@gmail.com
Fixes: b23d7a5f4a07 ("ring-buffer: speed up buffer resets by avoiding synchronize_rcu for each CPU")
Reviewed-by: Cheng-Jui Wang <cheng-jui.wang@mediatek.com>
Signed-off-by: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 58be5b409f72..9a0cb94c3972 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5326,6 +5326,9 @@ void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_reset_cpu);
 
+/* Flag to ensure proper resetting of atomic variables */
+#define RESET_BIT	(1 << 30)
+
 /**
  * ring_buffer_reset_online_cpus - reset a ring buffer per CPU buffer
  * @buffer: The ring buffer to reset a per cpu buffer of
@@ -5342,20 +5345,27 @@ void ring_buffer_reset_online_cpus(struct trace_buffer *buffer)
 	for_each_online_buffer_cpu(buffer, cpu) {
 		cpu_buffer = buffer->buffers[cpu];
 
-		atomic_inc(&cpu_buffer->resize_disabled);
+		atomic_add(RESET_BIT, &cpu_buffer->resize_disabled);
 		atomic_inc(&cpu_buffer->record_disabled);
 	}
 
 	/* Make sure all commits have finished */
 	synchronize_rcu();
 
-	for_each_online_buffer_cpu(buffer, cpu) {
+	for_each_buffer_cpu(buffer, cpu) {
 		cpu_buffer = buffer->buffers[cpu];
 
+		/*
+		 * If a CPU came online during the synchronize_rcu(), then
+		 * ignore it.
+		 */
+		if (!(atomic_read(&cpu_buffer->resize_disabled) & RESET_BIT))
+			continue;
+
 		reset_disabled_cpu_buffer(cpu_buffer);
 
 		atomic_dec(&cpu_buffer->record_disabled);
-		atomic_dec(&cpu_buffer->resize_disabled);
+		atomic_sub(RESET_BIT, &cpu_buffer->resize_disabled);
 	}
 
 	mutex_unlock(&buffer->mutex);

