Return-Path: <stable+bounces-87931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6061F9ACD69
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF86281D82
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157BB218D86;
	Wed, 23 Oct 2024 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRlle1mV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6661218D80;
	Wed, 23 Oct 2024 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694010; cv=none; b=fg4A/a6Ef/Sw8Djh/Q6+zcKlXCsDqiIirZTBGvZnlCxvecVaP2Gx5qsOO5sowDm/blocC119Y0FlDPt81SakDnnx6ab2n+AfTFofKTOT6l/V/eJQxP8ZwN6LDrW9vW87pYFmlovClf6LEgCYFVo15mD3fo+nT8sGCtjcBZkqSEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694010; c=relaxed/simple;
	bh=7g3Y5eVvBZRCGFtMoOhwes8/UM/FRtXZAYY+ax+pSHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJCbGpjFfbNSNu9lMHbn/IEiQ2ZWjRqJfkHugRvtnMd+Mp1LCBJuNxdHzY/UWr7+6RxsgI8ojlqzp+zPyc3J1idb9BhzsyLZ6V0CrGTOJ14lhSJJEiLpWchcbGxoQVdCiC94nBHZwxDsZ1Cg5RmZOVHNc2wGezMRZVSFgcq0UHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRlle1mV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0559C4CEC6;
	Wed, 23 Oct 2024 14:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729694010;
	bh=7g3Y5eVvBZRCGFtMoOhwes8/UM/FRtXZAYY+ax+pSHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LRlle1mVUBB2eVlk+IR8QQMG2ng0sfg9g0mYVe8KXcMREVrzuhqDBK16OLJQobwOG
	 Ix6bBbVy3IykboEJDscoHUAQhmpgZI/mP+/ooluqRRReWZh11KerGnfFv0A/uEYZgg
	 2pTcEAFSD/L+IzFvWJTNo/OfLszDYXtvdQMgZnuaZk6DizSDpQ+oyLSNlcYNCA9Axm
	 h0noORHHG8eqlLVLAYCP/jmCvUATv4nEdZJDPUtNaPKfOIS0FltkjPkamW8RMT5FRi
	 sZYUbuXTjfpwPJDMjHAyxJa04KtZ6ypuXjqAX/UCGlxju64IZISNIEpS9mAt9Z/7B6
	 uYo5MQ3boqK/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	2639161967 <2639161967@qq.com>,
	Sasha Levin <sashal@kernel.org>,
	chentao@kylinos.cn,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 5/5] powerpc/powernv: Free name on error in opal_event_init()
Date: Wed, 23 Oct 2024 10:33:20 -0400
Message-ID: <20241023143321.2982841-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143321.2982841-1-sashal@kernel.org>
References: <20241023143321.2982841-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.322
Content-Transfer-Encoding: 8bit

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit cf8989d20d64ad702a6210c11a0347ebf3852aa7 ]

In opal_event_init() if request_irq() fails name is not freed, leading
to a memory leak. The code only runs at boot time, there's no way for a
user to trigger it, so there's no security impact.

Fix the leak by freeing name in the error path.

Reported-by: 2639161967 <2639161967@qq.com>
Closes: https://lore.kernel.org/linuxppc-dev/87wmjp3wig.fsf@mail.lhotse
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://patch.msgid.link/20240920093520.67997-1-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/powernv/opal-irqchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
index e71f2111c8c0b..676ec9fdd115d 100644
--- a/arch/powerpc/platforms/powernv/opal-irqchip.c
+++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
@@ -289,6 +289,7 @@ int __init opal_event_init(void)
 				 name, NULL);
 		if (rc) {
 			pr_warn("Error %d requesting OPAL irq %d\n", rc, (int)r->start);
+			kfree(name);
 			continue;
 		}
 	}
-- 
2.43.0


