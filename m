Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00296FA6A4
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbjEHKW5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbjEHKWP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:22:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F88DC79
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:21:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF9AA624EF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBDBC433EF;
        Mon,  8 May 2023 10:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541288;
        bh=Z/VOo4C395BFOcK/X7kGuEpCBT6UF2P86VQTWrcHIbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vIt6IsLcPmEIujYxqM5oqmWfy06CV1AmWqXV8J58UZTaDE45pE8SPtzdENL0h43kQ
         u17Cs5uOTj03AobbssajHcrWl+L0YxHPpt31kosTGrZHQ59RZhWg1ivtwUSBhJqhRd
         w+qgtpaoWwWzm2ciA0B3u4tBv1mDCOWLJ+uikN/U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Babu Moger <babu.moger@amd.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.2 037/663] hwmon: (k10temp) Check range scale when CUR_TEMP register is read-write
Date:   Mon,  8 May 2023 11:37:43 +0200
Message-Id: <20230508094429.663414559@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Babu Moger <Babu.Moger@amd.com>

commit 0c072385348e3ac5229145644055d3e2afb5b3db upstream.

Spec says, when CUR_TEMP_TJ_SEL == 3 and CUR_TEMP_RANGE_SEL == 0,
it should use RangeUnadjusted is 0, which is (CurTmp*0.125 -49) C. The
CUR_TEMP register is read-write when CUR_TEMP_TJ_SEL == 3 (bit 17-16).

Add the check to detect it.

Sensors command's output before the patch.
$sensors
 k10temp-pci-00c3
 Adapter: PCI adapter
 Tctl:         +76.6°C <- Wrong value
 Tccd1:        +26.5°C
 Tccd2:        +27.5°C
 Tccd3:        +27.2°C
 Tccd4:        +27.5°C
 Tccd5:        +26.0°C
 Tccd6:        +26.2°C
 Tccd7:        +25.0°C
 Tccd8:        +26.5°C

Sensors command's output after the patch.
$sensors
 k10temp-pci-00c3
 Adapter: PCI adapter
 Tctl:         +28.8°C <- corrected value
 Tccd1:        +27.5°C
 Tccd2:        +28.5°C
 Tccd3:        +28.5°C
 Tccd4:        +28.5°C
 Tccd5:        +27.0°C
 Tccd6:        +27.5°C
 Tccd7:        +27.0°C
 Tccd8:        +27.5°C

Signed-off-by: Babu Moger <babu.moger@amd.com>
Fixes: 1b59788979ac ("hwmon: (k10temp) Add temperature offset for Ryzen 2700X")
Link: https://lore.kernel.org/r/20230413213958.847634-1-babu.moger@amd.com
Cc: stable@vger.kernel.org
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/k10temp.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -75,6 +75,7 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 
 #define ZEN_CUR_TEMP_SHIFT			21
 #define ZEN_CUR_TEMP_RANGE_SEL_MASK		BIT(19)
+#define ZEN_CUR_TEMP_TJ_SEL_MASK		GENMASK(17, 16)
 
 struct k10temp_data {
 	struct pci_dev *pdev;
@@ -155,7 +156,8 @@ static long get_raw_temp(struct k10temp_
 
 	data->read_tempreg(data->pdev, &regval);
 	temp = (regval >> ZEN_CUR_TEMP_SHIFT) * 125;
-	if (regval & data->temp_adjust_mask)
+	if ((regval & data->temp_adjust_mask) ||
+	    (regval & ZEN_CUR_TEMP_TJ_SEL_MASK) == ZEN_CUR_TEMP_TJ_SEL_MASK)
 		temp -= 49000;
 	return temp;
 }


