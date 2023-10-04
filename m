Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56C97B8726
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243633AbjJDSCH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjJDSCH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:02:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14580A7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:02:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589A5C433C7;
        Wed,  4 Oct 2023 18:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442523;
        bh=+ZkB3rhePt7Y0cQPxw6a3dC5USsWL4B8ykqBsHTVOiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oInoLOEJ1b/TdZBe1ySuJ369hs2WctcrA8y7FAZltk25RmGZWpLrVyYraAe89bdqS
         Zz0ZBZun5uFPOtjLVhlMMieTSn2OwxZ/ZIS9yu3NAU+3N3Vr6IrmeLC02p6OjsyI+Z
         FJhrBp7kkWk8LhldgPfgjFGybLqV9VOh5lGHxQn4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 016/183] tracing: Have event inject files inc the trace array ref count
Date:   Wed,  4 Oct 2023 19:54:07 +0200
Message-ID: <20231004175204.661985402@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (Google) <rostedt@goodmis.org>

[ Upstream commit e5c624f027ac74f97e97c8f36c69228ac9f1102d ]

The event inject files add events for a specific trace array. For an
instance, if the file is opened and the instance is deleted, reading or
writing to the file will cause a use after free.

Up the ref count of the trace_array when a event inject file is opened.

Link: https://lkml.kernel.org/r/20230907024804.292337868@goodmis.org
Link: https://lore.kernel.org/all/1cb3aee2-19af-c472-e265-05176fe9bd84@huawei.com/

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Zheng Yejian <zhengyejian1@huawei.com>
Fixes: 6c3edaf9fd6a ("tracing: Introduce trace event injection")
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_inject.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
index c188045c5f976..b1fce64e126c0 100644
--- a/kernel/trace/trace_events_inject.c
+++ b/kernel/trace/trace_events_inject.c
@@ -321,7 +321,8 @@ event_inject_read(struct file *file, char __user *buf, size_t size,
 }
 
 const struct file_operations event_inject_fops = {
-	.open = tracing_open_generic,
+	.open = tracing_open_file_tr,
 	.read = event_inject_read,
 	.write = event_inject_write,
+	.release = tracing_release_file_tr,
 };
-- 
2.40.1



