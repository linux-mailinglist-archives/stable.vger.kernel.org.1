Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAD976AEEC
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbjHAJnL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbjHAJm6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:42:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1380E5C
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:40:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0C4B6126D
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAB8C433C8;
        Tue,  1 Aug 2023 09:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882835;
        bh=xa210WyPwxKWiyvN6sIxjtQJaL0inWUD2OC29I9DK1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BfymZsIjCAYaDw4CI0S2qm578lbyX2+HxSJuYYM/RLVoIej3O9IW+PFjZIkeq+C0j
         WyuJBITCupBA3HzAWKahpRVoq3sdXOxGlRvYSIMbTQG1FU6dfS6FM9Gqingx53l24X
         Whr83AaXgO0dLxTfzOrqegLS2H2UizTTIBrNTKMA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 6.4 002/239] platform/x86/amd/pmf: reduce verbosity of apmf_get_system_params
Date:   Tue,  1 Aug 2023 11:17:46 +0200
Message-ID: <20230801091925.742518422@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
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

From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

commit 839e90e75e695b3d9ee17f5a2811e7ee5aea8d4a upstream.

apmf_get_system_params() failure is not a critical event, reduce its
verbosity from dev_err to dev_dbg.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Link: https://lore.kernel.org/r/20230714144435.1239776-1-Shyam-sundar.S-k@amd.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/amd/pmf/acpi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/platform/x86/amd/pmf/acpi.c
+++ b/drivers/platform/x86/amd/pmf/acpi.c
@@ -310,7 +310,7 @@ int apmf_acpi_init(struct amd_pmf_dev *p
 
 	ret = apmf_get_system_params(pmf_dev);
 	if (ret) {
-		dev_err(pmf_dev->dev, "APMF apmf_get_system_params failed :%d\n", ret);
+		dev_dbg(pmf_dev->dev, "APMF apmf_get_system_params failed :%d\n", ret);
 		goto out;
 	}
 


