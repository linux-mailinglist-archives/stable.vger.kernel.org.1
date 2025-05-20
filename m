Return-Path: <stable+bounces-145533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA57ABDC0E
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0080B1883D3C
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EDE24337C;
	Tue, 20 May 2025 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MT9hAssl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E987524677B;
	Tue, 20 May 2025 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750452; cv=none; b=EW+T9p/BnsPyB9aTP0clov7byaW7EteVbr8XJVBbnUo8V9A+9XAGbrcjdWIBmM2Rn/Bsblt7IwOQRMcxTEhiwB3SVnrm0BrFdQE4VAuwnUQTWoAySRrrKHmGeMOt1Z5lHhwl+xJFi4FSiUiequZAImJn9iOCT48LT1YBeatONtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750452; c=relaxed/simple;
	bh=enDFJLL3wmo115/2Zq6EnRva3wHhwfRQiSu2bAZPlnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ADeEPt3y7vtoMo32BeUk2SRp32c+rt6kkWuMtj5jIB4T/sfeyID5TGTiNPG4nL6vP3vfDcIlwrMozKz3UBXgZRNP/uTLKUR8efruPKiAJJb8N/VSlk7g3MIk3HJ+6aJ6f0Zilz0bCT7t06kg3S45k8CgnX+VuzG9bcOUeKkb9DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MT9hAssl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02391C4CEE9;
	Tue, 20 May 2025 14:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747750451;
	bh=enDFJLL3wmo115/2Zq6EnRva3wHhwfRQiSu2bAZPlnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MT9hAssl8YPsZSefrmskzJof5TRVylxvzi8lvlpwT1tIB3yUqZ8bkP6u17h7pKbLi
	 ER0rA85Q4+pJxdqx++GxUZr3rLCvOo0iYthjY9eWLe2GB0OOfBfQWY1yiGbHfNcfqR
	 onorEwh06J8blEvX/wHws0d2kmSCp4namq9Rii0E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Carlos Bilbao <carlos.bilbao@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 005/145] x86/amd_node, platform/x86/amd/hsmp: Have HSMP use SMN through AMD_NODE
Date: Tue, 20 May 2025 15:49:35 +0200
Message-ID: <20250520125810.756391464@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125810.535475500@linuxfoundation.org>
References: <20250520125810.535475500@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yazen Ghannam <yazen.ghannam@amd.com>

[ Upstream commit 735049b801cf3d597752017385cfc8768ce44303 ]

The HSMP interface is just an SMN interface with different offsets.

Define an HSMP wrapper in the SMN code and have the HSMP platform driver
use that rather than a local solution.

