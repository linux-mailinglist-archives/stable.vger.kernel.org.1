Return-Path: <stable+bounces-93027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F8E9C8ED2
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 16:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68633283731
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 15:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FC2757EA;
	Thu, 14 Nov 2024 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZlzHZNK4"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E883F1420A8
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599447; cv=fail; b=WJX5T2Hp/Q1juB+SHfYAmg8u6d2SmalKmMjDCpyoNhzuEXggSjbhUisWt48z4FkZrdpWEtrzSj3ld/MyVn5swN1J2dI/Esdntui/SI+EciLiRG/2ouIMU1brjntSrUsUJbdm7iaUaPSrgt+sTxWPM/Jlr68VU5wxLGPO6NfRjGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599447; c=relaxed/simple;
	bh=mS7tz+LQ0CrYP2aDdrR/LysZazx12TV/WTGeZGmaDPM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mxAGL+1rYGLbBDGtRrwtCQ1ev2xsyZPb227aIwJtu9SyvBzeLtBoj94jzMMl4TKM2Wlp09FKOLUzcV8yudZY4rvPsvn7K3au4AcryXopL9R77FP8wTUoy/wzJ3Ix8mmTX7koa7WPFUc+L/AVCxoqoyfWB9M/Zdj+ukqnGFtR8+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZlzHZNK4; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/kL73Rw6iqjagzfxiWb62c4hMioWdX1vK/WxxFZ7aCfpOYQwnfQKWx+WnnskmdKwlO8hHaArCmaf6tG2ZagTnrq4VKONR8HsjpVPvXhBtTwl8zK62jWYQIdFWN9UG6kkXq8gvPDxaSz59TGg+/Zzc2aGnZAL8Cn7DWA6QZc86aH87cjvczIJkz1kROT6a4xxHQO8anYTiekoH76M7Dyxu5RISLOtEXWDZ/HEgwZtoOgHEwbV0sD14+gN9SmYn4LC0G5GWOeEIe8/c9t1sA6qtYQXc0nfeY6FVK1tG40tGZwdzKLzDTZy71HZhX+M9AgLvVNGVrCbOahxOsydaL+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qg8A0y8mbqowaUvxX6WOi8Ch+lKb6Gm584maI0owTiE=;
 b=fPij21VwhpazP2GekYoOaYTFRt0B/FVSUpzPr+pFkLOwXLLSxKK3RvknbUF7p/7Qk/wJONsdzCYmtcJLY0ckl2gSU4SrTbq4eudSFYTlsrKcV8i40Tm8Qfhq4Xa/uKWgMg96SCIJ6mtZpP2JFEa+ZAhk0TFABfidU/QqtMYeI4yuPtfh72JZSoxvZWxefM9FXSouPKEaIyY8ynHRetTMBoNVAA7zkN4W8+znYYyUHOWeUQwgBcgEm/91Q9CgIp1RfIHAmcS+XDej+PUTzNp5iX1HEMTNFVm+eEL7h9VVSbTE5WlIzLhVzcCCF7Dw1g1c9um2MWY2Xnmskd7jvT3mKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qg8A0y8mbqowaUvxX6WOi8Ch+lKb6Gm584maI0owTiE=;
 b=ZlzHZNK4tPHBA02cRDFg0f8f5EiSKyLReyIzdcyqTWt4RekFx1qYqufnSHeTMFwU4Z1tw9+oEqZqOZVVsH/dt588a9MQalCR+9iQZTWErIuYjA7rYlK/DJAgcsZuop6MynOTsEgMuGY0ECfvQQsAv3ObaqSIpj+gzPktNIK+u+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by DM3PR12MB9389.namprd12.prod.outlook.com (2603:10b6:0:46::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Thu, 14 Nov 2024 15:50:42 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%7]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 15:50:42 +0000
