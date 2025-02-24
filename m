Return-Path: <stable+bounces-118897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADFBA41DD1
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4B93B1D8D
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FBB25D554;
	Mon, 24 Feb 2025 11:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XogxnH4T"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2063.outbound.protection.outlook.com [40.107.247.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E820825D543;
	Mon, 24 Feb 2025 11:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396598; cv=fail; b=fH43HTjyohPD1olF0a90+9xyls0RUq/5FXHXYd8kEwDNp7tzeluUi3g+t85/zD5ob0NeaXFiLEayu8W9Vl6aKevloUgOd2x0jtL6HGv0ej0UWa8t55Wqp+d5uO/XVYacTVRvK7p69C1mLhgfKgsfzHIG17qf6RwluAynJkpmlCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396598; c=relaxed/simple;
	bh=4Oc9XOSATfJsapvDRUvROEn1kBs8X7lQebHwanmUA8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RIIaffhjxXCBckmxALIiTCCyC77Xi7cU7FpYKihFLZwGtVDLx0/SeScWClbWG9BLy6OudEvFLMpPZ4/7MzhFPSMuS6ESBaMTJNF9LdBMZN+Zp3sU2mZTtEe+0O0YwImoV7jkywIwIfWQHzo8+6WH7luf+zNKSA2hiSq80IWBhdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XogxnH4T; arc=fail smtp.client-ip=40.107.247.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqY/aV4zlt00DzfM3Pu3ygtf56o/UeuQXxu7lDUcba4zF0BYMDxDJACBCcKm6T7hAQdmLlr8/6T1W6/bqY9CY7iCODbukM2ZjcS+wk9VVk0C72hN6r9kmrDuVpqnBtZnS5UlhXXGdPSZrrmTEHcJrT4J+dOv5JM31luhuUKwB516qZ26JvwoW8tJGinugQQ4pTCM8vnuWp8HvwK+AVfhJOFFAm5HzGBPDS2Br2r07Xkaphq7ZIHXvY4vqIkhWke57V3R3GsZXQ7e0i/D/wd0LpMbLn+6X58ANsyz2h4pDKOTH3AfVx/fWMIwfUCPjzmr+8p+gPcLSTu1wJzmKtev8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zx6hBq7S3AXUvoSAgylFqU+jsWID7DRtjoYE126zu5E=;
 b=A0m5oNSihczlUDV19e8lSL9OhiNDylHM7h5PMGVwfJj1PJ8tlRFk/oTsfsvKvMkhRcEUhUCeRzlshyBRUOP66wQD4QlYkRSGpiNhbclTxm9fVTKK1WTy7cvanqVRvXiVUW0gPW84K4ZpWYg1u8/cc7zGGcBWtvMo9+wgxRz0W00ebwyycLzu6+uE9Qx/j3sPPGFbDxbCo61Nt5E+bWrmDE8IYH+VGyDZyu8/GptjbMKkUtLScDACUQtYgFd29l+SJbSYwwRTGqKwk8Yos7mUCml2ddfVQ2bWmmbbxgxERSULonFyQ6wfnWr90P5ge6uQrggQbfiI3AlXK0Xqdj+gIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zx6hBq7S3AXUvoSAgylFqU+jsWID7DRtjoYE126zu5E=;
 b=XogxnH4TFA4KAa3u6fdi2ON09DQcX0IJ3d9siIPB1K0vimdI1Q8N7uOtcHLBAdXlUKjhD+7Mv8hlnzrL/2Yl/St/NPmLWWafaL8TJLnXrFx9hGxQq8ZoYLZhF7AYx63qkqBzvz1mENMNM603AUN08d04beeYsp0ULOZPygQ2Yqtb41ZVasFhpputNRjAudNu/rEg5PEALpvL7CZS6I2QrHXYpKodf2RICEZw830XzPbwtJu0PnHmu1oDqvBbFrCbstcXHcZIFlEon5I30E2npolqnoCOaMrsw2PkUL0ENyBHj4/1Ih0u9yVXebRb8Hz93LtosH+apG+F2FtRImkO6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBAPR04MB7253.eurprd04.prod.outlook.com (2603:10a6:10:1a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 11:29:53 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8466.020; Mon, 24 Feb 2025
 11:29:53 +0000
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
Subject: [PATCH v3 net 0/8] net: enetc: fix some known issues
Date: Mon, 24 Feb 2025 19:12:43 +0800
Message-Id: <20250224111251.1061098-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBAPR04MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: 0442c023-aacf-453a-cfb4-08dd54c68e92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SkNxenD/uD5P1MEtjW1E4rQMdC6dbHJ9N9jnhcXDV5x0KE11kn2WI2FviyPB?=
 =?us-ascii?Q?MY5qNNHVlfNvFR+f9m9GMTGhrNRxfuB58mx2RVx8peJsMMoIkmGA/Tq9pT38?=
 =?us-ascii?Q?5SCEN7WbWYhQA3EEbpxEqwLTgeVbXVr8zQAyZ/O68RvM+2FaTfyKn2q8SrKo?=
 =?us-ascii?Q?MsSjpytNyGgCR/+kYQEDg6v4eIpIsysVbbMqOyAum2sNvHKvfUfyZBDcoURT?=
 =?us-ascii?Q?3eJNW8/D7QJ0rCeH5x0zG/4p6i7PZhzCC1XsEUTqDpASllv1vSDFHHZgP4uI?=
 =?us-ascii?Q?Z6wFmjX7lBMhBSMR9vdB+Z8cWJPsUqMEbdKZ1+6z0uq+qt3DUceGubuk41Hv?=
 =?us-ascii?Q?mFA1I4JshwUVHC+3LadeSD8pZfvOOuPl3lZH1D0pEbcMUxGq+UYxmFF06rqG?=
 =?us-ascii?Q?TdQv7t/2IKdAqCzx+IUgs2aCdSQGUVkZkp2Hsd2weAAxaabFMTMoXl2E0FzP?=
 =?us-ascii?Q?n/d41J7vV3D2sXMtXkc3W2iQZ8mpCs14OWZrCiomJF4z+8qiYojUa4xKq5uQ?=
 =?us-ascii?Q?jtzDrvyMIT+xT+lpR/P6Pvf7RTJOKrutxfSHBCLwzRV1Qtpk0iOb75GBd9cA?=
 =?us-ascii?Q?RrLOQTRd8S5qYPMFrPoojP5X1+pWCv/AnUV8y/9eajAg4+h2z9NtUIqjs8Cy?=
 =?us-ascii?Q?b9kuSQf+sDq4dKDmaZgaIHC2WfbF7smuAe6YjhRnuMSL2xl9BURimYSqNc1S?=
 =?us-ascii?Q?t/NwYwNoagsKLq/KHaCVzliM4BWBCPzLA8goYs9ftKzJBa0LIEdEskNP2Pl1?=
 =?us-ascii?Q?ZCefyyDUzacurUWuLa9mRAvBgNMfj9f3AeQsNFpcLA1ZMB6Xq5VQTyMkcFua?=
 =?us-ascii?Q?+e/8r5NPqWfVc81s50mZefgt8JVaY+N169M1DgbDJBT6U4PGmosbXOflI6UR?=
 =?us-ascii?Q?y9Ll42eqAv9m4Yof3EL71e9MP4VxbRW4TjEOAJV81CeSnfleWRDZIDz7XviM?=
 =?us-ascii?Q?1yTTJnp9xB2UMbSHHM4jRMGu44+g1X+nwHxhIXDmEprYR0bU2niRE36bdyC0?=
 =?us-ascii?Q?GmZanmyczc5y7w6hKNJ4vIpfKSd7uXLwgR1+ScJspXVu60IY/3kGbJG2SgUp?=
 =?us-ascii?Q?JYAGbvboHUKjszSWzUoe8s/EZbFl4JA5wcIsG48+jH8Jj14oig7tIkw2HVV0?=
 =?us-ascii?Q?9iE1ZzBMKYaMxTElDvOVTW7Hc4z8DfHJUiB23/pqmPTLDcNs4Xc4U5+ZHL4J?=
 =?us-ascii?Q?bA1RdNJDIcesYPk5Ofc2PxLRJCt6jAbUUQ+IB4/spFRroeVYAz7lTow0ttq4?=
 =?us-ascii?Q?KCSmQn/9gLaFpPQ50W/oUlPKKHVyqLPOqiGEhocC48eyn0q+hOvOdhENvKv5?=
 =?us-ascii?Q?t1CWam5hMBbqhM9xYKh89wcqDQW/HNvCAHYZcuCRWZpNL6q7l/YTy2VGNn1+?=
 =?us-ascii?Q?UC4pXVy4iRwNN4ezQ1Xiz0HkUeTgrNetLPepOTXsD4FdVfjvWcXfy3rC9yGQ?=
 =?us-ascii?Q?Y4dlbOucEfE+L3r7iGjxIKEN7o5cK9orv+uOl8CvC8+37Bv5OM1KxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w3JGJSzB628DmDQNrU4jdgPi1mpMciU1lDtN+sq0MOwc7q6LSjy2AJgwco5q?=
 =?us-ascii?Q?JxolkHf+9hYwQV2Fnh/3qLA3TrBejSWXyYmwIzMwassiP8Pwn1N50Qe3g4cw?=
 =?us-ascii?Q?jl5eqHz+RmVm7vEVRjnWX5Za8ezM/Ili8t/gFOs7sCpgIt7nunorO4CEejgi?=
 =?us-ascii?Q?fUHLegKRj/QnOjALsosiLxSU10XE4XJJUGkCpmvPLwEZhEI7nRsntwdofy2P?=
 =?us-ascii?Q?bv0s/NOHZVgRRvRDHPKkv0Y+ywO9/2MTEvwju9c//pBm/6h37Gv/AISYeuOx?=
 =?us-ascii?Q?2jntmCgZ3zSTXzFGbGlO6eQEg6G0YEOe+0zelSRAXedcl7cgMqd+bYktf/Rt?=
 =?us-ascii?Q?hHJrgcgI16dI+fkaJr+CUsYaMLa4epNRSKGWSVWMCu4nTZJK2GPoYvqDrX+M?=
 =?us-ascii?Q?6skPXKGktrhDsWg6e+ZjgB8AkZhIwXxazwzAQRtAzaI+KcXvu/IDLSLZy7RQ?=
 =?us-ascii?Q?rg0iVRqGgDTCgBVO9PApQv6xA/qaiDsGrRsnatfOcrkcOgnfGzlzWefNASJq?=
 =?us-ascii?Q?mWrM85uECDZfM6Ood1lrdd+Vq4SSd/O/PP5zK8uKFizUrtM1ibPUvPIle836?=
 =?us-ascii?Q?Z84Cwk+r5pFTKgKd9d9LPhn11l+7MFaMe1FE4YbfapabttRRKFaxkjNsDhrP?=
 =?us-ascii?Q?K368aQS0G+0cud5ibmtDT+mfqhri6Mc/6eGoIj5pIMc4HgXL5J1csECNTlfY?=
 =?us-ascii?Q?HclqUZABv7ExRnMUY4ZSE8KY1BPraTIN+rffpNN2+MAcSbM35vS3iJmTSNQU?=
 =?us-ascii?Q?XQZmFMmuyZJJsSl/ir5zC7Rkq1gT4pyYD0/3zzktnf5XXRdzmpKZbfj2rz1F?=
 =?us-ascii?Q?8TUVylGP4LGPaFGlNI7EKqGa2VQY9MPtVJp9R69JChDPiI9nFbyYnA8iItcn?=
 =?us-ascii?Q?BdkhRoT3/4a0Pb/SwdoKQUPy+eMmC9CHCF1d85rXnZS5zSJwyubyYeAP19M4?=
 =?us-ascii?Q?aL7/+hgICwnvscwVcmdgGrgms9m9SHVmbYWx7UqrYP2FbQEbQ0eC58L4Y2c7?=
 =?us-ascii?Q?aIVgAeqegqRk1PIdHnnnLxbyf4V5ErwexDPUvMFC0Nr61uYJKTFpFYXrPvk3?=
 =?us-ascii?Q?9LlLK8QS7ka6PJ11e3v9AyOwbGdkGgi4D+0Th726GIte8/ZXLFK+RAzex1+H?=
 =?us-ascii?Q?FBVAkrhcKLpYu8bjGIwU3jQZlAecVFyoeavLI8eeaotlk7wb8j0dZEvy3iGR?=
 =?us-ascii?Q?OWxxxs4Fw/iNj4oMMAZo69V1LUPBT6tYo+JlcyKF0T6xUNDWFc8RHUFGhUXo?=
 =?us-ascii?Q?OAh72cD4l1Rg2FC/6leEHo67qiITf4J7AxTVdasI1BNPm9mpkGXaHb8wNPD4?=
 =?us-ascii?Q?aQBG5pHRIkfC2qYLKBVAxB+7V7Ven3Iogr1B8CJBw5KJrDSOE5mjS05AVHxm?=
 =?us-ascii?Q?bm/j3xUmg6y/c6Z2KCz9FPPBc020qO/M/PdMNKjtBhvT7ePa40cb/14PlwyM?=
 =?us-ascii?Q?cCFXBl/gMUjX1kT/eCrmP8+awRjcT1in7AbL5rGGn3MWmAUWPhjBeX/J66+T?=
 =?us-ascii?Q?bb5kjj4oRhuFRP+Xbn/HUPuArAN0w03lCodnbeOP5XmjLvRul78tSojhK6TD?=
 =?us-ascii?Q?664EUz8LeEiDGK6op5YM5v2jWag/A4hAgJE192gw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0442c023-aacf-453a-cfb4-08dd54c68e92
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 11:29:53.0965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+a5qjMUVGH212g82Fsr//DdPTAyopS9IqRaWVEhMG/jbcGa76FBEjCPvvwJp8zfAm/CHG5MgBBh5psjGtkrbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7253

There are some issues with the enetc driver, some of which are specific
to the LS1028A platform, and some of which were introduced recently when
i.MX95 ENETC support was added, so this patch set aims to clean up those
issues.

---
v1 link: https://lore.kernel.org/imx/20250217093906.506214-1-wei.fang@nxp.com/
v2 changes:
1. Remove the unneeded semicolon from patch 1
2. Modify the commit message of patch 1
3. Add new patch 9 to fix another off-by-one issue

v2 link: https://lore.kernel.org/imx/20250219054247.733243-1-wei.fang@nxp.com/
v3 changes:
1. remove the patch "net: enetc: correct the EMDIO base offset for ENETC v4"
2. Add a helper function enetc_unwind_tx_frame()
3. Change the subject of patch 2, and refactor the implementation.
4. Use enetc_unwind_tx_frame() in patch 8, and roll back 'i' when
   enetc_map_tx_tso_data() returns an error
5. Collect Reviewed-by and Tested-by tags
---

Wei Fang (8):
  net: enetc: fix the off-by-one issue in enetc_map_tx_buffs()
  net: enetc: keep track of correct Tx BD count in
    enetc_map_tx_tso_buffs()
  net: enetc: correct the xdp_tx statistics
  net: enetc: VFs do not support HWTSTAMP_TX_ONESTEP_SYNC
  net: enetc: update UDP checksum when updating originTimestamp field
  net: enetc: add missing enetc4_link_deinit()
  net: enetc: remove the mm_lock from the ENETC v4 driver
  net: enetc: fix the off-by-one issue in enetc_map_tx_tso_buffs()

 drivers/net/ethernet/freescale/enetc/enetc.c  | 103 +++++++++++++-----
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |   2 +-
 .../ethernet/freescale/enetc/enetc_ethtool.c  |   7 +-
 3 files changed, 80 insertions(+), 32 deletions(-)

-- 
2.34.1


