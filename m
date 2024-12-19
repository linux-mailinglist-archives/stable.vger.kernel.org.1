Return-Path: <stable+bounces-105248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4031B9F715A
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 01:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D261890B77
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 00:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18F88BE7;
	Thu, 19 Dec 2024 00:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ExuAaKMh"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97E72AF12
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 00:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734568013; cv=fail; b=cR3fIS/TV+xEgchNN10tVq+cIdzubENy8TIbqmG5iw9J+XJq3JnJxFJOw4L8KxQHZ3TwCPJ9mdjPi8HqZ3gHfZRLODfC4iMQoMVMo5XBuKpm5gjpPmdgwn9gJpQtGirzB0z0NEb6oBsEhBllBvbeaJncAZhJ749fW7UlmTBDXaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734568013; c=relaxed/simple;
	bh=VCeW5mTpjlIM+3Iz1cEUdC/rqvFyMHm7dVGe/R3tQbI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RXbBNzrsB4B450WmK0mqC1u61kR+W42/o2DAKFPb3YV4CJRPIHZoqFvh7mgPAOVvECHziEtsHxUnncMHUPk511FtJg2rmlO23TiaaNe85altOtAngYlPaNQFrzax0Y18wGHUA+mt1++ShlqXK/Ykxg2z11IUGtTJkkuHwJ2ypkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ExuAaKMh; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sl7UTbpKdex4zu6wDTziGF88gN9nXOyYh1OTz6wfJMlJiklPv1cZFSlVK4x7QqtsM4Vr1MBxlOmaJqzcLkSfetUghQP930FpR4wiZfGbS7bUFbxGIvBBiUlpcjw4DVJf4ZjC2K5rLNY0YEFYPOSNqsvF6nodgVNjCyPzIdQJya7d5IOe0xfJ4lmspxRkGwzFQ6eJjnSZNClp2NtJFgez63B51ExSuvzTyEY95sYwX27i0zkSFhwF1m+MoV7mztSLug3qQrtGR6e5+3eKOnUu6FGBPZe8nyh11nnT9PjAFZ3+DTnmM5672/THqX0Jk8YvcfyUv4Ztbd2G/E/5jwxkzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gS3nHEheOA1WnG7nQ/yjzXiB7pCDpsQTm95JsWzuaSM=;
 b=y8sDRhRSOrAFOkgu/ZcM3ExdcsHCbV1VvEITiJd2eOtbvqRmO3lZhmJItfInan/uD4RUO7ZavieP2jJBhWuLKrlXDzfzco5gLLj+mM3ZPmVeRB/rtPa2rAXNY0zP1j1tKTSkoRARO0VoYvWbAvrPogT0vDhcoZqhtSEXxEOiWxWY6/asDUGJG2p+MrGSFIbUvnT6zSohmwK7HO5tmU1ek/OtjZJAHWw8NPUYAZIHAjZPMtQfnWPYuarwdf+2Np/bX9qgKT0O6DIkKV5buNTWxNRtaF7gmOjSZpVZ75nv+vlKbWQi3yAV4q2qEQXdHNXn0bSmq+Q1rgovL+K40s0bKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gS3nHEheOA1WnG7nQ/yjzXiB7pCDpsQTm95JsWzuaSM=;
 b=ExuAaKMh392afeqmvQmWPIQNqD+z4Nz3os6JNrhcl018dSu7VxO1j2s/EFK25phgCL3cIY8WgdKH6i292RyiX0JO9tvV9vC+NuxqBADiyedrXEE8pZQMDU0E7kE9F2XCPcq4GIt0bMLwygFXLPCXKVWjXdOAHJACv3yvUCm+DaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4956.namprd12.prod.outlook.com (2603:10b6:610:69::11)
 by MW4PR12MB6729.namprd12.prod.outlook.com (2603:10b6:303:1ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 00:26:23 +0000
Received: from CH2PR12MB4956.namprd12.prod.outlook.com
 ([fe80::fa2c:c4d3:e069:248d]) by CH2PR12MB4956.namprd12.prod.outlook.com
 ([fe80::fa2c:c4d3:e069:248d%6]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 00:26:23 +0000
Message-ID: <2432104e-c3d1-44c3-8e2c-fb6d79cf8e32@amd.com>
Date: Wed, 18 Dec 2024 18:26:20 -0600
User-Agent: Mozilla Thunderbird
Reply-To: tanmay.shah@amd.com
Subject: Re: [PATCH v2] mailbox: zynqmp: setup IPI for each valid child node
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <20241216214257.3924162-1-tanmay.shah@amd.com>
 <20241216192841-922fe76161366e54@stable.kernel.org> <Z2NFzb2byhmiDVtf@lappy>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <Z2NFzb2byhmiDVtf@lappy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0059.namprd12.prod.outlook.com
 (2603:10b6:802:20::30) To CH2PR12MB4956.namprd12.prod.outlook.com
 (2603:10b6:610:69::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4956:EE_|MW4PR12MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 76766d24-c68e-4e31-65d0-08dd1fc3c3f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1hjY3EzNVBVNm1WT3BDSnpjdGdGazNZZmlkNyt0RldQd1MzQko1MWR3R1RZ?=
 =?utf-8?B?RWdaTHZJNzI0RWl4RVhBMmc1YTUzYld5TXlqRzZPWDJ3RFBmRWpBTGdnWEdh?=
 =?utf-8?B?TVJLZDFnTjJ0amtLcjZYS2FVeGNaRDR4SEJXUmRTRVdZMXNUT3JCNTh2azRm?=
 =?utf-8?B?WkxFTXRxeHRldEpyL3ZTWnEzVVNPdWJWZWw0cWszblVMcjlYRFN1RS9rcndW?=
 =?utf-8?B?TlRhMmhFWnBwQ0VYdHBDWmhTd1dOSDVneE01NHlWQnJHSmFld1RMVEZBWits?=
 =?utf-8?B?VHVCdnJhTUE5bTBQdlEwSmM3ZS9UbHpLelJ2SGJtWDlZaU44dDd5cE94ZlI2?=
 =?utf-8?B?bFR1TWdjR2g1a0xOc3N1WjRPejVLNFN1U3k5ZUl6WGtXaVh1ekp6MzEyZVo5?=
 =?utf-8?B?bGRrVjNFeUxpS1ZHNFdlSDlDNWdRY1lSOS9sZ1A5aW5CdUprTDFRTlhzUVpR?=
 =?utf-8?B?bGpmNUtpdUFJR2dEdGhWa2FFRDUrTmRLajgzTURhYVhabzBFMXhyaTJVMllC?=
 =?utf-8?B?amU2YXduYW84c2VZb1BaY0kxdmd1Z25XWWV2TzhlYkR6YWwrL1pLU1lrZGVo?=
 =?utf-8?B?ZEZJTWx5WXovdTU3TmtXOW51UE1YbCtpMHdpbndZWHJtWHB1SHR4Tld1Y0tR?=
 =?utf-8?B?dzFyTitkdHVPc0p0OTNwZks2djBDMXo2Nmg0N0Z4WDFZdkpZWmp0akNhVFlq?=
 =?utf-8?B?WTlEaFRDQmZML3VVTEgzUUNBdk4xTEIzNTIvSUJSbGlkV1BHQmZGVzIxOFJP?=
 =?utf-8?B?RDBUbHdPNWhlTWd3emZ1TTZyQUNnSWZ6Ky9udUdZekpDVDJIeVFNb0hGWlM0?=
 =?utf-8?B?ZS9ZM3haOTV4UWZGL1NUT0lNYWI3OURTS3oycE5NUEtKeVhNSG56UkQ3STJF?=
 =?utf-8?B?b3o3NUJTTitmaHNvWEMyS09ROGM5MDY0c0drT0ZxTGxKVlUySmRTWWRlMWhF?=
 =?utf-8?B?Mzg5M1JvbkdsQkhqdkErazFxTDJSaUpnWlgvSENpVUhzTHhRQi9nTEtCVHVn?=
 =?utf-8?B?R1RkcnlORDlEUnROWmZlMUdKeVhJbms0ampEMEt1dVRyUmwxUHZhVllEcXJ1?=
 =?utf-8?B?UXpaSGYxZ0ViY2ZjWkorMkpNRDVKZWFhTEVrRWpiODBmYldqbFZpQmJ1WFhO?=
 =?utf-8?B?a0U0ZWExR0xQRFoxRDJXR01wRjQyT2ExOWIvdHA0MWVNZHo3RllXUlE0WEFN?=
 =?utf-8?B?ZVk4MUo4eHFlWXdIVjZMZzAvYWcvemxrT040M20xRVZtNk1xSGplTEcvZmhE?=
 =?utf-8?B?MGdDKzZhT3kxc2pXRTJ4azRxVFJKeDVtTmJZMGdORGNrNDNxcVRtaE00dHdW?=
 =?utf-8?B?dXk4eFhlS3d5a0I1TFVtVENNTVd4R1c5Mm1iYVZHQklwYXgrbUEvOUZlWmZU?=
 =?utf-8?B?N1RaMnZZZDIrd2Y2OTV6MWNCVzNpTjZtT0NsZ0t2ZUQyQ25pRkJScmlvczZR?=
 =?utf-8?B?ZFNOM3F3TXVIVVlMN0lxeHU0QkpyK2E2OG10SCtHSFkzaE5FaUZEMmMyRmpZ?=
 =?utf-8?B?WENYTU5MTFgxVzVkS2pYclNQMVNZZmdKOTN5dmIwRXE2eW5wRUZjdktadzdC?=
 =?utf-8?B?ejVlb2pBSDFueHF1eHFXSUl5RkhIQVdIN1k2WTRDeDhLdlhmYXZ2SG02ZEhX?=
 =?utf-8?B?RFlPWEJPZ0p4NWF3bzJrRXBqTURDOUwxbDRyUE96K1l4eFBHTUhLYlkzUlRH?=
 =?utf-8?B?NTFXUHFzS3hYMk9FZ3gvdG1PcWNscHJDWGJQWDlwWm15QVJYUlgwbzh3VmRk?=
 =?utf-8?B?Z05EWGZVQlpYUGlOZE5pM0RtekR5dEgyMzA5N2VoRjQrS1pSY1V5V1lSMFRB?=
 =?utf-8?B?RGk3ZDF1NnNQa0c1MFBsYU5xaUtBVjZkakFyazFoNlF0RTFnWnF0MWliVmIz?=
 =?utf-8?Q?TIfdg23+RH2fT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4956.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d296UXYydDNKd0dJZTZHRmdnMTNadDNVb2lEeTAzc05uNVZTR1BUVXhEUnQ3?=
 =?utf-8?B?aUs0TzAxYW5jbm9vd2ZYSG5QQjFPM0J0WDIvM0EweTJ5U1BOTGoveEdFWEZ5?=
 =?utf-8?B?eDcrcTlkNE9DNS9DTGpBTFl1SGhwK2RPVERGSE1IZUZsVEFyNS9XSVNBNzZn?=
 =?utf-8?B?UG1yOE55WDlyRCs3UDJ4RlRUcmprNVVvdHR4ZnVPYkUvM0FKeUpEb2tGVGtU?=
 =?utf-8?B?d3lFc3F6L3IyTG9aeFRmbW1pY09veVVRK0dsREtCNWtMVWxQM3hVak1XclpJ?=
 =?utf-8?B?TnBpT1h0c2tiNlYzbW14TmQ2WTJIYWZtb21aV1ZXeXlqMUUranM4WXdZeUtP?=
 =?utf-8?B?S29CTy9oWjM0dWY4MkU3YU5nQzM4dGFpOGh3Y1piOTZJMkI4MXk2czIza2dF?=
 =?utf-8?B?Z0UzcStFOEdmSkRVaktwd3ZVYUorV0pwNGd4K3VxZFVscVdlQWt3enNWcmJq?=
 =?utf-8?B?cENwU0VXK2NHQlZYUEU4OXErNVBNV2RIUlBZQitWSlUrV25GdVhxbHhkT1Jr?=
 =?utf-8?B?SnYrV01yaENoZFE1SWVhTlpqZDBnZnV0QStjR3c2OFlETFFCcXd5Y05wakxr?=
 =?utf-8?B?MC9SWncwS1pvUmRKamtxSmtlMGpvM1FlTmlZaXdSdFQ3TGgzb1ZWZTlObHll?=
 =?utf-8?B?ajY3aC9qT1BYNXUyYzY2cmI2L2FWK2taYkhabzZEdGh1NGI5NHJtSDZGOFJt?=
 =?utf-8?B?UExKOFhKMjNMVnkvTjFJdHVwaVZmcm9ONHl3QThxdXdpaElRQm5wVWJuNDJp?=
 =?utf-8?B?RHVKZUNJRElMRlBnbVRNOWE0TExHeXRhc2VkUHl4Sjc2ZU5JODltMk1XcThT?=
 =?utf-8?B?NE55OGl0MSt5K0s0WE50RTNraklGRUZydzVkckxLV2FsL0tzUWJCVTBDSWFX?=
 =?utf-8?B?WWdXeXg3WUQrZ1BodzBhYm9pdjRVaU5zWXY1TjVXaU1FaXdvNzQwb1ZKQnBD?=
 =?utf-8?B?bnc1cEpUSjhyMGZraTdEZTJ5d3NtSjBjZEIrRGE2TzhOSXJTV09MWFNueVFx?=
 =?utf-8?B?dE1Nd2c2T3NRRkd5MUZrejhSUFVzWWZQZlMzQUNjSGUzeGlQZGcxUTBIcDFY?=
 =?utf-8?B?UlNuTUt4eFh0ZGR0YkdqQjg5dHhRcWw0bzV2NXNpdGlDTHdwWktsN2xYeWph?=
 =?utf-8?B?N0xHZ1BxQ0owOXFxdTR5dmtkSkJtWVFvY1ZMOXJOajBCcUhSQXpVTlpOMGVs?=
 =?utf-8?B?d2RaTTgza2c4a2Q5ak1Vdkk2aW1TRkNlcERWaFl6cnR2eW1DcWZWZjM2cTRW?=
 =?utf-8?B?cHNSOWNqYlFvYW82dFh2cVFtQTRGNHo3amxmdDNKSmV1UVU4TTZ1TENxaG8z?=
 =?utf-8?B?SnBRak5BR0xyS2hoSHdRSzhHVGNmTnR2bzJCdmx0OVBLUHFNQ1YrSUlOWlpp?=
 =?utf-8?B?TW9FVWU5TVJwelZlRFJjSmZKblFFSllWUzV0dkpVTmFQNXJDYndncDM4UlNH?=
 =?utf-8?B?c2NCZ0dUTjdoQjdhWFpBSlUzU2x5ZVdBRjZLMFRUemxnbzBZcWMyTlMrM21Q?=
 =?utf-8?B?VUVmZUF0Z2hEaUFINS9Yd2JHRnhRWkU4N0VIWTNpVnJKK010MDh3YUhRL05I?=
 =?utf-8?B?c0M1WXBWVVNkSnBTZGJuRWxPQlJkL205V1ltQmZmSWlNNWZrVXYxSjlDclQ4?=
 =?utf-8?B?UEo1M3dNUFFYdW1SaDlvaGEveUZSQWxiQmNSekJKNThITjd4M3J2VjR3dGhq?=
 =?utf-8?B?MHdXUm1WR2NQdk5qN3M5MFNORUhwL0dnQ1orN1ZzSEFoRDF2NnIveG9kdEgv?=
 =?utf-8?B?L2plbnJ2Yk5PY2gwdHRKWGQ1UWVGd2QxL3pSdzJBcEhKdXBkV1RJcTgwNEEw?=
 =?utf-8?B?bThqbE1pdW9acGI5Z1Z6QkxnSTI4NGFMclg3Nk82d3M2QXg2VW9mM253Tkdk?=
 =?utf-8?B?VG9XZnQzL3M1R05tUld4SGJiS0dUM0xEUnJLVG1NaVlvcFBVUGdJdkNlbHdv?=
 =?utf-8?B?OGc4Q3hTL0FkNC81eVJDTGF1TWxHYTFma2IvL3g5eVpONm5PTUx0VjFOb1NJ?=
 =?utf-8?B?cnhYQ2FtUjNDd0E3RmNCSzcrQklyMVJ0TGY3dnVDdXRrVTI3RER5N2lpOXBp?=
 =?utf-8?B?Q1ZnRVNZVklqeTBTNC9xcVJMTzJHQ3lYemx3YmxtWDRLd3UyNHdUbEJUb01T?=
 =?utf-8?Q?R5uvagoMxedOsTkrSbfZ+d0KR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76766d24-c68e-4e31-65d0-08dd1fc3c3f7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4956.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 00:26:22.9097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkLCzmbXxxv8aazHyYMJmO14f6rDmvD9dFG/ls4Wq0ni/DSVDZQXcftAWJtGcS+i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6729



On 12/18/24 3:59 PM, Sasha Levin wrote:
> On Mon, Dec 16, 2024 at 07:42:17PM -0500, Sasha Levin wrote:
>> [ Sasha's backport helper bot ]
>>
>> Hi,
>>
>> Found matching upstream commit: 98fc87fe2937db5a4948c553f69b5a3cc94c230a
>>
>>
>> Status in newer kernel trees:
>> 6.12.y | Not found
>>
>> Note: The patch differs from the upstream commit:
>> ---
>> 1:  98fc87fe2937 ! 1:  7d2de1d13592 mailbox: zynqmp: setup IPI for 
>> each valid child node
>>    @@ Commit message
>>         Fix this crash by registering IPI setup function for each 
>> available child
>>         node.
>>
>>    +    Cc: stable@vger.kernel.org
>>    +    Fixes: 41bcf30100c5 (mailbox: zynqmp: Move buffered IPI setup)
>>         Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>>    -    Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
>>    +    Reviewed-by: Michal Simek <michal.simek@amd.com>
> 
> Why did we lose a S-O-B line here?
> 

I added manually RB line as per ask from last review.
May be I misunderstood something.
How to fix it ?

Can I add S-O-B line and RB line both manually ?

