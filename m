Return-Path: <stable+bounces-192634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD0BC3CA69
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 17:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B87623C78
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 16:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A64C348883;
	Thu,  6 Nov 2025 16:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="CHzbiIgl";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="tFChCYrz"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC70A33B964;
	Thu,  6 Nov 2025 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447934; cv=fail; b=Ob2B7B+lN5YrbuhlDMmbE5+3/dPXh11i9TE741FhZfz4TurMiwJGzC8Bs1p4SPZn/7dYV2Ff5lJiRVXYtkaw4MvvGsniLVZWknVg/zkrESAtq+TvEiel8hEocjNwVgpBEq3oBv98HHMsYYOQ4b8nTGltj4bc0uGxjIUwwtiYhMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447934; c=relaxed/simple;
	bh=Pva+sx+KfWGBaI3Jfge2+dABvEegIHiRUeCqnQh8PBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rpeKHWnywugTPq/mYXvP8UZGPCL3xZJKSiMKRDwOC1pOs4o4Iv32iZiAZ2W5S2oRESKlFs3A2a+MYj0D/USsj28wmKMQsALAsHybfO84HZJZqZxRnxTdegIgdEVqsdpKERV/d2NxVLobuZ++Zjv8Cd2EpdRh7O0xa/PgFwYYB04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=CHzbiIgl; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=tFChCYrz; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220294.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6CwEiR007888;
	Thu, 6 Nov 2025 10:51:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=kL3ZF
	YnCJtB3foOEMJahMQ7jT3PamYdAAyG6lnAmIns=; b=CHzbiIglR9hO927N1LJlk
	rQlUdIyc4vHD1Iki/9HYtPSAAMrXUZ/oGF32uzKC87+Ah/Ndk+paV5HpRsl6A5ZM
	YJW5m+Zd3UyjmF9Kw2y31vnEK9d2Glfvw0qBQRxE3zEYc/+OnKJE71rTz7fjOGNz
	CBF11NkyVCCFMk9yNVUOZSRffkb0oVlZXantdO3FziqRsh7CSywpWdbuGHOx/5/8
	PHENnMXFpZXMinpVwuGOIoURkTDPpPfymqh5NFdLDLoGefyLCy7B0KGGXD23gtfP
	uIkX5zmTBhPBDukjDceXkQhiWlK443bywTPfDPNdk2ZEHBRRggojBiy4gePyZ1Jc
	Q==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11021101.outbound.protection.outlook.com [52.101.62.101])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 4a8phy9830-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 10:51:44 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLdUmv9gCVam3COI7b59hhDQymIYveFCHz5Pu7rGBOAayadn07sAJPe9kNR7J8muAdOCpfyFPAyjzqq6Coy4Zgzsax5ZeD+dkj4V1I0KbXVqFQBKv3CkLBkaXYOVbPsgCxo7rOJURdbaZjukFcRC4AMPMe6lOrm7n4iZf9VbqU55gdkV6klgoMqsXuKdhQwxO6AdgI5zOtWPQoBhIbW/A3LcHkXQ9Iu2n7z/yZX6b/tnf1nG8kfzLsqJX+ex8m7vHYEsKlmQfTgVfqf9U3Dkks06jaKvYhdjicCmY8gNgLZ9i0mttvJ/cXMgP/qOiZgT0JiVBODHSW+FXzJaNllMew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kL3ZFYnCJtB3foOEMJahMQ7jT3PamYdAAyG6lnAmIns=;
 b=rXHBLX+8/558vcZHbKkhz37ZM+g5w3V8G+N4Xmtxxc5ltZOrF0tgDgMMDDntjRiad1yD0qCMLNq+t6sjuX3llmSfjiT0Aa5pFPLiHMXqY/v1S14SYVamgwgOQyUnpGZQp0P+32bXXaHygR8sJ3XQXyhSq8fJ5xuhMAYZPYjgcuHQwhHr4Uqv9DJyXfcjgVVGWn7sgB8FdqbDUWsstOuS8V2zsZ6vexLH2aL7aTS2CDuAO56n7DEutbFxeC31z9RNauqSzz99rY04WDO1S8VwmunAuWAFoFthjmAtzOoic76IWSvrDuWVxzZdJ9Hq6FOHatG/VDT/w/n8Mk5ZfoZr1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=davemloft.net smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=garmin.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kL3ZFYnCJtB3foOEMJahMQ7jT3PamYdAAyG6lnAmIns=;
 b=tFChCYrzEwLgg5fghKD78CMoQN2Ir/CVdg139CrGRsXUkfaArUsU/ex4YW07NZw3f/QGyyoF8HS4swzP6U5pMKmzd+sa6O0apvYGhhVvr1AV1AzpLKHXj8ZqMsvTMN0f18nhSMb96Pnh1IHOIeAf8bMFaK1NSnOxwvH8uM3Pum+ZMvVJRB2eqfJyUURKmwumRvoipCcBwDadrFBuB3cKceQjFv83XS0ZD4ApNzuMzH28m7uCZIPj2t4rdEzf7lFXpekpnsq4F8cOM0FTosLXppLf87kw6gDWG1uYT9Rym4DF19BdD2pfTuVxNHOQAgt+zBw6944kxUIlV23FkoHtvA==
