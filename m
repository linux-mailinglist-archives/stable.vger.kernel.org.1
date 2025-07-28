Return-Path: <stable+bounces-164905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0DBB13925
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 12:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB0F3B6494
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 10:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E072472B0;
	Mon, 28 Jul 2025 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YFkoFMOi";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YFkoFMOi"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010013.outbound.protection.outlook.com [52.101.84.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76BA1CB518;
	Mon, 28 Jul 2025 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.13
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753699374; cv=fail; b=R5Nh5zPMlhJmbOeHdKl4ei2yzy6v0n/PyK0CQLq6cPr5esZe2EOYyuC3le+nZxkuqAlAXgTZWzOti+cJ0GBhHhKPG0ogX5Ybbr+6oQrOw8Csyd355BUc0TH8CaqlxRnJwMJz/xMbIywPlTSZOUnRxLzkDdFweVjQCzDIIS+OyOQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753699374; c=relaxed/simple;
	bh=Z2YpNtIwNexhfjd91wYSTiym98p08Zpq7IxPGmUpeFg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bxgCQWi2Nz19rd52thgbXps/WH4ylIUaADDLctfTMKhmskGEbvNejqJm5Ub/6DXrkfNxaU5lZ+Pya5tPOXO79dUjIl2QViYUzQpCPoeH4yiVgK2PfvMSuhgq8XCkNQsVvDuBpjN0pwOtrMCg7Te5SkFR2C4DL8h2G45BFQAQEyc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YFkoFMOi; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YFkoFMOi; arc=fail smtp.client-ip=52.101.84.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=yjUuWb7NePMB/mQU7yvZPTzax9OG/VtidqHA1xspR4mvgyxK0GArSSu67wA7ZAImIrT9zk5uX/3fX2NTwNSQ4fO3tWZoyvb4oCcOIGfXpk7Ygd51ME5JF1mbBs3ocszgc5JR9COrPQHHIsTkbmT2MUseMpFHuplLlzXBAoCelYb0ozcjRV1ZOwG6jy2z/mn/xBfbOkk05Q4K7FVfgAWTmoIqPMW7afwDsIkuvVfLZTzz6blthNPGrEIQY4qCprVg0OJxvlijwc6sf15cuSfrPPr2WtgYD4bRWYWcC+eVBIiaNFnpdF3XyUGFdxFzKNTxfFDU+wZiaE4wzcbBD0hPTg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4++q4IBH/FYEU/5BRRmUPh446FoGjnVJzq0klnKyK0c=;
 b=QyO7ITs/6Xo7nTGbSMXlEwsagMOx68c6Erhm4zrLPxZ6LHn42DSJX6AfAIY0ohUSRVYLDjDofv9zRrojyLE61UYfBOEH9dx6sQQ7L7mcIQjzPEVUbpwVr0u1j+GYWSgeA3/ZCYj9k08kSNe0D63OTD0sHa63Y3k2ORYOp3iMGyIpHdvYPP503xsAk+yTHiEn/aGHe0wssS+4lwyyNOUZijaD7Nk5YjMqHShDFvCT96JPqfz3EAUO8J36Q7D2evE06e94Ct8NDFuPaALRIE2Gka8wX+mgaMUT89TcfelWLBFILaEWPu3IUYVXV5u6VpnIaSLrl0GGqTlHKImUOickhQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4++q4IBH/FYEU/5BRRmUPh446FoGjnVJzq0klnKyK0c=;
 b=YFkoFMOijxpwcGth6QPWu17G+PvxvZ4KFOiWI8VCQ9oYuIlGsNd2YNsBTbejnIL1qhh2SbAjp0SLd8pgvxoSRa9q4w/+Bd6d/s2kIdWCHqTLSEuXHeRZIV0mw3tfqz1el+3pd7uPe/RXsb1wnfUhOazudhP6HIbTCgbI01qAqbg=
Received: from DU2PR04CA0166.eurprd04.prod.outlook.com (2603:10a6:10:2b0::21)
 by DU0PR08MB8253.eurprd08.prod.outlook.com (2603:10a6:10:413::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 10:42:48 +0000
Received: from DB5PEPF00014B92.eurprd02.prod.outlook.com
 (2603:10a6:10:2b0:cafe::f3) by DU2PR04CA0166.outlook.office365.com
 (2603:10a6:10:2b0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.27 via Frontend Transport; Mon,
 28 Jul 2025 10:42:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B92.mail.protection.outlook.com (10.167.8.230) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.10
 via Frontend Transport; Mon, 28 Jul 2025 10:42:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6ipnqFd3qAc1Z8bX91Q8c8c3mfPjit/4EfRfSMo9Z99LJ6DRx7Qgmu9xhMc5/anS3lv3H5FhBqa8XyI/S3M8CGrGPE1QUPMa30PYE5CxAUnleyavu98SQSS+EVYZGnXIIYSDli2kgwOOMcP01nnDbG11x+jVU8/zVqW2CiPOcZaDYk5D13mgrxV+ORXTUeQ1aA9N5GUHLzDZ5yyB53JaGhPfubyyE9TZRqR8sgolLFOd5Ve+mLkB+8XW530zLth6LZAGxlrAn4VH6KjNzkPCrp2a2UvGw5Eyc6NlT9vAVg9xOjETZ3bKOqa3rVrZlWL7IaJ37b3X3LKRuMUwgOoKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4++q4IBH/FYEU/5BRRmUPh446FoGjnVJzq0klnKyK0c=;
 b=yTXPZ7aB+LiO0ctjun2lBriuxiR9zP76+h3yIUepXsoti21d6VqkmTebGL0RXR9wdsv65dsKggoa6qsk6pnrXw7VgsL8i1nYHmNgstD+KIQkb1RgBJZPN4P0RIErg0ebuxFaX5Uvjfars4Bmhsc0iHbMwGqVhh45IGfX+j0OjrEXKQGHgMfHecLxeTBWt2vg8Np2x5upeJ1i5WBijNiCWqwymodHEkVSjr4xjZn8yuBQxbsS4K0TPmURr8QpXeZiw5GAuedATM4p/v2Q/pKMfEwHYRx1vF4fV4qIijk78Wcc6RJ74pI3bQ4cW+7XWUBdOnqViM/4vPtqs0QnLDjgZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4++q4IBH/FYEU/5BRRmUPh446FoGjnVJzq0klnKyK0c=;
 b=YFkoFMOijxpwcGth6QPWu17G+PvxvZ4KFOiWI8VCQ9oYuIlGsNd2YNsBTbejnIL1qhh2SbAjp0SLd8pgvxoSRa9q4w/+Bd6d/s2kIdWCHqTLSEuXHeRZIV0mw3tfqz1el+3pd7uPe/RXsb1wnfUhOazudhP6HIbTCgbI01qAqbg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by PAWPR08MB9966.eurprd08.prod.outlook.com (2603:10a6:102:35e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Mon, 28 Jul
 2025 10:42:15 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 10:42:14 +0000
Message-ID: <c1a9284b-972a-4474-9151-0a2ed8558b9e@arm.com>
Date: Mon, 28 Jul 2025 16:12:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Fix use-after-free due to race between memory
 hotunplug and ptdump
To: catalin.marinas@arm.com, will@kernel.org
Cc: anshuman.khandual@arm.com, quic_zhenhuah@quicinc.com,
 ryan.roberts@arm.com, kevin.brodsky@arm.com, yangyicong@hisilicon.com,
 joey.gouly@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, mark.rutland@arm.com, maz@kernel.org,
 stable@vger.kernel.org
References: <20250728103137.94726-1-dev.jain@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250728103137.94726-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0108.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::26) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|PAWPR08MB9966:EE_|DB5PEPF00014B92:EE_|DU0PR08MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: af720604-01bf-4481-73b7-08ddcdc37e43
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?dElwUGJkWTRDT0V5cU1nY2pJZDdBWTkwK2ZPbW9hL21LN2w4Zmc0dDVJNEgr?=
 =?utf-8?B?MFlBRWQrZUR4c0IrTWQ5dk0zcXAvbmcxbFNsR2Z0b2pCSmtQYW1wWHc3bERo?=
 =?utf-8?B?YjA5QVNGUW5odTR5d3laNDlTSGQzQnBoWmhKRUwxVWk1cjRGeGk2V3lYRlNz?=
 =?utf-8?B?YmptUGhnUWQ3bVZBUWVpdFk2OXhnSGFKWW9RTmJoMHZXTlZHamg1M2VxcmpD?=
 =?utf-8?B?V0tFeUwwMEU2aUwySVZjTFVxRldYRU1nckFrNk1xNDJMZm50eHppU0djRTZo?=
 =?utf-8?B?c1pWRTU2enRRTDdScklLSSswNUN6K2NOS3N5MFNYcko1UW1IaTVyOWdMSk5t?=
 =?utf-8?B?aWpJeThRWE0vbllwNnJEODBNeDBJcEF4NkZIYjU5LzRpUUovWmorQVVZN1Qw?=
 =?utf-8?B?dzcyYWVyT016R3hPM3FuOUJFZXFJeUZPSzhHcjRUeXhIYlJnQjBCeW1PRjRz?=
 =?utf-8?B?VHdHRDEybzZVbDNCQVhEQU53dzRQRWVReHVMUFQ3UTJiMnV3U3hBY2sySVNM?=
 =?utf-8?B?SUNPUlVnaE1jMUE3Nm1JYzRaTkQ1SVA4NmVNNU9RTFpwTks5TWNnaGVGMW5u?=
 =?utf-8?B?N0ZIQnd0WU9VVjU3dlNKT2ZRWldkQlBWcW5KaENBT0N3V1VucStmTFQ0SUZJ?=
 =?utf-8?B?Q1gzaXVpNk4vRlJpSkxxR0pqekpGNVNoRUR5ZHJZdWlCWGlWMGFvMWtKcjFT?=
 =?utf-8?B?MjNLR3ZDdVNKclRlMkMwKzFJWjdXTWtRVldUdjBBMWJNUStCZFp4bWRsSWFo?=
 =?utf-8?B?dEdCU3pSQUFMSzJKaytZNlFBVExic3VxYnRGMVFiWjhTcVlmM3g1ZC9UbHJ5?=
 =?utf-8?B?MndLVzNnUEgxSEVlNHJ0NCsrdzloWm96bHpDL2JlOWxxUmV1U1ZIVlpyK2x6?=
 =?utf-8?B?ZnhiNHUwaGNFMm5ERUFXMWZsWktNbVZBM3orZG1lSEVPc2pTdm5DL3ZLMElv?=
 =?utf-8?B?VGtrdGJXcUxhN2tqREtGVDNSNXR3VG5XYmY4VXMzT3kvNDBrcjdZRDJSUUNp?=
 =?utf-8?B?M2pObW5kd1hhZ05wSnZQRi9NcXU2aEt0bXorOUtiVmFYZG5rK3ZIOUVweEVo?=
 =?utf-8?B?SVphTU9iWEE5SFNCY1lXZzFwVzJaUHNKSExGZFZHZFZOOFJGUm9WcGltbFlU?=
 =?utf-8?B?czJiTWlwY1ZHQUt5N2pDOStZcndkMm90a2sxTlR6cG45elU1YUloSFBzWEls?=
 =?utf-8?B?L01YREdYelE2YWZDcUVmcE5QNnlDcUY3aUFTODdZRHVwYVdMUjJQNXBhVTF1?=
 =?utf-8?B?U2kzU3A3SjB0cVIrZDNGTThseVcrSU1FeGJiT2FFaDFXRWs1MnVFaExaay8v?=
 =?utf-8?B?ZTlnQjlyZVluUkh1WUVlbW43KzM2Q2xsZGhTdlpBek1NOVdEdS90aVFheHBN?=
 =?utf-8?B?R1dWNkFmVEVWSk9jM3gwWjJxcjZFWS9GbjBDVmEyeE5XeXlOdmQ1UC9hL05K?=
 =?utf-8?B?RWhDV05hbDlERW8wWkpQVTNGZXRFVTM1TEZYWXlEVzhNSWxGTUQxbFZ4cGRh?=
 =?utf-8?B?QUFBMFdHM2J1STFITmNLbGdjVU9VTFdBUTNVV080S20zTGxFZzIrZEsza2pm?=
 =?utf-8?B?QU0wQVN2c2E5VE55eENmQXBsWW82SGs5Yi8zME9jMkphWFBRU0lWeTJrZ01a?=
 =?utf-8?B?cjFJWVlKMmsxMEtxOVJvMGVKSENYQUd2Qnc0ZnhwWCtOUTVwNFpMZDRRK0t6?=
 =?utf-8?B?azJqTW5ZdFJhK1IwK3lZTHJ6dGtiYVdKR29oYjhhaUlSSTZmOHpQZHFBQ2VC?=
 =?utf-8?B?NGgrOG15TjFkYkg4dHZUeWpWUG0xeE8rN0VtNnQ1REFFb1U1Zi9VSERDRCtO?=
 =?utf-8?B?OFN2Ynk5TncvN1NIbWVOYStlMWxMZnlxUnBGbDdvL2NzaDd3R0ZPaVFUUWpC?=
 =?utf-8?B?WEFqRk1QT1dDekhJaWt5dGlkWlZqMm9DdW5vVThiY3gwVnc9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9966
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B92.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	243745f7-a278-4f45-6ea6-08ddcdc36a45
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|82310400026|36860700013|376014|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXNwcEFPUGRHbTVQU2ZkRWJkNnoxWGxlZDRzMVZnYnpwME45Nmtlb29WYnlj?=
 =?utf-8?B?aHl1K0ljNURGSFZHN2M3bmpPeTIxZ0ZYbDE4Q1FkYVI5MHpvWXMvYnM5WXNX?=
 =?utf-8?B?YjRpSC83MmhwK055ZnZxNlJCL2g5QVNla3Q4ZHFnQXJkVzJWUTFYOEtac0FP?=
 =?utf-8?B?TzhlcUdIOWhPai9na08vZThjaEpoZ2pvdEN5K0dBLzR6d1FHL3ZzektaVU1S?=
 =?utf-8?B?TVB6TU85VjFIZWxQbkEyWVdHenRIWkhvNjlFaFc3MVR0K2k2R0xHWjlZZElL?=
 =?utf-8?B?UzFtZUwwQVJGNE5Rd2NkNEp4REV1REtMQmlSTkpaUnRnOGhpQ1BaMFBWQ3lH?=
 =?utf-8?B?Vmh3MkZwV00yRDNER2ZOYVc5RFRlQXpOVG8zMFhKOGNiKzZ2VnRxR0wzQ3Ix?=
 =?utf-8?B?VVJBdkFKNEsxQXlPaTNVNVF6WFlNQVMvOFpwSmVXUzBqQkRnZWdPdkZTSGpj?=
 =?utf-8?B?cVdTOEF0eXNyQTBxUEdLbHRQMFpjMVVFM3dZVjJRRUVCY0pPVDczR0lrOGhI?=
 =?utf-8?B?N2ZJdk55aW9VRHVvejhNSEdLSEpRL2JycUs4S3lYZHhCeDNLZUxTUFFDN2FM?=
 =?utf-8?B?TjFhMUNQdTNNNmFZMlZ1Y0FzVE5UUko2dkI3OWVyK2JFL0lqclRQcGhxQ0Fr?=
 =?utf-8?B?ajA1Um5xT0trcjk4M2tEN2pxejBxZnNvV3VpNjJKVmROMFVMU2kxUWJLci8x?=
 =?utf-8?B?bFc0Vkd5akFTNGJ5SzRoL0o1aVQybjZ4b2p1aUg2NjV1UThTZWcrWDFRL3JD?=
 =?utf-8?B?bE1TRkRybUxrZjJRYXFJamlMYTgyWE1YTWtjS3hRZ1k0dEJQZ2tINUdZS1JG?=
 =?utf-8?B?LzFZVWRSTTRXRzNJbVV4SXc5SW9GUEdHQVIxSFp5UDdyc3ZLakJFZ3dmeTZ0?=
 =?utf-8?B?M2hzeVFzMVlTLzhVOG03V2xHRXZxck1sRXJLWHlhU2Q1UFhSa0VzNzdqWHJt?=
 =?utf-8?B?b3d1MS9WcUNzbVJOVkgrcGpuZFBpaGpqK0Z5ejN5RXdaMGVtV1p2K0FxaVBj?=
 =?utf-8?B?MzZsRG4rNlVrYkVmS1ZqbTdlYUhHcklXRWgybnZBYUxZWVAwbVZyWmhrMjZx?=
 =?utf-8?B?cTdsdHBacGRENHdFTlg5Y3ExRmQ5c0Fpb3N0MzFpZlhyT2cyMVRhWmViMEhC?=
 =?utf-8?B?OE5xdStkZWgzSHY1VFVQNmdEYnZtcVQvU01JMzF3K1krdXZFeXZNT2h3d1NL?=
 =?utf-8?B?NjI0WGEwMnpQK09zSllRaGF6WEk0V0ZmODBLRVI4WGtGQWcvT0E0UUxSbGZS?=
 =?utf-8?B?dzdiQVh2eEtPMFNlSmFIZjBpZE9qQytWSDBBMEpReDFWQy9zZlFxRlpoSnRK?=
 =?utf-8?B?RzJLbWVUV01vV2RWbHVPdDNjZkVxQTFEVjFxR2EvdEVyT21IRXdnVGZlS1dm?=
 =?utf-8?B?Vk1Keit3aGJzUjB5QldQelRqaWgvUUZPRkJGQ1FpTE5sOWFTdXpqeXVraXFq?=
 =?utf-8?B?SjJrbGcwa3FqSllKVVkvN0FoZit4dVZoeHBBb0kxUUg1VDZlbFAzRDF6djZH?=
 =?utf-8?B?QzFJcnNoQlRNRWo3S1c3UFEyMjB6TTZWQmNFYjB2MEQ3OEZKdDJVN3NVcWJu?=
 =?utf-8?B?SndiTjk4dEpQQ2lQOFpLRHVkUmkzNWlxeS9YckdIRlN4Nnk0N2djbVRRejZk?=
 =?utf-8?B?Yk40Q3IzVGRxeksxczhmaVY5T29xczhiaTErMkVhSm41T2plMUY3b2tVYnpU?=
 =?utf-8?B?d2M3dDlVaWZsa2M1YkdmV2Q0ZFUyZjZNcU1jZDVhUk5ZK3hFZ1U2OGs4eis4?=
 =?utf-8?B?UEQyT3ZvV1FZNnFUNUVwWTduUW1EcXYxeTFGVi9lbE9LSmRuUklDOWlWQnlQ?=
 =?utf-8?B?VzFmaWNLbU1qOHRRK0RHN3o3bG0zM3ZsS2hMVjR0WlUzaTdxVTNMNjd5ZXNw?=
 =?utf-8?B?RXZxaXVtN0sxaUVmcEhpcnZVOXZSc2lkanQzL1ZJS28xVGRMQnZMWEFNOXFk?=
 =?utf-8?B?TTIvdGNTODl0OFFtWEx1eG9BZEo5bWZ3cC95SEsvSERWcnJzb2dyR0dMUll1?=
 =?utf-8?B?dytVTHhuVWQ5VDU3a2l3Tm1FeW94cjZmekpnQkFwZ01RaldleXdaRlZmYmlV?=
 =?utf-8?Q?C4UR8o?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(82310400026)(36860700013)(376014)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 10:42:47.6089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af720604-01bf-4481-73b7-08ddcdc37e43
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B92.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8253


On 28/07/25 4:01 pm, Dev Jain wrote:
> Memory hotunplug is done under the hotplug lock and ptdump walk is done
> under the init_mm.mmap_lock. Therefore, ptdump and hotunplug can run
> simultaneously without any synchronization. During hotunplug,
> free_empty_tables() is ultimately called to free up the pagetables.
> The following race can happen, where x denotes the level of the pagetable:
>
> CPU1					CPU2
> free_empty_pxd_table
> 					ptdump_walk_pgd()
> 					Get p(x+1)d table from pxd entry
> pxd_clear
> free_hotplug_pgtable_page(p(x+1)dp)
> 					Still using the p(x+1)d table
>
> which leads to a user-after-free.
>
> To solve this, we need to synchronize ptdump_walk_pgd() with
> free_hotplug_pgtable_page() in such a way that ptdump never takes a
> reference on a freed pagetable.
>
> Since this race is very unlikely to happen in practice, we do not want to
> penalize other code paths taking the init_mm mmap_lock. Therefore, we use
> static keys. ptdump will enable the static key - upon observing that,
> the free_empty_pxd_table() functions will get patched in with an
> mmap_read_lock/unlock sequence. A code comment explains in detail, how
> a combination of acquire semantics of static_branch_enable() and the
> barriers in __flush_tlb_kernel_pgtable() ensures that ptdump will never
> get a hold on the address of a freed pagetable - either ptdump will block
> the table freeing path due to write locking the mmap_lock, or, the nullity
> of the pxd entry will be observed by ptdump, therefore having no access to
> the isolated p(x+1)d pagetable.
>
> This bug was found by code inspection, as a result of working on [1].
> 1. https://lore.kernel.org/all/20250723161827.15802-1-dev.jain@arm.com/
>
> Cc: <stable@vger.kernel.org>
> Fixes: bbd6ec605c0f ("arm64/mm: Enable memory hot remove")
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---

Immediately after posting, I guess the first objection which is going to
come is, why not just nest free_empty_tables() with mmap_read_lock/unlock.
Memory offlining obviously should not be a hot path so taking the read lock
should be fine I guess.


