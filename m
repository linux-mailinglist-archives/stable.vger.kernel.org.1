Return-Path: <stable+bounces-50486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 974A99069AD
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17BC91F21AB5
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 10:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8989A1411D3;
	Thu, 13 Jun 2024 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PlH/lJ7q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A95013E3E4
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718273402; cv=none; b=vB56aGnKMVn/pbQ0SHU/U7P5Bho67F/wdL0ljSUeFnyupZbdav0la0oTN1TFXYJdFIJ/jauL0vaCj+A9X2/3nHZAguPazttPpHeB56j9qOLLfZo0pvbz7t0iLX459cXCV3+qQHHTmYUiC/vW12gFN4GT5YmVmAji35MyS1OViJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718273402; c=relaxed/simple;
	bh=BpcCAhFd6U53opCvspvMLAoq2J9xRhwSQi7+w+hdcoY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=M2p2HsTlTxIcXuGe8MgF7T7MP4eF73JF/JkzbPSeQtE70Hjc8pkYls9BV73UMlsds39shSizmbGJyXMs2MLNoJdJkQS3t+hFutvdP0CTRxRqhJKItOb8mlDSqQSVq+r5gyw3ePKWOPsRtYgxYL0XArz+J+LgJcSQ1u6KRw3X6to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PlH/lJ7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7118BC2BBFC;
	Thu, 13 Jun 2024 10:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718273401;
	bh=BpcCAhFd6U53opCvspvMLAoq2J9xRhwSQi7+w+hdcoY=;
	h=Subject:To:Cc:From:Date:From;
	b=PlH/lJ7quNJLM8xYpnXMNbgT6SgVrfCnH0kv/aj2t6meEbW6sAmLT9qtlLHM+ZKxD
	 NnapRazXB42L76dykNPv+KW750g0pjs9FrEs1grEOvibrDBggzlwwOfrlAptCtTDVD
	 9tTRI1HXqeHWW2FZcwbfbaIs2NizLibQp+PcWC8k=
Subject: FAILED: patch "[PATCH] s390/cpacf: Split and rework cpacf query functions" failed to apply to 5.10-stable tree
To: freude@linux.ibm.com,dengler@linux.ibm.com,hca@linux.ibm.com,jchrist@linux.ibm.com,nsg@linux.ibm.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 12:09:58 +0200
Message-ID: <2024061358-scanning-hacksaw-0540@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 830999bd7e72f4128b9dfa37090d9fa8120ce323
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061358-scanning-hacksaw-0540@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

830999bd7e72 ("s390/cpacf: Split and rework cpacf query functions")
b84d0c417a5a ("s390/cpacf: get rid of register asm")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 830999bd7e72f4128b9dfa37090d9fa8120ce323 Mon Sep 17 00:00:00 2001
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Fri, 3 May 2024 11:31:42 +0200
Subject: [PATCH] s390/cpacf: Split and rework cpacf query functions

Rework the cpacf query functions to use the correct RRE
or RRF instruction formats and set register fields within
instructions correctly.

Fixes: 1afd43e0fbba ("s390/crypto: allow to query all known cpacf functions")
Reported-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Suggested-by: Juergen Christ <jchrist@linux.ibm.com>
Suggested-by: Holger Dengler <dengler@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Juergen Christ <jchrist@linux.ibm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
index b378e2b57ad8..153dc4fcc40a 100644
--- a/arch/s390/include/asm/cpacf.h
+++ b/arch/s390/include/asm/cpacf.h
@@ -166,28 +166,79 @@
 
 typedef struct { unsigned char bytes[16]; } cpacf_mask_t;
 
