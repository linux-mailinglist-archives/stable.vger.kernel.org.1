Return-Path: <stable+bounces-141724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0F5AAB7E5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07381C26513
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158574ACAF3;
	Tue,  6 May 2025 00:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPyjhz5L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00303BB69D;
	Mon,  5 May 2025 23:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487357; cv=none; b=SgBXRjlfDW1D1vlfh0SaQ5gD2flDBJ1xxhAyDHkdGu28peeStTsNIK616mOjH5qp1D/Q3SugCdQ5lWZCSc9snf2BtSM6eo4S4qDsAwY5nV7U6lbIn/fW4aaklP4qxtDdRRqyvdIHG3A2kRg1XYLtjJ1jJjo+3jzgzXkVrCSfkEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487357; c=relaxed/simple;
	bh=AaBh9Dd/5cYObI/jzmDqfnzOcjCINMIsA+x8OSBG37I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QgoQt+Xpreg6UcQT6qMyat7j2iu0rui8jgiaLK9Ndzgr5AWcGSas525mGkbhM+Ec4hrLgxJlBV3+kC7blbB9ThI7dClF+xCtdMf2uyoquZn+6ClNAyn1szCMg3lzS3RoUQ09ZOQzm3kV74WoSPSxN7NIarEz5Y6XDQmzrcYTzCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPyjhz5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB43C4CEE4;
	Mon,  5 May 2025 23:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487357;
	bh=AaBh9Dd/5cYObI/jzmDqfnzOcjCINMIsA+x8OSBG37I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WPyjhz5LdJb2rL7dgo1xxd37bUb3ZBvVd7nR4KWUhZeai4OQ+W/Z/T/+KCZG5KqsS
	 25gV6GKDmC3j1VmH/ufL3Zo6A6+sQS9oyXiNq0z4bPNc7PKB8Wfu88W/lb+9vhodnx
	 hSW2HawfbwMPiMDtI122fWUlH67ODSly2BtUdwQoy8Hy4gLLVjXNCh3dHpLW+RLL6P
	 HlpJOyFw5EVRZgYaXob4TI8BFg1xjduDQFZBuTEfMJLxU+57Fl10NjzFWBlVX7asEQ
	 9pUe9b+rZuFsGV/JuQRfD66a3PXRDWE7w6x9Nm0V8oBOeDwWnTTBCt6a4L8XDSncy2
	 hTlmPCJ2qNPFg==
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
Subject: [PATCH AUTOSEL 5.4 27/79] powerpc/prom_init: Fixup missing #size-cells on PowerBook6,7
Date: Mon,  5 May 2025 19:20:59 -0400
Message-Id: <20250505232151.2698893-27-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
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
index b7ef63614417d..e0abb13b5806a 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2906,11 +2906,11 @@ static void __init fixup_device_tree_pmac(void)
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


