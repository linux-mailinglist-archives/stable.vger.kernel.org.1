Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5589570C673
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbjEVTS0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbjEVTSS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:18:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F208518B
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:18:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1D2B627AB
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:18:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE010C433EF;
        Mon, 22 May 2023 19:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783083;
        bh=AtayK4qjk1FQXuXKweT+CK/sOWtmkq+l/B5DzF85RJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ae+4Odh/nC5t7yuVgUaaj1Jp2bk50pjflPf0qzS+aRHm8km5FovpI4YrFng+Gvzzc
         UMqtpxXe45WLUWSXzck2z8ecKK9uvHXSIc05DzXCYuIza6mXoalhz+0Jf1dwPVyVV+
         jhsTB8HLv55uEeoGmO/LCe1BdJ/HtCRsx55gBpEc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 134/203] tracing: Introduce helpers to safely handle dynamic-sized sockaddrs
Date:   Mon, 22 May 2023 20:09:18 +0100
Message-Id: <20230522190358.676920670@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit d07c9ad622474616e94572e59e725c2c4a494fb4 ]

Enable a struct sockaddr to be stored in a trace record as a
dynamically-sized field. The common cases are AF_INET and AF_INET6
which are different sizes, and are vastly smaller than a struct
sockaddr_storage.

These are safer because, when used properly, the size of the
sockaddr destination field in each trace record is now guaranteed
to be the same as the source address that is being copied into it.

Link: https://lore.kernel.org/all/164182978641.8391.8277203495236105391.stgit@bazille.1015granger.net/
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 948f072ada23 ("SUNRPC: always free ctxt when freeing deferred request")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/bpf_probe.h    |  6 ++++
 include/trace/perf.h         |  6 ++++
 include/trace/trace_events.h | 55 ++++++++++++++++++++++++++++++++++--
 3 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index 04939b2d2f192..26ec024c3d58a 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -21,6 +21,9 @@
 #undef __get_bitmask
 #define __get_bitmask(field) (char *)__get_dynamic_array(field)
 
+#undef __get_sockaddr
+#define __get_sockaddr(field) ((struct sockaddr *)__get_dynamic_array(field))
+
 #undef __get_rel_dynamic_array
 #define __get_rel_dynamic_array(field)	\
 		((void *)(&__entry->__rel_loc_##field) +	\
@@ -37,6 +40,9 @@
 #undef __get_rel_bitmask
 #define __get_rel_bitmask(field) (char *)__get_rel_dynamic_array(field)
 
+#undef __get_rel_sockaddr
+#define __get_rel_sockaddr(field) ((struct sockaddr *)__get_rel_dynamic_array(field))
+
 #undef __perf_count
 #define __perf_count(c)	(c)
 
diff --git a/include/trace/perf.h b/include/trace/perf.h
index 5d48c46a30083..5800d13146c3d 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -21,6 +21,9 @@
 #undef __get_bitmask
 #define __get_bitmask(field) (char *)__get_dynamic_array(field)
 
+#undef __get_sockaddr
+#define __get_sockaddr(field) ((struct sockaddr *)__get_dynamic_array(field))
+
 #undef __get_rel_dynamic_array
 #define __get_rel_dynamic_array(field)	\
 		((void *)__entry +					\
@@ -38,6 +41,9 @@
 #undef __get_rel_bitmask
 #define __get_rel_bitmask(field) (char *)__get_rel_dynamic_array(field)
 
+#undef __get_rel_sockaddr
+#define __get_rel_sockaddr(field) ((struct sockaddr *)__get_rel_dynamic_array(field))
+
 #undef __perf_count
 #define __perf_count(c)	(__count = (c))
 
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 7f0b91dfb532d..e6b19ab357815 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -108,6 +108,9 @@ TRACE_MAKE_SYSTEM_STR();
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(char, item, -1)
 
+#undef __sockaddr
+#define __sockaddr(field, len) __dynamic_array(u8, field, len)
+
 #undef __rel_dynamic_array
 #define __rel_dynamic_array(type, item, len) u32 __rel_loc_##item;
 
@@ -120,6 +123,9 @@ TRACE_MAKE_SYSTEM_STR();
 #undef __rel_bitmask
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(char, item, -1)
 
+#undef __rel_sockaddr
+#define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
+
 #undef TP_STRUCT__entry
 #define TP_STRUCT__entry(args...) args
 
@@ -212,11 +218,14 @@ TRACE_MAKE_SYSTEM_STR();
 #undef __string
 #define __string(item, src) __dynamic_array(char, item, -1)
 
+#undef __string_len
+#define __string_len(item, src, len) __dynamic_array(char, item, -1)
+
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
-#undef __string_len
-#define __string_len(item, src, len) __dynamic_array(char, item, -1)
+#undef __sockaddr
+#define __sockaddr(field, len) __dynamic_array(u8, field, len)
 
 #undef __rel_dynamic_array
 #define __rel_dynamic_array(type, item, len)	u32 item;
@@ -230,6 +239,9 @@ TRACE_MAKE_SYSTEM_STR();
 #undef __rel_bitmask
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item, -1)
 
+#undef __rel_sockaddr
+#define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
+
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
 	struct trace_event_data_offsets_##call {			\
@@ -349,6 +361,12 @@ TRACE_MAKE_SYSTEM_STR();
 		trace_print_bitmask_seq(p, __bitmask, __bitmask_size);	\
 	})
 
