Return-Path: <stable+bounces-192632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978EEC3C89B
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 17:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB08D3AA190
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 16:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BC93491EB;
	Thu,  6 Nov 2025 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="0I+sxEHR";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="j8PSu/4Y"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63291261B70;
	Thu,  6 Nov 2025 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447018; cv=fail; b=RdUITHWTxImuj8kUJ81a489lkfQtkoaF69G0ubFEQQx0f7+Leui+3ytG/jgOFordJGKDb950rrnGnGlSMmV+UlsavNAKvKxiBxBTbNeFjxk/9ayGfrX4DOd8m9KvUA+V3hpzziszwlb37SQbKKNWCrOr7zaJmbr6TwFB0+rO7b8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447018; c=relaxed/simple;
	bh=3GefN5ObL4mlTF0N8HXHkZE1z91FNWRjyWo35Nh9QXw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fAaoCxiLqDQ79f4+kAWsCcfYWXFWEiTFAo+/WWhEGkYloF0zGfi977ZKX4GmM7DXmLjndcsjC7IGk57z/pGr26+X5GdB+fyq9tkipKc7UwQpgWPVfjtxSy63/4hXkqQVCMC682xHTWRUGfBC4gDyNKCs4HZAekzI87rC744ZeVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=0I+sxEHR; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=j8PSu/4Y; arc=fail smtp.client-ip=205.220.177.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220297.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6B7i5Q020706;
	Thu, 6 Nov 2025 10:36:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=3GefN
	5ObL4mlTF0N8HXHkZE1z91FNWRjyWo35Nh9QXw=; b=0I+sxEHRvOVd8xT3oueFj
	dqB+k2pe8+FV+4W7B5NDPQKeSi5xIT4FG5KVzM+idSpRDTMn09X1s/Fk8YUnthHW
	55vj6EK7sVUf18YPYoFqz+a4Xcz/Jc2a3d/aTaEGZ3/xOpVa19oShTLX7gV3qJnG
	UMuPPPPTqanhUU1ft4mOwLFTTStSa3GiWuMWIlNcIhLAY8Jd5KP2FcfblgrWYnF7
	JC0YiAGuEhozv7a+2ZrKh//iqcp2KZ3Mua+8m1UD/UoUUPSeHU4Nc3f7YTHrAxz1
	2PYfjyhZfKe4257FIitOjHwG1Gaw0uv0eo52NVBzbuq9d79RX4KzW88G27BCE6aq
	A==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020135.outbound.protection.outlook.com [52.101.56.135])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 4a8thfgskf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 10:36:34 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rEBOieuG1MoMdCBo3LRUlurOt5eKhf0otKTASDmPwL2sYkHs46sKRVzIjlTuLkub/Px6gG9QcyKbNNN0s7KQOAxb4o2mMGltuBKfvetq7U4ULQqtFKxiWOWOVLqu1L/ZyODuhQ8wrUepP0La+ZW2kipJq0ghIT6XRB/YbeSkDdnDcTGgx97vrMmTsRrQqr7iFX4VQOML0sgk7LBO/RFQjwvRTDmRKOaSR2ILgAr3EDakg3b1EixpBjqsHs6+w2f04K27AtCJWZw52VMideSlFq7TLidHYbDySJymZyhsbuXmCI0hVTK6h7BQL4rHi+H+Nt7MKJRDd8EM9VyN0TAaOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GefN5ObL4mlTF0N8HXHkZE1z91FNWRjyWo35Nh9QXw=;
 b=muQRk8clmIefWh8NDrI+9IKgsOpczRcGMApIxNNgkxtsP5lLFZAB81NujQURja3tYDtZ9qstHmQJeu/Skzig1n+nW2XcYmj71ZZKrmkxPLMkxQzbsTE/rcW5cG2YEZdT3WQk1dBf2UgxIfhZ4oa+c4SRO+KsgGRNZLYW0jwkmsZsq9qnI5Ca/8cwwPXn5XtC/S8UwmsFX6PaurB5JYAFEFNK8JjPCzSwPekNydw+aehc4Hv32p9zsH19EmaWF2D7SPxAErxbgagtXJaenv/GF6ZGe8iTwMfJHUXU4bYyAjvrDJVbtX6miw+EG2aNcBkO3dni0MruqL3u2ykhWMtfmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=queasysnail.net smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=garmin.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GefN5ObL4mlTF0N8HXHkZE1z91FNWRjyWo35Nh9QXw=;
 b=j8PSu/4Y3TvbYWbGrsEIsmwDw5oaEUTIY1HeBgyL9ypfiu4m2wJAPKukh1LP7/kzrky66lbCErad97YOKKIAsR/MJFiw1Ijn8xtaUacp0z69Aer3G2G3f3wu8Cee0EFKPD5v/TQQIM0HEYwkc3ABOalZIk7+OQX9NiWWWvqnpKBrxaf34+XRvfA0+/IGjxpcZukirvo9/fdYfYBnzU9HlkxBuoN2ycV1c2hy5IWGTUs3SmptF+LhpNf97sY7pS0KEBLxXVH/7F+E+ZExsd8iPi3NgcTp+DhQ6bgwm7F4u8EWa59WQ8cp9er+qx+oWfhB9DSPIimFZElD9734OxygmA==
