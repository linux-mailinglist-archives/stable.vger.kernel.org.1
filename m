Return-Path: <stable+bounces-108426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0572A0B7AA
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 14:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA52C162C98
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 13:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7C522AE42;
	Mon, 13 Jan 2025 13:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="Fh7KE1tB"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60E218E361
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 13:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736773600; cv=fail; b=Xzj8QRNThnxKPG2+qAUdU0jyzlGiJisrpif6DzTk0u5eR6l7ShGvLtLiwOntcM7HaAAbxoXhtSRaXNdSewKvpMXaQW9LHBVucEPoUgtnsWUforuxx1OIzgpwzTb5KBcw3hqpy17I2ulQsDU8EGY+lQdPOr5V6CEE1wOb2eLWJ7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736773600; c=relaxed/simple;
	bh=ToeYcQmNpwhNx+69XqCc8vCPA9nMJTBi80biScP0iRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EfOPJqSrbDV4Y2FGIRybUzXc6sl2ogMhT7MhdOKemktly45bZIlWSIDGpEnyQSEr4m3/UQbMR4SMhRQQZUiN6IerCOWYpP5ME6/47ssG2tlHh/4yWHdqo52/EdjkV62veEJpMaEXUHGcIZ/x6OHK9dz4MAgRncuGczTiGtjQCPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=Fh7KE1tB; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50CNR6v8013647;
	Mon, 13 Jan 2025 13:06:27 GMT
Received: from tyvp286cu001.outbound.protection.outlook.com (mail-japaneastazlp17011024.outbound.protection.outlook.com [40.93.73.24])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 443j0h98h5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 13:06:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpxil2fn+vq8V1NBDr45V+GE6QcoxtceoPgNOA3zsDzOonqTRIBiK8auGnfKJIoBCka0C5+pcgwzO0OzMfjdagL+BGcEn2e5JX+5OKh0xjULxVe+IrQhBubkfhtVXgSIb+Gwmoi2RClA4SBBDit6x4QXO+Yf2Tgo4EKrH/jTdEM6C3W0cGl4f2QUieO7Hua+L/OSSx6gqdN3k9SeZFfLC+c5veC7gLZrBC3ozA45c8ZQ7cygE3xWDhNzctt1f6SJzh3QcH3nsHXSriRlxwfbg7v6DwaVfSRYsa8pR7k+sB5tTuZazHp4JvhFlpS9b/tYW9V3Ee3CLOVJLNZsNrYRTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cArL8Oc1520revbjCAdETBsOfxvKtIA6Ud4I7mCpZvo=;
 b=OWbP4WooihvhCwyyxr9cR3JMjx1vXW4le7+DgaTSKVhmjBXn4BqlQMCDnopKiE19isOqjfS6nVfn5KrIeP2km8uyeEXy0XbPktWzIMZ+X3vtaeD5B953abZO2HLYB2ZjF5ykqekITqDNiGSNSBIBm95U5vLGiwk3QvAaXob9xfYVog3D0oQx8yHxeis5LkuICXE3iphEayw3wbF6OCg4AcA5Holk97+JoldEa05jM4nPMMgghlHrp0uHtc88dYI41n6R6LFZW8b3pQbEhwCZw8O9wcoAKGjkWviDbVfR7v82XiqdBGtZCAp4vW9aJUyx5Lwm8gKyVUOGLclyd5NTvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cArL8Oc1520revbjCAdETBsOfxvKtIA6Ud4I7mCpZvo=;
 b=Fh7KE1tB38AZWBqDNCcHRHz4PjcBt2MnuJkFBOWDDDWu1BcBTev0s87i57cEtbfvDhgETM8FmImewbR3i+IK5zyLHhWFsQ+AFmb5Jwx8gPBOBEJxdoq/qKnnMMbUW2OO5We/rx4rM01mGHX9vF1MZqCxAbnsyjCKDAawsHWoj6G34iqB0Bth8Zu+X/z9vEUW4Kivv9Jt3KwIel8Ku6ZEDNo7tr/inbG2wMlgNw1DFqzcmGaglpugYrJN/qpC+TXHvpZdKU6mr1Mk0BiB2o052iDY5nueQK2yteqfZdbUyxXgvubdAs8py9TeSLKSVJssi9YEfN0ho8Re6P8VB/5ZRw==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by OS3P286MB2824.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 13:06:23 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 13:06:23 +0000
