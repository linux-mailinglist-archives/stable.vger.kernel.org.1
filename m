Return-Path: <stable+bounces-204904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3CACF568A
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 20:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8ECC30640F5
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 19:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADE4331A7E;
	Mon,  5 Jan 2026 19:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVDpZFg+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1AE3242B8
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 19:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767642071; cv=none; b=NDOlzwT2wOZR3z1r8V54wPN5fanj/p02iYr/h+7YS+gv3xSep3vGdnvbI93u5hR4AiItgebZRge5JzSlQToQnnWFV09RwyAouxU+6FXbOuuveQzatnGArcuSeb8/oYdaPFHuFZMuIB+svAJGMyXMFZBEKgLeAmL0VT33R3PLwUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767642071; c=relaxed/simple;
	bh=ie+dGc43XsYVBI4wrf9ySpnP7Q+07+MvKEmg1B7prqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSREuo81raft2yM8eu7zt1uijKab1nnmK014iEOJOXyMEpWVjMnpoDHepOaGg4zlC1u9+tOoVQIzcCUqKxv3G4NWD2t9YZnUvlhPGoI0ckdVR2bB5lvkdrG6wpuGFJ8zwM2DZAA/Y68KG4l4SXzHqctdU0xFFL+sgvNGVMmMfy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVDpZFg+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FF6C19422;
	Mon,  5 Jan 2026 19:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767642071;
	bh=ie+dGc43XsYVBI4wrf9ySpnP7Q+07+MvKEmg1B7prqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CVDpZFg+aAq6YsdgPbLrIoomdLQbHgSJAP1E8le183RS6Fl3pC7H1RGmHedMyyd8a
	 oPol0PUH35rQ5gD6w3DU0BHqA6dgXPaM23/aY/dR3Pwtel2TLkLy80U8GLVzmMmE6/
	 Ownmxzw9poBCD/RsCqcn0NWsp0be9ugiOHFa1JVIo0f0hPyaz1zKo7YWmr5g4DYL6G
	 JhO4pe0oORGhWc4qqj/fBcRbntAhJoXVQqPoyPxFMy66gsTFncrYKuYDNhJSy0zsih
	 DY6nYHIzd6w5vxwCspvS2/ktOFh+eNVafiVA4IHAJ4RT1PEQMR9+d6eCU9hEdDC+Zr
	 7iLpF9gYNNa8A==
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
Subject: [PATCH 5.10.y 4/4] powerpc/pseries/cmm: adjust BALLOON_MIGRATE when migrating pages
Date: Mon,  5 Jan 2026 14:40:57 -0500
Message-ID: <20260105194057.2747929-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105194057.2747929-1-sashal@kernel.org>
References: <2026010548-hacked-transfer-1f00@gregkh>
 <20260105194057.2747929-1-sashal@kernel.org>
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
index 0507d3874c45..de93f31768d3 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -550,6 +550,7 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
 
 	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
 	balloon_page_insert(b_dev_info, newpage);
+	__count_vm_event(BALLOON_MIGRATE);
 	b_dev_info->isolated_pages--;
 	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
 
-- 
2.51.0


