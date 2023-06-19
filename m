Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BA97354E6
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjFSK7i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjFSK7O (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:59:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2361738
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:58:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A65F60B8D
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D891C433C8;
        Mon, 19 Jun 2023 10:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172291;
        bh=JtvoY6/oALQcjZPcw1kKEBD80K+TBPqLvWOnnsP8LhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XtL2f8I2HXh9A+ibpvKpxwN1ZHwtAW2PVdnoZ9eWwfqIvOpviO5W9KsXZD5An7YJ5
         ieJ0alRrR5aGr5naKU3g/dGwKuUIMZoUXQ3PqybLDCo+Hmf+UNQE9GnoD4o/OMlF7i
         SVZCe1o6wdBUYxJxyK/uzfJBiq5Vtg45MOs9J46k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 016/107] regulator: Fix error checking for debugfs_create_dir
Date:   Mon, 19 Jun 2023 12:30:00 +0200
Message-ID: <20230619102142.309411213@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102141.541044823@linuxfoundation.org>
References: <20230619102141.541044823@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Osama Muhammad <osmtendev@gmail.com>

[ Upstream commit 2bf1c45be3b8f3a3f898d0756c1282f09719debd ]

This patch fixes the error checking in core.c in debugfs_create_dir.
The correct way to check if an error occurred is 'IS_ERR' inline function.

Signed-off-by: Osama Muhammad <osmtendev@gmail.com
Suggested-by: Ivan Orlov <ivan.orlov0322@gmail.com
Link: https://lore.kernel.org/r/20230515172938.13338-1-osmtendev@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 9ddb80d10dee3..211ab227b000c 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5193,7 +5193,7 @@ static void rdev_init_debugfs(struct regulator_dev *rdev)
 	}
 
 	rdev->debugfs = debugfs_create_dir(rname, debugfs_root);
-	if (!rdev->debugfs) {
+	if (IS_ERR(rdev->debugfs)) {
 		rdev_warn(rdev, "Failed to create debugfs directory\n");
 		return;
 	}
@@ -6103,7 +6103,7 @@ static int __init regulator_init(void)
 	ret = class_register(&regulator_class);
 
 	debugfs_root = debugfs_create_dir("regulator", NULL);
-	if (!debugfs_root)
+	if (IS_ERR(debugfs_root))
 		pr_warn("regulator: Failed to create debugfs directory\n");
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.39.2



