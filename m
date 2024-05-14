Return-Path: <stable+bounces-44839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5536D8C54A2
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95671F2205F
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F266812D773;
	Tue, 14 May 2024 11:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GV1aIIDg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D655FDD2;
	Tue, 14 May 2024 11:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687325; cv=none; b=OUhK2jyEqeEIYrBfSVSWtToZXgkjs2l6FwfLb/VWoovzfn4cq+OUrevjn5La7hNZB95hNGCKwiOU3jjj8I8+jeI0fBXqZHFpbRQyMFE+wBMp/lVWy9BT1MPZywRDH7LU8bO9sTC0kfJrPVAtSXnXnA3mdM3hbA21lfVfXqJA6IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687325; c=relaxed/simple;
	bh=YnMwKSdPV0XsGrYpWnUsM6oEfKImjGjP8RoNpAwQKwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmQVcVnN87TjmwwfajFH2JZhYQPY98+gChzBKFL+XkMCZFv73iomdrvAZl9qPd5dPRPjl7fa+yqI4Us0QCe9ZqhadFTgxgZSvV/9AqKROBY3Pj+egx2X2w1RhA3tpdKUbb7JNeCUS0GtypnGkuMS/SxpNijqVrALX1t/wHYlxGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GV1aIIDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387CAC2BD10;
	Tue, 14 May 2024 11:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687325;
	bh=YnMwKSdPV0XsGrYpWnUsM6oEfKImjGjP8RoNpAwQKwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GV1aIIDgeSGQqLy44bk/0sQyIAgIYJQIUpzyh6uB2cA2eKZKWmJpqJD63zjAyd9pY
	 ir/iiVrv7/5wO9wXmFJc5LWGAOvTU45yMiih7dZduqSQHpBT/s6DXsY28ruQasgakd
	 RULKv1+vORsc7kJ1SYvuAdTWzltpE2qH8UuhisAE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jens Remus <jremus@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 026/111] s390/vdso: Add CFI for RA register to asm macro vdso_func
Date: Tue, 14 May 2024 12:19:24 +0200
Message-ID: <20240514100958.120959007@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514100957.114746054@linuxfoundation.org>
References: <20240514100957.114746054@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Remus <jremus@linux.ibm.com>

[ Upstream commit b961ec10b9f9719987470236feb50c967db5a652 ]

The return-address (RA) register r14 is specified as volatile in the
s390x ELF ABI [1]. Nevertheless proper CFI directives must be provided
for an unwinder to restore the return address, if the RA register
value is changed from its value at function entry, as it is the case.

[1]: s390x ELF ABI, https://github.com/IBM/s390x-abi/releases

Fixes: 4bff8cb54502 ("s390: convert to GENERIC_VDSO")
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/dwarf.h               | 1 +
 arch/s390/kernel/vdso64/vdso_user_wrapper.S | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/s390/include/asm/dwarf.h b/arch/s390/include/asm/dwarf.h
index 4f21ae561e4dd..390906b8e386e 100644
--- a/arch/s390/include/asm/dwarf.h
+++ b/arch/s390/include/asm/dwarf.h
@@ -9,6 +9,7 @@
 #define CFI_DEF_CFA_OFFSET	.cfi_def_cfa_offset
 #define CFI_ADJUST_CFA_OFFSET	.cfi_adjust_cfa_offset
 #define CFI_RESTORE		.cfi_restore
+#define CFI_REL_OFFSET		.cfi_rel_offset
 
 #ifdef CONFIG_AS_CFI_VAL_OFFSET
 #define CFI_VAL_OFFSET		.cfi_val_offset
diff --git a/arch/s390/kernel/vdso64/vdso_user_wrapper.S b/arch/s390/kernel/vdso64/vdso_user_wrapper.S
index a775d7e528728..2183b8f64d574 100644
--- a/arch/s390/kernel/vdso64/vdso_user_wrapper.S
+++ b/arch/s390/kernel/vdso64/vdso_user_wrapper.S
@@ -23,8 +23,10 @@ __kernel_\func:
 	CFI_DEF_CFA_OFFSET (STACK_FRAME_OVERHEAD + WRAPPER_FRAME_SIZE)
 	CFI_VAL_OFFSET 15, -STACK_FRAME_OVERHEAD
 	stg	%r14,STACK_FRAME_OVERHEAD(%r15)
+	CFI_REL_OFFSET 14, STACK_FRAME_OVERHEAD
 	brasl	%r14,__s390_vdso_\func
 	lg	%r14,STACK_FRAME_OVERHEAD(%r15)
+	CFI_RESTORE 14
 	aghi	%r15,WRAPPER_FRAME_SIZE
 	CFI_DEF_CFA_OFFSET STACK_FRAME_OVERHEAD
 	CFI_RESTORE 15
-- 
2.43.0




