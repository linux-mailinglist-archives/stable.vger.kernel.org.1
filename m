Return-Path: <stable+bounces-196903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB5EC85331
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 14:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC62E350FEF
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 13:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488F6221710;
	Tue, 25 Nov 2025 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="gcmkpTy+"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331D421CFE0;
	Tue, 25 Nov 2025 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764077839; cv=fail; b=naIiU9x2gvTrZdMhVYJ+z/Gcu3i3rDNrmbFB9+KsR44Ez3xJso0trV9iPCcMu94UTBwZWfPquklgUkSNhqvteL5AF8SJXxWTboLU1EBBb3Bng97XyjmoTlbZJVeku0x4BXNrI7t1rCpOMQl1pYe9FVxeuSXF+AELiq2q7LSXk1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764077839; c=relaxed/simple;
	bh=sil6gW5x53tuaF47nMmn2VGSIBEkMdk1eAFvInWfCMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lwxntXUnKbueqFRVC0f0VmISGSlpx/oq8ERiiAcHnoOJKKSpxMquDxkqaTEOL3kO5mT68FukSuXUikfKr4hZ+w1RzsI1cgwus2tWzXYOEl94clHKQBwBBLRGZh7bmOsqMO5Xj29Br+1JSytlXAQp6ZMkMopmGn8tAtXWfFKz0v4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=gcmkpTy+; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APDMxIO1211330;
	Tue, 25 Nov 2025 14:37:04 +0100
Received: from am0pr83cu005.outbound.protection.outlook.com (mail-westeuropeazon11010039.outbound.protection.outlook.com [52.101.69.39])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4amt55v0nf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 14:37:04 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ql5Beb9jpezv/MGjcNRvgck/cCqnkBE1Vgq7NlE/uEUCCN3ZuMwTMEGIpJjpEy8DCGOgd74uEWTfnMZCILaNrcb/saFNx3dboU3jvxhF5feCS7VATTURHcCl+D7swXP52C9x2QZXwgIkucLy7q9WbtAdQvrjh1wMDNwULMsJNuuYvNGrlIiYgyl4mapUFcYUh2uxZn2gEDDNIbrHN/LQQCVdbdjFhGDZDD2CuDJrJUuwphAlIPejTCYp/IU3XXsZaBntykuG1BdBuBQu3KZ07GhXCuFs9iVL+K+43QHgjjm0tO5DSTidERvDefK7dZbfEdLVaaYkHr4PH6aHWGVGYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmNRRFQu8picIIJsmtYusoh+w+wB2HtLEplKdyn43GI=;
 b=N2NgWHsDshv5lN7++T56xDhY7C48ZSwDAcHWb6oVjRQjC0TbdKN4IHtd+Iq9OUUwzlzucG6mEWD3AhCREhYCO6bJHQL9rTNkwaP1EcVN5itJPg0CBz1/qc+gQ+fOK8+1ye+FkYwOAdJ44KZZEDzN4B7X257wXn/+TIy5K0/gc3K13FHQqtyRyhW5kq62QQLTAwkYMQz6NmUUCCl4Jsrb56wcxEddsLIUhs+Vw5S6Vm96C01M6CeASEZPRUZ7pNqD2FG79hVAaPQdXYUUqZH++ARczyMW0R3cD5b40LRcQRMb23jW6UGtVpKQgqddHnTg5xyy3OIQIDvmPVFcgAHpKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmNRRFQu8picIIJsmtYusoh+w+wB2HtLEplKdyn43GI=;
 b=gcmkpTy+geGSmsI4yaeuTRmON72A/hn463aazZWgnNv6DJcvcWzff5haqxZjbYB1QXbaEQl/bsmLM/ouOKa4VtHx+vWAbKSNu4lP2uL3oiF+/jUAqD2OPTRYD+wAoy1Sl7MfxRijfSM0K7y6lcajCYCTd7YD0msxV76lpkLXIHENfleoK/ZvTe9jv2hr6ZI1YxDEvkRCi6lxmdh0r2DCK4MzXPWTXY7hSqI5etM3zKk1Ey1ZSSnPN+zpB3M+of/k/MjOMqZrSoY6QNaxIdRvrolFTsnV2UXobPlx7Me3HZncdaiKR99dbTCHQvyJlfryhgsdPriAv7n/LN7pBh/hWw==
