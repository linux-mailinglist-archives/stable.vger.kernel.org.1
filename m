Return-Path: <stable+bounces-3663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F868800E9E
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 16:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F4F281AE3
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 15:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9494AF6C;
	Fri,  1 Dec 2023 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="gxNGJ2je"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C88198
	for <stable@vger.kernel.org>; Fri,  1 Dec 2023 07:31:48 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40b4e35ecf1so21331795e9.1
        for <stable@vger.kernel.org>; Fri, 01 Dec 2023 07:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1701444706; x=1702049506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zrDqyx6agu66CFsaEwAwGPFt5h6we10bOzm7YE4XX+0=;
        b=gxNGJ2jeuQGtb1QsJNITbFf+iT3QGZAmiMpR9SqfX5Wr7+Jcb5dSpHE/2YFUv5+ikx
         3AJAVFGpuDmiSPIWSNkDWF39estfYTg9jwGvy1OZDDbqOXIwqZA7fnWMhFmxyYqTE+W/
         XCmSvwEYH6oZWB4uZb1rXLmgXAV8++KVLMdoyTOCUXcFdwwhWP3K1hii3yWZl1Q9EGjf
         rLUiwwYCPW6Om2jfV0iZE29/tSBoeyR7PGRFpeLjdA8arORSBrdCyShfCBC4T821UYQ0
         RS3ZHP9VFFwFPbRyQK8+75CCqubs1deteehyrhSSo3mlxRx0/KSnY1/e8wGABSBdTBwj
         AOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701444706; x=1702049506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zrDqyx6agu66CFsaEwAwGPFt5h6we10bOzm7YE4XX+0=;
        b=kfT4/ntn/SeyYJEneSIXVB5AL22FX6e3sWVpmcvvp908BjBhp+uCzG8hHZ78zcyoSI
         klDgEuz7UoYMxWF965XViBdUBZjHOh6u1TRF6z9midzuZCfTvG9MHsYOc+xEYfwIhuk/
         Ud500vlLPa6QRW3PQXo4nNB7ckOwreDNhy6I9LfeE86MrlByfNMR4ilsnVa0u0vr6RSW
         UL0a3hbp4MG0UIfTvHbwRGGk7K++olewEZ9nGBAA2Gk4CxgfDheC2Tc7N2W2xjQ7+kQ0
         HwkVn3PewJ4YDiFRPclXsVNGblkAbe2UBt2dzGpBOpI5/GEkFrdX/GvyroeeWCBKz4bm
         hj+A==
X-Gm-Message-State: AOJu0YwjEkFbZKu6ieBKE8C3Xh++6glizwLVPzLlZzRushlMnXxuJrNJ
	mV4RhSyEk2fLp55S8CVERiRs/016K3U/0vOYBwA=
X-Google-Smtp-Source: AGHT+IF4yZefDhQfkn3bHpMubMuak5XxvCL7T38seWdW+e8Eg9jNLWcrCT1ET5ZnEZ3m4aGk9V5qkA==
X-Received: by 2002:a05:600c:468f:b0:40b:5e59:99ca with SMTP id p15-20020a05600c468f00b0040b5e5999camr346457wmo.234.1701444706433;
        Fri, 01 Dec 2023 07:31:46 -0800 (PST)
Received: from trax.. (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id l5-20020adffe85000000b0033331b248acsm1771415wrr.91.2023.12.01.07.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:31:45 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge@foundries.io>
To: jorge@foundries.io,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCHv4] mmc: rpmb: fixes pause retune on all RPMB partitions.
Date: Fri,  1 Dec 2023 16:31:43 +0100
Message-Id: <20231201153143.1449753-1-jorge@foundries.io>
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
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Cc: <stable@vger.kernel.org> # v4.14+
---

  v2:
     fixes parenthesis around condition
  v3:
     adds stable to commit header
  v4:
     fixes the stable version to v4.14
     adds Reviewed-by

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

