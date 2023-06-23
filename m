Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F5973B95F
	for <lists+stable@lfdr.de>; Fri, 23 Jun 2023 16:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjFWOIA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 23 Jun 2023 10:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjFWOH6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Jun 2023 10:07:58 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2050.outbound.protection.outlook.com [40.92.90.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C1D2689
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 07:07:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhrH73DsDOzMWpW7Tgs9gNDvL/OPJcVG2cxz/o/ETnjhwWyigKPVe5QrgxE6O6Qd09dZY0d6XUJFVtHSFjuBWylQbxQEn7XVDJuUM0DDXjIs9mjGGmu8ndPxPDV9yjXcIENgXZcdFQNL0DZhD4PltfNQpVyL1BCsNRKoskT83dppPcsUIm48ywEjtNRKz6XfPzYiitsK3kTfzZ6X9FuIk738MFBa4629GDvPuJ9QUHyJ6keGuyMEflVID+dxo65/vlJ+DEEFj3ZUReydsltYmXfRkroWsRsARSPxjFd7P1kJuxgYTwYdbjAOZE57RFG5kkmgYfbAxu1YqLs18NwRZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0mXqXurALy9eS6K/S2VJsaWvAch8KCO3pBUJvJuDv8=;
 b=BrZaZGHthpsWKlCsrkzY/Z2yLo+WE35fHf4U9A5j0vyjg8GaVKePp44jhpBxeefHz4+iICzzuKNzMKGtyqQv1DfGrdzGKh/L6QeGt912V1p2+edYr56eahFpvCXNZ4ESwAwV1UqNWj0y3+NNO/SEYoMt19jg3KSESIKlNrnliILvpFqd9EqN/2l9u+/m9QAJfeDPlUXYT3sis0f3rxqfdwY1TGt9qKRgoRk4pEOGIjltygFzXE99I0pwASv6Wv+Otrfq7UHyBn9qB9Ly2FxDn99E1l02qE7S7JXSk7Q2e3tzdHWdanV++Ba92C11QkZjLPbeTctgg87JEqzAwGr6Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB4P250MB1032.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:3cc::7) by
 PR3P250MB0370.EURP250.PROD.OUTLOOK.COM (2603:10a6:102:17d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Fri, 23 Jun 2023 14:07:44 +0000
Received: from DB4P250MB1032.EURP250.PROD.OUTLOOK.COM
 ([fe80::1f3e:9e10:27b2:5ae4]) by DB4P250MB1032.EURP250.PROD.OUTLOOK.COM
 ([fe80::1f3e:9e10:27b2:5ae4%2]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 14:07:44 +0000
From:   Olivier Maignial <olivier.maignial@hotmail.fr>
To:     olivier.maignial@somfy.com
Cc:     Olivier Maignial <olivier.maignial@hotmail.fr>,
        stable@vger.kernel.org
Subject: [PATCH 1/2] mtd: spinand: toshiba: Fix ecc_get_status
Date:   Fri, 23 Jun 2023 16:07:21 +0200
Message-ID: <DB4P250MB103278A74C636547740F3CF0FE23A@DB4P250MB1032.EURP250.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [YG1OeFbMABK7hopdrWlhsugD442pvTo2]
X-ClientProxiedBy: PA7P264CA0310.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:395::7) To DB4P250MB1032.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:3cc::7)
X-Microsoft-Original-Message-ID: <20230623140722.3028981-1-olivier.maignial@hotmail.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4P250MB1032:EE_|PR3P250MB0370:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f0a36ba-48a5-4b6e-cd6c-08db73f33746
X-MS-Exchange-SLBlob-MailProps: mWtqiNqNgRtPdd8uo8VLeZ94y4B5qpXLhiiWJi7h2tEh9ZGkqFZlYCGABoeR5UO6jCbTbwxxe361FY5G8zIwODjZWT8zMMaIUHot1Oy6PQtEO+RTq0Jb5f5YNjFJBpzQjQgbQRdXTu7NEOsJoqwkd8heDTze/TYkTGhcD/nOV/6CR1lCGoQE6z8C4PsgXQlnSDmVoUQQiVg+r5F/rGgsvMXzxrMz3hVNIIabGWh2131Jj1/Vm+Jo3E/vfe0KCY+GzzXR0B11PSDhRXOGiSLdK5BzNySINne3s45Qx93PGLPXMAeHnvakQAhofYdvBQQxUEt7b2e+MG2NYf6GDm4TBb0kGRMlCwVvnvznc1RMNN465RhFV91QRr9jUkUbuGdHUJVGRuxSay80jOJwkoNoUAgkseeiwaFpYZxMkW8ScjI7VfGZB73oTMYJ8vbofA55YVPoYyxcRLisAaP0Vg+uU60pWJJ8ouMP7xJgGnSFv4+LK5G4zGQuPKjZceS8Qw76KAfJhw+43dxES8Tm0dwuVB7bQ6sDyXTvvfRm36rV7VWah2BJnFfdwO6Y1hCKz4oQklusCdzKxW/EW52qB+ZVqttMnLAZylIZ7xnf0uBoQA+6j3FDmycYQagdZoBzUmBXI+/1+f3HnFtaNKeWfo4TUC/+f1ik/6577E1qAEX4tLI8czLUFrcctm7EMuGGdl9rYHWCGw90JEEAmnr46kPdDiwPqCiSeRVBQcn8sZKGfLiXW07SYmbnKC5rEN8wbaXc3UJPP0xCK1Bu572PhjSCjJP+aHrpvqEztYr8x2Zan6k=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 95oc8SnNhGgrDj5heUAgZ5Twaukmd7loHoaWrWOKP3wnk/QFIUys+jtoIJkdu/oBOLNtrPV+o1UrrrKC1tmp9KIT9x/O3suvnn+u6QsfJM63GL3CExipQ/7Wb4dU2lBnH4Ax+e8UJfhF9pE7t5YZlr8LFWIG5OFMca3WMLRuhXtQDum6UzJ4JeIYA5INBjcKmHtO7WNCNaB/k3fF0v00mNV2R+dW/wuwsbug8E5BhSw+c1bi8X7aWN3QqvQ7o6K2Z9kYjtnK+JBySk/wiZhDFmAm1l74fZq+oCwEZih5l5PANDwlKmiyDkbE3f7eH/2YyaVRb/yRm0kBLWLF5WuNqS8YC7I4VnjDK31UpZMYnc1t5oipB7/G73JrNdo5vgvxqbZjcPhffL4AHJWE76np2lWZNErHsYL/VPT0bQjxl5B+/AMMv2x63F7iTym7Lj3gcGzif+ZsLSPGcthsdLBt8Bt1t5EOPZ52IjMtKOwDxcOs2noflYMSzpmnYze7wYqx1gKzSE4bgpnM/RKdSf8FEQdZ98VKwS6/0RO2JR++WJ6BE3wnwmMaErAVcnHXscPTumjlbXXzJ+NCKePUpyj6SuSmpK8RGUHeSzC9ujFG2G+BNkrsDSNTJGrfx9ShnHJXkGwghlyvWp3lQpuLy0ZH3g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?df2qxfVe5BENoaP7tF4unNuOUxj8qM821FpwMxQAOzbL014i2yfQVz6MS7ya?=
 =?us-ascii?Q?gkDOVz+n/E4mSsgVywbn6k62pQJ5g112wBBI6emE7pC64rcznTJkdAq+/Lon?=
 =?us-ascii?Q?v2jI6RFl5Y5Iy5FWjKdIwmo+5kD8vct9Loak0JSsFVUkQr8NimTIY98vWN+8?=
 =?us-ascii?Q?GE5UpJN0vxs0UaSiygp4kDo5vA2cSZ4WjKfICHzAso/hjlzxPtUGA1F2YKdr?=
 =?us-ascii?Q?uFniVIimUSZutfU/IUwXLQ2fjx0G+XMMdIQ6AUpr7lbVPFqazngjFdEjMAwz?=
 =?us-ascii?Q?r6vr4FfFxInniIYvhzLMR2ruw3pSo0UmKEa+TqPcMXB+wA6IQHDJnzRYk+Sl?=
 =?us-ascii?Q?a0FCO7YTb3u3v39REQvGhQbzqv5oOdJzEs+r4NJ5vGk+ZE+RYp1a6Cd4bz+G?=
 =?us-ascii?Q?bNvi1MmT7oivf4OMltlniMDo7Y2up6ij4fL9QAtsrOziFYQxT54YPsXs6L3N?=
 =?us-ascii?Q?j0tuqsXTXvcB9dXX9pu/BNSTfdFaVLGg0OYHp1clm+dzCwo9ZN/WZMuGL+zp?=
 =?us-ascii?Q?k/axQZ8uSEB2Tmh6Hz59UfwkRK+knwpoM15+hs+rAZY6bcy4QrGp1lOpN2x9?=
 =?us-ascii?Q?KgaSgBJwQbBmeNl+AcFAoWl7FEFQkb11UY0X0J6zZvLsp47QeqQvVRDA99QX?=
 =?us-ascii?Q?r86BU14+cGS1UdV7/UJq8ZnJbhj1lusLjyaEKEaEkkCVN5c0uqqAQqN6+vvd?=
 =?us-ascii?Q?1C6S5RtVVn7Kz6+FcDMD16Q5CV1CCidQBWOXy+sPnSfR6hM+paeKnPOAou4a?=
 =?us-ascii?Q?UVNyPfyqn8FNzAfk3jkprW2L+C79wTMZOg1kWYYuaAtvuDYNqLAcTHGzuPuW?=
 =?us-ascii?Q?xUm1+KAQHRP3ao3uAqMO1jWykgBF7fClI2YuYiRuzkIkqDA+hBjxEJTmNibh?=
 =?us-ascii?Q?1UCYVpI8+ZL3yRGQjXbYN0rrWZoU/49JZPxFrs2boraljquwXjn/iCnQjSlB?=
 =?us-ascii?Q?9NRomMc2lMyc1BLyRkROcrAvZs6lSSixjQnUdACyTEEKzYvePl5xeg1BzqnG?=
 =?us-ascii?Q?EuhFz+VpcSvvg+Lqz74IbJ+NYEClk2LJPGByIoHv8xJV0d5TsxlgAFckl9Wq?=
 =?us-ascii?Q?XsxhF3nYlZx/z/WkuabtQnBwJZoq3xbv3/z41z2StxkY1ve3gxJckm0s0TYz?=
 =?us-ascii?Q?aAaQ8BzQFANPLbJr0szlIzwRSjEvWtjoTd0Z4M0xce8oomaxayHXD6Ek1joc?=
 =?us-ascii?Q?bHkIHJsTbvcYALfiJ4ajRuOA2jilBB9nQlZVu4ngNdjjjLGU40jSakSKGC8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e3d53.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0a36ba-48a5-4b6e-cd6c-08db73f33746
