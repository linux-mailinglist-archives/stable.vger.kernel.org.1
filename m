Return-Path: <stable+bounces-118904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 392F1A41DD3
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12E9188BA93
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97850266EED;
	Mon, 24 Feb 2025 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V1CQSXbs"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013013.outbound.protection.outlook.com [52.101.67.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B89266EF0;
	Mon, 24 Feb 2025 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396631; cv=fail; b=BwZMvAVAFv6SSpIfu1UQn49ziJWVr5ltouXBKtwrVdnIaBusPCcUqhDDwmqpOWIYzAE3LZ42u50Ofzvts32mMEZj6OwmLsl3lOxIIHCEewSf9ebB92E4VHZN0uA51Jb3ImXSMqi4GIxbN/4TULhz5I7rQcetn4K16ApYVLcf2Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396631; c=relaxed/simple;
	bh=aHuVQywoRRhKCcIeRt1a0wwI1mup6/YPzQrsVnWWfDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=riTp97Dusquc+hRxsk0HDBnpG7Jrfh5I9gzWEvS+5XWqe4kWHIP/+64NutxVRl0KL/UVltjFfM+PKzNsm4eZqqwIcB5EmdxWSdhEOSATc+xshIe2ZMH1AagajbMmtWfr4uxcCdi7H4aNiwQhtCnqQ+rbevx5SiO8rmiLWNxkcTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V1CQSXbs; arc=fail smtp.client-ip=52.101.67.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlmX0y6j9IPGN6WO4td/Zfjy4x5f4v3Xao0dCFYWZvqNPmpLTfA/mXczeZRiQ8DnBUEpdEhbxUXGwVeKDnj7dHtJDTy9doF8CANaQKSKKWjnuVhDFVk9MUW8kkrWeqVaXB7esC7pfp9dZ5Ne7k9R/6iFXwwABHIjeeCZDyzicLRzLPz/PX+FRe+3HMYJErUO+EPPGaXBxAsiKapEoET6OgSucWN+0lDyg4+t1rlOzI0RvTw0fCEW/z4+FBZIFRMZP4p2li/mhBlmMmzE9OFQJdTwloFwjEg7rB1ro9mtkLXO7hAWBzn2O5J7hbyMQKp154G7VqABm+0D8jJOsQeGBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATmIexkfbLsalPnqzPcas2nW2/0RylfAo6ffhe0fUJE=;
 b=lsoJFA5jxGhk9/xauV+oG3dMhChl4Q2nDJWmKIcYnuaYTMYcAbJS1v684nqtVqy4/LnmhohfRXRH74N/palaAG+gBpfwdx33Zjglz2ps2V0YnrnBCur966umXjfqrVDN1M/J5ABJ/02HI7tjDC2a4uJOereJ5BKTzaZycisjW1iF0A+lqIn2DMx+iddThS3sgB1ulWwhmsl7JFudZltr3oeiuMOSas0RsGpS5oqJdkt5BsmVLp9vV5C+aD8tLkiOMUubBR+YGZiSQus80g6d3gkevfVME3/3OOQDnSiq75h8E27MKNEQZQG9lGv5rRrcJa+iKTPfrkakg+9kNzTMNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATmIexkfbLsalPnqzPcas2nW2/0RylfAo6ffhe0fUJE=;
 b=V1CQSXbsZT7dyDtXitR63qi3B3fuKla8Gggky/MJA+L20eNN0KJmzRwApF5Gbs21GcwWTY51hAQwspDu0s66OY3gz2M78GzBKSJpQ4w2VCByQioUDLuTEt/w8ZBGieDaqoJFxIssyrDp5JWlQ5YktqPeRE1GUVCitqH0x6nhMwa9o3bduIbUSIfTqW3pUkBytB+FSFSgaLl9hvx4FRfdxvU2roG+GlhOKAYEPM3pfzoOnVES4S3PB8HncwSsGsDnP5jSMtQhAYcF01hGB1G63EttTAcZZLAdnWgNDItawzRnOEQVH6kVzNKmSoarTxuZjYu8c4iMCgVylYq/9d1Cgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB8346.eurprd04.prod.outlook.com (2603:10a6:10:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 11:30:26 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8466.020; Mon, 24 Feb 2025
 11:30:26 +0000
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
	michal.swiatkowski@linux.intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v3 net 7/8] net: enetc: remove the mm_lock from the ENETC v4 driver
