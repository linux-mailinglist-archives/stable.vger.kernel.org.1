Return-Path: <stable+bounces-51823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 065D89071CC
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F508284617
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900C914374B;
	Thu, 13 Jun 2024 12:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xEVvlCiW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496C7142E9C;
	Thu, 13 Jun 2024 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282419; cv=none; b=CxP4VwkM9c8oi+pK/CDuEsjNTTMSkCl5PpLYIH/i818U8/MRa43EUkwYE6lTRLiRQy2kwE50eUKmZ+vD7YTktGeaNo4zRBRr+IEuI/DO+oPJ8y4jMOUNupi89LbWPy6iA9MtSFkcLrhFdPth87tk6CWNYnlDTCXKgpBWm3EWy54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282419; c=relaxed/simple;
	bh=8C3/8rGWMeB+/FoGs1mLVuHmEIaFsWObkau2258H+Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkMiRhSZL3nAhjD7gRRiFW8CU2ARzb6L3ITM6M2rEJ3RMtI4dTZZvmtixHUl5V5yntlvmOhQLfzs3ZmEfcJqTG7g/qaMtN1Ok3un/DbeAWhuwLA2JtzYszO/cj30v7BaJDAeW8LpQ18VbFWGAPZcoAw7RJovuLcfF0FK3izU3bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xEVvlCiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77508C32786;
	Thu, 13 Jun 2024 12:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282418;
	bh=8C3/8rGWMeB+/FoGs1mLVuHmEIaFsWObkau2258H+Uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xEVvlCiWhVT1emWb3+tZW7n+t74jsVr+cTPyAl8QkKT4UsO3/VmFqBhzAUKNzkOj8
	 Mhflmaqii6yjduXUQPeZPHWR+V1UdAeTdABMQF8n4Xd+GUqjkHiG8Z7WLEIaK77bkV
	 ECCIrlhzkUNCW/MXN1TB5M2QjfinSMutXG15fRLs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 270/402] um: Fix the -Wmissing-prototypes warning for __switch_mm
Date: Thu, 13 Jun 2024 13:33:47 +0200
Message-ID: <20240613113312.684651790@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tiwei Bie <tiwei.btw@antgroup.com>

[ Upstream commit 2cbade17b18c0f0fd9963f26c9fc9b057eb1cb3a ]

The __switch_mm function is defined in the user code, and is called
by the kernel code. It should be declared in a shared header.

Fixes: 4dc706c2f292 ("um: take um_mmu.h to asm/mmu.h, clean asm/mmu_context.h a bit")
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/include/asm/mmu.h           | 2 --
 arch/um/include/shared/skas/mm_id.h | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
index 5b072aba5b658..a7cb380c0b5c0 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -15,8 +15,6 @@ typedef struct mm_context {
 	struct page *stub_pages[2];
 } mm_context_t;
 
-extern void __switch_mm(struct mm_id * mm_idp);
-
 /* Avoid tangled inclusion with asm/ldt.h */
 extern long init_new_ldt(struct mm_context *to_mm, struct mm_context *from_mm);
 extern void free_ldt(struct mm_context *mm);
diff --git a/arch/um/include/shared/skas/mm_id.h b/arch/um/include/shared/skas/mm_id.h
index e82e203f5f419..92dbf727e3842 100644
--- a/arch/um/include/shared/skas/mm_id.h
+++ b/arch/um/include/shared/skas/mm_id.h
@@ -15,4 +15,6 @@ struct mm_id {
 	int kill;
 };
 
+void __switch_mm(struct mm_id *mm_idp);
+
 #endif
-- 
2.43.0