X-MS-Exchange-CrossTenant-AuthSource: DB4P250MB1032.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 14:07:44.8176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P250MB0370
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPOOFED_FREEMAIL,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Reading ECC status is failing.

tx58cxgxsxraix_ecc_get_status() is using on-stack buffer
for SPINAND_GET_FEATURE_OP() output. It is not suitable
for DMA needs of spi-mem.

Fix this by using the spi-mem operations dedicated buffer
spinand->scratchbuf.

See
spinand->scratchbuf:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/mtd/spinand.h?h=v6.3#n418
spi_mem_check_op():
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi-mem.c?h=v6.3#n199

Fixes: 10949af1681d
Cc: stable@vger.kernel.org
Signed-off-by: Olivier Maignial <olivier.maignial@hotmail.fr>
---
 drivers/mtd/nand/spi/toshiba.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index 7380b1ebaccd..a80427c13121 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -73,7 +73,7 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 mbf = 0;
-	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, &mbf);
+	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, spinand->scratchbuf);
 
 	switch (status & STATUS_ECC_MASK) {
 	case STATUS_ECC_NO_BITFLIPS:
@@ -92,7 +92,7 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
 		if (spi_mem_exec_op(spinand->spimem, &op))
 			return nanddev_get_ecc_conf(nand)->strength;
 
-		mbf >>= 4;
+		mbf = *(spinand->scratchbuf) >> 4;
 
 		if (WARN_ON(mbf > nanddev_get_ecc_conf(nand)->strength || !mbf))
 			return nanddev_get_ecc_conf(nand)->strength;
-- 
2.34.1

