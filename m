Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A387ED502
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344750AbjKOU7u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344658AbjKOU6Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:58:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198261FFF
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD47C433CD;
        Wed, 15 Nov 2023 20:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081870;
        bh=YXJmFzibi2jvnzkucAF8Y5tbRS2ZTNxacQfzjF3NbW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pn0Mn10I8CxqbP/Eswpfm+dQ/No2wUWZKZPvsZOhgHhJIkfJrIM8GMrLab6sMGIHY
         /vxKDsUSLTjNeMx7uLC1OBeivd+Rs4Nx27lG/76Ev9nOHL+SVI0KVNbESz33rBkm5q
         BSsfkkySOxmNe8kyYOE9wd74w8MG2eXfQxfOIzS8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, George Shuklin <george.shuklin@gmail.com>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 177/191] tg3: power down device only on SYSTEM_POWER_OFF
Date:   Wed, 15 Nov 2023 15:47:32 -0500
Message-ID: <20231115204655.058385730@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index d14f37be1eb3e..5647833303a44 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -18156,7 +18156,8 @@ static void tg3_shutdown(struct pci_dev *pdev)
 	if (netif_running(dev))
 		dev_close(dev);
 
-	tg3_power_down(tp);
+	if (system_state == SYSTEM_POWER_OFF)
+		tg3_power_down(tp);
 
 	rtnl_unlock();
 
-- 
2.42.0



