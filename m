Return-Path: <stable+bounces-204888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 811FFCF536E
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 19:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46B06304357C
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 18:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11916338594;
	Mon,  5 Jan 2026 18:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvaA+LOB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69B9303CB0
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767637143; cv=none; b=i30EAsRPxoH4hqYtlGRM95/BHoiwwI7qs/XShbb8SDcBMY2ntuYB0H8QkMGoi8gQS2YWhagx/1i6t9zzRAa8O07KRO1o8h9abK+jnM1md93w7+nD8r4EBo0eW0ypmKYn7K/TfJ+/HSlum+oWEn8q1xMpudMxMPrUG/LtFNHVTB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767637143; c=relaxed/simple;
	bh=MSuIA19HOzhzqaqXHUG3XbdQVfIKvnX8zde7DxytebY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7db8D28I51IWAozfAH4oRQtynzfXdtaGWPqqX2EpaRoyu2YElgUuttQQPK9+U9sCxwHoOScm92p74bjjodPXb5trJutyL/2KK4yic1nx9uFsVb+00tNQfumNVJdXMfqF/B9ojFVOA/J7Iqo2GsW/HCWK/No8+ZOFx9uDYUM6BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvaA+LOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FF9C116D0;
	Mon,  5 Jan 2026 18:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767637143;
	bh=MSuIA19HOzhzqaqXHUG3XbdQVfIKvnX8zde7DxytebY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mvaA+LOBHbt9kYcPfvLzIAUQhYEbeJJhK/tE6syYeJyxytfNpi/3EgJ4DIQw9HMI3
	 u3Ezp442ixNafrlpX/OuHM5lPhVVqJhThKvVXUj2UGnVzhcPZf5aulu8echeNJFqn1
	 fXx9zsRnX6dj2nRqLLbZLTCEES0dUlwdLmZwZFJsKOHi9J9D+lgiPVlyrF4RLEzv4q
	 Bs3d5iFimUZr+at+VtWMAlPb33lfkEue4XFkIjkYg0tYw5f+tEfVW6IkigrtEbTaYo
	 HVxjRAus0UQNBWGPlq30YBqw37xKOmsRlFp3txSkhGcwYHgixA9qbo30GA9Xw7YmiS
	 glxFpExu1NsUQ==
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
Subject: [PATCH 6.1.y 3/3] powerpc/pseries/cmm: adjust BALLOON_MIGRATE when migrating pages
Date: Mon,  5 Jan 2026 13:18:49 -0500
Message-ID: <20260105181849.2717306-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105181849.2717306-1-sashal@kernel.org>
References: <2026010547-partly-speller-54fa@gregkh>
 <20260105181849.2717306-1-sashal@kernel.org>
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


