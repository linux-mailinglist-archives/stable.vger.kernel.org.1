Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29C37BDE2B
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376951AbjJINQh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376959AbjJINQf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:16:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301C2D6
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:16:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35828C433C7;
        Mon,  9 Oct 2023 13:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857393;
        bh=n+x7mku1iL7klug4ZvtQX3dzS2OEkh4bgmVdH2YF3xY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L94I5PBXW9KOmXADpBt4G9MHPQrWdBbf4VYdKZszDtlLz995KRuzZx2w96SzAZylV
         rjnvUyV3B119kxryjJerWcWB+f83RQabDEYidFCMT4xKxtNsOFfASBYkhua576c7U3
         89++lIil9LzawV+E1APsGe3amEvUx6anFq7iyVRg=
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
Subject: [PATCH 6.1 032/162] ring-buffer: remove obsolete comment for free_buffer_page()
Date:   Mon,  9 Oct 2023 15:00:13 +0200
Message-ID: <20231009130123.833985888@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 2f562cf961e0a..51737b3d54b35 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -354,10 +354,6 @@ static void rb_init_page(struct buffer_data_page *bpage)
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



