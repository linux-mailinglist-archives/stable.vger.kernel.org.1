Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB16B78AD6D
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjH1KsK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjH1Krv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:47:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDC59E
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:47:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8122C642C1
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94030C433C7;
        Mon, 28 Aug 2023 10:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219659;
        bh=Bv2hszujlvACstvGyS9hPb7cNufeaRL6twWtZY5SltU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2pyj8sbLHZplR0B1M/DVJZBpge5GctYmwKps+ZVv33fQ+sbT801OIR+5eGhwNSDfX
         VNh7wRtKlHWuOi/K77edXpm9fPJFP2LVD+/wGQm2IxbpaU2as9g2vQr+5esSv03Oqc
         xYeW+0eH8JTkdhgX3mu4OilcXAtPEXcNwDfacB3g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, mhiramat@kernel.org,
        vnagarnaik@google.com, shuah@kernel.org,
        Zheng Yejian <zhengyejian1@huawei.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 25/84] tracing: Fix cpu buffers unavailable due to record_disabled missed
Date:   Mon, 28 Aug 2023 12:13:42 +0200
Message-ID: <20230828101150.085539451@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101149.146126827@linuxfoundation.org>
References: <20230828101149.146126827@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zheng Yejian <zhengyejian1@huawei.com>

[ Upstream commit b71645d6af10196c46cbe3732de2ea7d36b3ff6d ]

Trace ring buffer can no longer record anything after executing
following commands at the shell prompt:

  # cd /sys/kernel/tracing
  # cat tracing_cpumask
  fff
  # echo 0 > tracing_cpumask
  # echo 1 > snapshot
  # echo fff > tracing_cpumask
  # echo 1 > tracing_on
  # echo "hello world" > trace_marker
  -bash: echo: write error: Bad file descriptor

The root cause is that:
  1. After `echo 0 > tracing_cpumask`, 'record_disabled' of cpu buffers
     in 'tr->array_buffer.buffer' became 1 (see tracing_set_cpumask());
  2. After `echo 1 > snapshot`, 'tr->array_buffer.buffer' is swapped
     with 'tr->max_buffer.buffer', then the 'record_disabled' became 0
     (see update_max_tr());
  3. After `echo fff > tracing_cpumask`, the 'record_disabled' become -1;
Then array_buffer and max_buffer are both unavailable due to value of
'record_disabled' is not 0.

To fix it, enable or disable both array_buffer and max_buffer at the same
time in tracing_set_cpumask().

Link: https://lkml.kernel.org/r/20230805033816.3284594-2-zhengyejian1@huawei.com

Cc: <mhiramat@kernel.org>
Cc: <vnagarnaik@google.com>
Cc: <shuah@kernel.org>
Fixes: 71babb2705e2 ("tracing: change CPU ring buffer state from tracing_cpumask")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 167f2a19fd8a2..d0c9769938ad2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4843,11 +4843,17 @@ int tracing_set_cpumask(struct trace_array *tr,
 				!cpumask_test_cpu(cpu, tracing_cpumask_new)) {
 			atomic_inc(&per_cpu_ptr(tr->array_buffer.data, cpu)->disabled);
 			ring_buffer_record_disable_cpu(tr->array_buffer.buffer, cpu);
+#ifdef CONFIG_TRACER_MAX_TRACE
+			ring_buffer_record_disable_cpu(tr->max_buffer.buffer, cpu);
+#endif
 		}
 		if (!cpumask_test_cpu(cpu, tr->tracing_cpumask) &&
 				cpumask_test_cpu(cpu, tracing_cpumask_new)) {
 			atomic_dec(&per_cpu_ptr(tr->array_buffer.data, cpu)->disabled);
 			ring_buffer_record_enable_cpu(tr->array_buffer.buffer, cpu);
+#ifdef CONFIG_TRACER_MAX_TRACE
+			ring_buffer_record_enable_cpu(tr->max_buffer.buffer, cpu);
+#endif
 		}
 	}
 	arch_spin_unlock(&tr->max_lock);
-- 
2.40.1



