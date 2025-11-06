Return-Path: <stable+bounces-192655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8DFC3D995
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 23:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70D454E522C
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 22:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4897F333734;
	Thu,  6 Nov 2025 22:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="fei0goZE";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="GX79H63O"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1100230EF91;
	Thu,  6 Nov 2025 22:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468163; cv=fail; b=BzYtY8EfsKOU08CDdLiHiVlev3Q7eRWXLQ0/Q15zKWM2vfl6wIDR+3h41rnOqa4VF9ubpXPSmQyVuKGB3A2VHR0wUs4cIaYpmQ2UiGf36ML0YQC03tA92mTygbRFSx9idJ/Yy89NTNqCpLeJp/yOIe6+iIKetAv+yC7X67r6aD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468163; c=relaxed/simple;
	bh=QQTYl1Q3c6ekdyWs4N5L+dSkH8OqXES6uHrAxhqGu80=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c/NRvcARwIa3upM29MF7Q7v+9lYPDYvk4crdqUDmssLtZvAQf1UdNcqN1BaRDW3W6cZge2KfhXb/LGrovLOsbrR0Yzhkvet7Li8ZCl6iygNMSQISj7K1OBWxANrMPzx16ZCSmIA52hk1jskUp6YpjXSARhUNreyVDSsV3N75cJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=fei0goZE; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=GX79H63O; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220294.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6LDx4Z032022;
	Thu, 6 Nov 2025 16:28:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps1; bh=HsBSLPwM6+SCWjgfr4Oa7OIc9Ni
	xvGiixNOFI5h9Sp4=; b=fei0goZE8r3yLJ7qyVGKogj9UboHkFJlqe6s5jHvcK0
	didf3OVToAfsDM4CEkYhfGRd2V9aKH/pbP8QwhFYeATpgumo/tKDGuU7KdG3J9sC
	0IbyJ8uLOWQRLHG5mW7NUSqiM2kXnotQD0wGMBJVx+qaUDdnSeMS0xRI2rgZ6VCB
	Gzj525WrJ/akixwJA+oIbb54ffTZNdVxa04E+uxj6oCcfFEgNUStIJIFu6pimmZI
	2K/NhhERlWZTo7VoZdjiHxmvxtqm/yY/3nrNlPRWNABudxck884/Pl/znb7pwkke
	F7Dn7LGpomsCUedKgweBu6oAO7BeUrhSMciOU8gsATg==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11022076.outbound.protection.outlook.com [40.107.209.76])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 4a93dgr4dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 16:28:54 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bG5h3T+p92dFnfV5yz5u6ynBkUsDREoI5sJOijD7CkybVIPchOyRjEU+uhppW7oOS9nsERMxkAVGVUtF98yNJDhU4f+seHc1QzW4rz6XMO87I8D1NtVOqjmyF875W/llf4+Ri/P75BcjZUbVwbB8/6Xn5G+HJzu8LDiBo2xTDuMoRlR+ID7urxt6Faat6uOBxIZI133a2/y2djXJZjPpVvuclCPTI/fzPmWNxbI3Z5Rh05UUXVsYDMJKsC95HgLxva7L4ydgaLltrslhjLFx0DgYWbRTlBWQbJegEecP7xpgKR67+8N5h78QnQTa974lrnYLsTvJenfuWtlK2rv9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsBSLPwM6+SCWjgfr4Oa7OIc9NixvGiixNOFI5h9Sp4=;
 b=NbMb7P5UAxN4fXX01hLGCI54D6j6ciIpT+4sPEAhtgumcXLpUX8YPxNsvucV+yUTDZSNvshJK1S8ZgvTcWeDohgk4aP60EBxLmiKiD5Pxt2uz5i+vJ0JVXB91/uD00V6odYKgNCVZlL2QaezpGvWPNBI0TTS1CDssQ/azPYyQ6YukZ6JN6ycZMYxSmgtI2xt9hJ6gTFZI0wJZwKAQQOzuw2GwQiYjyOSn6jOtuQwQMTgi3poCOE5VWhhtLrXzqxg0yuF0r84zSTVN63cXG1uM/nvilthgpnqaUpTYrLOBbuwBhsjypicPxEtBL9TAtZZkPCXE8sharlYShq680HNvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=garmin.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsBSLPwM6+SCWjgfr4Oa7OIc9NixvGiixNOFI5h9Sp4=;
 b=GX79H63OstOagtfTsbvCZgtUzcgaYLXLct87hbMUJyB9Ehehbms6idc63zr1n4iRYRQ/FcxC63HGwvcFeNjr7J4OCeQ64MUxyqTpXiCkM+NFYKAPhPxAJMZ1f67pFcSMS9kmRGI6Yz/dau5gy5hFfe8nvcfxL74OHcrN6TS6VFRQAb7RnqPpha1QCtYeAGlA1xn01e/CjC227Ys41MAlAbwmylZ12zXLXbLTm3VecXr3FHNEiv336My4nzDBtMbZ7b7yuEfevf1QV7G0hedflKrxqnpJprR30cvrNSid/lA7zjNOIoq8qD9IqYr7Q1qOy1kjO8b1OaH3FJBm6s8RXQ==
