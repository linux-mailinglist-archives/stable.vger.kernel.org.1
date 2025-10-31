Return-Path: <stable+bounces-191932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C0CC2576F
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 15:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0ABE188D10E
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 14:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB2A34BA5C;
	Fri, 31 Oct 2025 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Jwt3yo0T"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57A424BBEC;
	Fri, 31 Oct 2025 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919656; cv=fail; b=egX1UocV7qY73VuDdGK2YITZCgXrH6JwQ9rMfgjpXpEM3yMKwD5Y398iQHjOfGDILMeYV3RDMgicp34t1d+eOz3idauPt+4Bad1zDyp5+Zaqyz4iqgJxBhIEDJFNBdOi3varUHiQQhaUunFY1owX03FhA8lw/ghQx5esUyKmafA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919656; c=relaxed/simple;
	bh=QtWST023JpA1PuA2iO8rqZ6Z2DmhfdRlDNq/sOG3JJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=nNUK8Xum/LncKPjOiRYRyDk2p3+UZ7E+CBZETKcKfOoGeauYL6vnEIK8IiwtnRQdPWweefBRZ20FpAgSCHw4S4EWidOdSacMQWTKK8cNxntdecgDDok6e4jX2dc0QJyxkV5YrgiAY9D0GhkaDGwK9d7SuCiUeUmUdTroma8xsDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Jwt3yo0T; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VDSSlm179537;
	Fri, 31 Oct 2025 15:07:14 +0100
Received: from pa4pr04cu001.outbound.protection.outlook.com (mail-francecentralazon11013011.outbound.protection.outlook.com [40.107.162.11])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4a4s369nr3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 15:07:14 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZYqgJzWb0OGc24NY+7ULfU1rncwc9YfSDzsPw2391CdKAP5Yh6SgNlVIpD2R3A/2NTR66zu0rZAxr07O/ICIKO9TTuLfzXi4KTx0U/FU3Q4r5SbHiXSr7M8N/h1lqH8FDHGrgM62s5BtGYu0Om2SGyvth/AD9qo+KfDRFwHoseQ5ZXVKcMr5wR4OtUS4a5NKJiHml90MlI79AdCl88lVtkZUzWrDrUudt5ikRw2WQNbMKrlbQUkODFaxWxTEdSJUdFTFfX+z6ofngXfkIFbdiJuT2ddd8ObrMX92AlMLzmxSBv/6ezNwYfY3BRyNLQ0FXYcB9Yb+4in3va9OqVK5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlwAGT7NbLV13GOn7P+DNmpN1PL4GS3fRAbRDB5pQCU=;
 b=q42Fla8zZxWI0uu1BbcmfUZMAkJ0ChJn6GOB5Qtta28CMktwQXh9JWPlgna6zChyK6LHRJv31IlfbtNll06ZS1GXazxKVrM/a0nFucLSo9jSfD77GG4WEk7jH0NNlJ0hTeInCMSlFV9I1K2/MAJb7oTStjqUNjggxseUTpHH6eQ2hRyyBAG7zEUMtYXWyRBFyJ8X/nFKR69XdOoLWUr3k9vxSC/c6pUiEWjfpjsIeNZlH+Af7K0/bwSTuHNvZrPJpb/VtDX/LYkftAWTED1rDiKcUYLuFFzEa2VEHcGFQ7NAwgLjN3dhhJPBB4WNnWiYU25ltj6UtHZE86FNvc1vEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlwAGT7NbLV13GOn7P+DNmpN1PL4GS3fRAbRDB5pQCU=;
 b=Jwt3yo0TlhjVbypO9x8WHfpCuwgbz2nG2RuQP2XB/2V7ktDGs1yBc4EJNPIbKq82kTQbcLbxtHIiNLZ4bh7kZdUsmGBRjvrVNPEY/ZzM6cPdC+0sB6+348jFSD5yKMg4Y+D7u3wDOGfd66qrT/TbqJYU4P6evIzOPnST5PbmAhtYeW38wf7f9PcI7tioe1oNW82eafLgsRFJKTXnsDujFWtVWUzfWJa3WRCWJS4A0SRN51JgUWaBiXO7BP3kWdbygVzXQpI+bU+0cgS3NbMH+UDk4jr2n/5m/EEOOE6k9CJ/QhSPtnDznNiiYIwMYi5kSdgjVvCGaUAKufOayc+MxA==
