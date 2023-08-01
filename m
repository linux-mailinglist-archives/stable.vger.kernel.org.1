Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FAE76AEC5
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjHAJlr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbjHAJlX (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:41:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCC835A2
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:39:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA1CF614FF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:39:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99A4C433C7;
        Tue,  1 Aug 2023 09:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882749;
        bh=QvHBerpn7XAkp9jqmF1JaeUtAE+i1zKRQPoEKH6blVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FRwjngQdRFvDbQ+mZme4nyacWIzatSvG50Z+klW3hEggxw3a17KkMfx62nIk36zzE
         6NzGAY109EncnYHapPmN+CvwN9wtkZ7MeA9ZA0qNtUCSJRmAg59fPgmixIzBZCtLKE
         tlOWUJ6GCY6aSTXJGZU4N7felcd25rzgdELujrZg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tom Zanussi <zanussi@kernel.org>,
        kernel test robot <lkp@intel.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCH 6.1 218/228] tracing: Fix trace_event_raw_event_synth() if else statement
Date:   Tue,  1 Aug 2023 11:21:16 +0200
Message-ID: <20230801091930.734439409@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Steven Rostedt (Google) <rostedt@goodmis.org>

commit 9971c3f944489ff7aacb9d25e0cde841a5f6018a upstream.

The test to check if the field is a stack is to be done if it is not a
string. But the code had:

    } if (event->fields[i]->is_stack) {

and not

   } else if (event->fields[i]->is_stack) {

which would cause it to always be tested. Worse yet, this also included an
"else" statement that was only to be called if the field was not a string
and a stack, but this code allows it to be called if it was a string (and
not a stack).

Also fixed some whitespace issues.

Link: https://lore.kernel.org/all/202301302110.mEtNwkBD-lkp@intel.com/
Link: https://lore.kernel.org/linux-trace-kernel/20230131095237.63e3ca8d@gandalf.local.home

Cc: Tom Zanussi <zanussi@kernel.org>
Fixes: 00cf3d672a9d ("tracing: Allow synthetic events to pass around stacktraces")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_events_synth.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -576,8 +576,8 @@ static notrace void trace_event_raw_even
 					   event->fields[i]->is_dynamic,
 					   data_size, &n_u64);
 			data_size += len; /* only dynamic string increments */
-		} if (event->fields[i]->is_stack) {
-		        long *stack = (long *)(long)var_ref_vals[val_idx];
+		} else if (event->fields[i]->is_stack) {
+			long *stack = (long *)(long)var_ref_vals[val_idx];
 
 			len = trace_stack(entry, event, stack,
 					   data_size, &n_u64);


