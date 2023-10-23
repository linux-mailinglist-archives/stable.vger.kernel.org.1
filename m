Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30577D32F4
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbjJWLZV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbjJWLZR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:25:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B8110DB
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:25:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C7CC433C9;
        Mon, 23 Oct 2023 11:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060312;
        bh=M7uZeptOAL/RJP6kUneZNcT3YujED2wKrVIE+NZs/hI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=omdeTZqTj07KdjfCSN145sdzqJDeNujYfMcQbNrwHOub0LLhL0gXMMqfAYnuAbPQm
         CpQHjHyfqLG1SOiYnZmtYOYDVwemUNMaiavqzt7ocC6RlpJOjyUgsvfG+JT7hxX3HF
         CtYzIgchIMPOKCfZd63i86OlVha6phRwBKnqpusQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 129/196] fprobe: Fix to ensure the number of active retprobes is not zero
Date:   Mon, 23 Oct 2023 12:56:34 +0200
Message-ID: <20231023104832.145915650@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
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

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

[ Upstream commit 700b2b439766e8aab8a7174991198497345bd411 ]

The number of active retprobes can be zero but it is not acceptable,
so return EINVAL error if detected.

Link: https://lore.kernel.org/all/169750018550.186853.11198884812017796410.stgit@devnote2/

Reported-by: wuqiang.matt <wuqiang.matt@bytedance.com>
Closes: https://lore.kernel.org/all/20231016222103.cb9f426edc60220eabd8aa6a@kernel.org/
Fixes: 5b0ab78998e3 ("fprobe: Add exit_handler support")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/fprobe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 441a373079213..f386d6bd8e0e3 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -134,7 +134,7 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
 {
 	int i, size;
 
-	if (num < 0)
+	if (num <= 0)
 		return -EINVAL;
 
 	if (!fp->exit_handler) {
@@ -147,8 +147,8 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
 		size = fp->nr_maxactive;
 	else
 		size = num * num_possible_cpus() * 2;
-	if (size < 0)
-		return -E2BIG;
+	if (size <= 0)
+		return -EINVAL;
 
 	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler);
 	if (!fp->rethook)
-- 
2.40.1



