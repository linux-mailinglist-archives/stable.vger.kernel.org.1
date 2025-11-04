Return-Path: <stable+bounces-192435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 06723C326BE
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 18:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1902134CEEA
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 17:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43FB33E342;
	Tue,  4 Nov 2025 17:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="MmhERSGE";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="PEzfCIWZ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFCB33DEFA;
	Tue,  4 Nov 2025 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278452; cv=fail; b=ee5H8B/IQZvEuPgUgphL7H9GnUXPP/g9MMTi0OeoYM8cYCZrQ/iC/SWPes4JiiPoglcrJiKyKO87WZcwowvv9TnQozsgAPXqcquLuXxZAjUKMHoY0ht3JiIh6tYvJqv99VNl+GN9resGNNQn+LpOGYYMLgH9TLFyE6aiwbu5amM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278452; c=relaxed/simple;
	bh=2PBTzo72nE/Z1FFza6PUR+/+fuBFQ75AZvcQVBsAe1A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kvEqkX3EePC0mICrHb34aMmsJPciiR3/p/pILhP4Id/S48D5vYyy7hg5Ol4JSalqwevR+qVm5FCGidwOcQyyDGvOcfoYoPfLvtHiOT/yNZSslorj9a4s4FCVfHA5MFt0UH79WgP05U46PwOeeNbEbVtY0TA3GlP1kYdYPMNAfLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=MmhERSGE; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=PEzfCIWZ; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220295.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4HDAuJ029293;
	Tue, 4 Nov 2025 11:42:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps1; bh=u/T20CmkJvtpF0Y4R57zBLCUPE5
	AgwSZHUgqoPHph8Y=; b=MmhERSGEupyqDA/F6WYh09FIUBNO/pVyJLp21h2CkGe
	MAcYrPfg9OuVkc5gSHASB68aHiMZsEhNa2xHh7AzMWmKMAkriPZ/SrWA4/ESFl5r
	yhi0xquafmi3GwlWMQQuLypl/FmbGxvAYr2Yxv0ZrejyONp20i2Fj9FlIv7zDoOq
	HlFo8RNI0ElJDaM991ASN9Q6Kx5zd9BoIdVkwiKfdfSnMRzDxPFwFQqWpFgR8lHP
	1SUifjs8J7e3G8cCjo/wuMDcD9wBBvAsz5zCXBD0NWZ2bxZ1kEoOoJVGYvwWGkpL
	ZPaXhbREzx9TMm5EExxTcrLE8nxYShRBHmzViDkMvLw==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020085.outbound.protection.outlook.com [52.101.201.85])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 4a7npp02g1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 11:42:25 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r82JILjB1ghUu/e5lK++otfRa9JcA6uJdwPoi6+MdBRj7nws5BAoHhEKCi8PGak2rWEjINp74n4gI7yFhU6/hHpjBlR88F0y7KB21iCb+ovyJe/qibrJW3XnmDI9S8GONQjn4+87ptK8eb2fAgb7Dj+2uRoZpn4WGEaTzwkkhlecty8kweBznDgshgeFmB1M4X2P+cN8o61BS25NZttEqRwh6DHOTZ3Y2FnuSLlZeBcSPQtRDEcZwXU0QjpyVvCp6tNlZyoYAxpBj4ZUhzEUgavQRLczZuUJpbJ9WE68Rxr0bDSMUiB7tK/oPrUYU4DHtsB3j4ByzQUFdaPRLI5Dpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/T20CmkJvtpF0Y4R57zBLCUPE5AgwSZHUgqoPHph8Y=;
 b=wC+I6oIscxZc4d4+OkaWKa4zrXjWQR/Zcjs4SKEU4cvo3bJ8QxC0Or5FaB/TWuUEWTNe7lMThKyA5dOaGWTCfbMHH5aBocJlONMbQySsxKjw0ACeabwyHwpgYIpRwFpwMWswrM+4aLwdO0dMdQNBpN9cy+JsE4LFnfhzdT94+MRxFrdg6fa3iAB3hBt5PBswAdakNCiMBn1x4GuHxeKrCuXwAi/ARhi9ZRWwKEecARK/B7ZGF38F8nVB0NcAF4MzOJyihimnrBkiefuMVV1gibOpYFQbnmbRw2RvDcx9NAzuGd9a7XzNNEPCmu3fJQwuF/rJblp3kFyZPhnCFtDXsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=garmin.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/T20CmkJvtpF0Y4R57zBLCUPE5AgwSZHUgqoPHph8Y=;
 b=PEzfCIWZ1wqLMMUfIpsq7KQDVTufvTL1iXMup3AuMAVrsOSynb3+SfM9v+w94GfHXn56r94yOTtaL3xXrWgiVtTbGEHJMAZ23/Qg+uIHC1kk/gJ/8kmefCvYRqIKDFf8ezzH1GHw6lT4wgiFEWH8rR9V4nHmk5olueEtwBpj2FUK6FDDbDcj7KL3PnHesSMcqjhaS/crB9BKIorPQOn2W1ld6bhUEEnYpFQ3fagAwBSIBjZcHnG/WmTG+qjF5psTeW66Mg1RAirziBs0GyhdRgoGs1G2HpWPkn7eHZ1B1zH8qzteVhNwE5hUpQclr7PvB3VvJOcO62rkkIj9DDvJxQ==