Message-ID: <2338a37c-33e5-4741-80b6-64a04c3df1aa@amd.com>
Date: Thu, 14 Nov 2024 21:20:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix UVD contiguous CS mapping problem
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, stable@vger.kernel.org
References: <20241111080524.353192-1-Arunpravin.PaneerSelvam@amd.com>
 <81849d7f-f1e9-4ace-af5a-7f36ab5f5c22@amd.com>
 <26165549-bb0c-4d6c-89b7-273648ff4512@amd.com>
 <e5aa5895-5a6f-4620-8537-dba03f91aeaa@amd.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <e5aa5895-5a6f-4620-8537-dba03f91aeaa@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0165.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::20) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|DM3PR12MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: b5fd70b5-da0e-4183-14b7-08dd04c417e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzR4NWJLSmsxdEt4V2IrS0lFQnFCTkZWNU92MXhlcmVXVXlpdUl0NWIrWEhm?=
 =?utf-8?B?eWsvZ040SnoycHZydDhZM09uTGxMK01hZHVOOUJtK3FUbXdkZjQ2THdUZk5I?=
 =?utf-8?B?SmF2NW9rcW9xcUE2b2xrbEJvTzFOMHljc0hrYlczTXBMdTJtQitHNHBxMGgv?=
 =?utf-8?B?VHg3THBjaFpTeHRzYkcrTWx5ek1GMGtWM24zdE42Rk5Cd0RMbTdXUTE0V0Z6?=
 =?utf-8?B?cW1LaWdyY1hiU0FjSGFYeEVQZnYyUmFNa3hLLzUxZmVhV3IralR5VnpZdWNV?=
 =?utf-8?B?ejl6dkQ0L21ub2dJaXE2SDdvc01sNGVPT1hnNktoZklXSTJtSUdZUXBiTk9Y?=
 =?utf-8?B?cTQwaDQ5NUQrNnJUeXRNb1hDazNmVjJsdWZuQ1drUFE3bG1aalU3bzN3R0Rm?=
 =?utf-8?B?N28rK04rckhrdHNuVkpaRHNha2hhUWkydy95MWM4ZTE5b0R4Q1RGOGRRUEFD?=
 =?utf-8?B?T3d5NjZEK0V6Q1hxdng3RVc0S1Z3NlU3eGRxSkE0Y1dsWnVyZUpUaTYzemtG?=
 =?utf-8?B?ZGE2bFpRZW1HLy9POG5BZzhOcWhzd29pQXgyTURWZmdldzN6dW8wREVuemEw?=
 =?utf-8?B?OWxYQ24wbmh5eU9LZEJ5VUk1emQ2S3REVEYrcnhoNFB0dk5DM2xXZEJJUkZn?=
 =?utf-8?B?QjdEeUpRVW9lVUFZc1FDR2Vjamw1RjR6TzNIN05JK2FUcXRKanIxRndtZDhr?=
 =?utf-8?B?dDliS1hldUNxblFCOHQxSmJlWFI0UWpvZTlGWDBhcmZWM0ZaWlhSbFNQT0t2?=
 =?utf-8?B?SHRjdGRHU0VzOXJuQk9BMmFTYzhIUXFtb2JCU0RuSnA3M2RmaFhPa1lBdmda?=
 =?utf-8?B?ZVp6S3JMNVFORjlKbVgwN042QkhERE5mWG9XNmpRMlRkcHpkbEo2YVRXOVJ4?=
 =?utf-8?B?UU1Deno4ME5vNGorZWp6ZUxLb0l6UUwyTXFxOG9Qai81Y0wvbS9WU05FUGJC?=
 =?utf-8?B?VE5xTTM1Rm1zUmRBMC94bjBBRXZ3azVvTThBbGdicHk3VFljQVFYVUIzaVdj?=
 =?utf-8?B?emo5cHZSaUttVW9tUW9FclY1QTZhSkNFMVhpSTN3NzMxOVdBR0FCRDF0eUNn?=
 =?utf-8?B?VW9rcC9rcHZPME9hT2dxWHMzakdXWlNhUEltclU3Q0lQaGI5S0RTb05EQjBE?=
 =?utf-8?B?Ykhob2ViSVRxaXRFanUxN3k0aHpyZVRtZ1pia24zZDUyYWFLZFlyMnZsck9W?=
 =?utf-8?B?NCt2V1ZRSWR4VktwNlBaRXdOcGFxU0UyVUg2VXEvQzc0UlZTclArNmgyclNG?=
 =?utf-8?B?cUQ1bSttTldHRkYvbWZzZlVJUU5BMUVSQW0xQzcvYTQwZGhxdVFzRXNXR1E2?=
 =?utf-8?B?ZVVPOGdhcVZVYUZjM3lxV0hwQXh6dDJCR2x2aTF2Vmp0M3ZIdUtPUTliMnlu?=
 =?utf-8?B?eHZTYnNPTFpyYXQzOStJWTAzRnZXNGVTZjFBQkV4MVpPaDBGQU8yZ3lSRW9u?=
 =?utf-8?B?SGYyZDBWWi9yLzJQdlhwY0dzcW12MzE2dFZSeXhxVCtJR0ljc01GYUhJRHJu?=
 =?utf-8?B?WkNPaUJPelNYcklMMjBoNzNvYThPdncrbHljRU5XdUlRbUVZc1duRzBWL25O?=
 =?utf-8?B?R29UZ2I1ck1oN2hlTCs4NXhKdjBabFpRZExqejd5UHgzd2x0bmNLWGp5czVV?=
 =?utf-8?B?T2JQaWpQRjB5WDl5YWFwRjBvWEYwdzljNWFRU2NiR2t6K09IcWpxcC9rRGx4?=
 =?utf-8?B?aVZUM1Z4RlNZeHkwai9ENEJMckNySjhzaVlKMDVIT1doZXg3SzlIV3R3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7301.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnJlSlRFZWtEYm03KytIa3ZGeGlpaG5sdVlPZnBaTG5hSmt0M3BrWkUxcWpw?=
 =?utf-8?B?NmFZOG13U0FickpGb2VGZDFZU2FzTXpweUdTRjVZalFMOXhzbW9CcmRYakZ6?=
 =?utf-8?B?L3pCdDBQdXNyL0RhZENveGVuaTV3bVI5NVlxMlZTNTcwR3BZbnI2d0pSQkZu?=
 =?utf-8?B?ZEZySWhGbElhV1JlUWxzYXRPZ2xRN0trWmVQZm01NWs2V0w1VXVQci9JbDRX?=
 =?utf-8?B?TnorbkRML3hxQUFYd1lSeldKS1MrU2ZJakNUeDJZSnpHQjZqc2I5UVBtbVdY?=
 =?utf-8?B?cHI4dUtHUStWS1VQNlRWd1dzS2d5eXpOaERkT3ozU3FDb0NpaVdJTDcyMzhF?=
 =?utf-8?B?NTlPSHhYMDA2Y1gzMldUV1g2M0ovREJBcEtLZFVRZGNDa1U3aGhZdExiV0Jx?=
 =?utf-8?B?VkNUZHpIbkZuVmoxQTZWcFozSFJWalZJUGxZOXBNR2svSklYVzhWc2QxS0kv?=
 =?utf-8?B?TkFCemprekRQR2kwOE1IWkp3c2VOTlZTMWRuMUhVYmxDWU1wb1NPMWlBblBq?=
 =?utf-8?B?Z2c5TE5xQ0ExWTd0TWtmM0xiYTZ1aWNPUW04SStYZ0N1V1NBWXc0aTNrbWts?=
 =?utf-8?B?UUFoNEIrY0FxeTZwdGNHR3A0SDRuTCtqRnIzQURrbnV0VzJhcDFueG1hTjY1?=
 =?utf-8?B?L0YvSjVkNlVrYUhRNUQrMUgvWU5vQTZSekh0cnhqci8zbFovZUQ4dVVIQWVo?=
 =?utf-8?B?c0pVZkdlcEdWWHNuYnp4bTQ1RlVNanVpQ1ZPRGN6RGtoT0E3Y09weks1ZHJ0?=
 =?utf-8?B?TmN0TDZzQlpLcWVHNUZObTM1cmxTaDMyZklQeGxsajc4ZVZONm1OWVFTWWE2?=
 =?utf-8?B?RnpxSlNLOHZSdVVXUzgzMitFUUNiUTl6bU9yeDQvbXluWHBLQk1SWlNUQmlN?=
 =?utf-8?B?SGNHV3g0dHY5ZXRIMWlFbzVadHM0ZjBrT0I3d2Z3Z2ZiQTlZZGNhR1o1dUVs?=
 =?utf-8?B?ZTNPTzJhMDhRaklMaHBUQWZKdDVScEhwMHU1NXZJbC9xbmhtd0tuWnZiVHNp?=
 =?utf-8?B?QlNUMG55eTBFb3BROWMwTjlBamR1dHcwS3hjdWtOU2FmN3JDdU1DTWF6RVVq?=
 =?utf-8?B?cXRNbzZENTBtN2dFbklPQi9OUWV4Uy9MQStQRjFqc1k3WG9oRTFLQi9NeDFD?=
 =?utf-8?B?S2tLZktodTBFbDJiN1FXT0hiOVNOcFc3a0t4cmlnWTBYS2Y2cVMvVEVQVFFJ?=
 =?utf-8?B?S2hHRndzbG1ibnNlVHVOUEt2cXpHcDJrZ3QwUTZhZldWNGxRZlBwa0VvMHNs?=
 =?utf-8?B?QytZSmxGcWl0NHBRM3loMFEzSENENU1qWjlocnJTQ2JIRjd3RXlXYkhMUEo2?=
 =?utf-8?B?QVRSTk1DbWdycGRINFo1Ry9UV0VmbzNHbGtaWHBFZkRIRTV3Z0ZNam1XNFpu?=
 =?utf-8?B?RGJGTVlZVmVqZ1RkckQxeXI5WGhwWnJDTmFFV2NmV3JpOEwvNFF4L3N4NTVu?=
 =?utf-8?B?ZlJRSytzQzlBMU41c2RsbGlIdkUwL2dFbDVQS0FvMHRPemdqWWlJdXhuOFVa?=
 =?utf-8?B?VzBDMDVqTllMdkwwSnlvcnQwaWZiS01DMDd5dkhjamdzdElVWmpyaUtMK2F3?=
 =?utf-8?B?L1FXeThkTG10b3g3NHJyYU5iS3dOMmVZV3QxUWY4cUtzL1BLQUttTEsrQ25V?=
 =?utf-8?B?Z0ZoQ0c1dXhUaVRXN1RhQlhZRmZIZ3hDOCtrVVNyOFR4ekVxWHZLSW9KdXJQ?=
 =?utf-8?B?cDBLd2xZNndoTk1iM0ZET0haM09BcUJvcFNGY2lGY2F2MWhoRlFEbnk4R0x0?=
 =?utf-8?B?ZzlEekJGVmpqOUpSSmlER3dHQXdjQXAzdGFKb0txQWFWVjljVWZvVkdNYXRG?=
 =?utf-8?B?cUpnYUFoV0kyZDZYejVLbnE1cXN1aGJNZ29HZy85ak5Sc01mNXpOclJaM0h5?=
 =?utf-8?B?YmluNnlqMTdUL2UxWEI2YWpsUVQxdTBFK0lhQ20wWWF4SlpFNmY1Q0EweE5D?=
 =?utf-8?B?eStncU5LNFR3OVhTRUhiSzFHQ3hMaDNwcGV1akNKT0N1OS80LzljTDZ1bi9w?=
 =?utf-8?B?Tjh1Z0R0S0ptSWltQ2RSMkdCajB2VWRqL1NZeEV4WVloNzlIMThacURsTGJX?=
 =?utf-8?B?MnJ6SUd4T2tCREp6MHhXR0VxUDI0RlgrVmhOWGZwdURTVXJhNFZMTUptemEz?=
 =?utf-8?Q?o6BJARahlKK5yiaLbIUWZaYR+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fd70b5-da0e-4183-14b7-08dd04c417e7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 15:50:42.2179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WMBJbLp/rX6eC/D8yuAbKXyDB/gE/n8NydzAcqfOyB4gv5k2mXSb6kVjG5rj+r8sy9OvrnH1ToSL8GAKmsdBuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9389



