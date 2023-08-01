Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3E576AE05
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjHAJfg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbjHAJfU (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:35:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12F410C
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:33:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59080614CF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606E0C433C8;
        Tue,  1 Aug 2023 09:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882382;
        bh=RZkTMoNmHRyipBonLNTB65cW3a9lqxfEVeyevHqrSZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r4K41gMR8fG8Opo/qsMZ5CDATLZRra/kpESSWS0xY1lv5wht53xWm1v83CjJ5jdBn
         jp6P5CbBIaqlgdFfoxzZJsHdkq0rRFnsOuWj1rehgqv9Psb1Y+D/tKRunDMvYX3W48
         wWU43cqdvOp60hAhpmZRO9/G4MCzKTtneTqnOqqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 057/228] tracing/probes: Add symstr type for dynamic events
Date:   Tue,  1 Aug 2023 11:18:35 +0200
Message-ID: <20230801091924.932469911@linuxfoundation.org>
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

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

[ Upstream commit b26a124cbfa80f42bfc4e63e1d5643ca98159d66 ]

Add 'symstr' type for storing the kernel symbol as a string data
instead of the symbol address. This allows us to filter the
events by wildcard symbol name.

e.g.
  # echo 'e:wqfunc workqueue.workqueue_execute_start symname=$function:symstr' >> dynamic_events
  # cat events/eprobes/wqfunc/format
  name: wqfunc
  ID: 2110
  format:
  	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
  	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
  	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
  	field:int common_pid;	offset:4;	size:4;	signed:1;

  	field:__data_loc char[] symname;	offset:8;	size:4;	signed:1;

  print fmt: " symname=\"%s\"", __get_str(symname)

Note that there is already 'symbol' type which just change the
print format (so it still stores the symbol address in the tracing
ring buffer.) On the other hand, 'symstr' type stores the actual
"symbol+offset/size" data as a string.