Received: from DU7P251CA0020.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::22)
 by AS8PR10MB7500.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 14:07:12 +0000
Received: from DB3PEPF0000885C.eurprd02.prod.outlook.com
 (2603:10a6:10:551:cafe::29) by DU7P251CA0020.outlook.office365.com
 (2603:10a6:10:551::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 14:07:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 DB3PEPF0000885C.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 14:07:11 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 31 Oct
 2025 14:59:46 +0100
Received: from localhost (10.252.30.100) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 31 Oct
 2025 15:07:10 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 31 Oct 2025 15:07:03 +0100
Subject: [PATCH v4] arm64: dts: st: Add memory-region-names property for
 stm32mp257f-ev1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251031-upstream_fix_dts_omm-v4-1-e4a059a50074@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAIbCBGkC/43NSw6CMBCA4auYri2ZFlrQlfcwhkAf0gWUdCrRE
 O5uYaUxRpf/TOabmaAJziA57mYSzOTQ+SFFsd8R1TXD1VCnUxMOXEAFkt5GjME0fW3dvdYRa9/
 3VAHIVh6g4JaRdDoGk9Ybe76k7hxGHx7bl4mt0x/gxCijRlaKCaMLzvXJesQMY6Z8T1Zy4i8MY
 18YnhgAa4WAUrZafDL5P0yeGFWwSrallKVq35llWZ5bAsIgSAEAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885C:EE_|AS8PR10MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c06323-ae1e-4172-a291-08de1886c995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dm5QSkZNRjFxRjZLZnUwMm1SWGkzNXNPYkVTamJIVm11aTk1cFFROEZHK1A0?=
 =?utf-8?B?RG5ydEJHTmFESkpWaDZnUjArR3hxbDV4VGNrL0tiS2FCYVFzdzV2Q2w1U0Ir?=
 =?utf-8?B?QzJ2WU9mU05nWTdLVVhSZ1FQQnoya1VUUjJPMHVQakprMnc5ZkhjNStPdFVL?=
 =?utf-8?B?cm5VL1V1VjdRblZ1MkZwNWlreW5YR004VXdSWHM4NGRCNXNNZmZMRy9ROWdR?=
 =?utf-8?B?a2tPMllpcVB0MTY5ZUMzVzBWa0RWbm5Xd09LaTF0OCtmMDhPb0hpaGp0NXg3?=
 =?utf-8?B?ZEcxNW05N0toaExiblpDMExmQkFabWhKK0JKcTdUTTVPbXZiTDJqOUNlTEti?=
 =?utf-8?B?aFJpaHY3eHRhQm5RWWJ4ZUxrWnlMNHhGY01CYXZ1RHQxUWlrRGd2cHh5WGJl?=
 =?utf-8?B?VzFaalRNNGdrendCZTNsMzFENWlPeEZ2bHpVdWtkUkNHS0pzLzJKWmx3REFR?=
 =?utf-8?B?MnI1bnc3c2VqZUtCd0VkRVQ5a0szcmNPMmN2d0tKV3J0MGNXdlh3LzNGUm9x?=
 =?utf-8?B?eTExRC9telZzUTdndFZhQjZXc201RW1iL0o5RlZyOW82d3VjamRwSkdXOWdI?=
 =?utf-8?B?SDJzcHRDdEc4c0NIdmF2dis1bnl0UDJ2aVNjTEJmeC9WdjNCNS9UQlFPNzZz?=
 =?utf-8?B?bGJrU2wyZUkwZ3F6WFNMU2pVT3hHQXF2ckNkbFpZMjBuMHpDYUxVWmlQbjlt?=
 =?utf-8?B?ZjhLclFNdDkvWHVMM1dLdy9QTVcrZ08zUkRlN1ZaKytYalRLYVBVZDVKZFlv?=
 =?utf-8?B?bUtXTm9sNjkxL0pGYXpCUGRDOURLb1U3QkcxNXlvWVFQYTdzcEFsWGdzeVdt?=
 =?utf-8?B?UE12OHBFZGJkdmxnblI1bnlocDFtSEwwTWlvODBIdjBUMVVabzJ2ZVN0T3pM?=
 =?utf-8?B?VHM1ZmhQS2JPeGJaWUVwamRLakVKUjR2dHFxWlh2dmNRTFlzcFpSNGRoQXlJ?=
 =?utf-8?B?bWUyQTB2bldJRlV2U0N5QXlhK3ZvTzRHSjYzeDVGd3ZMMDVOZHFBNjNZekNT?=
 =?utf-8?B?eHpydlJsSEFlcjM5S0xYUUNSZSsvTDRqM25yNW94emdzV081VWVhelRSRUhH?=
 =?utf-8?B?bGZpRkQ1c2NCaFVZSUdSZlFqeldFUm9abmlqYnhYUVNPVmRqbzdkMml0SVQ1?=
 =?utf-8?B?d1lKclZ4RU5BMmptUGxsWTN0Njgrd2lDMDUvT2xyazF4MmE5b01yZ0p5VXpB?=
 =?utf-8?B?eVFHUUJKRkNlaW9aMWpTMFY2RGFFNHNrOVo0Ly8vKzUzUmFpeEhvdENXV3h0?=
 =?utf-8?B?OTJZQkxlVTVIR1BjWHd2bng4Y1FsUkVZRWRMUnFMMGFQektnSTBxOFh1V1hD?=
 =?utf-8?B?aW82UmdQSXUweGpFQUhPKzlPRlVDZzhMTWxBQit5alNac1I5Uy9XdzBaK2dZ?=
 =?utf-8?B?MnAvQ3VRb3lScUMycjdmajU2Qzl5UEhCWFl5bmRCZStLUjhlTXZnRFlybEps?=
 =?utf-8?B?dnZjOEpkS1cyZXFFS0NaaUx3MmJjNHNSc1FiaEZKVXB5OXliUDdreUh6MlVL?=
 =?utf-8?B?dTVwa3pxdlRCWWZodENlWTRvanBIT25mT04wUHpFZm5uaGxEWHNwQWJCQVk5?=
 =?utf-8?B?RjRqYnNkanRSS3dtKytkazNtRHJHM1BlRDc4Y3R6R29FcW9JNDMzSWluSnFF?=
 =?utf-8?B?anJaZGpQVVU0K2ZsN1RqV1RDTEs5SzZKTktrWnN4VVhhNVFhWkIvak05dUgw?=
 =?utf-8?B?YzVhMjBiM2RQTlhXWEhqR2lzSldxcExRUjRQQysrMzYwY0t5bEdpSnIyams4?=
 =?utf-8?B?dUVnemM4ektnOFdLVW1Ja3BXRUZqZC9idTNaV2xNUFlRYlI1Z3hxUUZ6VlNa?=
 =?utf-8?B?aGlFU2puV0NBeXk4VHhXdVFYK3ZVZkxIZjQ2WkJKZDluZmVIMnJkM1lnVFJa?=
 =?utf-8?B?VWZ1QS9ySzMwQndkVVF0OGM0VS9wSVNUcjhKYmdTNXE3VVJ4T1Fjc1RHWlNC?=
 =?utf-8?B?TDdPVUFqL2tlTmU5S3MzY3N6bGtrRmwvMUdmeS9kelpUOG1KMFd4UWRaUWZh?=
 =?utf-8?B?WXB1V3lHT0c5N2UxeGs3RTd6MUxRNDBJTDBpVXAxb3ZkN1hVUmlkMDlwcHBl?=
 =?utf-8?B?WW5uUmVSdXlzZDFESWZsVTlwME5Hay93b0lpcE1lYUpVTTY4RnRQdXlmdm1z?=
 =?utf-8?Q?CCVlpMFt+3ddRrIXMZrwcm4Lu?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.44;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 14:07:11.8717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c06323-ae1e-4172-a291-08de1886c995
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.44];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7500
X-Authority-Analysis: v=2.4 cv=P6E3RyAu c=1 sm=1 tr=0 ts=6904c292 cx=c_pps
 a=sVc/mxcIhDaUo2azsgtTig==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=ZDeCC95CVvMA:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8
 a=N1czKCc1mgkcdJKb_p0A:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEyNyBTYWx0ZWRfX8W1XQIkBbqva
 dSRv64jgP/58v1LpfJQ60Iy0LzvH9t0KyXCziW5c7dcF0f5ZHT+gpxdz9mTcNSEfzDr9KbRSsK1
 elD7NzUODrrvNIhC2gKgrbR3dWhOK1BIdYehziTEws95ta43SPZLKVOGSXTNMeETH3c2YsO0u8F
 6x1tuDgw6b9wLczzmjzgQFJxhv4mvFHsxqFKenZdr3Gq7pBj3FDZFfHM5iB24NqzS/Kue7b7MFh
 hWotarw7tra+uqMtFZfedqt6KxI2XCT4qZIJsX/YaPneZY4LDRQxl+NhnE6fEwlk/yJo7pWqbc0
 GZQthI4ateC4oBbsBkNHk+x1jMXScAdaKyAgcgXsVoCFj4K0pN5TAhxlvcajhJaIByonDca0F53
 OwU25N+7vLf3x7Rb/WyqAhUDG7vF0A==
