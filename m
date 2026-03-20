Return-Path: <stable+bounces-227633-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGjWKFPCvWmEBQMAu9opvQ
	(envelope-from <stable+bounces-227633-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 22:55:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F09EC2E1855
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 22:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6CC4302002C
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137B936C5B3;
	Fri, 20 Mar 2026 21:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BACa0BFm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE852C08D4
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 21:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774043728; cv=none; b=YIFQ5BSZGHG1FPHWP5jLN7AR8Hj9JHm0I9gcWcWm2NR86TVD6FxPQG/kNqs/mhxPJUbehZh1ol/IObjvrUAy14IUiTD0f5BJezA7clw4MUyItbraOA85Qo46TzETCzf/kzDcDHG4zdx/QYnVNHqMBdPiQsb+l19FWYqE28ONkLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774043728; c=relaxed/simple;
	bh=5vEeALrjktgiaBdtbrIz1BTAhfMYtgFznRCEDYqg4jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tcfii6uYI9g9LBm0tnczsNYKSQZQ8nlrCfh1ttizMqPTG/JJ3aKqLJj/YnJg5947myFo6KxTrvYppjbwS356SZJKeC43Ht3KdpUJ3bSmd6HTjSfAUmkVdK/vbrJCULFeACjIi9SZQBSxSmxWT4CiE2PWPJO/R2k/AaSyW7E5NZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BACa0BFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4696C4CEF7;
	Fri, 20 Mar 2026 21:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774043728;
	bh=5vEeALrjktgiaBdtbrIz1BTAhfMYtgFznRCEDYqg4jI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BACa0BFmpxYL3WRHJimVwAKLoDMEE/53flNQwERVc2m3OaqaDYtPzht5fbEcn49ZD
	 6jqNd7TU3mu3V+xF94jns+lmPqehBV596KJfAIe0CdAO7PrMicghNvZ07nHKEYHFst
	 S7rh6mL1Y3k+8kYI3vVLHcdkDvmyyQ3a8Q0eqIQknx0Ec47l+afiN6N6G5Bzqfblvk
	 rHR6Jng9TMC0DsXou8xvXIbhB0xvPAHi+pvHfUg1YsYgQ4FyC6aNG/MSgLMY9TFPyL
	 lpnN+E2adByq3jhftBvpPaiTh/0BSH2C07soc9qLTH3mcD8eixNm2t58gZYANEDWRE
	 qR5YB/Faa+49w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Corentin Labbe <clabbe@baylibre.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] mtd: partitions: redboot: fix style issues
Date: Fri, 20 Mar 2026 17:55:25 -0400
Message-ID: <20260320215526.133494-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026032025-scanning-frying-8ead@gregkh>
References: <2026032025-scanning-frying-8ead@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227633-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,bootlin.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F09EC2E1855
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Corentin Labbe <clabbe@baylibre.com>

[ Upstream commit eb1765c40530ccc8690b9dad88cec6aaa6bfb498 ]

