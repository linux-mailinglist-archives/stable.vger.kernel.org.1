Return-Path: <stable+bounces-204909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B58DCF577A
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 21:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DEF0B300BFAF
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 20:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83840311959;
	Mon,  5 Jan 2026 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkpVntHR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4300E2D6624
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767643733; cv=none; b=cdNihrxG6VdiQXNpIZFxy0Z+BOvqE43Yw3sF5SP0Q8pDwDSydAOZZfqJ/8mFXgbZI2cqKgrH/Tl66PoND1qfn4Pa2BMBuDzPDv6csAE6CLPUMxn1lcT8VwqNejGqXi0vxllGmLMxAgVi6WNkGr7hByJXluLS13GPykN41aSAfqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767643733; c=relaxed/simple;
	bh=IxmhsArbqaLBturxWvmGhswy6L1JUyuk8Y44CanjiBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcRMHTxZb6X0YJYkjsfyxuBLJX9m6azuqwujABmQ2S9xPBy+pE9S4XoFbiwk/6qHRBqoxtqBQoa62cm6SKisTPTy/85M73pr9HSn+f9ZeibcMsNacoBhL+YO7738Aw+JVMIW7PjuqsIXHuN6PyxP5R6dmXcWdVKx638Ixf0Yy4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkpVntHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF2AC19422;
	Mon,  5 Jan 2026 20:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767643732;
	bh=IxmhsArbqaLBturxWvmGhswy6L1JUyuk8Y44CanjiBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hkpVntHR3EuHhMjV7Z+e8KgboW1njTLkeVsX1hBgnkJTK/lw3IkMK4oaBD6K9Z9WX
	 6UE19U7xG8F+WQZh2RguhuhJKDPots36tswAicVNn8Fvvx3v8g75DCRzRqg8Ej6oef
	 mMnGiVbRSzPrx2UGO7DymwNPdV9DsW5cB0lg0j6ACXLRTr5ub7OfpkApKiSz5j0G/O
	 fpsGGP+bVljB/NCFSx+Tfyw1W/r8lO0PQCf8+L5GkJLGnGteVs86Pc5kva3xCSldOb
	 GB4EiBMVo32aUPsACgn0kpGQCdUFyKRlc3Czb2lH4y1BTrggGepYhdAp2e6L5U3ZV2
	 ltykFMjNRzEGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] powerpc/pseries/cmm: call balloon_devinfo_init() also without CONFIG_BALLOON_COMPACTION
Date: Mon,  5 Jan 2026 15:08:50 -0500
Message-ID: <20260105200850.2767781-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010500-antirust-bacterium-2d22@gregkh>
References: <2026010500-antirust-bacterium-2d22@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hildenbrand <david@redhat.com>

[ Upstream commit fc6bcf9ac4de76f5e7bcd020b3c0a86faff3f2d5 ]

Patch series "powerpc/pseries/cmm: two smaller fixes".

Two smaller fixes identified while doing a bigger rework.

This patch (of 2):

We always have to initialize the balloon_dev_info, even when compaction is
not configured in: otherwise the containing list and the lock are left
uninitialized.

Likely not many such configs exist in practice, but let's CC stable to
be sure.

This was found by code inspection.

Link: https://lkml.kernel.org/r/20251021100606.148294-1-david@redhat.com
Link: https://lkml.kernel.org/r/20251021100606.148294-2-david@redhat.com
Fixes: fe030c9b85e6 ("powerpc/pseries/cmm: Implement balloon compaction")
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ moved balloon_devinfo_init() call from inside cmm_balloon_compaction_init() to cmm_init() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/cmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 45a3a3022a85..6b38ccd63c90 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -570,7 +570,6 @@ static int cmm_balloon_compaction_init(void)
 {
 	int rc;
 
-	balloon_devinfo_init(&b_dev_info);
 	b_dev_info.migratepage = cmm_migratepage;
 
 	balloon_mnt = kern_mount(&balloon_fs);
@@ -624,6 +623,7 @@ static int cmm_init(void)
 	if (!firmware_has_feature(FW_FEATURE_CMO) && !simulate)
 		return -EOPNOTSUPP;
 
+	balloon_devinfo_init(&b_dev_info);
 	rc = cmm_balloon_compaction_init();
 	if (rc)
 		return rc;
-- 
2.51.0


