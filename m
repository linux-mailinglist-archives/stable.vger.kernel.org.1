Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03A37E240E
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjKFNRg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjKFNRf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:17:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C8F94
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:17:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0FEC433C8;
        Mon,  6 Nov 2023 13:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276653;
        bh=PZy0gEs3mIsN/v45teV5woRNZ4SiU2qjPQBBYreA7ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hUpu2xMdRnaUtEW+dOMmMWuI77n4gJ+pB6HxEP+VIGS1cgppS7wqL8zuNouUcfhUU
         1sn432bg0wUdxG75jZGxfmRELeVu/wn4EFC0tHCzAsflV5eQhJZ/Te1RL3i/fNo15e
         oeC7O1UGVdsomOa5WDJvS0oVkQybrWTqwqG6rNlM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ondrej Zary <linux@zary.sk>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 13/88] ata: pata_parport: add custom version of wait_after_reset
Date:   Mon,  6 Nov 2023 14:03:07 +0100
Message-ID: <20231106130306.290956056@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
References: <20231106130305.772449722@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ondrej Zary <linux@zary.sk>

[ Upstream commit f343e578fef99a69b3322aca38b94a6d8ded2ce7 ]

Some parallel adapters (e.g. EXP Computer MC-1285B EPP Cable) return
bogus values when there's no master device present. This can cause
reset to fail, preventing the lone slave device (such as EXP Computer
CD-865) from working.

Add custom version of wait_after_reset that ignores master failure when
a slave device is present. The custom version is also needed because
the generic ata_sff_wait_after_reset uses direct port I/O for slave
device detection.

Signed-off-by: Ondrej Zary <linux@zary.sk>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/pata_parport/pata_parport.c | 68 ++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
index cf87bbb52f1ff..a7adfdcb5e27c 100644
--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -80,6 +80,72 @@ static bool pata_parport_devchk(struct ata_port *ap, unsigned int device)
 	return (nsect == 0x55) && (lbal == 0xaa);
 }
 
+static int pata_parport_wait_after_reset(struct ata_link *link,
+					 unsigned int devmask,
+					 unsigned long deadline)
+{
+	struct ata_port *ap = link->ap;
+	struct pi_adapter *pi = ap->host->private_data;
+	unsigned int dev0 = devmask & (1 << 0);
+	unsigned int dev1 = devmask & (1 << 1);
+	int rc, ret = 0;
+
+	ata_msleep(ap, ATA_WAIT_AFTER_RESET);
+
+	/* always check readiness of the master device */
+	rc = ata_sff_wait_ready(link, deadline);
+	if (rc) {
+		/*
+		 * some adapters return bogus values if master device is not
+		 * present, so don't abort now if a slave device is present
+		 */
+		if (!dev1)
+			return rc;
+		ret = -ENODEV;
+	}
+
+	/*
+	 * if device 1 was found in ata_devchk, wait for register
+	 * access briefly, then wait for BSY to clear.
+	 */
+	if (dev1) {
+		int i;
+
+		pata_parport_dev_select(ap, 1);
+
+		/*
+		 * Wait for register access.  Some ATAPI devices fail
+		 * to set nsect/lbal after reset, so don't waste too
+		 * much time on it.  We're gonna wait for !BSY anyway.
+		 */
+		for (i = 0; i < 2; i++) {
+			u8 nsect, lbal;
+
+			nsect = pi->proto->read_regr(pi, 0, ATA_REG_NSECT);
+			lbal = pi->proto->read_regr(pi, 0, ATA_REG_LBAL);
+			if (nsect == 1 && lbal == 1)
+				break;
+			/* give drive a breather */
+			ata_msleep(ap, 50);
+		}
+
+		rc = ata_sff_wait_ready(link, deadline);
+		if (rc) {
+			if (rc != -ENODEV)
+				return rc;
+			ret = rc;
+		}
+	}
+
+	pata_parport_dev_select(ap, 0);
+	if (dev1)
+		pata_parport_dev_select(ap, 1);
+	if (dev0)
+		pata_parport_dev_select(ap, 0);
+
+	return ret;
+}
+
 static int pata_parport_bus_softreset(struct ata_port *ap, unsigned int devmask,
 				      unsigned long deadline)
 {
@@ -94,7 +160,7 @@ static int pata_parport_bus_softreset(struct ata_port *ap, unsigned int devmask,
 	ap->last_ctl = ap->ctl;
 
 	/* wait the port to become ready */
-	return ata_sff_wait_after_reset(&ap->link, devmask, deadline);
+	return pata_parport_wait_after_reset(&ap->link, devmask, deadline);
 }
 
 static int pata_parport_softreset(struct ata_link *link, unsigned int *classes,
-- 
2.42.0



