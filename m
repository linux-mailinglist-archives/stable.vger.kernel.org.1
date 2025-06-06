Return-Path: <stable+bounces-151587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AACACFC7E
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 08:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40F18189856D
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 06:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560C7211A28;
	Fri,  6 Jun 2025 06:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YA4r37hl"
X-Original-To: stable@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013078.outbound.protection.outlook.com [52.103.74.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543621DF755;
	Fri,  6 Jun 2025 06:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749190954; cv=fail; b=Ms7uM6jNR2sAv/i8XGvrnTpMDWZFqQuUjldphEViFk5TxH/ab62PwPSX+dfgrdikLrhZMe9YE0Gx5gfnH4FV1j6Er0U2P2xO+qA1i0Mi0Ps0XurQ4psXj3+CF0awpFuWBRBM5zPFaLGSL3sICjdq4gVmvEx9ka4r9DPRILCkrDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749190954; c=relaxed/simple;
	bh=9g0MChXFKZSEqTBfOE1D4G6Ekags7mjpVMWxEEluNsw=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bRV/6QTiCx/ksdKQb1LtMQR5ZdIag33KpE1hKklkjU6dT8pxmELooZTNnxIgdzBI71k4FgeDMHAOAYRrMsmQzKb6Ovk4Njc9avPrM9FUh7FNk6cNziO+g0wI3oVodD3iEjM4RffkvpT3crVsuj7qorvpIk/MGi9EYdLzCNP4xuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YA4r37hl; arc=fail smtp.client-ip=52.103.74.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3bZUV2MtnteUAfHX6imc5Pj8NjGXaZuKQMo6xYSoO4cojIic8hyrPu+1aWKVah/+iTBTfTGdc7tW9uZ3JzhcqC0+i9tOxV1V06h7e06rWYoW1JgUC3i58bkINoDNebK+W2wS4T+EvLl84rkbjvq2mxxCNAN/sHz/CLTUk7ldV/cymvFbLbe06PuAlPQzVx5gIWXE/W44m2TuxXmy7tLUW5eTfPwy/y4IGT4bcpy7ZhX71TxR28g1rsmz47ZMYRZCiEbxlXCmGYdF81TMvNHmOi71aqpG6pPYOYhwrL6Sfpk4F47QTd5P2NxFwThMZRUGwL/RleqNK0J7R4oximtzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jy1KneNaQpLEu48zX8A7BSkXOrEs2balaWw13s1Lr1w=;
 b=KAigWB6qfvogdT/Sk+HM1hGbiuBwpjJKNPm6SDfhYbdmoCJlkjF2PLKpWLKfRdJEWm+UKqhGF4wTy42pOuDNHcBg7UcZ+fdftjxryRnxSYvhPG/3nfXQmmeOURokBZcAZduVpsy8FUY7tID+41zt3dhi289csAUR/qSbT8yFVFWvm0Kaok6VJN+i/dLDGbpU/3Rf/WdfvHfXwkAdBbVR45ODlB+JMXUBiL62IBwsffEiFejThrIxMahf51kLAKid3ak466CqrnN7vs89EwrrX3+HfDhP4vEfn8OIxDLwWzvsEwc8KjYAeYtjL8wEs5o/WB1wZYhHXESkXDUkXvheRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jy1KneNaQpLEu48zX8A7BSkXOrEs2balaWw13s1Lr1w=;
 b=YA4r37hlJlFlrDOwRijH/1OUdJJ7J9mxg0uMgrIAU4V/Z8zhqI84sYLuHc+KPel+d8qp/iL2wZgIRahLP2P/dn/h7SmaARPMjcLOKQ6gYanM9B9eQ8gsp1F9zqCtVBcygZfc5Kgbxyj0NpapQ2Vg6V7MxVykkxWcUOeD8Hz6MejOCoYgsXTwnAMcbCRFB2j+jC0KuogzhwCtN8Rlhl1eIauQjapbu7GA4TxYN6jShFZI+UsAiEqOCWcRn5wEd9nhDKlh6ubSwG5mrZ+WC3teLt0COrIFpaFWmdSYsbSyW9boAwRudZZVRM+cIC8hv6WcFpIFu8xlDUpBQQz3jf7mlQ==
Received: from TY0PR04MB5474.apcprd04.prod.outlook.com (2603:1096:400:137::7)
 by SI2PPF3AAD1F705.apcprd04.prod.outlook.com (2603:1096:f:fff6::7ce) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 06:22:26 +0000
Received: from TY0PR04MB5474.apcprd04.prod.outlook.com
 ([fe80::d611:1f7b:d97d:a15]) by TY0PR04MB5474.apcprd04.prod.outlook.com
 ([fe80::d611:1f7b:d97d:a15%7]) with mapi id 15.20.8813.018; Fri, 6 Jun 2025
 06:22:26 +0000
Message-ID:
 <TY0PR04MB54747B2377B780EDC1EDCD0B8D6EA@TY0PR04MB5474.apcprd04.prod.outlook.com>
Date: Fri, 6 Jun 2025 14:22:21 +0800
User-Agent: Mozilla Thunderbird
To: i@rong.moe
Cc: hdegoede@redhat.com, i@hack3r.moe, ikepanhc@gmail.com,
 ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
References: <20250525201833.37939-1-i@rong.moe>
Subject: Re: [PATCH] platform/x86: ideapad-laptop: use usleep_range() for EC
 polling
Content-Language: en-US
From: Sicheng Zhu <Emmet_Z@outlook.com>
In-Reply-To: <20250525201833.37939-1-i@rong.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To TY0PR04MB5474.apcprd04.prod.outlook.com
 (2603:1096:400:137::7)
X-Microsoft-Original-Message-ID:
 <b8d4f5c1-d03a-4d38-9bb2-78aeb95bb792@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR04MB5474:EE_|SI2PPF3AAD1F705:EE_
X-MS-Office365-Filtering-Correlation-Id: 208844bc-9f3f-4ed4-56be-08dda4c281a1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|5072599009|461199028|8060799009|15080799009|19110799006|3412199025|440099028|31101999003|3430499032;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUxnOTZ2U25Mc2t5M1B1akU4WjhWakdTK3FWdU92bkVLY1VBVDU3a0FJbjQv?=
 =?utf-8?B?TVF3aUtBWGhwbDYrRkdjOTZUWExkQmhMbzYwTVJRVE40THRYTEpueFZvd3ZP?=
 =?utf-8?B?Yk9SZG1BS2JsUFNzdmFXV2FUTTk1QjB5dXRFc3puUXIxM2syUWtSVERpYUhV?=
 =?utf-8?B?QVdxMDJkaGNnVnAyTTUwcUNEYlpuakNnVTlLV2J6WHlmNGN1YjhPdjJZeTFn?=
 =?utf-8?B?S2FmUENDSnNPR0hscG40czY2OGxTY0d1a3M0aG9mTlhGMXFlVE5aV1cvQnNz?=
 =?utf-8?B?YTNMdStCWGFjTm9UblRnY2l4Uk9MZWo0VytjNmlBSnFmbWpsdWdhZTJrQllz?=
 =?utf-8?B?Tm1GWnVsVWN6K3R2b2lNSis5NGpJNGdZOUF0bUNoWVpXUG1wUEZ6WU9XYzBq?=
 =?utf-8?B?d2FSUU84dDRWSkhrdWU0Z0lPMG9DVUVEa0hidkZmUEhVOER6RDVHRlFXV2Ri?=
 =?utf-8?B?S1ZXMHhtWkxTUVM4NHJ1c2liRE9UcXl0UVlJZ0RKakM1U0ZwQWNYcVF5NzlL?=
 =?utf-8?B?T3ZkVE9hLy9sRlk5V0pXQTAvclMzL0lwYjlweWJwMFNSb1M0cEtLMi9ETEEy?=
 =?utf-8?B?bk5pb0wvZVJoMFczdG03eFU2a2xtRGp5T2c3M0RqZ2UvWXczM016ZEVJTGRm?=
 =?utf-8?B?U2ZaRnY0cHpYWDkvVFZLM0RCV1JiRWcvanlXSFdSc0plSzZnbTJhbklYNmhN?=
 =?utf-8?B?N3M5M0M3TkRVS2tQeFUxTmR3bFlHY1NyK3VHYVdFeW4zeS9ZTUhsZUQ2RWFq?=
 =?utf-8?B?SzVveU15ZGxyOTFRbFVJcUpFcFMxanVYT0pwcHlRVzNsUHliaFlsaUxha2d3?=
 =?utf-8?B?NmEralBzbld5cFovREp4NnBKeGNyc01Cc0tLL3hOVWYybGhpeEkwSWVDT0J4?=
 =?utf-8?B?eVdVa1F3dDQrUWRTM1I2NG81aWR5OHp2eWtMZ3VZd3h0TStQVHo2S0ZYQmVz?=
 =?utf-8?B?czQxN2dKSlNyRkNSeEhIYm4vTVBvNVlUQWJUN3M5Yit5cGpEK1N3LzBGM2Fk?=
 =?utf-8?B?b2oxckJEaFhMblFoL3ppYTB1WUdhTG9TVnBKZVdNOGNzTGxVNm9rZ3ZCNXZj?=
 =?utf-8?B?K1VVME43U203QkFpdi9tZEtuYnh1SCtGNXUzNytFdG5DTk0xbytpMjFGOTMy?=
 =?utf-8?B?R3hyN2Q5cGlMeVlBOUp1ZnhIUjBxZ21uMDRqZ0NXYzFTcS9WM05HeVM0cDRY?=
 =?utf-8?B?bmh3Q1o0NzJDZEh1TVU3aGhiaDFOZTVEc0p0VitJc0kxWW1YY25OdXBVVFNw?=
 =?utf-8?B?N2JsTjRVQlVUU0Jva0sxbUJMdDRvdEI4b0xTSVQvTUx1MGttcGptdkJQa2k3?=
 =?utf-8?B?SG5LdmVneEdTYk1aV1krYXI1TVd6UXRvZTkyekZhTDlUOE8xbDdEcG1HOEs5?=
 =?utf-8?B?aWhuLzc1eWRGT1lJeGd3OGlzakg4N1VJUnBWYUo4YjFFajBvUDAvNk9BczRY?=
 =?utf-8?B?dEJJT3pPK2wvWHF3ZStQRTk4N2xOQWhWYkZJWDBSQnhrQ1pUZGcvZ2p2YWRl?=
 =?utf-8?B?cURjZ01rVm1QRVNzVHRDQmtQb1p1VmFNUkhEbVlqeEVKN3RWL044WnlqUURP?=
 =?utf-8?B?SkZUZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEZEazFURTFBQSs1dFdWd05ranViQ1N0SHltd1Z1b2ljcngxczFaNks3eGg4?=
 =?utf-8?B?MkUyWXp4ZXdGYTByVzV0eS80MDFnWCtaY1RNemFkcjI5ZHVXdDg5bU0rQnR2?=
 =?utf-8?B?UWVUanl4T0lGeGVlRUtEYUhVYnErRjZLVHVlZ3dlQ3doQjlDRlJIV294V0Qw?=
 =?utf-8?B?c2x2U0IySGk0eWQ4bUdwZmZNTlg0OTFTV1oxT29BeUlITG5MR1pRNFI4YUhS?=
 =?utf-8?B?eStvVjA0ZDlTQzNlZHloT3NnY3d4a0JqdjIvQllGZ3dZdHIxQllTUGpzLzA3?=
 =?utf-8?B?cTNUb1RQSGRMVmg1YjhiMHE1S3IveS9DODhVdVVrMjVBR1RNVUVFTlE4YkRp?=
 =?utf-8?B?amhCVDB0b0hmZFkwN2RwcWhMRmtjQnc0RkVTZDRHQ1lKbHlZLzFzNUhTU2Ex?=
 =?utf-8?B?NWt3R1hsKzlRdk5hL3Z4dGM2c0JuZ2VzNk5CSmxYR0pjanlCZGpEOWFNWG5i?=
 =?utf-8?B?eDdyZXdtSWRnRHFnSjRIMWk3eHoyMEl4T2VDRXg5QVRWZ2JzTlltY2Q1TG1v?=
 =?utf-8?B?N3p4eFVPU2EwRG1EcnZuWTdlSndYM2ZSZGlpRWg4MC8zbE9Nb1MyazlZc1Vv?=
 =?utf-8?B?aTNPMEZEN012ZmNja0QzMXNnKzBXMHVuajAxdnVwRkdheDFQbkZtVE94cGZL?=
 =?utf-8?B?QTlCYndia2F1TUg0QmJRU1lVQkdtTFBVNWM1TzRBT0c2eEFpMnBjY0p5NmJz?=
 =?utf-8?B?K1BCNDNRN25vaU5TZElhY0EyZFJsSGFWN1ozRjM4NDJjblFxYUtZdmNjcG9p?=
 =?utf-8?B?RnQwRTYrVEgvc0xuVHk3RjJYNFZSQjJJWjFjbzR2MnNJVGVDTEtOaExieWRH?=
 =?utf-8?B?TGtVYXpRejlYNGtYeWNSaEY5RDNiYVdOcFcvTWVzQkFVMTJ1YUw0RGlveTFQ?=
 =?utf-8?B?U1JqeStaaW1EYTQ1NEc3aDV6NUx1UlVGRGFDZXFORXlQR0JkZElIVUxxbDdH?=
 =?utf-8?B?WExGaGk2WEZWSjJrVjFpODd0eCtYUWhkM1gxWGhxbWxCcm9PRk0rSFoxS0hz?=
 =?utf-8?B?cndsQm95OG1iY1pKblFQR2pvdFd6Z0Y2SG54TExaMWJ5OUk3K3MxVytON1Nn?=
 =?utf-8?B?b1RjN1p5djh2VXdUUk9ZVi9Ydk5IZm5UMkNST3IySmFvZ2xxQitDN0R1L3Rl?=
 =?utf-8?B?SndockF3SXFRVmNTclhjRitjZk04RngrZ2U0Rk9zOEM2djhiR3BZL29GWE5J?=
 =?utf-8?B?SjB2TkRiOVkzMVJzY0RBdkNtNmhGcUdQRDlDeWV5SWpBZDJwQ0VuSFFMcXp0?=
 =?utf-8?B?WEY1NmVHVkxSYzEvM2hoQmVBSFU0OUFiSys5Y2dVb0FuaHJyZlR2UGc4NVJJ?=
 =?utf-8?B?dHpydTRtSTFmVDhybDBjYll1eFZTZHVaTE9ENXNhTDkyYmNQUjdFamo2eis2?=
 =?utf-8?B?RzdIREp4VlR6cHBFa0MzaU5Bc0E5ZlFCMUZ4czRNZWZ3WHBpZ1BnZDBiOFJT?=
 =?utf-8?B?alZ0MGw4MUhKc21iQVZKYTZkL0oxVmVNTUxsZnNNNm8zRm9pNkFzeWRWV2JQ?=
 =?utf-8?B?bDVCOWRMZEVKZEl2Rng5UEp4bjVENWdyRmkyNmNSeVNXZEtTTzh2TDl6NHVl?=
 =?utf-8?B?WFVoeWh4bTdVRzhUTitrSHhLOHI5Y3RSQkp4Mnd5dEUrMGZlT0s3Y05Nak16?=
 =?utf-8?B?VHJKSTZMbjFJMEpWVTdnVlMxeUZyMzBtOUFqWExOQ1RYK211empneWEwaWdu?=
 =?utf-8?B?OWxSMGtSTmhzZHpIWTNSbFE3NEhYSEtldDV1d3AwaStheW5lV3VwSG1Qb2pm?=
 =?utf-8?Q?j3WIzffhmSbeioWV3s=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 208844bc-9f3f-4ed4-56be-08dda4c281a1
X-MS-Exchange-CrossTenant-AuthSource: TY0PR04MB5474.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:22:26.5655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PPF3AAD1F705

Tested works fine on my Levono Thinkbook 14 G7+ AKP (AMD Ryzen AI 7 
model) with:

- frequent Fn+F4/F5/F6 inputs, having a more sensitive response

- close lid and suspend on plugged in and using battery


Thanks for solving this problem!


Tested-by: Sicheng Zhu <Emmet_Z@outlook.com>


