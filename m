Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7B2749A59
	for <lists+stable@lfdr.de>; Thu,  6 Jul 2023 13:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjGFLNx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 6 Jul 2023 07:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjGFLNw (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 6 Jul 2023 07:13:52 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB65131;
        Thu,  6 Jul 2023 04:13:50 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fb7b2e3dacso756555e87.0;
        Thu, 06 Jul 2023 04:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688642029; x=1691234029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=csDOZ6a1voCOJNBiSlT7Iqwi91gjcwEx7uBOQUBJAmA=;
        b=dpSxcvnzqbsIlXFbEGCXyLSHvMKo/dOm8+sUll7jcmtrCvBiEBTv8Luk8iz8NIqEgo
         D7OHQjTwZSbrsFbJlF6IJJRfWAURIC+t/yY3ks8Mw6MYkJWTioZF2hazFsFcJYlQyHiD
         GhPb50MgU2yb0omPctA7SEHgP2eA92ca394gNy1WGuFKMeOVggPgQ9Ei3dG5PwvPbyOo
         zIgY+ma7ZBL/7F1KfK9zs5ggLB1+EPII44thMWkydhPKpbZfR1E7GydJ1DkYkbImz58W
         vOVJbn/auadhIFbpGT9evotMKhl1zVX9Qn46R/K5KIrlbXLhNSOseI1CIpyh7zFix3+C
         vhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688642029; x=1691234029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=csDOZ6a1voCOJNBiSlT7Iqwi91gjcwEx7uBOQUBJAmA=;
        b=S9TbP1/uq1rSgEkzfzP3vxmWwgq0ybi0XOaRD7z/BXDhAFkXOfxXjvXQWhX2cmEpHL
         nEfbMqgE5DCboejQvm5gA8R8t+KAsOP3ijLLEB8Ft7a2r9E5znhPF+Ztq+4zzj5n5v9k
         g2Gqc2U7P//O2mbsnWldJwINwxkfXy01zHYHEKrqCvNGQG+BIxqwvwDtDH5O+eNvef/g
         San0H42z8zc7Y+iLKrvBHrdu3sKXCnhZJiO1RExLORAUspe5/8yTPLdiErnh2rmL3izF
         u3v+e+e8cAqjirvTG0LycWMi5vh565xy/znPYBdxpAQLGZN4x0+nRoPPNDuf61qdsPXF
         PYtQ==
X-Gm-Message-State: ABy/qLY+t8vSAPEwIkq3UGzCydpcKK99DT0sIgjss2wNkpO2oFwkvtdc
        8z5zxdhqMqBc6JTFw3UU+1qgEmHvNGk=
X-Google-Smtp-Source: APBJJlEwwIWE1/AkiX9bakJFxzlBhRE4Mj9tFFyWnMufZkJZ5qkcZtKiRVIao5dZBAn8z18Pk+GtFA==
X-Received: by 2002:ac2:5e30:0:b0:4f8:7528:50b5 with SMTP id o16-20020ac25e30000000b004f8752850b5mr1137692lfg.14.1688642028497;
        Thu, 06 Jul 2023 04:13:48 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id y24-20020ac24218000000b004fa039eb84csm207216lfh.198.2023.07.06.04.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 04:13:48 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     stable@vger.kernel.org
Cc:     netdev@vger.kernel.org
Subject: [PATCH linux-5.4.y] bgmac: fix *initial* chip reset to support BCM5358
Date:   Thu,  6 Jul 2023 13:13:46 +0200
Message-Id: <20230706111346.20234-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

commit f99e6d7c4ed3be2531bd576425a5bd07fb133bd7 upstream.

While bringing hardware up we should perform a full reset including the
switch bit (BGMAC_BCMA_IOCTL_SW_RESET aka SICF_SWRST). It's what
specification says and what reference driver does.

This seems to be critical for the BCM5358. Without this hardware doesn't
get initialized properly and doesn't seem to transmit or receive any
packets.

Originally bgmac was calling bgmac_chip_reset() before setting
"has_robosw" property which resulted in expected behaviour. That has
changed as a side effect of adding platform device support which
regressed BCM5358 support.

Fixes: f6a95a24957a ("net: ethernet: bgmac: Add platform device support")
Cc: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Link: https://lore.kernel.org/r/20230227091156.19509-1-zajec5@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Upstream commit wasn't backported to 5.4 (and older) because it couldn't
be cherry-picked cleanly. There was a small fuzz caused by a missing
commit 8c7da63978f1 ("bgmac: configure MTU and add support for frames
beyond 8192 byte size").

I've manually cherry-picked fix for BCM5358 to the linux-5.4.x.
---
 drivers/net/ethernet/broadcom/bgmac.c | 8 ++++++--
 drivers/net/ethernet/broadcom/bgmac.h | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 193722334d93..89a63fdbe0e3 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -890,13 +890,13 @@ static void bgmac_chip_reset_idm_config(struct bgmac *bgmac)
 
 		if (iost & BGMAC_BCMA_IOST_ATTACHED) {
 			flags = BGMAC_BCMA_IOCTL_SW_CLKEN;
-			if (!bgmac->has_robosw)
+			if (bgmac->in_init || !bgmac->has_robosw)
 				flags |= BGMAC_BCMA_IOCTL_SW_RESET;
 		}
 		bgmac_clk_enable(bgmac, flags);
 	}
 
-	if (iost & BGMAC_BCMA_IOST_ATTACHED && !bgmac->has_robosw)
+	if (iost & BGMAC_BCMA_IOST_ATTACHED && (bgmac->in_init || !bgmac->has_robosw))
 		bgmac_idm_write(bgmac, BCMA_IOCTL,
 				bgmac_idm_read(bgmac, BCMA_IOCTL) &
 				~BGMAC_BCMA_IOCTL_SW_RESET);
@@ -1489,6 +1489,8 @@ int bgmac_enet_probe(struct bgmac *bgmac)
 	struct net_device *net_dev = bgmac->net_dev;
 	int err;
 
+	bgmac->in_init = true;
+
 	bgmac_chip_intrs_off(bgmac);
 
 	net_dev->irq = bgmac->irq;
@@ -1538,6 +1540,8 @@ int bgmac_enet_probe(struct bgmac *bgmac)
 	net_dev->hw_features = net_dev->features;
 	net_dev->vlan_features = net_dev->features;
 
+	bgmac->in_init = false;
+
 	err = register_netdev(bgmac->net_dev);
 	if (err) {
 		dev_err(bgmac->dev, "Cannot register net device\n");
diff --git a/drivers/net/ethernet/broadcom/bgmac.h b/drivers/net/ethernet/broadcom/bgmac.h
index 40d02fec2747..76930b8353d6 100644
--- a/drivers/net/ethernet/broadcom/bgmac.h
+++ b/drivers/net/ethernet/broadcom/bgmac.h
@@ -511,6 +511,8 @@ struct bgmac {
 	int irq;
 	u32 int_mask;
 
+	bool in_init;
+
 	/* Current MAC state */
 	int mac_speed;
 	int mac_duplex;
-- 
2.35.3

