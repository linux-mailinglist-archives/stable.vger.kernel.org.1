Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB57B7A7DA4
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbjITMK7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235260AbjITMKz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:10:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8F3F5
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:10:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F439C433C8;
        Wed, 20 Sep 2023 12:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211844;
        bh=3f8rfw8YJuozVnbDWXuq6Q7tG5qJNOvIRB2O9s1di2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dg7ulW7zJbOClMGQByOxZ+uM0eXqsUxE9cqQ6bee64Qm/vJNsCAMO5r/EoLgEIZhs
         ANguPKB+NJ8xpiZw2he0OKi/UedaHwSOn0PULzIHBuP+6UnpsjTv7ICyqAJfGMUrlg
         fU2a3ugnr1IMTjnObBn9MPR+7sklyV5/JMEMn8Ik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 056/273] mwifiex: drop set_consistent_dma_mask log message
Date:   Wed, 20 Sep 2023 13:28:16 +0200
Message-ID: <20230920112848.165209431@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brian Norris <briannorris@chromium.org>

[ Upstream commit f7369179ad32000973fc7a0a76603e0b41792b52 ]

This message is pointless.

While we're at it, include the error code in the error message, which is
not pointless.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Stable-dep-of: 288c63d5cb46 ("wifi: mwifiex: fix error recovery in PCIE buffer descriptor management")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/pcie.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index aea79fd54c311..6712b5097bcca 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -2939,10 +2939,9 @@ static int mwifiex_init_pcie(struct mwifiex_adapter *adapter)
 
 	pci_set_master(pdev);
 
-	pr_notice("try set_consistent_dma_mask(32)\n");
 	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
 	if (ret) {
-		pr_err("set_dma_mask(32) failed\n");
+		pr_err("set_dma_mask(32) failed: %d\n", ret);
 		goto err_set_dma_mask;
 	}
 
-- 
2.40.1



