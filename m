Return-Path: <stable+bounces-195232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D71EAC72CF7
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 09:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6776D4E9A87
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 08:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB2B3128BC;
	Thu, 20 Nov 2025 08:20:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE13315D4C;
	Thu, 20 Nov 2025 08:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763626856; cv=none; b=alAHeocS1ynlD4yjI1L/MAQzjmRsYWCqpZqPDIKPiG2zrwqrBmN5GAXTKeqRAi01+YhNws5T3RZ+4B5rjoaa3iUiWPdAMMj3xriRIAeEMTOAgrrwn98W7A1ylQrZGP+552gK/9OQBSoJEaEFGos8BBOLFmCtu2TASPxuqEaXnL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763626856; c=relaxed/simple;
	bh=fnO6DKEEZr5MPOrmMKA1aR0Bp4NHSEEoNCWasbAywKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WpFKeuqEY8XnFLja6Lzw05Y8hQ0ejmpyy7PFUa6WhaDdC7oUztYp+XN4iL9ZAEqX950r5hbNrCrb9odWhDk01oQNRY2XMZVK89EIc48UvR4EVHcru61kW+AfX3o1aj4+wKMW7qKh394hWpbD43p/cy+dGPtfWPzYhPn7TfYBjl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC66EC116C6;
	Thu, 20 Nov 2025 08:20:53 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH] LoongArch: Don't panic if no valid cache info for PCI
Date: Thu, 20 Nov 2025 16:20:39 +0800
Message-ID: <20251120082039.2293136-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If there is no valid cache info detected (may happen in virtual machine)
for pci_dfl_cache_line_size, kernel shouldn't panic. Because in the PCI
core it will be evaluated to (L1_CACHE_BYTES >> 2).

Cc: <stable@vger.kernel.org>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/pci/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/pci/pci.c b/arch/loongarch/pci/pci.c
index 5bc9627a6cf9..d9fc5d520b37 100644
--- a/arch/loongarch/pci/pci.c
+++ b/arch/loongarch/pci/pci.c
@@ -50,11 +50,11 @@ static int __init pcibios_init(void)
 	 */
 	lsize = cpu_last_level_cache_line_size();
 
-	BUG_ON(!lsize);
+	if (lsize) {
+		pci_dfl_cache_line_size = lsize >> 2;
 
-	pci_dfl_cache_line_size = lsize >> 2;
-
-	pr_debug("PCI: pci_cache_line_size set to %d bytes\n", lsize);
+		pr_debug("PCI: pci_cache_line_size set to %d bytes\n", lsize);
+	}
 
 	return 0;
 }
-- 
2.47.3


