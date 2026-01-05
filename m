Return-Path: <stable+bounces-204882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E65CF51E1
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 18:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6006E314B627
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 17:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271E7339876;
	Mon,  5 Jan 2026 17:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNYgQQIC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1082B304BC6
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767635547; cv=none; b=OP7tNfoP3w10VbdVYvW2BFeI7y17ARWs69s8B6QALiSSQHLRpERBvv9W8gH9P83HzCQomo53l/H5XvZDbAyZwgCv4+LKSdkxGg1+/+rfQnO3pafBCzBdkl8C5rTFrSU9xkzIsNneW1LwXyVd49bUcmxZSquTAzN88xDJIbqo8Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767635547; c=relaxed/simple;
	bh=MSuIA19HOzhzqaqXHUG3XbdQVfIKvnX8zde7DxytebY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/uig4/mCW77toTa0UE5B3cf+eNu3KXns2czZFVQitADLUOq65ROgqZ9oSN7YZS2eMmNsL1jgCbLvWTdWRMwK1TP1BPOCUvvDWzoIuMExN8lpcN/0WbrMsQYHPhkX1MiRK8wkCloQjHNUiUMqlibYEe07LlZeMOdj/w83I7yTf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNYgQQIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29ADBC116D0;
	Mon,  5 Jan 2026 17:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767635545;
	bh=MSuIA19HOzhzqaqXHUG3XbdQVfIKvnX8zde7DxytebY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZNYgQQICKpu3uxo/VDp5mf3QVxEdwfNO9G9n/2uN21KngkZlV0TiqVOnheKU7b3pW
	 ES/ZZuDU0b2SKMBb3ceCI4gI3VQIwyxehSz7JX2DifSuOtsfGYz/2cnrX2ICb2iRmd
	 suo9UYnamMpHbYz9/m5ZViLdMBvBQgmfwuchfQg4RaAxaFQzQeszX9omdIWBTeK2yR
	 N0AdVTv54HfDzzBmNEgWibpBJ/HVV+A7s74Co828/MZrBG5QKgHP/KGIGsLkG+cmLm
	 tk0gaIO38BhPsQVYiRpbEsixOF89WyZr4cVe7wP/K7h8d4VIYkx9ZTUv5rZU0PIHa2
	 KW7eOCuSlwD3w==
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
Subject: [PATCH 6.6.y 3/3] powerpc/pseries/cmm: adjust BALLOON_MIGRATE when migrating pages
Date: Mon,  5 Jan 2026 12:52:12 -0500
Message-ID: <20260105175213.2699504-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105175213.2699504-1-sashal@kernel.org>
References: <2026010547-ninth-clinking-d127@gregkh>
 <20260105175213.2699504-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hildenbrand <david@redhat.com>

[ Upstream commit 0da2ba35c0d532ca0fe7af698b17d74c4d084b9a ]

Let's properly adjust BALLOON_MIGRATE like the other drivers.

Note that the INFLATE/DEFLATE events are triggered from the core when
enqueueing/dequeueing pages.

This was found by code inspection.

Link: https://lkml.kernel.org/r/20251021100606.148294-3-david@redhat.com
Fixes: fe030c9b85e6 ("powerpc/pseries/cmm: Implement balloon compaction")
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/cmm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 5e0a718d1be7..8c1f9721756e 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -532,6 +532,7 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
 
 	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
 	balloon_page_insert(b_dev_info, newpage);
+	__count_vm_event(BALLOON_MIGRATE);
 	b_dev_info->isolated_pages--;
 	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
 
-- 
2.51.0


