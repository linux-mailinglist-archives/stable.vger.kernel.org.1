Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD1275CDDD
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjGUQPY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjGUQPG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:15:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C428235B3
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:14:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A60E161D1D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F8AC433C8;
        Fri, 21 Jul 2023 16:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956073;
        bh=aa132c76rgGwJeCICOTy2cSkhP+lUjWtuRS0QAIa8Z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1wNy8WV407+MH5tB8keGvcM5rfEDj25NUIHPqBiQZebYe85c29TL4UNt3bo5ltNai
         V+8ZPkylDRca0smbxoX5n5/35y2FaqzRiMlFyXUzHIQky/7xsp0ZV4xE+sL3ufa+jF
         A696+sZk1+Ctr/j1h7wjSeOhoNhF+miJtyMYdsMc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Valentin David <valentin.david@gmail.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 6.4 123/292] tpm: Do not remap from ACPI resources again for Pluton TPM
Date:   Fri, 21 Jul 2023 18:03:52 +0200
Message-ID: <20230721160534.108155637@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Valentin David <valentin.david@gmail.com>

commit b1c1b98962d17a922989aa3b2822946bbb5c091f upstream.

For Pluton TPM devices, it was assumed that there was no ACPI memory
regions. This is not true for ASUS ROG Ally. ACPI advertises
0xfd500000-0xfd5fffff.

Since remapping is already done in `crb_map_pluton`, remapping again
in `crb_map_io` causes EBUSY error:

[    3.510453] tpm_crb MSFT0101:00: can't request region for resource [mem 0xfd500000-0xfd5fffff]
[    3.510463] tpm_crb: probe of MSFT0101:00 failed with error -16

Cc: stable@vger.kernel.org # v6.3+
Fixes: 4d2732882703 ("tpm_crb: Add support for CRB devices based on Pluton")
Signed-off-by: Valentin David <valentin.david@gmail.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm_crb.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -563,15 +563,18 @@ static int crb_map_io(struct acpi_device
 	u32 rsp_size;
 	int ret;
 
-	INIT_LIST_HEAD(&acpi_resource_list);
-	ret = acpi_dev_get_resources(device, &acpi_resource_list,
-				     crb_check_resource, iores_array);
-	if (ret < 0)
-		return ret;
-	acpi_dev_free_resource_list(&acpi_resource_list);
-
-	/* Pluton doesn't appear to define ACPI memory regions */
+	/*
+	 * Pluton sometimes does not define ACPI memory regions.
+	 * Mapping is then done in crb_map_pluton
+	 */
 	if (priv->sm != ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON) {
+		INIT_LIST_HEAD(&acpi_resource_list);
+		ret = acpi_dev_get_resources(device, &acpi_resource_list,
+					     crb_check_resource, iores_array);
+		if (ret < 0)
+			return ret;
+		acpi_dev_free_resource_list(&acpi_resource_list);
+
 		if (resource_type(iores_array) != IORESOURCE_MEM) {
 			dev_err(dev, FW_BUG "TPM2 ACPI table does not define a memory resource\n");
 			return -EINVAL;


