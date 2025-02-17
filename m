Return-Path: <stable+bounces-116547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F811A37F1B
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 10:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E3A172A8E
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 09:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B6821771E;
	Mon, 17 Feb 2025 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gDrFI34Q"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013008.outbound.protection.outlook.com [40.107.162.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE4F217674;
	Mon, 17 Feb 2025 09:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786192; cv=fail; b=nMsMU2qqPCIzSEJ72hhTdHQQBhlOodyaGLQn94j9zATMFyej6RJXqShsD3io7Ig4lW4vqW3M/97SXh3L/mYUePEqtwm5tBZ0E9RxF8DfTwBETS/Ho9nFTa+Nyl/wBxefM8TcNfDg3RD5z45gnW1kHSjLqwjHJ1RmQQ6B0vA7VbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786192; c=relaxed/simple;
	bh=hKwQx6KsnX5ScMV+IrlAN1VXIe4DME1oWyBxbt1acNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C1A6tPxPSHyy+3pELdggcOYyE3+VItNiVV1ufQ1pbji+19FtXzEm8b9SR3YUEZvm6XRrB/hskXQA1Z0G9po32eHMrQmH/da2Po60ODveAEOSB3zPOA27pz6oCmKqRRb5ntbYWDwaac9reoAIodqoD84N6V3+MdQ1iDa2Bp1XYV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gDrFI34Q; arc=fail smtp.client-ip=40.107.162.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgK1A1nZTBOKL5Qr4Pb84gjZ5N+0jiVtP/LxaJMK6QHGHfgd7O3jVcTwPJaiQzpI+3OtM5AfLm6xXhwmyUZVZ7Hl8710zJ8P0x+x9FGzNX6YNHgdt4+FvATw++rk7x2Z8//fg9ARTu4pqHKREeizNWqRAKebGxUii6VdcaTpRvtzgloRpU7ntwQq8pmuuaV+PLDF2hYJ8lb19Z1QOmyOWj0MvfOP72gU06bp+oGZs+z7gV2iqL/pLdibHvj4Eq40lBRiyBbjO1W+Bq9oaI3+gUvsHGsI8vhvnvfK20OxNpQbmkVMfDzc1aDX1aWrx9IEmggtnhKWsc4Y68AtCrZUxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b30Jg8Wx5so82uohEZTVnAOZXjaPrd4dE9ClQlMhuSg=;
 b=cec/TgPuFl589p/rF4/wXFX0Nt9sX8C6hM7fmimlW1BcA0xR5Ek50pxc8+mO6b/qwED00aBYEHDkVxITlA9BBnjnROesBmSDLXXogISrMCawKa/zfQQeu/d444esDzOxksjCrzM9pNjJUYertFoGuzriRitH8xS3aIJ+y9s5KcvADWR5ogwYL/b2cDhLADVZw6J4m1z/zIra28+nI5aztkL7h7TISFn8MBNinY1QFfZRkhR1IjXw8xDg2jjbshCQT5KVM9Y3/R10nEf3UvemtPPJlVKGHt7rMRtu+WBDbiQrHFB6zRieC7qyCnvMxfB4OhLkpkeMxb6Pj5o5t7Af8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b30Jg8Wx5so82uohEZTVnAOZXjaPrd4dE9ClQlMhuSg=;
 b=gDrFI34QTGDTCKc+GBAVIbQ1/DZAxA8zKBIi/5IhOXfhQpxyS4YWYiMyBh9mtWXz50xfoj2eyxNVN43awj0q0rLEd6OF7n2AhFVxXB+2ZvxUTeaWMIExRvzwsAJmitcaT/HYiukX0K+h9WDEEEgy/n6wpHrZmM2ux2iPoi1GPm7aQLn6nJ14ZwSlL8l6LlvK9cRmvE/5LVoWzqVBRXcVBhDrasecZBo9MD2IZQUAdF+Yn/3L+sTDipswt0gaPhw3dxkH8OvAVI1M2LqCM3mjq31oM6gCJ7nRuyEM0Wi/IUKY2qfcgUDd8uG7DB85jNUIDuKQTKqoWgODVS4ygpVZUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBAPR04MB7287.eurprd04.prod.outlook.com (2603:10a6:10:1a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 09:56:28 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8445.011; Mon, 17 Feb 2025
 09:56:28 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: ioana.ciornei@nxp.com,
	yangbo.lu@nxp.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH net 3/8] net: enetc: correct the xdp_tx statistics
