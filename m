Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5C96FAA0E
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbjEHK6k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbjEHK6B (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:58:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F2E30ADA
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:57:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08EE661709
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9763C433EF;
        Mon,  8 May 2023 10:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543424;
        bh=oWUxFGWUGp1tUky7lt2pEBZRL81RZORgAxCRAKAofUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0YaSIS2hAjV+VbpbIiCxq3Ce2I2qfamX5t/jPcQ3EtE8XOms7M1cff9RDYsGkaC9M
         NpbIxs5vxe37ZqCqoXI8YO79ocOYN7UYtaDqgyy+o1yeYXwX/CB65gkxcQHJ2pxiAF
         9l9az+nl9IYvfxARjWzhHcOkrzK0dvRlchMNSHpM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, mhiramat@kernel.org, npiggin@gmail.com,
        Cheng-Jui Wang <cheng-jui.wang@mediatek.com>,
        Tze-nan Wu <Tze-nan.Wu@mediatek.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.3 046/694] ring-buffer: Ensure proper resetting of atomic variables in ring_buffer_reset_online_cpus
Date:   Mon,  8 May 2023 11:38:01 +0200
Message-Id: <20230508094434.114280579@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tze-nan Wu <Tze-nan.Wu@mediatek.com>

commit 7c339fb4d8577792378136c15fde773cfb863cb8 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/ring_buffer.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5345,6 +5345,9 @@ void ring_buffer_reset_cpu(struct trace_
 }
 EXPORT_SYMBOL_GPL(ring_buffer_reset_cpu);
 
+/* Flag to ensure proper resetting of atomic variables */
+#define RESET_BIT	(1 << 30)
+
 /**
  * ring_buffer_reset_online_cpus - reset a ring buffer per CPU buffer
  * @buffer: The ring buffer to reset a per cpu buffer of
@@ -5361,20 +5364,27 @@ void ring_buffer_reset_online_cpus(struc
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


