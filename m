Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D996F9346
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 19:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjEFRQ0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 13:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEFRQ0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 13:16:26 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49A89191C0
        for <stable@vger.kernel.org>; Sat,  6 May 2023 10:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=XDbPr
        foM+vd09SU0nLd9OpVWaVSYKPv82lGdDyy/2QU=; b=Fks/akAA1RFcj6Cav+w9B
        aD1FFWv2XtV6mwY7eHa4AklfcWIh1C8p+eMax+1GWRN/WqgWCgEcymKAVtPtSaUZ
        Ns72pw8ZiQZVsios5P/T1Ea0qdUa8BhU3pLzghZlGMIbrxvfsyqnluooirsVel+6
        AspOFQnyU6/+OAkTtNvyuY=
Received: from localhost.localdomain (unknown [111.43.134.127])
        by zwqz-smtp-mta-g2-2 (Coremail) with SMTP id _____wAH_qFKi1ZkAC2QBA--.41346S2;
        Sun, 07 May 2023 01:15:54 +0800 (CST)
From:   frshuov@163.com
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, stable@vger.kernel.org, Larry Chi <frshuov@163.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for ASUS GU603ZM
Date:   Sun,  7 May 2023 01:15:46 +0800
Message-Id: <20230506171546.50815-1-frshuov@163.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAH_qFKi1ZkAC2QBA--.41346S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr1fZr18AF4fXFW5WFWDtwb_yoWkuFb_Ar
        W3GFW5GF4UZwnrGFn3Grn5Ar4Iyrn8urZrXFyftFs8Jw4fKa109FnYkrnIkF1xXrW8ur15
        G3yYyrWrtry5KjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRCyxi3UUUUU==
X-Originating-IP: [111.43.134.127]
X-CM-SenderInfo: xiuvx3lry6il2tof0z/1tbisQtnCWMr+EtimQAAsU
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Larry Chi <frshuov@163.com>

ASUS ROG Zephyrus M16 2022 GU603ZM (1043:1c62)
added SND_PCI_QUIRK for speaker and headset-mic working properly

Signed-off-by: Larry Chi <frshuov@163.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 172ffc2c332b..374a9755d19a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9522,6 +9522,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1b13, "Asus U41SV", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1bbd, "ASUS Z550MA", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1c23, "Asus X55U", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
+    SND_PCI_QUIRK(0x1043, 0x1c62, "ASUS GU603ZM", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1c92, "ASUS ROG Strix G15", ALC285_FIXUP_ASUS_G533Z_PINS),
 	SND_PCI_QUIRK(0x1043, 0x1ccd, "ASUS X555UB", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1d42, "ASUS Zephyrus G14 2022", ALC289_FIXUP_ASUS_GA401),
-- 
2.40.1