Date: Mon, 17 Feb 2025 17:39:01 +0800
Message-Id: <20250217093906.506214-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250217093906.506214-1-wei.fang@nxp.com>
References: <20250217093906.506214-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0196.apcprd04.prod.outlook.com
 (2603:1096:4:14::34) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBAPR04MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f4bf87-8f42-4097-7f54-08dd4f3958df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3lpZKLAV5sGe/aWPK+DR8IjNewfODJf4zCK5DokPuVsMwcCEAnDa3zxpFwrU?=
 =?us-ascii?Q?a8g80cCTXjSxsrpp8NNyLmkWmmAy7l4WzET44He48/lcylgAUMFdmcaa0pim?=
 =?us-ascii?Q?eH8zq89P9+lu99H0RlGUMKuBlBBDB95yXsr7/ZfBXtGN1nRBqi1hMsJuxgiw?=
 =?us-ascii?Q?Ji5wHKD5joiV+8iLURbDYz82G6A1SWRqWkdeaqSOcNMsf6GabmP4zzCsYR0e?=
 =?us-ascii?Q?hxmunN0LAkY+uuTRz98N8/y+jKnyptbLF5VIDxrkWuESxgRHwldZ8EY1k/wQ?=
 =?us-ascii?Q?5cBTlJRm6pIPANHRX1TRR90vFfMYlFCiEoB3cVfuJpR5ZpwaW/+C5MqFWTGc?=
 =?us-ascii?Q?uGoURH4l81y77Pmg+pmkoZTjwVb/5yTzBm51RSRizXesnrs9440R+L80/ibS?=
 =?us-ascii?Q?o/qRGRciZenWkieeUGHHyfBQx8GRAHQ6SGskpcbCBQoWJ/KKGNf0UmVYho/L?=
 =?us-ascii?Q?rJa2/ZovTcoIroGSdoL1wyNtKzA/cfWQp/JDU6ElMie1qCpWDM4tQ6C06f7k?=
 =?us-ascii?Q?E01MnpeQKcGaab41PexJfArhU1b6LXcrHOwfNL0ZcQBLGN/9Io07/DIEWm6c?=
 =?us-ascii?Q?0T5c7KPfBolex/FYFbjialv+3Qc/F8h3GO/92orZHouII5KZyiIFZjtzxWdM?=
 =?us-ascii?Q?Dwi+neeXpm+j0m20QaT4MaVIB9rrRxQjufB/3Ss3QeKQveqi+9s8Jy4fESao?=
 =?us-ascii?Q?yeUamX4kYPI2kTcqsH1f6moHY7XVKKS8HybC3S2aylE2ekxpk4biOc1BXHoD?=
 =?us-ascii?Q?G00cIEEmnpiaSzCi8VvO6qlvXiUZZQdU1J8DUgKTBxo1ssp6Jvspfgcb6bgl?=
 =?us-ascii?Q?iuDhqJPDWAX7KDksnL7vEKnMs2CI+IIpBPPvwb2PF1ivJsUOU1XRbXAjissb?=
 =?us-ascii?Q?jumjYAIkqumMnnJmL+EkIxUdyCuCVJh1AiM8FcroMjS1DV/McRJPUIXZ6N2Q?=
 =?us-ascii?Q?0vW9KJv0nNWQT/4EaPLctA+v0KFrsr1Aas8/OuoCQMmk8P23+RtVd9I0mPgY?=
 =?us-ascii?Q?4US8XEfnsZhCDPXhWEr+U5JYe9dAEU8cBvVJkA3KSxQVmf2WniolizL8dmx7?=
 =?us-ascii?Q?53XqSIKPHpRmm8Vd5U1TNjTGg6WL5aXq9radEs+yr/XICuYq/i69DhU2kAs+?=
 =?us-ascii?Q?KL1xG+bfOBvFIKEO0f5Z+dq/YkLeZ0Y7nhKiiwthrHxouToOst7RDjCJHbvM?=
 =?us-ascii?Q?RjdbWI0/34kB+aIc3BvaFlCnVbkAEMkEYpJQMoxnwtdvQK/Q9cL8P5lNMKi6?=
 =?us-ascii?Q?ldudKxLpjkiWw2SuX6qMDTD+oXoR+A8diSwaS1SoQIhznOV9TU3/FVLppCjf?=
 =?us-ascii?Q?2uIAy2po3UNh5gmEQjUSnWpjoPMK7Z+fD2Tw2vJZQl8iwZGqpc8kqF0Xkp+o?=
 =?us-ascii?Q?4awxqn0A7NObH30a7P0aBOiUrjMKPBlTcgmEjshobMRXYA5wRLd20G2GCvPx?=
 =?us-ascii?Q?zkPfouNgSfOuDmvFPmb9k7wtfVbVaHSQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JT5QjdYRxKHgsl+SZ2NGZlAYhPPJpzX7AyhZmEaOjbEcozVNCMS1mC3Iwb0L?=
 =?us-ascii?Q?NOjkxdirzKWWxulYUOaXAQQ9oyXgYRO9tl7bOfFA+YnPBp3F6pt4Opsj3jLf?=
 =?us-ascii?Q?e3NNQWZx3yd0eHoeIQuTK105SQ96Ovt+aFy2hpA85Pq5x2fWuzeVNOu41NcQ?=
 =?us-ascii?Q?rPoiwTSOyCcXTPQvJy0Huc1DQWdUg41NjvFGuVTgDyIH53nYReIZiY7uxyuP?=
 =?us-ascii?Q?H955Dh9jn/rLdz+ueoQ8F3/41U/mpsmtgFL75eG4xU+RSme1H7CUUD/DZL9N?=
 =?us-ascii?Q?S1ErpLvR5AY/tPsKikqv4+wKTYMjN5ycXP4c7cuo6WwuXtifEqz+BL9Apvmx?=
 =?us-ascii?Q?PaWX+j3JA2lIZj8fK3UoKBhekmYzPFVVBfF/LD5sNSfyu0S+vDwAiTip5MF+?=
 =?us-ascii?Q?y09C7X1OvpfeyckAXCMRSeiE1y+PqXjlJqRg0qnbNboFTAg6LCvvsrURqS45?=
 =?us-ascii?Q?mXAvylOlFRMbX8kEJi34gn0OVE8faNO0HIgwJCRELIwXKQlj8Oq4OzBAkNWL?=
 =?us-ascii?Q?S2z4rBAWRIjRNo6TBfMnmNitIsP4ZdFL8lk+hPNPZXEVqIrB2g6y8Nh1fEGh?=
 =?us-ascii?Q?JxmYATJcqkXArRRrnVxTGCDjTjZNE/lHGVY+rUoDd7MrOJDLNu8QH6iSKWB2?=
 =?us-ascii?Q?7OGNmUi1Kqi/zK8+MKWmK2StMYvdMLfobtA+euMrkKhNa/z++UfXighGQCju?=
 =?us-ascii?Q?+Yc9rDIRDvD/0s+uFvxBNKGBcOW8s9anbyCKJV3PjY+W8mSKPbN9t4XGQ8vp?=
 =?us-ascii?Q?Om9gKyrQRl0tojguloBMSW/OofCEUXZavaq993d+DPRjRIht3SAFGyb3D1jp?=
 =?us-ascii?Q?K+E+SpXXfdLb9C6ETgV/lyvzIvUSyq1CHsraIxe/gZp4yOljDBiwT48kORNk?=
 =?us-ascii?Q?yALY6JL7vselfPpOq5hCtLqls0k3LnaG22XVze1KGNsI46MYCj6KehVKgl4v?=
 =?us-ascii?Q?Hh6fyI0uV1vyxZwqM355zub+AIKW1tAEb84uSUninvYjUS6bxS6kbaYJE8oS?=
 =?us-ascii?Q?v+UYhQ0nT8DUwtGovRgPKcroUkzNvbOp/x7bNYqBA4JDLunCKWlkiF+iejNY?=
 =?us-ascii?Q?+siXsKu9zwvLhIqpEjFzLKbw6kqaQOYM6xLuI3HG/ONe+j9PUWcUuN2XDhaA?=
 =?us-ascii?Q?EbfTX35G3+fqvq5EYIf5xtPEpplowe+2GbOEmWCx92FyMbBo182sJxTlLkuY?=
 =?us-ascii?Q?emcs9INvO1TP1dfxBwgFPuzycOK8LbXBNOrM1HaUBBx3ugaTRA1NJLH41uzQ?=
 =?us-ascii?Q?C9dWOcdB95Bics9dCvu4RooTpMCdgi6HdJg88/BOMB7Zw5T9hrxrtQ1MXJoy?=
 =?us-ascii?Q?3no5AHkyZup0Vu2ZVGHIminNIOEtz9X6VlcB1QC8pYIpiwDPcfczZPvD+9VV?=
 =?us-ascii?Q?CsgsQkKHUveeA6UrPA3vTsIxoujUqeieBEs7wFsmhuGDBSg2lbxfeCHvdENR?=
 =?us-ascii?Q?bAt6zO+JvyGeGhVKVZ92d1B8VP/l9+u7Gb2s1UmDxynU+pP/EEMBNv3TS73T?=
 =?us-ascii?Q?ZXCXPXri/UCBVnigEUsA7Phn15jS9VLqW50LiuGyFPOGkCr5NaRUjAUChCGf?=
 =?us-ascii?Q?bDWFm5+tK01/fhMc1HDwFR34vROplUDfPQVzWV82?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f4bf87-8f42-4097-7f54-08dd4f3958df
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 09:56:28.2514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AIZtp9/0X3497WwcwDwU415ysMQL7Q6Q01gQJ7/gL6BYcWY3H2DmG3KxyrjuQZ7Mlft4CMU4Uqj3okbn48d9QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7287

The 'xdp_tx' is used to count the number of XDP_TX frames sent, not the
number of Tx BDs.

Fixes: 7ed2bc80074e ("net: enetc: add support for XDP_TX")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 0a1cea368280..eb0d7ef73303 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1902,7 +1902,7 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 				enetc_xdp_drop(rx_ring, orig_i, i);
 				tx_ring->stats.xdp_tx_drops++;
 			} else {
-				tx_ring->stats.xdp_tx += xdp_tx_bd_cnt;
+				tx_ring->stats.xdp_tx++;
 				rx_ring->xdp.xdp_tx_in_flight += xdp_tx_bd_cnt;
 				xdp_tx_frm_cnt++;
 				/* The XDP_TX enqueue was successful, so we
-- 
2.34.1


