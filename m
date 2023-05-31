Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C8D718887
	for <lists+stable@lfdr.de>; Wed, 31 May 2023 19:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjEaRfE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 31 May 2023 13:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjEaRfA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 31 May 2023 13:35:00 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B647211D
        for <stable@vger.kernel.org>; Wed, 31 May 2023 10:34:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fn84PnY+Q6ikOiL0ejGPRO3VUvQEsX2h3NAInbXFLmOHpdK1aTB+rSReRBAO61u2Kzzm3dAVwC0ydi4jig1Zcq4dH87U+KdWczdlyK1XMt9lFaNu5eF/Rix5znjNPXLqI6f/3izRUwhNkyj8VmSTlO4Iza7H3myDUxCVUg9T4wXrWGco/0LoXiJ+XAOe8m45/9Fs+/SkJ+HstdIJ/Y9uGR+XQW0FEZ3At6dNu/6Gg6z3Jbuu7sGbL/NoTq52kOTVAfGmDhAfR+mIyGLa21PsKGq+khRzqX0rOZ4UQAC0DmkefVQXQ5HHg7F6rrOP4mjCohn59XS4mIU0/pJvD2gV7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtXrEUH3c8sGoPHcqM+GgoOFj0+0zxwqxhZlPI82pMk=;
 b=V7CWmNnXI9S6FhsHPKbWRJwJdlL6Wo+3HeI+UGJE/HebxtKpVv0NTlaUzjsGMPpqwWO5e4nYEC1s7qOY9SImroyfXgkPyqZz1G44YLwShwL3ZgFRyZpszM0c8eNM0M8AkhpdKhXQxJkSVgXXypy1lVD/9sqZXkuurpI3SIGRU77AAFuSWPGTLTphxeDGj3irLTBnNfZUMXZiCBUjpUkQfY3Zl07EuX6glvxBIxfgKDHIZgfgYLj+nwcUXeY8oUvgmszwj3PgpcZakQs6UEkD+fmuHQZ8hU44Csw1HNxynpxKHCnYMdE4pvfwNT3LKhbNUK0XphJPvhRO7pRny21QCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.4.225.30) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=infinera.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=infinera.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtXrEUH3c8sGoPHcqM+GgoOFj0+0zxwqxhZlPI82pMk=;
 b=AIkmxh6gAqBqXobpLaHlpeQQ6fEFze4VhvN/zdOIUWPAJnXvqvW1eE24DKUllrZ+M0KyT2T6aQsPxQA4XRd7y5l9fPONx/yi/WTp4R/FqK2tTeHYQw9IM+WdJOfQWgm3DOsQvn2Zefz0rk9PGWhLJ6p4TsMyNKFj13dWuurJS7rW74zY7R4R5W5ENAVOZVC/zz3EU1UQYLibn6XQrsnCEfHSN9oSXnhkuESYe1mVrpTqbg2ezE/ZmxFwn6TXZzAwqN9RDizMlddCJ85MWdh+W2nLxFq/6TatYAQQ2fjModuDfmFO2rJCVXyzXiUVR7gGobbGvZnuV4Iev5GnGbw/dA==
Received: from MW4PR04CA0158.namprd04.prod.outlook.com (2603:10b6:303:85::13)
 by IA1PR10MB7470.namprd10.prod.outlook.com (2603:10b6:208:453::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 17:34:54 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::4f) by MW4PR04CA0158.outlook.office365.com
 (2603:10b6:303:85::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Wed, 31 May 2023 17:34:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.4.225.30)
 smtp.mailfrom=infinera.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=infinera.com;
