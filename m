Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AA5726D4E
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbjFGUlF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbjFGUlA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:41:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4767226BD
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:40:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5585964607
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652B4C4339B;
        Wed,  7 Jun 2023 20:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170432;
        bh=8nxvFTp3cGhgeVG2TmNxqhpxt387C2Ix/5fV54bK9zk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HkRfHDZLeKZKhYQe1/GBjC3U6mEANRZTlr4x8IRyPZP/S8nyotOgC4NzbK9EqWih1
         fdioaSyCKvHuVSFFERe/Wbh8mibyEtya8tyYN69s6HqzQfV/7WWqg3SSWiXEi2IkK0
         4Wr304Rf2QCixRDK80CbK+Cr0122uXleEWT3o5oM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hristo Venev <hristo@venev.name>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 082/225] nvme-pci: add quirk for missing secondary temperature thresholds
Date:   Wed,  7 Jun 2023 22:14:35 +0200
Message-ID: <20230607200917.057605911@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hristo Venev <hristo@venev.name>

[ Upstream commit bd375feeaf3408ed00e08c3bc918d6be15f691ad ]

On Kingston KC3000 and Kingston FURY Renegade (both have the same PCI
IDs) accessing temp3_{min,max} fails with an invalid field error (note
that there is no problem setting the thresholds for temp1).

This contradicts the NVM Express Base Specification 2.0b, page 292:

  The over temperature threshold and under temperature threshold
  features shall be implemented for all implemented temperature sensors
  (i.e., all Temperature Sensor fields that report a non-zero value).

Define NVME_QUIRK_NO_SECONDARY_TEMP_THRESH that disables the thresholds
for all but the composite temperature and set it for this device.

Signed-off-by: Hristo Venev <hristo@venev.name>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/hwmon.c | 4 +++-
 drivers/nvme/host/nvme.h  | 5 +++++
 drivers/nvme/host/pci.c   | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 9e6e56c20ec99..316f3e4ca7cc6 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -163,7 +163,9 @@ static umode_t nvme_hwmon_is_visible(const void *_data,
 	case hwmon_temp_max:
 	case hwmon_temp_min:
 		if ((!channel && data->ctrl->wctemp) ||
-		    (channel && data->log->temp_sensor[channel - 1])) {
+		    (channel && data->log->temp_sensor[channel - 1] &&
+		     !(data->ctrl->quirks &
+		       NVME_QUIRK_NO_SECONDARY_TEMP_THRESH))) {
 			if (data->ctrl->quirks &
 			    NVME_QUIRK_NO_TEMP_THRESH_CHANGE)
 				return 0444;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 01d90424af534..3f82de6060ef7 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -149,6 +149,11 @@ enum nvme_quirks {
 	 * Reports garbage in the namespace identifiers (eui64, nguid, uuid).
 	 */
 	NVME_QUIRK_BOGUS_NID			= (1 << 18),
+
+	/*
+	 * No temperature thresholds for channels other than 0 (Composite).
+	 */
+	NVME_QUIRK_NO_SECONDARY_TEMP_THRESH	= (1 << 19),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3347e86b3c55f..1ec0ca40604aa 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3515,6 +3515,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
+	{ PCI_DEVICE(0x2646, 0x5013),   /* Kingston KC3000, Kingston FURY Renegade */
+		.driver_data = NVME_QUIRK_NO_SECONDARY_TEMP_THRESH, },
 	{ PCI_DEVICE(0x2646, 0x5018),   /* KINGSTON OM8SFP4xxxxP OS21012 NVMe SSD */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x2646, 0x5016),   /* KINGSTON OM3PGP4xxxxP OS21011 NVMe SSD */
-- 
2.39.2



