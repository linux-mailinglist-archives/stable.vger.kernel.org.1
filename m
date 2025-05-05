Return-Path: <stable+bounces-139747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA1AAA9E62
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C80F1A80235
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 21:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9B4270EC1;
	Mon,  5 May 2025 21:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XOcZVJ1b"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C961C3039;
	Mon,  5 May 2025 21:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746481774; cv=fail; b=MdEOQUHukARoUWTtL/BdVaAuetFWANtymAtwwmx9z7HDJnVtAYoFhwOxBeWbd/rpihbu2zJm0HJdAZBVAfwunoB0nYmRkENGovgjoiPqqTSfw4rf7LlZ3SFKS24RvEuM2zL4OOJw1QXJ/5C0csCSGrArh9DfQYNVFd7ybAXyjVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746481774; c=relaxed/simple;
	bh=jlLRYMxa8OczoAj6BA/0efnsnYa28sC3JzjrrlbTm7Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VMl3nMXp+QzcBl9915bwDiNYDhYzuCiJFUhvhNWHvXxeWIxYZ60fdGqEPd0jVNhxmxj6PgW+A3ncTOXvLHcIMkvgZ0hy+0r/usFaEOuPHo4+uKqLpPtp5h2LhOMmB7EMz62U/fHqM4OeGZImxfjJgHGEHa6G6eD7K1huP5gbOXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XOcZVJ1b; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5s8fmqOv0GH1GENaMRw07XUA71pAWuDV1YWDLOsREfxjSLog6kF8fFN41Wle1+97UK9WTg8KA79pgZZjv0gTfgPuMxs22jxWlfu07J7A+dBJc5xAuulZdr0uw/JT6G+YAetRDb0R018Gx9fv+MLDLFDW+mKETFRQobnb4NCSmO3Fu12XXgLbzk6ToqOLyxb1Um3uNIvFgXVn8pv5LmbOKL8RpPuVQjR+YMyTBzDkk1LFfgFituBFozO1Qbwv5Ny7B1OVqg4/IQae3iC6BThu0hR4fA5kzpe7vzZuDUsRqU5xDzztLdjzoaJvo+5yogQj5ZYbkhLAfMXvY996yYXsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1T6bvdwBzB9dQHo/km7bg+7vmMl38k1A4ETYSd7aVE8=;
 b=l2fT6IPGRfnE8lM39irIQi58NSiTITwkt2Ihin+5faLHuTmIxqpRShfQ4sVtGXqgmi7OsD0NCTq2pWqOr4EtKYC3i2+P+7wuG9VuEVnoXfTpvHQUrNJ0yNuV9G0hslL4YpCF+w5YgYtwpFPvJUo0tIRhyo0KOgBTJ6jm7D5x/88haqZtDv5hbDX3+UQ/f9Of8ubPCGEA1CGmjIaMYo5F8tvogjlfKTLtTIAhwW5F9MLpC+6EpXxxqBmgM3Ns82ineRnDBTxKdPhp7uumxOoRuULWHd3rxrcecE0IXKc6rnUNQN7A/z0xAiZw3q7GLL6/xe/IUMlQ1vf/o1HaFf/TUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1T6bvdwBzB9dQHo/km7bg+7vmMl38k1A4ETYSd7aVE8=;
 b=XOcZVJ1b33v/9+yzVW+lVC9eal8V+P8Dn80yv4IgNdz3ro5fP6OnXPE2t/cIus+3+fBY1pHFmXk5P22mszlFQYpa93iw6Zl8eF9dN0ZfhwlY5BA1nfg3bhJsm/2eEnLzjh4bRZSGif7YHdEQmLU21N8AWVwv+ltpzfJ+KFQHz10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Mon, 5 May
 2025 21:49:30 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef%5]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 21:49:29 +0000
Message-ID: <d980dc29-9a75-459b-a194-cb225b3fae7b@amd.com>
Date: Mon, 5 May 2025 16:49:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] x86/sev: Fix making shared pages private during kdump
To: Ingo Molnar <mingo@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, bp@alien8.de, thomas.lendacky@amd.com, hpa@zytor.com,
 michael.roth@amd.com, nikunj@amd.com, seanjc@google.com, ardb@kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev
