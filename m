Return-Path: <stable+bounces-27577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508C387A610
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 11:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826B71C21829
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 10:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874443D3A0;
	Wed, 13 Mar 2024 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XxarcjU0"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429F13D0D0
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710326610; cv=none; b=Onh7bXt/NqaXvjmcIHFbEGkHRRAjeUZkDIUyYSKszo3aIUYpGCNDxKNZ/43rsKF9LqeigjSfMa78Il3fFWFKPhP16EmUYNxtFNgGK27N0V8Y0aThPYpRohStLmTwM05/RgjUy8W7TgFUd6K9ZrBcb8JpURuQeih0OYfDdCtsd4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710326610; c=relaxed/simple;
	bh=UUJfQfrGpZIV3PGwcG9GYg/ms9YS0YPedmpI8jUrguY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BgE83MeTNIaEQsFZFvSOQa/JJ6WXI04QffykWthe+sjMS8wF2/QLieQG735PQhOC0a/ZVxP8IC/xauTs0lv5rfWwJVrYrLiF6rj9BXtTfJRwmOcwF50BW12wfOArv9JBucN1nSg6Zv6CioaM8KY8LHmBFS3USDK5h67ha1u6Ik4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=XxarcjU0; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=FEjK08/5ktjbKTHlNfJQG21SOzyESzvYCdfUVXdil0k=; b=XxarcjU0BbRfTqGxAPW6polmp2
	zGc7Cly4I14fxG34sHfdkGym1EaIxzCkejro8DI9V04q2Lp02cRzP7LV6M4DVLwXMqjLKA2q/Qd9S
	2EmC7CWp0Zximjy2Bu4XkMFF9l1ibL7b+8j45hrXK9B1Vq3uTKthVGr1Yz2TJiEk4jJSWooM2rBLH
	wf1Vxf0XLu9nmyI8GezQbJJDSxTLaIPJuE3l0XxOTxl11XcRdGxMr2UUBDPbykfE7b2c39hjVplDu
	rr+aj3loiupJUuq5DmrFKQK38AgnKEN0p9eRBxalY28Y0FZzljCBN9MBT3OzJ+xsTzBgRU79ZPGJM
	wYVQUUDw==;
Received: from 179-125-71-247-dinamico.pombonet.net.br ([179.125.71.247] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rkM4z-009uZG-5r; Wed, 13 Mar 2024 11:43:25 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	kernel-dev@igalia.com
Subject: [PATCH 5.15 2/5] x86/asm: Differentiate between code and function alignment
Date: Wed, 13 Mar 2024 07:42:52 -0300
Message-Id: <20240313104255.1083365-3-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313104255.1083365-1-cascardo@igalia.com>
References: <20240313104255.1083365-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

commit 8eb5d34e77c63fde8af21c691bcf6e3cd87f7829 upstream.

Create SYM_F_ALIGN to differentiate alignment requirements between
SYM_CODE and SYM_FUNC.

This distinction is useful later when adding padding in front of
functions; IOW this allows following the compiler's
patchable-function-entry option.

[peterz: Changelog]

Change-Id: I4f9bc0507e5c3fdb3e0839806989efc305e0a758
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220915111143.824822743@infradead.org
[cascardo: adjust for missing commit c4691712b546 ("x86/linkage: Add ENDBR to SYM_FUNC_START*()")]
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 arch/x86/include/asm/linkage.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index 3d7293d52950..04a333c334ae 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -11,11 +11,15 @@
 #define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))
 #endif /* CONFIG_X86_32 */
 
-#ifdef __ASSEMBLY__
-
 #define __ALIGN		.balign CONFIG_FUNCTION_ALIGNMENT, 0x90;
 #define __ALIGN_STR	__stringify(__ALIGN)
 
+#define ASM_FUNC_ALIGN		__ALIGN_STR
+#define __FUNC_ALIGN		__ALIGN
+#define SYM_F_ALIGN		__FUNC_ALIGN
+
+#ifdef __ASSEMBLY__
+
 #if defined(CONFIG_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
 #define RET	jmp __x86_return_thunk
 #else /* CONFIG_RETPOLINE */
-- 
2.34.1