Link: https://lore.kernel.org/all/166679930847.1528100.4124308529180235965.stgit@devnote3/

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Stable-dep-of: 66bcf65d6cf0 ("tracing/probes: Fix to avoid double count of the string length on the array")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/trace/kprobetrace.rst |  8 +++--
 kernel/trace/trace.c                |  2 +-
 kernel/trace/trace_probe.c          | 44 ++++++++++++++++++---------
 kernel/trace/trace_probe.h          | 16 +++++++---
 kernel/trace/trace_probe_tmpl.h     | 47 +++++++++++++++++++++++++++--
 5 files changed, 91 insertions(+), 26 deletions(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 4274cc6a2f94f..08a2a6a3782f0 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -58,8 +58,8 @@ Synopsis of kprobe_events
   NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
   FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
 		  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
-		  (x8/x16/x32/x64), "string", "ustring" and bitfield
-		  are supported.
+		  (x8/x16/x32/x64), "string", "ustring", "symbol", "symstr"
+                  and bitfield are supported.
 
   (\*1) only for the probe on function entry (offs == 0).
   (\*2) only for return probe.
@@ -96,6 +96,10 @@ offset, and container-size (usually 32). The syntax is::
 
 Symbol type('symbol') is an alias of u32 or u64 type (depends on BITS_PER_LONG)
 which shows given pointer in "symbol+offset" style.
+On the other hand, symbol-string type ('symstr') converts the given address to
+"symbol+offset/symbolsize" style and stores it as a null-terminated string.
+With 'symstr' type, you can filter the event with wildcard pattern of the
+symbols, and you don't need to solve symbol name by yourself.
 For $comm, the default type is "string"; any other type is invalid.
 
 .. _user_mem_access:
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 27bbe180a2ef2..709af9631be45 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5627,7 +5627,7 @@ static const char readme_msg[] =
 	"\t           +|-[u]<offset>(<fetcharg>), \\imm-value, \\\"imm-string\"\n"
 	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string, symbol,\n"
 	"\t           b<bit-width>@<bit-offset>/<container-size>, ustring,\n"
-	"\t           <type>\\[<array-size>\\]\n"
+	"\t           symstr, <type>\\[<array-size>\\]\n"
 #ifdef CONFIG_HIST_TRIGGERS
 	"\t    field: <stype> <name>;\n"
 	"\t    stype: u8/u16/u32/u64, s8/s16/s32/s64, pid_t,\n"
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index bb2f95d7175c2..c3852180bbb61 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -76,9 +76,11 @@ const char PRINT_TYPE_FMT_NAME(string)[] = "\\\"%s\\\"";
 /* Fetch type information table */
 static const struct fetch_type probe_fetch_types[] = {
 	/* Special types */
-	__ASSIGN_FETCH_TYPE("string", string, string, sizeof(u32), 1,
+	__ASSIGN_FETCH_TYPE("string", string, string, sizeof(u32), 1, 1,
 			    "__data_loc char[]"),
-	__ASSIGN_FETCH_TYPE("ustring", string, string, sizeof(u32), 1,
+	__ASSIGN_FETCH_TYPE("ustring", string, string, sizeof(u32), 1, 1,
+			    "__data_loc char[]"),
+	__ASSIGN_FETCH_TYPE("symstr", string, string, sizeof(u32), 1, 1,
 			    "__data_loc char[]"),
 	/* Basic types */
 	ASSIGN_FETCH_TYPE(u8,  u8,  0),
@@ -662,16 +664,26 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 
 	ret = -EINVAL;
 	/* Store operation */
-	if (!strcmp(parg->type->name, "string") ||
-	    !strcmp(parg->type->name, "ustring")) {
-		if (code->op != FETCH_OP_DEREF && code->op != FETCH_OP_UDEREF &&
-		    code->op != FETCH_OP_IMM && code->op != FETCH_OP_COMM &&
-		    code->op != FETCH_OP_DATA && code->op != FETCH_OP_TP_ARG) {
-			trace_probe_log_err(offset + (t ? (t - arg) : 0),
-					    BAD_STRING);
-			goto fail;
+	if (parg->type->is_string) {
+		if (!strcmp(parg->type->name, "symstr")) {
+			if (code->op != FETCH_OP_REG && code->op != FETCH_OP_STACK &&
+			    code->op != FETCH_OP_RETVAL && code->op != FETCH_OP_ARG &&
+			    code->op != FETCH_OP_DEREF && code->op != FETCH_OP_TP_ARG) {
+				trace_probe_log_err(offset + (t ? (t - arg) : 0),
+						    BAD_SYMSTRING);
+				goto fail;
+			}
+		} else {
+			if (code->op != FETCH_OP_DEREF && code->op != FETCH_OP_UDEREF &&
+			    code->op != FETCH_OP_IMM && code->op != FETCH_OP_COMM &&
+			    code->op != FETCH_OP_DATA && code->op != FETCH_OP_TP_ARG) {
+				trace_probe_log_err(offset + (t ? (t - arg) : 0),
+						    BAD_STRING);
+				goto fail;
+			}
 		}
-		if ((code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM ||
+		if (!strcmp(parg->type->name, "symstr") ||
+		    (code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM ||
 		     code->op == FETCH_OP_DATA) || code->op == FETCH_OP_TP_ARG ||
 		     parg->count) {
 			/*
@@ -679,6 +691,8 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 			 * must be kept, and if parg->count != 0, this is an
 			 * array of string pointers instead of string address
 			 * itself.
+			 * For the symstr, it doesn't need to dereference, thus
+			 * it just get the value.
 			 */
 			code++;
 			if (code->op != FETCH_OP_NOP) {
@@ -690,6 +704,8 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 		if (!strcmp(parg->type->name, "ustring") ||
 		    code->op == FETCH_OP_UDEREF)
 			code->op = FETCH_OP_ST_USTRING;
+		else if (!strcmp(parg->type->name, "symstr"))
+			code->op = FETCH_OP_ST_SYMSTR;
 		else
 			code->op = FETCH_OP_ST_STRING;
 		code->size = parg->type->size;
@@ -919,8 +935,7 @@ static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
 	for (i = 0; i < tp->nr_args; i++) {
 		parg = tp->args + i;
 		if (parg->count) {
-			if ((strcmp(parg->type->name, "string") == 0) ||
-			    (strcmp(parg->type->name, "ustring") == 0))
+			if (parg->type->is_string)
 				fmt = ", __get_str(%s[%d])";
 			else
 				fmt = ", REC->%s[%d]";
@@ -928,8 +943,7 @@ static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
 				pos += snprintf(buf + pos, LEN_OR_ZERO,
 						fmt, parg->name, j);
 		} else {
-			if ((strcmp(parg->type->name, "string") == 0) ||
-			    (strcmp(parg->type->name, "ustring") == 0))
+			if (parg->type->is_string)
 				fmt = ", __get_str(%s)";
 			else
 				fmt = ", REC->%s";
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 3d731aac94d49..f41c330bd60f1 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -98,6 +98,7 @@ enum fetch_op {
 	FETCH_OP_ST_UMEM,	/* Mem: .offset, .size */
 	FETCH_OP_ST_STRING,	/* String: .offset, .size */
 	FETCH_OP_ST_USTRING,	/* User String: .offset, .size */
+	FETCH_OP_ST_SYMSTR,	/* Kernel Symbol String: .offset, .size */
 	// Stage 4 (modify) op
 	FETCH_OP_MOD_BF,	/* Bitfield: .basesize, .lshift, .rshift */
 	// Stage 5 (loop) op
@@ -133,7 +134,8 @@ struct fetch_insn {
 struct fetch_type {
 	const char		*name;		/* Name of type */
 	size_t			size;		/* Byte size of type */
-	int			is_signed;	/* Signed flag */
+	bool			is_signed;	/* Signed flag */
+	bool			is_string;	/* String flag */
 	print_type_func_t	print;		/* Print functions */
 	const char		*fmt;		/* Format string */
 	const char		*fmttype;	/* Name in format file */
@@ -177,16 +179,19 @@ DECLARE_BASIC_PRINT_TYPE_FUNC(symbol);
 #define _ADDR_FETCH_TYPE(t) __ADDR_FETCH_TYPE(t)
 #define ADDR_FETCH_TYPE _ADDR_FETCH_TYPE(BITS_PER_LONG)
 
-#define __ASSIGN_FETCH_TYPE(_name, ptype, ftype, _size, sign, _fmttype)	\
-	{.name = _name,				\
+#define __ASSIGN_FETCH_TYPE(_name, ptype, ftype, _size, sign, str, _fmttype)	\
+	{.name = _name,					\
 	 .size = _size,					\
-	 .is_signed = sign,				\
+	 .is_signed = (bool)sign,			\
+	 .is_string = (bool)str,			\
 	 .print = PRINT_TYPE_FUNC_NAME(ptype),		\
 	 .fmt = PRINT_TYPE_FMT_NAME(ptype),		\
 	 .fmttype = _fmttype,				\
 	}
+
+/* Non string types can use these macros */
 #define _ASSIGN_FETCH_TYPE(_name, ptype, ftype, _size, sign, _fmttype)	\
-	__ASSIGN_FETCH_TYPE(_name, ptype, ftype, _size, sign, #_fmttype)
+	__ASSIGN_FETCH_TYPE(_name, ptype, ftype, _size, sign, 0, #_fmttype)
 #define ASSIGN_FETCH_TYPE(ptype, ftype, sign)			\
 	_ASSIGN_FETCH_TYPE(#ptype, ptype, ftype, sizeof(ftype), sign, ptype)
 
@@ -431,6 +436,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(ARRAY_TOO_BIG,	"Array number is too big"),		\
 	C(BAD_TYPE,		"Unknown type is specified"),		\
 	C(BAD_STRING,		"String accepts only memory argument"),	\
+	C(BAD_SYMSTRING,	"Symbol String doesn't accept data/userdata"),	\
 	C(BAD_BITFIELD,		"Invalid bitfield"),			\
 	C(ARG_NAME_TOO_LONG,	"Argument name is too long"),		\
 	C(NO_ARG_NAME,		"Argument name is not specified"),	\
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index c293a607d5366..21799fa813ca8 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -67,6 +67,37 @@ probe_mem_read(void *dest, void *src, size_t size);
 static nokprobe_inline int
 probe_mem_read_user(void *dest, void *src, size_t size);
 
+static nokprobe_inline int
+fetch_store_symstrlen(unsigned long addr)
+{
+	char namebuf[KSYM_SYMBOL_LEN];
+	int ret;
+
+	ret = sprint_symbol(namebuf, addr);
+	if (ret < 0)
+		return 0;
+
+	return ret + 1;
+}
+
+/*
+ * Fetch a null-terminated symbol string + offset. Caller MUST set *(u32 *)buf
+ * with max length and relative data location.
+ */
+static nokprobe_inline int
+fetch_store_symstring(unsigned long addr, void *dest, void *base)
+{
+	int maxlen = get_loc_len(*(u32 *)dest);
+	void *__dest;
+
+	if (unlikely(!maxlen))
+		return -ENOMEM;
+
+	__dest = get_loc_data(dest, base);
+
+	return sprint_symbol(__dest, addr);
+}
+
 /* From the 2nd stage, routine is same */
 static nokprobe_inline int
 process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
@@ -99,16 +130,22 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 stage3:
 	/* 3rd stage: store value to buffer */
 	if (unlikely(!dest)) {
-		if (code->op == FETCH_OP_ST_STRING) {
+		switch (code->op) {
+		case FETCH_OP_ST_STRING:
 			ret = fetch_store_strlen(val + code->offset);
 			code++;
 			goto array;
-		} else if (code->op == FETCH_OP_ST_USTRING) {
+		case FETCH_OP_ST_USTRING:
 			ret += fetch_store_strlen_user(val + code->offset);
 			code++;
 			goto array;
-		} else
+		case FETCH_OP_ST_SYMSTR:
+			ret += fetch_store_symstrlen(val + code->offset);
+			code++;
+			goto array;
+		default:
 			return -EILSEQ;
+		}
 	}
 
 	switch (code->op) {
@@ -129,6 +166,10 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 		loc = *(u32 *)dest;
 		ret = fetch_store_string_user(val + code->offset, dest, base);
 		break;
+	case FETCH_OP_ST_SYMSTR:
+		loc = *(u32 *)dest;
+		ret = fetch_store_symstring(val + code->offset, dest, base);
+		break;
 	default:
 		return -EILSEQ;
 	}
-- 
2.39.2



