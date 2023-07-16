Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C045175516A
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjGPT4H (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjGPT4G (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:56:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3E81BE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:56:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70B1C60EB3
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:56:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D865C433C7;
        Sun, 16 Jul 2023 19:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537364;
        bh=T38FeZHYSNvQMkHbWn3tgc6mZbuqYH+D3VQkC6USiMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c+/tQ0BUV2iBK7jEqA5lNZmgfQyY6gB+PwAXxkg0S9z1cikn1TenixhYxHorMiSLy
         5gNCJL+K3f0NK/xAYLtBCOX0gBtnBaG/lQE5r9AmOqUbQAuLhx5s04BkcSmabNgSXK
         9dPIlPCtS90mbrJzHk4DCqTx3pfammd4OMv5MHX0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Yang <leoyang.li@nxp.com>,
        Tony Luck <tony.luck@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 070/800] APEI: GHES: correctly return NULL for ghes_get_devices()
Date:   Sun, 16 Jul 2023 21:38:43 +0200
Message-ID: <20230716194950.726607201@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Li Yang <leoyang.li@nxp.com>

[ Upstream commit 9368aa1882ac7178adcd936cee5f0899dbf76dc4 ]

Since 315bada690e0 ("EDAC: Check for GHES preference in the
chipset-specific EDAC drivers"), vendor specific EDAC driver will not
probe correctly when CONFIG_ACPI_APEI_GHES is enabled but no GHES device
is present.  Make ghes_get_devices() return NULL when the GHES device
list is empty to fix the problem.

Fixes: 9057a3f7ac36 ("EDAC/ghes: Prepare to make ghes_edac a proper module")
Signed-off-by: Li Yang <leoyang.li@nxp.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/apei/ghes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 34ad071a64e96..4382fe13ee3e4 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1544,6 +1544,8 @@ struct list_head *ghes_get_devices(void)
 
 			pr_warn_once("Force-loading ghes_edac on an unsupported platform. You're on your own!\n");
 		}
+	} else if (list_empty(&ghes_devs)) {
+		return NULL;
 	}
 
 	return &ghes_devs;
-- 
2.39.2



