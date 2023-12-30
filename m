Return-Path: <stable+bounces-8720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4F4820468
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 11:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8CBE2821C4
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 10:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224091FC5;
	Sat, 30 Dec 2023 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z5RTDZ9t"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFA423A5
	for <Stable@vger.kernel.org>; Sat, 30 Dec 2023 10:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179FDC433C8;
	Sat, 30 Dec 2023 10:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703933856;
	bh=NBpsryUwXRjHbHpu/JkFmURCwaRT1DhoYufVFhGorPM=;
	h=Subject:To:Cc:From:Date:From;
	b=Z5RTDZ9t2SI7ckPHFaUxsIGSYTH24YoqxBDBX+hJm13nrS6Gfi7wQc7xkKRn2AG/s
	 6LXGulePJvuTvYzjya3jvVMCMcR3Zo7oE0IcGxer3NUC5QLkWjQfNsVu8PmohHwxzk
	 RikQSPwxJtL52y5JV9n4FlPQEd7mpBFkFY7K2eOI=
Subject: FAILED: patch "[PATCH] nvmem: brcm_nvram: store a copy of NVRAM content" failed to apply to 5.15-stable tree
To: rafal@milecki.pl,Stable@vger.kernel.org,arinc.unal@arinc9.com,florian.fainelli@broadcom.com,gregkh@linuxfoundation.org,scott.branden@broadcom.com,srinivas.kandagatla@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 30 Dec 2023 10:57:25 +0000
Message-ID: <2023123025-coming-unlawful-c79b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1e37bf84afacd5ba17b7a13a18ca2bc78aff05c0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023123025-coming-unlawful-c79b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

