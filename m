Return-Path: <stable+bounces-55549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A264D91641E
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34CD1C21A48
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D841814A4E9;
	Tue, 25 Jun 2024 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UtzAGOLN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ED514A4DA;
	Tue, 25 Jun 2024 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309230; cv=none; b=mhIxHTan6tEzgjcYOuPYuN5BbDz7ckNPOiZmu7eWUJ58X+V1r9hbbITxG+qGBc56FjOZCm8HSvReLMpt0eWm893QQTDn2ivrzM1fziaJQz54WYYsIe5yPk1933xFMxn3Wjffrgqoepmdoarl40gxTr88b1/M2i96qbb+h/9jx/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309230; c=relaxed/simple;
	bh=ijNxc/iCrkc2bGYWFhXMuASOc9e1u2Tdp+0ug2RNrzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIonOOfldJ14HE4/rfX47iAwdmtYSwRhbDME1YfjnqybAIPq/Kkf/sJmxvFHf98QdtJ+m9duebfwbcYPHX1Z709vopRn7vSFcCxWryVlJVZcJVs4/vt1myzcjjRi992WN/FEUBNaPd+hOvZSa0t/Wz46hWqxmN9xYwNZHAEdbx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UtzAGOLN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CC7C32781;
	Tue, 25 Jun 2024 09:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719309230;
	bh=ijNxc/iCrkc2bGYWFhXMuASOc9e1u2Tdp+0ug2RNrzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UtzAGOLNE3qJLifglTapvv9kZ8rSe+mA6gf4V9wGAj4w49y1q/FZzHi7RLrEqF97s
	 f9DiWwi4zdS9H6DMy9ooUfOZlighp0UZd6loelWf9I5cA8FGXb9Jl5t4TOTw19rL4H
	 ddMSoYKMpaWfu8B8UsFMaJcn1RCm0n2yxEr5oQrg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hui Li <lihui@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.6 139/192] LoongArch: Fix watchpoint setting error
Date: Tue, 25 Jun 2024 11:33:31 +0200
Message-ID: <20240625085542.495468070@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085537.150087723@linuxfoundation.org>
References: <20240625085537.150087723@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hui Li <lihui@loongson.cn>

commit f63a47b34b140ed1ca39d7e4bd4f1cdc617fc316 upstream.

In the current code, when debugging the following code using gdb,
"invalid argument ..." message will be displayed.

lihui@bogon:~$ cat test.c
  #include <stdio.h>
  int a = 0;
  int main()
  {
	a = 1;
	return 0;
  }
lihui@bogon:~$ gcc -g test.c -o test
lihui@bogon:~$ gdb test
...
(gdb) watch a
Hardware watchpoint 1: a
(gdb) r
...
Invalid argument setting hardware debug registers

There are mainly two types of issues.

1. Some incorrect judgment condition existed in user_watch_state
   argument parsing, causing -EINVAL to be returned.

When setting up a watchpoint, gdb uses the ptrace interface,
ptrace(PTRACE_SETREGSET, tid, NT_LOONGARCH_HW_WATCH, (void *) &iov)).
Register values in user_watch_state as follows:

  addr[0] = 0x0, mask[0] = 0x0, ctrl[0] = 0x0
  addr[1] = 0x0, mask[1] = 0x0, ctrl[1] = 0x0
  addr[2] = 0x0, mask[2] = 0x0, ctrl[2] = 0x0
  addr[3] = 0x0, mask[3] = 0x0, ctrl[3] = 0x0
  addr[4] = 0x0, mask[4] = 0x0, ctrl[4] = 0x0
  addr[5] = 0x0, mask[5] = 0x0, ctrl[5] = 0x0
  addr[6] = 0x0, mask[6] = 0x0, ctrl[6] = 0x0
  addr[7] = 0x12000803c, mask[7] = 0x0, ctrl[7] = 0x610

In arch_bp_generic_fields(), return -EINVAL when ctrl.len is
LOONGARCH_BREAKPOINT_LEN_8(0b00). So delete the incorrect judgment here.

In ptrace_hbp_fill_attr_ctrl(), when note_type is NT_LOONGARCH_HW_WATCH
and ctrl[0] == 0x0, if ((type & HW_BREAKPOINT_RW) != type) will return
-EINVAL. Here ctrl.type should be set based on note_type, and unnecessary
judgments can be removed.

2. The watchpoint argument was not set correctly due to unnecessary
   offset and alignment_mask.

Modify ptrace_hbp_fill_attr_ctrl() and hw_breakpoint_arch_parse(), which
ensure the watchpont argument is set correctly.