This patch fixes easy checkpatch issues.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20210520114851.1274609-2-clabbe@baylibre.com
Stable-dep-of: 8e2f8020270a ("mtd: Avoid boot crash in RedBoot partition table parser")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/parsers/redboot.c | 69 +++++++++++++++++------------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/drivers/mtd/parsers/redboot.c b/drivers/mtd/parsers/redboot.c
index 3351be6514732..3b55b676ca6b9 100644
--- a/drivers/mtd/parsers/redboot.c
+++ b/drivers/mtd/parsers/redboot.c
@@ -17,15 +17,15 @@
 #include <linux/module.h>
 
 struct fis_image_desc {
-    unsigned char name[16];      // Null terminated name
-    uint32_t	  flash_base;    // Address within FLASH of image
-    uint32_t	  mem_base;      // Address in memory where it executes
-    uint32_t	  size;          // Length of image
-    uint32_t	  entry_point;   // Execution entry point
-    uint32_t	  data_length;   // Length of actual data
-    unsigned char _pad[256-(16+7*sizeof(uint32_t))];
-    uint32_t	  desc_cksum;    // Checksum over image descriptor
-    uint32_t	  file_cksum;    // Checksum over image data
+	unsigned char name[16];      // Null terminated name
+	u32	  flash_base;    // Address within FLASH of image
+	u32	  mem_base;      // Address in memory where it executes
+	u32	  size;          // Length of image
+	u32	  entry_point;   // Execution entry point
+	u32	  data_length;   // Length of actual data
+	unsigned char _pad[256 - (16 + 7 * sizeof(u32))];
+	u32	  desc_cksum;    // Checksum over image descriptor
+	u32	  file_cksum;    // Checksum over image data
 };
 
 struct fis_list {
@@ -91,12 +91,12 @@ static int parse_redboot_partitions(struct mtd_info *master,
 
 	parse_redboot_of(master);
 
-	if ( directory < 0 ) {
+	if (directory < 0) {
 		offset = master->size + directory * master->erasesize;
 		while (mtd_block_isbad(master, offset)) {
 			if (!offset) {
-			nogood:
-				printk(KERN_NOTICE "Failed to find a non-bad block to check for RedBoot partition table\n");
+nogood:
+				pr_notice("Failed to find a non-bad block to check for RedBoot partition table\n");
 				return -EIO;
 			}
 			offset -= master->erasesize;
@@ -114,8 +114,8 @@ static int parse_redboot_partitions(struct mtd_info *master,
 	if (!buf)
 		return -ENOMEM;
 
-	printk(KERN_NOTICE "Searching for RedBoot partition table in %s at offset 0x%lx\n",
-	       master->name, offset);
+	pr_notice("Searching for RedBoot partition table in %s at offset 0x%lx\n",
+		  master->name, offset);
 
 	ret = mtd_read(master, offset, master->erasesize, &retlen,
 		       (void *)buf);
@@ -151,14 +151,13 @@ static int parse_redboot_partitions(struct mtd_info *master,
 			     && swab32(buf[i].size) < master->erasesize)) {
 				int j;
 				/* Update numslots based on actual FIS directory size */
-				numslots = swab32(buf[i].size) / sizeof (struct fis_image_desc);
+				numslots = swab32(buf[i].size) / sizeof(struct fis_image_desc);
 				for (j = 0; j < numslots; ++j) {
-
 					/* A single 0xff denotes a deleted entry.
 					 * Two of them in a row is the end of the table.
 					 */
 					if (buf[j].name[0] == 0xff) {
-				  		if (buf[j].name[1] == 0xff) {
+						if (buf[j].name[1] == 0xff) {
 							break;
 						} else {
 							continue;
@@ -185,8 +184,8 @@ static int parse_redboot_partitions(struct mtd_info *master,
 	}
 	if (i == numslots) {
 		/* Didn't find it */
-		printk(KERN_NOTICE "No RedBoot partition table detected in %s\n",
-		       master->name);
+		pr_notice("No RedBoot partition table detected in %s\n",
+			  master->name);
 		ret = 0;
 		goto out;
 	}
@@ -205,7 +204,7 @@ static int parse_redboot_partitions(struct mtd_info *master,
 			break;
 
 		new_fl = kmalloc(sizeof(struct fis_list), GFP_KERNEL);
-		namelen += strlen(buf[i].name)+1;
+		namelen += strlen(buf[i].name) + 1;
 		if (!new_fl) {
 			ret = -ENOMEM;
 			goto out;
@@ -214,13 +213,13 @@ static int parse_redboot_partitions(struct mtd_info *master,
 		if (data && data->origin)
 			buf[i].flash_base -= data->origin;
 		else
-			buf[i].flash_base &= master->size-1;
+			buf[i].flash_base &= master->size - 1;
 
 		/* I'm sure the JFFS2 code has done me permanent damage.
 		 * I now think the following is _normal_
 		 */
 		prev = &fl;
-		while(*prev && (*prev)->img->flash_base < new_fl->img->flash_base)
+		while (*prev && (*prev)->img->flash_base < new_fl->img->flash_base)
 			prev = &(*prev)->next;
 		new_fl->next = *prev;
 		*prev = new_fl;
@@ -240,7 +239,7 @@ static int parse_redboot_partitions(struct mtd_info *master,
 		}
 	}
 #endif
-	parts = kzalloc(sizeof(*parts)*nrparts + nulllen + namelen, GFP_KERNEL);
+	parts = kzalloc(sizeof(*parts) * nrparts + nulllen + namelen, GFP_KERNEL);
 
 	if (!parts) {
 		ret = -ENOMEM;
@@ -249,23 +248,22 @@ static int parse_redboot_partitions(struct mtd_info *master,
 
 	nullname = (char *)&parts[nrparts];
 #ifdef CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED
-	if (nulllen > 0) {
+	if (nulllen > 0)
 		strcpy(nullname, nullstring);
-	}
 #endif
 	names = nullname + nulllen;
 
-	i=0;
+	i = 0;
 
 #ifdef CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED
 	if (fl->img->flash_base) {
-	       parts[0].name = nullname;
-	       parts[0].size = fl->img->flash_base;
-	       parts[0].offset = 0;
+		parts[0].name = nullname;
+		parts[0].size = fl->img->flash_base;
+		parts[0].offset = 0;
 		i++;
 	}
 #endif
-	for ( ; i<nrparts; i++) {
+	for ( ; i < nrparts; i++) {
 		parts[i].size = fl->img->size;
 		parts[i].offset = fl->img->flash_base;
 		parts[i].name = names;
@@ -273,17 +271,17 @@ static int parse_redboot_partitions(struct mtd_info *master,
 		strcpy(names, fl->img->name);
 #ifdef CONFIG_MTD_REDBOOT_PARTS_READONLY
 		if (!memcmp(names, "RedBoot", 8) ||
-				!memcmp(names, "RedBoot config", 15) ||
-				!memcmp(names, "FIS directory", 14)) {
+		    !memcmp(names, "RedBoot config", 15) ||
+		    !memcmp(names, "FIS directory", 14)) {
 			parts[i].mask_flags = MTD_WRITEABLE;
 		}
 #endif
-		names += strlen(names)+1;
+		names += strlen(names) + 1;
 
 #ifdef CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED
-		if(fl->next && fl->img->flash_base + fl->img->size + master->erasesize <= fl->next->img->flash_base) {
+		if (fl->next && fl->img->flash_base + fl->img->size + master->erasesize <= fl->next->img->flash_base) {
 			i++;
-			parts[i].offset = parts[i-1].size + parts[i-1].offset;
+			parts[i].offset = parts[i - 1].size + parts[i - 1].offset;
 			parts[i].size = fl->next->img->flash_base - parts[i].offset;
 			parts[i].name = nullname;
 		}
@@ -297,6 +295,7 @@ static int parse_redboot_partitions(struct mtd_info *master,
  out:
 	while (fl) {
 		struct fis_list *old = fl;
+
 		fl = fl->next;
 		kfree(old);
 	}
-- 
2.51.0


