Return-Path: <stable+bounces-112337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 385B7A28C33
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1F11682DF
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 13:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB2514A09A;
	Wed,  5 Feb 2025 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tgk7heQd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CC4142E86;
	Wed,  5 Feb 2025 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763180; cv=none; b=qSPfFK/RIiP1O7Kj3L86tXBtAVEcWPbwEJedStPxUk0pVUELhA5cfvRh1wXGIgV8LgPk3Q333syHpS2BcmsSGcXIUKcWjUC3Ha+4DnVfWWgW1MpyuLfyXO3Xy1Yp+tyMG1F2N2TH2TKEWsXzMg93Vtc6rAQIuhy3bV/AM5FYzsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763180; c=relaxed/simple;
	bh=QPD990p5tgRI7WA/q6Zd+2UFZuyKLhsPomI2lou+GQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s3cE9w+ePCrDutKJIxyQH5IVZ6RCyHkPYdpPh/wOKsuNEpMFW7WTgL5lIdfvH1ntRGNIkIXusp2I0op4MigMY8TD7XGt+wfoWx5W5abQcE/xyvLUz2KTi2Dyh1U0JjxtzqzZn0o8xk8Dxum3hYha7OkZDnFuIk3LcVvNWJzErNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tgk7heQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE61DC4CEE2;
	Wed,  5 Feb 2025 13:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738763180;
	bh=QPD990p5tgRI7WA/q6Zd+2UFZuyKLhsPomI2lou+GQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tgk7heQdk+AG03AuTOwxPBiZRpy8bzetUcKgSzTphS7mW9uO9/kLNup9J4cnSmnnU
	 zmwHBMUkBzZWFCrN0+/6GBD/6X2sjYoOdtEOMhPB6apbFBIdqpOJad+R8fscIGipjZ
	 9Wh8Yluk5cg3LFEVi8Kd8AOloANXFRJEwog5Je4U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 002/623] powerpc/book3s64/hugetlb: Fix disabling hugetlb when fadump is active
Date: Wed,  5 Feb 2025 14:35:44 +0100
Message-ID: <20250205134456.323184137@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sourabh Jain <sourabhjain@linux.ibm.com>

[ Upstream commit d629d7a8efc33d05d62f4805c0ffb44727e3d99f ]

Commit 8597538712eb ("powerpc/fadump: Do not use hugepages when fadump
is active") disabled hugetlb support when fadump is active by returning
early from hugetlbpage_init():arch/powerpc/mm/hugetlbpage.c and not
populating hpage_shift/HPAGE_SHIFT.

Later, commit 2354ad252b66 ("powerpc/mm: Update default hugetlb size
early") moved the allocation of hpage_shift/HPAGE_SHIFT to early boot,
which inadvertently re-enabled hugetlb support when fadump is active.

Fix this by implementing hugepages_supported() on powerpc. This ensures
that disabling hugetlb for the fadump kernel is independent of
hpage_shift/HPAGE_SHIFT.

Fixes: 2354ad252b66 ("powerpc/mm: Update default hugetlb size early")
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20241217074640.1064510-1-sourabhjain@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/hugetlb.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 18a3028ac3b6d..dad2e7980f245 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -15,6 +15,15 @@
 
 extern bool hugetlb_disabled;
 
+static inline bool hugepages_supported(void)
+{
+	if (hugetlb_disabled)
+		return false;
+
+	return HPAGE_SHIFT != 0;
+}
+#define hugepages_supported hugepages_supported
+
 void __init hugetlbpage_init_defaultsize(void);
 
 int slice_is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
-- 
2.39.5




