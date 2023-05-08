Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036F96FAED4
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbjEHLsP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbjEHLsG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:48:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03B844BD4
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:47:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CF3863A4F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:47:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0CFC433D2;
        Mon,  8 May 2023 11:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546472;
        bh=0KXPJlpZ8vVe3/ElnRYE483uEUtFbCe+ZJ/HRT38QMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KePWdg/Jx7RkpdClm3vdJcVbPUACy0+pD++z5UmZAbDCa2hpgdciZtU0bDXRm6xG4
         A9RNEvT8L7EHCq3VBKq1UFSmmhkfBQQbN5LcqDgu0H36apWtcGZ83sVyYcj6arQNJA
         Ol52ZV2Cx3ZPhDyxzTomfk4FxDBXztMtReFYXrMU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.15 352/371] mtd: core: fix error path for nvmem provider
Date:   Mon,  8 May 2023 11:49:13 +0200
Message-Id: <20230508094826.111367934@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Michael Walle <michael@walle.cc>

commit e0489f6e221f5ddee6cb3bd51b992b790c5fa4b9 upstream.

If mtd_otp_nvmem_add() fails, the partitions won't be removed
because there is simply no call to del_mtd_partitions().
Unfortunately, add_mtd_partitions() will print all partitions to
the kernel console. If mtd_otp_nvmem_add() returns -EPROBE_DEFER
this would print the partitions multiple times to the kernel
console. Instead move mtd_otp_nvmem_add() to the beginning of the
function.

Fixes: 4b361cfa8624 ("mtd: core: add OTP nvmem provider support")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20230308082021.870459-3-michael@walle.cc
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/mtdcore.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -964,10 +964,14 @@ int mtd_device_parse_register(struct mtd
 
 	mtd_set_dev_defaults(mtd);
 
+	ret = mtd_otp_nvmem_add(mtd);
+	if (ret)
+		goto out;
+
 	if (IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER)) {
 		ret = add_mtd_device(mtd);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	/* Prefer parsed partitions over driver-provided fallback */
@@ -1002,9 +1006,12 @@ int mtd_device_parse_register(struct mtd
 		register_reboot_notifier(&mtd->reboot_notifier);
 	}
 
-	ret = mtd_otp_nvmem_add(mtd);
-
 out:
+	if (ret) {
+		nvmem_unregister(mtd->otp_user_nvmem);
+		nvmem_unregister(mtd->otp_factory_nvmem);
+	}
+
 	if (ret && device_is_registered(&mtd->dev))
 		del_mtd_device(mtd);
 


