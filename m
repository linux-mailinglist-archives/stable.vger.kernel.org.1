Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1CB726C31
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjFGUbU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjFGUbT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:31:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E41F184
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:31:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 225A3644FB
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BA9C433EF;
        Wed,  7 Jun 2023 20:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169876;
        bh=rv2GjjLz0EFiXPtcHR/czhXpGMXhLdLRwa9sx8TXDhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hjLS1kyF3y/BaL5Tngjy05cD0EuzXCXG6PwpBxQaCVLhdjg15p/edJPaR/6eRaXfE
         GD7gTNZHafVZxxwpZgwG130my/LWrb1by4smzXk8bBQqiIl0fA1uiAwFUeb69dNppZ
         cbMFlpuik4d4Zmts+P7Y2zyN0sCrZg4QErJaRtbw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.3 247/286] tracing/histograms: Allow variables to have some modifiers
Date:   Wed,  7 Jun 2023 22:15:46 +0200
Message-ID: <20230607200931.369289701@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Steven Rostedt (Google) <rostedt@goodmis.org>

commit e30fbc618e97b38dbb49f1d44dcd0778d3f23b8c upstream.

Modifiers are used to change the behavior of keys. For instance, they
can grouped into buckets, converted to syscall names (from the syscall
identifier), show task->comm of the current pid, be an array of longs
that represent a stacktrace, and more.

It was found that nothing stopped a value from taking a modifier. As
values are simple counters. If this happened, it would call code that
was not expecting a modifier and crash the kernel. This was fixed by
having the ___create_val_field() function test if a modifier was present
and fail if one was. This fixed the crash.

Now there's a problem with variables. Variables are used to pass fields
from one event to another. Variables are allowed to have some modifiers,
as the processing may need to happen at the time of the event (like
stacktraces and comm names of the current pid). The issue is that it too
uses __create_val_field(). Now that fails on modifiers, variables can no
longer use them (this is a regression).

As not all modifiers are for variables, have them use a separate check.

Link: https://lore.kernel.org/linux-trace-kernel/20230523221108.064a5d82@rorschach.local.home

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Tom Zanussi <zanussi@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Fixes: e0213434fe3e4 ("tracing: Do not let histogram values have some modifiers")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_events_hist.c |   23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4238,13 +4238,19 @@ static int __create_val_field(struct his
 		goto out;
 	}
 
-	/* Some types cannot be a value */
-	if (hist_field->flags & (HIST_FIELD_FL_GRAPH | HIST_FIELD_FL_PERCENT |
-				 HIST_FIELD_FL_BUCKET | HIST_FIELD_FL_LOG2 |
-				 HIST_FIELD_FL_SYM | HIST_FIELD_FL_SYM_OFFSET |
-				 HIST_FIELD_FL_SYSCALL | HIST_FIELD_FL_STACKTRACE)) {
-		hist_err(file->tr, HIST_ERR_BAD_FIELD_MODIFIER, errpos(field_str));
-		ret = -EINVAL;
+	/* values and variables should not have some modifiers */
+	if (hist_field->flags & HIST_FIELD_FL_VAR) {
+		/* Variable */
+		if (hist_field->flags & (HIST_FIELD_FL_GRAPH | HIST_FIELD_FL_PERCENT |
+					 HIST_FIELD_FL_BUCKET | HIST_FIELD_FL_LOG2))
+			goto err;
+	} else {
+		/* Value */
+		if (hist_field->flags & (HIST_FIELD_FL_GRAPH | HIST_FIELD_FL_PERCENT |
+					 HIST_FIELD_FL_BUCKET | HIST_FIELD_FL_LOG2 |
+					 HIST_FIELD_FL_SYM | HIST_FIELD_FL_SYM_OFFSET |
+					 HIST_FIELD_FL_SYSCALL | HIST_FIELD_FL_STACKTRACE))
+			goto err;
 	}
 
 	hist_data->fields[val_idx] = hist_field;
@@ -4256,6 +4262,9 @@ static int __create_val_field(struct his
 		ret = -EINVAL;
  out:
 	return ret;
+ err:
+	hist_err(file->tr, HIST_ERR_BAD_FIELD_MODIFIER, errpos(field_str));
+	return -EINVAL;
 }
 
 static int create_val_field(struct hist_trigger_data *hist_data,


