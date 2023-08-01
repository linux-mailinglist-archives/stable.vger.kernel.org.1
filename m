Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EF976AEBC
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbjHAJlS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbjHAJky (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:40:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8FB5248
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:38:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A02BC6150B
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D76C433C7;
        Tue,  1 Aug 2023 09:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882727;
        bh=oI/XKw0qlPgkusWNxo3U0SLTswQGNgifJh5gt3K1duE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yvp6t8QiqGUfiiiCeL5VsSLpWSbsN/QtUs5Hm5HGKvqtAxqYkhO1M1/dc/PuHa6DG
         SRYLFWwpgHeRfLTOfs5iAZ3JyKDA8czWcJN01fgJXSO7zY9HZVyj68glNjFEQE8izT
         3NmpXyiFb58FgdDIe1JmS2lv7uxJlt8WBnJC+0y8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Baskaran Kannan <Baski.Kannan@amd.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.1 181/228] hwmon: (k10temp) Enable AMD3255 Proc to show negative temperature
Date:   Tue,  1 Aug 2023 11:20:39 +0200
Message-ID: <20230801091929.400413710@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Baskaran Kannan <Baski.Kannan@amd.com>

commit e146503ac68418859fb063a3a0cd9ec93bc52238 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/k10temp.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

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
@@ -204,12 +212,12 @@ static int k10temp_read_temp(struct devi
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
@@ -405,6 +413,11 @@ static int k10temp_probe(struct pci_dev
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


