Return-Path: <stable+bounces-147915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B804AC636F
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 09:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E56C16451C
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 07:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BDC244665;
	Wed, 28 May 2025 07:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="ACZ8LPY1"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2094.outbound.protection.outlook.com [40.107.22.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006B219005E
	for <stable@vger.kernel.org>; Wed, 28 May 2025 07:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748418866; cv=fail; b=i0Qa1XNBjZUssncLRwaDQ+Xw1cClwyGxAFkQhVCdEHSHeofFNQedKkoUHn6Ddl9ujfhgxOIAXMvfveBcvKMhK0vIjIQ2LPh5If8zE9K8x/DR5m4j97r50u48hwD23XZNlEIJnk4B5ClZL3cBEe3DQzjjxv5u7gSy/KuxzQoStsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748418866; c=relaxed/simple;
	bh=F7FW5lYr7jMLcwulRYqLv/PX7/R0+y/PPQeYPKj0BOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nLtpWw953rQy9nCqadbZW2ceMtmi1RyxCIRhkXB7Ecp6wvv7+IMjD9fvzA74Af6ZMIXDQLNUYFAKc19mOCwc0EG/Gg/STGm+17DxuWs/9wyAvl5J3UWkSOKaoDd41gaCoocoTN6A6h/usbMKtCuC2D2b0zmcbtBIyF946/8jh4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=ACZ8LPY1; arc=fail smtp.client-ip=40.107.22.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZdx0AU3d6thbJmkTVZR4HVoPhJt5nmINxuvFf+eLSwqqaSFPSR9A4BVUP+1pXQR4/UpSXy/VF8k/M7XIN2C0OhJlWhSSnmdnSdrjTmsqzpQPyenifGPRd6xSQTIWZzmCILRjgpd5jzvKfot3o7FOhpsA4LyQmqlbET7/g9Src4+QSgHnWkd6TvhZ6o8LEXdk06tWE0TnhBAslgNd8xx8vOTtGYPj6YKvsQ4ceNlI7nvTcZg8oFojnHooZ+idxflJTwKIhUN7RAj5rSZWUiF+Cvw8/iN+wl52pw+n1rqVnyIC/b+uY2/hEQThRw8HrAkWFeGq/MclgW430/rWKsX8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7KhIRhgJ7Si5Ta8ZneCdtb6Al5N36LkWwtyB2KsDac=;
 b=aDq/+7/dhOx7FXMK6azjURJcf+pYuJA4WKpliNHDqjLWAQOhpZlpcEvSjRIw9jHfRxxDfh/Yc2dwbvht/k3NALEwzdoH3xpHqXhTors3AYjGw02rZ0Nq42m2kwei5ZShdSibneKPHIFIFP4ESxCV4jTfhcKr5/IauVPXdz41QEALjmADS/DZlb1DVBK9g6R7eFxQE/5SOm/70yvK1hbjg66OFVYrQsKHUM0C6DFp+hG77nzrFQjnMzc7wLB/LcVWbLndt+etTI30wbmMCvitOU+wR0MfG/RFbicA3aYkKRUq7akXv/6Q388WsGqqFiKuU5GmVFllz4qy5VO1q+HDcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7KhIRhgJ7Si5Ta8ZneCdtb6Al5N36LkWwtyB2KsDac=;
 b=ACZ8LPY1awjCjoKJWn4wVXJ0SBHJYBqYLyH2sBD6+s2mNS2c5IeIfRRIyjLKoUVKTJQZfNbH0bpPe8rNfgJ0KieBpMu9uCl+DNUn//bwwdD6A8KMzzySAUS5BLonog6RsHEOx9OYiB5ehK/SvZbEGJOVk7lvsOvVl+nYtcdN0t0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3ed::14)
 by PAXP193MB1167.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:15b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Wed, 28 May
 2025 07:54:19 +0000
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18]) by AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18%7]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 07:54:19 +0000
From: Axel Forsman <axfo@kvaser.com>
To: stable@vger.kernel.org
Cc: Axel Forsman <axfo@kvaser.com>,
	Jimmy Assarsson <extja@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.14.y] can: kvaser_pciefd: Force IRQ edge in case of nested IRQ
