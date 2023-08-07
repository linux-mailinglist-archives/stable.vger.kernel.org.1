Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC19771B00
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 09:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjHGHDI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 03:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHGHDH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 03:03:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FC91A4
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 00:03:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C1FF611C0
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 07:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A57AC433C8;
        Mon,  7 Aug 2023 07:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691391785;
        bh=Tvfniy/rTWbp2DjyioEvW4ki/MbZyGdCKl0yZxUUWJw=;
        h=Subject:To:Cc:From:Date:From;
        b=TOaqN4l17OK9i8rEvGQXzkgse0vHIXojolZKdnbSJcga8VuvkWhcTEneanxj7eoY2
         wG2RK5VQYdm8t/ywHUKBirlqL0nn2pTzoSRnoLjrBeCRTkRmrNsLrEfn9T8lhgx2C5
         2Xc34/o3D6iUpdYDnbvntNbiG/QSi848VeloLJyU=
Subject: FAILED: patch "[PATCH] wifi: mt76: mt7615: do not advertise 5 GHz on first phy of" failed to apply to 5.10-stable tree
To:     fercerpav@gmail.com, kvalo@kernel.org, nbd@nbd.name,
        rani.hod@gmail.com, simon.horman@corigine.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 07 Aug 2023 09:03:02 +0200
Message-ID: <2023080702-boned-sprang-1bc9@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 421033deb91521aa6a9255e495cb106741a52275
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023080702-boned-sprang-1bc9@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

421033deb915 ("wifi: mt76: mt7615: do not advertise 5 GHz on first phy of MT7615D (DBDC)")
f12758f6f929 ("mt76: mt7615: Fix fall-through warnings for Clang")
48dbce5cb1ba ("mt76: move band capabilities in mt76_phy")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 421033deb91521aa6a9255e495cb106741a52275 Mon Sep 17 00:00:00 2001
From: Paul Fertser <fercerpav@gmail.com>
Date: Mon, 5 Jun 2023 10:34:07 +0300
Subject: [PATCH] wifi: mt76: mt7615: do not advertise 5 GHz on first phy of
 MT7615D (DBDC)

On DBDC devices the first (internal) phy is only capable of using
2.4 GHz band, and the 5 GHz band is exposed via a separate phy object,
so avoid the false advertising.

Reported-by: Rani Hod <rani.hod@gmail.com>
Closes: https://github.com/openwrt/openwrt/pull/12361
Fixes: 7660a1bd0c22 ("mt76: mt7615: register ext_phy if DBDC is detected")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Fertser <fercerpav@gmail.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Acked-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230605073408.8699-1-fercerpav@gmail.com

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index 68e88224b8b1..ccedea7e8a50 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -128,12 +128,12 @@ mt7615_eeprom_parse_hw_band_cap(struct mt7615_dev *dev)
 	case MT_EE_5GHZ:
 		dev->mphy.cap.has_5ghz = true;
 		break;
-	case MT_EE_2GHZ:
-		dev->mphy.cap.has_2ghz = true;
-		break;
 	case MT_EE_DBDC:
 		dev->dbdc_support = true;
 		fallthrough;
+	case MT_EE_2GHZ:
+		dev->mphy.cap.has_2ghz = true;
+		break;
 	default:
 		dev->mphy.cap.has_2ghz = true;
 		dev->mphy.cap.has_5ghz = true;

