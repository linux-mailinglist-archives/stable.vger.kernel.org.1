Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9CE7556B0
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjGPUxC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjGPUxB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:53:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B377E9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:53:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE39860EB8
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8C1C433C7;
        Sun, 16 Jul 2023 20:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540779;
        bh=HazZpb7WfMdlFO82QNAD4dCrnb+STNa5eSQNGSxY7VM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iRb9x92sFUXWEfnRcGvFSNaoi9exhueQaVXMM/IszL3oRpSmZboXGlxoCkTDWSqbA
         L7X4sM+ndMq+BpokkdBLjLgZc6yHfPLHa+JMYD1e/LHEUhk+PdV3BBoMIqXkqxhG5p
         ceUz9H/rbNJXWfaKoGmClDqp1VERbgnVQUicddc0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 484/591] Bluetooth: MGMT: Use BIT macro when defining bitfields
Date:   Sun, 16 Jul 2023 21:50:23 +0200
Message-ID: <20230716194936.420073826@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit a80d2c545ded86d0350b9a870735565d8b749786 ]

This makes use of BIT macro when defining bitfields which makes it
clearer what bit it is toggling.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: 73f55453ea52 ("Bluetooth: MGMT: Fix marking SCAN_RSP as not connectable")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/mgmt.h | 80 ++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index e18a927669c0a..a5801649f6196 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -91,26 +91,26 @@ struct mgmt_rp_read_index_list {
 #define MGMT_MAX_NAME_LENGTH		(HCI_MAX_NAME_LENGTH + 1)
 #define MGMT_MAX_SHORT_NAME_LENGTH	(HCI_MAX_SHORT_NAME_LENGTH + 1)
 
-#define MGMT_SETTING_POWERED		0x00000001
-#define MGMT_SETTING_CONNECTABLE	0x00000002
-#define MGMT_SETTING_FAST_CONNECTABLE	0x00000004
-#define MGMT_SETTING_DISCOVERABLE	0x00000008
-#define MGMT_SETTING_BONDABLE		0x00000010
-#define MGMT_SETTING_LINK_SECURITY	0x00000020
-#define MGMT_SETTING_SSP		0x00000040
-#define MGMT_SETTING_BREDR		0x00000080
-#define MGMT_SETTING_HS			0x00000100
-#define MGMT_SETTING_LE			0x00000200
-#define MGMT_SETTING_ADVERTISING	0x00000400
-#define MGMT_SETTING_SECURE_CONN	0x00000800
-#define MGMT_SETTING_DEBUG_KEYS		0x00001000
-#define MGMT_SETTING_PRIVACY		0x00002000
-#define MGMT_SETTING_CONFIGURATION	0x00004000
-#define MGMT_SETTING_STATIC_ADDRESS	0x00008000
-#define MGMT_SETTING_PHY_CONFIGURATION	0x00010000
-#define MGMT_SETTING_WIDEBAND_SPEECH	0x00020000
-#define MGMT_SETTING_CIS_CENTRAL	0x00040000
-#define MGMT_SETTING_CIS_PERIPHERAL	0x00080000
+#define MGMT_SETTING_POWERED		BIT(0)
+#define MGMT_SETTING_CONNECTABLE	BIT(1)
+#define MGMT_SETTING_FAST_CONNECTABLE	BIT(2)
+#define MGMT_SETTING_DISCOVERABLE	BIT(3)
+#define MGMT_SETTING_BONDABLE		BIT(4)
+#define MGMT_SETTING_LINK_SECURITY	BIT(5)
+#define MGMT_SETTING_SSP		BIT(6)
+#define MGMT_SETTING_BREDR		BIT(7)
+#define MGMT_SETTING_HS			BIT(8)
+#define MGMT_SETTING_LE			BIT(9)
+#define MGMT_SETTING_ADVERTISING	BIT(10)
+#define MGMT_SETTING_SECURE_CONN	BIT(11)
+#define MGMT_SETTING_DEBUG_KEYS		BIT(12)
+#define MGMT_SETTING_PRIVACY		BIT(13)
+#define MGMT_SETTING_CONFIGURATION	BIT(14)
+#define MGMT_SETTING_STATIC_ADDRESS	BIT(15)
+#define MGMT_SETTING_PHY_CONFIGURATION	BIT(16)
+#define MGMT_SETTING_WIDEBAND_SPEECH	BIT(17)
+#define MGMT_SETTING_CIS_CENTRAL	BIT(18)
+#define MGMT_SETTING_CIS_PERIPHERAL	BIT(19)
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
@@ -635,21 +635,21 @@ struct mgmt_rp_get_phy_configuration {
 } __packed;
 #define MGMT_GET_PHY_CONFIGURATION_SIZE	0
 
-#define MGMT_PHY_BR_1M_1SLOT	0x00000001
-#define MGMT_PHY_BR_1M_3SLOT	0x00000002
-#define MGMT_PHY_BR_1M_5SLOT	0x00000004
-#define MGMT_PHY_EDR_2M_1SLOT	0x00000008
-#define MGMT_PHY_EDR_2M_3SLOT	0x00000010
-#define MGMT_PHY_EDR_2M_5SLOT	0x00000020
-#define MGMT_PHY_EDR_3M_1SLOT	0x00000040
-#define MGMT_PHY_EDR_3M_3SLOT	0x00000080
-#define MGMT_PHY_EDR_3M_5SLOT	0x00000100
-#define MGMT_PHY_LE_1M_TX		0x00000200
-#define MGMT_PHY_LE_1M_RX		0x00000400
-#define MGMT_PHY_LE_2M_TX		0x00000800
-#define MGMT_PHY_LE_2M_RX		0x00001000
-#define MGMT_PHY_LE_CODED_TX	0x00002000
-#define MGMT_PHY_LE_CODED_RX	0x00004000
+#define MGMT_PHY_BR_1M_1SLOT		BIT(0)
+#define MGMT_PHY_BR_1M_3SLOT		BIT(1)
+#define MGMT_PHY_BR_1M_5SLOT		BIT(2)
+#define MGMT_PHY_EDR_2M_1SLOT		BIT(3)
+#define MGMT_PHY_EDR_2M_3SLOT		BIT(4)
+#define MGMT_PHY_EDR_2M_5SLOT		BIT(5)
+#define MGMT_PHY_EDR_3M_1SLOT		BIT(6)
+#define MGMT_PHY_EDR_3M_3SLOT		BIT(7)
+#define MGMT_PHY_EDR_3M_5SLOT		BIT(8)
+#define MGMT_PHY_LE_1M_TX		BIT(9)
+#define MGMT_PHY_LE_1M_RX		BIT(10)
+#define MGMT_PHY_LE_2M_TX		BIT(11)
+#define MGMT_PHY_LE_2M_RX		BIT(12)
+#define MGMT_PHY_LE_CODED_TX		BIT(13)
+#define MGMT_PHY_LE_CODED_RX		BIT(14)
 
 #define MGMT_PHY_BREDR_MASK (MGMT_PHY_BR_1M_1SLOT | MGMT_PHY_BR_1M_3SLOT | \
 			     MGMT_PHY_BR_1M_5SLOT | MGMT_PHY_EDR_2M_1SLOT | \
@@ -974,11 +974,11 @@ struct mgmt_ev_auth_failed {
 	__u8	status;
 } __packed;
 
-#define MGMT_DEV_FOUND_CONFIRM_NAME		0x01
-#define MGMT_DEV_FOUND_LEGACY_PAIRING		0x02
-#define MGMT_DEV_FOUND_NOT_CONNECTABLE		0x04
-#define MGMT_DEV_FOUND_INITIATED_CONN		0x08
-#define MGMT_DEV_FOUND_NAME_REQUEST_FAILED	0x10
+#define MGMT_DEV_FOUND_CONFIRM_NAME		BIT(0)
+#define MGMT_DEV_FOUND_LEGACY_PAIRING		BIT(1)
+#define MGMT_DEV_FOUND_NOT_CONNECTABLE		BIT(2)
+#define MGMT_DEV_FOUND_INITIATED_CONN		BIT(3)
+#define MGMT_DEV_FOUND_NAME_REQUEST_FAILED	BIT(4)
 
 #define MGMT_EV_DEVICE_FOUND		0x0012
 struct mgmt_ev_device_found {
-- 
2.39.2



