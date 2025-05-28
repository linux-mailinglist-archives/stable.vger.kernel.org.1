Return-Path: <stable+bounces-147940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F39EBAC66B1
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 12:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A465D178BA3
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 10:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D641C2797B5;
	Wed, 28 May 2025 10:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="PAkorKI0"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2125.outbound.protection.outlook.com [40.107.105.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE3A27979C
	for <stable@vger.kernel.org>; Wed, 28 May 2025 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748426928; cv=fail; b=sq1vGYPIiV+ifkQPkjOr+qESPFbrre7dBRRGoPDidYOW8qYXoi2ElPRJncuGktYFL0r0VbfbU61xCqqOFt3clJYXIoeFb7G/B9J7mXpLFWlBiBfmfArq23Cx8Rzn6KkGf1Vr5SyLMgcg33Zz2TRfb5CH/eOUY7C2n/e3HlETt1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748426928; c=relaxed/simple;
	bh=WbDJs19003GbWXihaBI1VVwcaKxbriXTaQq/4JPEcsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fuSCmKQaqma/WPlOQodVBdsx+wESlxzyLZfc6Ttb61XslqXA1b9ZxRROhl0dPxPbI+tPXiarOb3G0q2J01k+D22Iy3m86vVNlH/IZR8RmIDeQ6gg5Hajrs9SitZNdtKAd/n+pVEj3ijyvhAwYsf/fXwFXYpQUSmWGWInOR1R2eE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=PAkorKI0; arc=fail smtp.client-ip=40.107.105.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qeza6cnuHUh7ukUBgUYycHrOCoG628Yv7z6GlfkG5wjo/8RijvICo1e4on3Fj2y1QH1FrfexFa9REMdSH5vD6SaulhNs/jqgWW09Zp+bRonWF8PoUynmqAar7PbvEAUczHc0jtWNPdbCEP2oueEaRNH6Ev0DcWMfq6dvOYZZqETqIpiWr5CO0QTKiaFDdL5Bgj0DCEi6ag9uOhVrzjgC3D5OJVpDGu6wAFr6v55vnNKNItLDLsrVY7BAc8PhfZY+dYSTBQ/wHvKubuCiDNA8jVzQjYR6qPyGHi7w3vTESHRMkk+ZKDruG1WvCtxzj9T/ufVKjpgxPVvK23oM8Et3ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jt8rHJiN3IrXwO1PxczJF/4TMvN9PeNYvNm2C69TRP4=;
 b=putg4c57orgeAzgevOvW+oKY6N00FcjLSNaeawmwowYQ+m07wrcAsCzx2epGekGVa7pyFHgdNk6DEejHBgvSNoDN+OskNzZpJeqFswDKuZG3+r9BELyUWAxN2mKStYLJ93FMr6uhLSdUCnP7VPDY6ksw6AgO9fcPTJra6+Q6MSWgGJMsgU+pPkGlwnWmsgj84ailQbOiIn6n+jsriQcZwFKzfCG7KJ9ux2lDVY+JjjybggINqO4cdQDxiNyi9+OxiVnVwIlIGb/XDFjU9yZq8TSOVmlW9QR5v+OysA2xO/6VRHSKBTTNvCdf3oX6xR6d8TRO+rQg4yb8H2wWCkeyLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jt8rHJiN3IrXwO1PxczJF/4TMvN9PeNYvNm2C69TRP4=;
 b=PAkorKI0X2JIs5AIF9kGkDYlhH+mmo3gCRNHbXO9l6D1k+KZULq3zXqFUDBd0SHaLAYY3FoFCQKntEgn+hQkpKlWnN+0e4O0HOLUSjedvD4bDH8WVhsQhid0ghiTdxMBW1i2rPVde5d/2ksOlKt/HXiaICecxHvF3hYqg6Glvi0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3ed::14)
 by AM0P193MB0673.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:16e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 10:08:34 +0000
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18]) by AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18%7]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 10:08:33 +0000
From: Axel Forsman <axfo@kvaser.com>
To: stable@vger.kernel.org
Cc: Axel Forsman <axfo@kvaser.com>,
	Jimmy Assarsson <extja@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.6.y] can: kvaser_pciefd: Force IRQ edge in case of nested IRQ