From: inv.git-commit@tdk.com
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.1.y] iio: imu: inv_icm42600: fix spi burst write not supported
Date: Mon, 13 Jan 2025 13:06:09 +0000
Message-Id: <20250113130609.1797-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2025011347-quilt-fraction-73b6@gregkh>
References: <2025011347-quilt-fraction-73b6@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0177.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::11) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|OS3P286MB2824:EE_
X-MS-Office365-Filtering-Correlation-Id: 2329a718-f9fa-4d7e-47bb-08dd33d3143c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|7053199007|38350700014|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OktZKFt+b/OyS676dqNHZTp1+TfgrodmLTEHvGzkU16ySqo27OiVc57Hqnki?=
 =?us-ascii?Q?e3CQVBQwdZ9zZwPxmBllg2plRs15dUdo8ylek0FBnG1bSKelB1OBGNQBrDB6?=
 =?us-ascii?Q?xateznH1nmfFm5JdA25o2rgxTlxneggMVqjudcA0AEnXWTYkkkZExexZQXWI?=
 =?us-ascii?Q?vvwFziLQBVTnfYGqaHwkFUF8UCxLE3aR+V1p+8QH+v3Ktx4R4Vdu2QhdphQo?=
 =?us-ascii?Q?LpVS7RwXSP1R8hrkZSLfB6utO0qgyEf9nlylAS8hmz55HWYU4jf6t8deDhF2?=
 =?us-ascii?Q?2mH6OPFD5nzzJLM/fuJd+XJb81L7EBJMDTBBu0Rck7hHbBc4F41HGUq4Ljxo?=
 =?us-ascii?Q?OVi6bCbIHMF9czCCs+kv8U4nZ1YGqY92JAPCt8pV0LD7UBYxFQUaAjwNOZlE?=
 =?us-ascii?Q?l0pEtN8pMKtfN4ldDvqjOclGvsOonbhdxt+yiG1Jq2ZE85vfC77iaN0ad95J?=
 =?us-ascii?Q?/R4ulZvfVJDTd5eqxvXd4UkDh+XpNczEDO16ggcKxFrC7SCPt9kXy19K0gG7?=
 =?us-ascii?Q?Ch9XzQ3/Cj/Hqrlk1H/GTk8h6vddVOXl5ThqGyY3hxmPn9A2/GA7kos4qUio?=
 =?us-ascii?Q?iQdVcWhJONMFMuNLTf4qHeAfniRz+gYkJSKNsfi99sP17ODXUsyf6TB4vl2h?=
 =?us-ascii?Q?vDvaUXDSCebFqPKfr5/lDfOdmBBrpTFCcrPMkkJenaQK4EDxLrsWYCq4xjgQ?=
 =?us-ascii?Q?U+GK2We8ZbLla6ZSBpZeU7uqNy7MrggHoT249iMmuth1fsR/oDkPHDonuZIS?=
 =?us-ascii?Q?3nbhdz/XZRmU/11baDvYs5R/tbw5jmhx7UcbNtB4bICpY506V7628xoEoSdd?=
 =?us-ascii?Q?PaPT/XQx9CKTghXXO06vst1N23mC++ICvLBgflAxBbs2Q1ZWn59WiA4MxZxG?=
 =?us-ascii?Q?rVPUpAAk6LsKLI6AaPOlp5foOTA/+6nYzWQSrgDjzHaltbt2PzvUbAELKWJY?=
 =?us-ascii?Q?dJzClpqZ/4ZgwzXFS/cqSzQpbn3zPRt7LdaTDtoII8ghb7Ybnhwe2CiPKkvB?=
 =?us-ascii?Q?WwJUVCrBsvXr82yfTkTxx+xbRM2+UktARiTMU9bDxQOEP2NCkE8Gsd7fWWvs?=
 =?us-ascii?Q?2svtEW5Hfg7nbo6XwYCxFP2W5rgNly5VY2WF5lhPg58CvTvSnEpzSsCE+WvD?=
 =?us-ascii?Q?s9/gw1xnLiCSt4ZO1rnsHTEgOJLC2sFXodFfAhl8+UR8iYkzPdEOulR4F3UW?=
 =?us-ascii?Q?eyIJR7JAj7XutpDfwQfNXYWWQSpSuE1TqTohv75s4GP8cYZQHHmiI76N6boB?=
 =?us-ascii?Q?xQOBQ1xOeeoWMjvpzkabl6wdFUhGdua8D1r1Pf9AiXQd3ylPPtuiEAJF5tiD?=
 =?us-ascii?Q?WIe9BFYcJ9eaerfkscRXFw6qTizZpRYANwLmtBlYGkLOdev82blG9Qx0dUXI?=
 =?us-ascii?Q?z8TuBUYPWJziMttKmgLHrw2r59oat93ZRbBEJoff1CX2mllSKpyVO6DFKsgy?=
 =?us-ascii?Q?Gdkh/vQMxCo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(7053199007)(38350700014)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h/Cqe9yuSQSVFF1NJ4JYQtO+beVUh2vCLK4d+69W9EBYZGFv8n7yt+4P1HWY?=
 =?us-ascii?Q?h8ygX4th+dEVHrNIaO+Gd2t2LTODgksbNINaDtq3++kS5bZoAKNlvnjE/DyP?=
 =?us-ascii?Q?9+ZTNC99mL/kZM+COGgom/khR1GkgBZG1lVy12slPVVt1WZ5a9WJExA/4dia?=
 =?us-ascii?Q?/8eMvue/k575AnkE1yssdduOZG9ZbdD6APR2vm7jVFx47SRCV13jE0UL7yZm?=
 =?us-ascii?Q?uESXIq2bAXbaxNEOOmHctHLapgcqRQyajTOly1QZI2DrudaIxWE3KKOCJY6d?=
 =?us-ascii?Q?W25YHRESX7ygDWaK3hjG+3Pj4t3XznfErYez23i0VU9TNNXbJc+RISPQB5m4?=
 =?us-ascii?Q?eEIR12sM7miS9Yyl5j6PffUeYZkP4e/GX/P4ZB3CMTRWFdqipteMEcdqxPRf?=
 =?us-ascii?Q?34yPnSBN1+fY9fi+gUGwmwEHdutAYGPn/l4IwEkR76Yigs+8/N5pETyZqTOu?=
 =?us-ascii?Q?EP9M/gisRjQmAgaMgHpv5Z6nesmt72riNgJoI+ydZt4P7zBApyBBDuwY/urc?=
 =?us-ascii?Q?EKGbkobbw5QLVwvzd9M7KXY7n93b4gvyDOasiJMDwX8+GmdCxxn17idi2Igw?=
 =?us-ascii?Q?tUZKjsawBOJOupAFj9U5To8lF68CiSP6qOZRYA4Kyx42YBze0Bz5uvjMCxzy?=
 =?us-ascii?Q?cxlzm3nO76PFv9l/CFo04eRkbFVNRvC6FOxEsukny6wp5bFJcjwFZYMri4dD?=
 =?us-ascii?Q?MkK8Jg0MXb1Db5Lg/xN7KlHJFZ3Wtn+eN/NVmNRtgWDx0B0PSGzLpQQOYPuk?=
 =?us-ascii?Q?7hH0E/2nL5dCx+UONlSaPlM4TsIScO+iQv28+0PqqPDfjdJIx7n/BTkr14TF?=
 =?us-ascii?Q?u9QMzjaelWaGCzG9BbhTPzYKeCcz8ZjLxK2nMmi3YEgvCVdc2jRSUVD/ZWqM?=
 =?us-ascii?Q?zq2GTIiHliGRyxK2KzKB/EC+afTOGfcV7aZY6anqUUsJ5luG/Z02W7ZSM2BR?=
 =?us-ascii?Q?eIZscNNFmzFNtY6UNJ4qdscvpg5rKYW0MmTBIHx86XUljwhyb5RUT4h7FVpt?=
 =?us-ascii?Q?LYzLYvwxyrmkDUPc3XAghABuBxZ6PKoIsoIivzoHfjuhAIOG2HIC1hW3zuiw?=
 =?us-ascii?Q?4JKh/nH+jZHNEc6pBUtXITsfVIScmwgpNWjrFS5rCkkV3PObA3MlRiKUWU7/?=
 =?us-ascii?Q?WH3mXPgBW++x7rcfLgN6pXpq8Jk/A1+MxnrJ6CBulwIEFKCb9LvroWuTr8Lh?=
 =?us-ascii?Q?v18d+eR7ncO2kHixp6N9sQg79Dwdd3x33yz3tEQDpXTbKBEGw938nxBBit+M?=
 =?us-ascii?Q?8s+eMWxBn4LJ/xm99uPkrlo2OnpvhC+EtQHq+G8IfRYyxR/9OvSHQhVmh51n?=
 =?us-ascii?Q?EEqVCyv6Dpi5mB/h2b1G+NTksFAYFCcNyIHcOiF0SXn7AZjB/8Q7U2TNUA5i?=
 =?us-ascii?Q?XzinUeW0hn5tXCvjDUeHprZCrADrlooNK06zTEPq2H1/plIUztekIX7hf68A?=
 =?us-ascii?Q?dYrFC+es7y/pBtRhl852t6a4//Vac7qvexcr9UWLA4RMJnuw3FxYLaU1z4aG?=
 =?us-ascii?Q?kJp6Vqxa6RKenVR9bTVidKSX11Mye7yc1vTQh7fRGUnQcRWtkHJBwLArqlOM?=
 =?us-ascii?Q?r87vQpdZy4f/dAzd4xEs4LvDRM1pRYQdY8WLYqF45Bu9Qz3PMaEp9/wj8HGs?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2329a718-f9fa-4d7e-47bb-08dd33d3143c
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 13:06:23.0483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8EGPThMLHJYZyfkGgbsTIylURGBXyduy1YzPr43Qla+n4Y/evYwBo72Bwrj7I4bseHn/eu5QUbVaZUJA/p3oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2824
X-Proofpoint-GUID: Lm4YCXw2Jx4PB7kMf6RQc34IdwDXPILR
X-Proofpoint-ORIG-GUID: Lm4YCXw2Jx4PB7kMf6RQc34IdwDXPILR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 phishscore=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501130110

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Burst write with SPI is not working for all icm42600 chips. It was
only used for setting user offsets with regmap_bulk_write.

