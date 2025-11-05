Return-Path: <stable+bounces-192540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CA5C3734B
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 18:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18DC188A62E
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 17:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424ED332EA7;
	Wed,  5 Nov 2025 17:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="KWjLK7zM";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="ZBbj7lyK"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AFC3321C6;
	Wed,  5 Nov 2025 17:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762365103; cv=fail; b=XGvlX8cu7dlEu+J1CwcCNwSRV1qiznFJWDJCXTssg3vxCMfoIRbZ7zABNtVwa2wQH8vXXqxjzop92ylX1at+7uiGA699iBPRbYFrf7j3eceeCutSNlhXUET2I+g3fpCO9VWPw0j7HHGF2x2DG7VcunstboL5gPNMUFmT9hYk+GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762365103; c=relaxed/simple;
	bh=/rffi4lfExP2bZH4XgeqiioyPkfr3qDAc/C8U4itJPs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVaOfvn+AJZj+p9Am89b1s+v2mZCwxCuth6RNczJRMawugMTjpBCvhApSch3kE2V7nHtEfQAquBH8AN2gISYkHq3Z4Xg7H2KWDF3fWRG99jEDgDtxCqX/67EV2CtEl1n26tU1Nl/MVRWX97/jzFyua1fOCnFV9KScoiDwdf5j6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=KWjLK7zM; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=ZBbj7lyK; arc=fail smtp.client-ip=205.220.177.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220298.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5HLARd027431;
	Wed, 5 Nov 2025 11:34:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=/rffi
	4lfExP2bZH4XgeqiioyPkfr3qDAc/C8U4itJPs=; b=KWjLK7zMtSsXU2SEJmoc0
	UC2Eyh9zpWRQjkKtpMm7Fn0F6JjEqI9P6zKioeGT0/Z1iJHLPlTxZ3H5lW71uuyd
	dhCkw3iOuz64DBfCNXPPtPLLpak6Ak8shum4OEb9pP5hzlDN6RHMWSHX+pZ3/8/u
	orbcGe5fpEyOWMgBhDZYTFmEVwfVxEP/JBuZIhDGXrQ/+XroKvThYKZ0xHf/We1I
	rCxLZhtv+SdN6q+O0WvjT7l0PHmoXI4I8S3Q9xokLNQKkR+LljfmI8ENa7eSb4ZI
	NMYD42zI8mr9Cxe3GWmmb5qVzOf723oksYMyLFKfiKmc6Y76YeyL+QtKZHNvz3ns
	w==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11020110.outbound.protection.outlook.com [52.101.61.110])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 4a8aw9813c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 11:34:54 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBkTjjRC8XNyN7bJLp8wFW3WJdcgNfm7FJar3VrJhqvV/sG8w886oKrpDfm6WDY7buZw1EzA/dD0D+59IhDfltMOdIavgVLAZ6lNtUzhTDbyFH2v/+wob/mIMlMhc1gjJPvAL6S846/O8LGLMjmAbzetFltq3mgSmXh04SO+OXDwk1tOl8xv1cO0zOeB3qyQ7Q96dj0jz8uBaYeRM2J49wkDxKut2SbDG9mf0PEz+2KHE2UB0JXy2twYqWsWv5X6q/z8rS9QWHzalTiKK0WUJa5CTs+8OKHnwER+QRQNgit6zsWxUpuB21We4pLmQurF2lCVr+NxWiJSMpoThGMiug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rffi4lfExP2bZH4XgeqiioyPkfr3qDAc/C8U4itJPs=;
 b=i9JEkUhmqF9cvaugzrALrc4nK20ls0IyxfKY+PG1+YT3o8GYUVEIJKOv4fD+11rXbHc5+3j+LH+Y3id3/R1V+nzAaNMTkX4VMTgCNH3KQ2R68fS90BaY6mD5jzsuXzzv+m1+V1N53+7uYizXxaKTZkzEQ6pyxJkJsbub0vvTlKtAUFRbax9UFotpMQhDQb5P3iMFSdoCBt5GxaEmZIbbftWsccneNS2iWoRMT6VtQUZRpCVbHJCfcXQJewFdn8spt2zP9ksMCxGkKKJpO49Qwq6k+LMJkYXrvzgI15uRnn8eVVTkiZkXrCi2ieqLgRgTjLia1ottzhPPKPbUi5UQhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=davemloft.net smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=garmin.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rffi4lfExP2bZH4XgeqiioyPkfr3qDAc/C8U4itJPs=;
 b=ZBbj7lyK8GfM+rhskU9H5UIykCIKzjsQ0urjsQ+ibFd8f5Bi0GdRly4B8Owklsz1IDe8O1i+npt6gqQtuEBBuV1a6xmV6/sHO93EjBuBUQ7YLDTyoe1WJKYydHzBv20Zw3UXPTW2RZc0MYIQE4d9PKKglAG7rFDnXe1b1zKT/JsnQxtGJc8r5CIOfeVbs3ePUpySrfc4Fev97U6/Mg8VnW30qXqyIT92YpwF835Ihi/z2Fie6wq12OZLBVdgWC+bi4bSVUq0e5ZFxwYjl/29zR7UOE6oE3UO7m0E+4GNujXZqM0d0Xk5OsUwVhzaTR2VTUYK7GzDLLYgtM6LUK1v6g==