References: <20250502212143.578866-1-Ashish.Kalra@amd.com>
 <aBcxjsdC4tsIgIf2@gmail.com>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <aBcxjsdC4tsIgIf2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0321.namprd03.prod.outlook.com
 (2603:10b6:408:112::26) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|PH7PR12MB5903:EE_
X-MS-Office365-Filtering-Correlation-Id: 28aaf0fb-8774-4daf-66d6-08dd8c1eb685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUtIajBITElXZWhYd0l4UDc4VVZWSmJDMlRtL0s2VURvRTBoUFhvM0lKOVNs?=
 =?utf-8?B?OVpIckJFVis0bHRoR0V4OWNHeUorZzVISFcrNVhvMHlHbGNHWlpTSXZkanZk?=
 =?utf-8?B?OGFxaU8yc2ZQa3hBcVN2RGM2cTBXalFoQzhCeGF6VW5TaWxwOFd3ajFvOS9Q?=
 =?utf-8?B?VllZQTI2MndoU3oyVHVCaE51b2l4cEdmdUsyR0ZHM1I5TjEwS21UM3FFazRu?=
 =?utf-8?B?SkJSSFBDV3VZV01OT2gvR2hqcEloa0ZDUnlMMmU3UnViRzVrREg2bStzcTVu?=
 =?utf-8?B?MjU1MjZ1d1lLbE1FZEZIa2hXd0JCSk4wbFovK1FFYnBFZFM3cW9GOGoxRmNh?=
 =?utf-8?B?SGdkenVQb1lwVTBOcUNCYWVuZDBDU1N6OUJCR2thM1drelJwemZkZkVLRDU3?=
 =?utf-8?B?QXNIeW96eWo1b3YwSVRxNjNmNzZHbU5ENnVkN1dwcGNtUXNqbXpVYTllVFZa?=
 =?utf-8?B?cFJNQWZZbzlYVTE3VVIxakFyb1k0MW1HaXBQRDVwUkQrNklaUndXRjB5citB?=
 =?utf-8?B?WVdnNmtSb1BCSXZiRUcvbXMySGFUYm13aEJYbmxIZTY5MHFTK1Q1Z0dzMGtS?=
 =?utf-8?B?ODFKZkpSUG5aL29mTFlrZENPQmsrbDZMcktvUXVtWmtwSG4wazdNd3VwVWtX?=
 =?utf-8?B?WUgrWkE2d1RqWUp3eitkR2diaHYzblYveGRKNC9XUHBLZ1FBa2dsaDVXM0gv?=
 =?utf-8?B?SEQ1N3VrMWU5UHIvanh4RjNXeGd4TnE5bkJNMlhoZ0V4Q2JvL0t0eTV1MGMr?=
 =?utf-8?B?KzJNT3NOd1krMC9nZGFvWnBqdjEyQTJSU3JjT1kxcnJFWml0bVNDN1cxVkxr?=
 =?utf-8?B?eVpKK1VSK2JDRi9oOGZxZmdJRFJLYTNyUFZWeUFTVWwyMmRsNzJMYW1PM1V6?=
 =?utf-8?B?NjhhUFJOaHRNUXVINnFISUZ5Vk1BbTFwOFVJNWVkdUltNnpCM2ltcmJ3dUIy?=
 =?utf-8?B?SkdNZTAzVnhHSUttTlBKVjJCaHRhR2ZQYjZCeTZTRTVZcTVvcDNXWTA0Q0tp?=
 =?utf-8?B?b2wrRlY2b21QN3ZOSktHSWU2NVNqeXNxdUhhbzZhbVAxZUQvTmh2MVRKeS9F?=
 =?utf-8?B?UjlJOS9NYXJSZjE0c1dkZ0pzU2YwWmhHTE5qMit1STFWeDY4TnlYWVI4bS80?=
 =?utf-8?B?Vi9uT3M5dWo5ZGxXb05EZXFrTzBTZ2NHb3lXRnE5aFVBalNWbS82QzZoNjQz?=
 =?utf-8?B?NUw0N05MUklYWldhTU1HREdQL00wek9MNDNWeloreE9HYnFHVWFXSCthNUNk?=
 =?utf-8?B?bm9ycEhucEhIZGlKM3VFSEl5ejlyZWR4TUs4a1JoNmdyWjYyTVNVc25wanZB?=
 =?utf-8?B?d1lpQi9kVFhPb2JqR3VQN0NGeWgxeXZlYVI5SmVZY0psdW5qdUZKa1FhOXZW?=
 =?utf-8?B?T1Jla1dNd0k3bkdhV0VJV21XR25IZExOL09RV3dUM3o0YkV6V0pBODZTb1dU?=
 =?utf-8?B?dDlGTmIvRHV4QUVHbDRkUkQ2SUl1QXh0bEhwWUVNd1JUNEZRbXJuaHB4U2xt?=
 =?utf-8?B?N1lyak9RbGVqeEJ2QTZLVkd3QzVNK29EVDhNbDJGRnVQTGlrS1BDS0xCdmZU?=
 =?utf-8?B?OUo2a1B1WWt6djZUWGo2RjBSczdlQjEwUEtVOXpQVXpIR0FiRVZHK3RnN1BN?=
 =?utf-8?B?RkE1RTA4SThWdmxsWWk3aG5NRXpibWdmbGV5cllWMmF3Zk9oRzFyV3o0ME1K?=
 =?utf-8?B?QkRJR1JlaHBxeFpZYWpSVklUUndlTWpUQ0RTZjl1WThGL1U2Z1U1REJzNjZ0?=
 =?utf-8?B?ODFRUEhaM0pIZ0U1aVRaWlZjaTAwM2o4Vnh4RkRhT2JiNFkva3psaXlPN0Fk?=
 =?utf-8?B?Q3BNZUx3UktVcDkxUmdLVEVDYkZpV1hwTElldkMxQlk4TDh3S2lVSFhQLzRo?=
 =?utf-8?B?Z3p1aEh1OWw4M2phcm5PakR3K0s1VFNhSFRScTNINmptdDJSaHJ6SmlBMFZT?=
 =?utf-8?Q?AXYf1iiL250=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZERxY1QvV1EzQjNkN045Q1ZSZ2E0Qkcxcyt3SUx3aWM4SEJVNUtyT1NBdG13?=
 =?utf-8?B?akEwZHBYT2JaSVRYdzJjN2tCRWlvWlpJY2EyVlg2ZW5EZ1R1UGhIcUlmTEow?=
 =?utf-8?B?c0J5d2ZRWS9NNytMTXpYeStDamtxYlozRlo0RUN6WFRodytGblJycUsrV1hr?=
 =?utf-8?B?emN0YVNVdGdnbEVVMlNNVzlOcTQySktkS2poSWY2S2NiNllSc3FLSld4RGEz?=
 =?utf-8?B?dy9BV1hCSDB6SzV2RjdWeE5kbkJqWmJoelZINWg3UEpLZUtHL1Ixb0dIL1ZM?=
 =?utf-8?B?bEJ1dkwvTVQ1ckdsaFh2YmlxZFpEWjZZcnpDakgxblJ3b2h0RmhzUFhxYStY?=
 =?utf-8?B?SklHMVVSUkIybDhZb2VUc3BOSDk3eWNmRXRmZUFjOU5YRE0wZjJrMDI1cFdU?=
 =?utf-8?B?QWNlbVBieGhXOUNsS0lQU0hmV0I2MnNndTdOOGU3cUlPTjBZU0QyNUd4SFpv?=
 =?utf-8?B?NDk5anE5SkdKd2xQQ2ZPZFRXSU0rejVKMkpCN2VNZXRzNWpOTTJ6VXVqZHFK?=
 =?utf-8?B?bkpFK3ZUSXdCUy9TdjZEcjBHMWpLUS8xMGFYMlVNTytONFZIZ3NhUkxnNnJZ?=
 =?utf-8?B?Nm1GejNEeFlyVjlINzBRK3c0SkVCS2hzVTZ3ZDlmdk1sVHhPTzlkWHVjR1V4?=
 =?utf-8?B?a2xCTVgxQllOclFhZ2VObFF3cnlTOUpXOHlDY2RoYWNvOW5vVmt1WDUzd3NV?=
 =?utf-8?B?dnlsM3gwTllJRW9JTUUrVXYvaDlPZVNXRU5QcW13Q3B5d3ordVNMMWltYVE1?=
 =?utf-8?B?Yi9UUW8ybUwzQmRxN3hyb2tCYno5YlhnSnNKVnNHYTkzTHJIanRIVEVZdTU3?=
 =?utf-8?B?SC9ma0lPbm8zdVZRMG1JdG5RNjdSYXlld1N6NW1QdjJ4VjFCUGx0QTNabDdF?=
 =?utf-8?B?SWNrK0hIR0k1VVZ4WHRmaUkwZEdVQ3JYZGU2TFBoemRrUWM3bW5xWnpWNnkz?=
 =?utf-8?B?d0ZubFoyZXhzby8zZmp4OUdlclk1MVlDL3A5OWEyWTJUVkFGdFZJam5jVEZI?=
 =?utf-8?B?N1hjSUpRWXhuWUNnWVJGd1BvRVNqRWIwNG5HckFOeFh0WUt1UUZHVnd5NFdk?=
 =?utf-8?B?bnVRWVkvVENxR0tXZUprNkQ2VGVvc0NXRFY2R3dmMHV5RTcyeFB1OW94L3dl?=
 =?utf-8?B?ejhMK1JqeTdyTFpPZTQ5T2dMaWdGY3lhNmRzdkk4L25xbE5MZkxmSzNGOS9Y?=
 =?utf-8?B?R3k5djRYeGp5LzBoUGpKNm9kTkRPeHpqUzg4OE5tSWJXcGJlKzZzWVozRTNk?=
 =?utf-8?B?K3YwSCtQaFVNdE53WWlYbGprZGp4ZWFVZzlpMDZpZnlRbHRWWFh2dUdWNTdY?=
 =?utf-8?B?R0VDbENpOTZmV2JiK2lFS2M0dW04dzdTVEdIQ3daSHYxbUFUQjF6MFpFTzc3?=
 =?utf-8?B?VVBBZnJEbzZudFlsNDY4YXVVdGEyWUl3VWtVTUxwWTdBZEVjTHZySWx6WUR2?=
 =?utf-8?B?U3EvYnNJV3VoWVZUNU9NYk9BQ25HRFVsN1FCSUxMVktQd001UXZ6b2NHbGM4?=
 =?utf-8?B?STcrSmVXYWZ4TDJqTzJZT09XZnEzRmI0Wjh4enFYVWs2TlJ1YmR2WjJkM0VQ?=
 =?utf-8?B?NTBLY2NSNTY0RmI5ZFRyaDF3V3lSNXN3SXNtOGM0VVpPUDNUditONmdYVVZ1?=
 =?utf-8?B?bW03MGliL2pqNlVINjB5VnIvOGw5bTl0VGxKQmFDOUFzY3pxMHh1TDJla0po?=
 =?utf-8?B?WHdmeERQenBacVhMbGwrT0FOWDlBbGJ2QlRhK3NWc2xxUjFGbUpDaTdjc3Zp?=
 =?utf-8?B?L1QvSTNzVTdZQjFJQUVidFFmTndCZythZkJIQjNZRHFLYXdOaU9VZDN1bmJw?=
 =?utf-8?B?T2ErQW5tZEVIUm8xOW1MQTZhYzk3bXVsc3EvRGNMVzNZSGRMRUVqcTgyT2Fq?=
 =?utf-8?B?c1VqOEhOZWRCWCtjY0pOZU1uazF5aE9yc3RwSkg2VjVENWplUHk3WG0xbm1K?=
 =?utf-8?B?a3Axa0R4V1RBbWMyZ1VpN09RUndDYXJmVWRzUE55c0tWd08wbW5BT0RHUUpr?=
 =?utf-8?B?S0tWTk0wRWYxTWZ4OWx2V2ZBSWw0QWpMM1NraEwvaUlwTVJlbkd4V3liRk5L?=
 =?utf-8?B?RENYNkFQU2xPTXl3aVFxUFFCckRscjNTTU5lS2VmVkZHMlNQSkM1eWt1RG5y?=
 =?utf-8?Q?5N4IMCmmzeXBbCBE28cRNvlyQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28aaf0fb-8774-4daf-66d6-08dd8c1eb685
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 21:49:29.7272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aedsa4LQ9nQEryokAPFHawaOd/YzB/o86edAIDoD5K5zWSiw5bU4wXczQy7kstsXsttKUDQ8plDCb8j7QpVRiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5903


