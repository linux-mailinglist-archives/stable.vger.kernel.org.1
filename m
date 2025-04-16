Return-Path: <stable+bounces-132851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8255FA9056F
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 16:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65D35170FE8
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 14:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E2420E033;
	Wed, 16 Apr 2025 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="fs+a0HgV";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="bKq/SQ8O"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201C3155300;
	Wed, 16 Apr 2025 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811602; cv=fail; b=gihJA17iLx5enHbL2dhDg3AttztkPNl2rbc2kMABIkNNlKBnPSXZg2NsPFYe8Lm80Ii5KZLQbNkf0PjHjTTskBbY+IhZejhI0PoGNSqJID26RkYTx6IUvETM3Ga30VDtVXp1X/hJJTqpbXFvVzfoHufUELCL09DLg4eqdzVChK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811602; c=relaxed/simple;
	bh=j5Q22aao1gapT4fri4ZrdfCAMsQ0JnIC2YyaXcH4z78=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lus0Cqa8xQADRPyr1hZnZ8Kbg3PBK0GAZ+hSUhh+XZ8uJSdrzaWouuFIw3KQdXMx1S9lbotAOHUHC6LjAWcOCTuzYPXzWHqmdWDdloPcOBk1hWaO8tnu5ZzjBhJEsa48g+zCU+kWVgoNjhh+pBmbiZKY/opoZVvDz/w4yeHGvWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=fs+a0HgV; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=bKq/SQ8O; arc=fail smtp.client-ip=205.220.177.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220298.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G8ODZL011201;
	Wed, 16 Apr 2025 08:52:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=o/Luu
	M7yKWjQgHDEWSrK5LrRqlsE2Awtt3xni40sQnA=; b=fs+a0HgVnMOmN30RjK6ce
	K18dBGQtxcZrF1cF85ueSFsEL6mTdpSPJgMy1FVemJV255EbTT566HdvLxtfasD1
	3p7wLCBXRgviuIk2kZpOOBuyv2jY0NIwT+p6YNQ5CTojnoCnyuzgONghg8b2b1AU
	/OisEYbrsQQOmYMF88qlbqV9H7SHuR4v3pP0FegaZpqbF3zkCsfOo7fblGl/Fqnl
	no0sI5OnueqlE12PURUV7vVIq/mVc/MKK3jsslqeTM0vC6uR2w9RlNApNCm2kvMn
	k0Dfbh0Nn5fDG2dA2dFnqBIO3MeVOYPI718YYAj+xvoV5dXisPpMwaUeY23xmx8Q
	w==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 46290n0my9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 08:52:39 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWAZh8qet8k30HDpRtAa1sv7NaZVQ5atVImvpTejgqJ09OJ8EbQLvE48gXMogm4DcZ+iNsC902vYTx7q1TPsaN1WREsHtHQDGERYvAXh6PAVCI2wbGIUS1eETFKF/zBPOvxapB5J6q9yJNH+wT2TVbK0e2EXuCMOyFfRCQ4xu2BpCl68m62fcglcKCxBGL/NH4XrBY+Dbjh+W3E2/CqbvV1NF/RB2RnXwr17H5UhQH02hhhglEMv/9dIOEXH4yAThDRElVAHW47LruoQKDEFcei3ACKBB5X96oyaizuWYiaaMcRfxgIvVACN3toNSpWs7TDHadicL7tGrcuDFXFYPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/LuuM7yKWjQgHDEWSrK5LrRqlsE2Awtt3xni40sQnA=;
 b=EDpp+JtYvrOwqQTFJ3TG3Z7UL5syO9vBrfbSOglwB6+loTjxAMxmcHOkRZO0Fi1h3k5rTwYNUZ6c0pFtAr58frVUe8Gmf5EgzWYvQu1fuHzIrHJBTm7vinG/r1cRQkriB6DLufbYjusmze7cyKhnrolFZvXIU3JzSJHglXhito3gM8AgQe5Bfuv14UVHdYAc1iMnCLXSzMr3USWhF6899pz5CI/7nsYNvw13fh3s6FzICTE5rKbVk8qRKJQzYF2DAkLI7rptNKQe9ACpTKNgKlXBH6hwPVeBdm3KPln8Au9pHjM0D6q62UBXAYIy99oalpGSgwNmSNromOn3JhDClw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=garmin.com; dmarc=pass (p=reject sp=quarantine pct=100)
 action=none header.from=garmin.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/LuuM7yKWjQgHDEWSrK5LrRqlsE2Awtt3xni40sQnA=;
 b=bKq/SQ8OFTGrVoKnuRbXoYGltc2vzWzoKmkoZQGKZi53mZECeJrQQ5UojkgAydOY6+Ys7qhhmBQjpPHJo63gWJCiI/HnjEs1qvESaXucxJ8ExBsCMpB5zUjpW5k5v/o3OEzuJXfQrQifpPMFul2t73UHo6A1zqk0/hocRbNOdpoksUSMO3JKBvDkeZ7v/ndJfYxmRCTOfLLgcBdct598R61WZvx72BdkUSb2qobR+UplPhonl3p2TyNUl2y3NdeLeeF+iF/s3V1X/cc3wEIA3eYnCw19/+BsjyOH9L+EQFGrQSLCYJi6WOi/KAv5nB3cTm/W2+TvIelUAcWbaZUF6A==