Received: from CH0PR03CA0118.namprd03.prod.outlook.com (2603:10b6:610:cd::33)
 by DM6PR04MB6650.namprd04.prod.outlook.com (2603:10b6:5:24d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 22:28:52 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::62) by CH0PR03CA0118.outlook.office365.com
 (2603:10b6:610:cd::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Thu, 6
 Nov 2025 22:28:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 22:28:52 +0000
Received: from KC3WPA-EXSE01.ad.garmin.com (10.65.32.84) by cv1wpa-edge1
 (10.60.4.252) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 16:28:46 -0600
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 KC3WPA-EXSE01.ad.garmin.com (10.65.32.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Thu, 6 Nov 2025 16:28:50 -0600
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 CV1WPA-EXMB1.ad.garmin.com (10.5.144.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.57; Thu, 6 Nov 2025 16:28:49 -0600
Received: from ola-9gm7613-uvm.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.73) with Microsoft SMTP Server id 15.1.2507.57 via Frontend
 Transport; Thu, 6 Nov 2025 16:28:49 -0600
From: Nate Karstens <nate.karstens@garmin.com>
To: <netdev@vger.kernel.org>
CC: Nate Karstens <nate.karstens@garmin.com>,
        Nate Karstens
	<nate.karstens@gmail.com>,
        Tom Herbert <tom@quantonium.net>,
        Sabrina Dubroca
	<sd@queasysnail.net>,
        Jacob Keller <jacob.e.keller@intel.com>, <stable@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen
	<mrpre@163.com>,
        "Dr. David Alan Gilbert" <linux@treblig.org>,
        Tom Herbert
	<tom@herbertland.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net v2] strparser: Fix signed/unsigned mismatch bug
Date: Thu, 6 Nov 2025 16:28:33 -0600
Message-ID: <20251106222835.1871628-1-nate.karstens@garmin.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|DM6PR04MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: fee55901-e400-4c74-79bc-08de1d83dd6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PBbv5f9Wl9W3lGCZhpOB1MbR05vXBy9WpmF/reXmJm7xUthdeegdwFGDcST7?=
 =?us-ascii?Q?1/GpIpTJg3cpRSutIAXnDKcxeBTEeLkxunBsBXGSqFq3qB4e+Olli8WHMDOa?=
 =?us-ascii?Q?1JOzETzA0MXy0dPuzKUsJ01V7UJea5v7dBkkfAFSaqTaS+0zyd7/uz4WyRf/?=
 =?us-ascii?Q?Lx02SyyeV7aVNxKYuhVlJpfxjJm66Z8lEL9gg51v8hmfbfnu/GPHmHChbJPX?=
 =?us-ascii?Q?97opnMfdxeow5Gf9JFRdVjpXbYVaPNitNUgnX9aYfFVww4Rv6e621rrRP2vJ?=
 =?us-ascii?Q?cre+U+KkCmTR1jSI3kV6+GRNmAgXwMbdUIyUhYUwL8K57/4caBI6f1KUoZn6?=
 =?us-ascii?Q?jx5fE6U6Ob/76CLMn7YcoWHftzv5Fnu0RKq0euJH8EsRGSF61B1vynj6JO52?=
 =?us-ascii?Q?cQdiOqGmvcDiq0+cIaes7JBQmKYBx78e+a1HKXVEvW0m5cQc/DOSq7KiQOOy?=
 =?us-ascii?Q?ZF3Odb6rgynRbYIaQ7s8o3fpczdRBHH3DeLYJxoqDxObLuwdyQ9QbYiTfQn/?=
 =?us-ascii?Q?VGCqNeWHWC8rJ+UhjIR5VfY7QOHga0awoQmdBMrA8V6nG8Xzu8J0SeBr7cTe?=
 =?us-ascii?Q?VSRUOUwxDM5iC3/nE07hpPczvtkZh14ydFASZEj7eGEE/zYuYY5ZCacHZXRM?=
 =?us-ascii?Q?UP6WKOWDcnxkEnc3BeHlBlMo6iHCYVAc8NCOPZaXIGTvEDcfIzZLjVanN4pY?=
 =?us-ascii?Q?O0LomBALIJ4NcAwJ3NtSsmpJyfX8hSCBtzHO/H15DNtIzPr1A+73y0s+pyfJ?=
 =?us-ascii?Q?J2KTHrmnoJX3tu57zPRxcKiqWVJEJZIC9QTBbI/sw+CC4KU3dFlO4M89b6hH?=
 =?us-ascii?Q?Fcej6R2Fd9AdUfrQErpAcCCPIEsLyhk2QPg6G8THRu8rCxoTB0MF5px7k9os?=
 =?us-ascii?Q?4AHB+hfT+8sYX0RzzWwoDxPQhT6R6ltZDZGgfJ4VwJzvn9hLTvUSRmovJeLf?=
 =?us-ascii?Q?SHKVQtAU83JOw59url8BjQ850eGAiy5zRBcPedD96FooeYviofAfhziU2mTW?=
 =?us-ascii?Q?/HIWf9mjhClblwlGCo1+UohUQ/tQUu2+fXSHc1Z1Pm62MTrYhHPXBYQqDEpU?=
 =?us-ascii?Q?15q8PN8pF7J0MrdHxIKvCJMmwN1wgbgvifJ4xlsZK/PWr7qEFtv1aud6MqMR?=
 =?us-ascii?Q?DNMn1bC8h6OPxLM5Y3j4Mh+J2pw62zJ97GoFFIKwKt+iymV1wLxlkI+TDEOq?=
 =?us-ascii?Q?d2EIbfzizqVtZkl5y/cNO+fYYlhm0S+y4nrhD3n0lyvx8Szukw8MVA5RYsyT?=
 =?us-ascii?Q?oC4mN3LxxOTE9UiFi4hPq3MDN8xfmyNBj1Dp8VA6H+lye6ixMcfr4JnCCdwr?=
 =?us-ascii?Q?WV/JGFDxVP0XZQu8wt5hGixwUa3vFor1EbcZbc8lWZuZk2nBVFLe2per+C8m?=
 =?us-ascii?Q?t0nC6CMktc5jUqtRdl3/Kb93SQ6iwUTkrspZw2HB83H12CJej726VcFY3YB6?=
 =?us-ascii?Q?vmXMoOIAIHvwyKe1oWdAsczxd02X6dnDoteUyp2/nVkNcaHPPxmAP8vcGN2i?=
 =?us-ascii?Q?DhONl/0LTbU6EFLeMXksk/Bw3Nccf6HjQ4uk8mBJr4zCwZX5FLXcvZ7aV/8H?=
 =?us-ascii?Q?6kOfFJRZCo92Qrp4Ukw=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 22:28:52.5185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fee55901-e400-4c74-79bc-08de1d83dd6c
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6650
X-Authority-Analysis: v=2.4 cv=QYdrf8bv c=1 sm=1 tr=0 ts=690d2126 cx=c_pps a=iqhpHS1GVmy1vcQnvunGbg==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=6UeiqGixMTsA:10 a=qm69fr9Wx_0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=NbHB2C0EAAAA:8
 a=VwQbUJbxAAAA:8 a=lX9ijenlc9IpQ35JxxEA:9 cc=ntf
X-Proofpoint-GUID: L2in-4GiUupR4PiiKTObU7Fr29kiz2qF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDE3MyBTYWx0ZWRfX6/mhmWBSEUn3 s0Rjq/9VJ9tYOb+PuwtwPRiQaTPjaTW5ZifSTaEqhbxt9mra6GBHnev07Fm1LjTsKm+uur5crUG i795y7Qax8rXJex3KRQ84B3YwNIstvhJ3e/RamkRBiWtihZi5llaF15ghtrdW/M3QuVLQvZA3Mt
 uBHW1FupZ9q5X5hd7Oo4J9Mdu2x8D4R0HPoDnq/E/33rA1qOg24CMn+4eDxWm7y2CIJ1kA95z5F BD1oNfwJp9XMHYPIaXzn90hMTtLeguz+pPihUpGKV1NQdMhPoaPzkw0GzpK6KRyyfJEJbl1diZR YP8oUrmRpH0yAOcc7ptWHCFHTir02c9U3gy+5ZghS8g5CtmkeX+dG0eXoZ/8j29K6/+MGm/rRJ3
 NxTv5cX9B1Ogrb2x92EoI1Ujdxyr+ClvHpFhm4/t2wGQkjirX5Y=
X-Proofpoint-ORIG-GUID: L2in-4GiUupR4PiiKTObU7Fr29kiz2qF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc=notification
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2510240000
 definitions=main-2511060173

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


