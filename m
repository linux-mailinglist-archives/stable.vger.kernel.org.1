Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132B6761721
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjGYLpN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjGYLpI (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:45:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76BD19A0
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:45:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DC6E615BA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81333C433C7;
        Tue, 25 Jul 2023 11:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285506;
        bh=skF5nD74tf3Bzz55Ixw89W9t6ya2NhtNrV7fXgyfXRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EbzocFL4WDeGZnV79+M5qQ3D0it5m9UjDCiGMZWITkkOL62n4llD/vb1r9+Db+lc7
         dlyjvYNGnNREk8RmTkZ9vxdYXE0j3uCZVVro/GQEP9mB9r3bdVYhfAU9JkFhTOmUdO
         liVmqU00PY9xvAFaXJzKxFZlWkvwbMGbgjPavEqk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 5.4 230/313] tpm: tpm_vtpm_proxy: fix a race condition in /dev/vtpmx creation
Date:   Tue, 25 Jul 2023 12:46:23 +0200
Message-ID: <20230725104530.994528379@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>

commit f4032d615f90970d6c3ac1d9c0bce3351eb4445c upstream.

/dev/vtpmx is made visible before 'workqueue' is initialized, which can
lead to a memory corruption in the worst case scenario.

Address this by initializing 'workqueue' as the very first step of the
driver initialization.

Cc: stable@vger.kernel.org
Fixes: 6f99612e2500 ("tpm: Proxy driver for supporting multiple emulated TPMs")
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm_vtpm_proxy.c |   30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -693,37 +693,21 @@ static struct miscdevice vtpmx_miscdev =
 	.fops = &vtpmx_fops,
 };
 
-static int vtpmx_init(void)
-{
-	return misc_register(&vtpmx_miscdev);
-}
-
-static void vtpmx_cleanup(void)
-{
-	misc_deregister(&vtpmx_miscdev);
-}
-
 static int __init vtpm_module_init(void)
 {
 	int rc;
 
-	rc = vtpmx_init();
-	if (rc) {
-		pr_err("couldn't create vtpmx device\n");
-		return rc;
-	}
-
 	workqueue = create_workqueue("tpm-vtpm");
 	if (!workqueue) {
 		pr_err("couldn't create workqueue\n");
-		rc = -ENOMEM;
-		goto err_vtpmx_cleanup;
+		return -ENOMEM;
 	}
 
-	return 0;
-
-err_vtpmx_cleanup:
-	vtpmx_cleanup();
+	rc = misc_register(&vtpmx_miscdev);
+	if (rc) {
+		pr_err("couldn't create vtpmx device\n");
+		destroy_workqueue(workqueue);
+	}
 
 	return rc;
 }
@@ -731,7 +715,7 @@ err_vtpmx_cleanup:
 static void __exit vtpm_module_exit(void)
 {
 	destroy_workqueue(workqueue);
-	vtpmx_cleanup();
+	misc_deregister(&vtpmx_miscdev);
 }
 
 module_init(vtpm_module_init);


