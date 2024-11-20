Return-Path: <stable+bounces-94403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B069D3D1D
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88EE4284DC9
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810D61C7603;
	Wed, 20 Nov 2024 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4iiSxnJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5E11BAEFC;
	Wed, 20 Nov 2024 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111614; cv=none; b=Q2Kkn0sXw9pXts8jRWpCjIgOKL5r620X6pAF/gyP+5zaoL3rlUJmR24RMO3drqtg64URtTIeW9cfDY+m7yi/AE74X3f4UzZK+kv2bjSH32D+IlVdJz2L9QBXy253bOF8IFvhkmwS6Ti3seYW1w+peah9J52Poy2F54InRPxQSPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111614; c=relaxed/simple;
	bh=uuxKz9LRtwvQ4JVrYt5z5avtxAXuzIKbNIj3+zRSltA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEPuoN1dJVc0Bn47PLAlllClhTLx9Vd0JBC66R5hmT4qeYnX8cJO3RCvfS1kc2mAWXOZbp3JgHFodH7EuqhDZYxAneyxO6sYOnZZoWe11Y+5MLkZNfZoJZ6ldWM81H+IFTlp433lGPyHVRNorfe0uo9Cqhij/rbkHumYmtzvKVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4iiSxnJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A454BC4CECD;
	Wed, 20 Nov 2024 14:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732111614;
	bh=uuxKz9LRtwvQ4JVrYt5z5avtxAXuzIKbNIj3+zRSltA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S4iiSxnJRLz9JeVGxHxjJMU+fESYoKNM+aaqwEP5qKg1qtErKF8cSKthtHTUrb1ak
	 mfN21CMZ9A1Rft8TwAp2D+R+zsjmMwL9audXUeKVWnx80k1uCei7HcZLjSmQJR2LE5
	 pC4enGXsAIher+EW/dhvOuI+s3xkpQPuiA9uMYnajZTeUllGawiIgwwGjzU9MHpVfe
	 3mmJRiyigbLRgyi9Wg+Rdd2qnCdLyYcZMwnbMRiQ87LcVqBI5BfHwbRFhPWhtiP/0k
	 8ZND6xQo6LHOkli1eHLKMs+2a2t1pElwB6YKBGuRdbrLvPy9d9dnLLjBFRPp/UUyox
	 aIQPUT7pNsJ/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yuli Wang <wangyuli@uniontech.com>,
	Wentao Guan <guanwentao@uniontech.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	arnd@arndb.de,
	tglx@linutronix.de,
	geert@linux-m68k.org,
	vincenzo.frascino@arm.com,
	max.kellermann@ionos.com,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 2/6] LoongArch: Define a default value for VM_DATA_DEFAULT_FLAGS
Date: Wed, 20 Nov 2024 09:06:32 -0500
Message-ID: <20241120140647.1768984-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120140647.1768984-1-sashal@kernel.org>
References: <20241120140647.1768984-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.62
Content-Transfer-Encoding: 8bit

From: Yuli Wang <wangyuli@uniontech.com>

[ Upstream commit c859900a841b0a6cd9a73d16426465e44cdde29c ]

This is a trivial cleanup, commit c62da0c35d58518d ("mm/vma: define a
default value for VM_DATA_DEFAULT_FLAGS") has unified default values of
VM_DATA_DEFAULT_FLAGS across different platforms.

Apply the same consistency to LoongArch.

Suggested-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Yuli Wang <wangyuli@uniontech.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/include/asm/page.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/loongarch/include/asm/page.h b/arch/loongarch/include/asm/page.h
index 63f137ce82a41..f49c2782c5c4d 100644
--- a/arch/loongarch/include/asm/page.h
+++ b/arch/loongarch/include/asm/page.h
@@ -94,10 +94,7 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 extern int __virt_addr_valid(volatile void *kaddr);
 #define virt_addr_valid(kaddr)	__virt_addr_valid((volatile void *)(kaddr))
 
-#define VM_DATA_DEFAULT_FLAGS \
-	(VM_READ | VM_WRITE | \
-	 ((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0) | \
-	 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+#define VM_DATA_DEFAULT_FLAGS	VM_DATA_FLAGS_TSK_EXEC
 
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
-- 
2.43.0


