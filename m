Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1797D32C3
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbjJWLXe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbjJWLX0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:23:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136D610DA
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:23:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19221C433C8;
        Mon, 23 Oct 2023 11:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060196;
        bh=/S4DjT8q6h0eud3FuzLkJ7o4p41onZplSQ00NWSjBPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pRm8k6JlYAzvGa/0p4zL87xhUop+iQG5Lfw8PAs60vGcvIh3VwbjHEiqm5+8uhlvL
         DjKwxerfA7Rmg8a41mcLSsHH2u/yDztCOX++Sl6piinqkQsnY5igwDK1bGW7N8UrGj
         FSeUrJFsINgDi1PIpsVEZ8noW7fx+iHvvl5XYxKk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Thompson <davthompson@nvidia.com>,
        Asmaa Mnebhi <asmaa@nvidia.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 091/196] pwr-mlxbf: extend Kconfig to include gpio-mlxbf3 dependency
Date:   Mon, 23 Oct 2023 12:55:56 +0200
Message-ID: <20231023104831.109755639@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Thompson <davthompson@nvidia.com>

[ Upstream commit 82f07f1acf417b81e793145c167dd5e156024de4 ]

The BlueField power handling driver (pwr-mlxbf.c) provides
functionality for both BlueField-2 and BlueField-3 based
platforms.  This driver also depends on the SoC-specific
BlueField GPIO driver, whether gpio-mlxbf2 or gpio-mlxbf3.
This patch extends the Kconfig definition to include the
dependency on the gpio-mlxbf3 driver, if applicable.

Signed-off-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Asmaa Mnebhi <asmaa@nvidia.com>
Link: https://lore.kernel.org/r/20230823133743.31275-1-davthompson@nvidia.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index a8c46ba5878fe..54201f0374104 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -299,7 +299,7 @@ config NVMEM_REBOOT_MODE
 
 config POWER_MLXBF
 	tristate "Mellanox BlueField power handling driver"
-	depends on (GPIO_MLXBF2 && ACPI)
+	depends on (GPIO_MLXBF2 || GPIO_MLXBF3) && ACPI
 	help
 	  This driver supports reset or low power mode handling for Mellanox BlueField.
 
-- 
2.40.1



