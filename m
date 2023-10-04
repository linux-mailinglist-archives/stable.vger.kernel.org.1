Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A705F7B87B5
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243850AbjJDSI3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243818AbjJDSI2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:08:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3E8A6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:08:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AE4C433C8;
        Wed,  4 Oct 2023 18:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442905;
        bh=M/V2Tt9af+8Utlv68tTUR3iwA/FIi0LpvX54zB80O30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HVC+gUkoU4ZsDlNxbiokwGFAVfZQF8eozkTieyPQSkbedjCLQSPodBQWxB356dQS7
         mb2KJIRNedZEeQAVkSczHJk4fKHBSYUWYE/KZbLF9cAtuzOy9DN8btsrcC3GW/dDSL
         6gremTlyjRjeRXn54/ZP0IhVA3Gpsfl9BJbbg4MU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tze-nan Wu <Tze-nan.Wu@mediatek.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 123/183] ring-buffer: Do not attempt to read past "commit"
Date:   Wed,  4 Oct 2023 19:55:54 +0200
Message-ID: <20231004175209.107104053@linuxfoundation.org>
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

[ Upstream commit 95a404bd60af6c4d9d8db01ad14fe8957ece31ca ]

When iterating over the ring buffer while the ring buffer is active, the
writer can corrupt the reader. There's barriers to help detect this and
handle it, but that code missed the case where the last event was at the
very end of the page and has only 4 bytes left.

The checks to detect the corruption by the writer to reads needs to see the
length of the event. If the length in the first 4 bytes is zero then the
length is stored in the second 4 bytes. But if the writer is in the process
of updating that code, there's a small window where the length in the first
4 bytes could be zero even though the length is only 4 bytes. That will
cause rb_event_length() to read the next 4 bytes which could happen to be off the
allocated page.

To protect against this, fail immediately if the next event pointer is
less than 8 bytes from the end of the commit (last byte of data), as all
events must be a minimum of 8 bytes anyway.

Link: https://lore.kernel.org/all/20230905141245.26470-1-Tze-nan.Wu@mediatek.com/
Link: https://lore.kernel.org/linux-trace-kernel/20230907122820.0899019c@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Reported-by: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index b15d72284c7f7..69db849ae7dad 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2352,6 +2352,11 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
 	 */
 	commit = rb_page_commit(iter_head_page);
 	smp_rmb();
+
+	/* An event needs to be at least 8 bytes in size */
+	if (iter->head > commit - 8)
+		goto reset;
+
 	event = __rb_page_index(iter_head_page, iter->head);
 	length = rb_event_length(event);
 
-- 
2.40.1



