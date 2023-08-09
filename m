Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF618775B82
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjHILSP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjHILSO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:18:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38151FA
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:18:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC62A6318B
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAE8C433C8;
        Wed,  9 Aug 2023 11:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579893;
        bh=h3eCyERTzNdjXRZTxvGHXInrl1OBWlykxQMqCXbe1v0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=azkcAwagK8N0y/kNC+SqMDL0zQz7gv2ymgQPmNLtlzQgMmlCLuXS+CbjtbvZLxA+0
         JN4msi4XBNX8pc+xdiPvOgnCm4UfkHhsC3eNdQ70/rwd1okptwpsB0cxFXHXPusUOn
         oN4w5gGFq9o63jy6SzHqHx+ZoX6IxcfCcN4JXZb8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 4.19 153/323] tpm: tpm_vtpm_proxy: fix a race condition in /dev/vtpmx creation
Date:   Wed,  9 Aug 2023 12:39:51 +0200
Message-ID: <20230809103705.164656827@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
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
@@ -700,37 +700,21 @@ static struct miscdevice vtpmx_miscdev =
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
@@ -738,7 +722,7 @@ err_vtpmx_cleanup:
 static void __exit vtpm_module_exit(void)
 {
 	destroy_workqueue(workqueue);
-	vtpmx_cleanup();
+	misc_deregister(&vtpmx_miscdev);
 }
 
 module_init(vtpm_module_init);


