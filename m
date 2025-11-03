Return-Path: <stable+bounces-192190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ECAC2B918
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 13:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE0674E8038
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 12:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36D42D8DDF;
	Mon,  3 Nov 2025 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bru+4fCa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GXHmBE+/"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E96F302754;
	Mon,  3 Nov 2025 12:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762171356; cv=none; b=jV9AxNwl2z6OdA5LJ52X5T8ya8rK7QFJBqBH5QF/O6X2S9lgM++RezLn2qr8rHCEXPPC15XINQAXDpoWVHKQZPjvklR0cTYDWtLPzJvFi9uVYtTaMXqQ0vvJfEMf5Q1vsL/CLd/cwMXlx9yNmJVxVRwypdYJXbjK4Z1jIK4Ci0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762171356; c=relaxed/simple;
	bh=wjJ4GTW3ZQBiMGB3mOx2afmkgjth5bf2L/cJPHLs5m8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PoT6P9blSzM9ILETL9Mkzr3nr3zVts65iru5JjjLG6RGl2PPmpmV94NzoTBv5RuFDt0kU3hnniVgrxAmL7p5JCmeCH7ViXpBzVJST5nrnTVvtBmRkiOSPVUFRGASLYnsALSBAzteixl2kukrVQO33i4LEdYRbBuRTjzJr7m1908=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bru+4fCa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GXHmBE+/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 12:02:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762171351;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4OiI8buPxg4k7SYM/WM1iRKna/Mk2uvO/kYkh7TIahw=;
	b=bru+4fCaevpyfzlvHBz2pLcvJWtEdydO6dUFSYnvbDZ5GPpgfC7tvqHf/vqBEZQesP/YJp
	E0kVlk8fgeh3PyIopeaOcFFfmvPMjJyV+FjuV8JNCiDF/WozZyMRGEGscaw8sBbBTs/xQH
	qpsUp1QbYLN4kjHmbEdPNHnSfAIqPB40jG4BxyLjsag6H1ymCytZ4viQL8nZCyIGymiR5t
	PaE1ADp5lPFJH4Fi38WKBvsd9kqLid5rd8Bgs7rJnIga8bHWWUlxm57on6VsXABT75keJC
	IOOkQLtFnPMuVcWjiIzpFpNbczZIyO6Ir57u3zpwO4kOnY9xGu5vmfq/hfOZsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762171351;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4OiI8buPxg4k7SYM/WM1iRKna/Mk2uvO/kYkh7TIahw=;
	b=GXHmBE+/8Hgfu/kVYEcZ50iqKlupe0eV2kQWHEJnz3Z5Ckzkro5tW5ByEz0zLlLr8l5iIq
	ZW+SUFljOYb2lkDg==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/amd_node: Fix AMD root device caching
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251028-fix-amd-root-v2-1-843e38f8be2c@amd.com>
References: <20251028-fix-amd-root-v2-1-843e38f8be2c@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176217134946.2601451.211473792666059205.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     0a4b61d9c2e496b5f0a10e29e355a1465c8738bb
Gitweb:        https://git.kernel.org/tip/0a4b61d9c2e496b5f0a10e29e355a1465c8=
738bb
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Tue, 28 Oct 2025 21:35:42=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 03 Nov 2025 12:46:57 +01:00

x86/amd_node: Fix AMD root device caching

Recent AMD node rework removed the "search and count" method of caching AMD
root devices. This depended on the value from a Data Fabric register that was
expected to hold the PCI bus of one of the root devices attached to that
fabric.

However, this expectation is incorrect. The register, when read from PCI
config space, returns the bitwise-OR of the buses of all attached root
devices.

This behavior is benign on AMD reference design boards, since the bus numbers
are aligned. This results in a bitwise-OR value matching one of the buses. For
example, 0x00 | 0x40 | 0xA0 | 0xE0 =3D 0xE0.

This behavior breaks on boards where the bus numbers are not exactly aligned.
For example, 0x00 | 0x07 | 0xE0 | 0x15 =3D 0x1F.

The examples above are for AMD node 0. The first root device on other nodes
will not be 0x00. The first root device for other nodes will depend on the
total number of root devices, the system topology, and the specific PCI bus
number assignment.

For example, a system with 2 AMD nodes could have this:

  Node 0 : 0x00 0x07 0x0e 0x15
  Node 1 : 0x1c 0x23 0x2a 0x31