Date: Wed, 28 May 2025 12:08:16 +0200
Message-ID: <20250528100816.195747-1-axfo@kvaser.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025052430-customary-paramount-b71a@gregkh>
References: <2025052430-customary-paramount-b71a@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0001A047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::491) To AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:3ed::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P193MB1652:EE_|AM0P193MB0673:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d11af6b-20ad-4e40-8d54-08dd9dcf9a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NqADJchf4Wcgk/fcvda9/INTJ+swyYY1mK6+3HDIp+aukTf3pbu4nA1BIT67?=
 =?us-ascii?Q?EvW6K7DgirThOzIrKWVstF+rGt7BztKOFrl/nTyn4Ne2hg//hUjkA01UBhrd?=
 =?us-ascii?Q?PmGawjGzjlV8xVwUuFzi6uTNaDCmpZUvZ/GpuwRGjE5EVHD7yUlfBWwa1dm8?=
 =?us-ascii?Q?uSsYFXvFkvpeXdQc3aW5V5aHQdbKWqiQ4Np6fpJmk4KkkJZUa5w0nIiuX64D?=
 =?us-ascii?Q?rK6yfFfzZEMfCKgSn7DxsleQOanwzLXUUct3rdKvGCHk5YWk1YhycLKqDEci?=
 =?us-ascii?Q?r3O3wsxU73+SrbYllTO4h1/ozfoht05caJ9uorCMi4gLYHXCOzdw04EyjAh0?=
 =?us-ascii?Q?zCN/i15EFKBPtpA0hQkh/EmnZKKksaMoSBw9ZPpH9lGwznB31Fu4NWAaD3Tm?=
 =?us-ascii?Q?FKXAHm9299rUvyoypFNecG0FFYW9b/t5cGM8EEy8A+uEpt6d8tHgoSaBPDTC?=
 =?us-ascii?Q?2ggLzwP3jPLk7/oLQjP23BzoV3gA9uEaZA9tS4NM0kDz5RbRm8yBieZoJf87?=
 =?us-ascii?Q?Q4ptxkQeYi09mJnATFQzijH6832YIrpC88/p06J+mNLZj8Rw6Ahe/ARHj+uR?=
 =?us-ascii?Q?3oNheUWK/M+qUMbnRL5jWWxxHcAACdHtkhKGtSbwBBANZOCNj9ZnIAcf7IfN?=
 =?us-ascii?Q?mCbz1Mpxea/BmKgsq1j8rG9/MzQ+75kcLu9dP/cR/DBfUJDKy8GD0XIOKkiv?=
 =?us-ascii?Q?n8aUSQPCOWiNWypdbhxKL93Otsen7qHtX99DuHAK/Glk3KI/wdud66tB0/Pd?=
 =?us-ascii?Q?Qe0YxAppEo9SiLkZnop2fEmO/fHpdwGbs7YWGnMEh3Ock0lSN57Io/5VIoTD?=
 =?us-ascii?Q?jiisvMtb8PkK03V3DsbkSYOB2O+gYYcD+DkJ78T9J25wdjKvs0d8b1yflXc0?=
 =?us-ascii?Q?DlcDtxTIfe8vsWaUPNkZcAbrX4mVq8nA2JdeQWrvXN20gfk9F+RQ2CWl93PO?=
 =?us-ascii?Q?9EsP2aKVsPBXew8P6SD8c76z/RT7KO7h0GchVJw0u7XqBGhdocVc5uAKd44H?=
 =?us-ascii?Q?WXRLCmsOm3kab0oGC0IqZTJqzxgmkm7OuZoW0vDP03rog93K7U6JOFwr3blm?=
 =?us-ascii?Q?mtUHkdncB1mh1RRqv7VL9NkElXo1WMkyNG+CxF4XuZBtprWPTfG+I4V830Sc?=
 =?us-ascii?Q?eCH6QT9LaBoIpn8y8dO0xdiwgKss640sDEFldWBb8qDz8uCy44a+lUfoZ/yx?=
 =?us-ascii?Q?m6KO1zBnwxgrGxFvBFp+uubmRS9d2DM6o8FMrDLtistM717TdGm2Xzs+dFgJ?=
 =?us-ascii?Q?6w980jFwZS355z51ZMz8ec3ig8H/AoJ2nAGpVcGQdp1qvDPWKn16FM2JuM6r?=
 =?us-ascii?Q?xiRX9iIP9Ox7K0wRf694A0o/YgwGZU7iGIKF/LOieye7/apTar/JxCxvG2Sr?=
 =?us-ascii?Q?F3m5sKw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1652.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?94qen1NE2tbCiEQ1px09k85nSc1IuYNCD+wCpaOdRJ5aq/htkdGYzeE0dSSM?=
 =?us-ascii?Q?YZLxfpPWAhyEpYckWYNjrVksX1Rhtv2bmbOxk6jgOxZrd5+rwAD3ciUtheYi?=
 =?us-ascii?Q?YeK8HXFqD/a1YK0JelquabKBNeG7QVvBk/h5B+Sgh+BKKSMpNERQVppaziun?=
 =?us-ascii?Q?5tLT6VIFep0uN4+GySUmhDUlpd02tbzXpDtwpfsfBnbJg+AFjJGamSJkp12Q?=
 =?us-ascii?Q?NjS7pQOgw86i0eC9OdcqC+jACv+ZOq3YJkX6wUAnotUNRSN5uAYbTTWNi1xs?=
 =?us-ascii?Q?9p91lXR3M0vcIVjt2s3I+fe8lONZ589CAUyBNaLvqyeZvOVzaeCWqiAJPZB0?=
 =?us-ascii?Q?7JACE+q01EdxwUtxgroUnD2kQr1/apAE6OuAlkD/oM1Iie1aTFcklrF1gnxD?=
 =?us-ascii?Q?r6JPbH6BC0864B9kjbupSibXmoofY99hErZIRjCJH31DFIjvjEqsRzn5a1A+?=
 =?us-ascii?Q?x72ViNwKV93dxukLP638+3xWbyGo5gLDq6oVBuTg7G1pN/ky+4xwYeFnj5zS?=
 =?us-ascii?Q?xIVlZAC7PCTTu7TNq6icNS/l2GbPOBPbPayiEzaNf9EHThchbleibCj7FNMi?=
 =?us-ascii?Q?EGzL24URdZiVnOx8p9RclLdiDJsHNJj41lVeSlZjeR96G1mSEcrKGi2/9D8J?=
 =?us-ascii?Q?fkc2H/XJkrYU1JIwdDd0+UwOUgkqUb5DwSbg23IqmgZsJ/p4cZZL/8KI4sqT?=
 =?us-ascii?Q?Tb9sxMogQFXnylnH2NTrxfOVgizWJHDdB2qc43Fj1Wx6K5UIYaogeL3xxyTK?=
 =?us-ascii?Q?Miqo0nMtw09pHzfqv+yUBu1TV4MPYtU+9U/FeCD2gaLP88ydrjEXBbcuz+xs?=
 =?us-ascii?Q?2z5+4VBDdw/C8CbSMcRDg5E09aa7dhQGMGn1LKd6hY44mmB9rDbjxVc7DFe8?=
 =?us-ascii?Q?qVldPYCiD6FqivWb1ryTNlG1sY/JZA/olLQgRG3fIKhE6sltQQAMu9mqEhoR?=
 =?us-ascii?Q?Sqg5Avgr8Lqklb1NGXvt0tqQdtWmGW+pyBr4F9AUR6CW8BgND8HAA+e3j0cy?=
 =?us-ascii?Q?GFPYM9E6bJ4hFPBRxIwSyd0CgXGi/HRrW6sPyeGxdyBiGss3V/ox5IbPPO0/?=
 =?us-ascii?Q?ff90Cf75HX+2NdPDXPog6MLDaAseNMfFNTpW3FJKS/CS5pUwWPrDmTLzI4N0?=
 =?us-ascii?Q?P4cQeXEI5KUNb0OsxRi2Q4VsL7FYc4tkgGxj6EMV7opxxu2KyAl1tgjTHcFb?=
 =?us-ascii?Q?C+UmzORXxq34/tuaXdn36A9vStiM2++IZ9Kgj0Bqx+Xa6GDsW5JtCsYV2eNx?=
 =?us-ascii?Q?+KD8/lxNYr510veuC9LyVsUHBVAY903NnnjJS6iNEzT9WQuDd66cHX7P8QcZ?=
 =?us-ascii?Q?GswPFt8qRq11VeQW53OgamSHetdy8lq4D3J3LXq9Hm11RNONUB8VrRGCvnel?=
 =?us-ascii?Q?E9JeIYaGUr23t1gEwGb0aFZj/df5u5h0ldGUVHDwYhRh+hBJTUHoftRAtMgh?=
 =?us-ascii?Q?oEAmoVepsg2iRh6fJGUWrdOhw2yXJL40dsIQ1N4Da2/Gfco8oRVlXPCna8vl?=
 =?us-ascii?Q?qN5knGLUZktjwss/E3QQoioQq68rpIadkqC4EiDO+G5s6mY4XQdIwprkV5v5?=
 =?us-ascii?Q?XDtG30BQmsBDqEi67Y0+Z5L0AQD3tRlSTqJdMtX+?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d11af6b-20ad-4e40-8d54-08dd9dcf9a9b
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 10:08:33.7989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZCvhPtWXmGTqj2AvnJcvbc2yXB9HOcrR0DRN7sFQrBGMPQd48f9YvP7IylgCGgp7jABiMzEO8zI1yl0ZG+Org==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0673