Received-SPF: Pass (protection.outlook.com: domain of infinera.com designates
 8.4.225.30 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.4.225.30; helo=owa.infinera.com; pr=C
Received: from owa.infinera.com (8.4.225.30) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Wed, 31 May 2023 17:34:54 +0000
Received: from sv-ex16-prd.infinera.com (10.100.96.229) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 31 May 2023 10:34:53 -0700
Received: from sv-smtp-prod3.infinera.com (10.100.98.58) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 31 May 2023 10:34:53 -0700
Received: from se-metroit-prd1.infinera.com ([10.210.32.58]) by sv-smtp-prod3.infinera.com with Microsoft SMTPSVC(8.5.9600.16384);
         Wed, 31 May 2023 10:34:03 -0700
Received: from gentoo-jocke.infinera.com (gentoo-jocke.infinera.com [10.210.71.73])
        by se-metroit-prd1.infinera.com (Postfix) with ESMTP id B32E82C06D81;
        Wed, 31 May 2023 19:34:02 +0200 (CEST)
Received: by gentoo-jocke.infinera.com (Postfix, from userid 1001)
        id B09AC20062E8; Wed, 31 May 2023 19:34:02 +0200 (CEST)
From:   Joakim Tjernlund <joakim.tjernlund@infinera.com>
To:     <stable@vger.kernel.org>
CC:     Romain Izard <romain.izard.pro@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Joakim Tjernlund <joakim.tjernlund@infinera.com>
Subject: [PATCH 2/2] usb: gadget: f_ncm: Fix NTP-32 support
Date:   Wed, 31 May 2023 19:33:58 +0200
Message-ID: <20230531173358.910767-2-joakim.tjernlund@infinera.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230531173358.910767-1-joakim.tjernlund@infinera.com>
References: <20230531173358.910767-1-joakim.tjernlund@infinera.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 31 May 2023 17:34:04.0143 (UTC) FILETIME=[182BDFF0:01D993E6]
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT025:EE_|IA1PR10MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: ec329718-2033-45ec-cfaf-08db61fd58b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2erEEYW2qtgfSxGHMIUY3FQKDWVX4s2nAiQzgJxFrboc29gq6gRX40X0VPZKus4B5i1I0meKAbY4JSa4mQkqNDp9VN49ii05cLoDFTdUwDKwpkBo18TMkupIGNeoTyzci0giVLizBZZnIrvzNXPVoObcAYj42ww8NQjuF3gBziFi2aTcG35AMy6G4uu5nRUkcInjk3t0sxUh+uoG/2Ss1/Zc5X75X9409UdFTpyn8974rDYbAeEl7w6N1fp4WuMcaBF54sD4zgNvnUx5RfcvpCQZ4lvppmfrlTIYeCHUbVPr/FaCjNxVC+nOCXJBYAZBgi8ZbaH2jira2Cy75KZIR0S1gldhQrr1EY4a0qyapBAB6mT3YELB/XOmDgVs2hXqxdHjDk4qztrO85SCFaKFE1e2UxjKtt0EkNhZS94gGfaVR5+aoFJ8dslpAAnCsdpt1JG06VjZI9GBZHcpMsIV53U4lgL1vjh6/HG/X/xOCMlUQW5o5drcekE1AGMvfzwrOF38Qw+xsWbHeebcHkh8aAO3Q6Y8bOqKCXsoO0GHugOIe9n9YOx5nzGMOBWFra9pIBFL3vS6WM4lWOnuQ+WKqhHFOgdYi0b/NNUcvyhOZhlQ27xlpJPRshARQUfX6QvcFiWHtXK0GX4F/a7IhAnEw1nnrTZfSYOx9HmZ5/qN9Ip9zHVc2MeqQvErff1MV7WOpS1mazFKIJlHpxU1qkkuHoLKq+O3RzM38rmJm+zpAv90xaFhbWxcFMO52BhV7Zgz
X-Forefront-Antispam-Report: CIP:8.4.225.30;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:owa.infinera.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199021)(46966006)(36840700001)(107886003)(6666004)(47076005)(36860700001)(336012)(36756003)(426003)(83380400001)(2616005)(82310400005)(86362001)(356005)(81166007)(82740400003)(1076003)(26005)(186003)(6266002)(40480700001)(70206006)(6916009)(70586007)(2906002)(4326008)(54906003)(42186006)(8676002)(8936002)(316002)(5660300002)(41300700001)(44832011)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 17:34:54.5297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec329718-2033-45ec-cfaf-08db61fd58b4
X-MS-Exchange-CrossTenant-Id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=285643de-5f5b-4b03-a153-0ae2dc8aaf77;Ip=[8.4.225.30];Helo=[owa.infinera.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7470
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Romain Izard <romain.izard.pro@gmail.com>

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

