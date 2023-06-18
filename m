Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9B27345E5
	for <lists+stable@lfdr.de>; Sun, 18 Jun 2023 13:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjFRLlI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 18 Jun 2023 07:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjFRLlH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Jun 2023 07:41:07 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F384013D
        for <stable@vger.kernel.org>; Sun, 18 Jun 2023 04:41:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4EPQ/j5oDjWNhBPyWKM0lFX4QunMl8Ge7HmTwE0oDDL6dc+bd+g/wMbARU+EsLaurR11ai/3FSmY7secMMr3mir4Thwwz2ai8GyhLt9ctxglQ9uhV3IfsQ/OgxzjQr9GL+oHtXi1VEa8fHNL38xfU6yfjiXtsGFdttkhzqYBQD62GeWbUWm369vBRQCXITMxoP2Ookv8CcN03fYJf5N5O6x7t2t40onR7iRBv3yz4RRuWDrYKYb/x/VwjPz5M58G2sE9bsev/QdYa+wuVW0gQN+QvxybOgEDknH3eiZtUZUotUbK63O684Xf9uD72yMh9qO49kr0i77Qog+/Lid2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVZ6gHcxWb4UNPCIaCyenx1eJCSTYsx1FDSm/LXizRk=;
 b=hV2kF+PWmqXly8wExeuBVNnzf8DYsxjZBcwN19QrqmxIX6fCeHyhQFc/2ect+mD0zshdv8m0kr3TFXe/kbtKKHS1UCHlh+PuMEzHsqXj1IoZE2EX4nC3j8W+YpdP/+Kk0PD68enHe4jayUhr6v+6LC3gpiFIWY4okBfQl/8tnYGFpgLg8S9ivv8lSSqAfk7qMB0MVYKVSYW25eOitrdgDrds1BOTkaKA9iwJDvsiBtvlIgqqAzjcTaUHEkzBtBr6GynhwUegFGx9sT+laaSWftvgovjnr+eoboWZ0Q+sTNZdPQoiyUlHqXRu/apZffFzCA8p4I5ffu/uRLbzi1slig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.4.225.30) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=infinera.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=infinera.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVZ6gHcxWb4UNPCIaCyenx1eJCSTYsx1FDSm/LXizRk=;
 b=O7bXhQdY0kUaFZhmSHC4p2rSVzRqYEHQjXwmCIbrBn3lhGlCqIcH0COwNA/rJREsDzd55H3Uzxa+qQG45S1bZZJSmZzK1LZGBMF0u/rrC1wcRxLokw5eeJ/klVYbXqkx1zg1ZG1YaCrtR75LRj4AGi001T0o/2/8vaHQ885flKOksbsIaMx/OTm35TCh1D+rGhapmloEsk3GuDzb9V12wFHNhprIhPg7ZyZwhbDYPMKxTPVpPJcioNP1bkyrF/bPRd2DdCbIm16sNjkVg7YKF1f9tI0yVX0BMp7ZvTXeqh6bkDardSDpt/PG0rO1hosK88Qndl+KmSQiDwY+0McTnA==
Received: from DS7PR03CA0087.namprd03.prod.outlook.com (2603:10b6:5:3bb::32)
 by CH3PR10MB6761.namprd10.prod.outlook.com (2603:10b6:610:146::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Sun, 18 Jun
 2023 11:41:03 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:5:3bb:cafe::f5) by DS7PR03CA0087.outlook.office365.com
 (2603:10b6:5:3bb::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35 via Frontend
 Transport; Sun, 18 Jun 2023 11:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.4.225.30)
 smtp.mailfrom=infinera.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=infinera.com;
