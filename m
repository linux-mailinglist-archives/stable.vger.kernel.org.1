Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2DD6F8ED9
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 07:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjEFFyw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 01:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjEFFyu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 01:54:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF21149EC
        for <stable@vger.kernel.org>; Fri,  5 May 2023 22:54:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 425DF6150F
        for <stable@vger.kernel.org>; Sat,  6 May 2023 05:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCD4C433EF;
        Sat,  6 May 2023 05:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683352488;
        bh=2Cqyrfr1Kr0Snnrq7mwtRrBCzahKmklhu5M1ukHD+H0=;
        h=Subject:To:Cc:From:Date:From;
        b=2T1v9hgg52ejfvUWxwP/9/C5grCZ9oQ3HLMMbk3b+PYXBVqZlGqKN3g+o/nmLKvsy
         FB+T5KHe7+U7lKh3kCzvLJAcnsLCPPVmiu7gr++mIV4PUAN3m4ZmVUUK6YnfwhRYWa
         FwHsULAs62rAZSak9lFYIQIy3KsCJVgT76ojmczY=
Subject: FAILED: patch "[PATCH] hwmon: (k10temp) Check range scale when CUR_TEMP register is" failed to apply to 4.19-stable tree
To:     Babu.Moger@amd.com, babu.moger@amd.com, linux@roeck-us.net
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 06 May 2023 11:00:07 +0900
Message-ID: <2023050607-mammogram-popcorn-cc13@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 0c072385348e3ac5229145644055d3e2afb5b3db
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050607-mammogram-popcorn-cc13@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0c072385348e3ac5229145644055d3e2afb5b3db Mon Sep 17 00:00:00 2001
From: Babu Moger <Babu.Moger@amd.com>
Date: Thu, 13 Apr 2023 16:39:58 -0500
Subject: [PATCH] hwmon: (k10temp) Check range scale when CUR_TEMP register is
 read-write
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 5a9d47a229e4..be8bbb1c3a02 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -75,6 +75,7 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 
 #define ZEN_CUR_TEMP_SHIFT			21
 #define ZEN_CUR_TEMP_RANGE_SEL_MASK		BIT(19)
+#define ZEN_CUR_TEMP_TJ_SEL_MASK		GENMASK(17, 16)
 
 struct k10temp_data {
 	struct pci_dev *pdev;
@@ -155,7 +156,8 @@ static long get_raw_temp(struct k10temp_data *data)
 
 	data->read_tempreg(data->pdev, &regval);
 	temp = (regval >> ZEN_CUR_TEMP_SHIFT) * 125;
-	if (regval & data->temp_adjust_mask)
+	if ((regval & data->temp_adjust_mask) ||
+	    (regval & ZEN_CUR_TEMP_TJ_SEL_MASK) == ZEN_CUR_TEMP_TJ_SEL_MASK)
 		temp -= 49000;
 	return temp;
 }