On 11/14/2024 9:17 PM, Christian König wrote:
> Am 14.11.24 um 16:38 schrieb Paneer Selvam, Arunpravin:
>>
>> Hi Christian,
>>
>> On 11/11/2024 3:33 PM, Christian König wrote:
>>> Am 11.11.24 um 09:05 schrieb Arunpravin Paneer Selvam:
>>>> When starting the mpv player, Radeon R9 users are observing
>>>> the below error in dmesg.
>>>>
>>>> [drm:amdgpu_uvd_cs_pass2 [amdgpu]]
>>>> *ERROR* msg/fb buffer ff00f7c000-ff00f7e000 out of 256MB segment!
>>>>
>>>> The patch tries to set the TTM_PL_FLAG_CONTIGUOUS for both user
>>>> flag(AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) set and not set cases.
>>>>
>>>> Closes:https://gitlab.freedesktop.org/drm/amd/-/issues/3599
>>>> Closes:https://gitlab.freedesktop.org/drm/amd/-/issues/3501
>>>> Signed-off-by: Arunpravin Paneer Selvam 
>>>> <Arunpravin.PaneerSelvam@amd.com>
>>>> Cc: stable@vger.kernel.org
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 18 +++++++++++-------
>>>>   1 file changed, 11 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> index d891ab779ca7..9f73f821054b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> @@ -1801,13 +1801,17 @@ int amdgpu_cs_find_mapping(struct 
>>>> amdgpu_cs_parser *parser,
>>>>       if (dma_resv_locking_ctx((*bo)->tbo.base.resv) != 
>>>> &parser->exec.ticket)
>>>>           return -EINVAL;
>>>>   -    (*bo)->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>>>> -    amdgpu_bo_placement_from_domain(*bo, (*bo)->allowed_domains);
>>>> -    for (i = 0; i < (*bo)->placement.num_placement; i++)
>>>> -        (*bo)->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
>>>> -    r = ttm_bo_validate(&(*bo)->tbo, &(*bo)->placement, &ctx);
>>>> -    if (r)
>>>> -        return r;
>>>> +    if ((*bo)->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) {
>>>> +        (*bo)->placements[0].flags |= TTM_PL_FLAG_CONTIGUOUS;
>>>
>>> That is a pretty clearly broken approach. (*bo)->placements[0].flags 
>>> is just used temporary between the call to 
>>> amdgpu_bo_placement_from_domain() and ttm_bo_validate().
>>>
>>> So setting the TTM_PL_FLAG_CONTIGUOUS here is certainly not correct. 
>>> Why is that necessary?
>> gitlab users reported that the buffers are out of 256MB segment, 
>> looks like buffers are not contiguous, after making the
>> contiguous allocation mandatory using the TTM_PL_FLAG_CONTIGUOUS 
>> flag, they are not seeing this issue.
>
> In that case we have a bug somewhere that we don't properly initialize 
> the flags before validating something.
>
> I fear you need to investigate further since that here clearly doesn't 
> fix the bug but just hides it.
Sure, I will check the flag initialization part.

Thanks,
Arun.
>
> Regards,
> Christian.
>
>>
>> Thanks,
>> Arun.
>>>
>>> Regards,
>>> Christian.
>>>
>>>> +    } else {
>>>> +        (*bo)->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>>>> +        amdgpu_bo_placement_from_domain(*bo, (*bo)->allowed_domains);
>>>> +        for (i = 0; i < (*bo)->placement.num_placement; i++)
>>>> +            (*bo)->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
>>>> +        r = ttm_bo_validate(&(*bo)->tbo, &(*bo)->placement, &ctx);
>>>> +        if (r)
>>>> +            return r;
>>>> +    }
>>>>         return amdgpu_ttm_alloc_gart(&(*bo)->tbo);
>>>>   }
>>>
>>
>


