Return-Path: <stable+bounces-141624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFCEAAB7A3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34EE3A451B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB8B39E072;
	Tue,  6 May 2025 00:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hxoa+szh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6902F400D;
	Mon,  5 May 2025 23:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486918; cv=none; b=kvLTedX8QkBH6fCJzCSje3JOOKI1CNSFT1EtOMKT20jfbLkgSEjj+n2FFZe022o18l3hCrEYtwbzJVThc2MAZ4HP7PVydXkPoSvH/LvBkD3UNLoybBzpTsPZrcnXLSb7Z2DR9KIj0dzlIHGIab3fA893kHUP7zRZ1RDbVLTEwpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486918; c=relaxed/simple;
	bh=XLMmjYNZfvEVGWVc35sSzaNlQVzUVSow72mCRxS8E7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mDprgeTZXLh0m9GDvll5u+j1241sFlNMjTDc036W1GIiunUc3F0/ZHLsE4S6orKX0j/JOW2kBNzhNPFtMXYa8Ixl9rKus/BXGhMGOtf7pBpBMda46kFFO4XYPZ8MH2gvaNSs9Wtx2LVnfuoeACT1aHdxsuRiarBchYW1zp3tCvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hxoa+szh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62187C4CEE4;
	Mon,  5 May 2025 23:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486917;
	bh=XLMmjYNZfvEVGWVc35sSzaNlQVzUVSow72mCRxS8E7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hxoa+szhKo3UlHNecGTIVTUAfh6DQJ3BgDpvBDISTSefNLdu2uifqloLxXvPRqUii
	 aHGBFYAU/4VXrOYw6r9m+M2tKJOfmOISmQmVOTg0XpGHn6t4wsHV7l6SeG1vr1ubU2
	 hkB8beuaG3lI+TRoGKHa1dl+mUqfTmUYNozSeZBE3rHYcPAG0LeH+OIarySYsPm0/I
	 Y6vJNq7B5dQf012vOF5qzdY525S+qqQR938AzSgzIPHTcCVlcyC7Cr/ugTZgIsgr6h
	 B5Xx7EW/9edNQ0eVIl2iRfav4SPOl/NSpdWr15L193zrRpD7r8eJ+scRdQxdJVrZRg
	 aQdxo1Do8BPFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Rob Herring <robh@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	mpe@ellerman.id.au,
	sourabhjain@linux.ibm.com,
	mahesh@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.15 057/153] powerpc/prom_init: Fixup missing #size-cells on PowerBook6,7
Date: Mon,  5 May 2025 19:11:44 -0400
Message-Id: <20250505231320.2695319-57-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index 302c2acc8dcbf..491de25e38a86 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2978,11 +2978,11 @@ static void __init fixup_device_tree_pmac(void)
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


