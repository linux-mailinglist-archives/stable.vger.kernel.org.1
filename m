Return-Path: <stable+bounces-140703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2B1AAAEC5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB841A86FF9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6329F2ECFEA;
	Mon,  5 May 2025 23:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJh8rE+k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41CD377651;
	Mon,  5 May 2025 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486006; cv=none; b=dPepPGFjcuGTXFvRB+mnpEN8nJJ1rjOlrAErFXdc4T9n7f1RWMZZLkHbuwaPBGQT1NCGN9VnkHDFKtwCUkvxLYj+wEp8THS9fFE23kEFBnzJ0B1eyleJTQiAoddMGJpXHPg3gTOtx2mgdk37sECbxavu25IzLv8zAi+xD17FL1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486006; c=relaxed/simple;
	bh=ZwZ3YGeWzp0VrR/6gg4OpFWFODZyzKKrozm/7+HYum8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t4rAHnagmyZhpJY7r35TbQfk2ZwPxN6G4a6VjqCV0Xguz7YlcnQfC/fL8K0lIYL7SN7XCbonqbPUGvEcnxeNEqWGtnSGVvlLwglJie5Lr4BQS0AYHPfxrdaCPPByGmAUHsIQYl+YxkeCQfO3jgI2wkBb08/LJivZKisP+b8udEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJh8rE+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72458C4CEE4;
	Mon,  5 May 2025 23:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486006;
	bh=ZwZ3YGeWzp0VrR/6gg4OpFWFODZyzKKrozm/7+HYum8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VJh8rE+k0zo4MMu0KnlOmaA/Ix/zrL+vVcAAp6wSWoHckp0EwqiYY7YedGMNCYVpc
	 gHuSIX9o2sP8YKuJyLLHxEWdwtS5EldZsNCDMlCgTaGuZVtWtwDOqBHJT3QjOPTdyD
	 W12oSgT/ugyzIl8eZ7oWB0vOpDp8/SLbQz/yWZ/zhy1pUgiZx0E8EnTT1+GIRbsUFu
	 E5gZ//cYpNflsPMZwjLi8Z+8/aM81OXVeZqeKYWWAKmNyOZMcUbZ2UdsiPwWOeTT1e
	 QBDLsGnzs3ch+R162tQaFmt5icM87Gal7xpPykc3VfaRBZjG3kRufkjhjBbAMd23QO
	 hpMwsf/hV595g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Rob Herring <robh@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	mpe@ellerman.id.au,
	mahesh@linux.ibm.com,
	sourabhjain@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.6 106/294] powerpc/prom_init: Fixup missing #size-cells on PowerBook6,7
Date: Mon,  5 May 2025 18:53:26 -0400
Message-Id: <20250505225634.2688578-106-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Andreas Schwab <schwab@linux-m68k.org>

[ Upstream commit 7e67ef889c9ab7246547db73d524459f47403a77 ]

Similar to the PowerMac3,1, the PowerBook6,7 is missing the #size-cells
property on the i2s node.

Depends-on: commit 045b14ca5c36 ("of: WARN on deprecated #address-cells/#size-cells handling")
Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
[maddy: added "commit" work in depends-on to avoid checkpatch error]
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/875xmizl6a.fsf@igel.home
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/prom_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index a6090896f7497..ac669e58e2023 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2974,11 +2974,11 @@ static void __init fixup_device_tree_pmac(void)
 	char type[8];
 	phandle node;
 
-	// Some pmacs are missing #size-cells on escc nodes
+	// Some pmacs are missing #size-cells on escc or i2s nodes
 	for (node = 0; prom_next_node(&node); ) {
 		type[0] = '\0';
 		prom_getprop(node, "device_type", type, sizeof(type));
-		if (prom_strcmp(type, "escc"))
+		if (prom_strcmp(type, "escc") && prom_strcmp(type, "i2s"))
 			continue;
 
 		if (prom_getproplen(node, "#size-cells") != PROM_ERROR)
-- 
2.39.5


