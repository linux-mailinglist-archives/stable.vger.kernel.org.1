Return-Path: <stable+bounces-209004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01789D26949
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 18:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2259D3256BFA
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 17:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D417D29B200;
	Thu, 15 Jan 2026 17:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PXmQ34tq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9820286334;
	Thu, 15 Jan 2026 17:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497461; cv=none; b=SCkAwfc04YJUlTFgk9cxVYzUI8RoR0rkePceWe6uhpBH9xPWxIjhWWD8H8MIomlh2s8RdJslAhrP2sbEiCNt3J+TaxAl/ft4CgskZRoF0OD5DVAmrSw/girfpADUib0vcMMEfK1E07VmjIwjv0Pl9N+qB9vA/9ddcxcKKLfOu78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497461; c=relaxed/simple;
	bh=W4SSRqFbF+r+F9bpe2wTmZsCwSifaudKjOh7ewIb6jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTR/FT2Ezw1A1T6nJANLyc36HPfs0+MTSuQ3yi98bBn1IBdFeRUK+fO5DDxqEvRhnaYVUBx9Zr0pmLnYiKfFfp0YF7ppni/AqsqrUpp5+W8HAV04IvW/v6MG3lF4vAq0GrBOhyg3t2sSX3L6yFQQHonfnynzLp3cDsOlQuMlhmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PXmQ34tq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60B1C116D0;
	Thu, 15 Jan 2026 17:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768497461;
	bh=W4SSRqFbF+r+F9bpe2wTmZsCwSifaudKjOh7ewIb6jQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PXmQ34tqj7MQ/S2J2r/cE5KkC+Ph0sSRmdBRci4+0WJOG749hA5eS4TOChGtNNo5g
	 okKHPIkSjeR5uqrMX8udG/EtGcUmT99PFipkl+QynKPz6Ray3No0RxBsTfGWTqyAeR
	 /cLDi856k+rwYceSdUCB5uhqb5v2aZdNh9YEVkJo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 089/554] powerpc/32: Fix unpaired stwcx. on interrupt exit
Date: Thu, 15 Jan 2026 17:42:35 +0100
Message-ID: <20260115164249.468565163@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115164246.225995385@linuxfoundation.org>
References: <20260115164246.225995385@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit 10e1c77c3636d815db802ceef588522c2d2d947c ]

Commit b96bae3ae2cb ("powerpc/32: Replace ASM exception exit by C
exception exit from ppc64") erroneouly copied to powerpc/32 the logic
from powerpc/64 based on feature CPU_FTR_STCX_CHECKS_ADDRESS which is
always 0 on powerpc/32.

Re-instate the logic implemented by commit b64f87c16f3c ("[POWERPC]
Avoid unpaired stwcx. on some processors") which is based on
CPU_FTR_NEED_PAIRED_STWCX feature.

Fixes: b96bae3ae2cb ("powerpc/32: Replace ASM exception exit by C exception exit from ppc64")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/6040b5dbcf5cdaa1cd919fcf0790f12974ea6e5a.1757666244.git.christophe.leroy@csgroup.eu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/entry_32.S | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 3eb3c74e402b5..c23b2b0046970 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -314,10 +314,9 @@ interrupt_return:
 	mtspr	SPRN_SRR1,r12
 
 BEGIN_FTR_SECTION
+	lwarx   r0,0,r1
+END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	stwcx.	r0,0,r1		/* to clear the reservation */
-FTR_SECTION_ELSE
-	lwarx	r0,0,r1
-ALT_FTR_SECTION_END_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 
 	lwz	r3,_CCR(r1)
 	lwz	r4,_LINK(r1)
@@ -360,10 +359,9 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 	mtspr	SPRN_SRR1,r12
 
 BEGIN_FTR_SECTION
+	lwarx   r0,0,r1
+END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	stwcx.	r0,0,r1		/* to clear the reservation */
-FTR_SECTION_ELSE
-	lwarx	r0,0,r1
-ALT_FTR_SECTION_END_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 
 	lwz	r3,_LINK(r1)
 	lwz	r4,_CTR(r1)
-- 
2.51.0