Received: from AS4P192CA0011.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::8)
 by AM7PR10MB3224.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 13:37:00 +0000
Received: from AM3PEPF0000A799.eurprd04.prod.outlook.com
 (2603:10a6:20b:5da:cafe::98) by AS4P192CA0011.outlook.office365.com
 (2603:10a6:20b:5da::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.11 via Frontend Transport; Tue,
 25 Nov 2025 13:37:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM3PEPF0000A799.mail.protection.outlook.com (10.167.16.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 13:36:59 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 14:37:31 +0100
Received: from [10.252.13.178] (10.252.13.178) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 14:36:58 +0100
Message-ID: <535d0468-f194-4e04-9f2b-ba27151d2672@foss.st.com>
Date: Tue, 25 Nov 2025 14:36:57 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] ASoC: stm32: sai: fix clk prepare imbalance on probe
 failure
To: Johan Hovold <johan@kernel.org>,
        Arnaud Pouliquen
	<arnaud.pouliquen@foss.st.com>,
        Mark Brown <broonie@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, Olivier Moysan <olivier.moysan@st.com>
References: <20251124104908.15754-1-johan@kernel.org>
 <20251124104908.15754-3-johan@kernel.org>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20251124104908.15754-3-johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A799:EE_|AM7PR10MB3224:EE_
X-MS-Office365-Filtering-Correlation-Id: 85dcc143-fb71-40b3-284f-08de2c27b5cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnpmMlFCWEpBM0o5TFB1WTRSdElWN0hlMm1hdHBVdjB6ZDhoRVlZWXdkbDJO?=
 =?utf-8?B?Q2o5SGR5dE9yMitsOU1sT2hYMDhMWWpUS3UyQ3hFY2Rxc0VtVDhLbnJwT0tu?=
 =?utf-8?B?Ykt3ZXd6cjRncWJhRUowa2FJRFBJbEhUS29xUVFSY0NlMy8vaWVxSEU4TzJI?=
 =?utf-8?B?Q012U1VaK0JZbElLUlp2QktNL0ZzN3R0M2JYUUoxd0crRVBoMmVFUGNIN0g1?=
 =?utf-8?B?VFlBZXFpTW4wY3prSFZHcjNsWFB3K05FZHY3VHFXc1dhLzdMZHNuUGRmNTh3?=
 =?utf-8?B?TDFqUkN6Skl1cHE5TWpqVFZxaUJxSEIwRE1TRythYzZCRHJSYTY4QU80M2xM?=
 =?utf-8?B?eW05a3c5eDBDOHhqeCtTU3lPL3JyYlFLTmZzWGJZRHhQUnFWcGpvbS9QcEdD?=
 =?utf-8?B?OVR4YkNxM2pXTS9OcGZiQkNkMElFcmx0WjFKcDVVT1JEVEF4dmpnOHl1VEJu?=
 =?utf-8?B?dGNJMzZGZkE4NFJiUDRoT3hHSndxQTVYMkE5bjhjbnhRY1VUUDRTekhIeXQ1?=
 =?utf-8?B?elpyR0lEZzRRYXYwUFRTNWdPWUd5ajRWVnZFYlBrRW1ORHBxelg0aHAyV29X?=
 =?utf-8?B?eGNaSG9pdXJCT0JwcUJDZW9WUTUwS3oxaEZvU2tSVjdlRE5oNlhha0xpaGlp?=
 =?utf-8?B?MzZDUG0xWWhPODUrRjFGZlFQMGQwNDMwRTMxRk5oZ3hpQ3ZjRjdneU1vNm9v?=
 =?utf-8?B?djJHUUFRdVRxT3RjTEYwZUlwQ3F1RGlua29JNWl4U2hJR0xheVd0SityTXVt?=
 =?utf-8?B?eDQ1bDFoMHVVQkc1bFdENmtxT3BZYjY4dFNrdFFQZkd4d2pSOVBxMHlMbS96?=
 =?utf-8?B?OWVaMyt3Sk9Tak8weXBUZk9za3haNmVmTU9jNmtZd1FhcWs1YW5ua3BuMm5D?=
 =?utf-8?B?YXBNVDF0SjI0SDBPdlp2UlQ0UEhDU3Y2VHZtMVZTY3A5UnU5a29jUGZaeEFG?=
 =?utf-8?B?V0NUUHgxejN0T3RmVjM5cnBKQU5IMHIwald6WjVIR3ZOTlFXc2p5bHVaRlJz?=
 =?utf-8?B?UnVGVGo0bytTbG9JWlVqZS9WMmU0WDdpaW9KMmNyNVVrZXJWVUgzTWNwelFS?=
 =?utf-8?B?S1Z2SjdqazRSUHJpdS8ycUlaTGVkYms0cVpQNXVqaUlUSWsrcDVIaDgyaU5C?=
 =?utf-8?B?WkxpVENoWDFOVEd1aGhRdk0yWXlmRVdZNHhkcU1aUHVMci9XaHA2VUpKM09p?=
 =?utf-8?B?ZlB0Vjg0Q1puUzJkZVRicFRPR3AxWWtaUmxQMnhSMzRJK2NMbnE4SVZKa0Na?=
 =?utf-8?B?UlZXV0FtUWJuZXIrS0l5dlIxV1JnbHVSL285NnYvdlVZVDUvNWJEb29kUUFv?=
 =?utf-8?B?elNWK0g4Y3pFMjB1NFJBQzNBZVJyZ0VzWnN3Mk9ENkJmWnlkeFFRTG8wdzVP?=
 =?utf-8?B?YTVVcmtlWDhCL011MUJ3djZzMmliYlBNVE0vV1RoZ3lIaWtqVXpuMXNuTzNI?=
 =?utf-8?B?NGZvU1FxYURPSmFOdFVqcnUwajR1SFlPVkRsUDlpWnBQUG1aL3hFZDkxQklk?=
 =?utf-8?B?SlM5RWVjYmx3VURrclFGNWR2dnNGVFEvRXBVNzM2WisxVElKVWxNZitSZE9E?=
 =?utf-8?B?UXdDSUY2TkxISEdBYkJxK2wyYkIxcTBNNnFnQ1Z2ckdnQU8wRGRNa2FheVFT?=
 =?utf-8?B?NlVqK08xVml2QVA2VGE5M2hveTJFRnVVYnVQTVJaUlVRekxjUFVXdWtHdmxj?=
 =?utf-8?B?Tm52MlNDdGdmcmRJOWk5eWpvVWZIZ3p1U1ozbDJwRGZNNkplS1M1QkNNOVYx?=
 =?utf-8?B?eWR0VXlrMFc2WkRmeWUxdXlDelJPQkFYWHRQaW9mWC9qblArQnNIOFFuOGs4?=
 =?utf-8?B?UHhkR0g2S0ZvaHV5bHB1NE0xTE5hVWtSM3JTTmVDMTJjOUd4cEJIU1JuNlll?=
 =?utf-8?B?Mmt6VXIyNXluNGNCQ1JhOEhmZzZwd0dJbSt2WVlIMFRxQS9SNVBPbDZFaUdt?=
 =?utf-8?B?MGtXMENPZUNZNHFneUJyZEM3WHhTa0xmWGxrRVVUUVJWY0ZmaHo3YWxnNnBv?=
 =?utf-8?B?V0Y2dWdYdVlZNElOVjhPYXZjUWMrenU5R3BZWFpITDNOWlczeVgrYnhaSUVH?=
 =?utf-8?B?UVFWc0FEaUpnSTRrTVdJSlI2NC9pM1VPd3ZBQWFKY3NkdldvdkxGWkJ3UHVp?=
 =?utf-8?Q?UYO8=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 13:36:59.7799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85dcc143-fb71-40b3-284f-08de2c27b5cd
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3224
X-Authority-Analysis: v=2.4 cv=EMYLElZC c=1 sm=1 tr=0 ts=6925b100 cx=c_pps
 a=x4xW8dTIuPyjN86DDFALrg==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=YK2f4aGzhgIA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8
 a=JXPbA1VN-0EU_hMV9qAA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: U8xIDQpvrNuHzeLMPX-cfMRi-JxgLILl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDExMyBTYWx0ZWRfX5+68W3EAEroh
 YYJni2Ik2yvZmqjQT50Exvmqg7/JiC02xwHdi+ahG88txmFJ9qt6valnl1vy6G1dwirSiDaql8q
 BGCUpnpLa8KjsA1D8llKsOw374M7e1PTtgBlqs85KBGX8Zv97B2cCf6OWZ0WpYRC39n8Ec99HIL
 3iqN+XIKvEimr/rkkI8/nE1wIUS7oS/MH/90xczMMym/EqRyYo2y2lPhIV3D0qC8PXffochu6fs
 le5ABlY8R+hJUObLDFjg3LC0BwUuNb1X6kXMMi3Chw77qwRAXRU23eKBRiN+zCa2X402dPvaW59
 8nN5A/NCYCzsoJmZq1d8FFaOwtpxPpKywGegE0KoMrKY7jQs4A69pJ1RIwjS+V9tskA7AWvGe+g
 iFbOpB+bUMEo/nzjcRcBDL5XJdo4Cw==
X-Proofpoint-GUID: U8xIDQpvrNuHzeLMPX-cfMRi-JxgLILl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511250113



On 11/24/25 11:49, Johan Hovold wrote:
> Make sure to unprepare the parent clock also on probe failures (e.g.
> probe deferral).
> 
> Fixes: a14bf98c045b ("ASoC: stm32: sai: fix possible circular locking")
> Cc: stable@vger.kernel.org	# 5.5
> Cc: Olivier Moysan <olivier.moysan@st.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: olivier moysan <olivier.moysan@foss.st.com>

Olivier

> ---
>   sound/soc/stm/stm32_sai_sub.c | 28 +++++++++++++++++++++-------
>   1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
> index 0ae1eae2a59e..7a005b4ad304 100644
> --- a/sound/soc/stm/stm32_sai_sub.c
> +++ b/sound/soc/stm/stm32_sai_sub.c
> @@ -1634,14 +1634,21 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
>   	if (of_property_present(np, "#clock-cells")) {
>   		ret = stm32_sai_add_mclk_provider(sai);
>   		if (ret < 0)
> -			return ret;
> +			goto err_unprepare_pclk;
>   	} else {
>   		sai->sai_mclk = devm_clk_get_optional(&pdev->dev, "MCLK");
> -		if (IS_ERR(sai->sai_mclk))
> -			return PTR_ERR(sai->sai_mclk);
> +		if (IS_ERR(sai->sai_mclk)) {
> +			ret = PTR_ERR(sai->sai_mclk);
> +			goto err_unprepare_pclk;
> +		}
>   	}
>   
>   	return 0;
> +
> +err_unprepare_pclk:
> +	clk_unprepare(sai->pdata->pclk);
> +
> +	return ret;
>   }
>   
>   static int stm32_sai_sub_probe(struct platform_device *pdev)
> @@ -1688,26 +1695,33 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
>   			       IRQF_SHARED, dev_name(&pdev->dev), sai);
>   	if (ret) {
>   		dev_err(&pdev->dev, "IRQ request returned %d\n", ret);
> -		return ret;
> +		goto err_unprepare_pclk;
>   	}
>   
>   	if (STM_SAI_PROTOCOL_IS_SPDIF(sai))
>   		conf = &stm32_sai_pcm_config_spdif;
>   
>   	ret = snd_dmaengine_pcm_register(&pdev->dev, conf, 0);
> -	if (ret)
> -		return dev_err_probe(&pdev->dev, ret, "Could not register pcm dma\n");
> +	if (ret) {
> +		ret = dev_err_probe(&pdev->dev, ret, "Could not register pcm dma\n");
> +		goto err_unprepare_pclk;
> +	}
>   
>   	ret = snd_soc_register_component(&pdev->dev, &stm32_component,
>   					 &sai->cpu_dai_drv, 1);
>   	if (ret) {
>   		snd_dmaengine_pcm_unregister(&pdev->dev);
> -		return ret;
> +		goto err_unprepare_pclk;
>   	}
>   
>   	pm_runtime_enable(&pdev->dev);
>   
>   	return 0;
> +
> +err_unprepare_pclk:
> +	clk_unprepare(sai->pdata->pclk);
> +
> +	return ret;
>   }
>   
>   static void stm32_sai_sub_remove(struct platform_device *pdev)