Avoid the driver missing IRQs by temporarily masking IRQs in the ISR
to enforce an edge even if a different IRQ is signalled before handled
IRQs are cleared.

Fixes: 48f827d4f48f ("can: kvaser_pciefd: Move reset of DMA RX buffers to the end of the ISR")
Cc: stable@vger.kernel.org
Signed-off-by: Axel Forsman <axfo@kvaser.com>
Tested-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://patch.msgid.link/20250520114332.8961-2-axfo@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
(cherry picked from commit 9176bd205ee0b2cd35073a9973c2a0936bcb579e)
---
 drivers/net/can/kvaser_pciefd.c | 82 +++++++++++++++------------------
 1 file changed, 38 insertions(+), 44 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index c490b4ba065b..95c293aa4222 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1580,24 +1580,28 @@ static int kvaser_pciefd_read_buffer(struct kvaser_pciefd *pcie, int dma_buf)
 	return res;
 }
 
-static u32 kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
+static void kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
 {
+	void __iomem *srb_cmd_reg = KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG;
 	u32 irq = ioread32(KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IRQ_REG);
 
-	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD0)
-		kvaser_pciefd_read_buffer(pcie, 0);
+	iowrite32(irq, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IRQ_REG);
 
-	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD1)
+	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD0) {
+		kvaser_pciefd_read_buffer(pcie, 0);
+		iowrite32(KVASER_PCIEFD_SRB_CMD_RDB0, srb_cmd_reg); /* Rearm buffer */
+	}
+
+	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD1) {
 		kvaser_pciefd_read_buffer(pcie, 1);
+		iowrite32(KVASER_PCIEFD_SRB_CMD_RDB1, srb_cmd_reg); /* Rearm buffer */
+	}
 
 	if (irq & KVASER_PCIEFD_SRB_IRQ_DOF0 ||
 	    irq & KVASER_PCIEFD_SRB_IRQ_DOF1 ||
 	    irq & KVASER_PCIEFD_SRB_IRQ_DUF0 ||
 	    irq & KVASER_PCIEFD_SRB_IRQ_DUF1)
 		dev_err(&pcie->pci->dev, "DMA IRQ error 0x%08X\n", irq);