The bus numbering style in the reference boards is not a requirement.  The
numbering found in other boards is not incorrect. Therefore, the root device
caching method needs to be adjusted.

Go back to the "search and count" method used before the recent rework.
Search for root devices using PCI class code rather than fixed PCI IDs.

This keeps the goal of the rework (remove dependency on PCI IDs) while being
able to support various board designs.

Merge helper functions to reduce code duplication.

  [ bp: Reflow comment. ]

Fixes: 40a5f6ffdfc8 ("x86/amd_nb: Simplify root device search")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/all/20251028-fix-amd-root-v2-1-843e38f8be2c@am=
d.com
---
 arch/x86/include/asm/amd/node.h |   1 +-
 arch/x86/kernel/amd_node.c      | 150 ++++++++++---------------------
 2 files changed, 51 insertions(+), 100 deletions(-)

diff --git a/arch/x86/include/asm/amd/node.h b/arch/x86/include/asm/amd/node.h
index 23fe617..a672b87 100644
--- a/arch/x86/include/asm/amd/node.h
+++ b/arch/x86/include/asm/amd/node.h
@@ -23,7 +23,6 @@
 #define AMD_NODE0_PCI_SLOT	0x18
=20
 struct pci_dev *amd_node_get_func(u16 node, u8 func);
-struct pci_dev *amd_node_get_root(u16 node);
=20
 static inline u16 amd_num_nodes(void)
 {
diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index a40176b..3d0a476 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -34,62 +34,6 @@ struct pci_dev *amd_node_get_func(u16 node, u8 func)
 	return pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(AMD_NODE0_PCI_SLOT + nod=
e, func));
 }
=20
-#define DF_BLK_INST_CNT		0x040
-#define	DF_CFG_ADDR_CNTL_LEGACY	0x084
-#define	DF_CFG_ADDR_CNTL_DF4	0xC04
-
-#define DF_MAJOR_REVISION	GENMASK(27, 24)
-
-static u16 get_cfg_addr_cntl_offset(struct pci_dev *df_f0)
-{
-	u32 reg;
-
-	/*
-	 * Revision fields added for DF4 and later.
-	 *
-	 * Major revision of '0' is found pre-DF4. Field is Read-as-Zero.
-	 */
-	if (pci_read_config_dword(df_f0, DF_BLK_INST_CNT, &reg))
-		return 0;
-
-	if (reg & DF_MAJOR_REVISION)
-		return DF_CFG_ADDR_CNTL_DF4;
-
-	return DF_CFG_ADDR_CNTL_LEGACY;
-}
-
-struct pci_dev *amd_node_get_root(u16 node)
-{
-	struct pci_dev *root;
-	u16 cntl_off;
-	u8 bus;
-
-	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
-		return NULL;
-
-	/*
-	 * D18F0xXXX [Config Address Control] (DF::CfgAddressCntl)
-	 * Bits [7:0] (SecBusNum) holds the bus number of the root device for
-	 * this Data Fabric instance. The segment, device, and function will be 0.
-	 */
-	struct pci_dev *df_f0 __free(pci_dev_put) =3D amd_node_get_func(node, 0);
-	if (!df_f0)
-		return NULL;
-
-	cntl_off =3D get_cfg_addr_cntl_offset(df_f0);
-	if (!cntl_off)
-		return NULL;
-
-	if (pci_read_config_byte(df_f0, cntl_off, &bus))
-		return NULL;
-
-	/* Grab the pointer for the actual root device instance. */
-	root =3D pci_get_domain_bus_and_slot(0, bus, 0);
-
-	pci_dbg(root, "is root for AMD node %u\n", node);
-	return root;
-}
-
 static struct pci_dev **amd_roots;
=20
 /* Protect the PCI config register pairs used for SMN. */
@@ -274,51 +218,21 @@ DEFINE_SHOW_STORE_ATTRIBUTE(smn_node);
 DEFINE_SHOW_STORE_ATTRIBUTE(smn_address);
 DEFINE_SHOW_STORE_ATTRIBUTE(smn_value);
