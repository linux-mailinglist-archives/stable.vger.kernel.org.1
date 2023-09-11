Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F093779B2AA
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349137AbjIKVco (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240817AbjIKOyn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:54:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF3AE40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:54:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFE1C433C7;
        Mon, 11 Sep 2023 14:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444078;
        bh=6k+YPnSfRoqD3a3tB73kKxaDzI83Ua8mKnbg+cZLGJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g2psPgqd6aGu5ee5lE2aLSuSisP1bQZncsB1NotCYHU3r5V/4Lgd+vRyYW+O7jcQt
         n/PAF0wZR0hKfGePpTcAp1Nv+qLKUJg3bJB9L/AzqFggOrF8DfifFXLnEAaAtmr4t+
         mQplckqzUnpkf+j0wlBZtRoRZ9cF6CGhFIZqPl/I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
        Mikhail Kobuk <m.kobuk@ispras.ru>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 602/737] tracing: Remove extra space at the end of hwlat_detector/mode
Date:   Mon, 11 Sep 2023 15:47:41 +0200
Message-ID: <20230911134707.352776322@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikhail Kobuk <m.kobuk@ispras.ru>

[ Upstream commit 2cf0dee989a8b2501929eaab29473b6b1fa11057 ]

Space is printed after each mode value including the last one:
$ echo \"$(sudo cat /sys/kernel/tracing/hwlat_detector/mode)\"
"none [round-robin] per-cpu "

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Link: https://lore.kernel.org/linux-trace-kernel/20230825103432.7750-1-m.kobuk@ispras.ru

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: 8fa826b7344d ("trace/hwlat: Implement the mode config option")
Signed-off-by: Mikhail Kobuk <m.kobuk@ispras.ru>
Reviewed-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_hwlat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 2f37a6e68aa9f..b791524a6536a 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -635,7 +635,7 @@ static int s_mode_show(struct seq_file *s, void *v)
 	else
 		seq_printf(s, "%s", thread_mode_str[mode]);
 
-	if (mode != MODE_MAX)
+	if (mode < MODE_MAX - 1) /* if mode is any but last */
 		seq_puts(s, " ");
 
 	return 0;
-- 
2.40.1



