Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E5775D379
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjGUTLG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjGUTLF (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:11:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C35B30E3
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:11:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B430561D7B
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65E7C433C8;
        Fri, 21 Jul 2023 19:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966663;
        bh=W3S81AMvm6oV2LRJcrQVtcTDHkd0EV6zYyF/1tp3bFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cfyw0xe8o0yXHKLbVKlbTJZkjA0jdciMIq6+WVrsRORtcButI1skh2F5NbvapVz8N
         EiavftojS8O0EpXloPSZxr86L3/k4y+xF+iiS0Rg34LcY1sp+rILylaZBuVwzjBWMF
         19UzVLjHzL3AqmMi35T/d2S67jcfUYgePQ7F1+pk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 424/532] kernel/trace: Fix cleanup logic of enable_trace_eprobe
Date:   Fri, 21 Jul 2023 18:05:28 +0200
Message-ID: <20230721160637.559541557@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>

[ Upstream commit cf0a624dc706c306294c14e6b3e7694702f25191 ]

The enable_trace_eprobe() function enables all event probes, attached
to given trace probe. If an error occurs in enabling one of the event
probes, all others should be roll backed. There is a bug in that roll
back logic - instead of all event probes, only the failed one is
disabled.

Link: https://lore.kernel.org/all/20230703042853.1427493-1-tz.stoyanov@gmail.com/

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_eprobe.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 9806316af1279..085f056e66f19 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -725,6 +725,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 	struct trace_eprobe *ep;
 	bool enabled;
 	int ret = 0;
+	int cnt = 0;
 
 	tp = trace_probe_primary_from_call(call);
 	if (WARN_ON_ONCE(!tp))
@@ -748,12 +749,25 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 		if (ret)
 			break;
 		enabled = true;
+		cnt++;
 	}
 
 	if (ret) {
 		/* Failed to enable one of them. Roll back all */
-		if (enabled)
-			disable_eprobe(ep, file->tr);
+		if (enabled) {
+			/*
+			 * It's a bug if one failed for something other than memory
+			 * not being available but another eprobe succeeded.
+			 */
+			WARN_ON_ONCE(ret != -ENOMEM);
+
+			list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
+				ep = container_of(pos, struct trace_eprobe, tp);
+				disable_eprobe(ep, file->tr);
+				if (!--cnt)
+					break;
+			}
+		}
 		if (file)
 			trace_probe_remove_file(tp, file);
 		else
-- 
2.39.2