-/**
- * cpacf_query() - check if a specific CPACF function is available
- * @opcode: the opcode of the crypto instruction
- * @func: the function code to test for
- *
- * Executes the query function for the given crypto instruction @opcode
- * and checks if @func is available
- *
- * Returns 1 if @func is available for @opcode, 0 otherwise
- */
-static __always_inline void __cpacf_query(unsigned int opcode, cpacf_mask_t *mask)
+static __always_inline void __cpacf_query_rre(u32 opc, u8 r1, u8 r2,
+					      cpacf_mask_t *mask)
 {
 	asm volatile(
-		"	lghi	0,0\n" /* query function */
-		"	lgr	1,%[mask]\n"
-		"	spm	0\n" /* pckmo doesn't change the cc */
-		/* Parameter regs are ignored, but must be nonzero and unique */
-		"0:	.insn	rrf,%[opc] << 16,2,4,6,0\n"
-		"	brc	1,0b\n"	/* handle partial completion */
-		: "=m" (*mask)
-		: [mask] "d" ((unsigned long)mask), [opc] "i" (opcode)
-		: "cc", "0", "1");
+		"	la	%%r1,%[mask]\n"
+		"	xgr	%%r0,%%r0\n"
+		"	.insn	rre,%[opc] << 16,%[r1],%[r2]\n"
+		: [mask] "=R" (*mask)
+		: [opc] "i" (opc),
+		  [r1] "i" (r1), [r2] "i" (r2)
+		: "cc", "r0", "r1");
+}
+
+static __always_inline void __cpacf_query_rrf(u32 opc,
+					      u8 r1, u8 r2, u8 r3, u8 m4,
+					      cpacf_mask_t *mask)
+{
+	asm volatile(
+		"	la	%%r1,%[mask]\n"
+		"	xgr	%%r0,%%r0\n"
+		"	.insn	rrf,%[opc] << 16,%[r1],%[r2],%[r3],%[m4]\n"
+		: [mask] "=R" (*mask)
+		: [opc] "i" (opc), [r1] "i" (r1), [r2] "i" (r2),
+		  [r3] "i" (r3), [m4] "i" (m4)
+		: "cc", "r0", "r1");
+}
+
+static __always_inline void __cpacf_query(unsigned int opcode,
+					  cpacf_mask_t *mask)
+{
+	switch (opcode) {
+	case CPACF_KDSA:
+		__cpacf_query_rre(CPACF_KDSA, 0, 2, mask);
+		break;
+	case CPACF_KIMD:
+		__cpacf_query_rre(CPACF_KIMD, 0, 2, mask);
+		break;
+	case CPACF_KLMD:
+		__cpacf_query_rre(CPACF_KLMD, 0, 2, mask);
+		break;
+	case CPACF_KM:
+		__cpacf_query_rre(CPACF_KM, 2, 4, mask);
+		break;
+	case CPACF_KMA:
+		__cpacf_query_rrf(CPACF_KMA, 2, 4, 6, 0, mask);
+		break;
+	case CPACF_KMAC:
+		__cpacf_query_rre(CPACF_KMAC, 0, 2, mask);
+		break;
+	case CPACF_KMC:
+		__cpacf_query_rre(CPACF_KMC, 2, 4, mask);
+		break;
+	case CPACF_KMCTR:
+		__cpacf_query_rrf(CPACF_KMCTR, 2, 4, 6, 0, mask);
+		break;
+	case CPACF_KMF:
+		__cpacf_query_rre(CPACF_KMF, 2, 4, mask);
+		break;
+	case CPACF_KMO:
+		__cpacf_query_rre(CPACF_KMO, 2, 4, mask);
+		break;
+	case CPACF_PCC:
+		__cpacf_query_rre(CPACF_PCC, 0, 0, mask);
+		break;
+	case CPACF_PCKMO:
+		__cpacf_query_rre(CPACF_PCKMO, 0, 0, mask);
+		break;
+	case CPACF_PRNO:
+		__cpacf_query_rre(CPACF_PRNO, 2, 4, mask);
+		break;
+	default:
+		BUG();
+	}
 }
 
 static __always_inline int __cpacf_check_opcode(unsigned int opcode)
@@ -215,6 +266,16 @@ static __always_inline int __cpacf_check_opcode(unsigned int opcode)
 	}
 }
 
+/**
+ * cpacf_query() - check if a specific CPACF function is available
+ * @opcode: the opcode of the crypto instruction
+ * @func: the function code to test for
+ *
+ * Executes the query function for the given crypto instruction @opcode
+ * and checks if @func is available
+ *
+ * Returns 1 if @func is available for @opcode, 0 otherwise
+ */
 static __always_inline int cpacf_query(unsigned int opcode, cpacf_mask_t *mask)
 {
 	if (__cpacf_check_opcode(opcode)) {


