Return-Path: <stable+bounces-204908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 888D5CF5744
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 21:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02747309F715
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 20:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD333161BF;
	Mon,  5 Jan 2026 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hG9+7Ms3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADA726E6F4
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 20:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767643283; cv=none; b=EQqK4ZvqziUIqOwQDS/tajDIxuWVVSCIOCn9oJ4PqG9ZJEM+DAnQanAdRm67z9XE1xcMjdzPO0IGu+fwhv622a5Ouo0VSxAZ4jAlkaJvUzUxyt+j/sRj/4wXODQXx1fzy5JE0i4LrN0KLr7n1SULCJQ3DPbSxEprPKghQgQSVt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767643283; c=relaxed/simple;
	bh=IxmhsArbqaLBturxWvmGhswy6L1JUyuk8Y44CanjiBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEAgMGFr4+BMstFBsEZJJyucZ+pntyFnuvCwFj9uejruqNE0gurV2QKKMzimKwMoDUuAiYoRUfQMMqDd8XoB1XqDvbspyXkw9sqfQZpuR/blq/PfNonRXe/pu5L/axUnqUZu3UMtJ2TslNZoqspEJ++ZlXiLGwwlFncNMGBe8vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hG9+7Ms3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D89C116D0;
	Mon,  5 Jan 2026 20:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767643282;
	bh=IxmhsArbqaLBturxWvmGhswy6L1JUyuk8Y44CanjiBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hG9+7Ms3TQZkW/tnWYBMYrIlgLs32tietu+DbwSd/ccTURbM1lhqIWVU2oE8iYvYL
	 +FEMiC6ZU9KTeQVnEiYipV1WpSJ9B+BVSYb7KghdV9h0YcQTLzmufZt/rI+TgMzLgN
	 3r1h6oTF3P/HV/VFbSiJW6cZKF5F6l1brGrp4mFrBCp+sKxhavwmAfjN9EBOlFeRtM
	 EKn/uqoj7ebvXWgftgWhVu/x8w/Pu35rd8zUWVhkvhE9nsz1ZCjaqF+KjVdnYdXLN3
	 bk0rIbUr9HUOi/Tq/BPYm095lAMYYq3uWCL4MeZFI1HOTHelxYGhXKhyPCCjcxbBp5
	 WqCbkwj/1hF+w==
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
Subject: [PATCH 5.15.y] powerpc/pseries/cmm: call balloon_devinfo_init() also without CONFIG_BALLOON_COMPACTION
Date: Mon,  5 Jan 2026 15:01:20 -0500
Message-ID: <20260105200120.2763600-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010559-profane-handsfree-0d22@gregkh>
References: <2026010559-profane-handsfree-0d22@gregkh>
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