1e37bf84afac ("nvmem: brcm_nvram: store a copy of NVRAM content")
cfadd0e7d922 ("nvmem: brcm_nvram: Use devm_platform_get_and_ioremap_resource()")
73bcd133c910 ("nvmem: brcm_nvram: add .read_post_process() for MACs")
b0576ade3aaf ("nvmem: brcm_nvram: Add check for kzalloc")
a5be5ce0e254 ("firmware/nvram: bcm47xx: support init from IO memory")
a06d9e5a63b7 ("nvmem: sort config symbols alphabetically")
28fc7c986f01 ("nvmem: prefix all symbols with NVMEM_")
d3524bb5b9a0 ("nvmem: brcm_nvram: Use kzalloc for allocating only one element")
d5542923f200 ("nvmem: add driver handling U-Boot environment variables")
228dfe98a313 ("Merge tag 'char-misc-6.0-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1e37bf84afacd5ba17b7a13a18ca2bc78aff05c0 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Date: Fri, 15 Dec 2023 11:13:58 +0000
Subject: [PATCH] nvmem: brcm_nvram: store a copy of NVRAM content
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This driver uses MMIO access for reading NVRAM from a flash device.
Underneath there is a flash controller that reads data and provides
mapping window.

Using MMIO interface affects controller configuration and may break real
controller driver. It was reported by multiple users of devices with
NVRAM stored on NAND.

Modify driver to read & cache NVRAM content during init and use that
copy to provide NVMEM data when requested. On NAND flashes due to their
alignment NVRAM partitions can be quite big (1 MiB and more) while
actual NVRAM content stays quite small (usually 16 to 32 KiB). To avoid
allocating so much memory check for actual data length.

Link: https://lore.kernel.org/linux-mtd/CACna6rwf3_9QVjYcM+847biTX=K0EoWXuXcSMkJO1Vy_5vmVqA@mail.gmail.com/
Fixes: 3fef9ed0627a ("nvmem: brcm_nvram: new driver exposing Broadcom's NVRAM")
Cc:  <Stable@vger.kernel.org>
Cc: Arınç ÜNAL <arinc.unal@arinc9.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Acked-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20231215111358.316727-3-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
index 9737104f3b76..5cdf339cfbec 100644
--- a/drivers/nvmem/brcm_nvram.c
+++ b/drivers/nvmem/brcm_nvram.c
@@ -17,9 +17,23 @@
 
 #define NVRAM_MAGIC			"FLSH"
 
+/**
+ * struct brcm_nvram - driver state internal struct
+ *
+ * @dev:		NVMEM device pointer
+ * @nvmem_size:		Size of the whole space available for NVRAM
+ * @data:		NVRAM data copy stored to avoid poking underlaying flash controller
+ * @data_len:		NVRAM data size
+ * @padding_byte:	Padding value used to fill remaining space
+ * @cells:		Array of discovered NVMEM cells
+ * @ncells:		Number of elements in cells
+ */
 struct brcm_nvram {
 	struct device *dev;
-	void __iomem *base;
+	size_t nvmem_size;
+	uint8_t *data;
+	size_t data_len;
+	uint8_t padding_byte;
 	struct nvmem_cell_info *cells;
 	int ncells;
 };
@@ -36,10 +50,47 @@ static int brcm_nvram_read(void *context, unsigned int offset, void *val,
 			   size_t bytes)
 {
 	struct brcm_nvram *priv = context;
-	u8 *dst = val;
+	size_t to_copy;
+
+	if (offset + bytes > priv->data_len)
+		to_copy = max_t(ssize_t, (ssize_t)priv->data_len - offset, 0);
+	else
+		to_copy = bytes;
+
+	memcpy(val, priv->data + offset, to_copy);
+
+	memset((uint8_t *)val + to_copy, priv->padding_byte, bytes - to_copy);
+
+	return 0;
+}
+
+static int brcm_nvram_copy_data(struct brcm_nvram *priv, struct platform_device *pdev)
+{
+	struct resource *res;
+	void __iomem *base;
+
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	priv->nvmem_size = resource_size(res);
+
+	priv->padding_byte = readb(base + priv->nvmem_size - 1);
+	for (priv->data_len = priv->nvmem_size;
+	     priv->data_len;
+	     priv->data_len--) {
+		if (readb(base + priv->data_len - 1) != priv->padding_byte)
+			break;
+	}
+	WARN(priv->data_len > SZ_128K, "Unexpected (big) NVRAM size: %zu B\n", priv->data_len);
+
+	priv->data = devm_kzalloc(priv->dev, priv->data_len, GFP_KERNEL);
+	if (!priv->data)
+		return -ENOMEM;
+
+	memcpy_fromio(priv->data, base, priv->data_len);
 
-	while (bytes--)
-		*dst++ = readb(priv->base + offset++);
+	bcm47xx_nvram_init_from_iomem(base, priv->data_len);
 
 	return 0;
 }
@@ -67,8 +118,13 @@ static int brcm_nvram_add_cells(struct brcm_nvram *priv, uint8_t *data,
 				size_t len)
 {
 	struct device *dev = priv->dev;
-	char *var, *value, *eq;
+	char *var, *value;
+	uint8_t tmp;
 	int idx;
+	int err = 0;
+
+	tmp = priv->data[len - 1];
+	priv->data[len - 1] = '\0';
 
 	priv->ncells = 0;
 	for (var = data + sizeof(struct brcm_nvram_header);
@@ -78,67 +134,68 @@ static int brcm_nvram_add_cells(struct brcm_nvram *priv, uint8_t *data,
 	}
 
 	priv->cells = devm_kcalloc(dev, priv->ncells, sizeof(*priv->cells), GFP_KERNEL);
-	if (!priv->cells)
-		return -ENOMEM;
+	if (!priv->cells) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	for (var = data + sizeof(struct brcm_nvram_header), idx = 0;
 	     var < (char *)data + len && *var;
 	     var = value + strlen(value) + 1, idx++) {
+		char *eq, *name;
+
 		eq = strchr(var, '=');
 		if (!eq)
 			break;
 		*eq = '\0';
+		name = devm_kstrdup(dev, var, GFP_KERNEL);
+		*eq = '=';
+		if (!name) {
+			err = -ENOMEM;
+			goto out;
+		}
 		value = eq + 1;
 
-		priv->cells[idx].name = devm_kstrdup(dev, var, GFP_KERNEL);
-		if (!priv->cells[idx].name)
-			return -ENOMEM;
+		priv->cells[idx].name = name;
 		priv->cells[idx].offset = value - (char *)data;
 		priv->cells[idx].bytes = strlen(value);
 		priv->cells[idx].np = of_get_child_by_name(dev->of_node, priv->cells[idx].name);
-		if (!strcmp(var, "et0macaddr") ||
-		    !strcmp(var, "et1macaddr") ||
-		    !strcmp(var, "et2macaddr")) {
+		if (!strcmp(name, "et0macaddr") ||
+		    !strcmp(name, "et1macaddr") ||
+		    !strcmp(name, "et2macaddr")) {
 			priv->cells[idx].raw_len = strlen(value);
 			priv->cells[idx].bytes = ETH_ALEN;
 			priv->cells[idx].read_post_process = brcm_nvram_read_post_process_macaddr;
 		}
 	}
 
-	return 0;
+out:
+	priv->data[len - 1] = tmp;
+	return err;
 }
 
 static int brcm_nvram_parse(struct brcm_nvram *priv)
 {
+	struct brcm_nvram_header *header = (struct brcm_nvram_header *)priv->data;
 	struct device *dev = priv->dev;
-	struct brcm_nvram_header header;
-	uint8_t *data;
 	size_t len;
 	int err;
 
-	memcpy_fromio(&header, priv->base, sizeof(header));
-
-	if (memcmp(header.magic, NVRAM_MAGIC, 4)) {
+	if (memcmp(header->magic, NVRAM_MAGIC, 4)) {
 		dev_err(dev, "Invalid NVRAM magic\n");
 		return -EINVAL;
 	}
 
-	len = le32_to_cpu(header.len);
-
-	data = kzalloc(len, GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	memcpy_fromio(data, priv->base, len);
-	data[len - 1] = '\0';
-
-	err = brcm_nvram_add_cells(priv, data, len);
-	if (err) {
-		dev_err(dev, "Failed to add cells: %d\n", err);
-		return err;
+	len = le32_to_cpu(header->len);
+	if (len > priv->nvmem_size) {
+		dev_err(dev, "NVRAM length (%zd) exceeds mapped size (%zd)\n", len,
+			priv->nvmem_size);
+		return -EINVAL;
 	}
 
-	kfree(data);
+	err = brcm_nvram_add_cells(priv, priv->data, len);
+	if (err)
+		dev_err(dev, "Failed to add cells: %d\n", err);
 
 	return 0;
 }
@@ -150,7 +207,6 @@ static int brcm_nvram_probe(struct platform_device *pdev)
 		.reg_read = brcm_nvram_read,
 	};
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	struct brcm_nvram *priv;
 	int err;
 
@@ -159,21 +215,19 @@ static int brcm_nvram_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	priv->dev = dev;
 
-	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
+	err = brcm_nvram_copy_data(priv, pdev);
+	if (err)
+		return err;
 
 	err = brcm_nvram_parse(priv);
 	if (err)
 		return err;
 
-	bcm47xx_nvram_init_from_iomem(priv->base, resource_size(res));
-
 	config.dev = dev;
 	config.cells = priv->cells;
 	config.ncells = priv->ncells;
 	config.priv = priv;
-	config.size = resource_size(res);
+	config.size = priv->nvmem_size;
 
 	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &config));
 }