Add specific SPI regmap config for using only single write with SPI.

Fixes: 9f9ff91b775b ("iio: imu: inv_icm42600: add SPI driver for inv_icm42600 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Link: https://patch.msgid.link/20241112-inv-icm42600-fix-spi-burst-write-not-supported-v2-1-97690dc03607@tdk.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
(cherry picked from commit c0f866de4ce447bca3191b9cefac60c4b36a7922)
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h      |  1 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 15 +++++++++++++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c  |  3 ++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 3d91469beccb..20fb1c33b90a 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -360,6 +360,7 @@ struct inv_icm42600_state {
 typedef int (*inv_icm42600_bus_setup)(struct inv_icm42600_state *);
 
 extern const struct regmap_config inv_icm42600_regmap_config;
+extern const struct regmap_config inv_icm42600_spi_regmap_config;
 extern const struct dev_pm_ops inv_icm42600_pm_ops;
 
 const struct iio_mount_matrix *
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index ca85fccc9839..897b1790f607 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -43,6 +43,21 @@ const struct regmap_config inv_icm42600_regmap_config = {
 };
 EXPORT_SYMBOL_GPL(inv_icm42600_regmap_config);
 
+/* define specific regmap for SPI not supporting burst write */
+const struct regmap_config inv_icm42600_spi_regmap_config = {
+	.name = "inv_icm42600",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x4FFF,
+	.ranges = inv_icm42600_regmap_ranges,
+	.num_ranges = ARRAY_SIZE(inv_icm42600_regmap_ranges),
+	.volatile_table = inv_icm42600_regmap_volatile_accesses,
+	.rd_noinc_table = inv_icm42600_regmap_rd_noinc_accesses,
+	.cache_type = REGCACHE_RBTREE,
+	.use_single_write = true,
+};
+EXPORT_SYMBOL_NS_GPL(inv_icm42600_spi_regmap_config, "IIO_ICM42600");
+
 struct inv_icm42600_hw {
 	uint8_t whoami;
 	const char *name;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
index e6305e5fa975..4441c3bb9601 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
@@ -59,7 +59,8 @@ static int inv_icm42600_probe(struct spi_device *spi)
 		return -EINVAL;
 	chip = (uintptr_t)match;
 
-	regmap = devm_regmap_init_spi(spi, &inv_icm42600_regmap_config);
+	/* use SPI specific regmap */
+	regmap = devm_regmap_init_spi(spi, &inv_icm42600_spi_regmap_config);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-- 
2.25.1


