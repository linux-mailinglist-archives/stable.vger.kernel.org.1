Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C947A7C36
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbjITL7M (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbjITL7K (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:59:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5855B4
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:59:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30892C433C7;
        Wed, 20 Sep 2023 11:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211144;
        bh=K45HDIcgq/YoiW9wqwqcdzv1H+DDvIxTjrnyAhPQeW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l1+bik+BKTmnFWGyTIcmoldC+KNoztqnBrnF8w5JBeIqALFwWLogtnDXUhiPCHGbB
         qTH7dy5w0e56FRIwfznDBRaemcBkudUJrzL5Nz66IhZhLzLhuFybqleqwetkFHX9Mt
         JMK0RZDDjAza/ebeI2Zx17AQ+WnBVEsyA7YZBack=
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
Subject: [PATCH 6.1 125/139] tracing: Have current_trace inc the trace array ref count
Date:   Wed, 20 Sep 2023 13:30:59 +0200
Message-ID: <20230920112840.253834037@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112835.549467415@linuxfoundation.org>
References: <20230920112835.549467415@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (Google) <rostedt@goodmis.org>

commit 9b37febc578b2e1ad76a105aab11d00af5ec3d27 upstream.

The current_trace updates the trace array tracer. For an instance, if the
file is opened and the instance is deleted, reading or writing to the file
will cause a use after free.

Up the ref count of the trace array when current_trace is opened.

Link: https://lkml.kernel.org/r/20230907024803.877687227@goodmis.org
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
 kernel/trace/trace.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7708,10 +7708,11 @@ static const struct file_operations trac
 #endif
 
 static const struct file_operations set_tracer_fops = {
-	.open		= tracing_open_generic,
+	.open		= tracing_open_generic_tr,
 	.read		= tracing_set_trace_read,
 	.write		= tracing_set_trace_write,
 	.llseek		= generic_file_llseek,
+	.release	= tracing_release_generic_tr,
 };
 
 static const struct file_operations tracing_pipe_fops = {