All changes according to the LoongArch Reference Manual:
https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#control-and-status-registers-related-to-watchpoints

Cc: stable@vger.kernel.org
Signed-off-by: Hui Li <lihui@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/include/asm/hw_breakpoint.h |    2 -
 arch/loongarch/kernel/hw_breakpoint.c      |   19 ++++-------------
 arch/loongarch/kernel/ptrace.c             |   32 +++++++++++++----------------
 3 files changed, 21 insertions(+), 32 deletions(-)

--- a/arch/loongarch/include/asm/hw_breakpoint.h
+++ b/arch/loongarch/include/asm/hw_breakpoint.h
@@ -101,7 +101,7 @@ struct perf_event;
 struct perf_event_attr;
 
 extern int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
-				  int *gen_len, int *gen_type, int *offset);
+				  int *gen_len, int *gen_type);
 extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
 extern int hw_breakpoint_arch_parse(struct perf_event *bp,
 				    const struct perf_event_attr *attr,
--- a/arch/loongarch/kernel/hw_breakpoint.c
+++ b/arch/loongarch/kernel/hw_breakpoint.c
@@ -283,7 +283,7 @@ int arch_check_bp_in_kernelspace(struct
  * to generic breakpoint descriptions.
  */
 int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
-			   int *gen_len, int *gen_type, int *offset)
+			   int *gen_len, int *gen_type)
 {
 	/* Type */
 	switch (ctrl.type) {
@@ -303,11 +303,6 @@ int arch_bp_generic_fields(struct arch_h
 		return -EINVAL;
 	}
 
-	if (!ctrl.len)
-		return -EINVAL;
-
-	*offset = __ffs(ctrl.len);
-
 	/* Len */
 	switch (ctrl.len) {
 	case LOONGARCH_BREAKPOINT_LEN_1:
@@ -386,21 +381,17 @@ int hw_breakpoint_arch_parse(struct perf
 			     struct arch_hw_breakpoint *hw)
 {
 	int ret;
-	u64 alignment_mask, offset;
+	u64 alignment_mask;
 
 	/* Build the arch_hw_breakpoint. */
 	ret = arch_build_bp_info(bp, attr, hw);
 	if (ret)
 		return ret;
 
-	if (hw->ctrl.type != LOONGARCH_BREAKPOINT_EXECUTE)
-		alignment_mask = 0x7;
-	else
+	if (hw->ctrl.type == LOONGARCH_BREAKPOINT_EXECUTE) {
 		alignment_mask = 0x3;
-	offset = hw->address & alignment_mask;
-
-	hw->address &= ~alignment_mask;
-	hw->ctrl.len <<= offset;
+		hw->address &= ~alignment_mask;
+	}
 
 	return 0;
 }
--- a/arch/loongarch/kernel/ptrace.c
+++ b/arch/loongarch/kernel/ptrace.c
@@ -494,28 +494,14 @@ static int ptrace_hbp_fill_attr_ctrl(uns
 				     struct arch_hw_breakpoint_ctrl ctrl,
 				     struct perf_event_attr *attr)
 {
-	int err, len, type, offset;
+	int err, len, type;
 
-	err = arch_bp_generic_fields(ctrl, &len, &type, &offset);
+	err = arch_bp_generic_fields(ctrl, &len, &type);
 	if (err)
 		return err;
 
-	switch (note_type) {
-	case NT_LOONGARCH_HW_BREAK:
-		if ((type & HW_BREAKPOINT_X) != type)
-			return -EINVAL;
-		break;
-	case NT_LOONGARCH_HW_WATCH:
-		if ((type & HW_BREAKPOINT_RW) != type)
-			return -EINVAL;
-		break;
-	default:
-		return -EINVAL;
-	}
-
 	attr->bp_len	= len;
 	attr->bp_type	= type;
-	attr->bp_addr	+= offset;
 
 	return 0;
 }
@@ -609,7 +595,19 @@ static int ptrace_hbp_set_ctrl(unsigned
 		return PTR_ERR(bp);
 
 	attr = bp->attr;
-	decode_ctrl_reg(uctrl, &ctrl);
+
+	switch (note_type) {
+	case NT_LOONGARCH_HW_BREAK:
+		ctrl.type = LOONGARCH_BREAKPOINT_EXECUTE;
+		ctrl.len = LOONGARCH_BREAKPOINT_LEN_4;
+		break;
+	case NT_LOONGARCH_HW_WATCH:
+		decode_ctrl_reg(uctrl, &ctrl);
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	err = ptrace_hbp_fill_attr_ctrl(note_type, ctrl, &attr);
 	if (err)
 		return err;