-
-	iowrite32(irq, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IRQ_REG);
-	return irq;
 }
 
 static void kvaser_pciefd_transmit_irq(struct kvaser_pciefd_can *can)
@@ -1625,29 +1629,22 @@ static irqreturn_t kvaser_pciefd_irq_handler(int irq, void *dev)
 	struct kvaser_pciefd *pcie = (struct kvaser_pciefd *)dev;
 	const struct kvaser_pciefd_irq_mask *irq_mask = pcie->driver_data->irq_mask;
 	u32 pci_irq = ioread32(KVASER_PCIEFD_PCI_IRQ_ADDR(pcie));
-	u32 srb_irq = 0;
-	u32 srb_release = 0;
 	int i;
 
 	if (!(pci_irq & irq_mask->all))
 		return IRQ_NONE;
 
+	iowrite32(0, KVASER_PCIEFD_PCI_IEN_ADDR(pcie));
+
 	if (pci_irq & irq_mask->kcan_rx0)
-		srb_irq = kvaser_pciefd_receive_irq(pcie);
+		kvaser_pciefd_receive_irq(pcie);
 
 	for (i = 0; i < pcie->nr_channels; i++) {
 		if (pci_irq & irq_mask->kcan_tx[i])
 			kvaser_pciefd_transmit_irq(pcie->can[i]);
 	}
 
