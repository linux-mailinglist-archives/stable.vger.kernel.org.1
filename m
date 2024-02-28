Return-Path: <stable+bounces-25322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF0886A6D8
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 03:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 643281C20930
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 02:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B671DFF2;
	Wed, 28 Feb 2024 02:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Zab5itUG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32614200C0
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 02:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709088375; cv=none; b=M7tNNzq+0qBh0qoEUa/jXUuEpd8JPxYCTjuU+p/Si45SN7Tw8iTznCgsjCUnekK4H6GGRH81bdzbKXyBgvwp1mngCBKW9MFhBA2MRfOw2U+1u6AfyCCve0XWtbIso2SU8lVi8hEaTK+77Tn1lyT47MYclQTgm2zFQK7h4jeYEEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709088375; c=relaxed/simple;
	bh=abhzLrMcAo73itQJFRf9PngJ2NfPzbHIHmMJXMFZsec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ft8bTe8qpPEBwjEoT1xHgq4biNOsXCI8O0ym4mVy5iohm63DEAfV1LdBXR03sSDFawr2Z5dlsInkTSFbzy3U6AhMlzQJqKhHyvc3pQZXqihxYIaRrHcnIgf53QdzHENzrDE38onbiLt1+jkwF/Ks1J0pP1DXV+KHmiFiicdYof0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Zab5itUG; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e49812ba77so1652234a34.2
        for <stable@vger.kernel.org>; Tue, 27 Feb 2024 18:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709088372; x=1709693172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Xvb2DA8xzihP7Mzi/v0EMpx+00b5U5crlo4mSn4zeU=;
        b=Zab5itUGCPvAlQrjJy0TWTfijq60dXxVpV1rCh4oGw61rTSZcwrh1z1mPTzUufbYPm
         5UDndPTkQQAfhPl6inPDKm/vRPHrnvtLACoHsImxuSodljQI6D+eP3k8hVDL0L+7XBUw
         9RT3QZUkYWq7u+toLo46SAwvw6xCbAMM8Z9uVnKIVkcyYQMkUQQp2KIbkkDIQ/zML0Y6
         EaZQEWCj5jCTMmFxu5p7SiBtuEhdZBzj8IMCeGukyHI3moHuLui5Mmc/REB5u4KRWIaD
         gMeiZFK63t6qKTXA2TBVazoLlzR+xGt3hdFGODjzNzW0IxghNspagDAZEIec50Sra+Vf
         mRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709088372; x=1709693172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Xvb2DA8xzihP7Mzi/v0EMpx+00b5U5crlo4mSn4zeU=;
        b=N5fu6b42lOMIe1fvl5jnTOA4VUHpsr+uyN+1mJDt701cD9GQ7bmT1JitnCacEcXzlX
         Tnc0xeJTmGkQz0jKEX7v7aRquyLEEMkcbl3CxaPwRv3DFmnxtB96Fhg9+o32Go7W2d2Q
         lZiBpKobuhppShaFP8Nr3shDHk28wSyIiyM86kx10f9MAKLuMTR3VVpY6ZFOE3XRWgOb
         9HETAv1FDluFo2JFUP1iJcIBoMfAG3LqYhT+LTMvzYt9jxiVfAseL1kjXwWWijg/n/JD
         JwMlTPxKq2ceCANrCsZ+faHT/sFy5JjYw0NDsVH77BZ8MOvaSCb2mdu4iyZYmJdpdeh+
         0RzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwx9feitXEzaT9e6M6MhUaU9IPN2nwN3O5JrBZDy9C8eEMyM7S3JAX5ncwq5Yb860PiIrKyhT/V3UX+1Wb6bat24VOkc8c
X-Gm-Message-State: AOJu0YzyxEqdu5vFqcSk0qAGPn7eSPsyNoKANdt0irkHb+ou0nmYAzBz
	mnr0lShsxwfxzGsXu36MirXqSAgjUac4aa/B5njcqMMRYQZH8RNrZaYrFO2VPvg=
X-Google-Smtp-Source: AGHT+IE/uRJXmSDsmVcdvvQtha1dgj/hFQ8X8ftxAxzYl4tzNY8SQCryfk2c7wi8S6k4aalqlMt/mQ==
X-Received: by 2002:a05:6830:120c:b0:6e4:7be4:393a with SMTP id r12-20020a056830120c00b006e47be4393amr14448289otp.5.1709088372243;
        Tue, 27 Feb 2024 18:46:12 -0800 (PST)
Received: from C02CV19DML87.bytedance.net ([240e:6b1:c0:120::1:d])
        by smtp.gmail.com with ESMTPSA id 9-20020a631249000000b005dcbb699abfsm6489072pgs.34.2024.02.27.18.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 18:46:11 -0800 (PST)
From: Rui Qi <qirui.001@bytedance.com>
To: bp@alien8.de,
	mingo@redhat.com,
	tglx@linutronix.de,
	hpa@zytor.com,
	jpoimboe@redhat.com,
	peterz@infradead.org,
	mbenes@suse.cz,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	alexandre.chartre@oracle.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	yuanzhu@bytedance.com,
	Rui Qi <qirui.001@bytedance.com>
Subject: [PATCH v2 2/3] objtool: Add support for intra-function calls
Date: Wed, 28 Feb 2024 10:45:34 +0800
Message-Id: <20240228024535.79980-3-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240228024535.79980-1-qirui.001@bytedance.com>
References: <20240228024535.79980-1-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandre Chartre <alexandre.chartre@oracle.com>

