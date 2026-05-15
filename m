Return-Path: <stable+bounces-247716-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPKBEs4NB2oLrAIAu9opvQ
	(envelope-from <stable+bounces-247716-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:13:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C80C354F3DB
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85FBA31ACCC2
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECA147F2CA;
	Fri, 15 May 2026 11:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZoidVDnr"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475FD47F2C0
	for <stable@vger.kernel.org>; Fri, 15 May 2026 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846251; cv=none; b=RnjfHY4QqxLxKCOxN9BOzaHM6TXaJcmYNzR1ticqZPRvYgweZ4r0kKXpCFCicyfw44ciWvjvMsGFVIsCWj/AjzRdiAb7eSYY5muXPdZZCLQYPfpYG6lK/GHVybTSBo4CkcjMb54XhGPQqvktudZ13Cn3kErgiwMtpThNbL8+Rpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846251; c=relaxed/simple;
	bh=qv6791fmwYA8Bu9G/4+WRwlbAR6upaKRhwrl1guW0Pc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MdmdOYLaioelN0xnenMegbEOR2fkCFKBQOCHkhRjRUeXPgNVwM0Z6j/Xqx2s2/FMR1vK8bFTYVPPfrD8NwKVaXzvksJo+ZphIdi84Du8Nfb8goCM2PjtOtCP18A/9ENXyT73+aUpCYXD/qbTPaAtAKS5HECWNXl27fqegeo/EME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZoidVDnr; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 88399C2B9C5;
	Fri, 15 May 2026 11:58:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 30F7D606FD;
	Fri, 15 May 2026 11:57:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D0F7611AF8C57;
	Fri, 15 May 2026 13:57:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778846241; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZULPDCQMZeP6dSm6lPb3NNTuIuvRxhqHOfIGSPpG41Y=;
	b=ZoidVDnrQR2s+sN4fIiPjgkWD8yiW9/V3gP/WuH4+XnbY+zgGSbTuVL98NamwrX6oxIhtm
	o3TeXuZ1xjcoP1aoj1pv7F7ueuPBL192uScXHIGU1pf6HSvt6qiMZXLLwGRVthEDFxhnbU
	ggxVd5QgMlASEx50yFPI2grsuptlkw6/eoNKakYu0GNc52/GIJjL1bLTwqICLCm2LMGBi+
	CjjgdQX76fRcGcmXCaHXX3acsNJeqYVjXGbB+XG8XDscTovjzd7QkISFTw2ukt/2xl58gk
	9Willk7QU8rf4Fvk4nEf7FgpiLZPW8q9/enll4yE1REhROR4JSePsp9Iio4w5A==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 15 May 2026 13:56:56 +0200
Subject: [PATCH v2 1/2] nvmem: layouts: Add fixed-layout driver
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-mathieu-nvmem-fixed-layout-v2-1-8ac215dd4016@bootlin.com>
References: <20260515-mathieu-nvmem-fixed-layout-v2-0-8ac215dd4016@bootlin.com>
In-Reply-To: <20260515-mathieu-nvmem-fixed-layout-v2-0-8ac215dd4016@bootlin.com>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778846239; l=6953;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=qv6791fmwYA8Bu9G/4+WRwlbAR6upaKRhwrl1guW0Pc=;
 b=KVeH5ZdSlZDePqs5ItI1ebjRhLulvV+4YvG+JOrxJKwgpAZ9KmPJFCxCBQRvorjEuHvdTON2V
 HOGtDPQ8hATBEwcXhH2yVDtiboU9OAWf9aV3FzS7jBVLQKVz+gYEawY
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: C80C354F3DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247716-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathieu.dubois-briand@bootlin.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Current implementation isn't working well when device tree nodes have a
phandle on a fixed-layout nvmem node. As the fixed layout is handled in
nvmem core, no driver is ever associated with the layout, and the device
consumer driver probe is deferred indefinitely.

Remove the specific handling of fixed-layout and add a layout driver.
This makes the fixed-layout similar to all other layouts, fixing the
whole issue.

Fixes: fc29fd821d9a ("nvmem: core: Rework layouts to become regular devices")
Cc: stable@vger.kernel.org
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 MAINTAINERS                          |  5 ++++
 drivers/nvmem/core.c                 | 23 +---------------
 drivers/nvmem/layouts.c              | 11 --------
 drivers/nvmem/layouts/Makefile       |  1 +
 drivers/nvmem/layouts/fixed-layout.c | 52 ++++++++++++++++++++++++++++++++++++
 include/linux/nvmem-provider.h       |  7 +++++
 6 files changed, 66 insertions(+), 33 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 882214b0e7db..c48c4e129736 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10018,6 +10018,11 @@ F:	drivers/base/firmware_loader/
 F:	rust/kernel/firmware.rs
 F:	include/linux/firmware.h
 
+FIXED-LAYOUT NVMEM LAYOUT DRIVER
+M:	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+S:	Maintained
+F:	drivers/nvmem/layouts/fixed-layout.c
+
 FLEXTIMER FTM-QUADDEC DRIVER
 M:	Patrick Havelange <patrick.havelange@essensium.com>
 L:	linux-iio@vger.kernel.org
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 311cb2e5a5c0..0ec4924c4bda 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -786,7 +786,7 @@ static int nvmem_validate_keepouts(struct nvmem_device *nvmem)
 	return 0;
 }
 
-static int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_node *np)
+int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_node *np)
 {
 	struct device *dev = &nvmem->dev;
 	const __be32 *addr;
@@ -840,23 +840,6 @@ static int nvmem_add_cells_from_legacy_of(struct nvmem_device *nvmem)
 	return nvmem_add_cells_from_dt(nvmem, nvmem->dev.of_node);
 }
 