Received: from BN0PR04CA0191.namprd04.prod.outlook.com (2603:10b6:408:e9::16)
 by PH0PR04MB7382.namprd04.prod.outlook.com (2603:10b6:510:1e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 16:51:42 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:e9:cafe::33) by BN0PR04CA0191.outlook.office365.com
 (2603:10b6:408:e9::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 16:51:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 16:51:40 +0000
Received: from KC3WPA-EXSE03.ad.garmin.com (10.65.32.86) by cv1wpa-edge3
 (10.60.4.253) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 10:51:38 -0600
Received: from cv1wpa-exmb4.ad.garmin.com (10.5.144.74) by
 KC3WPA-EXSE03.ad.garmin.com (10.65.32.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Thu, 6 Nov 2025 08:51:40 -0800
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 CV1WPA-EXMB4.ad.garmin.com (10.5.144.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Thu, 6 Nov 2025 10:51:39 -0600
Received: from ola-9gm7613-uvm.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.71) with Microsoft SMTP Server id 15.1.2507.57 via Frontend
 Transport; Thu, 6 Nov 2025 10:51:39 -0600
From: Nate Karstens <nate.karstens@garmin.com>
To: <nate.karstens@garmin.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
        <jacob.e.keller@intel.com>, <john.fastabend@gmail.com>,
        <kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <linux@treblig.org>,
        <mrpre@163.com>, <nate.karstens@gmail.com>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>, <sd@queasysnail.net>, <stable@vger.kernel.org>,
        <tom@quantonium.net>
Subject: [PATCH net v2] strparser: Fix signed/unsigned mismatch bug
Date: Thu, 6 Nov 2025 10:51:17 -0600
Message-ID: <20251106165117.1774787-1-nate.karstens@garmin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106163623.1772347-1-nate.karstens@garmin.com>
References: <20251106163623.1772347-1-nate.karstens@garmin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|PH0PR04MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: d7bde4ec-5ee5-4e9a-2226-08de1d54c284
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dQuhGeN7cwB47Ptywafnygj5hzFXEEk5yCkNCBVs5Jrj7eVtvgGHhiihONy4?=
 =?us-ascii?Q?CKyIg4Iu8fQC+vknLdCsmgedMu9af0dr17N55ASdoplV0IT5/RIw8Hg3A2Wk?=
 =?us-ascii?Q?caLQIPtjlQ0VCzKjzrXAnnrJ/J37PpI5p/5hIqKindGn+a0OVKbe+S4o2pgZ?=
 =?us-ascii?Q?uU7SKpc4hFFYLvostTWqyrl1vmR8a6Ms7mSbkFs1xg1iM0ACBkb3tfXnr4MA?=
 =?us-ascii?Q?4Zazsp6oE9TSkDJvr5xWkSelmao+Npb56mJlVjOXAAu6ttA41bGKbHg2C8nk?=
 =?us-ascii?Q?DXFVg+QSyu8FLhXMgcZngVcHQFr4PQjddaHDWMKU7lu2BhYGs6tEo9B2yFKR?=
 =?us-ascii?Q?BI1cvHAjvhUewQQ2lo/+6BdR21BWyQcq/itoi/gNBbBYtXhBzERvlHhp8czq?=
 =?us-ascii?Q?viPyUIlhPeyVaL8HjIphrdWNyi4MnwI0VyWhpAD5X3WeRoGRtCAq9DyXu0dX?=
 =?us-ascii?Q?5KB+jLTGBcVdL+7PGxHoqIROXJrD5GmxC8Af39grUvvOq6EUR+IUHNNeAUlR?=
 =?us-ascii?Q?6c0LJ26S4lNnbCJMKyhAPkDvSqZjpr2Ba1ERWQc/gob+lfTCX3Su/YWDcvSY?=
 =?us-ascii?Q?UgWYUiac0Sysfk3hfMPjSmcgcPXHcpL4m7yCzANmvKy9ZC3za5TNcQDRnJgA?=
 =?us-ascii?Q?kRXcveHnvf4fDTWoMplh0DEThsILlJ8zlvc5tSB4Ht9eA/6n4yoXVuMOisA9?=
 =?us-ascii?Q?IgmW5NrIbgbeZvI3EqlVmTzBl33hGk17CLRouGrbUA+x6+Hu5BuyLhmbeqJ9?=
 =?us-ascii?Q?oORmQsv6kk5AQT4F9WEhjMw5uUaC7qGrJ62h5OsiyzvKU6uXywEzxbTQ8hGu?=
 =?us-ascii?Q?Q0S8uTOUm3nGcQW1BnTQ5kQUUoOcgLiI0KcF6B5hA1hlNbwP8G1R86ylmkqX?=
 =?us-ascii?Q?OanycpuJ+kAcVaGbsQs+076raWWnRSFF3+qwvWKDZ+HKztg5Ion4X9eSm4+5?=
 =?us-ascii?Q?enn1zSLW6kbnPpVtQYhcYxXqeq28oJfuETdsW7Wsq4rX1R2t06lRkn/BCSg8?=
 =?us-ascii?Q?ECyAlwSYy6HwTQWBXa0nLQEvlPYFwe/RGiGQKawn8zgQ1LdijEGiPLsBcoSn?=
 =?us-ascii?Q?Y/A7svE7CVDjqeFcr8wz/SfKozO8TGzTb+kOyg5RDqKf5NG+UwD3dBFlqm1e?=
 =?us-ascii?Q?EE0t4Ib7Zuwzlphkc3d+sKkrZa5suSREJeySmts2tQ65c1QMtNtmMHXSwlSz?=
 =?us-ascii?Q?seI+bijqtDSlFswvtAnr6uRFJ1HL9xBTrEgXyjl2UWFIDZf9TFfbBRdelDHs?=
 =?us-ascii?Q?NK9MvaYVxqG/lUEnID7aVL4h6GLQCmXOfTuJNXzHx9pYb4DDrtB2vM/wdHSe?=
 =?us-ascii?Q?pLBhIvbmWO2DSLjU79lak/f/vDWDBoD0KotEp6+LCzfqFBcOlQ2aJOXDqGdp?=
 =?us-ascii?Q?qf9qbuT0IEfFzHP5Of3UBPnsphax2t/8hENZdXnxXSyfIYtLhqfggg2x9vNL?=
 =?us-ascii?Q?Un35QRRgNvrT/eenpmbvjP7TWlBbxBLUbWHFAgtTx27FNG6tjpDXT+MFbaAu?=
 =?us-ascii?Q?PkP29ygDxHyenGcqEXUUviCEpK78VciEeAA4pHRXhVLDHLLcvjKX4wmWIj/A?=
 =?us-ascii?Q?uyEzYop1y1NsBTQuhHY=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 16:51:40.9927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7bde4ec-5ee5-4e9a-2226-08de1d54c284
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7382
X-Proofpoint-GUID: HFauzTxStFvusK-Ah8UAgvBMTxvcWaQG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA1MiBTYWx0ZWRfX14kr6CuIGgeg 9/aOKwCfx48Ch2665BGSxF4ovHNn+/L6tzVA7FHaomhonm5J4YIPwmYxayzJc5BM+ThOzti9tWi iFiUjU1dsIby16SDKTdj6NGE5XirjXdkQopcxaQXJT0wSUf/TrzHxWayLR9R+kq5r7vVsXR3INB
 E7otc5ex2SnutKotqEnA6HHuiJ2BMlVIETwlRW7AUKzeDhNuzDmMSv1Jsk8UFrEpXurV+gTYY6J AQrqSDYl8MiGjrhA9aK61pKF6cXhzuhX0qx3TQFbblXMBgJIFDpgmmYL9RiKt53USf8v3/06fk2 NW5WIbTcLFw0OycI2z1bkQGb/FHxGbMi1eSXdC9CcpUPnDrv+2mODHBKiR7H8ratz86fua4fefG
 RGvwCpbjW7WVijRCjncSXQsz4j62mC/3JejXqSbwAZGudQPLkX0=
X-Authority-Analysis: v=2.4 cv=BPG+bVQG c=1 sm=1 tr=0 ts=690cd220 cx=c_pps a=vgafN4kwWYQEHO2M6PbBOA==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=6UeiqGixMTsA:10 a=qm69fr9Wx_0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=NbHB2C0EAAAA:8
 a=VwQbUJbxAAAA:8 a=_HojjBXY4aqDAocttyMA:9 cc=ntf
X-Proofpoint-ORIG-GUID: HFauzTxStFvusK-Ah8UAgvBMTxvcWaQG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc=notification
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2510240000
 definitions=main-2511060052

The `len` member of the sk_buff is an unsigned int. This is cast to
`ssize_t` (a signed type) for the first sk_buff in the comparison,
but not the second sk_buff. On 32-bit systems, this can result in
an integer underflow for certain values because unsigned arithmetic
is being used.

This appears to be an oversight: if the intention was to use unsigned
arithmetic, then the first cast would have been omitted. The change
ensures both len values are cast to `ssize_t`.

The underflow causes an issue with ktls when multiple TLS PDUs are
included in a single TCP segment. The mainline kernel does not use
strparser for ktls anymore, but this is still useful for other
features that still use strparser, and for backporting.

Signed-off-by: Nate Karstens <nate.karstens@garmin.com>
Cc: stable@vger.kernel.org
Fixes: 43a0c6751a32 ("strparser: Stream parser for messages")
---
 net/strparser/strparser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
index 43b1f558b33d..e659fea2da70 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -238,7 +238,7 @@ static int __strp_recv(read_descriptor_t *desc, struct =
sk_buff *orig_skb,
                                strp_parser_err(strp, -EMSGSIZE, desc);
                                break;
                        } else if (len <=3D (ssize_t)head->len -
-                                         skb->len - stm->strp.offset) {
+                                         (ssize_t)skb->len - stm->strp.off=
set) {
                                /* Length must be into new skb (and also
                                 * greater than zero)
                                 */
--
2.34.1


________________________________

CONFIDENTIALITY NOTICE: This email and any attachments are for the sole use=
 of the intended recipient(s) and contain information that may be Garmin co=
nfidential and/or Garmin legally privileged. If you have received this emai=
l in error, please notify the sender by reply email and delete the message.=
 Any disclosure, copying, distribution or use of this communication (includ=
ing attachments) by someone other than the intended recipient is prohibited=
. Thank you.

