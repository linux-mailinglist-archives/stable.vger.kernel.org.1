Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B447A7EDB
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbjITMV3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235767AbjITMVY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:21:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE701A7
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:21:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D02C433C8;
        Wed, 20 Sep 2023 12:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212473;
        bh=dnBacza4/GGM/zU/hL/cfp4HG8XcPthMn66gPcw+pjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0edc9zQAL+MdXy5nDWTGrcnRPBv8AnihywOhVktF4x3xInrt9X+NBJwvnJjaRvnpe
         wR73Gsm3PEaUoYorQr1GTZ3yCD548fKYcgAZOsH65nictoO45ZhcwQReVn8lRR5Bgc
         8X/OwNsPwZ7i4bZ94QXMBTMuxUBW5shdHTWWLfZs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dongliang Mu <dzm91@hust.edu.cn>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 15/83] wifi: ath9k: fix printk specifier
Date:   Wed, 20 Sep 2023 13:31:05 +0200
Message-ID: <20230920112827.282173183@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112826.634178162@linuxfoundation.org>
References: <20230920112826.634178162@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dongliang Mu <dzm91@hust.edu.cn>

[ Upstream commit 061115fbfb2ce5870c9a004d68dc63138c07c782 ]

Smatch reports:

ath_pci_probe() warn: argument 4 to %lx specifier is cast from pointer
ath_ahb_probe() warn: argument 4 to %lx specifier is cast from pointer

Fix it by modifying %lx to %p in the printk format string.

Note that with this change, the pointer address will be printed as a
hashed value by default. This is appropriate because the kernel
should not leak kernel pointers to user space in an informational
message. If someone wants to see the real address for debugging
purposes, this can be achieved with the no_hash_pointers kernel option.

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230723040403.296723-1-dzm91@hust.edu.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/ahb.c | 4 ++--
 drivers/net/wireless/ath/ath9k/pci.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wireless/ath/ath9k/ahb.c
index cdefb8e2daf14..05fb76a4e144e 100644
--- a/drivers/net/wireless/ath/ath9k/ahb.c
+++ b/drivers/net/wireless/ath/ath9k/ahb.c
@@ -136,8 +136,8 @@ static int ath_ahb_probe(struct platform_device *pdev)
 
 	ah = sc->sc_ah;
 	ath9k_hw_name(ah, hw_name, sizeof(hw_name));
-	wiphy_info(hw->wiphy, "%s mem=0x%lx, irq=%d\n",
-		   hw_name, (unsigned long)mem, irq);
+	wiphy_info(hw->wiphy, "%s mem=0x%p, irq=%d\n",
+		   hw_name, mem, irq);
 
 	return 0;
 
diff --git a/drivers/net/wireless/ath/ath9k/pci.c b/drivers/net/wireless/ath/ath9k/pci.c
index cff9af3af38d5..4f90c304d1214 100644
--- a/drivers/net/wireless/ath/ath9k/pci.c
+++ b/drivers/net/wireless/ath/ath9k/pci.c
@@ -994,8 +994,8 @@ static int ath_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	sc->sc_ah->msi_reg = 0;
 
 	ath9k_hw_name(sc->sc_ah, hw_name, sizeof(hw_name));
-	wiphy_info(hw->wiphy, "%s mem=0x%lx, irq=%d\n",
-		   hw_name, (unsigned long)sc->mem, pdev->irq);
+	wiphy_info(hw->wiphy, "%s mem=0x%p, irq=%d\n",
+		   hw_name, sc->mem, pdev->irq);
 
 	return 0;
 
-- 
2.40.1