+#undef __get_sockaddr
+#define __get_sockaddr(field)	((struct sockaddr *)__get_dynamic_array(field))
+
+#undef __get_rel_sockaddr
+#define __get_rel_sockaddr(field)	((struct sockaddr *)__get_rel_dynamic_array(field))
+
 #undef __print_flags
 #define __print_flags(flag, delim, flag_array...)			\
 	({								\
@@ -520,6 +538,9 @@ static struct trace_event_functions trace_event_type_funcs_##call = {	\
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
+#undef __sockaddr
+#define __sockaddr(field, len) __dynamic_array(u8, field, len)
+
 #undef __rel_dynamic_array
 #define __rel_dynamic_array(_type, _item, _len) {			\
 	.type = "__rel_loc " #_type "[]", .name = #_item,		\
@@ -535,6 +556,9 @@ static struct trace_event_functions trace_event_type_funcs_##call = {	\
 #undef __rel_bitmask
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item, -1)
 
+#undef __rel_sockaddr
+#define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
+
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, func, print)	\
 static struct trace_event_fields trace_event_fields_##call[] = {	\
@@ -626,6 +650,12 @@ static struct trace_event_fields trace_event_fields_##call[] = {	\
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item,	\
 					 __bitmask_size_in_longs(nr_bits))
 
+#undef __sockaddr
+#define __sockaddr(field, len) __dynamic_array(u8, field, len)
+
+#undef __rel_sockaddr
+#define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
+
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
 static inline notrace int trace_event_get_offsets_##call(		\
@@ -790,6 +820,15 @@ static inline notrace int trace_event_get_offsets_##call(		\
 #define __assign_bitmask(dst, src, nr_bits)					\
 	memcpy(__get_bitmask(dst), (src), __bitmask_size_in_bytes(nr_bits))
 
+#undef __sockaddr
+#define __sockaddr(field, len) __dynamic_array(u8, field, len)
+
+#undef __get_sockaddr
+#define __get_sockaddr(field)	((struct sockaddr *)__get_dynamic_array(field))
+
+#define __assign_sockaddr(dest, src, len)					\
+	memcpy(__get_dynamic_array(dest), src, len)
+
 #undef __rel_dynamic_array
 #define __rel_dynamic_array(type, item, len)				\
 	__entry->__rel_loc_##item = __data_offsets.item;
@@ -821,6 +860,16 @@ static inline notrace int trace_event_get_offsets_##call(		\
 #define __assign_rel_bitmask(dst, src, nr_bits)					\
 	memcpy(__get_rel_bitmask(dst), (src), __bitmask_size_in_bytes(nr_bits))
 
+#undef __rel_sockaddr
+#define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
+
+#undef __get_rel_sockaddr
+#define __get_rel_sockaddr(field)	((struct sockaddr *)__get_rel_dynamic_array(field))
+
+#define __assign_rel_sockaddr(dest, src, len)					\
+	memcpy(__get_rel_dynamic_array(dest), src, len)
+
+
 #undef TP_fast_assign
 #define TP_fast_assign(args...) args
 
@@ -885,10 +934,12 @@ static inline void ftrace_test_probe_##call(void)			\
 #undef __get_dynamic_array_len
 #undef __get_str
 #undef __get_bitmask
+#undef __get_sockaddr
 #undef __get_rel_dynamic_array
 #undef __get_rel_dynamic_array_len
 #undef __get_rel_str
 #undef __get_rel_bitmask
+#undef __get_rel_sockaddr
 #undef __print_array
 #undef __print_hex_dump
 
-- 
2.39.2