Received: from SJ0PR05CA0210.namprd05.prod.outlook.com (2603:10b6:a03:330::35)
 by DS4PR04MB9847.namprd04.prod.outlook.com (2603:10b6:8:2ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Thu, 6 Nov
 2025 16:36:32 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::95) by SJ0PR05CA0210.outlook.office365.com
 (2603:10b6:a03:330::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.8 via Frontend Transport; Thu, 6
 Nov 2025 16:36:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 16:36:32 +0000
Received: from kc3wpa-exmb3.ad.garmin.com (10.65.32.83) by cv1wpa-edge1
 (10.60.4.254) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 10:36:21 -0600
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 kc3wpa-exmb3.ad.garmin.com (10.65.32.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 6 Nov 2025 10:36:23 -0600
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 cv1wpa-exmb3.ad.garmin.com (10.5.144.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.57; Thu, 6 Nov 2025 10:36:23 -0600
Received: from ola-9gm7613-uvm.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.73) with Microsoft SMTP Server id 15.1.2507.57 via Frontend
 Transport; Thu, 6 Nov 2025 10:36:23 -0600
From: Nate Karstens <nate.karstens@garmin.com>
To: <sd@queasysnail.net>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
        <jacob.e.keller@intel.com>, <john.fastabend@gmail.com>,
        <kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <linux@treblig.org>,
        <mrpre@163.com>, <nate.karstens@garmin.com>, <nate.karstens@gmail.com>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>,
        <stable@vger.kernel.org>, <tom@quantonium.net>
Subject: Re: [PATCH] strparser: Fix signed/unsigned mismatch bug
Date: Thu, 6 Nov 2025 10:36:23 -0600
Message-ID: <20251106163623.1772347-1-nate.karstens@garmin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aQy9TZm4rpP3ZB4b@krikkit>
References: <aQy9TZm4rpP3ZB4b@krikkit>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|DS4PR04MB9847:EE_
X-MS-Office365-Filtering-Correlation-Id: 3859ea24-2590-486c-38e6-08de1d52a4d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4oxXXWUoW+5YYgnIR/zwy74zBxola1s+CYrxa5GicgWTcqBHJpx8XoUiDdsA?=
 =?us-ascii?Q?bMSSd9B10c9eZSA6nNralTPCzdwoYUulpmo2qAhiJNXy63zKBoTiZ2FwCvcM?=
 =?us-ascii?Q?adrkI+RNJQhSTasdBygUHg0W30+Iq89LDf85zJdM3QhnfPMPN3IQwgYbwlzl?=
 =?us-ascii?Q?wS1yAFJNtvZVfiP0NSLN9wiWt+ZTrsMa2F3t43OK0ovEjAapRPlGG3RQFy8d?=
 =?us-ascii?Q?4cGI0SgHiZ4BEcX8si3Cx/J85YsSd1k1LdiQISsIdynmrlGpk6fj0232eFaV?=
 =?us-ascii?Q?YGwsg82WjpWEEWzH7klAKdxa8ru1m5lAqNkhdDKOmlWIVAiMFBXBaSlGLaVo?=
 =?us-ascii?Q?QaztTi/xXsNlciVxxSkKmJJo3X3qurhxUf7teSaV3f0jfjLHf2eYPpAHj38m?=
 =?us-ascii?Q?ycg7KJce5YEweQSJ0QP+yKdhY4fzjuQm0McK92M68Y43jsfqPYVxOurP5Ca7?=
 =?us-ascii?Q?U3ntxQrEFUDMt4Qj2Mhbov51TpzpaCSBJHqD6x3KGDsmcQXkklVe0fvrbwMU?=
 =?us-ascii?Q?o0tT9ybIeT4+yKlD3pL6lqPXq3/aa/XEseP53MNdjdF108eiGYuaHu7TO4gn?=
 =?us-ascii?Q?QTvGVUy/wOwW3PYfpD0Y7rOEeMMbnbkZUOAOcTZutdIaSLtOFj+IdUpa2+aL?=
 =?us-ascii?Q?4woEGMaHtDQwmTP/Pt47QSEXDtBvLQwp0ZKNMS1PajaQO4CKCQf0k9OTlHZx?=
 =?us-ascii?Q?U09+wcgM5SKZIYhJL8yh0ppx1NuTYdn9c3CWY3UaEQXlRDrlMmvFKkBSoRPN?=
 =?us-ascii?Q?tD0E2QWnb/22x5pi4RXJ7/u+q4WIA9ljTBxWtiV598O4IbBv3uPbT/S5ILpe?=
 =?us-ascii?Q?jYHz/tF8/TCvnhca3MVfATaFNhXTWAFkkNJOZmTpD8eQVvY/KBtTO3caYN5H?=
 =?us-ascii?Q?56J8dNOthmjPytKGr5aNfZJ11uFf8lnhsEtP7DbFD+N0kwJS08wLGF2DBTV7?=
 =?us-ascii?Q?CR3lkMu7/Du7hlnPTZS1rMGP6RbhqeWvlwMNBNR0p6qALRhgLep9OihwBnOJ?=
 =?us-ascii?Q?6tGXnWLjlNzUvpGnCUHPuQRxHoarnWV5FpVDC8sm1v/mw6wBPQQy2o5MgtoV?=
 =?us-ascii?Q?PvddXrO92eGXbuGLYH0WNL2T4dn3s/II3L9gEfCFd2icOl4tb5jWFgIYibNX?=
 =?us-ascii?Q?7leQRXTHek2PC6mj9ce1sia4mxqC9J7E304r3G7O/0otp3+r2miFiD1rzIcB?=
 =?us-ascii?Q?yoeVdk7WbvbR7Dhooqc4hXvpWrO/T0459WMmSJOxAJPGjMEQnq2e5csZPJnd?=
 =?us-ascii?Q?9Y3cXqdz0AUwPTqyRWtn8+VVi7hvR7gu4YWcBbTqIzsMHhyZTEJPz92+nEUz?=
 =?us-ascii?Q?6KKlw+G1GZOfT+32jD4w2LyT/OBpXjBJ3MMbH2yWbZFoTZLLkp3Xfw1Fkw77?=
 =?us-ascii?Q?o9HRXSqgLGSDo9F40qs8rBX+RPnLrtvZaKXys6n13wmKP7eKNCL+oXj5WdE9?=
 =?us-ascii?Q?N7MwJhIOiO/ulvZwiPIJkR4KCmK3tJGhQzPBEx/7Rz5VxKkXIfyUrTrydnZE?=
 =?us-ascii?Q?UBnm57e18f00E0pv09NubSNAPq9zMjwDdFk9GbKHJGwUUuFFWXV+brzuRxSo?=
 =?us-ascii?Q?zirEtkdUx+NIG1XF4Eo=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 16:36:32.1642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3859ea24-2590-486c-38e6-08de1d52a4d5
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR04MB9847
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA4NyBTYWx0ZWRfXzDcc/9oqLsSa vEnLfuIvNhxrtwlHj7xW1LTZpyQxJhobXpANvVwbmirtkZYI0Lr7ZHaj/+z9HD/Ux69pChJ23M/ BMHl3ZFxjwq2lHswvk59DYCFZL8y1th37j0E8l0tcEKH43qpLtDf+NvDgfR5zy34SFHMHXe26oY
 iAuqoB6UCkPQR/z1CqKBM21UnfBIpAVR6c7keVDrt1l9ujzeRuqF4Aa2zVcspEuyzfZfrhzMs0F O0WUq65sLIpKTOSd5Jfi+iLmeyIeAmhfJYTehn0+1lH7PaptH2Z6Hmi/TCpemXHPvq65kJPzhiL Vi/jXKg6k9GCXXB6lp6nExYTNic4HeeMDJYQFm0Hnk080Pzpq1W740METmGkI9gaHYxmTbnoHPF
 rIVTIcmF1Osd0+qe+4cYgMa6bpKgU9u1TlTGVmQZiMM3YfkiozE=
X-Proofpoint-ORIG-GUID: ulZyAtWQrQlpWbnmUR6kRrZjs1Z5fP6k
X-Proofpoint-GUID: ulZyAtWQrQlpWbnmUR6kRrZjs1Z5fP6k
X-Authority-Analysis: v=2.4 cv=VuIuwu2n c=1 sm=1 tr=0 ts=690cce92 cx=c_pps a=7RdxWpphQ0FXUQ9+5PcytA==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=6UeiqGixMTsA:10 a=qm69fr9Wx_0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=PCC1QBCX1cjj2AFU9lAA:9
 cc=ntf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc=notification
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2510240000
 definitions=main-2511060087

Thanks, Sabrina!

> Are you testing on some 32b arch? Otherwise ssize_t would be s64 and
> int/unsigned int should be 32b so the missing cast would not matter?

Yes, that is a good point. I tested this on a 32-bit architecture. On a 64-=
bit system, the u32 would be put into an s64 because all possible values fo=
r the u32 can fit into the s64. Signed arithmetic is used and you would get=
 the correct result.

> Agree. And adding a summary of the information in this thread to the
> commit message would be really useful

Sounds good!

> Agree. I didn't mean to dismiss the presence of a bug, sorry if it
> sounded like that. But I was a bit unclear on the conditions, this
> discussion is helpful.

No worries, I didn't take it as being dismissive at all. You had great ques=
tions and I agree that the discussion has been really helpful!

Cheers,

Nate

________________________________

CONFIDENTIALITY NOTICE: This email and any attachments are for the sole use=
 of the intended recipient(s) and contain information that may be Garmin co=
nfidential and/or Garmin legally privileged. If you have received this emai=
l in error, please notify the sender by reply email and delete the message.=
 Any disclosure, copying, distribution or use of this communication (includ=
ing attachments) by someone other than the intended recipient is prohibited=
. Thank you.

________________________________

CONFIDENTIALITY NOTICE: This email and any attachments are for the sole use=
 of the intended recipient(s) and contain information that may be Garmin co=
nfidential and/or Garmin legally privileged. If you have received this emai=
l in error, please notify the sender by reply email and delete the message.=
 Any disclosure, copying, distribution or use of this communication (includ=
ing attachments) by someone other than the intended recipient is prohibited=
. Thank you.

