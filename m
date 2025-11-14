Return-Path: <stable+bounces-194774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63704C5BFB7
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 09:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AD7E4ED625
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 08:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BA22FC014;
	Fri, 14 Nov 2025 08:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="a+dweL44"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4F42FBDF6;
	Fri, 14 Nov 2025 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763108927; cv=fail; b=gEgWsV7KKVADclpeFHK5KNnvnwldfWNOVDK85PArkRQmifbC8q8cl50StSjjjVmyZbO2StzrWkiAi/nADZX+reRDzaRBXw6X4qSg8Zcz27xwuGhL/c2mguDHfkRsL+ri8Z73O3M0RLNPR9mkrlTYfzUmXIOv5ChcVlPAwPWoOhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763108927; c=relaxed/simple;
	bh=r9MFb/MZcUPWAwKBDNyO+bkJ7o453MFhol0IaYQKrPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ixvjhf5wwXmE2NHyZKqi+cLwb8/Sv9t+XIUQP/b6WRbvrnnJA+mUR+nwM3Ik6jcYjBASx1ItUzQEjns8yhbKYfxW8pkroeNa+H/kXSQzDVQg3MuA5F65dFnxo3QjScH0C4RecOkEbkZIHgiU9spdnj5o1FkjYegAYH5k5Nio2oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=a+dweL44; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AE8NV8Y2095828;
	Fri, 14 Nov 2025 09:28:34 +0100