Date: Mon, 24 Feb 2025 19:12:50 +0800
Message-Id: <20250224111251.1061098-8-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224111251.1061098-1-wei.fang@nxp.com>
References: <20250224111251.1061098-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: ac18c0ce-9f1f-4be4-48ad-08dd54c6a251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u9hymlnzUzPRSMgaryxpiw1icKhQ3Sg7SFyGArbv7jawt3qOtfpv1dTx36KX?=
 =?us-ascii?Q?cPcPczYK/nhAA4fmOhVbjc9rT12Ol8o+X34k1zp7Y4qFGf6MlP0XisPQCZcN?=
 =?us-ascii?Q?6pdLzY/h4pw/cBwwSHeDQhwIq2OI8z6EQnQhwQThFjPnsLAhNpZxCO0f0fzl?=
 =?us-ascii?Q?1nXN2GzHF426w3UGDMoJkJMK7ZtAtki5poj6RJEOcpJE0qVyKn2rz529zDK2?=
 =?us-ascii?Q?/xOEoNR3iz0mLXjrvz5zHUMXCww4Mg4dRvWKK5Gy+UGO9+FudUMXFcEYar7z?=
 =?us-ascii?Q?4kSwEuO3/MQ9exoCetC/7sMg/X0nWNtW23cpo1TYrXLTE4l923RGo/0xjuqK?=
 =?us-ascii?Q?zn4+DBxSm4iHiPOaNikDy/l66wi6LJmcOpV047wS9e0QH00zsGDH6pnLnvbO?=
 =?us-ascii?Q?jA2+HyLVj+gqGSC7pDgJC62TH0IZboU2uHSGIYaCnTCRHEN7+b1elS+BFpAL?=
 =?us-ascii?Q?n85N8f1EtXkx5ujCadNzPEUhqagrtEklu00o/+uAUK65J3AgQbLzrgIhUR4w?=
 =?us-ascii?Q?mqb0CbzFa/wH/gZi8i4xf3wzZhcsRfPnYjgbmpdqAaTt2ztd7L9/sqciy9Qb?=
 =?us-ascii?Q?ZdOPfeXDc0ShdfFsJATXqVL0rVZlW+t0aXt28qKmOdHr7+NKGGvCZMgQeJo7?=
 =?us-ascii?Q?61sO1De8BVltwtFPOpkKdWGZxXWeOWRGFMeEiWYNaIfRP4qwAXqOSsYit36N?=
 =?us-ascii?Q?Q+bI/dpXpxWphyxZxdfSnZBOhMGGT8eWRSBHoa7osaxl4HIqus5FIJ5ECmoR?=
 =?us-ascii?Q?sGbNqJs1CykrOP+ZSR7vNWglI2zRYFGRFCLr7Y9Lsy/SvXL/cstEVdzhvy0t?=
 =?us-ascii?Q?aHnY13Tw5n2A4SaOuJWWLw5rO2F1ZailKnezc67yCIDs6n5a6XyFy72giTJq?=
 =?us-ascii?Q?qM+Ac0/7CBj0zJEwm+e0a0T1C0PuDu6CPvd/OrsNpvoy300HWOV1OFai/SaI?=
 =?us-ascii?Q?/Iz5yzGZE4k/bJh9haGW49j0dSkpTJ4Lcg2VciRN13oIZVlZZrqioycKeKhQ?=
 =?us-ascii?Q?3K3BPDp+2yPWi1fXEM8G3C4CEPORPu1z7oz2gPPZRfHx7KrNNmlcUYLfjp3j?=
 =?us-ascii?Q?YPeMM955jRbiQByf3ln1G4VF/rcj4SVsDgSA+jfgBn7xhh71zwBMm7c7AOsQ?=
 =?us-ascii?Q?m18h7V43tBdXttgDxiN8otxtiSh2Kpwtlzz7Ay8p2Eu422Kdz1/iFhEr5jGI?=
 =?us-ascii?Q?4WbO1hUvoxiNdBFqQ7VUo5piecHq9n1hwOdbgpVVU/wG/RHAzoWg254eCXhe?=
 =?us-ascii?Q?KTmBS2RyiX0P8+BzHvvnmAddtnFlLukux5oEe8/yXLbCgSRxn5/xLxCJsOjj?=
 =?us-ascii?Q?NoK8gz7V60i2ywN3nTtjP+1fSvaDkVxCqeNbB5VFqu502sPi3bpKXymvS/3p?=
 =?us-ascii?Q?lR+eqz4UHOgn5EDXcwYQ93Byb8Mwj5Dde3JJObDBOzGhW3L6WLaBuyTghHS8?=
 =?us-ascii?Q?VQKEtlSFmYFVbFZffoROxJOv5mEP+B7s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5M5m8VseOJofwGhgf++JbXoqHuJgrSr22iQbIGuh4hdZHD5aJXIIjIGGjJMW?=
 =?us-ascii?Q?AbBFaTUVmp+ekeNnaAE2NSVhgqQ3xmWayw7greeluwgYl7D4aeiHdC84rqGQ?=
 =?us-ascii?Q?+gDIoEbw+wPJ+8NS3lczMGAbjCG2uT/a2z4qkxjVRbBhavhy/+RzwvHjWALh?=
 =?us-ascii?Q?6+w3gqQ7KjjTji1i8xjliUNFt3DLxc6Y3lKz65zTu9baB9W0p/3U7Gpnfbqi?=
 =?us-ascii?Q?VAiNcagnol9tyc+cVklTN6FmbHyIE6GDCnklr3C+C0QW/VNleO/jHSBX4tRl?=
 =?us-ascii?Q?knVzBAMsP/y4Cxv4YJA+HKkdQ3wvvqlPZP0NQ8NAoTHTGWQ0eZ92SCKqx786?=
 =?us-ascii?Q?P3K/yeUTVtSYnpxiuf6u57lKKXpfPytxLx4R3XwhwmMYHW6f0Gq6n0D9D3fc?=
 =?us-ascii?Q?31eC+J0dh0wXeUYA85Lj3JNcD/vC8OIo8tJ3Me56HttmiDkYPgnT1j9u44bU?=
 =?us-ascii?Q?MvRLA4pq6Wck98MUV5frUNwqhk6q2i7UlhtAbIu1P1LJlhPV9nEQ2hMAqLan?=
 =?us-ascii?Q?2P3WU84I16FuJMiVDRnhuM00gCzF+uMUf92O56PV5nDiyvKJBg27Gd1RajgD?=
 =?us-ascii?Q?yGdCbpYodaTRCUK9MFbkKDHDnxRPC4xXtUhPK8Yu907KNYLU03eRWB2WBwZw?=
 =?us-ascii?Q?n3zutSuD4Kp39q3LjHbRLdua1wytj7HKCgxCbG6WQ1IHyd01xddfs4UGehOg?=
 =?us-ascii?Q?xcJeigd+UCh48WPiWNXANcWgKkaSf9nXXeWsqKaV9/vvBvF8mIvyyuap9vW9?=
 =?us-ascii?Q?we/07Nied1myl9qB01Z/fh1JaFBpVXtYayT7WhMC5xjcWwJA9uU8Ct37TmB+?=
 =?us-ascii?Q?k/qi//rIfFAUTF/UugZAnA9VJYsHyFDMp1Jy3Opn9dbxYHh3ci5lRBhPSbaQ?=
 =?us-ascii?Q?r3FyS/LYsu2Q97uBIR+Lh7Dt1nBIv5wJEaEGIX+W/M/ZOScHXc2BUg3ngWBL?=
 =?us-ascii?Q?mFLOabK9Opda1es9i5yTJHDpI4cIF1W5sca6AKzTvljXmcKt7tPuP3hVyg/z?=
 =?us-ascii?Q?khoiJcIwVcrxMf4lh58c7Esvq2X7VX3L/8y42pNpT/b/1o4SOjQYaSAJXosC?=
 =?us-ascii?Q?1UnqASkn7XihsBIolsO/qvHqo19AXxUkYek4QEr4N26QuI2K3Eru2xyuqaET?=
 =?us-ascii?Q?G0Qvf5xuTil8YRttzmDJtmX6Z1e31w/mRWYkNRv6Op5w9V4LAYwMYQCzLl/1?=
 =?us-ascii?Q?UQbNCe0suVxXMIm54olMhVHLdKMqDtiwmBLXRtOeuStVJhUaW7wX0cOPGMg4?=
 =?us-ascii?Q?XGU0Bd29zp4vI2yh6QYp/o68+7rduk/VKCroDzbOlmvdTGVB6yuKqAExK9js?=
 =?us-ascii?Q?BohC5TdJgXJrvPFFWSiu5IvP2j+PAym54puLngeBSHoGIdNBqMxkQHRF8yUH?=
 =?us-ascii?Q?lj58/MBxNHSmjnS2XIWprV/Kpzvvmb3r2SxOOE853mBa4/nDEDUXe+twZxVN?=
 =?us-ascii?Q?kTCxBEt7KicZmYMZfwu8fkWtUMgldAELVHo3gaSa9bQqvasAkr0dtCaA/BfG?=
 =?us-ascii?Q?ajJblQtW/mKUmTnR6OkibjzT3cKA398gqsYo/XvykI98KQs/lN1geU4tmBSH?=
 =?us-ascii?Q?xyrnZqqYLtB/wNsC1pY/QXwxy+RmjvehyDYETtLy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac18c0ce-9f1f-4be4-48ad-08dd54c6a251
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 11:30:26.3350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qbko5CrZ+6gKOSRjJgjMH2CJVjyuhyiSo4sUf4KR26M492rowop5oztPEveCfGZDheeFw+87QHcUwi4wYrXn5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8346

Currently, the ENETC v4 driver has not added the MAC merge layer support
in the upstream, so the mm_lock is not initialized and used, so remove
the mm_lock from the driver.

Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 48861c8b499a..73ac8c6afb3a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -672,7 +672,6 @@ static int enetc4_pf_netdev_create(struct enetc_si *si)
 err_alloc_msix:
 err_config_si:
 err_clk_get:
-	mutex_destroy(&priv->mm_lock);
 	free_netdev(ndev);
 
 	return err;
-- 
2.34.1


