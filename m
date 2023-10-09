Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78387BDFB7
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377125AbjJINdH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377134AbjJINdE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:33:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD90B6
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:33:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA254C433C9;
        Mon,  9 Oct 2023 13:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858382;
        bh=NLn0dd/Huxxn8n96p5pzOxhDoAOOx3d0xxFkbJMLKeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eo6MjxP2kYlRg1JuzhBNZhIHLeEzMBezL54JuTK9NBbEI/CQTV1xPDu2VsYaD4DGr
         KYxr+n+sYJoqAbl/aCJRTAzZj9eNCTc0WU3lv29nUFs2G/BsBg0nMJ+4VY9WmYIH8A
         SBZ4XyqguKWKKnJg2QwdNlphWENYGyobBsjDq9KU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 5.4 078/131] ring-buffer: Update "shortest_full" in polling
Date:   Mon,  9 Oct 2023 15:01:58 +0200
Message-ID: <20231009130118.718968122@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (Google) <rostedt@goodmis.org>

commit 1e0cb399c7653462d9dadf8ab9425337c355d358 upstream.

It was discovered that the ring buffer polling was incorrectly stating
that read would not block, but that's because polling did not take into
account that reads will block if the "buffer-percent" was set. Instead,
the ring buffer polling would say reads would not block if there was any
data in the ring buffer. This was incorrect behavior from a user space
point of view. This was fixed by commit 42fb0a1e84ff by having the polling
code check if the ring buffer had more data than what the user specified
"buffer percent" had.

The problem now is that the polling code did not register itself to the
writer that it wanted to wait for a specific "full" value of the ring
buffer. The result was that the writer would wake the polling waiter
whenever there was a new event. The polling waiter would then wake up, see
that there's not enough data in the ring buffer to notify user space and
then go back to sleep. The next event would wake it up again.

Before the polling fix was added, the code would wake up around 100 times
for a hackbench 30 benchmark. After the "fix", due to the constant waking
of the writer, it would wake up over 11,0000 times! It would never leave
the kernel, so the user space behavior was still "correct", but this
definitely is not the desired effect.

To fix this, have the polling code add what it's waiting for to the
"shortest_full" variable, to tell the writer not to wake it up if the
buffer is not as full as it expects to be.

Note, after this fix, it appears that the waiter is now woken up around 2x
the times it was before (~200). This is a tremendous improvement from the
11,000 times, but I will need to spend some time to see why polling is
more aggressive in its wakeups than the read blocking code.

Link: https://lore.kernel.org/linux-trace-kernel/20230929180113.01c2cae3@rorschach.local.home

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Fixes: 42fb0a1e84ff ("tracing/ring-buffer: Have polling block on watermark")
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Tested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/ring_buffer.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -742,6 +742,9 @@ __poll_t ring_buffer_poll_wait(struct ri
 	if (full) {
 		poll_wait(filp, &work->full_waiters, poll_table);
 		work->full_waiters_pending = true;
+		if (!cpu_buffer->shortest_full ||
+		    cpu_buffer->shortest_full > full)
+			cpu_buffer->shortest_full = full;
 	} else {
 		poll_wait(filp, &work->waiters, poll_table);
 		work->waiters_pending = true;


