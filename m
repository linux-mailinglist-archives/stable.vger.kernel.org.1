Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CC57BDF00
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376628AbjJINZW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376736AbjJINZV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:25:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E278E4
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:25:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A77AC433C8;
        Mon,  9 Oct 2023 13:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857918;
        bh=xsSG+IJfNctiGXWHB3p6BMIMMzNbcFJD7Qw0e2upHvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ua8M8Sof/epltwrGhZMJ/M8vRylpT96g3ZHT1C++RpIiUfmtFM3tgzmbNL5QGVqii
         uBkiuCLHPp2cvoioTp2hrFCpjh7EAtdkXqHgcVEfZP3u4baU2cXhyh8A+jKaPz+XBX
         +2M84fmldgpvEy2419cxdfqzOG/bL3SyVb8o4P5w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@elte.hu>,
        Mike Rapoport <mike.rapoport@gmail.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 08/75] ring-buffer: remove obsolete comment for free_buffer_page()
Date:   Mon,  9 Oct 2023 15:01:30 +0200
Message-ID: <20231009130111.505926156@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.200710898@linuxfoundation.org>
References: <20231009130111.200710898@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vlastimil Babka <vbabka@suse.cz>

[ Upstream commit a98151ad53b53f010ee364ec2fd06445b328578b ]

The comment refers to mm/slob.c which is being removed. It comes from
commit ed56829cb319 ("ring_buffer: reset buffer page when freeing") and
according to Steven the borrowed code was a page mapcount and mapping
reset, which was later removed by commit e4c2ce82ca27 ("ring_buffer:
allocate buffer page pointer"). Thus the comment is not accurate anyway,
remove it.

Link: https://lore.kernel.org/linux-trace-kernel/20230315142446.27040-1-vbabka@suse.cz

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
Reported-by: Mike Rapoport <mike.rapoport@gmail.com>
Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Fixes: e4c2ce82ca27 ("ring_buffer: allocate buffer page pointer")
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Stable-dep-of: 45d99ea451d0 ("ring-buffer: Fix bytes info in per_cpu buffer stats")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 2e5f3de7bfb09..352a7de4fc458 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -346,10 +346,6 @@ static void rb_init_page(struct buffer_data_page *bpage)
 	local_set(&bpage->commit, 0);
 }
 
-/*
- * Also stolen from mm/slob.c. Thanks to Mathieu Desnoyers for pointing
- * this issue out.
- */
 static void free_buffer_page(struct buffer_page *bpage)
 {
 	free_page((unsigned long)bpage->page);
-- 
2.40.1