Date: Wed, 28 May 2025 09:54:01 +0200
Message-ID: <20250528075401.100449-1-axfo@kvaser.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025052429-stadium-triage-c0af@gregkh>
References: <2025052429-stadium-triage-c0af@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00003834.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:5:0:1d) To AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:3ed::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P193MB1652:EE_|PAXP193MB1167:EE_
X-MS-Office365-Filtering-Correlation-Id: 637792bf-5d9e-433b-4897-08dd9dbcd9e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jh60V3Ya2uqOdpg8ZkWRvr5rl5BxP2UyzuAM025enu2xkx8rlNpGeTkLz2oT?=
 =?us-ascii?Q?uYl4Vs74EuvZm4UQmU7OyP+trJ6NOIvaWc3U+S3lTpB4yF15a7N1mHrIocT0?=
 =?us-ascii?Q?wXU0v/zQehZ/Wf/PyuABehNFur5DRMNMUga/xGmowECy13pvhSL5hdJAhkkl?=
 =?us-ascii?Q?64n/iWzAHJB4A1U20lZOoDW7gpNttlb/Lw/+ed6mDwgMg5VrDUnh2trqRx70?=
 =?us-ascii?Q?3hLTnkmCUfqFPgSp5kFYSwB6nRKI/Klfc1uS0F7PgAMnAStwzHYSKWcsXjIW?=
 =?us-ascii?Q?wiabw/YBoUcer8KrZ9diDTng/lDP5H32yagnpfuX5p8140dXzrOgptn/hrXS?=
 =?us-ascii?Q?qLL1Se/1ct1r2ZOGbAO7wzGs16uxCYQzrsybeRrndodtdVfrcMDb3B18gH9t?=
 =?us-ascii?Q?1zdCOpn95719vT+HOq1Tnv2tYb9SzqjreAkBS2OprHAqyPw7zHyicNEQuNkB?=
 =?us-ascii?Q?OLjNic4aZ7eUWpWHoNu6Zowm7/Bx+WSjrh2OG7w2VR6lfGFIAON0Qaj9il4V?=
 =?us-ascii?Q?55TNy+MBMeddDFtZzpQYMd4hPkpHojBowCniIlKG2RiNesuFiGkukmOPz5Rk?=
 =?us-ascii?Q?Vd1Dz9OpLQm46iRnxKjhj47K5o6AjuUw8bLV+nSUaIGnVDsNT2/+ri/GGKjj?=
 =?us-ascii?Q?G+TeJBoX2/FyfAi9COb1zlr4etqhzkNSDnHBXUv2oMFkw3yBQhgMshhI6q/o?=
 =?us-ascii?Q?B7X1dciJ5XVhCdk+NhQo2v/ZwqUgOvV2SgvDCgM2h7q7+klOf0cs4clIMfHJ?=
 =?us-ascii?Q?+leHuapFGmQQI+MSo98nfesChO8W1tSzMzBAax5Kl16n7VAJpySqxeSE5u1Z?=
 =?us-ascii?Q?H49rSSIpACqhv3MF5ijQTnhzHpfHspP/31hPRvOa9RT9qaiwzSItkEi9PWBQ?=
 =?us-ascii?Q?luynQ8OpJu169ecSBtP7R8O95kZyVvAkzMW+Bom7Crb5dEX/zIolpC8b/+Ci?=
 =?us-ascii?Q?jhjIRbxzzvzaCvy+gBurSbxrWeUWjOpIUgQG/Kmn08S+INFRaPsw6ZqED7S1?=
 =?us-ascii?Q?2apxkoyLKRW5xaCVTe09SYBF/ekV/GXfJ+ximVXJww9u+KJOr5R5RBmHCzXf?=
 =?us-ascii?Q?f59kjYbQ03igB5ct3imAthNLyF6UEsE7FaSIM2GXl2T56Z7vnXm3siwaF2Bw?=
 =?us-ascii?Q?uvTJFKB6QbRchVNrCPRayk59OvJ2WLH3JHrUwk9r+nSj7uHXF47KnPDRNl7f?=
 =?us-ascii?Q?LEOrXB6RR82h/sQ6Jg4IDng3jUR1kN52Eh2uGvNnCNHSA5Oc9f7Q2mnfxuml?=
 =?us-ascii?Q?zuLmoPCJlRdUrySm6D500+liyeqDbH2CH0HDcNIJYSkkk7lTX9lrdbg6hkqZ?=
 =?us-ascii?Q?XlLq9B4Pzfgp9BSy+SzHX3c+ZYWZxhZrcFmNrn7WmNUvx/nXoFFsAyWFUEJq?=
 =?us-ascii?Q?ubD2gCk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1652.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gq5Fo5f1pCO3suAVUDr1doRyWrIut5x35KcPURpIjIGi5+PeIMuOI7eqV/7T?=
 =?us-ascii?Q?gFqyPnMFesdVgrsA3NtQ3F34YN1k+0N1J5xGjjPuCte8Q8O/wPMjZkYmth9r?=
 =?us-ascii?Q?UbYg3C45SL0Fh5idMnAPcKGQMSsILRScGrlaT9xnoy48HlKQbB1hhEkc2tWy?=
 =?us-ascii?Q?h5LMRrS9gH+3b0AqAdyZgefs97aBkGnCE0l8WPrD+0AzTqOJcpdq4iMvu+wl?=
 =?us-ascii?Q?63CHyDOVOPVp7e36oN8//4EuCXyPBxxwkMub25m8QwKJSJoGW74Icb790cKx?=
 =?us-ascii?Q?GiKENiU3QstZgbu7UGWdeRg2jVS+0V/5+g2Yg55X9NKOb0M9VYkLprmZzYtg?=
 =?us-ascii?Q?HfdMSafnEVszh5ZxUp+oryKdc2kvBbVQLgCCjez8mVGKDL4rg9aNNG57R/LO?=
 =?us-ascii?Q?p8pKMUh98d4PizNOhFpv9XGY/E6b6LbqAmL6g2I9nrhZhdpZ6kxqtAhrtm22?=
 =?us-ascii?Q?VWMHxMvnD5qUuhVKPFvyegg2Jxok+yWxiV4hFT/b8zUikv2VYHs76H13a8QX?=
 =?us-ascii?Q?Avryr0/LNkPFCzaRBqkU0NiZ05w28/yHKMPKNd6ItO8olrovSoRb7xr5Lz8m?=
 =?us-ascii?Q?PYTqtSachcA6HNxfGtuMG44AmQmxKc2h1Zk6T0D0OMTaJDRDEtz2Omopi8jy?=
 =?us-ascii?Q?9K5vEe5eyiGznpS/F+bgGrYh/Zuy7pi1GAQgBKF/4bR2b7QaBPjzrNPQW/DB?=
 =?us-ascii?Q?QGycFXJjfXQcLMbHrdyP7QLr1oIBUWAVlyb+w8JmX8D1m9Pa8gyhIfq5/8Li?=
 =?us-ascii?Q?OuPjUkXxHKO8pSD96jqLdEETbmnJ0Sw+4RZR/Jnd13jUnSd7XXw4zU1E/H7D?=
 =?us-ascii?Q?dNltaXQnVLMKLiknkFwCE6r2eB3E28TbQe1XnVTEXNlxOSO83YEZPCyw+tCh?=
 =?us-ascii?Q?owMth0VFo/IxxPOZeuSDZvAn4JMk+GNgWgwb9N+rLyeueUzD+z4Pb5WAcjEY?=
 =?us-ascii?Q?i/sFoc3NVxLGXoLqQvOjQgZWM3RXw93G9BbsjljU9OeDmIUpVUqtRgCFRsYf?=
 =?us-ascii?Q?Cdv0ytyy8CExzkKPTjFtAGRWDUaS5+g7oVzVfwo74jrViGxZKeB6HKN323gG?=
 =?us-ascii?Q?V8a3zIZdLHqCT5Tlyhn6/mEX7wbht/0X0VYVICVVDfDWU+5wDAJjme552/Xc?=
 =?us-ascii?Q?2NZ8kGKySACJUklJbPvwxglO5Ie2gWRKYCQ0h0FNxNgvY9b+PVXXEkTQ0/MJ?=
 =?us-ascii?Q?jJQOEHyed6A9fFip4FXmNtmqFnn4O3hcJb/abzSAG2+GFjq3MVjBSr0HE9J6?=
 =?us-ascii?Q?QqWiU40+FV/bX2azu0vEAa+uE+Fwpk4htr2ioCj6kBw/QhYvxxgRHspBJY5x?=
 =?us-ascii?Q?If5JPyV0XXvkuImRACYxFH0ix/9ZkyvOJHOwhu3ss4poo1NRfY5aDaMic1ka?=
 =?us-ascii?Q?nbSaMFHgkxZNKEd65C7q1wBRdHizF7b0UQty+WK8SVLRQjBmLRXVHdLFDl8F?=
 =?us-ascii?Q?RMC6C37p80AIuUE3FSRdUmVkmP3iBnYdSVQqffSFpgberm8g2OwGOu3Pkq1+?=
 =?us-ascii?Q?t55hb5BDbZHkogJIjND26yKf16xPodFnKEqLRhemF1CPDew6a2t6kpBI9Kkb?=
 =?us-ascii?Q?umMTzvyB82dnApjbMmLnKNIVjtZohiN+zL8pDmCZ?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637792bf-5d9e-433b-4897-08dd9dbcd9e8
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 07:54:19.4681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUrqRbX0I/5msVWD3kXO26VDH3dL99KokRr6IY46/El0r9+046N1zVsEh8pnCWDpiNCht9XBjEIdp62QgSsQSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB1167

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
 drivers/net/can/kvaser_pciefd.c | 83 ++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 44 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index fa04a7ced02b..4d84f7d13c6f 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1646,24 +1646,28 @@ static int kvaser_pciefd_read_buffer(struct kvaser_pciefd *pcie, int dma_buf)
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
 
 	if (unlikely(irq & KVASER_PCIEFD_SRB_IRQ_DOF0 ||
 		     irq & KVASER_PCIEFD_SRB_IRQ_DOF1 ||
 		     irq & KVASER_PCIEFD_SRB_IRQ_DUF0 ||
 		     irq & KVASER_PCIEFD_SRB_IRQ_DUF1))
 		dev_err(&pcie->pci->dev, "DMA IRQ error 0x%08X\n", irq);
