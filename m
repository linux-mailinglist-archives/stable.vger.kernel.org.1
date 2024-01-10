Return-Path: <stable+bounces-9843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAC68255AD
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 15:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51AC21F24575
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 14:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D73F2D7B0;
	Fri,  5 Jan 2024 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s3vCVBEX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3E828FA;
	Fri,  5 Jan 2024 14:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6F5C433C7;
	Fri,  5 Jan 2024 14:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704465684;
	bh=vXq1LrPa9tY65IsqP6MFV5XQlZOCb92a8Y1tqPxDKqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s3vCVBEXZJUZxHhtJRkM3DSBRUOymgdvyLlni3DuEual5wxxumhcJ+2jJJNidhx+R
	 +ialqDSyIXm6GNGRT8PocO7YLTmxlDWS5ah7O+/kqMa9+X/DcSVRTfOmcI8aa1POkA
	 0mj/V97bbjBxjVS8pcm9sAKXUClmzQbtXpQw5WHE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiko Carstens <hca@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 08/41] s390/vx: fix save/restore of fpu kernel context
Date: Fri,  5 Jan 2024 15:38:48 +0100
Message-ID: <20240105143814.300921792@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105143813.957669139@linuxfoundation.org>
References: <20240105143813.957669139@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit e6b2dab41888332bf83f592131e7ea07756770a4 ]

The KERNEL_FPR mask only contains a flag for the first eight vector
registers. However floating point registers overlay parts of the first
sixteen vector registers.

This could lead to vector register corruption if a kernel fpu context uses
any of the vector registers 8 to 15 and is interrupted or calls a
KERNEL_FPR context. If that context uses also vector registers 8 to 15,
their contents will be corrupted on return.

Luckily this is currently not a real bug, since the kernel has only one
KERNEL_FPR user with s390_adjust_jiffies() and it is only using floating
point registers 0 to 2.

Fix this by using the correct bits for KERNEL_FPR.

Fixes: 7f79695cc1b6 ("s390/fpu: improve kernel_fpu_[begin|end]")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/fpu/api.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/fpu/api.h b/arch/s390/include/asm/fpu/api.h
index 34a7ae68485c6..be16a6c0f1276 100644
--- a/arch/s390/include/asm/fpu/api.h
+++ b/arch/s390/include/asm/fpu/api.h
@@ -76,7 +76,7 @@ static inline int test_fp_ctl(u32 fpc)
 #define KERNEL_VXR_HIGH		(KERNEL_VXR_V16V23|KERNEL_VXR_V24V31)
 
 #define KERNEL_VXR		(KERNEL_VXR_LOW|KERNEL_VXR_HIGH)
-#define KERNEL_FPR		(KERNEL_FPC|KERNEL_VXR_V0V7)
+#define KERNEL_FPR		(KERNEL_FPC|KERNEL_VXR_LOW)
 
 struct kernel_fpu;
 
-- 
2.43.0