=20
-static int amd_cache_roots(void)
-{
-	u16 node, num_nodes =3D amd_num_nodes();
-
-	amd_roots =3D kcalloc(num_nodes, sizeof(*amd_roots), GFP_KERNEL);
-	if (!amd_roots)
-		return -ENOMEM;
-
-	for (node =3D 0; node < num_nodes; node++)
-		amd_roots[node] =3D amd_node_get_root(node);
-
-	return 0;
-}
-
-static int reserve_root_config_spaces(void)
+static struct pci_dev *get_next_root(struct pci_dev *root)
 {
-	struct pci_dev *root =3D NULL;
-	struct pci_bus *bus =3D NULL;
-
-	while ((bus =3D pci_find_next_bus(bus))) {
-		/* Root device is Device 0 Function 0 on each Primary Bus. */
-		root =3D pci_get_slot(bus, 0);
-		if (!root)
+	while ((root =3D pci_get_class(PCI_CLASS_BRIDGE_HOST << 8, root))) {
+		/* Root device is Device 0 Function 0. */
+		if (root->devfn)
 			continue;
=20
 		if (root->vendor !=3D PCI_VENDOR_ID_AMD &&
 		    root->vendor !=3D PCI_VENDOR_ID_HYGON)
 			continue;
=20
-		pci_dbg(root, "Reserving PCI config space\n");
-
-		/*
-		 * There are a few SMN index/data pairs and other registers
-		 * that shouldn't be accessed by user space.
-		 * So reserve the entire PCI config space for simplicity rather
-		 * than covering specific registers piecemeal.
-		 */
-		if (!pci_request_config_region_exclusive(root, 0, PCI_CFG_SPACE_SIZE, NULL=
)) {
-			pci_err(root, "Failed to reserve config space\n");
-			return -EEXIST;
-		}
+		break;
 	}
=20
-	smn_exclusive =3D true;
-	return 0;
+	return root;
 }
=20
 static bool enable_dfs;
@@ -332,7 +246,8 @@ __setup("amd_smn_debugfs_enable", amd_smn_enable_dfs);
=20
 static int __init amd_smn_init(void)
 {
-	int err;
+	u16 count, num_roots, roots_per_node, node, num_nodes;
+	struct pci_dev *root;
=20
 	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
 		return 0;
@@ -342,13 +257,48 @@ static int __init amd_smn_init(void)
 	if (amd_roots)
 		return 0;
=20
-	err =3D amd_cache_roots();
-	if (err)
-		return err;
+	num_roots =3D 0;
+	root =3D NULL;
+	while ((root =3D get_next_root(root))) {
+		pci_dbg(root, "Reserving PCI config space\n");
=20
-	err =3D reserve_root_config_spaces();
-	if (err)
-		return err;
+		/*
+		 * There are a few SMN index/data pairs and other registers
+		 * that shouldn't be accessed by user space. So reserve the
+		 * entire PCI config space for simplicity rather than covering
+		 * specific registers piecemeal.
+		 */
+		if (!pci_request_config_region_exclusive(root, 0, PCI_CFG_SPACE_SIZE, NULL=
)) {
+			pci_err(root, "Failed to reserve config space\n");
+			return -EEXIST;
+		}
+
+		num_roots++;
+	}
+
+	pr_debug("Found %d AMD root devices\n", num_roots);
+
+	if (!num_roots)
+		return -ENODEV;
+
+	num_nodes =3D amd_num_nodes();
+	amd_roots =3D kcalloc(num_nodes, sizeof(*amd_roots), GFP_KERNEL);
+	if (!amd_roots)
+		return -ENOMEM;
+
+	roots_per_node =3D num_roots / num_nodes;
+
+	count =3D 0;
+	node =3D 0;
+	root =3D NULL;
+	while (node < num_nodes && (root =3D get_next_root(root))) {
+		/* Use one root for each node and skip the rest. */
+		if (count++ % roots_per_node)
+			continue;
+
+		pci_dbg(root, "is root for AMD node %u\n", node);
+		amd_roots[node++] =3D root;
+	}
=20
 	if (enable_dfs) {
 		debugfs_dir =3D debugfs_create_dir("amd_smn", arch_debugfs_dir);
@@ -358,6 +308,8 @@ static int __init amd_smn_init(void)
 		debugfs_create_file("value",	0600, debugfs_dir, NULL, &smn_value_fops);
 	}
=20
+	smn_exclusive =3D true;
+
 	return 0;
 }
=20

