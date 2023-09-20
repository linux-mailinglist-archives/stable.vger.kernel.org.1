Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16417A81B8
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbjITMr6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbjITMrz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:47:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13D39E
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:47:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24421C433C7;
        Wed, 20 Sep 2023 12:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695214063;
        bh=Js2Z/+OiwfNAfUe7ebVBU/aFs/v00X/oXs7VpxUg8tg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PiffLWt7bYX8KMKG8oxHjZFVhYj9DwXz5ZHhNAl3Z1wynYjkMjGDjmFYxR7GXFe58
         9Vapt5FztGCk0UMjSJiXx1ev5gksRsN/ts78S0AGrdBGMv/azt0sNPnoIB2xpnxqF3
         TxzkNk19y2sWc4pv3wSfU9pVHDIrdRiMtAOYLBOQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 5.15 099/110] tracing: Have option files inc the trace array ref count
Date:   Wed, 20 Sep 2023 13:32:37 +0200
Message-ID: <20230920112834.131292627@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112830.377666128@linuxfoundation.org>
References: <20230920112830.377666128@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (Google) <rostedt@goodmis.org>

commit 7e2cfbd2d3c86afcd5c26b5c4b1dd251f63c5838 upstream.

The option files update the options for a given trace array. For an
instance, if the file is opened and the instance is deleted, reading or
writing to the file will cause a use after free.

Up the ref count of the trace_array when an option file is opened.

Link: https://lkml.kernel.org/r/20230907024804.086679464@goodmis.org
Link: https://lore.kernel.org/all/1cb3aee2-19af-c472-e265-05176fe9bd84@huawei.com/

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Zheng Yejian <zhengyejian1@huawei.com>
Fixes: 8530dec63e7b4 ("tracing: Add tracing_check_open_get_tr()")
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace.c |   23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8830,12 +8830,33 @@ trace_options_write(struct file *filp, c
 	return cnt;
 }
 
+static int tracing_open_options(struct inode *inode, struct file *filp)
+{
+	struct trace_option_dentry *topt = inode->i_private;
+	int ret;
+
+	ret = tracing_check_open_get_tr(topt->tr);
+	if (ret)
+		return ret;
+
+	filp->private_data = inode->i_private;
+	return 0;
+}
+
+static int tracing_release_options(struct inode *inode, struct file *file)
+{
+	struct trace_option_dentry *topt = file->private_data;
+
+	trace_array_put(topt->tr);
+	return 0;
+}
 
 static const struct file_operations trace_options_fops = {
-	.open = tracing_open_generic,
+	.open = tracing_open_options,
 	.read = trace_options_read,
 	.write = trace_options_write,
 	.llseek	= generic_file_llseek,
+	.release = tracing_release_options,
 };
 
 /*