Received-SPF: Pass (protection.outlook.com: domain of infinera.com designates
 8.4.225.30 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.4.225.30; helo=owa.infinera.com; pr=C
Received: from owa.infinera.com (8.4.225.30) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.19 via Frontend Transport; Sun, 18 Jun 2023 11:41:01 +0000
Received: from sv-ex16-prd.infinera.com (10.100.96.229) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 18 Jun 2023 04:40:57 -0700
Received: from sv-smtp-prod3.infinera.com (10.100.98.58) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 18 Jun 2023 04:40:57 -0700
Received: from se-metroit-prd1.infinera.com ([10.210.32.58]) by sv-smtp-prod3.infinera.com with Microsoft SMTPSVC(8.5.9600.16384);
         Sun, 18 Jun 2023 04:40:57 -0700
Received: from gentoo-jocke.infinera.com (gentoo-jocke.infinera.com [10.210.71.73])
        by se-metroit-prd1.infinera.com (Postfix) with ESMTP id 7CEBC2C06D81;
        Sun, 18 Jun 2023 13:40:56 +0200 (CEST)
Received: by gentoo-jocke.infinera.com (Postfix, from userid 1001)
        id 79F862000BC8; Sun, 18 Jun 2023 13:40:56 +0200 (CEST)
From:   Joakim Tjernlund <joakim.tjernlund@infinera.com>
To:     "stable @ vger . kernel . org" <stable@vger.kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     Romain Izard <romain.izard.pro@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Joakim Tjernlund <joakim.tjernlund@infinera.com>
Subject: [PATCHv2 2/2] usb: gadget: f_ncm: Fix NTP-32 support
Date:   Sun, 18 Jun 2023 13:40:50 +0200
Message-ID: <20230618114050.2750443-2-joakim.tjernlund@infinera.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230618114050.2750443-1-joakim.tjernlund@infinera.com>
References: <2023061834-relative-gem-0d53@gregkh>
 <20230618114050.2750443-1-joakim.tjernlund@infinera.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 18 Jun 2023 11:40:57.0692 (UTC) FILETIME=[BF7F81C0:01D9A1D9]
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|CH3PR10MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: f24be145-3cb3-4d87-bf2f-08db6ff0e475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Jbeg9jDHyYNdT3cEIw6j0jT7w2exqqCuXpVerTpz3il+PNeev0F7EMMFdl1ap/d2dD3BsfbU5OrFZgRpz6+ge6BQbvEGOFxCBq/zFnR3wwGl0XTrcLhT5f1/45cJCzLHo3b1vmxpnKqxVHnK1+Wii5r9Jxn013m6yH0xAucZBGJqw0YAol6zBUZzusi1tVsRNe7htNqVUE1SbRiLWUExatpFO2047NpQFvjsjZzniFY5g69Ci8nS6zE7XRbCwW7zjyuCH4JtdTiGx4ffM6EVue5mU6Pnejb/I/uCrgowTKeSQ2/J9TmJGuyr4SS3xHKLlibJkYHxxxsQxVRm4tV35RZxqVKC1wmaASsPUoILFRiqu6aqS93s4LGEPIMi6uyj0QBCUpOmDN38IOU9F/FD1Dopu9axxbdmbDidVnShkXcTTw83GxtckuPTMmZiKFXJl5ro5ek8KIRmSxiJ69LMoYewVKUfj7wC5Th0fKedgfqvy+RESskbnvP/FJ5wzw9i+NvB0yoFg1USetV3SKxPiyTVmf3Woln77Eo7GYVa2SGcld5dzmQ8jI6xW7marJLmQnC9iEDh0ZieRyEoue1gWWq9hIGMA0RVk8ue1w/s0bgJ9fkH33Dhh7BW43Xp2ULYqRbhcx2+L1/rVWs1yeco8ZjFkrxBvOHvAr1oezZkNRHsLpc037H7pB3+RIzZnHfTJ8ruIo8RpfBy4gIMijyHyVcPcUCZz55HGXElzNkvqWQ2lcS6cbks3v+Djnvusgt
X-Forefront-Antispam-Report: CIP:8.4.225.30;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:owa.infinera.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39850400004)(136003)(451199021)(36840700001)(46966006)(70586007)(186003)(8676002)(70206006)(8936002)(6266002)(82740400003)(5660300002)(54906003)(42186006)(110136005)(4326008)(6666004)(82310400005)(316002)(478600001)(41300700001)(36756003)(26005)(1076003)(40480700001)(107886003)(426003)(336012)(81166007)(356005)(47076005)(86362001)(83380400001)(44832011)(2906002)(36860700001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2023 11:41:01.8188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f24be145-3cb3-4d87-bf2f-08db6ff0e475
X-MS-Exchange-CrossTenant-Id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=285643de-5f5b-4b03-a153-0ae2dc8aaf77;Ip=[8.4.225.30];Helo=[owa.infinera.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6761
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Romain Izard <romain.izard.pro@gmail.com>

upstream commit: 550eef0c353030ac4223b9c9479bdf77a05445d6

When connecting a CDC-NCM gadget to an host that uses the NTP-32 mode,
or that relies on the default CRC setting, the current implementation gets
confused, and does not expect the correct signature for its packets.

Fix this, by ensuring that the ndp_sign member in the f_ncm structure
always contain a valid value.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Cc: stable@vger.kernel.org # v4.19
---

 Seems to have been forgotten when backporting NCM fixes.
 Needed to make Win10 accept Linux NCM gadget ethernet

 drivers/usb/gadget/function/f_ncm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index b4571633f7b5..92a7c3a83945 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -36,9 +36,7 @@
 
 /* to trigger crc/non-crc ndp signature */
 
-#define NCM_NDP_HDR_CRC_MASK	0x01000000
 #define NCM_NDP_HDR_CRC		0x01000000
-#define NCM_NDP_HDR_NOCRC	0x00000000
 
 enum ncm_notify_state {
 	NCM_NOTIFY_NONE,		/* don't notify */
@@ -530,6 +528,7 @@ static inline void ncm_reset_values(struct f_ncm *ncm)
 {
 	ncm->parser_opts = &ndp16_opts;
 	ncm->is_crc = false;
+	ncm->ndp_sign = ncm->parser_opts->ndp_sign;
 	ncm->port.cdc_filter = DEFAULT_FILTER;
 
 	/* doesn't make sense for ncm, fixed size used */
@@ -812,25 +811,20 @@ static int ncm_setup(struct usb_function *f, const struct usb_ctrlrequest *ctrl)
 	case ((USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE) << 8)
 		| USB_CDC_SET_CRC_MODE:
 	{
-		int ndp_hdr_crc = 0;
-
 		if (w_length != 0 || w_index != ncm->ctrl_id)
 			goto invalid;
 		switch (w_value) {
 		case 0x0000:
 			ncm->is_crc = false;
-			ndp_hdr_crc = NCM_NDP_HDR_NOCRC;
 			DBG(cdev, "non-CRC mode selected\n");
 			break;
 		case 0x0001:
 			ncm->is_crc = true;
-			ndp_hdr_crc = NCM_NDP_HDR_CRC;
 			DBG(cdev, "CRC mode selected\n");
 			break;
 		default:
 			goto invalid;
 		}
-		ncm->ndp_sign = ncm->parser_opts->ndp_sign | ndp_hdr_crc;
 		value = 0;
 		break;
 	}
@@ -847,6 +841,8 @@ static int ncm_setup(struct usb_function *f, const struct usb_ctrlrequest *ctrl)
 			ctrl->bRequestType, ctrl->bRequest,
 			w_value, w_index, w_length);
 	}
+	ncm->ndp_sign = ncm->parser_opts->ndp_sign |
+		(ncm->is_crc ? NCM_NDP_HDR_CRC : 0);
 
 	/* respond with data transfer or status phase? */
 	if (value >= 0) {
-- 
2.39.3