Received: from DM6PR14CA0045.namprd14.prod.outlook.com (2603:10b6:5:18f::22)
 by DM8PR04MB7751.namprd04.prod.outlook.com (2603:10b6:8:29::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.33; Wed, 16 Apr 2025 13:52:37 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:5:18f:cafe::98) by DM6PR14CA0045.outlook.office365.com
 (2603:10b6:5:18f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Wed,
 16 Apr 2025 13:52:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.4 via Frontend Transport; Wed, 16 Apr 2025 13:52:36 +0000
Received: from OLAWPA-EXMB2.ad.garmin.com (10.5.144.14) by cv1wpa-edge1
 (10.60.4.252) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Apr
 2025 08:52:35 -0500
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 OLAWPA-EXMB2.ad.garmin.com (10.5.144.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Apr 2025 08:52:36 -0500
Received: from cv1wpa-exmb2.ad.garmin.com (10.5.144.72) by
 cv1wpa-exmb3.ad.garmin.com (10.5.144.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Apr 2025 08:52:35 -0500
Received: from OLA-9X4GN34.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.72) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 16 Apr 2025 08:52:35 -0500
From: Ross Stutterheim <ross.stutterheim@garmin.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>,
        <ross.stutterheim@garmin.com>, <ross.sweng@gmail.com>,
        Mike Rapoport
	<rppt@kernel.org>, <stable@vger.kernel.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3] arm/memremap: fix arch_memremap_can_ram_remap()
Date: Wed, 16 Apr 2025 08:52:33 -0500
Message-ID: <20250416135233.1421962-1-ross.stutterheim@garmin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414133219.107455-1-ross.stutterheim@garmin.com>
References: <20250414133219.107455-1-ross.stutterheim@garmin.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|DM8PR04MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: b3570432-0a17-46f9-ee25-08dd7cedf20c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VqVn0Fo5AeavzP3C5morMmzBUsXo607SxYCPjq1AUNbxAS2Z/TA2XQUFJObr?=
 =?us-ascii?Q?uitqBjFab65yuEKFojTvx586iuzN9fWtml/xNO8H1l/OjfpTZo0PNYd1IjiO?=
 =?us-ascii?Q?nl1cp5bjPwpPNaGg/gT3VaKWRINDGlatZgqv8gVEvMMmD3rrqxBT6Bm+7gun?=
 =?us-ascii?Q?zdJw3C/hJGD5aSRr378sL/1SrMB9Sjn6TpLje9+Ppqp6bqebvhlYbc4aaV7a?=
 =?us-ascii?Q?7dgLROFHsxDqwf0j9IibpQCbHxU3eqZcfT2BcnShZ5+Mb8qc224WIyrVRlHo?=
 =?us-ascii?Q?ISkDdWErO+wr/vSDLydPXfQX9nCZ+83FrL9ruQAUQCKgW+3wNkY+9YaFgkAO?=
 =?us-ascii?Q?I8nlo1oBiSpiFzij+RjEJK/fk50bke+ZfwQbr+dpe01oQ11qyN5JAmE0A3iG?=
 =?us-ascii?Q?S223tGzl259uAPgYNpxlavmkQCS40sC64o6zBVQYj/Nw2UAQWnWBkInE0Sms?=
 =?us-ascii?Q?z3+v9W+gL4iBDOMbtJ0AkFvLAgDQHsjbEGCB4pFFAPkOA6iN0BP4m41c2inY?=
 =?us-ascii?Q?/P1pHdMGn9/RVE+WgXr3nAFJrKDQbwELaTIcMw8RgopxdM5zd6ybL9haDaWd?=
 =?us-ascii?Q?6CAmEBmh888O9iDsIYrNeOeK5mX2AkVag2YhLZyrkJ2Dv8VRET/soPc7biT7?=
 =?us-ascii?Q?c4YSqKxL5hKW4UUXWIcDpjW+L8wsETAiUpileHG1qdkgWX5Edv/XzZJOh8AN?=
 =?us-ascii?Q?13vLVKa2D2Ni8XRVdm8C0J4r+5kUu0y3cWTj4fpyTPAQoR3Lx1I0y9/ORmXz?=
 =?us-ascii?Q?c/x/PzImrTvGZbVsK5NmV8nfHOOpsnXgUs40Rltn579/8T2x/EOpkqqBsPms?=
 =?us-ascii?Q?ZEPo69zQ/gbiHWrd3LiSTYQtdtE7Z0YscIbMTXif7y8qevfn47uVhK5XOg7t?=
 =?us-ascii?Q?aazdSWpQuPWiOsOmjdiqIVzHc+Gny5xhBQX9ge7WXjrn041zp+2JdmQv8ztM?=
 =?us-ascii?Q?uWu6BjM+ON47z41yZ+oWvqCpyaRDpmiiBCsJg4cNEihvI6vuQQHhCSNZ4/N2?=
 =?us-ascii?Q?uQ9AwBPX3EQYGCyFlYK5KmI73FrpmzFr8TL0MjN9Ljml+YJ9kLGi2CSlSsJi?=
 =?us-ascii?Q?f+fROfNV7IzSACS/G8Z3GmbkFZHd5q7WQc5zev2gyMrF9VqAJk2EY8a3cDjr?=
 =?us-ascii?Q?0jgC9zFNjKTr1YgC/tYcZpikT2WwgZx/3DTum19opNK8R9wq7o01tvgUSdrQ?=
 =?us-ascii?Q?I0yCgdc9PjE7hs15swsAPpP4FCgtVLaEH8Yw9SIwm6zitA8FLUY96Z5PWmTF?=
 =?us-ascii?Q?pzpceFkjPGZLw6sawK/za7umDi1PbwaBcuaW0yvZ4hgOaVVFykweg1QqEHq8?=
 =?us-ascii?Q?sPA5IDlhHVSxJDXbQShLGuBBQxj7zwI8X3BvG3AUcWJ14i7o4ydmlh7CaDvW?=
 =?us-ascii?Q?CqUAr1fTOg7PTywk7wUe0A1W/45lVCZLyxI919NAPb1JcrfI+hIZTTbrfaPW?=
 =?us-ascii?Q?HqoBQud/xGnR6vPkmIeIR3sPJ8Br9ey1U88g0Y705vwoD4UoSAB/Hk6hHc2/?=
 =?us-ascii?Q?+EexI1gIXE3qb10OsJbkecPTlXO1h0+4yDjx?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 13:52:36.5682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3570432-0a17-46f9-ee25-08dd7cedf20c
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7751
X-Proofpoint-GUID: 2YVlQIvxHBhhj34ZfX284ZkhHqsvrYIn
X-Proofpoint-ORIG-GUID: 2YVlQIvxHBhhj34ZfX284ZkhHqsvrYIn
X-Authority-Analysis: v=2.4 cv=OZqYDgTY c=1 sm=1 tr=0 ts=67ffb627 cx=c_pps a=fpyyTn7Kx2iM0+fj1eipXw==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10
 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=VwQbUJbxAAAA:8 a=PHq6YzTAAAAA:8 a=7CQSdrXTAAAA:8 a=KKAkSRfTAAAA:8 a=7Za35VhZ2r2lkZNaMMAA:9 a=ZKzU8r6zoKMcqsNulkmm:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=cvBusfyB2V15izCimMoJ:22 cc=ntf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc=notification route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504160113

commit 260364d112bc ("arm[64]/memremap: don't abuse pfn_valid() to ensure
presence of linear map") added the definition of
arch_memremap_can_ram_remap() for arm[64] specific filtering of what pages
can be used from the linear mapping. memblock_is_map_memory() was called
with the pfn of the address given to arch_memremap_can_ram_remap();
however, memblock_is_map_memory() expects to be given an address for arm,
not a pfn.

This results in calls to memremap() returning a newly mapped area when
it should return an address in the existing linear mapping.

Fix this by removing the address to pfn translation and pass the
address directly.

Fixes: 260364d112bc ("arm[64]/memremap: don't abuse pfn_valid() to ensure presence of linear map")
Signed-off-by: Ross Stutterheim <ross.stutterheim@garmin.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: stable@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mm/ioremap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 748698e91a4b..27e64f782cb3 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -515,7 +515,5 @@ void __init early_ioremap_init(void)
 bool arch_memremap_can_ram_remap(resource_size_t offset, size_t size,
 				 unsigned long flags)
 {
-	unsigned long pfn = PHYS_PFN(offset);
-
-	return memblock_is_map_memory(pfn);
+	return memblock_is_map_memory(offset);
 }
-- 
2.49.0


