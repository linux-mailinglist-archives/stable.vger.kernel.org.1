Return-Path: <stable+bounces-140554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3395AAAE0D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF90046326C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE196376459;
	Mon,  5 May 2025 22:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4PaeK/J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E4A35FAEA;
	Mon,  5 May 2025 22:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485138; cv=none; b=llg6XhgLvtY83qs99AK1T2sOu1J9xAOWN2qMOAqhcwBI72kbTu4ork4T+qNiBBm1unCJfxjVvUfCQ7MwsK2Zoc6dEJ4lRJCHYJeO3otHkPf6Bk6bw5jPIqecDmG6kZ8fz08ItJpw7FdBUW/sPJjshdSNPGTTbV0tPyRrf9rTj1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485138; c=relaxed/simple;
	bh=env492LK+vvyLJ2wPesu0+se6FFVuWBfgNvAhXjV/bs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nGgVY2NBFJ7txBqcHwATdsJMoL5keDHqaYdzqf5fNP3HWOfJ7cqMOXyZNx49sni03VmKq2jbGYINICIZ6pE3mkmTLNZdWPawEiR3ucRXidPUrt1XIqxTC/N+Y3e0/bgbcuUYRvCJymjtKteC2Xrg4zm3Gn6CraWyl+lWw4rQf2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4PaeK/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650B1C4CEEE;
	Mon,  5 May 2025 22:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485136;
	bh=env492LK+vvyLJ2wPesu0+se6FFVuWBfgNvAhXjV/bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a4PaeK/JbirVJaFcUsI3EfG5OogzoIz/fo5RbNHIm0ljtVeHexXYo3BaactODoaZB
	 0qcTTAXTZgk/bDRyaGnyspqqqLEqnbZ3CGjlOojNzv4252vlCc1lWm5p34VWuAsX/8
	 oK+Q7eYUsfyEWkVv4bfSSgzDughFdLeLwlv/I5HECzWjDV/kyIwP0QGCySnJD7biRr
	 rpn6pDPUfJYEmP9cIc5r93wiDCKT9CYWmbZB/BBJVFczV1KoJxSMhNjmnjiRiCRtW/
	 qMZTsD2DipiOPZm7zWYsj3MKn3Fd/rn9oFOMxK1PABdZGoPO1Gw/QXJaCjyJFcIxwt
	 DzP3kVN5U5Hnw==
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
Subject: [PATCH AUTOSEL 6.12 178/486] powerpc/prom_init: Fixup missing #size-cells on PowerBook6,7
Date: Mon,  5 May 2025 18:34:14 -0400
Message-Id: <20250505223922.2682012-178-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 935568d68196d..b1dc4cb9f78e6 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2982,11 +2982,11 @@ static void __init fixup_device_tree_pmac(void)
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