On 5/4/2025 4:21 AM, Ingo Molnar wrote:
> 
> * Ashish Kalra <Ashish.Kalra@amd.com> wrote:
> 
>>  
>> -			if (addr <= ghcb && ghcb <= addr + size) {
>> +			/* Handle the case of a huge page containing the GHCB page */
>> +			if (addr <= ghcb && ghcb < addr + size) {
>>  				skipped_addr = true;
>>  				break;
>>  			}
>> @@ -1131,9 +1132,8 @@ static void shutdown_all_aps(void)
>>  void snp_kexec_finish(void)
>>  {
>>  	struct sev_es_runtime_data *data;
>> +	unsigned long size, mask, ghcb;
>>  	unsigned int level, cpu;
>> -	unsigned long size;
>> -	struct ghcb *ghcb;
> 
> So this patch just morphs the type of 'ghcb' from a typed pointer to 
> unsigned long, while most 'ghcb' uses in coco/ are typed pointers?
> 
> That's just sloppy and fragile. Please just keep 'ghcb' a typed 
> pointer, and introduce *another* variable for the virtual address to 
> the hugepage.
> 
>>  	pte_t *pte;
>>  
>>  	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
>> @@ -1157,11 +1157,14 @@ void snp_kexec_finish(void)
>>  
>>  	for_each_possible_cpu(cpu) {
>>  		data = per_cpu(runtime_data, cpu);
>> -		ghcb = &data->ghcb_page;
>> -		pte = lookup_address((unsigned long)ghcb, &level);
>> +		ghcb = (unsigned long)&data->ghcb_page;
> 
> If 'ghcb' has the proper type then this ugly forced type-cast goes 
> away.
> 
>> +		pte = lookup_address(ghcb, &level);
>>  		size = page_level_size(level);
>> +		mask = page_level_mask(level);
>> +		/* Handle the case of a huge page containing the GHCB page */
>> +		ghcb &= mask;
> 
> This too calls for using a separate variable for this, because after 
> this masking 'ghcb' is very much *not* the location of a GHCB page 
> anymore...
>

Sure, i will use a separate variable for this and keep ghcb as a typed pointer.
 
>>  		set_pte_enc(pte, level, (void *)ghcb);
>> -		snp_set_memory_private((unsigned long)ghcb, (size / PAGE_SIZE));
>> +		snp_set_memory_private(ghcb, (size / PAGE_SIZE));
> 
> Do we know whether this is safe? Could the huge page around the GHCB 
> page contain anything else? What is the structure of this memory area, 
> is it all dedicated to the GHCB, or could it contain random other data?
> 

There will be an issue if the huge page containing the GHCB 
has both private and shared memory contents in it.

When we skip a huge page containing the ghcb in unshare_all_memory()
then that huge page should have been containing all shared memory,
because if it had other private memory contents then there would be a
mismatch between NPT entry and RMP entry (as RMP would have 4K sub-entries
for private and shared mappings and then there would have been size type
mismatch between NPT and RMP tables) causing an RMP fault and then correspondingly
NPT would have been smashed/split into 4K private and shared mappings.

So at end of snp_kexec_finish(), when will be revisiting this huge page
again which contains the ghcb, it should be containing other shared memory
along with the ghcb as this whole range was skipped earlier and now
we should be able to convert this huge page back to private.

Thanks,
Ashish

> Thanks,
> 
> 	Ingo


