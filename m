Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A74B7ED38A
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbjKOUxU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbjKOUxT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:53:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0A7B0
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:53:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A62C4E778;
        Wed, 15 Nov 2023 20:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081596;
        bh=wh5SG6xsgFWgoCHZRMO4DTOMygNMLNmrKaBFjYyBjt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AVPuQ0haT53aAuv923MBeekwQ8NwJ76gh6itfeFmwZwJFxyaguk8kSDNv0Mq0+KZv
         SxC9rU1eEqonbn067sxn4xT272hsafs/vdoa0cTBQsye44a3PXtY+/tYuUFK4ETHKY
         xbIfRusRp6kLca3Y7x1blSdAgnQMD64M64i7dTOE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, George Shuklin <george.shuklin@gmail.com>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 228/244] tg3: power down device only on SYSTEM_POWER_OFF
Date:   Wed, 15 Nov 2023 15:37:00 -0500
Message-ID: <20231115203602.032775439@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: George Shuklin <george.shuklin@gmail.com>

[ Upstream commit 9fc3bc7643341dc5be7d269f3d3dbe441d8d7ac3 ]

Dell R650xs servers hangs on reboot if tg3 driver calls
tg3_power_down.

This happens only if network adapters (BCM5720 for R650xs) were
initialized using SNP (e.g. by booting ipxe.efi).

The actual problem is on Dell side, but this fix allows servers
to come back alive after reboot.

Signed-off-by: George Shuklin <george.shuklin@gmail.com>
Fixes: 2ca1c94ce0b6 ("tg3: Disable tg3 device on system reboot to avoid triggering AER")
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Link: https://lore.kernel.org/r/20231103115029.83273-1-george.shuklin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/tg3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 70b1a855273e4..2c41852a082bb 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -18088,7 +18088,8 @@ static void tg3_shutdown(struct pci_dev *pdev)
 	if (netif_running(dev))
 		dev_close(dev);
 
-	tg3_power_down(tp);
+	if (system_state == SYSTEM_POWER_OFF)
+		tg3_power_down(tp);
 
 	rtnl_unlock();
 
-- 
2.42.0



