Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0B37554DD
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjGPUez (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjGPUey (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:34:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A61D9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:34:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6D2460EBF
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73AEC433C8;
        Sun, 16 Jul 2023 20:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539692;
        bh=S9fi49NQ3VZL7QCRW8FMlgkIywx+AR81l2d2frMOVRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZGpokA2GdQi4qAq9vau9cAOpI0YYJQH+wiQU/W1XntSyZ6mW5roQo/brzKIltYsxH
         qLOB256GyxCyyVSBU2iTC2fz070k+iFnvJ8vj/JxWgZFyFMcezhW8X6xlaX0MiHkwa
         xy/pBSKqq7MmQdpV5n6q6SGgQRM+fNDBnZ77LhVI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marek Vasut <marex@denx.de>,
        Simon Horman <simon.horman@corigine.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 097/591] wifi: rsi: Do not set MMC_PM_KEEP_POWER in shutdown
Date:   Sun, 16 Jul 2023 21:43:56 +0200
Message-ID: <20230716194926.388074506@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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

From: Marek Vasut <marex@denx.de>

[ Upstream commit e74f562328b03fbe9cf438f958464dff3a644dfc ]

It makes no sense to set MMC_PM_KEEP_POWER in shutdown. The flag
indicates to the MMC subsystem to keep the slot powered on during
suspend, but in shutdown the slot should actually be powered off.
Drop this call.

Fixes: 063848c3e155 ("rsi: sdio: Add WOWLAN support for S5 shutdown state")
Signed-off-by: Marek Vasut <marex@denx.de>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230527222859.273768-1-marex@denx.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/rsi/rsi_91x_sdio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_sdio.c b/drivers/net/wireless/rsi/rsi_91x_sdio.c
index 6e33a2563fdbd..1911fef3bbad6 100644
--- a/drivers/net/wireless/rsi/rsi_91x_sdio.c
+++ b/drivers/net/wireless/rsi/rsi_91x_sdio.c
@@ -1479,9 +1479,6 @@ static void rsi_shutdown(struct device *dev)
 	if (sdev->write_fail)
 		rsi_dbg(INFO_ZONE, "###### Device is not ready #######\n");
 
-	if (rsi_set_sdio_pm_caps(adapter))
-		rsi_dbg(INFO_ZONE, "Setting power management caps failed\n");
-
 	rsi_dbg(INFO_ZONE, "***** RSI module shut down *****\n");
 }
 
-- 
2.39.2



