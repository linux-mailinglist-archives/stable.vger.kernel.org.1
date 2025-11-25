Return-Path: <stable+bounces-196902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD99C85328
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 14:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6F3C0350F16
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 13:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C4521E087;
	Tue, 25 Nov 2025 13:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="VXQ4bHwB"
X-Original-To: stable@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E9A21CFE0;
	Tue, 25 Nov 2025 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764077828; cv=fail; b=fGiTQ5ZshXFviKdckaB0VyG9WEYUm1gS+3sPcroGNBx3csLtsgQzPEf2JjPATgVnMtr9qj9O+B9HSU6RktTM6NRDRe6O8Pl9eox4MLugyamgsh6wEqOJ6npmrh6BiNEwPQV6DWTVcG1TxNhIxfPmcvSiPPyEgfQoJtXPTE/1Pd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764077828; c=relaxed/simple;
	bh=HohZzTfnfSJKPQFPk4mfNFXhhIJmsmxPPS4r9sUUc+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lGg+KrhvdQTul90KXCL/HHo48NESdBMkAWl0zjzT5U3C7SgOTOKAC35APSLMFlyVvh1j3gWvkdO6/SF9kcpF6/ydi4g7L7PNJckkEpAy9SoB9wZthTth1Ji56a5BdTUnZGXKub+3oIpV5Dy24SfvdxcHmmG7OEwzwVDdeAXEB4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=VXQ4bHwB; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APDV743877944;
	Tue, 25 Nov 2025 14:36:36 +0100
Received: from du2pr03cu002.outbound.protection.outlook.com (mail-northeuropeazon11011038.outbound.protection.outlook.com [52.101.65.38])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4amuk4bn9w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 14:36:36 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWdktcuVmROkFbodoi+xbZQ7EGbwYhyKyxYfjphsZNwKrLprx91bedJ0tAECMOW9RHYaUdFpoyXsYs5TZIXGDQOkj01KFPjY1Lqec1BrbfnwVYd0Sya9ucW0Ay+ggOZPXecoLpVZBigFkDx2WMfkQ+sbANYKpaWe5wkC4iuBBmylEdqrJ1TlstSRBSgvpir28xVmYdroDAZO/pCAw5EFhDgCU7zKo96wZXNTC42KPX/fKFn1VZDRYBrgvwtEr/5QyVVw/38fqO8nRqko6uwtrsIWB6Ho8CNvbZ5tCuq+fRumq5W9YQRxQwpji00AH7L7mQ2wTDbirtrR1bFZnpH9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmXO5moYEBYShya7Ovqz4718CMDcoMHqb1FYEqhR/Eg=;
 b=y4ymTS3NX42ui5ggi/15xlFx3C80xPA8j1aHRo6NWZsGDJo7lIeekf2GXD6A47gX7RsCcXFOF62vNwe62u4iLf8eRPtXtb4M06UkPVfZTcOGFzxAhQo+Nczw2sByUfz5be3vML4CCi12XxRowtTmOz+Ggz4TpyJkoUxYpFQwisTclFLBHvnxkYo4gRmBqRnxs4dOBM9qr2Lp6I4L1QhLFh6BzX6iiPgYMucFechwKHAYxxdRzJxtbkMtpz4fDQX527s6dHrqO1YLjQNVs3jeh5rUwW/T7YRx5qIftcGuZkfZB/STEriUvByccPMKtFQXdUomaVvsxb7PvixpRS09iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmXO5moYEBYShya7Ovqz4718CMDcoMHqb1FYEqhR/Eg=;
 b=VXQ4bHwBhHsj2u64yb412F0Ex0gwGk9tv4T4gWBpmhmdCSTTAmLZqMfWDDEvXl3X73FnAdns/yTX4zqs5Pli+CsHw617N60MetFtWPGpmjpTbZa01ICB0DuajXd6DrUXROvgg+1gCSUYz3NuhJw9kA8L1dbqVG0t5RWKCwv72u4jEatvP11+XkExfjNDZWcLAgZvy180wng1Lv77bJGVU7FVUTmXhcnTSs/GXcwJoCGNPQYwY7MWM/PvawNirMWlK7MF7ssnF7zThrRgSZ8D3ASaB4GVV9SXFcrOSGdv9PiRb01JKEv9o9q7SDcefqb5fjrlqtQXmhaCqPdroHR00w==
