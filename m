Return-Path: <stable+bounces-192551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB76C384E9
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 00:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 846564EA12B
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 23:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D162F3635;
	Wed,  5 Nov 2025 23:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="QaU/65PD";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="WWhcxvOh"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3C229992A;
	Wed,  5 Nov 2025 23:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762384378; cv=fail; b=gwnflcI44Pqaf2eWQy/Q9TSWIaLhk0I6sXjEgkMOg89zsWe6ceuF3a8ZBB9R4FOdWv/QWEdaVX83xE+cItOz/+O6kXMDkqnLcPVa4exlpX99ONOTflYKTYboaFIXdNgNHpNbvUItdk1uNYOka+V0Zkow0V/YdJCz/iMhD35ZMzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762384378; c=relaxed/simple;
	bh=31LEjb4IW2AqB76Bjhkyma1aAFjqLcSAyQtQzPObpj4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HofwJza3p0rMgjkAPem3pVtf1eIo1cB85tbWXZHHCuQdH5Jka5htPj5roCSj4G1wBzDCHDJJrNMJtHWcAzzmNX+EHam7F8XqB6/Wd088ghNmI28rwNXrZ3ZjitbTUCnKzC+NZGAngMWfE9OlTyV7qW5mBL14SG9d74rnDJbKW4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=QaU/65PD; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=WWhcxvOh; arc=fail smtp.client-ip=205.220.177.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220298.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5KUntw019221;
	Wed, 5 Nov 2025 17:12:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=31LEj
	b4IW2AqB76Bjhkyma1aAFjqLcSAyQtQzPObpj4=; b=QaU/65PDoY0oFVSzw08BR
	TglgsWncqY2IjB0A+0w48mpOoR+mV7Il1Fi4eyHX9U+8tKAb0LN9T+GghlcFgPb+
	KsxjV64RXtpllOjhrXFLp8tojiyG6lovYDLtpu/D9VJkjkQZpUcndHcvVPOc2oAv
	xVhGZCNMl2Z2vG2NJpo1eddMf0oDIkDQoN+kEJtngAcXddnWeR2mRmjBrfWSO7sd
	1wrCnJHbe0Ie1gzYrILhI6xdS6kuXcmor65KrgcjP62v+EXElzeC4WSYggIL7aYO
	rv5sWiVBCdA5vfRDgcI0kfDr57XPADVhISL8kvl5S0c/AFnMrHb8VfzYloYuo7gy
	w==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020073.outbound.protection.outlook.com [52.101.46.73])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 4a8aw98pyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 17:12:36 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFukv64pv22C+kZUeKMMUtkfNNRmdC+rYYzh7boH3rxm7YyirqYQwNDwGEm8tI0f9SOHI+CwtCWpbPLbEnBoRcczex1qwyxD4qCy4CFZcawVL101Gej/TKP12W0tWViLCSVyfE/nj3O17F3PMDpPDh18ussgoWTfecm9OUxWpFKnDQm1+MobWGkQ2caBxNVaAueR2/GfBzezcErzKuI1gfddNT7zC0Y+Af6PADF3JLpN2PIU76gw20/0zHRzYPi523HZCYZhxEBD1qqqjhGAiaka6c9sFaQ3wTBEMYHpBZU6dftTeTqfvPQfJdwf7iFlnL5PDIvVQUFjZuoJ9yMyOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31LEjb4IW2AqB76Bjhkyma1aAFjqLcSAyQtQzPObpj4=;
 b=MkfAeGFVSYcDDWjh8X8xP5pZiJxyzz5yftLj0DUFmzBVL/R35I68+YmVFHLHPyBYl9GNfCvfuqDFrhImgWn5QO2zZxiYHo7lehPmmskYJKkaNjDHK82ZjgSMxTHrm3ARyNyCsyeCK3Oe6IodjNwQLmxdWKTAz3m3oiqHoQAtTa7bkURA+lBjYx7ErsOj2uAIqjXbxH5RdkuQCD18Vm1OJq7bNNmmAe0iJtFg2YDBTgni7/NVF3aPGi7BIWSUio16H27GVNA4T4rA+FlcZvThgDL5iSS2lDCsalXFRZKtLwsJJ9fr9CTOrEn6STG2IJNOHvwfvit31Xpx1Fxiltw6WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=intel.com smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=garmin.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31LEjb4IW2AqB76Bjhkyma1aAFjqLcSAyQtQzPObpj4=;
 b=WWhcxvOhcC3fzhDccGMt43IkRrzAG6I2d1w78+swzcmosew6skKs1AkI+X9TbJnS+1sasir1SiyPCKaqrl2AfhidPPh47F2y6MpQHStBTw3GKIjh8goODponi5VKqj+bHS4aZ29mYwKsZ9bi/1P5QNTDcezWvLXPuKH0XmHB9NFHFU87qxOdpOVPEUvAp5fX1q3KRrr3DpIuvSelp3FQ7MRhTJ60uP5pCAlu8RH1U0o3W3jJ2i2oc8mMDCuQltThmYKJUnieq5HPIlGlDB4uEat0LVv5yrs7U7U46sRnjbd1Cpeb0ky8Fj9UbiOyL1Tqb5Js4Qz2XpbTiTjPt6jMTw==