commit 8aa8eb2a8f5b3305a95f39957dd2b715fa668e21 upstream.

Change objtool to support intra-function calls. On x86, an intra-function
call is represented in objtool as a push onto the stack (of the return
address), and a jump to the destination address. That way the stack
information is correctly updated and the call flow is still accurate.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200414103618.12657-4-alexandre.chartre@oracle.com
Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 include/linux/frame.h                         | 11 ++++
 .../Documentation/stack-validation.txt        |  8 +++
 tools/objtool/arch/x86/decode.c               |  6 ++
 tools/objtool/check.c                         | 62 +++++++++++++++++--
 4 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/include/linux/frame.h b/include/linux/frame.h
index 02d3ca2d9598..303cda600e56 100644
--- a/include/linux/frame.h
+++ b/include/linux/frame.h
@@ -15,9 +15,20 @@
 	static void __used __section(.discard.func_stack_frame_non_standard) \
 		*__func_stack_frame_non_standard_##func = func
 
+/*
+ * This macro indicates that the following intra-function call is valid.
+ * Any non-annotated intra-function call will cause objtool to issue a warning.
+ */
+#define ANNOTATE_INTRA_FUNCTION_CALL				\
+	999:							\
+	.pushsection .discard.intra_function_calls;		\
+	.long 999b;						\
+	.popsection;
+
 #else /* !CONFIG_STACK_VALIDATION */
 
 #define STACK_FRAME_NON_STANDARD(func)
+#define ANNOTATE_INTRA_FUNCTION_CALL
 
 #endif /* CONFIG_STACK_VALIDATION */
 
diff --git a/tools/objtool/Documentation/stack-validation.txt b/tools/objtool/Documentation/stack-validation.txt
index de094670050b..ee26bb382b70 100644
--- a/tools/objtool/Documentation/stack-validation.txt
+++ b/tools/objtool/Documentation/stack-validation.txt
@@ -290,6 +290,14 @@ they mean, and suggestions for how to fix them.
       https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70646
 
 
+11. file.o: warning: unannotated intra-function call
+
+   This warning means that a direct call is done to a destination which
+   is not at the beginning of a function. If this is a legit call, you
+   can remove this warning by putting the ANNOTATE_INTRA_FUNCTION_CALL
+   directive right before the call.
+
+
 If the error doesn't seem to make sense, it could be a bug in objtool.
 Feel free to ask the objtool maintainer for help.
 
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index a62e032863a8..c3ff62c085c8 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -437,6 +437,12 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 
 	case 0xe8:
 		*type = INSN_CALL;
+		/*
+		 * For the impact on the stack, a CALL behaves like
+		 * a PUSH of an immediate value (the return address).
+		 */
+			op->src.type = OP_SRC_CONST;
+			op->dest.type = OP_DEST_PUSH;
 		break;
 
 	case 0xfc:
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 71a24fd46dbd..0fa414869f45 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -645,6 +645,7 @@ static int add_jump_destinations(struct objtool_file *file)
 	return 0;
 }
 
+
 /*
  * Find the destination instructions for all calls.
  */
@@ -666,10 +667,7 @@ static int add_call_destinations(struct objtool_file *file)
 								dest_off);
 
 			if (!insn->call_dest && !insn->ignore) {
-				WARN_FUNC("unsupported intra-function call",
-					  insn->sec, insn->offset);
-				if (retpoline)
-					WARN("If this is a retpoline, please patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE.");
+				WARN_FUNC("unannotated intra-function call", insn->sec, insn->offset);
 				return -1;
 			}
 
@@ -1291,6 +1289,58 @@ static int read_retpoline_hints(struct objtool_file *file)
 	return 0;
 }
 
+
+static int read_intra_function_calls(struct objtool_file *file)
+{
+	struct instruction *insn;
+	struct section *sec;
+	struct rela *rela;
+
+	sec = find_section_by_name(file->elf, ".rela.discard.intra_function_calls");
+	if (!sec)
+		return 0;
+
+	list_for_each_entry(rela, &sec->rela_list, list) {
+		unsigned long dest_off;
+
+		if (rela->sym->type != STT_SECTION) {
+			WARN("unexpected relocation symbol type in %s",
+			     sec->name);
+			return -1;
+		}
+
+		insn = find_insn(file, rela->sym->sec, rela->addend);
+		if (!insn) {
+			WARN("bad .discard.intra_function_call entry");
+			return -1;
+		}
+
+		if (insn->type != INSN_CALL) {
+			WARN_FUNC("intra_function_call not a direct call",
+				  insn->sec, insn->offset);
+			return -1;
+		}
+
+		/*
+		 * Treat intra-function CALLs as JMPs, but with a stack_op.
+		 * See add_call_destinations(), which strips stack_ops from
+		 * normal CALLs.
+		 */
+		insn->type = INSN_JUMP_UNCONDITIONAL;
+
+		dest_off = insn->offset + insn->len + insn->immediate;
+		insn->jump_dest = find_insn(file, insn->sec, dest_off);
+		if (!insn->jump_dest) {
+			WARN_FUNC("can't find call dest at %s+0x%lx",
+				  insn->sec, insn->offset,
+				  insn->sec->name, dest_off);
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
 static void mark_rodata(struct objtool_file *file)
 {
 	struct section *sec;
@@ -1346,6 +1396,10 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	ret = read_intra_function_calls(file);
+	if (ret)
+		return ret;
+
 	ret = add_call_destinations(file);
 	if (ret)
 		return ret;
-- 
2.39.2 (Apple Git-143)