X-Proofpoint-GUID: OJWwzMvgIl16UPw0Ci9zfMX2eKvgE-YM
X-Proofpoint-ORIG-GUID: OJWwzMvgIl16UPw0Ci9zfMX2eKvgE-YM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310127

In order to set the AMCR register, which configures the
memory-region split between ospi1 and ospi2, we need to
identify the ospi instance.

By using memory-region-names, it allows to identify the
ospi instance this memory-region belongs to.

Fixes: cad2492de91c ("arm64: dts: st: Add SPI NOR flash support on stm32mp257f-ev1 board")
Cc: stable@vger.kernel.org
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Changes in v4:
- Rebase on v6.18-rc1
- Link to v3: https://lore.kernel.org/r/20250811-upstream_fix_dts_omm-v3-1-c4186b7667cb@foss.st.com

Changes in v3:
- Set again "Cc: <stable@vger.kernel.org>"
- Link to v2: https://lore.kernel.org/r/20250811-upstream_fix_dts_omm-v2-1-00ff55076bd5@foss.st.com

Changes in v2:
- Update commit message.
- Use correct memory-region-names value.
- Remove "Cc: <stable@vger.kernel.org>" tag as the fixed patch is not part of a LTS.
- Link to v1: https://lore.kernel.org/r/20250806-upstream_fix_dts_omm-v1-1-e68c15ed422d@foss.st.com
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 6e165073f732..bb6d6393d2e4 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -266,6 +266,7 @@ &i2c8 {
 
 &ommanager {
 	memory-region = <&mm_ospi1>;
+	memory-region-names = "ospi1";
 	pinctrl-0 = <&ospi_port1_clk_pins_a
 		     &ospi_port1_io03_pins_a
 		     &ospi_port1_cs0_pins_a>;

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20250806-upstream_fix_dts_omm-c006b69042f1

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>


