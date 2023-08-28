Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B686178AD78
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjH1Ksc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjH1KsI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:48:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F23115
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:47:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0333364342
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1420FC433C7;
        Mon, 28 Aug 2023 10:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219678;
        bh=5N9pxPLUPsQXgN9hQi6EofFu39koGK+xP285+BQzb7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kGEltrCpWbSqdIqOFn6m5/6H829ACgurKFNGdIdlWSrCvLFKgjro0j+07uXURnq9F
         5ywyjVPjmZRRa0Qg4tsEn7vmHiqukvRE4y13COFadrCJiTkjzflgI9iFa32+GRjUUX
         MZwFe9z9IAtHCMLNp3gt/Ew9laVfGuzEljIkzHVU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ruan Jinjie <ruanjinjie@huawei.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Doug Berger <opendmb@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 32/84] net: bcmgenet: Fix return value check for fixed_phy_register()
Date:   Mon, 28 Aug 2023 12:13:49 +0200
Message-ID: <20230828101150.348431111@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101149.146126827@linuxfoundation.org>
References: <20230828101149.146126827@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ruan Jinjie <ruanjinjie@huawei.com>

[ Upstream commit 32bbe64a1386065ab2aef8ce8cae7c689d0add6e ]

The fixed_phy_register() function returns error pointers and never
returns NULL. Update the checks accordingly.

Fixes: b0ba512e25d7 ("net: bcmgenet: enable driver to work without a device tree")
Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Acked-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 99aba64f03c2f..2b0538f2af639 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -568,7 +568,7 @@ static int bcmgenet_mii_pd_init(struct bcmgenet_priv *priv)
 		};
 
 		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
-		if (!phydev || IS_ERR(phydev)) {
+		if (IS_ERR(phydev)) {
 			dev_err(kdev, "failed to register fixed PHY device\n");
 			return -ENODEV;
 		}
-- 
2.40.1



