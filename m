Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADA674D81E
	for <lists+stable@lfdr.de>; Mon, 10 Jul 2023 15:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjGJNr4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 10 Jul 2023 09:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbjGJNru (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 10 Jul 2023 09:47:50 -0400
X-Greylist: delayed 515 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Jul 2023 06:47:41 PDT
Received: from mx.mylinuxtime.de (mx.mylinuxtime.de [195.201.174.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD7A184
        for <stable@vger.kernel.org>; Mon, 10 Jul 2023 06:47:41 -0700 (PDT)
Received: from leda.eworm.de (unknown [194.36.25.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id 3E95323469F;
        Mon, 10 Jul 2023 15:39:05 +0200 (CEST)
Received: by leda.eworm.de (Postfix, from userid 1000)
        id 1AB3D1814B5; Mon, 10 Jul 2023 15:39:05 +0200 (CEST)
From:   Christian Hesse <mail@eworm.de>
To:     linux-integrity@vger.kernel.org
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Peter Huewe <peterhuewe@gmx.de>,
        Christian Hesse <mail@eworm.de>, stable@vger.kernel.org,
        roubro1991@gmail.com
Subject: [PATCH 2/2] tpm/tpm_tis: Disable interrupts for Framework Laptop Intel 13th gen
Date:   Mon, 10 Jul 2023 15:38:36 +0200
Message-ID: <20230710133836.4367-2-mail@eworm.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710133836.4367-1-mail@eworm.de>
References: <c0ee4b7c-9d63-0bb3-c677-2be045deda43@leemhuis.info>
 <20230710133836.4367-1-mail@eworm.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This device suffer an irq storm, so add it in tpm_tis_dmi_table to
force polling.

https://bugs.archlinux.org/user/38129
https://bugzilla.kernel.org/show_bug.cgi?id=217631

Fixes: e644b2f498d297a928efcb7ff6f900c27f8b788e
Cc: stable@vger.kernel.org
Reported-by:  <roubro1991@gmail.com>
Signed-off-by: Christian Hesse <mail@eworm.de>
---
 drivers/char/tpm/tpm_tis.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 2979f8b9aaa0..a8bcd2134e6b 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -122,6 +122,14 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "A4"),
 		},
 	},
+	{
+		.callback = tpm_tis_disable_irq,
+		.ident = "Framework Laptop Intel 13th gen",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Framework"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "A6"),
+		},
+	},
 	{
 		.callback = tpm_tis_disable_irq,
 		.ident = "ThinkPad T490s",
-- 
2.41.0

