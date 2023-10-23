Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0CD7D32F3
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbjJWLZS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbjJWLZQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:25:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A4010C0
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:25:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783E3C433C8;
        Mon, 23 Oct 2023 11:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060309;
        bh=MtHUpp8hbYe1uo51F+NEV7bX6qoWzIPG1dTIh8glGcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SWvB6i2f84CZ063KIrkSBXXBGh5sTJtXSWBQkKtm8cIPKmBgcF2IdW769o3BW0qHQ
         EjrjiYggwsH50CcN0zlI5R6z3gyFsGVbly3BmO9iUMzrmOxWv00J/v1PiMGr2iiYMX
         4xUXf0vc5Ik97DpKH99FP03jn6xwjWVksuITfxnE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 128/196] fprobe: Add nr_maxactive to specify rethook_node pool size
Date:   Mon, 23 Oct 2023 12:56:33 +0200
Message-ID: <20231023104832.118749894@linuxfoundation.org>
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

[ Upstream commit 59a7a298565aa0ce44ce8e4fbcbb89a19730013a ]

Add nr_maxactive to specify rethook_node pool size. This means
the maximum number of actively running target functions concurrently
for probing by exit_handler. Note that if the running function is
preempted or sleep, it is still counted as 'active'.

Link: https://lkml.kernel.org/r/167526697917.433354.17779774988245113106.stgit@mhiramat.roam.corp.google.com

Cc: Florent Revest <revest@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Stable-dep-of: 700b2b439766 ("fprobe: Fix to ensure the number of active retprobes is not zero")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/fprobe.h | 2 ++
 kernel/trace/fprobe.c  | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
index e0d4e61362491..678f741a7b330 100644
--- a/include/linux/fprobe.h
+++ b/include/linux/fprobe.h
@@ -14,6 +14,7 @@
  * @flags: The status flag.
  * @rethook: The rethook data structure. (internal data)
  * @entry_data_size: The private data storage size.
+ * @nr_maxactive: The max number of active functions.
  * @entry_handler: The callback function for function entry.
  * @exit_handler: The callback function for function exit.
  */
@@ -31,6 +32,7 @@ struct fprobe {
 	unsigned int		flags;
 	struct rethook		*rethook;
 	size_t			entry_data_size;
+	int			nr_maxactive;
 
 	void (*entry_handler)(struct fprobe *fp, unsigned long entry_ip,
 			      struct pt_regs *regs, void *entry_data);
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index be28d1bc84e80..441a373079213 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -143,7 +143,10 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
 	}
 
 	/* Initialize rethook if needed */
-	size = num * num_possible_cpus() * 2;
+	if (fp->nr_maxactive)
+		size = fp->nr_maxactive;
+	else
+		size = num * num_possible_cpus() * 2;
 	if (size < 0)
 		return -E2BIG;
 
-- 
2.40.1