Also, remove the "root" member from AMD_NB, since there are no more
users of it.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Carlos Bilbao <carlos.bilbao@kernel.org>
Acked-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20250130-wip-x86-amd-nb-cleanup-v4-1-b5cc997e471b@amd.com
Stable-dep-of: 0581d384f344 ("platform/x86/amd/hsmp: Make amd_hsmp and hsmp_acpi as mutually exclusive drivers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/amd_nb.h         |  1 -
 arch/x86/include/asm/amd_node.h       | 13 ++++++++++
 arch/x86/kernel/amd_nb.c              |  1 -
 arch/x86/kernel/amd_node.c            |  9 +++++++
 drivers/platform/x86/amd/hsmp/Kconfig |  2 +-
 drivers/platform/x86/amd/hsmp/acpi.c  |  7 +++---
 drivers/platform/x86/amd/hsmp/hsmp.c  |  1 -
 drivers/platform/x86/amd/hsmp/hsmp.h  |  3 ---
 drivers/platform/x86/amd/hsmp/plat.c  | 36 +++++++++------------------
 9 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 4c4efb93045ed..adfa0854cf2da 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -27,7 +27,6 @@ struct amd_l3_cache {
 };
 
 struct amd_northbridge {
-	struct pci_dev *root;
 	struct pci_dev *misc;
 	struct pci_dev *link;
 	struct amd_l3_cache l3_cache;
diff --git a/arch/x86/include/asm/amd_node.h b/arch/x86/include/asm/amd_node.h
index 113ad3e8ee40a..002c3afbd30f9 100644
--- a/arch/x86/include/asm/amd_node.h
+++ b/arch/x86/include/asm/amd_node.h
@@ -30,7 +30,20 @@ static inline u16 amd_num_nodes(void)
 	return topology_amd_nodes_per_pkg() * topology_max_packages();
 }
 
+#ifdef CONFIG_AMD_NODE
 int __must_check amd_smn_read(u16 node, u32 address, u32 *value);
 int __must_check amd_smn_write(u16 node, u32 address, u32 value);
 
+/* Should only be used by the HSMP driver. */
+int __must_check amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *value, bool write);
+#else
+static inline int __must_check amd_smn_read(u16 node, u32 address, u32 *value) { return -ENODEV; }
+static inline int __must_check amd_smn_write(u16 node, u32 address, u32 value) { return -ENODEV; }
+
+static inline int __must_check amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *value, bool write)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_AMD_NODE */
+
 #endif /*_ASM_X86_AMD_NODE_H_*/
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 67e773744edb2..6d12a9b694327 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -73,7 +73,6 @@ static int amd_cache_northbridges(void)
 	amd_northbridges.nb = nb;
 
 	for (i = 0; i < amd_northbridges.num; i++) {
-		node_to_amd_nb(i)->root = amd_node_get_root(i);
 		node_to_amd_nb(i)->misc = amd_node_get_func(i, 3);
 
 		/*
diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index d2ec7fd555c51..65045f223c10a 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -97,6 +97,9 @@ static DEFINE_MUTEX(smn_mutex);
 #define SMN_INDEX_OFFSET	0x60
 #define SMN_DATA_OFFSET		0x64
 
+#define HSMP_INDEX_OFFSET	0xc4
+#define HSMP_DATA_OFFSET	0xc8
+
 /*
  * SMN accesses may fail in ways that are difficult to detect here in the called
  * functions amd_smn_read() and amd_smn_write(). Therefore, callers must do
@@ -179,6 +182,12 @@ int __must_check amd_smn_write(u16 node, u32 address, u32 value)
 }
 EXPORT_SYMBOL_GPL(amd_smn_write);
 
+int __must_check amd_smn_hsmp_rdwr(u16 node, u32 address, u32 *value, bool write)
+{
+	return __amd_smn_rw(HSMP_INDEX_OFFSET, HSMP_DATA_OFFSET, node, address, value, write);
+}
+EXPORT_SYMBOL_GPL(amd_smn_hsmp_rdwr);
+
 static int amd_cache_roots(void)
 {
 	u16 node, num_nodes = amd_num_nodes();
diff --git a/drivers/platform/x86/amd/hsmp/Kconfig b/drivers/platform/x86/amd/hsmp/Kconfig
index 7d10d4462a453..d6f7a62d55b5e 100644
--- a/drivers/platform/x86/amd/hsmp/Kconfig
+++ b/drivers/platform/x86/amd/hsmp/Kconfig
@@ -7,7 +7,7 @@ config AMD_HSMP
 	tristate
 
 menu "AMD HSMP Driver"
-	depends on AMD_NB || COMPILE_TEST
+	depends on AMD_NODE || COMPILE_TEST
 
 config AMD_HSMP_ACPI
 	tristate "AMD HSMP ACPI device driver"
diff --git a/drivers/platform/x86/amd/hsmp/acpi.c b/drivers/platform/x86/amd/hsmp/acpi.c
index 444b43be35a25..c1eccb3c80c5c 100644
--- a/drivers/platform/x86/amd/hsmp/acpi.c
+++ b/drivers/platform/x86/amd/hsmp/acpi.c
@@ -10,7 +10,6 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <asm/amd_hsmp.h>
-#include <asm/amd_nb.h>
 
 #include <linux/acpi.h>
 #include <linux/device.h>
@@ -24,6 +23,8 @@
 
 #include <uapi/asm-generic/errno-base.h>
 
+#include <asm/amd_node.h>
+
 #include "hsmp.h"
 
 #define DRIVER_NAME		"amd_hsmp"
@@ -321,8 +322,8 @@ static int hsmp_acpi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	if (!hsmp_pdev->is_probed) {
-		hsmp_pdev->num_sockets = amd_nb_num();
-		if (hsmp_pdev->num_sockets == 0 || hsmp_pdev->num_sockets > MAX_AMD_SOCKETS)
+		hsmp_pdev->num_sockets = amd_num_nodes();
+		if (hsmp_pdev->num_sockets == 0 || hsmp_pdev->num_sockets > MAX_AMD_NUM_NODES)
 			return -ENODEV;
 
 		hsmp_pdev->sock = devm_kcalloc(&pdev->dev, hsmp_pdev->num_sockets,
diff --git a/drivers/platform/x86/amd/hsmp/hsmp.c b/drivers/platform/x86/amd/hsmp/hsmp.c
index 03164e30b3a50..a3ac09a90de45 100644
--- a/drivers/platform/x86/amd/hsmp/hsmp.c
+++ b/drivers/platform/x86/amd/hsmp/hsmp.c
@@ -8,7 +8,6 @@
  */
 
 #include <asm/amd_hsmp.h>
-#include <asm/amd_nb.h>
 
 #include <linux/acpi.h>
 #include <linux/delay.h>
diff --git a/drivers/platform/x86/amd/hsmp/hsmp.h b/drivers/platform/x86/amd/hsmp/hsmp.h
index e852f0a947e4f..af8b21f821d66 100644
--- a/drivers/platform/x86/amd/hsmp/hsmp.h
+++ b/drivers/platform/x86/amd/hsmp/hsmp.h
@@ -21,8 +21,6 @@
 
 #define HSMP_ATTR_GRP_NAME_SIZE	10
 
-#define MAX_AMD_SOCKETS 8
-
 #define HSMP_CDEV_NAME		"hsmp_cdev"
 #define HSMP_DEVNODE_NAME	"hsmp"
 
@@ -41,7 +39,6 @@ struct hsmp_socket {
 	void __iomem *virt_base_addr;
 	struct semaphore hsmp_sem;
 	char name[HSMP_ATTR_GRP_NAME_SIZE];
-	struct pci_dev *root;
 	struct device *dev;
 	u16 sock_ind;
 	int (*amd_hsmp_rdwr)(struct hsmp_socket *sock, u32 off, u32 *val, bool rw);
diff --git a/drivers/platform/x86/amd/hsmp/plat.c b/drivers/platform/x86/amd/hsmp/plat.c
index 02ca85762b686..b9782a078dbd2 100644
--- a/drivers/platform/x86/amd/hsmp/plat.c
+++ b/drivers/platform/x86/amd/hsmp/plat.c
@@ -10,14 +10,16 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <asm/amd_hsmp.h>
-#include <asm/amd_nb.h>
 
+#include <linux/build_bug.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/sysfs.h>
 
+#include <asm/amd_node.h>
+
 #include "hsmp.h"
 
 #define DRIVER_NAME		"amd_hsmp"
@@ -34,28 +36,12 @@
 #define SMN_HSMP_MSG_RESP	0x0010980
 #define SMN_HSMP_MSG_DATA	0x00109E0
 
-#define HSMP_INDEX_REG		0xc4
-#define HSMP_DATA_REG		0xc8
-
 static struct hsmp_plat_device *hsmp_pdev;
 
 static int amd_hsmp_pci_rdwr(struct hsmp_socket *sock, u32 offset,
 			     u32 *value, bool write)
 {
-	int ret;
-
-	if (!sock->root)
-		return -ENODEV;
-
-	ret = pci_write_config_dword(sock->root, HSMP_INDEX_REG,
-				     sock->mbinfo.base_addr + offset);
-	if (ret)
-		return ret;
-
-	ret = (write ? pci_write_config_dword(sock->root, HSMP_DATA_REG, *value)
-		     : pci_read_config_dword(sock->root, HSMP_DATA_REG, value));
-
-	return ret;
+	return amd_smn_hsmp_rdwr(sock->sock_ind, sock->mbinfo.base_addr + offset, value, write);
 }
 
 static ssize_t hsmp_metric_tbl_plat_read(struct file *filp, struct kobject *kobj,
@@ -95,7 +81,12 @@ static umode_t hsmp_is_sock_attr_visible(struct kobject *kobj,
  * Static array of 8 + 1(for NULL) elements is created below
  * to create sysfs groups for sockets.
  * is_bin_visible function is used to show / hide the necessary groups.
+ *
+ * Validate the maximum number against MAX_AMD_NUM_NODES. If this changes,
+ * then the attributes and groups below must be adjusted.
  */
+static_assert(MAX_AMD_NUM_NODES == 8);
+
 #define HSMP_BIN_ATTR(index, _list)					\
 static const struct bin_attribute attr##index = {			\
 	.attr = { .name = HSMP_METRICS_TABLE_NAME, .mode = 0444},	\
@@ -159,10 +150,7 @@ static int init_platform_device(struct device *dev)
 	int ret, i;
 
 	for (i = 0; i < hsmp_pdev->num_sockets; i++) {
-		if (!node_to_amd_nb(i))
-			return -ENODEV;
 		sock = &hsmp_pdev->sock[i];
-		sock->root			= node_to_amd_nb(i)->root;
 		sock->sock_ind			= i;
 		sock->dev			= dev;
 		sock->mbinfo.base_addr		= SMN_HSMP_BASE;
@@ -305,11 +293,11 @@ static int __init hsmp_plt_init(void)
 		return -ENOMEM;
 
 	/*
-	 * amd_nb_num() returns number of SMN/DF interfaces present in the system
+	 * amd_num_nodes() returns number of SMN/DF interfaces present in the system
 	 * if we have N SMN/DF interfaces that ideally means N sockets
 	 */
-	hsmp_pdev->num_sockets = amd_nb_num();
-	if (hsmp_pdev->num_sockets == 0 || hsmp_pdev->num_sockets > MAX_AMD_SOCKETS)
+	hsmp_pdev->num_sockets = amd_num_nodes();
+	if (hsmp_pdev->num_sockets == 0 || hsmp_pdev->num_sockets > MAX_AMD_NUM_NODES)
 		return ret;
 
 	ret = platform_driver_register(&amd_hsmp_driver);
-- 
2.39.5




