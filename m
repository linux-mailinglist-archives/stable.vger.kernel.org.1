Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0447695E9
	for <lists+stable@lfdr.de>; Mon, 31 Jul 2023 14:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjGaMQu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 31 Jul 2023 08:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjGaMQt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 31 Jul 2023 08:16:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CB6197
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 05:16:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0C9A61083
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 12:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFD3C433C8;
        Mon, 31 Jul 2023 12:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690805807;
        bh=keAxXoXMjyf21+w1ESs77LT/m11zmhtF2kdCxv1LLMA=;
        h=Subject:To:Cc:From:Date:From;
        b=aFE/NwXs0Qn+S6jerZXE4J28ajVCSN0fTpJIswSgV1/K/yisUClqCVtAsJYPdasCz
         JEC2nGLuMrrCRB2mLhqzKjAsMmIldTaSaWSuNBH1lWdYhDrNebiuROxZKlRwhq5mQj
         NlqOMq8E20YgFJBKAulwYTc7wMEJmsrcj0hnPSjI=
Subject: FAILED: patch "[PATCH] hwmon: (k10temp) Enable AMD3255 Proc to show negative" failed to apply to 4.19-stable tree
To:     Baski.Kannan@amd.com, linux@roeck-us.net
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 31 Jul 2023 14:16:33 +0200
Message-ID: <2023073133-crystal-overdue-6430@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x e146503ac68418859fb063a3a0cd9ec93bc52238
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023073133-crystal-overdue-6430@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

e146503ac684 ("hwmon: (k10temp) Enable AMD3255 Proc to show negative temperature")
0e3f52bbd9eb ("hwmon: (k10temp) Rework the temperature offset calculation")
128066c88770 ("hwmon: (k10temp) Add additional missing Zen2 and Zen3 APUs")
02c9dce4df8d ("hwmon: (k10temp) support Zen3 APUs")
c8d0d3fa9469 ("hwmon: (k10temp) Zen3 Ryzen Desktop CPUs support")
0a4e668b5d52 ("hwmon: (k10temp) Remove support for displaying voltage and current on Zen CPUs")
55163a1c00fc ("hwmon: (k10temp) Add support for Zen3 CPUs")
d6144a40041a ("hwmon: (k10temp) Define SVI telemetry and current factors for Zen2 CPUs")
178224170423 ("hwmon: (k10temp) Create common functions and macros for Zen CPU families")
0e786f328b38 ("hwmon: (k10temp) make some symbols static")
60465245e6ce ("hwmon: (k10temp) Reorganize and simplify temperature support detection")
b02c6857389d ("hwmon: (k10temp) Swap Tdie and Tctl on Family 17h CPUs")
fd8bdb23b918 ("hwmon: (k10temp) Display up to eight sets of CCD temperatures")
9c4a38f19ed2 ("hwmon: (k10temp) Add debugfs support")
70831c8a9184 ("hwmon: (k10temp) Don't show temperature limits on Ryzen (Zen) CPUs")
b00647c46c9d ("hwmon: (k10temp) Show core and SoC current and voltages on Ryzen CPUs")
c757938929c9 ("hwmon: (k10temp) Report temperatures per CPU die")
d547552a1bf1 ("hmon: (k10temp) Convert to use devm_hwmon_device_register_with_info")
a6d210da1a01 ("hwmon: (k10temp) Use bitops")
12163cfbfc0f ("hwmon: (k10temp) Add support for AMD family 17h, model 70h CPUs")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e146503ac68418859fb063a3a0cd9ec93bc52238 Mon Sep 17 00:00:00 2001
From: Baskaran Kannan <Baski.Kannan@amd.com>
Date: Thu, 27 Jul 2023 11:21:59 -0500
Subject: [PATCH] hwmon: (k10temp) Enable AMD3255 Proc to show negative
 temperature

Industrial processor i3255 supports temperatures -40 deg celcius
to 105 deg Celcius. The current implementation of k10temp_read_temp
rounds off any negative temperatures to '0'. To fix this,
the following changes have been made.

A flag 'disp_negative' is added to struct k10temp_data to support
AMD i3255 processors. Flag 'disp_negative' is set if 3255 processor
is found during k10temp_probe.  Flag 'disp_negative' is used to
determine whether to round off negative temperatures to '0' in
k10temp_read_temp.

Signed-off-by: Baskaran Kannan <Baski.Kannan@amd.com>
Link: https://lore.kernel.org/r/20230727162159.1056136-1-Baski.Kannan@amd.com
Fixes: aef17ca12719 ("hwmon: (k10temp) Only apply temperature offset if result is positive")
Cc: stable@vger.kernel.org
[groeck: Fixed multi-line comment]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 7b177b9fbb09..a267b11731a8 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -77,6 +77,13 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 #define ZEN_CUR_TEMP_RANGE_SEL_MASK		BIT(19)
 #define ZEN_CUR_TEMP_TJ_SEL_MASK		GENMASK(17, 16)
 
+/*
+ * AMD's Industrial processor 3255 supports temperature from -40 deg to 105 deg Celsius.
+ * Use the model name to identify 3255 CPUs and set a flag to display negative temperature.
+ * Do not round off to zero for negative Tctl or Tdie values if the flag is set
+ */
+#define AMD_I3255_STR				"3255"
+
 struct k10temp_data {
 	struct pci_dev *pdev;
 	void (*read_htcreg)(struct pci_dev *pdev, u32 *regval);
@@ -86,6 +93,7 @@ struct k10temp_data {
 	u32 show_temp;
 	bool is_zen;
 	u32 ccd_offset;
+	bool disp_negative;
 };
 
 #define TCTL_BIT	0
@@ -204,12 +212,12 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 		switch (channel) {
 		case 0:		/* Tctl */
 			*val = get_raw_temp(data);
-			if (*val < 0)
+			if (*val < 0 && !data->disp_negative)
 				*val = 0;
 			break;
 		case 1:		/* Tdie */
 			*val = get_raw_temp(data) - data->temp_offset;
-			if (*val < 0)
+			if (*val < 0 && !data->disp_negative)
 				*val = 0;
 			break;
 		case 2 ... 13:		/* Tccd{1-12} */
@@ -405,6 +413,11 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	data->pdev = pdev;
 	data->show_temp |= BIT(TCTL_BIT);	/* Always show Tctl */
 
+	if (boot_cpu_data.x86 == 0x17 &&
+	    strstr(boot_cpu_data.x86_model_id, AMD_I3255_STR)) {
+		data->disp_negative = true;
+	}
+
 	if (boot_cpu_data.x86 == 0x15 &&
 	    ((boot_cpu_data.x86_model & 0xf0) == 0x60 ||
 	     (boot_cpu_data.x86_model & 0xf0) == 0x70)) {

