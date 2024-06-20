Return-Path: <stable+bounces-54683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C2090FB64
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 04:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C357A1C20D62
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 02:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DC8171A1;
	Thu, 20 Jun 2024 02:49:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A77E57E;
	Thu, 20 Jun 2024 02:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.124.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718851753; cv=none; b=VqKN6ss/9TFTPMGR8BaFImHY9TX7E+/pAeR7MSs7kfUkKnqlzray/iB9qJ5vN/wuSYIALVFljURpBFWUk+byL2jfhjYj7DRPTB6iQEaiLeOsHFG4oYhTeUVBCGNyrc3Nv+DcxkiChe/b4rMYmuhrLFweO21udPsSl23wzbRF/2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718851753; c=relaxed/simple;
	bh=Y/rDw2bzCXwt+Sd6tTdo6KTXR1kTgawHQy3Q4jGSmAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pSlzxCOrJ4dYga5gkNb2QUlNqdtWRqKDllA1OyW9/UXgAKGxrcLQJkn0BxWc6QygtEMg2SF4rXy94yhc3j16q6Io6WCBin/F2IdnFJ2JFwodoQd7UE42HmnM1sDxNlWnkA7OaBx31fa/ivmqMaucE6WYCkdFDsg7cBrWpTXuxNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.124.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp89t1718851638tsf77eb2
X-QQ-Originating-IP: Cnxcf0yE6w+MsvywbXobZi1OIKdeiMnOlWen8+fPLAs=
Received: from HX01040082.powercore.com.cn ( [14.19.141.254])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 20 Jun 2024 10:47:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16810093544147674005
From: Jinglin Wen <jinglin.wen@shingroup.cn>
To: mpe@ellerman.id.au
Cc: npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	naveen.n.rao@linux.ibm.com,
	masahiroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Jinglin Wen <jinglin.wen@shingroup.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] powerpc: Fix unnecessary copy to 0 when kernel is booted at address 0.
Date: Thu, 20 Jun 2024 10:41:50 +0800
Message-Id: <20240620024150.14857-1-jinglin.wen@shingroup.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240617023509.5674-1-jinglin.wen@shingroup.cn>
References: <20240617023509.5674-1-jinglin.wen@shingroup.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-2

According to the code logic, when the kernel is loaded to address 0,
no copying operation should be performed, but it is currently being
done.

This patch fixes the issue where the kernel code was incorrectly
duplicated to address 0 when booting from address 0.

Fixes: b270bebd34e3 ("powerpc/64s: Run at the kernel virtual address earlier in boot")
Signed-off-by: Jinglin Wen <jinglin.wen@shingroup.cn>
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: <stable@vger.kernel.org>
---

v2:
  - According to 87le336c6k.fsf@mail.lhotse, improve this patch.
v1:
  - 20240617023509.5674-1-jinglin.wen@shingroup.cn

 arch/powerpc/kernel/head_64.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 4690c219bfa4..63432a33ec49 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -647,8 +647,9 @@ __after_prom_start:
  * Note: This process overwrites the OF exception vectors.
  */
 	LOAD_REG_IMMEDIATE(r3, PAGE_OFFSET)
-	mr.	r4,r26			/* In some cases the loader may  */
-	beq	9f			/* have already put us at zero */
+	mr	r4,r26			/* Load the virtual source address into r4 */
+	cmpld	r3,r4			/* Check if source == dest */
+	beq	9f			/* If so skip the copy  */
 	li	r6,0x100		/* Start offset, the first 0x100 */
 					/* bytes were copied earlier.	 */
 
-- 
2.25.1


