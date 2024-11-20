Return-Path: <stable+bounces-94395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7DF9D3D0C
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2DDC1F2415A
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA32E1BC067;
	Wed, 20 Nov 2024 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t14aAPgu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B901AC438;
	Wed, 20 Nov 2024 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111572; cv=none; b=eSSy817pipPewO1YU3QmnYlx+SfD9od4B/gby8jgmzHgBKl5AOzxTPHT/6nZEPRjxdpEbkgLkWZbINhPgiFakEDQlNv4rqhs64xPvA2UrQyLYSKnqlZFv5x0ZYLOQOGW64DwQA2d9FWL760y03zgSAUz4ze9Q4nabRBDXqOafPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111572; c=relaxed/simple;
	bh=lIAlocuKqS1NJ3w6AEa/UsMB8AexBQJ9zTN26akowPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2N0BprcZJ9GGE4pZDPIlOfAMNxrpJLvt2jNssLQ3iphlgP8DoI2m7061j5PRXnWB/Y5ox+CRkFocTlfSIH7pCc5pj2uuHJVJ1pBg/zdTmdwULUtvHEGrp00OZIWKygragfyIVRv1rpyru1bRdB8XWzHhSGxvKNnsf+qvJtiEiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t14aAPgu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169CBC4CED1;
	Wed, 20 Nov 2024 14:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732111572;
	bh=lIAlocuKqS1NJ3w6AEa/UsMB8AexBQJ9zTN26akowPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t14aAPguzIoWZ6PnnqhwezYX3NJkZjP1PdqMtk7CtC/iQHY6Z5LKYgvYWfjgh5K51
	 hkKs/C3avpyRrMUfZjbSvJ8N08T+rIo3iKwZBOlhQp8VFUQ/y3WkC32e+Q36TYlcaU
	 33Z0uhyuHPMz4pyWtNA5YON5IE+DUznvNISa+oGvYmPCNGdIrFqdhLGdBRF8DW16Da
	 V+qakYXwVC3oEOXH1dfp2LBCrB8BB78Pxad2lPckmsuytrwH0TiG4L+ps0iPEPyCjV
	 UPCiUsl5nZn3B6Yl6vzat6u/mmbpdgL9XtkCzmfITRPnIAeB6+88Ca4YHzT2hZKbPo
	 GgSz5SoTkwZ8w==
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
	max.kellermann@ionos.com,
	vincenzo.frascino@arm.com,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 04/10] LoongArch: Define a default value for VM_DATA_DEFAULT_FLAGS
Date: Wed, 20 Nov 2024 09:05:29 -0500
Message-ID: <20241120140556.1768511-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120140556.1768511-1-sashal@kernel.org>
References: <20241120140556.1768511-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.9
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
index e85df33f11c77..8f21567a3188b 100644
--- a/arch/loongarch/include/asm/page.h
+++ b/arch/loongarch/include/asm/page.h
@@ -113,10 +113,7 @@ struct page *tlb_virt_to_page(unsigned long kaddr);
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


