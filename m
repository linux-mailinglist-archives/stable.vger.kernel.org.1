Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87326FA3AF
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbjEHJvH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbjEHJue (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:50:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF702383B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:50:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98094621B7
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C4DC4339B;
        Mon,  8 May 2023 09:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539432;
        bh=mFvArCJXTNfMHGEFXBtdeuGMV4GW0PAwwWJ/18fxOFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QE72J9sPQEk/3Bel7fzLhmjF/gtPLsxKLXPADK2sFlXyEQW7zWx3Favuj7IDk6Tvq
         ChYFUoZWjc51DQM2Eo/qCTJln3GNxp0x05yip6ihxB5+fkWYMyNuMADONUhuYO3NY/
         a3lpLJ/eVLMPdYVm3Jw8QZZNl+UrSzXo/Jrs2Yag=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Douglas RAILLARD <douglas.raillard@arm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 015/611] tracing: Error if a trace event has an array for a __field()
Date:   Mon,  8 May 2023 11:37:37 +0200
Message-Id: <20230508094422.180381995@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Steven Rostedt (Google) <rostedt@goodmis.org>

[ Upstream commit f82e7ca019dfad3b006fd3b772f7ac569672db55 ]

A __field() in the TRACE_EVENT() macro is used to set up the fields of the
trace event data. It is for single storage units (word, char, int,
pointer, etc) and not for complex structures or arrays. Unfortunately,
there's nothing preventing the build from accepting:

    __field(int, arr[5]);

from building. It will turn into a array value. This use to work fine, as
the offset and size use to be determined by the macro using the field name,
but things have changed and the offset and size are now determined by the
type. So the above would only be size 4, and the next field will be
located 4 bytes from it (instead of 20).

The proper way to declare static arrays is to use the __array() macro.

Instead of __field(int, arr[5]) it should be __array(int, arr, 5).

Add some macro tricks to the building of a trace event from the
TRACE_EVENT() macro such that __field(int, arr[5]) will fail to build. A
comment by the failure will explain why the build failed.

Link: https://lore.kernel.org/lkml/20230306122549.236561-1-douglas.raillard@arm.com/
Link: https://lore.kernel.org/linux-trace-kernel/20230309221302.642e82d9@gandalf.local.home

Reported-by: Douglas RAILLARD <douglas.raillard@arm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/stages/stage5_get_offsets.h | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/trace/stages/stage5_get_offsets.h b/include/trace/stages/stage5_get_offsets.h
index fba4c24ed9e60..def36fbb8c5cd 100644
--- a/include/trace/stages/stage5_get_offsets.h
+++ b/include/trace/stages/stage5_get_offsets.h
@@ -9,17 +9,30 @@
 #undef __entry
 #define __entry entry
 
+/*
+ * Fields should never declare an array: i.e. __field(int, arr[5])
+ * If they do, it will cause issues in parsing and possibly corrupt the
+ * events. To prevent that from happening, test the sizeof() a fictitious
+ * type called "struct _test_no_array_##item" which will fail if "item"
+ * contains array elements (like "arr[5]").
+ *
+ * If you hit this, use __array(int, arr, 5) instead.
+ */
 #undef __field
-#define __field(type, item)
+#define __field(type, item)					\
+	{ (void)sizeof(struct _test_no_array_##item *); }
 
 #undef __field_ext
-#define __field_ext(type, item, filter_type)
+#define __field_ext(type, item, filter_type)			\
+	{ (void)sizeof(struct _test_no_array_##item *); }
 
 #undef __field_struct
-#define __field_struct(type, item)
+#define __field_struct(type, item)				\
+	{ (void)sizeof(struct _test_no_array_##item *); }
 
 #undef __field_struct_ext
-#define __field_struct_ext(type, item, filter_type)
+#define __field_struct_ext(type, item, filter_type)		\
+	{ (void)sizeof(struct _test_no_array_##item *); }
 
 #undef __array
 #define __array(type, item, len)
-- 
2.39.2