Received: from AS4P189CA0041.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::15)
 by AM0PR10MB3185.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:187::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 13:36:33 +0000
Received: from AMS0EPF000001AE.eurprd05.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::2) by AS4P189CA0041.outlook.office365.com
 (2603:10a6:20b:5dd::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.18 via Frontend Transport; Tue,
 25 Nov 2025 13:36:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS0EPF000001AE.mail.protection.outlook.com (10.167.16.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 13:36:31 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 14:37:00 +0100
Received: from [10.252.13.178] (10.252.13.178) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 14:36:29 +0100
Message-ID: <c98f02a1-0153-496d-a484-0bac7acd030a@foss.st.com>
Date: Tue, 25 Nov 2025 14:36:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ASoC: stm32: sai: fix device leak on probe
To: Johan Hovold <johan@kernel.org>,
        Arnaud Pouliquen
	<arnaud.pouliquen@foss.st.com>,
        Mark Brown <broonie@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, olivier moysan <olivier.moysan@st.com>,
        Wen Yang
	<yellowriver2010@hotmail.com>
References: <20251124104908.15754-1-johan@kernel.org>
 <20251124104908.15754-2-johan@kernel.org>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20251124104908.15754-2-johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AE:EE_|AM0PR10MB3185:EE_
X-MS-Office365-Filtering-Correlation-Id: e08cdc8c-276f-4c17-ec6d-08de2c27a4f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|32650700017|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGxlREYyT0JuMkVNS25QOHdxNXpyd2hSeGU4RVlkMU5rUFA0bCtxa0Z2Tzk4?=
 =?utf-8?B?ZGh5M3JyVFgreDYvWHhtZXRrVWtodm1IMFNWcm10Q0x4WUhkZ2pQc0JsL0xz?=
 =?utf-8?B?ZTJINEhVV0ZxaW13a1QzNkUyeGNQbHMrZTFLdVlybXJsRU16SmNzVzZPQzdG?=
 =?utf-8?B?WktmQTlPTVhEMTlvOXRHODBvdmdMYWJqcTVlazNxT1JFaXg4WS9DNXJQbjlO?=
 =?utf-8?B?eTk1b3V2YVQrblhpOHhMdEJ3SlpLRm9HZkJ4MTZPK09UdXhMUThzVDBOZ3kx?=
 =?utf-8?B?a0JTZW5POVNZck1DRWwybGxvYVQ5a1Q1OWVtYkpMeEFVZXMrV0dhdEd5NHli?=
 =?utf-8?B?alNENFA1MTQ1MlpUbmVtWUFRSWVzRGRnQ3VhSWRFbkxWdWlJYTdoeC95dEFo?=
 =?utf-8?B?RlZVNENtVStMZkZRZnU5VGN0ejhOMDRrTjZCL1VVdkVJK0NhY1U0TVd6Q3d3?=
 =?utf-8?B?a205NHZEaFZMNVZPL1dkazVUcXp3RDU3VllmK01RcUZlT0FDMHoyR2tQY3JH?=
 =?utf-8?B?c05tUXBLM2M3T08zMzVTOURoMXZMWlNjTzgrY3MzSkdqdjFDTmVocDRtV0Q5?=
 =?utf-8?B?QVdzSDJQYS9VUVlXWEczTkd0SWlpd3dKTDJTR0dOUFAxVTJwWjA2QnFEM1ZS?=
 =?utf-8?B?dzRhYW9hYi92SEpuTTd6RUNQTXc5emc0SlBiYi9MUlhmbnpad1JQblNYeHRu?=
 =?utf-8?B?SDdsU0JCaG91Q2Z2RjUwTlhGZVh4ZEpjT3QvRFdaREM3RE1VNWhQbnJzcjgw?=
 =?utf-8?B?NTdZa1lsais4R0JWanFXeWRKeVNpVTBwc0dLcnRYY3NPblBVRmZmUXpBY1ho?=
 =?utf-8?B?cFdUMkFERFV2emVNZDVUMEthelJESFZxemFudVJuclRxOStZWWhFdzFHbEFk?=
 =?utf-8?B?TXJ6WVhBK2MxNXd0NGhDa1d3djVhUlZaRlBvTnJRM2tqZm40S3RsOVJXSGZE?=
 =?utf-8?B?WDR6TTBHRW5XNlZ6UDdnOEgzQkJYOGYvL2lZMWIrQm1DbkJSV2pEbGdibWJO?=
 =?utf-8?B?VWxQMGpaTEJKa2JGSEpOWTJ2WGpLU05ZbWRxTUJhRkdFc01VRjJzcXJWTUF0?=
 =?utf-8?B?MHNXK1BGMXZBQlUyU2hNK2o1K0Rwd2dGdEROMXRLNlpLYU03K1JUR0Y1b09r?=
 =?utf-8?B?VnB5MkxkR1J5YXU5NWtSKzRZenk4K0xpNzNLSDRFVDNNWHg0MFFWcDlQcC8v?=
 =?utf-8?B?RFgvaUNuSVBoNzI1KzdVNzFMK1hON0FqQ0RyWlk3WjBTYXZVVU5oZXB5QW9k?=
 =?utf-8?B?QmZ2SmY5KzE1emt4QVZNTmo0Snd0MlBiT09wVmZNMTBBcUttWWpFbjVFV0I1?=
 =?utf-8?B?Yi9CdmxYeVZPWm9PUnl3RU1mMlhwVTBxT2dsc1hDZDZWeFhCRUV0WUIweFJt?=
 =?utf-8?B?K2ljcjdKbGFRNjg0NFRFeEkzWmZLaldlOFZwYWhwRXFQU1VaL2s3N2FQOURt?=
 =?utf-8?B?QnBUNlhBUk5QbnMrSlpFeDE0SjA2V2xpQWJadHRqN0JvL2ZLRFJxaS9Zd2VO?=
 =?utf-8?B?L29iUWZQdlRaWUJvTHI2ODZSNCtIQVRaVThJUjAzcEVtam1tNWlBTUJ0dms2?=
 =?utf-8?B?cUgyblZhQ2d3RWtZbGpuZnVDUjdXOXRTZytiZTlnOWFCMFZDVy9HYm1XSENk?=
 =?utf-8?B?cjZmZ2NyQjlNWEIrbXFNWDdmTk1JMlZBN3lna1FsM3ZXcGk5T3dwdWtva2Vq?=
 =?utf-8?B?d1JiSmVqZXBUQm55MEdLaUszdHVtQVM0cTR0MzhpcmhHZTIwaEdMMjdzd1ZC?=
 =?utf-8?B?eFRYNzZEMjhYa2MrL1dmWkJoNHo4SkpKSDl5VGFjcWZBVFhyQmJOU01oN1Zh?=
 =?utf-8?B?TjRuYk5FZ2VpbE02bEx3L2REY1I1ZkRXL1I4UmJUWGUreEdBcW1mSWhhM3l5?=
 =?utf-8?B?blk1Y3R1YTdWb1Y4Z0ZCbXJxcC9QY2hVTWRIYUVoVmc0QUN4QjlDS0pzWFhl?=
 =?utf-8?B?eW13VXB6TlJpMlpGMGNGWmQ5em5jdWRQczVEa0FPQmtJa2FOTzVvR0xtUEl0?=
 =?utf-8?B?MWtTY0JDVjVjS2VldDhLa204eFRRVmZITXV5MzVORDZzck1jUGlORmhiQXhE?=
 =?utf-8?B?WWxkOUlQN0RyK0NHcEIzZUhFbDg0V3poWTZEd0pmSURlRzRLc1FIUTNxczVE?=
 =?utf-8?Q?zn8M=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(32650700017)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 13:36:31.4950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e08cdc8c-276f-4c17-ec6d-08de2c27a4f0
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AE.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3185
X-Authority-Analysis: v=2.4 cv=bZtmkePB c=1 sm=1 tr=0 ts=6925b0e4 cx=c_pps
 a=MSZw7vdKZaIRpydahKUoLA==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=YK2f4aGzhgIA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8 a=69EAbJreAAAA:8
 a=VmoCgi-VkC-57XdvzA4A:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: nl_Wqk2UZ5Ymuuz9-WpIX754_u0d5JSJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDExMiBTYWx0ZWRfX0n60XJXg4Vr5
 K73PLkuURQ/TK+btJZpSGs6I9osD6kosLaDq7McykBAWCtLIqjg1JqK1z3z2a4uomRLAWzrX1aL
 p3Wyq2Dq53kxDO4qjqek0XhOJOqqa0AjODGWMZ75bRXbZiIg6jfXlVgsWn19iWJ2T1EeWLZ8ujB
 noB0xObRF26WpFYO7vwC86RB+o/8zrGn8DEOWpmvqbxB/CfWtLSVVhap2vg2Ae3t4Tnz/vcVYqE
 jL7akyzBoRIg+y3dxqOL6Fl4vl2r17MPXKX3mLld1jHJ+22u7cCkIWOSkqqdy2nnBY1OEfUs0Td
 7Ar68vSGAs7/wvr28gRrz2cnpfFCfK+LZi/evxfPB2OwtObIALblBbZW2EuaBtJ25fQviGjHtKI
 BtbKEgv9LE1OilJVIEEs+ieV44pWvQ==
X-Proofpoint-ORIG-GUID: nl_Wqk2UZ5Ymuuz9-WpIX754_u0d5JSJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511250112

Hi Johan,

Thanks for your fixes.

On 11/24/25 11:49, Johan Hovold wrote:
> Make sure to drop the reference taken when looking up the sync provider
> device and its driver data during DAI probe on probe failures and on
> unbind.
> 
> Note that holding a reference to a device does not prevent its driver
> data from going away so there is no point in keeping the reference.
> 
> Fixes: 7dd0d835582f ("ASoC: stm32: sai: simplify sync modes management")
> Fixes: 1c3816a19487 ("ASoC: stm32: sai: add missing put_device()")
> Cc: stable@vger.kernel.org	# 4.16: 1c3816a19487
> Cc: olivier moysan <olivier.moysan@st.com>
> Cc: Wen Yang <yellowriver2010@hotmail.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: olivier moysan <olivier.moysan@foss.st.com>

> ---
>   sound/soc/stm/stm32_sai.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
> index fa821e3fb427..7065aeb0e524 100644
> --- a/sound/soc/stm/stm32_sai.c
> +++ b/sound/soc/stm/stm32_sai.c
> @@ -143,6 +143,7 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
>   	}
>   
>   	sai_provider = platform_get_drvdata(pdev);
> +	put_device(&pdev->dev);
>   	if (!sai_provider) {
>   		dev_err(&sai_client->pdev->dev,
>   			"SAI sync provider data not found\n");
> @@ -159,7 +160,6 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
>   	ret = stm32_sai_sync_conf_provider(sai_provider, synco);
>   
>   error:
> -	put_device(&pdev->dev);
>   	of_node_put(np_provider);
>   	return ret;
>   }

