Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCE078AA36
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjH1KUJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjH1KTo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:19:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5031A5
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:19:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A7D56382F
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B104C433C7;
        Mon, 28 Aug 2023 10:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693217949;
        bh=6oths7OvFtATegAo6TUbG5jbP/UkDVDNkf+uHHWl4R0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gwfiQj8LGxRMCvE/EMMGzJvmeqPv3aXRT9JdFXDIuXE4NYwG1ZnRtHFtImhCCEnAm
         VRD0U8bXed7+phb5E7XxVe/qcPZywFvXTOWHijfvxyouTW7bUpcXrTm/JqLFN6Gvil
         vugzHZdcrBHy3fqPs1YEZfDqz15OmrbI3eTm9nnI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 012/129] tracing/synthetic: Use union instead of casts
Date:   Mon, 28 Aug 2023 12:11:31 +0200
Message-ID: <20230828101157.800135532@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Schnelle <svens@linux.ibm.com>

[ Upstream commit ddeea494a16f32522bce16ee65f191d05d4b8282 ]

The current code uses a lot of casts to access the fields member in struct
synth_trace_events with different sizes.  This makes the code hard to
read, and had already introduced an endianness bug. Use a union and struct
instead.

Link: https://lkml.kernel.org/r/20230816154928.4171614-2-svens@linux.ibm.com

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: 00cf3d672a9dd ("tracing: Allow synthetic events to pass around stacktraces")
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Stable-dep-of: 887f92e09ef3 ("tracing/synthetic: Skip first entry for stack traces")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/trace_events.h      | 11 ++++
 kernel/trace/trace.h              |  8 +++
 kernel/trace/trace_events_synth.c | 87 +++++++++++++------------------
 3 files changed, 56 insertions(+), 50 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 7c4a0b72334eb..c55fc453e33b5 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -59,6 +59,17 @@ int trace_raw_output_prep(struct trace_iterator *iter,
 extern __printf(2, 3)
 void trace_event_printf(struct trace_iterator *iter, const char *fmt, ...);
 
+/* Used to find the offset and length of dynamic fields in trace events */
+struct trace_dynamic_info {
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	u16	offset;
+	u16	len;
+#else
+	u16	len;
+	u16	offset;
+#endif
+};
+
 /*
  * The trace entry - the most basic unit of tracing. This is what
  * is printed in the end as a single line in the trace output, such as:
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index eee1f3ca47494..2daeac8e690a6 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1282,6 +1282,14 @@ static inline void trace_branch_disable(void)
 /* set ring buffers to default size if not already done so */
 int tracing_update_buffers(void);
 
+union trace_synth_field {
+	u8				as_u8;
+	u16				as_u16;
+	u32				as_u32;
+	u64				as_u64;
+	struct trace_dynamic_info	as_dynamic;
+};
+
 struct ftrace_event_field {
 	struct list_head	link;
 	const char		*name;
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index d6a70aff24101..da0627fa91caf 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -127,7 +127,7 @@ static bool synth_event_match(const char *system, const char *event,
 
 struct synth_trace_event {
 	struct trace_entry	ent;
-	u64			fields[];
+	union trace_synth_field	fields[];
 };
 
 static int synth_event_define_fields(struct trace_event_call *call)
@@ -321,19 +321,19 @@ static const char *synth_field_fmt(char *type)
 
 static void print_synth_event_num_val(struct trace_seq *s,
 				      char *print_fmt, char *name,
-				      int size, u64 val, char *space)
+				      int size, union trace_synth_field *val, char *space)
 {
 	switch (size) {
 	case 1:
-		trace_seq_printf(s, print_fmt, name, (u8)val, space);
+		trace_seq_printf(s, print_fmt, name, val->as_u8, space);
 		break;
 
 	case 2:
-		trace_seq_printf(s, print_fmt, name, (u16)val, space);
+		trace_seq_printf(s, print_fmt, name, val->as_u16, space);
 		break;
 
 	case 4:
-		trace_seq_printf(s, print_fmt, name, (u32)val, space);
+		trace_seq_printf(s, print_fmt, name, val->as_u32, space);
 		break;
 
 	default:
@@ -374,36 +374,26 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 		/* parameter values */
 		if (se->fields[i]->is_string) {
 			if (se->fields[i]->is_dynamic) {
-				u32 offset, data_offset;
-				char *str_field;
-
-				offset = (u32)entry->fields[n_u64];
-				data_offset = offset & 0xffff;
-
-				str_field = (char *)entry + data_offset;
+				union trace_synth_field *data = &entry->fields[n_u64];
 
 				trace_seq_printf(s, print_fmt, se->fields[i]->name,
 						 STR_VAR_LEN_MAX,
-						 str_field,
+						 (char *)entry + data->as_dynamic.offset,
 						 i == se->n_fields - 1 ? "" : " ");
 				n_u64++;
 			} else {
 				trace_seq_printf(s, print_fmt, se->fields[i]->name,
 						 STR_VAR_LEN_MAX,
-						 (char *)&entry->fields[n_u64],
+						 (char *)&entry->fields[n_u64].as_u64,
 						 i == se->n_fields - 1 ? "" : " ");
 				n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
 			}
 		} else if (se->fields[i]->is_stack) {
-			u32 offset, data_offset, len;
 			unsigned long *p, *end;
+			union trace_synth_field *data = &entry->fields[n_u64];
 
-			offset = (u32)entry->fields[n_u64];
-			data_offset = offset & 0xffff;
-			len = offset >> 16;
-
-			p = (void *)entry + data_offset;
-			end = (void *)p + len - (sizeof(long) - 1);
+			p = (void *)entry + data->as_dynamic.offset;
+			end = (void *)p + data->as_dynamic.len - (sizeof(long) - 1);
 
 			trace_seq_printf(s, "%s=STACK:\n", se->fields[i]->name);
 
@@ -419,13 +409,13 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 			print_synth_event_num_val(s, print_fmt,
 						  se->fields[i]->name,
 						  se->fields[i]->size,
-						  entry->fields[n_u64],
+						  &entry->fields[n_u64],
 						  space);
 
 			if (strcmp(se->fields[i]->type, "gfp_t") == 0) {
 				trace_seq_puts(s, " (");
 				trace_print_flags_seq(s, "|",
-						      entry->fields[n_u64],
+						      entry->fields[n_u64].as_u64,
 						      __flags);
 				trace_seq_putc(s, ')');
 			}
@@ -454,21 +444,16 @@ static unsigned int trace_string(struct synth_trace_event *entry,
 	int ret;
 
 	if (is_dynamic) {
-		u32 data_offset;
+		union trace_synth_field *data = &entry->fields[*n_u64];
 
-		data_offset = struct_size(entry, fields, event->n_u64);
-		data_offset += data_size;
-
-		len = fetch_store_strlen((unsigned long)str_val);
-
-		data_offset |= len << 16;
-		*(u32 *)&entry->fields[*n_u64] = data_offset;
+		data->as_dynamic.offset = struct_size(entry, fields, event->n_u64) + data_size;
+		data->as_dynamic.len = fetch_store_strlen((unsigned long)str_val);
 
 		ret = fetch_store_string((unsigned long)str_val, &entry->fields[*n_u64], entry);
 
 		(*n_u64)++;
 	} else {
-		str_field = (char *)&entry->fields[*n_u64];
+		str_field = (char *)&entry->fields[*n_u64].as_u64;
 
 #ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 		if ((unsigned long)str_val < TASK_SIZE)
@@ -492,6 +477,7 @@ static unsigned int trace_stack(struct synth_trace_event *entry,
 				 unsigned int data_size,
 				 unsigned int *n_u64)
 {
+	union trace_synth_field *data = &entry->fields[*n_u64];
 	unsigned int len;
 	u32 data_offset;
 	void *data_loc;
@@ -515,8 +501,9 @@ static unsigned int trace_stack(struct synth_trace_event *entry,
 	memcpy(data_loc, stack, len);
 
 	/* Fill in the field that holds the offset/len combo */
-	data_offset |= len << 16;
-	*(u32 *)&entry->fields[*n_u64] = data_offset;
+
+	data->as_dynamic.offset = data_offset;
+	data->as_dynamic.len = len;
 
 	(*n_u64)++;
 
@@ -592,19 +579,19 @@ static notrace void trace_event_raw_event_synth(void *__data,
 
 			switch (field->size) {
 			case 1:
-				*(u8 *)&entry->fields[n_u64] = (u8)val;
+				entry->fields[n_u64].as_u8 = (u8)val;
 				break;
 
 			case 2:
-				*(u16 *)&entry->fields[n_u64] = (u16)val;
+				entry->fields[n_u64].as_u16 = (u16)val;
 				break;
 
 			case 4:
-				*(u32 *)&entry->fields[n_u64] = (u32)val;
+				entry->fields[n_u64].as_u32 = (u32)val;
 				break;
 
 			default:
-				entry->fields[n_u64] = val;
+				entry->fields[n_u64].as_u64 = val;
 				break;
 			}
 			n_u64++;
@@ -1790,19 +1777,19 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
 
 			switch (field->size) {
 			case 1:
-				*(u8 *)&state.entry->fields[n_u64] = (u8)val;
+				state.entry->fields[n_u64].as_u8 = (u8)val;
 				break;
 
 			case 2:
-				*(u16 *)&state.entry->fields[n_u64] = (u16)val;
+				state.entry->fields[n_u64].as_u16 = (u16)val;
 				break;
 
 			case 4:
-				*(u32 *)&state.entry->fields[n_u64] = (u32)val;
+				state.entry->fields[n_u64].as_u32 = (u32)val;
 				break;
 
 			default:
-				state.entry->fields[n_u64] = val;
+				state.entry->fields[n_u64].as_u64 = val;
 				break;
 			}
 			n_u64++;
@@ -1883,19 +1870,19 @@ int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
 
 			switch (field->size) {
 			case 1:
-				*(u8 *)&state.entry->fields[n_u64] = (u8)val;
+				state.entry->fields[n_u64].as_u8 = (u8)val;
 				break;
 
 			case 2:
-				*(u16 *)&state.entry->fields[n_u64] = (u16)val;
+				state.entry->fields[n_u64].as_u16 = (u16)val;
 				break;
 
 			case 4:
-				*(u32 *)&state.entry->fields[n_u64] = (u32)val;
+				state.entry->fields[n_u64].as_u32 = (u32)val;
 				break;
 
 			default:
-				state.entry->fields[n_u64] = val;
+				state.entry->fields[n_u64].as_u64 = val;
 				break;
 			}
 			n_u64++;
@@ -2030,19 +2017,19 @@ static int __synth_event_add_val(const char *field_name, u64 val,
 	} else {
 		switch (field->size) {
 		case 1:
-			*(u8 *)&trace_state->entry->fields[field->offset] = (u8)val;
+			trace_state->entry->fields[field->offset].as_u8 = (u8)val;
 			break;
 
 		case 2:
-			*(u16 *)&trace_state->entry->fields[field->offset] = (u16)val;
+			trace_state->entry->fields[field->offset].as_u16 = (u16)val;
 			break;
 
 		case 4:
-			*(u32 *)&trace_state->entry->fields[field->offset] = (u32)val;
+			trace_state->entry->fields[field->offset].as_u32 = (u32)val;
 			break;
 
 		default:
-			trace_state->entry->fields[field->offset] = val;
+			trace_state->entry->fields[field->offset].as_u64 = val;
 			break;
 		}
 	}
-- 
2.40.1