-
-	iowrite32(irq, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IRQ_REG);
-	return irq;
 }
 
 static void kvaser_pciefd_transmit_irq(struct kvaser_pciefd_can *can)
@@ -1691,29 +1695,22 @@ static irqreturn_t kvaser_pciefd_irq_handler(int irq, void *dev)
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
@@ -1733,13 +1730,22 @@ static void kvaser_pciefd_teardown_can_ctrls(struct kvaser_pciefd *pcie)
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
 	int ret;
 	struct kvaser_pciefd *pcie;
 	const struct kvaser_pciefd_irq_mask *irq_mask;
-	void __iomem *irq_en_base;
 
 	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
@@ -1805,8 +1811,7 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 		  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IEN_REG);
 
 	/* Enable PCI interrupts */
-	irq_en_base = KVASER_PCIEFD_PCI_IEN_ADDR(pcie);
-	iowrite32(irq_mask->all, irq_en_base);
+	iowrite32(irq_mask->all, KVASER_PCIEFD_PCI_IEN_ADDR(pcie));
 	/* Ready the DMA buffers */
 	iowrite32(KVASER_PCIEFD_SRB_CMD_RDB0,
 		  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);
@@ -1820,8 +1825,7 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	return 0;
 
 err_free_irq:
-	/* Disable PCI interrupts */
-	iowrite32(0, irq_en_base);
+	kvaser_pciefd_disable_irq_srcs(pcie);
 	free_irq(pcie->pci->irq, pcie);
 
 err_pci_free_irq_vectors:
@@ -1844,35 +1848,26 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	return ret;
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
 	pci_free_irq_vectors(pcie->pci);
+
+	for (i = 0; i < pcie->nr_channels; ++i)
+		free_candev(pcie->can[i]->can.dev);
+
 	pci_iounmap(pdev, pcie->reg_base);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
-- 
2.49.0


