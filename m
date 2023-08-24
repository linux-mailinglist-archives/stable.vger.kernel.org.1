Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74ACB7876CE
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 19:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238976AbjHXRUM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 13:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242826AbjHXRTo (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 13:19:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1926C10D7
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 10:19:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3A5067534
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 17:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE1FC433C7;
        Thu, 24 Aug 2023 17:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692897582;
        bh=n5tfex2PTR1BwOt40HyNE7poOdCGrKMGU8+TmEuuhkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sb3Ocu+KCBBxBXq5jT4ujpllrVegPA4Kl3jNa9POEUxtahlNVb9RO/L/dvU8G1BpS
         NPCp3ET4hCik58SV7pGJWDyy0A1s2GScdI2ETrQOcSPnIzlQZ3lmFH+d9F5casKTDz
         su2j+rTM6BTfw6/txFJ5wBVdfwRTu6ucHIdt+4yk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Heiner Kallweit <hkallweit1@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 061/135] mmc: core: add devm_mmc_alloc_host
Date:   Thu, 24 Aug 2023 19:08:53 +0200
Message-ID: <20230824170619.836918405@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 80df83c2c57e75cb482ccf0c639ce84703ab41a2 ]

Add a device-managed version of mmc_alloc_host().

The argument order is reversed compared to mmc_alloc_host() because
device-managed functions typically have the device argument first.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Link: https://lore.kernel.org/r/6d8f9fdc-7c9e-8e4f-e6ef-5470b971c74e@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Stable-dep-of: b8ada54fa1b8 ("mmc: meson-gx: fix deferred probing")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/host.c  | 26 ++++++++++++++++++++++++++
 include/linux/mmc/host.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 03e2f965a96a8..1f46694b2e531 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -513,6 +513,32 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 
 EXPORT_SYMBOL(mmc_alloc_host);
 
+static void devm_mmc_host_release(struct device *dev, void *res)
+{
+	mmc_free_host(*(struct mmc_host **)res);
+}
+
+struct mmc_host *devm_mmc_alloc_host(struct device *dev, int extra)
+{
+	struct mmc_host **dr, *host;
+
+	dr = devres_alloc(devm_mmc_host_release, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return ERR_PTR(-ENOMEM);
+
+	host = mmc_alloc_host(extra, dev);
+	if (IS_ERR(host)) {
+		devres_free(dr);
+		return host;
+	}
+
+	*dr = host;
+	devres_add(dev, dr);
+
+	return host;
+}
+EXPORT_SYMBOL(devm_mmc_alloc_host);
+
 static int mmc_validate_host_caps(struct mmc_host *host)
 {
 	if (host->caps & MMC_CAP_SDIO_IRQ && !host->ops->enable_sdio_irq) {
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 40d7e98fc9902..fb294cbb9081d 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -477,6 +477,7 @@ struct mmc_host {
 struct device_node;
 
 struct mmc_host *mmc_alloc_host(int extra, struct device *);
+struct mmc_host *devm_mmc_alloc_host(struct device *dev, int extra);
 int mmc_add_host(struct mmc_host *);
 void mmc_remove_host(struct mmc_host *);
 void mmc_free_host(struct mmc_host *);
-- 
2.40.1