Received: from as8pr04cu009.outbound.protection.outlook.com (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4adr7khv64-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 09:28:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+hBgIRu8ZHoVmrDc0e77xAvTmbsjDa1oohJagcT3MkL5KFbLm05qAyZx5UkaCuKXg6C+KogE/A/9MLYJvj92ZkHl809k6M0dHakAIgGEYIG9bTCwC+OKEk9htHKYG0TgqrNi2p6k4p2LuyiLDzw5yE1+zkP4Et7esFVuXVH+71sFkV0kLcYWL2205pCm41FTSJqqDUxANVcm/UEvxTg/04FZ8GdwjblOws+6WE94a4z4C+X8YcR7aCV8cn44Z82UoHIioT2ygc4QqTCItK6GF1uYAeMrlKcEnw/ybN8De3hH6LfT6STwfnhf+ftNNOqPYDc8VUdtj/AYI9TQhbX2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Udvf/zLXY9vRyyZhCuWFfQBN4B0nmCaaN6/vxN0x9Qk=;
 b=QzxGR9YZW4h43z5mjNQ7kNw/m2afRl597dlt8+dopnEAgftj9ijGBqjC5kgBHsD3KvpWDqhkLpTXwmBeS0keXa04xggq7Rdr/Wo/Xn9e6zVIk+Qj9L3Kz8EoTjYkNAUu65ASPfC59X6o5gygLc2XSWimNrc2aF/f/5t/t7ASzxzb+wBHCp9ZwVFZszWiMNUZn4JYRT6lJ+3yhW2mzaJwBrvPSB1xI3MuscApdqzm+UFKCGv0/0s1b8VPYEKjTHX507FebDIcz89z+jHkn/jxZaGOEVuRZI2SDl0XsEPabfiUPDkH1lgfJZVf848owpAIz5nPLf5jygFcAkW0IPxpuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Udvf/zLXY9vRyyZhCuWFfQBN4B0nmCaaN6/vxN0x9Qk=;
 b=a+dweL44uaA0GH7tsIaxS0ze4XUtUVWFVLFa7/P31DAK0aq6Rznrj6ctl6fuF1Pd1dDdKoHrg1cFnYON6WcRTxGA/PwMMz3Y2XH/oeIXyPvF7RVrWeS8TgSwlLiiHskIKaKyHnzVt0wo++g/9GzLLcd3wJYEvc6fMRDOfZqOeUtI5JXwGUUuRKoQAyYxvtqZbCmgVP6GL06nvDJ3lpIPHblloNZrCvzENo69wHpEa1VXDvVV+TmPxzNtWQYBitGHucdZToyV6pwVCJMJIKsJHhdxAI4otdUTdzswG9qVcEL+rrV3+6eR8szeiPRJGCtP1TJEpoL7HkYxpKeHdKJ1gQ==
Received: from DB3PR06CA0004.eurprd06.prod.outlook.com (2603:10a6:8:1::17) by
 AS2PR10MB7575.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:546::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 08:28:31 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:8:1:cafe::32) by DB3PR06CA0004.outlook.office365.com
 (2603:10a6:8:1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 08:28:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 08:28:31 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 09:28:40 +0100
Received: from [10.48.86.79] (10.48.86.79) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 09:28:28 +0100
Message-ID: <499cf369-2ff7-47e9-a66b-1fce8b1bd4c3@foss.st.com>
Date: Fri, 14 Nov 2025 09:28:28 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm64: dts: st: Add memory-region-names property for
 stm32mp257f-ev1
To: Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20251031-upstream_fix_dts_omm-v4-1-e4a059a50074@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20251031-upstream_fix_dts_omm-v4-1-e4a059a50074@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FD:EE_|AS2PR10MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: dfd854c9-e0c6-40da-38d2-08de2357cb42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TSt6ZFQzQTBPZkdKbUhhdUEyaWNKckt1UWZsRFlxSmtIS3gxMUFuSTRybDNQ?=
 =?utf-8?B?WkdvZXh4SzEyeGlYZC9XMjNLRlZKZXprVzBITFdBZTc0Vjd3YVZZM0JvalVu?=
 =?utf-8?B?Y0RZQjI4WWJLUkk2TEo1YjJLTUM2LzJEK0lWdHV0SHovWStUekFxR20wcThx?=
 =?utf-8?B?WnE2dnlQZmZ5Mzgyd3VDYm4zY25WVXA5Wkp3YmttZlYvTXJuV2Vnb0EvSVdw?=
 =?utf-8?B?Z29Nb2dxeGdQY2tCVE5sYjVaUDJTczFHa21PRlJsRE9UaFNVZlRhanV6MUVJ?=
 =?utf-8?B?cmZzRGZQdHlmL2lOT0x0NWkyYUJQem95VDZEdHJjaFdCdHVORnA4d0xqS2V2?=
 =?utf-8?B?WWxBdHYvVFlYY1RVdE5GYTlGVytoWWRLQjFRcDdpQjYxYVpNYW0vdTF1UjJo?=
 =?utf-8?B?VlQzc3pIeXRlempIVFpNK1pPbDdWWmVpL0NoaU85YTdoMkpkYmRBNksyQXJz?=
 =?utf-8?B?c3V5Qm9tMDR2c0xicTVpY1ZKdFRCa2g1MldXZENmTXFFclgzSzlBK3lpeUUy?=
 =?utf-8?B?N05WWktjbVJITlMyU214bFVnNFM1RUVLa3NzYVEvSzNBWm05aTBBd2g0cVpT?=
 =?utf-8?B?MkQyM2hTZzVHdU9XT0FzeGRZeFNxaVhpOHBzaGh0cXBENnZseEh3SjM5VnN3?=
 =?utf-8?B?M0NVR0xEQTV4V1BzU3FLSFFnYkxLdTZxTnlDNTJUZ3I0NEJnYzlPR0ZXeDFx?=
 =?utf-8?B?d05EbkRhRVlKbG5Kb2dmZWszOGpJU0VRcTJBbmROaDNrV3lWZVBReUZHclA2?=
 =?utf-8?B?OC9WTlYyYjdNT21nZnc4d3pkMDBwcGt1dWYzRXprZUNsZHJuWFI3d3YwSGpt?=
 =?utf-8?B?WUg1TmxJNVpYZ1F0Y2VlMUR2dTU0RWZTWHJ0dWRIeGdOTko0RHZXak1BMTJv?=
 =?utf-8?B?UzEwa1Y4VjhQZUZmVnNsakU2QWcrUXNEcFU5Sng5TWlJeUR0NHV3bTd0dlg5?=
 =?utf-8?B?dGR5YXpKUW1kOXkyMDg2eXNVdHB1WXM1czBPTmsrRHFXczZmTk9TMkdVd25j?=
 =?utf-8?B?Q25ibXUrZ3ljVktjMEcwTmFsRXhwUUdWcDZBZDA4d3BEOGRUM3YrWXh5dkJL?=
 =?utf-8?B?NUw1clI3VnZXcXp4U3BxMm9ZN1BpSzFoZHFBamlGRHJ4MmFPWXpsWFBrbnlh?=
 =?utf-8?B?bExnL3pMaTlCKzN1SERhOVVQL3ZyL0Y4THFDeFVjSGlrSGFaSjBIWWl4STVq?=
 =?utf-8?B?aTBZRUgxNmQ4WFU5K1lnUXlDUkNDbjJPalRwU0tsUitUUCtob2tYV0NpanI4?=
 =?utf-8?B?YmxrNS9GWmVJS2k5VkI0dnVQNHcvcVdtdWZPOFhpRkZWRU54RWZqTFppUkJQ?=
 =?utf-8?B?ak5qUmxSN1JaUFZha1c4TUE4bmJKbjVPRko5dUVIWFNzWHJScXVmT1ZOMjYz?=
 =?utf-8?B?ZVZrTE1uYTlnOXd3d2Ntd2ptSG12d3F5anV1RC9rRkdTNW1ocUp1OUdoVkU1?=
 =?utf-8?B?ZUdqVzVLNmNNeHhwSTVhb21aMWl3bFM2c2lkQkc0NmF5S3pvUEtYMmhFOVpS?=
 =?utf-8?B?RUQ4WGtTd1FFRXZoZFpxZThYTGNpSGxpVHR1cUZuNkJoZWtWb3BuV2VtaDZJ?=
 =?utf-8?B?dUFTeURZT0pNQmFDK1JvQnBDaGFsTXBGd1E4dUpiaFQzV1lESlZ0ajEzb3Fn?=
 =?utf-8?B?N3RaWDFjcmpOT0ZiZHRQZW5YRUN4bXJaZUxQNE55MC9PZXBla2diNXI3OXh3?=
 =?utf-8?B?UStMSDVqWSsrZnc3bmt6bGltUGpjNnl0UWVHZlhaMkN2cVVUdTdnUkpGTHZq?=
 =?utf-8?B?cDVPOGt3ckhKUDY1S3pSN2tvbFAyci9TY3pNV0tKVmlaZFFteHRPK1poNEdz?=
 =?utf-8?B?eHM5WXVvM1FTZnIwaGxPUHNKeUhmWlNWc3V6LzZ3eXk0ZzIxWDZtellPQk9v?=
 =?utf-8?B?VXluYVRxckhBSTZEVlR3ajRaNjB3bzlDTnlTcEZET0thWjBINlRRc3IwN2JD?=
 =?utf-8?B?ODByRnlxdzRld1p1OVpEc2U0YWJ5Tko5ZjR0THFNV0tISWRIcWtiemZxRmdx?=
 =?utf-8?B?eHoyWHQ5KzNlRXMyc05XUnN1YTdSU0RxQTFTS1dQbGJEcDl0YmtGMm5jYnk4?=
 =?utf-8?B?ZEh2dFFZMC84OUhXcElqejFmRzllQnRjOXVSbjg1TldTQ2pQOWZvdENvRkNj?=
 =?utf-8?Q?pjMgCZTq+srZI6ge3Tx80Nu82?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 08:28:31.1270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd854c9-e0c6-40da-38d2-08de2357cb42
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7575
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA2NiBTYWx0ZWRfXwRvCWy89sKDa
 xzFQfZDyUQZcXEFysKI8H1947Mm6LHo/Ygt8VsmQYnq87CzkMkNUERniY8+7TXQKi1LpNZNXEb0
 eqsJGQxMZQqrZW+tcrj4b+xZMC59UE/MbJDNjIRikEzabwABY6or4hhTEiBdl/QV4Sj0o2ae0GZ
 /3abFIYEReO90qIro0cm+EtdakOaQnGsxzuaiEuUTHsrUZ+UiMCvcr7a7Z/5WL8iRl8NuLVHQJ1
 cN3j5WAQIZ3aQ5A2zRqktqqZ/b8TOZvucrnuG238bHHutfjmEqFeBajgOdmIQERRCxiGmnSSKl8
 GOGHjoRx+2SKoOZk8fKqBLts/d/t0pyqEm9sC+3Qb3yC1aYu/Ns37TJg4Fp3hHjh7WhE2MibBbn
 f0PM7TM7+M7AXpJG1I9ItE5jZLzOfw==
X-Authority-Analysis: v=2.4 cv=Xsf3+FF9 c=1 sm=1 tr=0 ts=6916e832 cx=c_pps
 a=z9iZX4VeUw2B6cD4x6/zxQ==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=TP8aPCUxYTYA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8
 a=0KiWEAhyJGVofYOcvXsA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 9HA7dg5Vpn9YGXX1vblEuuyfaUEjXeM7
X-Proofpoint-GUID: 9HA7dg5Vpn9YGXX1vblEuuyfaUEjXeM7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140066

Hi Patrice

On 10/31/25 15:07, Patrice Chotard wrote:
> In order to set the AMCR register, which configures the
> memory-region split between ospi1 and ospi2, we need to
> identify the ospi instance.
> 
> By using memory-region-names, it allows to identify the
> ospi instance this memory-region belongs to.
> 
> Fixes: cad2492de91c ("arm64: dts: st: Add SPI NOR flash support on stm32mp257f-ev1 board")
> Cc: stable@vger.kernel.org
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> Changes in v4:
> - Rebase on v6.18-rc1
> - Link to v3: https://lore.kernel.org/r/20250811-upstream_fix_dts_omm-v3-1-c4186b7667cb@foss.st.com
> 
> Changes in v3:
> - Set again "Cc: <stable@vger.kernel.org>"
> - Link to v2: https://lore.kernel.org/r/20250811-upstream_fix_dts_omm-v2-1-00ff55076bd5@foss.st.com
> 
> Changes in v2:
> - Update commit message.
> - Use correct memory-region-names value.
> - Remove "Cc: <stable@vger.kernel.org>" tag as the fixed patch is not part of a LTS.
> - Link to v1: https://lore.kernel.org/r/20250806-upstream_fix_dts_omm-v1-1-e68c15ed422d@foss.st.com
> ---
>   arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
> index 6e165073f732..bb6d6393d2e4 100644
> --- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
> +++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
> @@ -266,6 +266,7 @@ &i2c8 {
>   
>   &ommanager {
>   	memory-region = <&mm_ospi1>;
> +	memory-region-names = "ospi1";
>   	pinctrl-0 = <&ospi_port1_clk_pins_a
>   		     &ospi_port1_io03_pins_a
>   		     &ospi_port1_cs0_pins_a>;
> 
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20250806-upstream_fix_dts_omm-c006b69042f1
> 
> Best regards,

Applied on stm32-next.

Regards
Alex

