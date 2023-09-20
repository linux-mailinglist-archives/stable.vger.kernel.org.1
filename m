Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275A77A7B87
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbjITLxH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbjITLxG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:53:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53D1AD
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:52:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB13EC433C7;
        Wed, 20 Sep 2023 11:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210779;
        bh=uKXXiU7mmVZBnHMPJZocCfAxv5WulQps9TEbhaV/2OQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oh7M21ZAMiWka8UsOsSEKmnXDNXZWCtjNWQOJpHsou4gCpQidkb1IvciqLSRxF4Am
         Gn3L7ZMyDN2ukkvlObbyGowfjzrlKWn4IPCQyDGeuKy3aZ+pXscU/TB8iCHRvGR2Hf
         QdJX+2eF46LoWZ/UbtZN5HqJE9WZFvvDvR8bqdLo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.5 184/211] tracing/synthetic: Fix order of struct trace_dynamic_info
Date:   Wed, 20 Sep 2023 13:30:28 +0200
Message-ID: <20230920112851.579736524@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (Google) <rostedt@goodmis.org>

commit fc52a64416b010c8324e2cb50070faae868521c1 upstream.

To make handling BIG and LITTLE endian better the offset/len of dynamic
fields of the synthetic events was changed into a structure of:

 struct trace_dynamic_info {
 #ifdef CONFIG_CPU_BIG_ENDIAN
	u16	offset;
	u16	len;
 #else
	u16	len;
	u16	offset;
 #endif
 };

to replace the manual changes of:

 data_offset = offset & 0xffff;
 data_offest = len << 16;

But if you look closely, the above is:

  <len> << 16 | offset

Which in little endian would be in memory:

 offset_lo offset_hi len_lo len_hi

and in big endian:

 len_hi len_lo offset_hi offset_lo

Which if broken into a structure would be:

 struct trace_dynamic_info {
 #ifdef CONFIG_CPU_BIG_ENDIAN
	u16	len;
	u16	offset;
 #else
	u16	offset;
	u16	len;
 #endif
 };

Which is the opposite of what was defined.

Fix this and just to be safe also add "__packed".

Link: https://lore.kernel.org/all/20230908154417.5172e343@gandalf.local.home/
Link: https://lore.kernel.org/linux-trace-kernel/20230908163929.2c25f3dc@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
Tested-by: Sven Schnelle <svens@linux.ibm.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Fixes: ddeea494a16f3 ("tracing/synthetic: Use union instead of casts")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/trace_events.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 12f875e9e69a..21ae37e49319 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -62,13 +62,13 @@ void trace_event_printf(struct trace_iterator *iter, const char *fmt, ...);
 /* Used to find the offset and length of dynamic fields in trace events */
 struct trace_dynamic_info {
 #ifdef CONFIG_CPU_BIG_ENDIAN
-	u16	offset;
 	u16	len;
+	u16	offset;
 #else
-	u16	len;
 	u16	offset;
+	u16	len;
 #endif
-};
+} __packed;
 
 /*
  * The trace entry - the most basic unit of tracing. This is what
-- 
2.42.0



