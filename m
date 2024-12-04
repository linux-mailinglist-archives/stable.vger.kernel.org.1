Return-Path: <stable+bounces-98656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BC39E498E
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D112E28330C
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E5C20FA87;
	Wed,  4 Dec 2024 23:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyCjNbsL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39B22066EB;
	Wed,  4 Dec 2024 23:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733355039; cv=none; b=K6s4y1JQnXyDcRzKBnz9WO8f+K5urWb8l9hYstLnlJBY7DfSgNNo4Xq+Iw9auIoukvUqamFF6jMwok3PJlmcKRDjjO925hX6o7fGgoU99PUO8irtOWgiiK+dtZaJgo9SYj2LZusmPv0G1N9gnpAhXerCHu77CCMnK5iHh0tPy3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733355039; c=relaxed/simple;
	bh=3LM6BcQii/dod30SKjStMYeiuwsTOy/Qg766ka+ZWYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjWnwFKK2j81z2nuG0SFFEwyNKyzv5UANPabnCraiDaBUrtxuwPWfPPDbu35Q4Se1LAvZipySBRw+LbEbD2HGgJDr3iuAOixFzCYJLOAMZ+93OHvITy9mu8abB93muS5Wsnu//iai5OlwfjaRbZZw5J+e+7mKvLdHMCyVihHZUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyCjNbsL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC9EC4CECD;
	Wed,  4 Dec 2024 23:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733355039;
	bh=3LM6BcQii/dod30SKjStMYeiuwsTOy/Qg766ka+ZWYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fyCjNbsLYk8zCC1wmlk8A34ff8WvUxA9Ehq6t17yCvcZGa6T5XmON4HQfbk3J3MC+
	 s+ft0nWptySx0WjSWjvCJg9bSMMeGKtazWP2b+GfImuu40b2ITpXeN2FsSB6sGExlm
	 eF5XblgV7aEMpD2jYOarVBuFquZW+bYPoAh9Xc/utECmAuAS96XA2M9GN2TVLUocYD
	 2+P9KksNYK7J/IGJW7DvIzjH/S1ZXsw5pcLE3mXnzNC4fyTFKDFa43+V1LbofuSkyM
	 bDMAS+VZwxzZ4hYPkdCbJQdt/VDY7H1O9hFmu3rvPFODVP0RXoEBLbXmWIA1YOdPxX
	 R23kSONMJkfuA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Rob Herring <robh@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	jsavitz@redhat.com,
	aneesh.kumar@kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.1 8/8] powerpc/prom_init: Fixup missing powermac #size-cells
Date: Wed,  4 Dec 2024 17:18:50 -0500
Message-ID: <20241204221859.2248634-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221859.2248634-1-sashal@kernel.org>
References: <20241204221859.2248634-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
Content-Transfer-Encoding: 8bit

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit cf89c9434af122f28a3552e6f9cc5158c33ce50a ]

On some powermacs `escc` nodes are missing `#size-cells` properties,
which is deprecated and now triggers a warning at boot since commit
045b14ca5c36 ("of: WARN on deprecated #address-cells/#size-cells
handling").

For example:

  Missing '#size-cells' in /pci@f2000000/mac-io@c/escc@13000
  WARNING: CPU: 0 PID: 0 at drivers/of/base.c:133 of_bus_n_size_cells+0x98/0x108
  Hardware name: PowerMac3,1 7400 0xc0209 PowerMac
  ...
  Call Trace:
    of_bus_n_size_cells+0x98/0x108 (unreliable)
    of_bus_default_count_cells+0x40/0x60
    __of_get_address+0xc8/0x21c
    __of_address_to_resource+0x5c/0x228
    pmz_init_port+0x5c/0x2ec
    pmz_probe.isra.0+0x144/0x1e4
    pmz_console_init+0x10/0x48
    console_init+0xcc/0x138
    start_kernel+0x5c4/0x694

As powermacs boot via prom_init it's possible to add the missing
properties to the device tree during boot, avoiding the warning. Note
that `escc-legacy` nodes are also missing `#size-cells` properties, but
they are skipped by the macio driver, so leave them alone.

Depends-on: 045b14ca5c36 ("of: WARN on deprecated #address-cells/#size-cells handling")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20241126025710.591683-1-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/prom_init.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index d464ba412084d..a6090896f7497 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2924,7 +2924,7 @@ static void __init fixup_device_tree_chrp(void)
 #endif
 
 #if defined(CONFIG_PPC64) && defined(CONFIG_PPC_PMAC)
-static void __init fixup_device_tree_pmac(void)
+static void __init fixup_device_tree_pmac64(void)
 {
 	phandle u3, i2c, mpic;
 	u32 u3_rev;
@@ -2964,7 +2964,31 @@ static void __init fixup_device_tree_pmac(void)
 		     &parent, sizeof(parent));
 }
 #else
-#define fixup_device_tree_pmac()
+#define fixup_device_tree_pmac64()
+#endif
+
+#ifdef CONFIG_PPC_PMAC
+static void __init fixup_device_tree_pmac(void)
+{
+	__be32 val = 1;
+	char type[8];
+	phandle node;
+
+	// Some pmacs are missing #size-cells on escc nodes
+	for (node = 0; prom_next_node(&node); ) {
+		type[0] = '\0';
+		prom_getprop(node, "device_type", type, sizeof(type));
+		if (prom_strcmp(type, "escc"))
+			continue;
+
+		if (prom_getproplen(node, "#size-cells") != PROM_ERROR)
+			continue;
+
+		prom_setprop(node, NULL, "#size-cells", &val, sizeof(val));
+	}
+}
+#else
+static inline void fixup_device_tree_pmac(void) { }
 #endif
 
 #ifdef CONFIG_PPC_EFIKA
@@ -3189,6 +3213,7 @@ static void __init fixup_device_tree(void)
 	fixup_device_tree_maple_memory_controller();
 	fixup_device_tree_chrp();
 	fixup_device_tree_pmac();
+	fixup_device_tree_pmac64();
 	fixup_device_tree_efika();
 	fixup_device_tree_pasemi();
 }
-- 
2.43.0


