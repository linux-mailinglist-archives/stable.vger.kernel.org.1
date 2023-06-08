Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBEE728A4A
	for <lists+stable@lfdr.de>; Thu,  8 Jun 2023 23:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbjFHVf2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 8 Jun 2023 17:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjFHVf1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Jun 2023 17:35:27 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2075.outbound.protection.outlook.com [40.107.215.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015432D65;
        Thu,  8 Jun 2023 14:35:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKlLe09dTAwfq941jV0u+HKpgj7NeInVYnbZD1EP96CVSEGWieMmSkTZbYsLvq21dVvXTa/g8s5O7PUVyCd/FQXr7s9IzHBwOvydaipTpxOwA2dhmZPMuVMMLcHGyG86hscDyvDGDWA46W6MLo4wNpG4M58VM49kTjRn1ADK5mUWxAl1Yd1bh3KMGPeXNrloNsEvFgSG7glUDR+8ZAxqNL3J3cbW4YYcwVp0/kJOYPtgRQqY5Grdo/EDGKJjZ8HpA+DYu5Hm5isXTMjH+037Q4whuCM0mZX/5xjYKchLnvr3ssTsXTDjWvTtdZb1t3Mkv+QgZMVhv3LlRkmDgX0Bwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJT1PE4iHREf91gHKoi4RHY9vvI4g2/hnEzDVX+/z40=;
 b=k1d6SZlF3K/5W1vStEg+D7Jl3zO3U+MyyfbN+P+sw9WHPGNX0C5pzfjQ6FfCM73NKu/N6ZfsVsSQMHohIffgwRBADIHUpzXDgoRr29r4WLCzLHABkwCfMmJeMD1jsA9FfLFWcxV9d1PtP8gIbghH/ydsROM5U/0lZ/foQRELn4PoUUEv13qcg+PN+3mF2xmojnwIUNBvb9/NkQTxwIQkMYAGuoKXyiDYxHNpcJCi8jU8VOPM9wc20w/AF90TFKTgPKT6TgtX6L39P2Jzh3WGnzFGXH/UOK47XiaGaiVkB/uKHKoGPx8/mksW7xXDzQgOrP/iNV3jjTlC/kki7kjHvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sancloud.com; dmarc=pass action=none header.from=sancloud.com;
 dkim=pass header.d=sancloud.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sancloud.com;
Received: from SEYPR06MB5064.apcprd06.prod.outlook.com (2603:1096:101:55::13)
 by TYSPR06MB6750.apcprd06.prod.outlook.com (2603:1096:400:479::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Thu, 8 Jun
 2023 21:35:20 +0000
Received: from SEYPR06MB5064.apcprd06.prod.outlook.com
 ([fe80::de44:cc0c:5757:6626]) by SEYPR06MB5064.apcprd06.prod.outlook.com
 ([fe80::de44:cc0c:5757:6626%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 21:35:20 +0000
From:   Paul Barker <paul.barker@sancloud.com>
To:     stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Luis Machado <luis.machado@arm.com>,
        linux-ide@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Barker <paul.barker@sancloud.com>
Subject: [PATCH 5.15.y 1/2] ata: ahci: fix enum constants for gcc-13
Date:   Thu,  8 Jun 2023 22:34:57 +0100
Message-Id: <20230608213458.123923-2-paul.barker@sancloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608213458.123923-1-paul.barker@sancloud.com>
References: <20230608213458.123923-1-paul.barker@sancloud.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=17494; i=paul.barker@sancloud.com; h=from:subject; bh=AteFurDgQv+a6BEmTtjeM0IIq9q+2VSkgdKng1oFaiI=; b=owGbwMvMwCF2w7xIXuiX9CvG02pJDClNnvV2j/lmFX8yDvc9kVW3qaK4vp9lqYINV+L0wjccE 5yP3E/pKGVhEONgkBVTZNk9e9fl6w+WbO29IR0MM4eVCWQIAxenAEzkUBPDfx8dxuiqnE9Tb526 b1I2/eLhdV88px/SVJIxYZTcGvLw7U1GhnPf7fTybrb6sx6c4cVlWzE5P82SZfI+VpZ/Nydm39y wlBkA
X-Developer-Key: i=paul.barker@sancloud.com; a=openpgp; fpr=D2DDFDAE30017AF4CB62AA96A67255DFCCE62ECD
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: LO4P265CA0262.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::10) To SEYPR06MB5064.apcprd06.prod.outlook.com
 (2603:1096:101:55::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB5064:EE_|TYSPR06MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 038168c3-babe-4b75-a73f-08db6868426c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UAlzYGpxlxAL6vGthFCmU8X32Tvz9BRVzqz2uCZHH1Vo0qnm66+RiaH+0YQskDfFNbzEle09h28N05Rv55oLeob8CBGoXbeH2nLAnuL0vJqkA20ryjyQLiGvXhRgq3J17aCDWHCUVlr1VdswUue1FxpGvWCqAUDhzXXmD3f7dv79a0o4mdSKZX0co31U/z8dL1nRG1NjR59IVGH55/NnxgCH0lVBXVE1dTcJV9Oi8CQhY+wlDMdkarwTLFA0rbbYSgKiNod6pOQ9G/6fXT1Eobbk4Z1FLMox7W2hxm53vpRYY1DBYyp7/nNfD5hgfJTUknyxikEXdz8jrVcHrt7G52YF5qjX+8fYwx0ogIdUWSeFhOaL8Au8mMqo3G9BeHceHLzxScjoi4mMlIf722IfsMnfKPtSDZJ30xcdVcxzokchdo28pQL28H6cphUpVctf/I0/7Tl9hamEEBbeshSkUti47qKBuyCZVyJksNzU8ZIFiBZuMAfaF98V1SRPiH99eBF3KcdXFgB27tyUvN0qcasZSNkKBfn3xlPrTl1jAdhs34D0Mev8KCKrnRO2Ug4+1BKiNrHznXlPHKTBTSKpe5pMSG+eof9iv6j4cq4huJg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5064.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(366004)(376002)(136003)(346002)(396003)(451199021)(786003)(316002)(36756003)(86362001)(38350700002)(41300700001)(38100700002)(83380400001)(66946007)(26005)(6506007)(1076003)(6512007)(66476007)(66556008)(186003)(2616005)(4326008)(6916009)(6666004)(478600001)(41320700001)(107886003)(30864003)(54906003)(2906002)(52116002)(6486002)(44832011)(966005)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S0NQzwAlvlfHY7eSzz2vspfPsOwvyXnbValIPdXb3nyHPSJ4DRU+s2mirOO9?=
 =?us-ascii?Q?PkGlq4Y2nApNOqSHeQyeZWWJSg0iL9Y2Olqb77TH7HhnUwLegvU8W1Ul6itw?=
 =?us-ascii?Q?MMvFNk/Cdb2EKrrlGnWbrH6Koja+64hd9R7g5DDw0A+jXwDWblu8ak23/nAN?=
 =?us-ascii?Q?TLk5FZW3U3kpJXE35OVmSeYoZDe9neV0oejrdfWrI7zYm+UGQ+yiVwMITQl6?=
 =?us-ascii?Q?JKNOLYp+bJT2BZf0T8BYK81Qglg6AD0IZF0DAS6MU5yKQXP67QwbQfDY2x7p?=
 =?us-ascii?Q?Jbop++O2Pw7eWTfYcsxLZX+NHwoby+vkLuGg6Wxw9hH1RS7OI2ihvu8KTfXR?=
 =?us-ascii?Q?upzNyGquI/JvBErYpX7vIEr54kzEmz7mGwGkRjFxQaRZ8RRJu9YVLkrRJYAS?=
 =?us-ascii?Q?XOIvdNPWimXOAhhL3GxbiVnhXsbUKejwFsLGV1ceda3TqCC0INbQ6SM6Uy0T?=
 =?us-ascii?Q?stx26ifhvx9JwNSPoODU81VwH5HqXeRdAFHXKCeAY/15uIvr13yao/Q3TGEQ?=
 =?us-ascii?Q?ZB1HIKPLGmHHS5ru5FYucQ7jaTza7HbRfacUCKJ6RhuXUlQeY70ocwM9A3em?=
 =?us-ascii?Q?Mi+MghX06B9T3ZS1i9YcB9S1EPnGwG2gy1M84OWNktSQH5V6drEhcpXiwKJg?=
 =?us-ascii?Q?Uq7srdMHpfST+DGVx4Yu35k0vAUFOVOdtUHQKSA8jcKRLDOgW5tJWHeH/zsO?=
 =?us-ascii?Q?dPzpuV3cc4/n6U7Kzlf/O30yTja1UtW3vFXJpaiG9T/IvH2tn2dZziQsM82V?=
 =?us-ascii?Q?UiFZvIIsdns5hFV81R9D9imIkTTdZ8tcqBvUWQvciZ+TyDAQOknZf3YOTQnm?=
 =?us-ascii?Q?7kFKpeCz3ksbaHo2eoWr0lycD3C89PB4WU55DQoCRJ/ePiEY/MlgvQcQH8jG?=
 =?us-ascii?Q?sQkoAgz2NneYp5DNuKcUdi+2KaPCKhDfGJ3p8no3puglnijqdoXuhr3qfVkw?=
 =?us-ascii?Q?cqvXSr6+xjwnmkKuIJMYk3s9751Avvm5oiZ6Mlm1m4gaFPC137sowDEfmwyg?=
 =?us-ascii?Q?ikWhqKBCMn3vv7qza89kPG5nCkg62Mlo/1KcFF6ryRbLcvPDjvJK10wxnsvY?=
 =?us-ascii?Q?gt71VdUpTP5H3x1vcnDzZjmpEdT0W3dPLaxax/0UCrz1SHfXwWFMU5cJZtoX?=
 =?us-ascii?Q?2gCLR0FtPXw7+FourGCJaDb3+HwcFWggAZdJEprr/dSx+PHx48BS/U8aZGbn?=
 =?us-ascii?Q?H0BAjBHby6y79llBym9iWxPHlR2bV3xaJs+yNVG2i6beCR+NhYpT06nYEyy9?=
 =?us-ascii?Q?jcTLqPOmVdi6mDlnlK8L6iIoE3/lktGK1NQiybl4JeTnzMAhq4d/xbuoZSTD?=
 =?us-ascii?Q?DgjzjQGlYPNE9VHDmodGyGjTL2W6Cim7IAQQQupcWsOs2kPKJ9sJe1m+hUJi?=
 =?us-ascii?Q?/rgScuALHJI+ZNWy/2+qyfjtmfObyXgczsUXOp+SRv71/JSehR5fpny+t4Bm?=
 =?us-ascii?Q?mr2P93L9R1S+Ll3myOA3xgMuXWiQx5P4skM6/K0VvoOj8CJlQ+7H71H50sRo?=
 =?us-ascii?Q?HMwkEebojkjocMpe+2OtLuH2mg21IlDQovRTRQXdnokT0H99os3huBWOO+bO?=
 =?us-ascii?Q?l4/k9rNviwMwWj++Ot0vhWkOCRNZ2lIQhIzp1P9O76FuTUuBeLmSUArvvmtt?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: sancloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 038168c3-babe-4b75-a73f-08db6868426c
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5064.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 21:35:20.4700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3e0f949f-6a74-4378-baf2-0abfca8d5e06
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00nQDrl49pLvKMec+xrezZ2whU+Ao3zjIe0NRqjSheg5Dh3OYxBQbzaz/zT+aIVzfZ3EaWtxcDXMcbmZYpln8UUu9yqaNYnubpJ4TC9SmrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6750
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

commit f07788079f515ca4a681c5f595bdad19cfbd7b1d upstream.

gcc-13 slightly changes the type of constant expressions that are defined
in an enum, which triggers a compile time sanity check in libata:

linux/drivers/ata/libahci.c: In function 'ahci_led_store':
linux/include/linux/compiler_types.h:357:45: error: call to '__compiletime_assert_302' declared with attribute error: BUILD_BUG_ON failed: sizeof(_s) > sizeof(long)
357 | _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)

The new behavior is that sizeof() returns the same value for the
constant as it does for the enum type, which is generally more sensible
and consistent.

The problem in libata is that it contains a single enum definition for
lots of unrelated constants, some of which are large positive (unsigned)
integers like 0xffffffff, while others like (1<<31) are interpreted as
negative integers, and this forces the enum type to become 64 bit wide
even though most constants would still fit into a signed 32-bit 'int'.

Fix this by changing the entire enum definition to use BIT(x) in place
of (1<<x), which results in all values being seen as 'unsigned' and
fitting into an unsigned 32-bit type.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107917
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107405
Reported-by: Luis Machado <luis.machado@arm.com>
Cc: linux-ide@vger.kernel.org
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: stable@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Luis Machado <luis.machado@arm.com>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Modified to account for slight differences in the enum contents in the
5.15.y tree.
Signed-off-by: Paul Barker <paul.barker@sancloud.com>
---
 drivers/ata/ahci.h | 245 +++++++++++++++++++++++----------------------
 1 file changed, 123 insertions(+), 122 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 60ae707a88cc..dcc2d92cf6b6 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -24,6 +24,7 @@
 #include <linux/libata.h>
 #include <linux/phy/phy.h>
 #include <linux/regulator/consumer.h>
+#include <linux/bits.h>
 
 /* Enclosure Management Control */
 #define EM_CTRL_MSG_TYPE              0x000f0000
@@ -54,12 +55,12 @@ enum {
 	AHCI_PORT_PRIV_FBS_DMA_SZ	= AHCI_CMD_SLOT_SZ +
 					  AHCI_CMD_TBL_AR_SZ +
 					  (AHCI_RX_FIS_SZ * 16),
-	AHCI_IRQ_ON_SG		= (1 << 31),
-	AHCI_CMD_ATAPI		= (1 << 5),
-	AHCI_CMD_WRITE		= (1 << 6),
-	AHCI_CMD_PREFETCH	= (1 << 7),
-	AHCI_CMD_RESET		= (1 << 8),
-	AHCI_CMD_CLR_BUSY	= (1 << 10),
+	AHCI_IRQ_ON_SG		= BIT(31),
+	AHCI_CMD_ATAPI		= BIT(5),
+	AHCI_CMD_WRITE		= BIT(6),
+	AHCI_CMD_PREFETCH	= BIT(7),
+	AHCI_CMD_RESET		= BIT(8),
+	AHCI_CMD_CLR_BUSY	= BIT(10),
 
 	RX_FIS_PIO_SETUP	= 0x20,	/* offset of PIO Setup FIS data */
 	RX_FIS_D2H_REG		= 0x40,	/* offset of D2H Register FIS data */
@@ -77,37 +78,37 @@ enum {
 	HOST_CAP2		= 0x24, /* host capabilities, extended */
 
 	/* HOST_CTL bits */
-	HOST_RESET		= (1 << 0),  /* reset controller; self-clear */
-	HOST_IRQ_EN		= (1 << 1),  /* global IRQ enable */
-	HOST_MRSM		= (1 << 2),  /* MSI Revert to Single Message */
-	HOST_AHCI_EN		= (1 << 31), /* AHCI enabled */
+	HOST_RESET		= BIT(0),  /* reset controller; self-clear */
+	HOST_IRQ_EN		= BIT(1),  /* global IRQ enable */
+	HOST_MRSM		= BIT(2),  /* MSI Revert to Single Message */
+	HOST_AHCI_EN		= BIT(31), /* AHCI enabled */
 
 	/* HOST_CAP bits */
-	HOST_CAP_SXS		= (1 << 5),  /* Supports External SATA */
-	HOST_CAP_EMS		= (1 << 6),  /* Enclosure Management support */
-	HOST_CAP_CCC		= (1 << 7),  /* Command Completion Coalescing */
-	HOST_CAP_PART		= (1 << 13), /* Partial state capable */
-	HOST_CAP_SSC		= (1 << 14), /* Slumber state capable */
-	HOST_CAP_PIO_MULTI	= (1 << 15), /* PIO multiple DRQ support */
-	HOST_CAP_FBS		= (1 << 16), /* FIS-based switching support */
-	HOST_CAP_PMP		= (1 << 17), /* Port Multiplier support */
-	HOST_CAP_ONLY		= (1 << 18), /* Supports AHCI mode only */
-	HOST_CAP_CLO		= (1 << 24), /* Command List Override support */
-	HOST_CAP_LED		= (1 << 25), /* Supports activity LED */
-	HOST_CAP_ALPM		= (1 << 26), /* Aggressive Link PM support */
-	HOST_CAP_SSS		= (1 << 27), /* Staggered Spin-up */
-	HOST_CAP_MPS		= (1 << 28), /* Mechanical presence switch */
-	HOST_CAP_SNTF		= (1 << 29), /* SNotification register */
-	HOST_CAP_NCQ		= (1 << 30), /* Native Command Queueing */
-	HOST_CAP_64		= (1 << 31), /* PCI DAC (64-bit DMA) support */
+	HOST_CAP_SXS		= BIT(5),  /* Supports External SATA */
+	HOST_CAP_EMS		= BIT(6),  /* Enclosure Management support */
+	HOST_CAP_CCC		= BIT(7),  /* Command Completion Coalescing */
+	HOST_CAP_PART		= BIT(13), /* Partial state capable */
+	HOST_CAP_SSC		= BIT(14), /* Slumber state capable */
+	HOST_CAP_PIO_MULTI	= BIT(15), /* PIO multiple DRQ support */
+	HOST_CAP_FBS		= BIT(16), /* FIS-based switching support */
+	HOST_CAP_PMP		= BIT(17), /* Port Multiplier support */
+	HOST_CAP_ONLY		= BIT(18), /* Supports AHCI mode only */
+	HOST_CAP_CLO		= BIT(24), /* Command List Override support */
+	HOST_CAP_LED		= BIT(25), /* Supports activity LED */
+	HOST_CAP_ALPM		= BIT(26), /* Aggressive Link PM support */
+	HOST_CAP_SSS		= BIT(27), /* Staggered Spin-up */
+	HOST_CAP_MPS		= BIT(28), /* Mechanical presence switch */
+	HOST_CAP_SNTF		= BIT(29), /* SNotification register */
+	HOST_CAP_NCQ		= BIT(30), /* Native Command Queueing */
+	HOST_CAP_64		= BIT(31), /* PCI DAC (64-bit DMA) support */
 
 	/* HOST_CAP2 bits */
-	HOST_CAP2_BOH		= (1 << 0),  /* BIOS/OS handoff supported */
-	HOST_CAP2_NVMHCI	= (1 << 1),  /* NVMHCI supported */
-	HOST_CAP2_APST		= (1 << 2),  /* Automatic partial to slumber */
-	HOST_CAP2_SDS		= (1 << 3),  /* Support device sleep */
-	HOST_CAP2_SADM		= (1 << 4),  /* Support aggressive DevSlp */
-	HOST_CAP2_DESO		= (1 << 5),  /* DevSlp from slumber only */
+	HOST_CAP2_BOH		= BIT(0),  /* BIOS/OS handoff supported */
+	HOST_CAP2_NVMHCI	= BIT(1),  /* NVMHCI supported */
+	HOST_CAP2_APST		= BIT(2),  /* Automatic partial to slumber */
+	HOST_CAP2_SDS		= BIT(3),  /* Support device sleep */
+	HOST_CAP2_SADM		= BIT(4),  /* Support aggressive DevSlp */
+	HOST_CAP2_DESO		= BIT(5),  /* DevSlp from slumber only */
 
 	/* registers for each SATA port */
 	PORT_LST_ADDR		= 0x00, /* command list DMA addr */
@@ -129,24 +130,24 @@ enum {
 	PORT_DEVSLP		= 0x44, /* device sleep */
 
 	/* PORT_IRQ_{STAT,MASK} bits */
-	PORT_IRQ_COLD_PRES	= (1 << 31), /* cold presence detect */
-	PORT_IRQ_TF_ERR		= (1 << 30), /* task file error */
-	PORT_IRQ_HBUS_ERR	= (1 << 29), /* host bus fatal error */
-	PORT_IRQ_HBUS_DATA_ERR	= (1 << 28), /* host bus data error */
-	PORT_IRQ_IF_ERR		= (1 << 27), /* interface fatal error */
-	PORT_IRQ_IF_NONFATAL	= (1 << 26), /* interface non-fatal error */
-	PORT_IRQ_OVERFLOW	= (1 << 24), /* xfer exhausted available S/G */
-	PORT_IRQ_BAD_PMP	= (1 << 23), /* incorrect port multiplier */
-
-	PORT_IRQ_PHYRDY		= (1 << 22), /* PhyRdy changed */
-	PORT_IRQ_DEV_ILCK	= (1 << 7), /* device interlock */
-	PORT_IRQ_CONNECT	= (1 << 6), /* port connect change status */
-	PORT_IRQ_SG_DONE	= (1 << 5), /* descriptor processed */
-	PORT_IRQ_UNK_FIS	= (1 << 4), /* unknown FIS rx'd */
-	PORT_IRQ_SDB_FIS	= (1 << 3), /* Set Device Bits FIS rx'd */
-	PORT_IRQ_DMAS_FIS	= (1 << 2), /* DMA Setup FIS rx'd */
-	PORT_IRQ_PIOS_FIS	= (1 << 1), /* PIO Setup FIS rx'd */
-	PORT_IRQ_D2H_REG_FIS	= (1 << 0), /* D2H Register FIS rx'd */
+	PORT_IRQ_COLD_PRES	= BIT(31), /* cold presence detect */
+	PORT_IRQ_TF_ERR		= BIT(30), /* task file error */
+	PORT_IRQ_HBUS_ERR	= BIT(29), /* host bus fatal error */
+	PORT_IRQ_HBUS_DATA_ERR	= BIT(28), /* host bus data error */
+	PORT_IRQ_IF_ERR		= BIT(27), /* interface fatal error */
+	PORT_IRQ_IF_NONFATAL	= BIT(26), /* interface non-fatal error */
+	PORT_IRQ_OVERFLOW	= BIT(24), /* xfer exhausted available S/G */
+	PORT_IRQ_BAD_PMP	= BIT(23), /* incorrect port multiplier */
+
+	PORT_IRQ_PHYRDY		= BIT(22), /* PhyRdy changed */
+	PORT_IRQ_DEV_ILCK	= BIT(7),  /* device interlock */
+	PORT_IRQ_CONNECT	= BIT(6),  /* port connect change status */
+	PORT_IRQ_SG_DONE	= BIT(5),  /* descriptor processed */
+	PORT_IRQ_UNK_FIS	= BIT(4),  /* unknown FIS rx'd */
+	PORT_IRQ_SDB_FIS	= BIT(3),  /* Set Device Bits FIS rx'd */
+	PORT_IRQ_DMAS_FIS	= BIT(2),  /* DMA Setup FIS rx'd */
+	PORT_IRQ_PIOS_FIS	= BIT(1),  /* PIO Setup FIS rx'd */
+	PORT_IRQ_D2H_REG_FIS	= BIT(0),  /* D2H Register FIS rx'd */
 
 	PORT_IRQ_FREEZE		= PORT_IRQ_HBUS_ERR |
 				  PORT_IRQ_IF_ERR |
@@ -162,34 +163,34 @@ enum {
 				  PORT_IRQ_PIOS_FIS | PORT_IRQ_D2H_REG_FIS,
 
 	/* PORT_CMD bits */
-	PORT_CMD_ASP		= (1 << 27), /* Aggressive Slumber/Partial */
-	PORT_CMD_ALPE		= (1 << 26), /* Aggressive Link PM enable */
-	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
-	PORT_CMD_FBSCP		= (1 << 22), /* FBS Capable Port */
-	PORT_CMD_ESP		= (1 << 21), /* External Sata Port */
-	PORT_CMD_HPCP		= (1 << 18), /* HotPlug Capable Port */
-	PORT_CMD_PMP		= (1 << 17), /* PMP attached */
-	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
-	PORT_CMD_FIS_ON		= (1 << 14), /* FIS DMA engine running */
-	PORT_CMD_FIS_RX		= (1 << 4), /* Enable FIS receive DMA engine */
-	PORT_CMD_CLO		= (1 << 3), /* Command list override */
-	PORT_CMD_POWER_ON	= (1 << 2), /* Power up device */
-	PORT_CMD_SPIN_UP	= (1 << 1), /* Spin up device */
-	PORT_CMD_START		= (1 << 0), /* Enable port DMA engine */
-
-	PORT_CMD_ICC_MASK	= (0xf << 28), /* i/f ICC state mask */
-	PORT_CMD_ICC_ACTIVE	= (0x1 << 28), /* Put i/f in active state */
-	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
-	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
+	PORT_CMD_ASP		= BIT(27), /* Aggressive Slumber/Partial */
+	PORT_CMD_ALPE		= BIT(26), /* Aggressive Link PM enable */
+	PORT_CMD_ATAPI		= BIT(24), /* Device is ATAPI */
+	PORT_CMD_FBSCP		= BIT(22), /* FBS Capable Port */
+	PORT_CMD_ESP		= BIT(21), /* External Sata Port */
+	PORT_CMD_HPCP		= BIT(18), /* HotPlug Capable Port */
+	PORT_CMD_PMP		= BIT(17), /* PMP attached */
+	PORT_CMD_LIST_ON	= BIT(15), /* cmd list DMA engine running */
+	PORT_CMD_FIS_ON		= BIT(14), /* FIS DMA engine running */
+	PORT_CMD_FIS_RX		= BIT(4),  /* Enable FIS receive DMA engine */
+	PORT_CMD_CLO		= BIT(3),  /* Command list override */
+	PORT_CMD_POWER_ON	= BIT(2),  /* Power up device */
+	PORT_CMD_SPIN_UP	= BIT(1),  /* Spin up device */
+	PORT_CMD_START		= BIT(0),  /* Enable port DMA engine */
+
+	PORT_CMD_ICC_MASK	= (0xfu << 28), /* i/f ICC state mask */
+	PORT_CMD_ICC_ACTIVE	= (0x1u << 28), /* Put i/f in active state */
+	PORT_CMD_ICC_PARTIAL	= (0x2u << 28), /* Put i/f in partial state */
+	PORT_CMD_ICC_SLUMBER	= (0x6u << 28), /* Put i/f in slumber state */
 
 	/* PORT_FBS bits */
 	PORT_FBS_DWE_OFFSET	= 16, /* FBS device with error offset */
 	PORT_FBS_ADO_OFFSET	= 12, /* FBS active dev optimization offset */
 	PORT_FBS_DEV_OFFSET	= 8,  /* FBS device to issue offset */
 	PORT_FBS_DEV_MASK	= (0xf << PORT_FBS_DEV_OFFSET),  /* FBS.DEV */
-	PORT_FBS_SDE		= (1 << 2), /* FBS single device error */
-	PORT_FBS_DEC		= (1 << 1), /* FBS device error clear */
-	PORT_FBS_EN		= (1 << 0), /* Enable FBS */
+	PORT_FBS_SDE		= BIT(2), /* FBS single device error */
+	PORT_FBS_DEC		= BIT(1), /* FBS device error clear */
+	PORT_FBS_EN		= BIT(0), /* Enable FBS */
 
 	/* PORT_DEVSLP bits */
 	PORT_DEVSLP_DM_OFFSET	= 25,             /* DITO multiplier offset */
@@ -197,52 +198,52 @@ enum {
 	PORT_DEVSLP_DITO_OFFSET	= 15,             /* DITO offset */
 	PORT_DEVSLP_MDAT_OFFSET	= 10,             /* Minimum assertion time */
 	PORT_DEVSLP_DETO_OFFSET	= 2,              /* DevSlp exit timeout */
-	PORT_DEVSLP_DSP		= (1 << 1),       /* DevSlp present */
-	PORT_DEVSLP_ADSE	= (1 << 0),       /* Aggressive DevSlp enable */
+	PORT_DEVSLP_DSP		= BIT(1),         /* DevSlp present */
+	PORT_DEVSLP_ADSE	= BIT(0),         /* Aggressive DevSlp enable */
 
 	/* hpriv->flags bits */
 
 #define AHCI_HFLAGS(flags)		.private_data	= (void *)(flags)
 
-	AHCI_HFLAG_NO_NCQ		= (1 << 0),
-	AHCI_HFLAG_IGN_IRQ_IF_ERR	= (1 << 1), /* ignore IRQ_IF_ERR */
-	AHCI_HFLAG_IGN_SERR_INTERNAL	= (1 << 2), /* ignore SERR_INTERNAL */
-	AHCI_HFLAG_32BIT_ONLY		= (1 << 3), /* force 32bit */
-	AHCI_HFLAG_MV_PATA		= (1 << 4), /* PATA port */
-	AHCI_HFLAG_NO_MSI		= (1 << 5), /* no PCI MSI */
-	AHCI_HFLAG_NO_PMP		= (1 << 6), /* no PMP */
-	AHCI_HFLAG_SECT255		= (1 << 8), /* max 255 sectors */
-	AHCI_HFLAG_YES_NCQ		= (1 << 9), /* force NCQ cap on */
-	AHCI_HFLAG_NO_SUSPEND		= (1 << 10), /* don't suspend */
-	AHCI_HFLAG_SRST_TOUT_IS_OFFLINE	= (1 << 11), /* treat SRST timeout as
-							link offline */
-	AHCI_HFLAG_NO_SNTF		= (1 << 12), /* no sntf */
-	AHCI_HFLAG_NO_FPDMA_AA		= (1 << 13), /* no FPDMA AA */
-	AHCI_HFLAG_YES_FBS		= (1 << 14), /* force FBS cap on */
-	AHCI_HFLAG_DELAY_ENGINE		= (1 << 15), /* do not start engine on
-						        port start (wait until
-						        error-handling stage) */
-	AHCI_HFLAG_NO_DEVSLP		= (1 << 17), /* no device sleep */
-	AHCI_HFLAG_NO_FBS		= (1 << 18), /* no FBS */
+	AHCI_HFLAG_NO_NCQ		= BIT(0),
+	AHCI_HFLAG_IGN_IRQ_IF_ERR	= BIT(1), /* ignore IRQ_IF_ERR */
+	AHCI_HFLAG_IGN_SERR_INTERNAL	= BIT(2), /* ignore SERR_INTERNAL */
+	AHCI_HFLAG_32BIT_ONLY		= BIT(3), /* force 32bit */
+	AHCI_HFLAG_MV_PATA		= BIT(4), /* PATA port */
+	AHCI_HFLAG_NO_MSI		= BIT(5), /* no PCI MSI */
+	AHCI_HFLAG_NO_PMP		= BIT(6), /* no PMP */
+	AHCI_HFLAG_SECT255		= BIT(8), /* max 255 sectors */
+	AHCI_HFLAG_YES_NCQ		= BIT(9), /* force NCQ cap on */
+	AHCI_HFLAG_NO_SUSPEND		= BIT(10), /* don't suspend */
+	AHCI_HFLAG_SRST_TOUT_IS_OFFLINE	= BIT(11), /* treat SRST timeout as
+						      link offline */
+	AHCI_HFLAG_NO_SNTF		= BIT(12), /* no sntf */
+	AHCI_HFLAG_NO_FPDMA_AA		= BIT(13), /* no FPDMA AA */
+	AHCI_HFLAG_YES_FBS		= BIT(14), /* force FBS cap on */
+	AHCI_HFLAG_DELAY_ENGINE		= BIT(15), /* do not start engine on
+						      port start (wait until
+						      error-handling stage) */
+	AHCI_HFLAG_NO_DEVSLP		= BIT(17), /* no device sleep */
+	AHCI_HFLAG_NO_FBS		= BIT(18), /* no FBS */
 
 #ifdef CONFIG_PCI_MSI
-	AHCI_HFLAG_MULTI_MSI		= (1 << 20), /* per-port MSI(-X) */
+	AHCI_HFLAG_MULTI_MSI		= BIT(20), /* per-port MSI(-X) */
 #else
 	/* compile out MSI infrastructure */
 	AHCI_HFLAG_MULTI_MSI		= 0,
 #endif
-	AHCI_HFLAG_WAKE_BEFORE_STOP	= (1 << 22), /* wake before DMA stop */
-	AHCI_HFLAG_YES_ALPM		= (1 << 23), /* force ALPM cap on */
-	AHCI_HFLAG_NO_WRITE_TO_RO	= (1 << 24), /* don't write to read
-							only registers */
-	AHCI_HFLAG_IS_MOBILE		= (1 << 25), /* mobile chipset, use
-							SATA_MOBILE_LPM_POLICY
-							as default lpm_policy */
-	AHCI_HFLAG_SUSPEND_PHYS		= (1 << 26), /* handle PHYs during
-							suspend/resume */
-	AHCI_HFLAG_IGN_NOTSUPP_POWER_ON	= (1 << 27), /* ignore -EOPNOTSUPP
-							from phy_power_on() */
-	AHCI_HFLAG_NO_SXS		= (1 << 28), /* SXS not supported */
+	AHCI_HFLAG_WAKE_BEFORE_STOP	= BIT(22), /* wake before DMA stop */
+	AHCI_HFLAG_YES_ALPM		= BIT(23), /* force ALPM cap on */
+	AHCI_HFLAG_NO_WRITE_TO_RO	= BIT(24), /* don't write to read
+						      only registers */
+	AHCI_HFLAG_IS_MOBILE            = BIT(25), /* mobile chipset, use
+						      SATA_MOBILE_LPM_POLICY
+						      as default lpm_policy */
+	AHCI_HFLAG_SUSPEND_PHYS		= BIT(26), /* handle PHYs during
+						      suspend/resume */
+	AHCI_HFLAG_IGN_NOTSUPP_POWER_ON	= BIT(27), /* ignore -EOPNOTSUPP
+						      from phy_power_on() */
+	AHCI_HFLAG_NO_SXS		= BIT(28), /* SXS not supported */
 
 	/* ap->flags bits */
 
@@ -258,22 +259,22 @@ enum {
 	EM_MAX_RETRY			= 5,
 
 	/* em_ctl bits */
-	EM_CTL_RST		= (1 << 9), /* Reset */
-	EM_CTL_TM		= (1 << 8), /* Transmit Message */
-	EM_CTL_MR		= (1 << 0), /* Message Received */
-	EM_CTL_ALHD		= (1 << 26), /* Activity LED */
-	EM_CTL_XMT		= (1 << 25), /* Transmit Only */
-	EM_CTL_SMB		= (1 << 24), /* Single Message Buffer */
-	EM_CTL_SGPIO		= (1 << 19), /* SGPIO messages supported */
-	EM_CTL_SES		= (1 << 18), /* SES-2 messages supported */
-	EM_CTL_SAFTE		= (1 << 17), /* SAF-TE messages supported */
-	EM_CTL_LED		= (1 << 16), /* LED messages supported */
+	EM_CTL_RST		= BIT(9), /* Reset */
+	EM_CTL_TM		= BIT(8), /* Transmit Message */
+	EM_CTL_MR		= BIT(0), /* Message Received */
+	EM_CTL_ALHD		= BIT(26), /* Activity LED */
+	EM_CTL_XMT		= BIT(25), /* Transmit Only */
+	EM_CTL_SMB		= BIT(24), /* Single Message Buffer */
+	EM_CTL_SGPIO		= BIT(19), /* SGPIO messages supported */
+	EM_CTL_SES		= BIT(18), /* SES-2 messages supported */
+	EM_CTL_SAFTE		= BIT(17), /* SAF-TE messages supported */
+	EM_CTL_LED		= BIT(16), /* LED messages supported */
 
 	/* em message type */
-	EM_MSG_TYPE_LED		= (1 << 0), /* LED */
-	EM_MSG_TYPE_SAFTE	= (1 << 1), /* SAF-TE */
-	EM_MSG_TYPE_SES2	= (1 << 2), /* SES-2 */
-	EM_MSG_TYPE_SGPIO	= (1 << 3), /* SGPIO */
+	EM_MSG_TYPE_LED		= BIT(0), /* LED */
+	EM_MSG_TYPE_SAFTE	= BIT(1), /* SAF-TE */
+	EM_MSG_TYPE_SES2	= BIT(2), /* SES-2 */
+	EM_MSG_TYPE_SGPIO	= BIT(3), /* SGPIO */
 };
 
 struct ahci_cmd_hdr {
-- 
2.34.1

