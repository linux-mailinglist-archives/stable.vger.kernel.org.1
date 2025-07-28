Return-Path: <stable+bounces-164907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D702B139E3
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 13:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE731891939
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 11:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA3625C810;
	Mon, 28 Jul 2025 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nikZ2693";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nikZ2693"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013017.outbound.protection.outlook.com [52.101.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0C7212B3D;
	Mon, 28 Jul 2025 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.17
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753702316; cv=fail; b=pXTbP8xxjJ5M4iCETYxvYXeeZQI1Zmu9Hi5bkrlSZA+gsCHVUY6klAyPYa/4RKI2UFDtMoEcTQ6PKkSgZNbOme8kw+gvw2IYvhDmSoGnoZSFTIcQktqK5ghF/A4c3/bLb503D4ghoc//xOh0hlbWsAaMdSetQYMsIkv0UP9CnBQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753702316; c=relaxed/simple;
	bh=71bkFQqo9Y2VkY9LH7DuwqI2aFfThT/DZ77ccufApZs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MVNKndJmlbqsaBahk0mPJ37Z+y6t56doaBVd1NkXUzL/qzEk7DWxJOzy1XmMIrbd8ckB4Q0yNna4bODygy+T/ha0/kuUJHTXR8cFikuHcwVW+5DZXPi54X2v7U6NhRQMnONVEG04Rtp2SkuGoSKKDIouJ1dg6/xrUH3om5pbE90=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nikZ2693; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nikZ2693; arc=fail smtp.client-ip=52.101.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=mR1SA4o7z5TOT//SIfPdrLEwr5hVezS022ZkjlCBarxdQMN/t4J5fknR2YxFpmW9NWuRp80+cFrRNWzhIiTh25z8pxMVnaTVET9LPgO3gpxWVVPvXY15jH/zRwrkVlBXhAyYZNY54FywZ9xFVppKYpa5lfnUsKoxW9ydWfOUpEKe1e8WN8uATimWvpbSrgug76lgDolRheOoUu+wi0YL2XZLrYuQsAPA+ParRIZlTlSB0kOTXRKWlqcwvloL92lSe14Zfu1hl4fO3moBzSqxB7Zz9qagYMgB2ywn97e5XglfgZcSr2wroDGq2HhyAWprNKeTM0lAEqC26I0uu3JQzw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsvWd9uexREyuf/y85YWNaj94o+741YPqagdcdWz2DY=;
 b=EsDT3M5l5bNQYrhYxzV9f44I4depupm78HISXpToWG+Jh1pJ8JQgswq7/rFfMmhY172PIPueWPvDr7J/SOEdwm2vLw0CgWI5FsRks8wqvNrrfXx/lKDdMC8SC8B4Jt4y+ih6X0GcP8B8jYmrUmG3UuTnJH0bk8xQTJKwQtdjNerIEXQzunEuVYaQwb8BPW04LBWCi2DkDGS9uGp046xVVXPlKXpnQi7ByQSOoXt9jTYfmKejRVOWlmCvqYUlpYPrp8aAmayorr9hsTTlfhKr6Uisq8TWK6KG+CwgPjLTNz7I5rbkIAsyHBrmBA3UaEatBMRL++VsTVNSMzTw5hoH6g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsvWd9uexREyuf/y85YWNaj94o+741YPqagdcdWz2DY=;
 b=nikZ2693Bz0df9sIwpx+na6GtKJvJWoXO3hHXytjeJUMC0IPgsyK35nFqzwVTiRhJh9H1Ky0deJVWXwFGsjR/QVctaeNM/XGV9794I6LL/HsFPeSdwvyO7wuQvrLak1JqEKFLc/k5ewoP9QsyaytUTcgKs9bGx/Gf935U71RoUo=
Received: from AM8P251CA0023.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::28)
 by AS8PR08MB10001.eurprd08.prod.outlook.com (2603:10a6:20b:632::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Mon, 28 Jul
 2025 11:31:51 +0000
Received: from AMS0EPF000001AC.eurprd05.prod.outlook.com
 (2603:10a6:20b:21b:cafe::b0) by AM8P251CA0023.outlook.office365.com
 (2603:10a6:20b:21b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.26 via Frontend Transport; Mon,
 28 Jul 2025 11:31:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001AC.mail.protection.outlook.com (10.167.16.152) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.10
 via Frontend Transport; Mon, 28 Jul 2025 11:31:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9Qr4cbz/dwV0kQBBN3mnxurdUPqVGvjxx9t2RpNDsipFJIBU8iRI30cbodEPvUgktthbGHjwMbbcjqchLr+Q1lEeJWHt9U5SYWBELejOaJZ79ZjFjbXLdt0pBJH1rN1WH+yK+OBS0Vyj8Pim/nkyBgnrOl9CihcAfx9qUFkiggyUJQ+X2WXWEQaX5Wi5j0hTR8QKgdLVd6uHm6LtTi0q0SvyFvJd0+pYbH6miPUi8MZzMOCpQ/IQ9RXhee3V8bJdJZD7nwjgOI721wrBdIV+S348Sjqkat9tHVJu8Sz26hfXwj6y1jXQ/DXM4HKvhuhhqxWFffWd+WgDqKrOzWsOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsvWd9uexREyuf/y85YWNaj94o+741YPqagdcdWz2DY=;
 b=PQPnqbCTC7EdAjt2BYoRz/9rQpaQAv/L510FLtN4grWIE8xrXhovjDztXDoK4WkSBDH04S5EQ2tY79K7d1W7+a9QEnJYApEu0y21MPVQRXkx8qf47u6Y50d+SrWeJjPU6f9sw8vj+8v+UGTZ8d5sVfX8ZCWId10JAvb5OYUUBqCqHP5I8TRxT1Ji1dvmA1IgiaiRj09uLgUMx+uF+o2Zv/RzBF805ZsdnfUJyZ/kddyzyL3FcefyBEn58OXZPsLcaTdGK+YJHcML/35YH88Ur3i2a/nmL3gB4efgRYLfY8jQIR6Q9F59Y1R+tPGDmUmpwkTNj1vgali2DgdDcCHgqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsvWd9uexREyuf/y85YWNaj94o+741YPqagdcdWz2DY=;
 b=nikZ2693Bz0df9sIwpx+na6GtKJvJWoXO3hHXytjeJUMC0IPgsyK35nFqzwVTiRhJh9H1Ky0deJVWXwFGsjR/QVctaeNM/XGV9794I6LL/HsFPeSdwvyO7wuQvrLak1JqEKFLc/k5ewoP9QsyaytUTcgKs9bGx/Gf935U71RoUo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DU0PR08MB7922.eurprd08.prod.outlook.com (2603:10a6:10:3c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 11:31:15 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 11:31:15 +0000
Message-ID: <ebbd54a7-1d84-4a47-8a66-394bdcb53d65@arm.com>
Date: Mon, 28 Jul 2025 17:01:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Fix use-after-free due to race between memory
 hotunplug and ptdump
To: Ryan Roberts <ryan.roberts@arm.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: anshuman.khandual@arm.com, quic_zhenhuah@quicinc.com,
 kevin.brodsky@arm.com, yangyicong@hisilicon.com, joey.gouly@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mark.rutland@arm.com, maz@kernel.org, stable@vger.kernel.org
References: <20250728103137.94726-1-dev.jain@arm.com>
 <f0e12d1e-110d-4a56-9f77-8fe2d664b0d1@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <f0e12d1e-110d-4a56-9f77-8fe2d664b0d1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::15) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DU0PR08MB7922:EE_|AMS0EPF000001AC:EE_|AS8PR08MB10001:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4d841e-aa8c-4860-10d4-08ddcdca5871
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?U3QzRUN2ZEdwczdVcGpzYjRRcUdDbVFFRSt2cUxhUzBZaUNJd0VzUU95VFZP?=
 =?utf-8?B?MXVyMHpqOGlZcVVjM1JoOWNrWHlESHlMVlVTajZMMnhYZmJCMVc2OUtSTHFh?=
 =?utf-8?B?SzBNaXB0b0d6NU5MVG9RbWk2MGdDWWZGOWhjR0EyVE9VUVlJZXJpRnFYNnJ1?=
 =?utf-8?B?d1BHR3FLVU9rdDBxTElFeEV0UDg3bmNEaExsbzZuYUprREVDNkFXeW0rRE5L?=
 =?utf-8?B?ajFJOWFycXpmM2xGQ0hxZy84Rm9VbnhMaURJd0s3NVlCU2dxdzN0eG14a0pH?=
 =?utf-8?B?eG5hLzhoK0pBWUFPcUxDaEtCcXhHWjgycTF5eDV3Vzd4b3ZzRFVGNUFTS3Iv?=
 =?utf-8?B?dUxrSWpoM1JMM0p1d01mQWt4eUVzTUd3Si9yMld4VURGS1dUSE5vaUM2My9l?=
 =?utf-8?B?bndsM0NZSW1XdFBLZGdXTlkrRUE1eWgzV3Rma25MZ1E4Z1dNbGhkVk8zSG5N?=
 =?utf-8?B?QWdYRzBOQTRSNXJlT2k4L2Y4cDdTMys2NnVEWU9IVFVPTmQ0S3gzZHNEWUV6?=
 =?utf-8?B?K3NiY0loazZDRWFJTEZqUUNBUkVQenR6MTZqb0ZIQStVYVphNnN6K2hyNUxq?=
 =?utf-8?B?cnhzdERFOUt3M0ptYWU0eHF5ei9YUVBacWRmNUZqNGxiU2NrQTB2YzdMMmh3?=
 =?utf-8?B?OUIrdHpyc0R1Vk9USThDVVBvOURReksvdU5xTzJhV21GK1JKRG9wWFlXU0RI?=
 =?utf-8?B?V1MxTW1IdEpFZkZOUXVvUUtLeGkxd1dROFBFSWhuOVh0SDVpWnViaDRyVG9V?=
 =?utf-8?B?SVdBQXBoWkx6V2hEM0R0bUhSc0JTMEZVL25qUFVCcy92S2xwZVhhRzV1TGF2?=
 =?utf-8?B?VHdES2dvU1RJOUpBSDNHWkUxRi9yeEpqTXd4bVFaWUZFWFh5dktIcUsyTGVZ?=
 =?utf-8?B?Y1ZlRjQrd0lzLy9yT091bDg3MHQramJOREpFaERvUjN5NFJXMWFEYjRjNjhX?=
 =?utf-8?B?K1AyL3B3MG5RNitsTHd6U25DamhiaHV0NGlHWG9PZXg5d3ZnRTJtUElzeWdu?=
 =?utf-8?B?NWxVQnZocEFsb096Tjl6Y0R6dDBuclkxRkNpQzd1c1F3NzVnbmdEaDMyMTNC?=
 =?utf-8?B?WWE5Vm1mRzJqU1RBb24va2daMlNiRkE5SUJxbmxRRnhrVk05NGlHamdsMWNa?=
 =?utf-8?B?SFlkTi92bmhVVS9MUUFvcnVSSC9aSVA1N24wbytXOFFjcmFKQllBYzZTUHpU?=
 =?utf-8?B?N1dCR1pHNVcyZlQ0TnJkZlNlWlFhb1pVekVoVitUT0lTNzJGOHd6amxNaXVm?=
 =?utf-8?B?RVFBaEdYOGRjbjVKVElDMHlGR3MvMmVpcDhtTm56OHZoeldmdTN6YUdTaUhX?=
 =?utf-8?B?b2c1dDN4bitjSzJMNXVtNlhEQnBCaXpFOGZWNnE2MnZKY3dxVlhveEtQL3o0?=
 =?utf-8?B?ZkF6RXIweElDdEs3MUcxYitYR2FDcXNQc3FtZjBXWTlpdWEvd1pISFRncHp2?=
 =?utf-8?B?NHhNcGxuazBuRnVYZ2EzWVRaNnZiYWsyUnZacGFHSnJPWTR4bWZUbmxacFJn?=
 =?utf-8?B?VVNxa0tLb3Y5T2ZqODIrb2JmeEs0Nk1aTThvSmthWVRZcFVIbCsrLzJTUjZX?=
 =?utf-8?B?ellFbEZicytibVlvcnBVNlZCUTNXekthTi9Wc0t5MTRCWWhpTVJXM0xkMzJz?=
 =?utf-8?B?ekhRcEhtWGZ1SW1kK1NBd1ZycUZ5UFZHdTFTUlpsQW1GWHRhVHMwZlJqaElL?=
 =?utf-8?B?S0xDSm5VZ1FqWURDQ092N0FKWjloeFFVVjNtd3FpRUV2d0NCNVNqSGNlSUoy?=
 =?utf-8?B?ajZLdHEwbmwxM2QvcWFGYkVoOUZiREh5eFYxV0Rkb21BdW9YZ3NnYTRmeENL?=
 =?utf-8?B?U0hMVWhzZ1ZUUHFhV2IwMkZ2c0dkR3FPZ0dNSDFyZDVWQWNiZ1lqZXZDYXo0?=
 =?utf-8?B?K2dSbHRNbW5ZUnZQZXp0QWMzeWs4NUdEOFlXTGhTSExiUUE9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7922
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001AC.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5ad3f990-3884-4b44-571d-08ddcdca4369
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|35042699022|1800799024|376014|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnFtTWNCVmNMTWF5ZkkzZUUyLzZvUHplTStYSjFvVElFSGxhYkRkd0FpVW9N?=
 =?utf-8?B?U3FLb1hadFRXa2RFcU54QUloQit5OWFZdTBkc0laUFdyWTVjdHZxcVZ3a0ZM?=
 =?utf-8?B?S0dGUGIxUjl1VzF0dHgxcTJEYmVWZlVlbTVyQndTREFEbUdQN2xVaGx2djdl?=
 =?utf-8?B?MVJidEtPNVU3K3FhUVNKaFRQMDdwRTQ4RHRFL1lBM3NSS3B2dmwxTUIvM09y?=
 =?utf-8?B?UHorMzhYK3FpTmNiRTFlN2UyL1lORXFobEtYQURvRGhwa3ZLSmcwKzlmNEty?=
 =?utf-8?B?TXFQcFJqUkRyTWhTY3dWdktQdllQK25IMEcwRXhxMzhtM0R3RzVGdTZCS3Mr?=
 =?utf-8?B?M20wZWc0VDVFNlBiMFZwVzdYYjhFbHVQVUdFV2I2dk16cUJaZDRBRzZXUXBJ?=
 =?utf-8?B?UFMxUnFiSGVpUE0waXR6NnJKSU8zU1VibzRFUHd4RTE5a1FTa3FsRjhHYWw3?=
 =?utf-8?B?Y0llRkhCNFNkMnowZkZCeUw2NTQwV0NWRXJ4Z3VRcStsNUxSR2IrNmNUMzE4?=
 =?utf-8?B?a3VBWEpjTFFORFRTSHQ4NEhua0NKVnRsQ3RnQUZrdFBuZmFxQ3p1SGc1TU8y?=
 =?utf-8?B?b3lVQXJ1WGQzN0Nwb1lPSmYvTy8rS1RkMWpwSllXYmlsQXhPZk43bVE3UTlq?=
 =?utf-8?B?bEpsOU1wRVdGTDg1OG5rS0h3aUN4OHBmd3hPbTcraUUyRHBHeGZnOGlVcVFE?=
 =?utf-8?B?NVo1cC9nNFRQd2c2U2JXVGIzdzFVOGNNQkxsb3BQYlRBUzV0bHVLSU10ckUv?=
 =?utf-8?B?NVhNUmNlSEQ2L1hkNGExcjdOTUdOeW1SOGdRSlNCeUtxK015aEV0eEZtOFpD?=
 =?utf-8?B?Q1F4SnpodWlGUTZ5bzRwV2w4TjRpUHkyREpURGJvb2Y0MVYzWUtIb3VJY09O?=
 =?utf-8?B?eU93d3MzTEl3MXJ2QnViNHZiYWV1cEpKQlNzWFNPcG9TdnRZbktHMkpTVHdO?=
 =?utf-8?B?SGtQWTRDL0N0elBIb1lGOHZITjNqY2dtdmxFUlNyaG5HWi9mT2wvakEwL1F3?=
 =?utf-8?B?UEk1SnpiUzNWVjVHOVhEUlljbkdhMWtIck1mMk9wT1N3eHYrcGpKT3ZJN3Fa?=
 =?utf-8?B?UXNhYWNacUQvTVBSSFgvLzJ2aWowRit3MndNRWVjR3gveXNYSzBQVFBuV0tF?=
 =?utf-8?B?T3pFZlpTMnp4S1d5MlV5c2Q2ZXpEbFhyZEpaZ2ZoenU4d2pwWXYzOCtNTThG?=
 =?utf-8?B?WGs0R3lLV25tbzVSNE53WDVLckJGempIM1hOYlMrQnhSU1dacHhqdFA3WnVF?=
 =?utf-8?B?WjQ5dmthL2ZwYWFqdk5BZ0F1YWhkaCtWdlhOb0JVdmNJcmZqMk1MejJiOE9o?=
 =?utf-8?B?UEpVUFZiemtmOGhSRzhsamJOODZjNi8xUEZlRFV0OFQyRzJPMlZZY09nTHRh?=
 =?utf-8?B?dkk1bmtWQWxBMEh6VVA4cEFLSFRzYzc1SHRPellMRU5Rdy9XMjhDVzVzdHVv?=
 =?utf-8?B?NVRTMmF3TXcybGxZN0IveFRCQjNRVUk4N25VOGRydkIvSi84MGVuU255Yzc1?=
 =?utf-8?B?bEE4VVJSa3liWGxXSS9wWTBRQ29MK2RmVFBtWjZwcVIxczVJNE90ZUlGM1k4?=
 =?utf-8?B?T3JFL1dHZFpwL3FweXQ4Sk4wTkZ4NHJ5RFE1eHYxbTdhRUw2aEJuUnBwMnFt?=
 =?utf-8?B?VDFqM3RNekp6RzhFSnlYL0h1QzA3UEJhbko4N2xmaUVJL0xGMUVTdWYyZ1Ew?=
 =?utf-8?B?WjAzYi9Ed0dxNGF0aWtySGJDcFU3OGtqbFRuWGN5eTl4c1Q0NTRCU1ptdjZ6?=
 =?utf-8?B?WnhkUkJSTWxPN0tORVdjVjlldWoxOThOcEpQekNXYVgrcUFNOGF3ajJGWG5q?=
 =?utf-8?B?SDhMZC9JM2l5NWpEcThYUmRlNk1xbnVVSEgrMjQvMHp3WEVyMTJSNEtLcWhu?=
 =?utf-8?B?S016eGtxUDJ6YzJsZHQxZkJaUG80Z0hkN1RqWmJaODNBNW5BRXpMUVJFUGty?=
 =?utf-8?B?bk1NZ3N4dEk1ZFpFaUt0SkxGTnV2OVZ4dFRGeXBPbjRENTdZUW51MUFyTzJI?=
 =?utf-8?B?dXB1emJYVXpVN1RiekJDeFhyRG42WHEzVjVJS3FTcVZzd1pKMFllOTdDbzFp?=
 =?utf-8?Q?qFdZqf?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(35042699022)(1800799024)(376014)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 11:31:50.6414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4d841e-aa8c-4860-10d4-08ddcdca5871
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AC.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10001


On 28/07/25 4:43 pm, Ryan Roberts wrote:
> On 28/07/2025 11:31, Dev Jain wrote:
>> Memory hotunplug is done under the hotplug lock and ptdump walk is done
>> under the init_mm.mmap_lock. Therefore, ptdump and hotunplug can run
>> simultaneously without any synchronization. During hotunplug,
>> free_empty_tables() is ultimately called to free up the pagetables.
>> The following race can happen, where x denotes the level of the pagetable:
>>
>> CPU1					CPU2
>> free_empty_pxd_table
>> 					ptdump_walk_pgd()
>> 					Get p(x+1)d table from pxd entry
>> pxd_clear
>> free_hotplug_pgtable_page(p(x+1)dp)
>> 					Still using the p(x+1)d table
>>
>> which leads to a user-after-free.
> I'm not sure I understand this. ptdump_show() protects against this with
> get_online_mems()/put_online_mems(), doesn't it? There are 2 paths that call
> ptdump_walk_pgd(). This protects one of them. The other is ptdump_check_wx(); I
> thought you (or Anshuman?) had a patch in flight to fix that with
> [get|put]_online_mems() too?
>
> Sorry if my memory is failing me here...

Nope, I think I just had a use-after-free in my memory so I came up with this patch :)
Because of the recent work with ptdump, I was so concentrated on ptdump_walk_pgd() that I
didn't even bother looking up the call chain. And I even forgot we had these [get|put]_online_mems()
patches recently.

Sorry for the noise, it must have been incredibly confusing to see this patch :(