Received: from BY5PR03CA0004.namprd03.prod.outlook.com (2603:10b6:a03:1e0::14)
 by MW4PR04MB7460.namprd04.prod.outlook.com (2603:10b6:303:71::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:42:22 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::9b) by BY5PR03CA0004.outlook.office365.com
 (2603:10b6:a03:1e0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 17:42:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:42:22 +0000
Received: from OLAWPA-EXMB2.ad.garmin.com (10.5.144.14) by cv1wpa-edge1
 (10.60.4.255) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 11:42:04 -0600
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 OLAWPA-EXMB2.ad.garmin.com (10.5.144.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.57; Tue, 4 Nov 2025 11:42:07 -0600
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 CV1WPA-EXMB1.ad.garmin.com (10.5.144.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.57; Tue, 4 Nov 2025 11:42:06 -0600
Received: from ola-9gm7613-uvm.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.71) with Microsoft SMTP Server id 15.1.2507.57 via Frontend
 Transport; Tue, 4 Nov 2025 11:42:06 -0600
From: Nate Karstens <nate.karstens@garmin.com>
To: <netdev@vger.kernel.org>
CC: Nate Karstens <nate.karstens@garmin.com>,
        Nate Karstens
	<nate.karstens@gmail.com>,
        Tom Herbert <tom@quantonium.net>, <stable@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        John Fastabend
	<john.fastabend@gmail.com>,
        "Dr. David Alan Gilbert" <linux@treblig.org>,
        Jiayuan Chen <mrpre@163.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] strparser: Fix signed/unsigned mismatch bug
Date: Tue, 4 Nov 2025 11:42:03 -0600
Message-ID: <20251104174205.984895-1-nate.karstens@garmin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|MW4PR04MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: da4bc8a1-7a70-437f-eb0d-08de1bc98250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lh5zKuu4Hwxj+BQTs6TMO3lfQbdKM97bk5VihLcgTiRR7UJ+f45XVLfpRD6S?=
 =?us-ascii?Q?dc53l4E04IHqxIJgwHigwYKcHurjpr9CyELeT3op3IQrL8hTNBDJC1myPPZH?=
 =?us-ascii?Q?LQ830OoJI5QEJXSjRAqPRF05zEiKtP4O/B0dgpkjJ/L5xgUu8pSOcKXb6Ned?=
 =?us-ascii?Q?pbZEawqo0rzOnVknHUcRsWCQtVU3TKM5n/2ECyYl9iUC6dBH75/r4tidjTwI?=
 =?us-ascii?Q?mHPv+ycBLO4ABaTGE1OUYZgRCjQcbDAxFhZYqxckqXi00Y0UqqADZCxU0sEK?=
 =?us-ascii?Q?1CzOdDQ+hsMvA1O360H+uNWy7IvvceOpPaxkeYTBSca6f+Vg4qwiKUgNyeDr?=
 =?us-ascii?Q?MdPkYelp+1bd0p/1XGNubZZkzgzlbwmAgKfT4pDP02MANj7Ajkvx4hI/nuQI?=
 =?us-ascii?Q?PlLJ3MsGTsSFChBmrrP/wNemc8C7Ut9oh5X3/mVvAZbelqpkSW/MPrMV9H7T?=
 =?us-ascii?Q?SMWcwsoaa8+OwF824xQTKO9VCgf0W+2eVMbtTqw8q4CD++cI6C8Vse8s93IS?=
 =?us-ascii?Q?oEb/wtwZMB/PrOkv2Z6+TftgR4snBT6MRcWUEhDz/zhEd9wcjS2NDCnE9bzV?=
 =?us-ascii?Q?f8sZvQyxff9a1GwYStEu97d34jom4WAE97NcvvsUnQ1Fgbu6Jp1m7lXhBPkF?=
 =?us-ascii?Q?R/BKsuBX/X2lvz6sMnTKCSpid2ZhDaH91iWZSJl1eNTTbCxMZ8UoUVCkgoCJ?=
 =?us-ascii?Q?kPQWwmjvDQnzqCa/ZHbyx6IOZB9QzUXUE2CoQJCFNGDZVjHMLPHz0eau+2Ar?=
 =?us-ascii?Q?dEbFd9lHMREAi5nVnCbDJYlMvZjtbHDKf/cg3TFfBh+NAsVC1e7Z/cT+aFpB?=
 =?us-ascii?Q?uGCjndvlR604ZW8D8a52O2ZiMlFa6xl97KzzjuDhPtXx1w808stbmVNF2Pxj?=
 =?us-ascii?Q?yLDAfpMxA5yw/Nkb+9v/o7RIoHuNZPlJV2jeCPc8MmCBnIw+N2vJZNklI55p?=
 =?us-ascii?Q?ga00YERnPpVbfUwIDmpzsF7WtpOGJoPGYKTPHh+xABzjHQ5KKSYWVIDGFj32?=
 =?us-ascii?Q?wlntwdhEkbQN25lihYLiyMR7DYaMwtNHt+7RMAsnv7GcSLiWhu/oD6c2qKBA?=
 =?us-ascii?Q?kBjvNbAF4f1kEf637xtL4bUx+5DINt3EKXQ/7OEeD+K6ViqlDilOnD+gfVc8?=
 =?us-ascii?Q?gVd80jiH6mJAHgc/9426hKOw4Si2gXR3Vd33ZM8/Bv6ZpJpO/LGnzJQzpSFa?=
 =?us-ascii?Q?El5LmqROUCjxBQFvPjZymfiMiGHbq7MeBCSdgWdmFD9305tcgemoQsmu4o5s?=
 =?us-ascii?Q?po/FGxUuZ9jA/+BX7Dvy5ynKLXcEz2A3o10ixiGGS6T8tTVKCIIy3QuW0CbH?=
 =?us-ascii?Q?2pz3lcyAS3EJcoCBHLcyj6wUh8hXerIVH2F2bxQskDhoiJT+7FAWsIGMtXxL?=
 =?us-ascii?Q?92rVyYZmhgZIh1HXm8a7QcXLiuy1ype8uc/DO5ePy6o1sfyRyFQmplxT6xst?=
 =?us-ascii?Q?9y79RvN9TvNcCcctYy5nnfSzO9nOPMP3b8+4wifaziMCzjLgPEB5TKDBmTPS?=
 =?us-ascii?Q?y5271NoS6C5QhwEpSkOc8VdGfNkCd/1L8F8cBe3YOF0ENboknjkXGJ64GQJ6?=
 =?us-ascii?Q?ZOreQnnL9VU6VS79qeg=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:42:22.0297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da4bc8a1-7a70-437f-eb0d-08de1bc98250
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7460
X-Authority-Analysis: v=2.4 cv=Methep/f c=1 sm=1 tr=0 ts=690a3b01 cx=c_pps a=H3Na7JgWheL2EZIWx/c7UQ==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=6UeiqGixMTsA:10 a=qm69fr9Wx_0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=NbHB2C0EAAAA:8
 a=VwQbUJbxAAAA:8 a=xoKjXkbgRWgnxvzBBN4A:9 cc=ntf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE0NCBTYWx0ZWRfX6ZHltV5f3KZX rrglAEVKP5Et7xlX5rvn8IJfAwcFY7h065cuInOyPxCBhf90btqd9+jaIgxV3R/iamBJ9oSE6sV jLso85X2vYSvI1uUwBl11oN9SgQshRwGPU/kWK/IP/VwKF+HCHcuxEgi2LnSjtHJ1IaU0QXNTqk
 qHkJW/Qf0FzwO2Cr4h+SvpMe24dCw8tyB4oEfKv9i+v+kay1w7jpz/9jUiS8CPOvnVzMxijs8tz H04QBIeZFVZVa+3XjMtVbGPIDnGl4pBRl09bZd95oTPyRovoXfnx7JXjOoMJwSBqZ4fKFY934Lj CpdMAnUWM0cDtqJCIyLmX7+FXv9ZkgrXT/3QF1VHM+5/6rT07wSzTXyjW2csQPiyqU3jmJ1bxWN
 +IcfZKbddlmC7E8R6M0sv3GTqnnyQJKhRgz2iX9Bo7kRB/CKU64=
X-Proofpoint-ORIG-GUID: j1swE1ETxF-CV7cHHxC0cV4i-nNdC8SP
X-Proofpoint-GUID: j1swE1ETxF-CV7cHHxC0cV4i-nNdC8SP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1011 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc=notification
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2510240000
 definitions=main-2511040144

The `len` member of the sk_buff is an unsigned int. This is cast to
`ssize_t` (a signed type) for the first sk_buff in the comparison,
but not the second sk_buff. This change ensures both len values are
cast to `ssize_t`.

This appears to cause an issue with ktls when multiple TLS PDUs are
included in a single TCP segment.

Signed-off-by: Nate Karstens <nate.karstens@garmin.com>
Cc: stable@vger.kernel.org
---
 net/strparser/strparser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
index 43b1f558b33d..e659fea2da70 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -238,7 +238,7 @@ static int __strp_recv(read_descriptor_t *desc, struct sk_buff *orig_skb,
 				strp_parser_err(strp, -EMSGSIZE, desc);
 				break;
 			} else if (len <= (ssize_t)head->len -
-					  skb->len - stm->strp.offset) {
+					  (ssize_t)skb->len - stm->strp.offset) {
 				/* Length must be into new skb (and also
 				 * greater than zero)
 				 */
-- 
2.34.1