-static int nvmem_add_cells_from_fixed_layout(struct nvmem_device *nvmem)
-{
-	struct device_node *layout_np;
-	int err = 0;
-
-	layout_np = of_nvmem_layout_get_container(nvmem);
-	if (!layout_np)
-		return 0;
-
-	if (of_device_is_compatible(layout_np, "fixed-layout"))
-		err = nvmem_add_cells_from_dt(nvmem, layout_np);
-
-	of_node_put(layout_np);
-
-	return err;
-}
-
 int nvmem_layout_register(struct nvmem_layout *layout)
 {
 	int ret;
@@ -1005,10 +988,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 			goto err_remove_cells;
 	}
 
-	rval = nvmem_add_cells_from_fixed_layout(nvmem);
-	if (rval)
-		goto err_remove_cells;
-
 	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
 
 	rval = device_add(&nvmem->dev);
diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
index b90584e1b99e..07a34be9669c 100644
--- a/drivers/nvmem/layouts.c
+++ b/drivers/nvmem/layouts.c
@@ -125,11 +125,6 @@ static int nvmem_layout_create_device(struct nvmem_device *nvmem,
 	return 0;
 }
 
-static const struct of_device_id of_nvmem_layout_skip_table[] = {
-	{ .compatible = "fixed-layout", },
-	{}
-};
-
 static int nvmem_layout_bus_populate(struct nvmem_device *nvmem,
 				     struct device_node *layout_dn)
 {
@@ -142,12 +137,6 @@ static int nvmem_layout_bus_populate(struct nvmem_device *nvmem,
 		return 0;
 	}
 
-	/* Fixed layouts are parsed manually somewhere else for now */
-	if (of_match_node(of_nvmem_layout_skip_table, layout_dn)) {
-		pr_debug("%s() - skipping %pOF node\n", __func__, layout_dn);
-		return 0;
-	}
-
 	if (of_node_check_flag(layout_dn, OF_POPULATED_BUS)) {
 		pr_debug("%s() - skipping %pOF, already populated\n",
 			 __func__, layout_dn);
diff --git a/drivers/nvmem/layouts/Makefile b/drivers/nvmem/layouts/Makefile
index 4940c9db0665..dd6c6c70b1a9 100644
--- a/drivers/nvmem/layouts/Makefile
+++ b/drivers/nvmem/layouts/Makefile
@@ -3,6 +3,7 @@
 # Makefile for nvmem layouts.
 #
 
+obj-$(CONFIG_NVMEM_LAYOUTS) += fixed-layout.o
 obj-$(CONFIG_NVMEM_LAYOUT_SL28_VPD) += sl28vpd.o
 obj-$(CONFIG_NVMEM_LAYOUT_ONIE_TLV) += onie-tlv.o
 obj-$(CONFIG_NVMEM_LAYOUT_U_BOOT_ENV) += u-boot-env.o
diff --git a/drivers/nvmem/layouts/fixed-layout.c b/drivers/nvmem/layouts/fixed-layout.c
new file mode 100644
index 000000000000..bc7da9a904d4
--- /dev/null
+++ b/drivers/nvmem/layouts/fixed-layout.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2026 Bootlin
+ *
+ * Authors: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+ */
+
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+
+static int fixed_layout_add_cells(struct nvmem_layout *layout)
+{
+	struct device_node *np;
+
+	np = of_nvmem_layout_get_container(layout->nvmem);
+	if (!np)
+		return -ENOENT;
+
+	return nvmem_add_cells_from_dt(layout->nvmem, np);
+}
+
+static int fixed_layout_probe(struct nvmem_layout *layout)
+{
+	layout->add_cells = fixed_layout_add_cells;
+
+	return nvmem_layout_register(layout);
+}
+
+static void fixed_layout_remove(struct nvmem_layout *layout)
+{
+	nvmem_layout_unregister(layout);
+}
+
+static const struct of_device_id fixed_layout_of_match_table[] = {
+	{ .compatible = "fixed-layout", },
+	{},
+};
+
+static struct nvmem_layout_driver fixed_layout_layout = {
+	.driver = {
+		.name = "fixed-layout",
+		.of_match_table = fixed_layout_of_match_table,
+	},
+	.probe = fixed_layout_probe,
+	.remove = fixed_layout_remove,
+};
+module_nvmem_layout_driver(fixed_layout_layout);
+
+MODULE_AUTHOR("Mathieu Dubois-Briand");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(of, fixed_layout_of_match_table);
+MODULE_DESCRIPTION("NVMEM fixed-layout driver");
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index f3b13da78aac..e7eaa9a89b8b 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -176,6 +176,7 @@ int nvmem_add_one_cell(struct nvmem_device *nvmem,
 
 int nvmem_layout_register(struct nvmem_layout *layout);
 void nvmem_layout_unregister(struct nvmem_layout *layout);
+int nvmem_add_cells_from_dt(struct nvmem_device *nvmem, struct device_node *np);
 
 #define nvmem_layout_driver_register(drv) \
 	__nvmem_layout_driver_register(drv, THIS_MODULE)
@@ -214,6 +215,12 @@ static inline int nvmem_layout_register(struct nvmem_layout *layout)
 
 static inline void nvmem_layout_unregister(struct nvmem_layout *layout) {}
 
+static inline int nvmem_add_cells_from_dt(struct nvmem_device *nvmem,
+					  struct device_node *np)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_NVMEM */
 
 #if IS_ENABLED(CONFIG_NVMEM) && IS_ENABLED(CONFIG_OF)

-- 
2.47.3


