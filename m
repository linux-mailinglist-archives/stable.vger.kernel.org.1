Return-Path: <stable+bounces-44147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D24AF8C5174
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CFBE1F21F6F
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC46139583;
	Tue, 14 May 2024 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UNb3iU+c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA7957880;
	Tue, 14 May 2024 11:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684540; cv=none; b=DOeTHvOcbl0nLt1p2SB54aoiKZ/X5tfZC9YIvs0Euk/oP0MWz2s1AHQBsWRuX8FR2YhVM0mAq1M2sBoMRMXA27jzNsZp8tqiFO2Q2uyyZ0ZMJELwCOJICkYZ6V08zlROqlWMxvYJHkrA9N5atGA3KnYOqrJPYrQp+kVGpBG94OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684540; c=relaxed/simple;
	bh=SPZsBY6f+gGz2yhiZiglIEhbwZkfED9XkszQzQCZnqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXdpZNMyXwEsfxjVT8+SWHahO+dCs0DBEI0lnbAJ1n7YWdHCRyGXuWavJzlTfdoVRe4+PqNYmcOodiraFaK81pJyV+TWh0mJ23btvXUVe2dvUVv8QO6b5BK+yueaZ3DTsnEK8ZgySkMclcaBjnwso0uXVyHnLMom402Jx8PAmxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UNb3iU+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D86C2BD10;
	Tue, 14 May 2024 11:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715684539;
	bh=SPZsBY6f+gGz2yhiZiglIEhbwZkfED9XkszQzQCZnqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UNb3iU+cJblfRIqqcQsMjIWIV2YyhqvcX7ArsrBJ914Aqbs/m6mfhdbRw3OdcoPVo
	 qaB5G1m83OIbVu9lDBl1qMd6F9RPo8rZo7dEoEp7BkC5GcCtFrNr2HMqd9QM+R7PaN
	 bnZwyo7mnvNyRCEiCtP1n+CP8vSAsnGwX+IQkm20=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jens Remus <jremus@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 053/301] s390/vdso: Add CFI for RA register to asm macro vdso_func
Date: Tue, 14 May 2024 12:15:24 +0200
Message-ID: <20240514101034.246209038@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101032.219857983@linuxfoundation.org>
References: <20240514101032.219857983@linuxfoundation.org>
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
index 57f62596e53b9..85247ef5a41b8 100644
--- a/arch/s390/kernel/vdso64/vdso_user_wrapper.S
+++ b/arch/s390/kernel/vdso64/vdso_user_wrapper.S
@@ -24,8 +24,10 @@ __kernel_\func:
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




