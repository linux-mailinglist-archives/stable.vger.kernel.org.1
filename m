Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF1D6F16A1
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 13:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241208AbjD1L26 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 07:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjD1L25 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 07:28:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069874EC3
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 04:28:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99B43642AA
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 11:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8762C433EF;
        Fri, 28 Apr 2023 11:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682681335;
        bh=rpDuiGQFMqHLiOUGNWZuv0UIVvR5mfmhCuFKJioySt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ImQfeE3oqV6IU0w2nYRjufoWkE198YhD4fcedluAkgMLKiCITFjcuezkgGxCeGghk
         D2EkJgKgAaPSNG1b3FU0MA/tJtxMfa7DKezLW5eph3dR91Ddqkm8RAdJrsZrjmCH15
         4VIZ8EwwMUqA3Et/xiBPQvwC2zPokROUZUnQcQvA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Marek Vasut <marex@denx.de>,
        Simon Horman <simon.horman@corigine.com>,
        Kalle Valo <kvalo@kernel.org>
Subject: [PATCH 6.2 09/15] wifi: brcmfmac: add Cypress 43439 SDIO ids
Date:   Fri, 28 Apr 2023 13:27:53 +0200
Message-Id: <20230428112040.429506497@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230428112040.137898986@linuxfoundation.org>
References: <20230428112040.137898986@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Marek Vasut <marex@denx.de>

commit cc4cffc3c142d57df48c07851862444e1d33bdaa upstream.

Add SDIO ids for use with the muRata 1YN (Cypress CYW43439).
The odd thing about this is that the previous 1YN populated
on M.2 card for evaluation purposes had BRCM SDIO vendor ID,
while the chip populated on real hardware has a Cypress one.
The device ID also differs between the two devices. But they
are both 43439 otherwise, so add the IDs for both.

On-device 1YN (43439), the new one, chip label reads "1YN":
```
/sys/.../mmc_host/mmc2/mmc2:0001 # cat vendor device
0x04b4
0xbd3d
```

EA M.2 evaluation board 1YN (43439), the old one, chip label reads "1YN ES1.4":
```
/sys/.../mmc_host/mmc0/mmc0:0001/# cat vendor device
0x02d0
0xa9a6
```

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Marek Vasut <marex@denx.de>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230407203752.128539-1-marex@denx.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c |    9 ++++++++-
 include/linux/mmc/sdio_ids.h                              |    5 ++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -965,6 +965,12 @@ out:
 		.driver_data = BRCMF_FWVENDOR_ ## fw_vend \
 	}
 
+#define CYW_SDIO_DEVICE(dev_id, fw_vend) \
+	{ \
+		SDIO_DEVICE(SDIO_VENDOR_ID_CYPRESS, dev_id), \
+		.driver_data = BRCMF_FWVENDOR_ ## fw_vend \
+	}
+
 /* devices we support, null terminated */
 static const struct sdio_device_id brcmf_sdmmc_ids[] = {
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43143, WCC),
@@ -979,6 +985,7 @@ static const struct sdio_device_id brcmf
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4335_4339, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4339, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43430, WCC),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43439, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4345, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43455, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4354, WCC),
@@ -986,9 +993,9 @@ static const struct sdio_device_id brcmf
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4359, WCC),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373, CYW),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43012, CYW),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439, CYW),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752, CYW),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_89359, CYW),
+	CYW_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439, CYW),
 	{ /* end: all zeroes */ }
 };
 MODULE_DEVICE_TABLE(sdio, brcmf_sdmmc_ids);
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -74,10 +74,13 @@
 #define SDIO_DEVICE_ID_BROADCOM_43362		0xa962
 #define SDIO_DEVICE_ID_BROADCOM_43364		0xa9a4
 #define SDIO_DEVICE_ID_BROADCOM_43430		0xa9a6
-#define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439	0xa9af
+#define SDIO_DEVICE_ID_BROADCOM_43439		0xa9af
 #define SDIO_DEVICE_ID_BROADCOM_43455		0xa9bf
 #define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752	0xaae8
 
+#define SDIO_VENDOR_ID_CYPRESS			0x04b4
+#define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43439	0xbd3d
+
 #define SDIO_VENDOR_ID_MARVELL			0x02df
 #define SDIO_DEVICE_ID_MARVELL_LIBERTAS		0x9103
 #define SDIO_DEVICE_ID_MARVELL_8688_WLAN	0x9104