Received: from SJ0PR13CA0008.namprd13.prod.outlook.com (2603:10b6:a03:2c0::13)
 by CO6PR04MB7492.namprd04.prod.outlook.com (2603:10b6:303:a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 17:34:52 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::f6) by SJ0PR13CA0008.outlook.office365.com
 (2603:10b6:a03:2c0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.5 via Frontend Transport; Wed, 5
 Nov 2025 17:34:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 17:34:51 +0000
Received: from OLAWPA-EXMB13.ad.garmin.com (10.5.144.17) by cv1wpa-edge1
 (10.60.4.251) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 11:34:34 -0600
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 OLAWPA-EXMB13.ad.garmin.com (10.5.144.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.26; Wed, 5 Nov 2025 11:34:35 -0600
Received: from cv1wpa-exmb2.ad.garmin.com (10.5.144.72) by
 CV1WPA-EXMB1.ad.garmin.com (10.5.144.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Wed, 5 Nov 2025 11:34:35 -0600
Received: from ola-9gm7613-uvm.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.72) with Microsoft SMTP Server id 15.1.2507.57 via Frontend
 Transport; Wed, 5 Nov 2025 11:34:34 -0600
From: Nate Karstens <nate.karstens@garmin.com>
To: <nate.karstens@garmin.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
        <john.fastabend@gmail.com>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@treblig.org>, <mrpre@163.com>,
        <nate.karstens@gmail.com>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>, <stable@vger.kernel.org>, <tom@quantonium.net>
Subject: Re: [PATCH] strparser: Fix signed/unsigned mismatch bug
Date: Wed, 5 Nov 2025 11:34:34 -0600
Message-ID: <20251105173434.1404676-1-nate.karstens@garmin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104174205.984895-1-nate.karstens@garmin.com>
References: <20251104174205.984895-1-nate.karstens@garmin.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|CO6PR04MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f23ff8-20b3-43f8-0950-08de1c91a00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Iwv2cXB0i217B0dPZeverKKVm2XP3lHKtzC+k9RguPKtSaa7YYA0iyv/BcNK?=
 =?us-ascii?Q?0vMpp1qNzna348NFJ/DZzmg55r3cMV37neHPUbjhaYyXhqgnDGqkUzXPpIA+?=
 =?us-ascii?Q?QHpU4F4orP00Rxrcl8a8AjroKQv99Bl8DnsAT+bQVzEGXhGIf8cucDEb+SWJ?=
 =?us-ascii?Q?7zDlW9lJkO1jVQX8dYTA3lX4AjVR1xd0GMLbHEblc2g9X6SXCV0Bz8WVxLAs?=
 =?us-ascii?Q?ZhBt6Zcs0mMos12Axn5Vier8tnlSjvyJec+ri/RVJSqM+K2hec7nV6vdrRC/?=
 =?us-ascii?Q?PqsU5C93Qc1ywH0CuPGmbtVgvSqKy91N3rsi66k9cAAl/DFCNi+vkA+ztSLa?=
 =?us-ascii?Q?QT6H91+/sMKqtM2LecoocWUxaPeFd11y/IOaH2dMmb3dglVlEMWWqHMQSE2q?=
 =?us-ascii?Q?Msk+rVfg9uh2uxHGfLK2bPonB2ujDyFcViRYjGTg5ciVCSkvrjcZzGgJJUk2?=
 =?us-ascii?Q?MWE+3z4LMjpKqnavuyPqEgtp2UlDg8KHn9ZJasQdnV7CxqSSt0f3PitW+lx9?=
 =?us-ascii?Q?aDA+gVBIU2mDmjaAbt9lIpotCLCYUoIuWv8Sznd7+ggv9OF3lg16pDuhua6P?=
 =?us-ascii?Q?e1eSkSlmEeEMHHzyN2Cvv1Gv4lCjmsnVDH0CbUWrDiNpgK1loSz/mHVi6S9o?=
 =?us-ascii?Q?2PSfFddAlDbxIVjgi8BY2SsNkJ9WAHlHSf5au0wbFS8LJ+7GlWA/8x7RMFjr?=
 =?us-ascii?Q?OiM7EAln+bOuXjOrj2aPFQBEFl+WxWZyVVHolQfMREKsD72OuVzIaZbmwg5A?=
 =?us-ascii?Q?qtOzY0lUQw26Of9nA2JIIZ4YhUH3Z/roWYtIn0aQFH1oPDiBobGBj1HCT8e8?=
 =?us-ascii?Q?4nEeqQBjBY0pqVa50mii/4V2amm0O0KOyuyQXKJrQozXlJsc2HcunAUVBkF1?=
 =?us-ascii?Q?l2YJcQV1HQxyt0Z9WUSsYVE38SNIcEI5Y7VCHQ7WIyGahTEzTCrzxAYNW8wx?=
 =?us-ascii?Q?D09z/bwPjA6Y1QV1iF99vjWnUMl+n3WMKPES5FM7LcX5FAdSSZPj7I/P++X4?=
 =?us-ascii?Q?2Mp1cSGTu9b1wYuM+Vx1asTLwaLmuTacT2aAExJndgmRDHTLwfCPVRzLv5oR?=
 =?us-ascii?Q?k+PD465gous5gO694LrcrKuD/pV5Q1uUe+XCGOeM/NXoFCbThwWcMlv/2YHI?=
 =?us-ascii?Q?GZe31Ro4Rls9cbhAmpqAV/EN2bs8i1vwBI4MjHqHta2Ls8BHaD3Dy4v5RDtd?=
 =?us-ascii?Q?0uaETKs4pWZW7y1CbXT1pSQB7IALXppYB0vHDd/t/ohRI6E2xBIU7r/js1NI?=
 =?us-ascii?Q?njGCB1MVBdrBnG+TAlrpNCLbi+FXK5agxOpjr2vcRDJTZcOkdwaQFkyXxb1+?=
 =?us-ascii?Q?0cVqPR42YWSSyoIjLlKWOLaJSsl3fjsS6O1kNe36VQwC391kKGaM+Rxxo6fo?=
 =?us-ascii?Q?GrIkarD8kVk1V4aCYVHVffYLhFpES6jUQ8EqjjGQkLyznrJDTVXJd1iN9AFF?=
 =?us-ascii?Q?wojgxikPxBmeC38X/9I9kNHSb+QcDUWYX+D+c98rOpAlvxsdRGZ0Cepcs7oQ?=
 =?us-ascii?Q?HS91CKV873gpZp14po6me+uX+goaPXeP9fo3/5EFc4XKbSm43EuYtx30yPw4?=
 =?us-ascii?Q?B4zCVlemFYCSj82zGuE=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 17:34:51.2618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f23ff8-20b3-43f8-0950-08de1c91a00d
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7492
X-Proofpoint-GUID: emqDvlfxOdrOTC9b8zMP8QxN6TDhha3c
X-Authority-Analysis: v=2.4 cv=Ev3fbCcA c=1 sm=1 tr=0 ts=690b8abe cx=c_pps a=low8nCDu0sffNixxSzL/Hw==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=6UeiqGixMTsA:10 a=qm69fr9Wx_0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=PCC1QBCX1cjj2AFU9lAA:9
 cc=ntf
X-Proofpoint-ORIG-GUID: emqDvlfxOdrOTC9b8zMP8QxN6TDhha3c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzNCBTYWx0ZWRfXz29ewMvjsumT 47uMN4wup6Twfez0gchvdwDlX5Jr2UTIuULyvh4QTpNpfDcy4GUiMIMaHDvai7Z0l7GF9tSS/dd Q0H/8esoajl05ut1JayYDwWCqD6fnwKWtjZrQ/e1Nb3ZNtJ0PMYyfUQGC30nmmqwVn8oLzlrtvj
 /+nmpVQaEZ64AVFrFBuP1qtF10oWaytPyjV2lctTHMFNLGv6yCfFygRZfD/s7qgqJ8VgKLwk1Gq 7jVVw0U+/Vxc7BKpEQAqyEY409Y8H9T/QVkY5u8LWvlXF+KQIcuLixJvFS7fVMmP0Eyo1AVatwM J/2jfx6OZupwsGsdomaJUbfx6Xg8uXvO5ijQWFEm3ahVEHzQtJppzG97EhcRr2jFRMOtQqJmBeS
 IzIdX3YVXu85gsx/H+Po+rpR6T7eyhY+z4fau9D+yhnsKg5bHRs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc=notification
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2510240000
 definitions=main-2511050134

All right, one more time using `git send-email` (plainly I don't do this ev=
ery day)...

Sabrina,

Thanks for looking at this!

I'm seeing this on kernel version 5.10.244. I know that ktls on the mainlin=
e kernel has moved away from strparser, but I think the change would be use=
ful for anyone still using strparser (both for ktls on old kernels and othe=
r users as well). It seems that, because head->len was cast to ssize_t, it =
was an oversight that skb->len wasn't as well (if the intention was to use =
unsigned arithmetic, then there would be no need to cast head-> len).

Here is an example of the values involved with the test I'm running:

len =3D 16406
head->len =3D 1448
skb->len =3D 1448
stm->strp.offset =3D 478
(ssize_t)head->len - skb->len - stm.strp.offset =3D 4294966818
(ssize_t)head->len - (ssize_t)skb->len - stm.strp.offset =3D -478

I'm happy to update the patch, how much of this information would be useful=
 to include in the commit message?

Nate

________________________________

CONFIDENTIALITY NOTICE: This email and any attachments are for the sole use=
 of the intended recipient(s) and contain information that may be Garmin co=
nfidential and/or Garmin legally privileged. If you have received this emai=
l in error, please notify the sender by reply email and delete the message.=
 Any disclosure, copying, distribution or use of this communication (includ=
ing attachments) by someone other than the intended recipient is prohibited=
. Thank you.

