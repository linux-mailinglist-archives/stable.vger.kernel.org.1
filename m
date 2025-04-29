Return-Path: <stable+bounces-137985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD804AA163A
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13869A35A8
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C30823F405;
	Tue, 29 Apr 2025 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ua47o9ak"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE981FE468;
	Tue, 29 Apr 2025 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947740; cv=none; b=dkRrX0/UnvDPwmMrjyegEBOZcNGJ1t2jPZ/zqVUEORqTxOrcOQnbEcxEMpIZRe30ZQF15tWWdvi8q1LccyKBjy/JA4Io7WweMy94jkNYzjc5C/bPIjHb4b9RNIEbKnAXVdPP39L/3lIKTjRWiAhbvce/AKp7S3+XM3DFXygr+BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947740; c=relaxed/simple;
	bh=74eP2zJo7aJZ6D1j2HNPPLIxCnJSMuZaSbmqy0Te4/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vr+FjUsK3MbVr4XXr3gw/OzHC7e5cAuzRgZEZritLzDJ1WYeLz9bYU/VxWUWkB9sRxVnAf9rXlPP9XszgMML+mZR3+1b5O4bOk74fNOGUmSPsmmh6BzF2na5tOtNJQOVlyNlmAPTEdXkCIrWkWl+9qEf3shmg0VDdRe9+qKAzr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ua47o9ak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B0FC4CEE9;
	Tue, 29 Apr 2025 17:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745947740;
	bh=74eP2zJo7aJZ6D1j2HNPPLIxCnJSMuZaSbmqy0Te4/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ua47o9akVHP2XKLg1iXFlBwl6VOlOsvw3Fp10ag362V8MTgm2D4d1hfN9qBnUjIU7
	 oXwBa/G2/Dtlz3WAneOS3dQc/kK9K/N3764pYOVL9EfHpvKNSiRDRGlC/+8jbAVyrb
	 aI5tW52T+iSwXyOSkXe+Hh4xqK3+ugO6b9tHy4P8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 090/280] LoongArch: Make regs_irqs_disabled() more clear
Date: Tue, 29 Apr 2025 18:40:31 +0200
Message-ID: <20250429161118.792182096@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>
References: <20250429161115.008747050@linuxfoundation.org>
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

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit bb0511d59db9b3e40c8d51f0d151ccd0fd44071d ]

In the current code, the definition of regs_irqs_disabled() is actually
"!(regs->csr_prmd & CSR_CRMD_IE)" because arch_irqs_disabled_flags() is
defined as "!(flags & CSR_CRMD_IE)", it looks a little strange.

Define regs_irqs_disabled() as !(regs->csr_prmd & CSR_PRMD_PIE) directly
to make it more clear, no functional change.

While at it, the return value of regs_irqs_disabled() is true or false,
so change its type to reflect that and also make it always inline.

Fixes: 803b0fc5c3f2 ("LoongArch: Add process management")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/include/asm/ptrace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
index f3ddaed9ef7f0..a5b63c84f8541 100644
--- a/arch/loongarch/include/asm/ptrace.h
+++ b/arch/loongarch/include/asm/ptrace.h
@@ -33,9 +33,9 @@ struct pt_regs {
 	unsigned long __last[];
 } __aligned(8);
 
-static inline int regs_irqs_disabled(struct pt_regs *regs)
+static __always_inline bool regs_irqs_disabled(struct pt_regs *regs)
 {
-	return arch_irqs_disabled_flags(regs->csr_prmd);
+	return !(regs->csr_prmd & CSR_PRMD_PIE);
 }
 
 static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
-- 
2.39.5




