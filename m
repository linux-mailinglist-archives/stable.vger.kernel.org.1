Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132CC789CE4
	for <lists+stable@lfdr.de>; Sun, 27 Aug 2023 12:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjH0KNB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 27 Aug 2023 06:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjH0KMa (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 27 Aug 2023 06:12:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2997E13E
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 03:12:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B420E61D9E
        for <stable@vger.kernel.org>; Sun, 27 Aug 2023 10:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88E9C433C7;
        Sun, 27 Aug 2023 10:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693131141;
        bh=OiyxS//73exP87nXi/6JoyF71X0YfuJUXZ3vc3KULvU=;
        h=Subject:To:Cc:From:Date:From;
        b=bLWjulcU/E8T0CNd4sgynula4/Cwqjka1kp8hSSFCqGDD63KlOknhoeTrdY0KJY7i
         8P7upSS2oBFkfXmXMK1i8V0XsO7BRch5OnLrtbqeJ2wwWOPDFPgMV7iys6PWEhmw4Q
         vMY8t1RYFidbO6XldN1+qvH1kKT1r5RzAL9vM5aQ=
Subject: FAILED: patch "[PATCH] tracing/synthetic: Allocate one additional element for size" failed to apply to 6.1-stable tree
To:     svens@linux.ibm.com, mhiramat@kernel.org, rostedt@goodmis.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 27 Aug 2023 12:12:10 +0200
Message-ID: <2023082710-twisty-automatic-966e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c4d6b5438116c184027b2e911c0f2c7c406fb47c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082710-twisty-automatic-966e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

c4d6b5438116 ("tracing/synthetic: Allocate one additional element for size")
fc1a9dc10129 ("tracing/histogram: Don't use strlen to find length of stacktrace variables")
288709c9f3b0 ("tracing: Allow stacktraces to be saved as histogram variables")
5f2e094ed259 ("tracing: Allow multiple hitcount values in histograms")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c4d6b5438116c184027b2e911c0f2c7c406fb47c Mon Sep 17 00:00:00 2001
From: Sven Schnelle <svens@linux.ibm.com>
Date: Wed, 16 Aug 2023 17:49:28 +0200
Subject: [PATCH] tracing/synthetic: Allocate one additional element for size

While debugging another issue I noticed that the stack trace contains one
invalid entry at the end:

<idle>-0       [008] d..4.    26.484201: wake_lat: pid=0 delta=2629976084 000000009cc24024 stack=STACK:
=> __schedule+0xac6/0x1a98
=> schedule+0x126/0x2c0
=> schedule_timeout+0x150/0x2c0
=> kcompactd+0x9ca/0xc20
=> kthread+0x2f6/0x3d8
=> __ret_from_fork+0x8a/0xe8
=> 0x6b6b6b6b6b6b6b6b

This is because the code failed to add the one element containing the
number of entries to field_size.

Link: https://lkml.kernel.org/r/20230816154928.4171614-4-svens@linux.ibm.com

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: 00cf3d672a9d ("tracing: Allow synthetic events to pass around stacktraces")
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 80a2a832f857..9897d0bfcab7 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -528,7 +528,8 @@ static notrace void trace_event_raw_event_synth(void *__data,
 		str_val = (char *)(long)var_ref_vals[val_idx];
 
 		if (event->dynamic_fields[i]->is_stack) {
-			len = *((unsigned long *)str_val);
+			/* reserve one extra element for size */
+			len = *((unsigned long *)str_val) + 1;
 			len *= sizeof(unsigned long);
 		} else {
 			len = fetch_store_strlen((unsigned long)str_val);