-	if (srb_irq & KVASER_PCIEFD_SRB_IRQ_DPD0)
-		srb_release |= KVASER_PCIEFD_SRB_CMD_RDB0;
-
-	if (srb_irq & KVASER_PCIEFD_SRB_IRQ_DPD1)
-		srb_release |= KVASER_PCIEFD_SRB_CMD_RDB1;
-
-	if (srb_release)
-		iowrite32(srb_release, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);
+	iowrite32(irq_mask->all, KVASER_PCIEFD_PCI_IEN_ADDR(pcie));
 
 	return IRQ_HANDLED;
 }
@@ -1667,13 +1664,22 @@ static void kvaser_pciefd_teardown_can_ctrls(struct kvaser_pciefd *pcie)
 	}
 }
 
+static void kvaser_pciefd_disable_irq_srcs(struct kvaser_pciefd *pcie)
+{
+	unsigned int i;
+
+	/* Masking PCI_IRQ is insufficient as running ISR will unmask it */
+	iowrite32(0, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IEN_REG);
+	for (i = 0; i < pcie->nr_channels; ++i)
+		iowrite32(0, pcie->can[i]->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
+}
+
 static int kvaser_pciefd_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *id)
 {
 	int err;
 	struct kvaser_pciefd *pcie;
 	const struct kvaser_pciefd_irq_mask *irq_mask;
-	void __iomem *irq_en_base;
 
 	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
@@ -1726,8 +1732,7 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 		  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IEN_REG);
 
 	/* Enable PCI interrupts */
-	irq_en_base = KVASER_PCIEFD_PCI_IEN_ADDR(pcie);
-	iowrite32(irq_mask->all, irq_en_base);
+	iowrite32(irq_mask->all, KVASER_PCIEFD_PCI_IEN_ADDR(pcie));
 	/* Ready the DMA buffers */
 	iowrite32(KVASER_PCIEFD_SRB_CMD_RDB0,
 		  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);
@@ -1741,8 +1746,7 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	return 0;
 
 err_free_irq:
-	/* Disable PCI interrupts */
-	iowrite32(0, irq_en_base);
+	kvaser_pciefd_disable_irq_srcs(pcie);
 	free_irq(pcie->pci->irq, pcie);
 
 err_teardown_can_ctrls:
@@ -1762,35 +1766,25 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	return err;
 }
 
-static void kvaser_pciefd_remove_all_ctrls(struct kvaser_pciefd *pcie)
-{
-	int i;
-
-	for (i = 0; i < pcie->nr_channels; i++) {
-		struct kvaser_pciefd_can *can = pcie->can[i];
-
-		if (can) {
-			iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
-			unregister_candev(can->can.dev);
-			del_timer(&can->bec_poll_timer);
-			kvaser_pciefd_pwm_stop(can);
-			free_candev(can->can.dev);
-		}
-	}
-}
-
 static void kvaser_pciefd_remove(struct pci_dev *pdev)
 {
 	struct kvaser_pciefd *pcie = pci_get_drvdata(pdev);
+	unsigned int i;
 
-	kvaser_pciefd_remove_all_ctrls(pcie);
+	for (i = 0; i < pcie->nr_channels; ++i) {
+		struct kvaser_pciefd_can *can = pcie->can[i];
 
-	/* Disable interrupts */
-	iowrite32(0, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CTRL_REG);
-	iowrite32(0, KVASER_PCIEFD_PCI_IEN_ADDR(pcie));
+		unregister_candev(can->can.dev);
+		del_timer(&can->bec_poll_timer);
+		kvaser_pciefd_pwm_stop(can);
+	}
 
+	kvaser_pciefd_disable_irq_srcs(pcie);
 	free_irq(pcie->pci->irq, pcie);
 
+	for (i = 0; i < pcie->nr_channels; ++i)
+		free_candev(pcie->can[i]->can.dev);
+
 	pci_iounmap(pdev, pcie->reg_base);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
-- 
2.49.0


