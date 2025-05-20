Return-Path: <stable+bounces-145477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00D6ABDBEA
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A7237B6816
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165FD246792;
	Tue, 20 May 2025 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="in74PdUM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB68246775;
	Tue, 20 May 2025 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750291; cv=none; b=gltCsDwP/vM4Pw+mqLC4M3BkVH/IbIxszL5NIA6mn93m/GXVz/ZPS7oFdVJpaq0zVaHpwAFbewSZzFu0398/VXEqHpgyCR6kGn2mXUbKqA8kC5I/9d4BnT3NCXWID1sN89LisReIP7HIR4rO8rkGPkzYyZRljItFnxSRUffxwFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750291; c=relaxed/simple;
	bh=xPFyoB7DaY4uy8rIWf51WgjZMZC8ZsFIb1LyNzaVv0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRanLlySw0CuRC1Kt9m2o+n+rDdPYOhjTFKWmUApVDVF5XAgN0yGDFn39jrd9UEWJ/7pH9O2uNYenfzbNAop8wQB2Cgx6588CDku5crB7zduoumM+KCbyDr7ZladfJyUpmDYqfq61HllXy5QmgI3Lw/WyQtsGlyiu+WWFs0yBBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=in74PdUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE2EC4CEE9;
	Tue, 20 May 2025 14:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747750291;
	bh=xPFyoB7DaY4uy8rIWf51WgjZMZC8ZsFIb1LyNzaVv0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=in74PdUMxJEkVoWbNY7WtYbgCT8JrbF+iwrgfAeD6VAaZH0uEDsBEp42j7KQT/DhG
	 DTRBUPRtaEymJfccUwOxkHBr7jDwXT5bgnGH0SCLpULhQ2gvfiya/V0/qECydpT9rB
	 4aMfbX3BABslvO1YY5b7EW0pr/44yAkGEbx9qT8g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.12 074/143] LoongArch: Move __arch_cpu_idle() to .cpuidle.text section
Date: Tue, 20 May 2025 15:50:29 +0200
Message-ID: <20250520125812.979641581@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125810.036375422@linuxfoundation.org>
References: <20250520125810.036375422@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhuacai@loongson.cn>

commit 3e245b7b74c3a2ead5fa4bad27cc275284c75189 upstream.

Now arch_cpu_idle() is annotated with __cpuidle which means it is in
the .cpuidle.text section, but __arch_cpu_idle() isn't. Thus, fix the
missing .cpuidle.text section assignment for __arch_cpu_idle() in order
to correct backtracing with nmi_backtrace().

The principle is similar to the commit 97c8580e85cf81c ("MIPS: Annotate
cpu_wait implementations with __cpuidle")

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/kernel/genex.S |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/arch/loongarch/kernel/genex.S
+++ b/arch/loongarch/kernel/genex.S
@@ -16,6 +16,7 @@
 #include <asm/stackframe.h>
 #include <asm/thread_info.h>
 
+	.section .cpuidle.text, "ax"
 	.align	5
 SYM_FUNC_START(__arch_cpu_idle)
 	/* start of idle interrupt region */
@@ -31,14 +32,16 @@ SYM_FUNC_START(__arch_cpu_idle)
 	 */
 	idle	0
 	/* end of idle interrupt region */
-1:	jr	ra
+idle_exit:
+	jr	ra
 SYM_FUNC_END(__arch_cpu_idle)
+	.previous
 
 SYM_CODE_START(handle_vint)
 	UNWIND_HINT_UNDEFINED
 	BACKUP_T0T1
 	SAVE_ALL
-	la_abs	t1, 1b
+	la_abs	t1, idle_exit
 	LONG_L	t0, sp, PT_ERA
 	/* 3 instructions idle interrupt region */
 	ori	t0, t0, 0b1100



