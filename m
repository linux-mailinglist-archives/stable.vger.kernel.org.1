Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5227353F4
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjFSKub (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbjFSKuK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:50:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F38B10E6
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:49:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD6C360B9C
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CB7C433C9;
        Mon, 19 Jun 2023 10:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171776;
        bh=Jymx44z1iSgD3yMJLBhiJFfnCFgTfXcvMi/u8kKELJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MwjuAS1MeOei/6IT+PyYw4NJ18aCQmI/MR6AmJp32TrBxFC8pTTG5Y/mFE5AbOqdf
         F290zui3CdbWrW7j9+yqS8ByNXjIG0nhy+uD6nSoW8MoouQuFB//TgiwX91OkyG73L
         waWUi5B5CT+p5GxNZbRDYkcPw3sKY33CsiUVAtSw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 153/166] octeon_ep: Add missing check for ioremap
Date:   Mon, 19 Jun 2023 12:30:30 +0200
Message-ID: <20230619102202.109872619@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

[ Upstream commit 9a36e2d44d122fe73a2a76ba73f1d50a65cf8210 ]

Add check for ioremap() and return the error if it fails in order to
guarantee the success of ioremap().

Fixes: 862cd659a6fb ("octeon_ep: Add driver framework and device initialization")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Link: https://lore.kernel.org/r/20230615033400.2971-1-jiasheng@iscas.ac.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index b45dd7f04e213..8979dd05e873f 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -928,6 +928,9 @@ int octep_device_setup(struct octep_device *oct)
 		oct->mmio[i].hw_addr =
 			ioremap(pci_resource_start(oct->pdev, i * 2),
 				pci_resource_len(oct->pdev, i * 2));
+		if (!oct->mmio[i].hw_addr)
+			goto unmap_prev;
+
 		oct->mmio[i].mapped = 1;
 	}
 
@@ -966,7 +969,9 @@ int octep_device_setup(struct octep_device *oct)
 	return 0;
 
 unsupported_dev:
-	for (i = 0; i < OCTEP_MMIO_REGIONS; i++)
+	i = OCTEP_MMIO_REGIONS;
+unmap_prev:
+	while (i--)
 		iounmap(oct->mmio[i].hw_addr);
 
 	kfree(oct->conf);
-- 
2.39.2