Received: from SJ0PR05CA0139.namprd05.prod.outlook.com (2603:10b6:a03:33d::24)
 by DS0PR04MB9368.namprd04.prod.outlook.com (2603:10b6:8:1f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 23:12:33 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::4f) by SJ0PR05CA0139.outlook.office365.com
 (2603:10b6:a03:33d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Wed, 5
 Nov 2025 23:12:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 23:12:31 +0000
Received: from cv1wpa-exmb6.ad.garmin.com (10.5.144.76) by cv1wpa-edge3
 (10.60.4.253) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 17:12:09 -0600
Received: from cv1wpa-exmb4.ad.garmin.com (10.5.144.74) by
 cv1wpa-exmb6.ad.garmin.com (10.5.144.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.26; Wed, 5 Nov 2025 17:12:13 -0600
Received: from cv1wpa-exmb2.ad.garmin.com (10.5.144.72) by
 CV1WPA-EXMB4.ad.garmin.com (10.5.144.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Wed, 5 Nov 2025 17:12:12 -0600
Received: from ola-9gm7613-uvm.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.72) with Microsoft SMTP Server id 15.1.2507.57 via Frontend
 Transport; Wed, 5 Nov 2025 17:12:12 -0600
From: Nate Karstens <nate.karstens@garmin.com>
To: <jacob.e.keller@intel.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
        <john.fastabend@gmail.com>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@treblig.org>, <mrpre@163.com>,
        <nate.karstens@garmin.com>, <nate.karstens@gmail.com>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>,
        <stable@vger.kernel.org>, <tom@quantonium.net>
Subject: Re: [PATCH] strparser: Fix signed/unsigned mismatch bug
Date: Wed, 5 Nov 2025 17:12:12 -0600
Message-ID: <20251105231212.1491817-1-nate.karstens@garmin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1097ef25-d36e-4cbb-96cb-7516c1f640e7@intel.com>
References: <1097ef25-d36e-4cbb-96cb-7516c1f640e7@intel.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|DS0PR04MB9368:EE_
X-MS-Office365-Filtering-Correlation-Id: ed612ee0-3887-4196-bcec-08de1cc0cc4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xWw31F9f/9aymSmN0saxGhQegW/vQJYLfG4Bd8PeZ1tyglxOVqY/u0neawo4?=
 =?us-ascii?Q?NX2N8hRrU6PaYeqCsKzgKAj+K7RjsnusVAykj2PUXO7kQ54cUdaZs6UpZRxS?=
 =?us-ascii?Q?+wabEQZ1YZjWuKnN09H9BlLTXgPBl7WaVTvtzKzsCe/NhRdgNE/EP7BPypgL?=
 =?us-ascii?Q?VBCLzIn+GMZ6YFeWoy7VOrkeGu3Afb3RSXnCozE88cSpaA+13WGPXjc0qjRy?=
 =?us-ascii?Q?XkxeDay0IM7FGsm1HyLKwEJ/qQ7o0hHPd6Zg7hfDTUNwI86wpvyW77H4Ur2+?=
 =?us-ascii?Q?ervClDBirXGXfVjf59sl4fgehDhwBUvhsEEK4Ve6cFMshBE1CZu8tgAOgouJ?=
 =?us-ascii?Q?6Tq91JBdcFkg7cprkn06ABDubun7cvHz/7WTzk2TU1Nvxf6jBV0zkFyF2+yE?=
 =?us-ascii?Q?d/JHBPJT3GxwytshGRbH1X3Xm/jhBhQCpEbjqxXDHk3KoxrwzCoEwDq3J9fL?=
 =?us-ascii?Q?0WfXFssy0dcWdUBRxok0p/gcPDrjmkmzwYB0fuCuUqw+NpgCWvOpqAc1WPzH?=
 =?us-ascii?Q?cW+n1zgIaaAJpCS8reiBP++dKsOzvpCcfGG6BFqBVFg4+5C6SMJ8hl/VazFZ?=
 =?us-ascii?Q?8ueChjnZPSM9nfS8HHpBzwT5KkI1acStO59OpzVEyAf+7+sIXIwmR1ga2oW0?=
 =?us-ascii?Q?0t4r/w/wRDTxaF/67yTu1+s0yREU5fLJe079BnHuHf0GNo0O4el3sqQo0dzQ?=
 =?us-ascii?Q?CiCNWkInYpq52rrrbYufuNdBjf0SytYvzjGM++71WhprrkEQryv8GOlOrUV0?=
 =?us-ascii?Q?QWyxkDus0xfYTcrH2dnAa/6X6Dmk0Qq2wkZyZSCn6OraYTYu2AWabxKxHjrJ?=
 =?us-ascii?Q?heV9IJ1U+pQSov6ncmHdT1LGzE2FQvdn3djrZNDMOwIedMSb4MXcsePvaisc?=
 =?us-ascii?Q?TYRpQfrexmpkG1UdXSnM8hXlfbmZohVCmpA8zZlG7TSvMTwu/VxosRo9EpRt?=
 =?us-ascii?Q?hhHrQsLWBOtxzuUAw3ZDApYkVqDi49X8JXYofNjZmEcuPfK6F6bExMwWLY73?=
 =?us-ascii?Q?HoJ/ggCWPGb8vBICDlFAayYPU/rG0j1tv3jYxMsEGXixN2TNN8FluyZTJ6ps?=
 =?us-ascii?Q?gA0/FOm4huEYGFfP/P/OnrHdmFxJJucTyuP7ZdSQCeIUfcsqMWmUROL2aE14?=
 =?us-ascii?Q?sBKoq4Blfmk4B9dYXoslDsstc2foqE7dgwPTLJ9us1iZMdbQtPk5PUXCH1Hz?=
 =?us-ascii?Q?TK9hExiyMCHzvDcY9BBn1lARMhyeHpdgJe7gFe7mod5DdsBqWAGy5z976i6R?=
 =?us-ascii?Q?8fCAmzk9uTa5NrmVvELI8vA+qCxzBpkKrY4F+V/h6hp6vAj7mKac5u2asBML?=
 =?us-ascii?Q?KqnpRBHYGJSrp/LGJXLbcQQ6zvbxTMp39GylXrqEDyTI1Aci/ysCHb9cVs9A?=
 =?us-ascii?Q?3+9sU4E5SEiv1QvP0s2p7IR4Vnsdvi29L3XhNoJm9tfuRDLfjVExyfmjAujz?=
 =?us-ascii?Q?cBSL/8z7B/QdlNck/TGLdHIU8sohX8pG+lIz/nBHlRQJAXYpWIXgm6lOXzCx?=
 =?us-ascii?Q?AiXQxApQL5fpABStYo8dwC58j7NBlANDlUcyeSWHPqvqXvIfGP6r/JuAAbZM?=
 =?us-ascii?Q?ogkmTz59g6nqdF8lKM8=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 23:12:31.8437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed612ee0-3887-4196-bcec-08de1cc0cc4c
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB9368
X-Proofpoint-GUID: wEHLIe1XP6DKcQAofnRwUIhyWQekwmt-
X-Authority-Analysis: v=2.4 cv=Ev3fbCcA c=1 sm=1 tr=0 ts=690bd9e4 cx=c_pps a=NUMs+PEU/Pz2DPnLQvFO8g==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=6UeiqGixMTsA:10 a=qm69fr9Wx_0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=nbmrX6kiSIJ956-0F0gA:9
 cc=ntf
X-Proofpoint-ORIG-GUID: wEHLIe1XP6DKcQAofnRwUIhyWQekwmt-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzNCBTYWx0ZWRfXzWK6NmXAitgm ITofm0wKAtfxz4cMtqCBIjfV/NL67//VoZ+xckKDPJZnnxRbjv/5E9LlNdcKwxrycgdlO9zd/Pk fsRPZK4ha8qAGQfwAw8cDSd0bfPuQjhYjVKaBluDg1ss5tKbVR/63JvnO/4p6eDzXD5RuJKeZxi
 iYvNhpjZeXAJ3DHoISmxmsmaSTJ2x+GFjcAZkl7PJU7eC0ysdn71ekEO0l5uFeEbNH5Or4219+l mAsTnVPI16jxnV6RrGF3l+4s8jxPILzX4dyuKvHXiG73tdZGeAj2lg0HftOUlCAwTLe0TDuSnWq RTyraprzuKp+7OaVLy3qHZeDBbZH/uhiOHBvE7V5vw4BXHSbJAYr83kFw+CokuEF6JTjSPbrFea
 ib9GIDf0s8bDT67NCJfhsLizwb0Wn/ndLJRi6Fp+fuwItLxsZyU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_08,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 clxscore=1011 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc=notification
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2510240000
 definitions=main-2511050134

Thanks, Jake!

> So, without the ssize_t, I guess everything switches back to unsigned
> here when subtracting skb->len..

That's right. In C, if there is a mix of signed an unsigned, then signed ar=
e converted to unsigned and unsigned arithmetic is used.

> I don't quite recall the signed vs unsigned rules for this. Is
> stm.strp.offset also unsigned? which means that after head->len -
> skb->len resolves to unsigned 0 then we underflow?

Here is a summary of the types for the variables involved:

len =3D> ssize_t (signed)
(ssize_t)head->len =3D> unsigned int cast to ssize_t
skb->len =3D> unsigned int, causes the whole comparison to use unsigned ari=
thmetic
stm->strp.offset =3D> int (see struct strp_msg)

> If we don't actually use the strparser code anywhere then it could be
> dropped

It is still used elsewhere, and ktls still uses some of the data structures=
.

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

