Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493457BE058
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377229AbjJINjc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377458AbjJINjC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:39:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A526184
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:38:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A566C433C9;
        Mon,  9 Oct 2023 13:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858735;
        bh=nkTPl+hnGLyjBp1HPDuxaCVkhoOJfUJ+rTO/RwnXvbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eXQhK++XTr2ZhQdruKiA0kOfOrtkkCfdCCuSHDr4v3th5CGX8g3aCLMAOlC95fFk/
         ZPaziDdvG7FDl7geI24Th2bK09m0kIpHvQNZLInWrkjKsbCYat+S41iXJKvQvSr/46
         H7CbTy5MnoonfM1CuPNKyBujYErKLzx6uxY1LXzw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paul Menzel <pmenzel@molgen.mpg.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 083/226] ata: libata: Rename link flag ATA_LFLAG_NO_DB_DELAY
Date:   Mon,  9 Oct 2023 15:00:44 +0200
Message-ID: <20231009130128.958280106@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
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

From: Paul Menzel <pmenzel@molgen.mpg.de>

[ Upstream commit b9ba367c513dbc165dd6c01266a59db4be2a3564 ]

Rename the link flag ATA_LFLAG_NO_DB_DELAY to
ATA_LFLAG_NO_DEBOUNCE_DELAY. The new name is longer, but clearer.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Stable-dep-of: 2a2df98ec592 ("ata: ahci: Add Elkhart Lake AHCI controller")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/ahci_brcm.c   | 2 +-
 drivers/ata/libata-sata.c | 2 +-
 include/linux/libata.h    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 5b32df5d33adc..2e4252545fd27 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -332,7 +332,7 @@ static struct ata_port_operations ahci_brcm_platform_ops = {
 
 static const struct ata_port_info ahci_brcm_port_info = {
 	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NO_DIPM,
-	.link_flags	= ATA_LFLAG_NO_DB_DELAY,
+	.link_flags	= ATA_LFLAG_NO_DEBOUNCE_DELAY,
 	.pio_mask	= ATA_PIO4,
 	.udma_mask	= ATA_UDMA6,
 	.port_ops	= &ahci_brcm_platform_ops,
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 4fd9a107fe7f8..45656067c547a 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -317,7 +317,7 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
 		 * immediately after resuming.  Delay 200ms before
 		 * debouncing.
 		 */
-		if (!(link->flags & ATA_LFLAG_NO_DB_DELAY))
+		if (!(link->flags & ATA_LFLAG_NO_DEBOUNCE_DELAY))
 			ata_msleep(link->ap, 200);
 
 		/* is SControl restored correctly? */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5ca9347bd8ef9..2de6b4a613944 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -187,7 +187,7 @@ enum {
 	ATA_LFLAG_NO_LPM	= (1 << 8), /* disable LPM on this link */
 	ATA_LFLAG_RST_ONCE	= (1 << 9), /* limit recovery to one reset */
 	ATA_LFLAG_CHANGED	= (1 << 10), /* LPM state changed on this link */
-	ATA_LFLAG_NO_DB_DELAY	= (1 << 11), /* no debounce delay on link resume */
+	ATA_LFLAG_NO_DEBOUNCE_DELAY = (1 << 11), /* no debounce delay on link resume */
 
 	/* struct ata_port flags */
 	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
-- 
2.40.1



