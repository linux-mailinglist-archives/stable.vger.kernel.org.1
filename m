Return-Path: <stable+bounces-3613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBF280079D
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 10:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9A34B21160
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 09:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42671F614;
	Fri,  1 Dec 2023 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="GGFpYQ25"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4590B2
	for <stable@vger.kernel.org>; Fri,  1 Dec 2023 01:56:13 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b4e35ecf1so17914385e9.1
        for <stable@vger.kernel.org>; Fri, 01 Dec 2023 01:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1701424572; x=1702029372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=imgzYGiqQhIIN9pgZ0mud47x5443YmKclZtZpKeB2ec=;
        b=GGFpYQ25N72u8lCbtYsLxrIiSTXFWvgnp4ewKQNg1p+Z8/II5IcafVWofDjrRRr3cY
         Cr0aaKGYvro+psN8Hfw9LeUOPWPHHXTo6Hm+l8zel77Da8EobdIPPSAmDzH6qiAbhRim
         8kU2r4cNKkCIJbOd8ZfuL/0dRiDOg695Unz0s9NwVGTgOrtv1f/wHOiG9Ktl9TQwv7ma
         N1LcHn/sf1UjHuowtq7Q1Px3qbMZHOzKVHQxI7ZrfSxREuhlQxnTY2qMCPUXlL95v7Kg
         iAtWJUPplgnxCJZFJ8LcdU/kUHlIctcnPSkxNqhFjylDprJDGhWnXJBHtcx1uX/UifbC
         2iuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701424572; x=1702029372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=imgzYGiqQhIIN9pgZ0mud47x5443YmKclZtZpKeB2ec=;
        b=Fm98EqY6eGcZhEdJpMrKbp984b37l9xOH4VXMQ3QqSmpsRneZYlgzWfRm4G9XzCXRn
         Su3G5VZUBHTR2WofR0MnQJL7LSZrxk06n/LJOxlv7PK2RN49qpFYhqg4gaVEugaYeF27
         oX3dfR9vehYV0z2dxoLBcadken20ZNJ/bSM8IDV3UN8sxaUZ59+4RnYcmkd/Nkh5Va13
         tBU2PCPLeSV6u1JLDmGw+aJ/8ETgeXDGsG9ld1gE0AD0uRWHwrjbLI+Fb1aTPivg1aDN
         sg3TMK9IxVeHjgTUL6ZXcaz2ijLQ749ei9iTOrrO6mwvKUdijV/9lvlwsXNfjefI51iQ
         mzsQ==
X-Gm-Message-State: AOJu0YyTQMwNfG8tTMCqoiwy9WmhjkttpE9IhgnwZsDs32KCuSoKke2H
	IHg9tl10vgJNaLHniNWpLIgSSw==
X-Google-Smtp-Source: AGHT+IFnbhz99eZMpManLr6PpXpUYiNXssmncvB7WIe5Pd7fQ9Q9gc+blj35njaOP99Xp0fGTyYNEQ==
X-Received: by 2002:a05:600c:1f91:b0:40b:5433:17ef with SMTP id je17-20020a05600c1f9100b0040b543317efmr196223wmb.30.1701424572074;
        Fri, 01 Dec 2023 01:56:12 -0800 (PST)
Received: from trax.. (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id h7-20020adf9cc7000000b0032d8eecf901sm3802982wre.3.2023.12.01.01.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:56:11 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge@foundries.io>
To: jorge@foundries.io,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org
Cc: adrian.hunter@intel.com,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCHv2] mmc: rpmb: fixes pause retune on all RPMB partitions.
Date: Fri,  1 Dec 2023 10:56:08 +0100
Message-Id: <20231201095608.1022191-1-jorge@foundries.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When RPMB was converted to a character device, it added support for
multiple RPMB partitions (Commit 97548575bef3 ("mmc: block: Convert RPMB
to a character device").

One of the changes in this commit was transforming the variable
target_part defined in __mmc_blk_ioctl_cmd into a bitmask.

This inadvertedly regressed the validation check done in
mmc_blk_part_switch_pre() and mmc_blk_part_switch_post().

This commit fixes that regression.

Fixes: 97548575bef3 ("mmc: block: Convert RPMB to a character device")
Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
---
 drivers/mmc/core/block.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 152dfe593c43..13093d26bf81 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -851,9 +851,10 @@ static const struct block_device_operations mmc_bdops = {
 static int mmc_blk_part_switch_pre(struct mmc_card *card,
 				   unsigned int part_type)
 {
+	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_RPMB;
 	int ret = 0;

-	if (part_type == EXT_CSD_PART_CONFIG_ACC_RPMB) {
+	if ((part_type & mask) == mask) {
 		if (card->ext_csd.cmdq_en) {
 			ret = mmc_cmdq_disable(card);
 			if (ret)
@@ -868,9 +869,10 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
 static int mmc_blk_part_switch_post(struct mmc_card *card,
 				    unsigned int part_type)
 {
+	const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_RPMB;
 	int ret = 0;

-	if (part_type == EXT_CSD_PART_CONFIG_ACC_RPMB) {
+	if ((part_type & mask) == mask) {
 		mmc_retune_unpause(card->host);
 		if (card->reenable_cmdq && !card->ext_csd.cmdq_en)
 			ret = mmc_cmdq_enable(card);
@@ -3143,4 +3145,3 @@ module_exit(mmc_blk_exit);

 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Multimedia Card (MMC) block device driver");
-
--
2.34.1

