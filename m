Return-Path: <stable+bounces-145108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B800CABDA0E
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E6427B0461
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30384242D8B;
	Tue, 20 May 2025 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ElWyXZtw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8FD241103;
	Tue, 20 May 2025 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749183; cv=none; b=t6lXLXVWO80wtgt7BMfjyA98wciYAAnXBGokAA3ntSmSvY5VXkjsyOUtxAUZFdALRH2i2PmOpJx7E9ZACTNt1GsvyDezDu6BygDi+c0qPcjig3FSHEiRby81ia9WI5CBAZ91vsqc2DuyQBagyNJpTImEylir4CVhVh2zDE78TBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749183; c=relaxed/simple;
	bh=7nhQ3/hl6y0LEFYBpE8EHwPytprFFdf3QAV0llBkcj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0S55sYVv5/O+LhLJ5WxK6D7L6pWbcnqKc0gVRRrlvkKpxTkS+jeqcMw6fgTD3wg/RojVCP5ub1kndNO1pxWHedY0o7hsHdZ80NT2nSco6OUMJ7lDYm1cdvkK3aZkB0AwK/dF2/e6G6oHjLPJv8xFOOY7klE71qQHQP/CS8UpGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ElWyXZtw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E527CC4CEE9;
	Tue, 20 May 2025 13:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747749182;
	bh=7nhQ3/hl6y0LEFYBpE8EHwPytprFFdf3QAV0llBkcj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ElWyXZtwDZQoL2bSUL2isVCnPrgnIzsjnj7ulVZjsqOxaNYm/lIwWJmXFJ4OpEZIA
	 SC2RY+tbKmDEnV08DJrNHF7wDfeI35KLTjyvgjtN7x2EzXI1iIaaba+mAOBvyC6kDE
	 +ap+BLUv9iF1WNAn54qSG09369JF5JyAGm+oU6Bs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH 5.15 21/59] x86/alternative: Optimize returns patching
Date: Tue, 20 May 2025 15:50:12 +0200
Message-ID: <20250520125754.696741072@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125753.836407405@linuxfoundation.org>
References: <20250520125753.836407405@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Borislav Petkov (AMD)" <bp@alien8.de>

commit d2408e043e7296017420aa5929b3bba4d5e61013 upstream.

Instead of decoding each instruction in the return sites range only to
realize that that return site is a jump to the default return thunk
which is needed - X86_FEATURE_RETHUNK is enabled - lift that check
before the loop and get rid of that loop overhead.

Add comments about what gets patched, while at it.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230512120952.7924-1-bp@alien8.de
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/alternative.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -620,13 +620,12 @@ static int patch_return(void *addr, stru
 {
 	int i = 0;
 
+	/* Patch the custom return thunks... */
 	if (cpu_feature_enabled(X86_FEATURE_RETHUNK)) {
-		if (x86_return_thunk == __x86_return_thunk)
-			return -1;
-
 		i = JMP32_INSN_SIZE;
 		__text_gen_insn(bytes, JMP32_INSN_OPCODE, addr, x86_return_thunk, i);
 	} else {
+		/* ... or patch them out if not needed. */
 		bytes[i++] = RET_INSN_OPCODE;
 	}
 
@@ -639,6 +638,14 @@ void __init_or_module noinline apply_ret
 {
 	s32 *s;
 
+	/*
+	 * Do not patch out the default return thunks if those needed are the
+	 * ones generated by the compiler.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_RETHUNK) &&
+	    (x86_return_thunk == __x86_return_thunk))
+		return;
+
 	for (s = start; s < end; s++) {
 		void *dest = NULL, *addr = (void *)s + *s;
 		struct insn insn;



