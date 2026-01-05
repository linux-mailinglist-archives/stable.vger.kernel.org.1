Return-Path: <stable+bounces-204878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB6DCF5109
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 18:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F89330C6114
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 17:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A41320A30;
	Mon,  5 Jan 2026 17:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgMvN5tK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F27A2FC00C
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 17:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767634938; cv=none; b=HLtzBop3x3/eRlWSWfUZ21XDzFgQPqxl4ElwQKA9Jz0tg0g4MRLxpCEAFInt2dWIEFECeWJ67UmVLFnz16VuY3LgzW9eLa6+gWKy+w5hjeL7gJXPO/UM/Uyjow0LuIAbqJ5PvafqYVqEVbwPVQoTVE0eNyhPAuLUBHGKQ1CqQNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767634938; c=relaxed/simple;
	bh=MSuIA19HOzhzqaqXHUG3XbdQVfIKvnX8zde7DxytebY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDiMDp4IIqMj01gjj4F8DQc0RQ18xAr3CoEUR9irWZVsZ93HAH0K8QHeec9JCQYJEo1KCNaUKKQIZqPiYQr8NIXKSCyiaRCZm4fI3hNwWvRp3M3QkHoZf07+1VtFbX1/HwxZKk+H2HDYYrAXTNgIplPSfzBuaP0Pzsq1DXLNZzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgMvN5tK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C66C116D0;
	Mon,  5 Jan 2026 17:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767634938;
	bh=MSuIA19HOzhzqaqXHUG3XbdQVfIKvnX8zde7DxytebY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TgMvN5tKnRR6LvPRRB00EFyWLGLkEZnnJbfT5Xz8g/4qJCZSgFOOuzsM4a6SlSZ6d
	 A7YBbNW8Um5Zo3jj/f7IbyUWuFz3ke5y7iysn2GF2OM6KzpL+HqRWbVhUfISt5upB8
	 CTcQdKa5lfTBhgsaP70lqzLhFuKcAXVVnQgbdeCEiRJ+wsru4cvJr1HK8aAt+xdB6F
	 lUv9uO5jT1ES4vzzQb0WGPFJMWVL5W3iMYk5/emKmWWc1KJrPjLPCyERTyGaeeWQCI
	 YEAn5hMMY1M7rUsthf2sSKn5dHU47Tf8s/TAhCI+ZJq4VAkRsjXGYlpa/77WZxDc3P
	 TdLBe0q84ViDg==
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
Subject: [PATCH 6.12.y 3/3] powerpc/pseries/cmm: adjust BALLOON_MIGRATE when migrating pages
Date: Mon,  5 Jan 2026 12:42:05 -0500
Message-ID: <20260105174205.2697666-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105174205.2697666-1-sashal@kernel.org>
References: <2026010546-overcrowd-jarring-93b0@gregkh>
 <20260105174205.2697666-1-sashal@kernel.org>
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


