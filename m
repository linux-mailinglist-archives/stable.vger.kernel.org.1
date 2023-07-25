Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF88A7612C9
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbjGYLFi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbjGYLFV (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:05:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974552709
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:03:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BFC6615BA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF5AC433C7;
        Tue, 25 Jul 2023 11:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282988;
        bh=9b+9aKuIZCx+bFQNZ80VhD+Nbq2DsN2OchqWP/egD/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=drncV65JX3dU4bnEC1Va79p1raeKBD5EZnhDsSyyt9LQoe69BO/8ok+vBeS0a1gzm
         sq3U/N4oHND/W3QGjj0wpyNi/lepHkeAyNF44S6pm1GTluQ9CSgZZDKi+5pT/2ZFT+
         LLNjUD4QC1tPxS52NGTorEUOAqYJ3xPJvOQUAFN0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wen Gong <quic_wgong@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 070/183] wifi: ath11k: add support default regdb while searching board-2.bin for WCN6855
Date:   Tue, 25 Jul 2023 12:44:58 +0200
Message-ID: <20230725104510.503846442@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Wen Gong <quic_wgong@quicinc.com>

[ Upstream commit 88ca89202f8e8afb5225eb5244d79cd67c15d744 ]

Sometimes board-2.bin does not have the regdb data which matched the
parameters such as vendor, device, subsystem-vendor, subsystem-device
and etc. Add default regdb data with 'bus=%s' into board-2.bin for
WCN6855, then ath11k use 'bus=pci' to search regdb data in board-2.bin
for WCN6855.

kernel: [  122.515808] ath11k_pci 0000:03:00.0: boot using board name 'bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262'
kernel: [  122.517240] ath11k_pci 0000:03:00.0: boot firmware request ath11k/WCN6855/hw2.0/board-2.bin size 6179564
kernel: [  122.517280] ath11k_pci 0000:03:00.0: failed to fetch regdb data for bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262 from ath11k/WCN6855/hw2.0/board-2.bin
kernel: [  122.517464] ath11k_pci 0000:03:00.0: boot using board name 'bus=pci'
kernel: [  122.518901] ath11k_pci 0000:03:00.0: boot firmware request ath11k/WCN6855/hw2.0/board-2.bin size 6179564
kernel: [  122.518915] ath11k_pci 0000:03:00.0: board name
kernel: [  122.518917] ath11k_pci 0000:03:00.0: 00000000: 62 75 73 3d 70 63 69                             bus=pci
kernel: [  122.518918] ath11k_pci 0000:03:00.0: boot found match regdb data for name 'bus=pci'
kernel: [  122.518920] ath11k_pci 0000:03:00.0: boot found regdb data for 'bus=pci'
kernel: [  122.518921] ath11k_pci 0000:03:00.0: fetched regdb

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230517133959.8224-1-quic_wgong@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/core.c | 53 +++++++++++++++++++-------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index b99180bc81723..893fefadbba96 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -870,7 +870,8 @@ int ath11k_core_check_dt(struct ath11k_base *ab)
 }
 
 static int __ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
-					   size_t name_len, bool with_variant)
+					   size_t name_len, bool with_variant,
+					   bool bus_type_mode)
 {
 	/* strlen(',variant=') + strlen(ab->qmi.target.bdf_ext) */
 	char variant[9 + ATH11K_QMI_BDF_EXT_STR_LENGTH] = { 0 };
@@ -881,15 +882,20 @@ static int __ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
 
 	switch (ab->id.bdf_search) {
 	case ATH11K_BDF_SEARCH_BUS_AND_BOARD:
-		scnprintf(name, name_len,
-			  "bus=%s,vendor=%04x,device=%04x,subsystem-vendor=%04x,subsystem-device=%04x,qmi-chip-id=%d,qmi-board-id=%d%s",
-			  ath11k_bus_str(ab->hif.bus),
-			  ab->id.vendor, ab->id.device,
-			  ab->id.subsystem_vendor,
-			  ab->id.subsystem_device,
-			  ab->qmi.target.chip_id,
-			  ab->qmi.target.board_id,
-			  variant);
+		if (bus_type_mode)
+			scnprintf(name, name_len,
+				  "bus=%s",
+				  ath11k_bus_str(ab->hif.bus));
+		else
+			scnprintf(name, name_len,
+				  "bus=%s,vendor=%04x,device=%04x,subsystem-vendor=%04x,subsystem-device=%04x,qmi-chip-id=%d,qmi-board-id=%d%s",
+				  ath11k_bus_str(ab->hif.bus),
+				  ab->id.vendor, ab->id.device,
+				  ab->id.subsystem_vendor,
+				  ab->id.subsystem_device,
+				  ab->qmi.target.chip_id,
+				  ab->qmi.target.board_id,
+				  variant);
 		break;
 	default:
 		scnprintf(name, name_len,
@@ -908,13 +914,19 @@ static int __ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
 static int ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
 					 size_t name_len)
 {
-	return __ath11k_core_create_board_name(ab, name, name_len, true);
+	return __ath11k_core_create_board_name(ab, name, name_len, true, false);
 }
 
 static int ath11k_core_create_fallback_board_name(struct ath11k_base *ab, char *name,
 						  size_t name_len)
 {
-	return __ath11k_core_create_board_name(ab, name, name_len, false);
+	return __ath11k_core_create_board_name(ab, name, name_len, false, false);
+}
+
+static int ath11k_core_create_bus_type_board_name(struct ath11k_base *ab, char *name,
+						  size_t name_len)
+{
+	return __ath11k_core_create_board_name(ab, name, name_len, false, true);
 }
 
 const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
@@ -1218,7 +1230,7 @@ int ath11k_core_fetch_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd)
 
 int ath11k_core_fetch_regdb(struct ath11k_base *ab, struct ath11k_board_data *bd)
 {
-	char boardname[BOARD_NAME_SIZE];
+	char boardname[BOARD_NAME_SIZE], default_boardname[BOARD_NAME_SIZE];
 	int ret;
 
 	ret = ath11k_core_create_board_name(ab, boardname, BOARD_NAME_SIZE);
@@ -1235,6 +1247,21 @@ int ath11k_core_fetch_regdb(struct ath11k_base *ab, struct ath11k_board_data *bd
 	if (!ret)
 		goto exit;
 
+	ret = ath11k_core_create_bus_type_board_name(ab, default_boardname,
+						     BOARD_NAME_SIZE);
+	if (ret) {
+		ath11k_dbg(ab, ATH11K_DBG_BOOT,
+			   "failed to create default board name for regdb: %d", ret);
+		goto exit;
+	}
+
+	ret = ath11k_core_fetch_board_data_api_n(ab, bd, default_boardname,
+						 ATH11K_BD_IE_REGDB,
+						 ATH11K_BD_IE_REGDB_NAME,
+						 ATH11K_BD_IE_REGDB_DATA);
+	if (!ret)
+		goto exit;
+
 	ret = ath11k_core_fetch_board_data_api_1(ab, bd, ATH11K_REGDB_FILE_NAME);
 	if (ret)
 		ath11k_dbg(ab, ATH11K_DBG_BOOT, "failed to fetch %s from %s\n",
-- 
2.39.2



