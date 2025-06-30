Return-Path: <stable+bounces-158952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2063AEDD7A
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 14:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970FF189CFAB
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 12:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74A72459EA;
	Mon, 30 Jun 2025 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="oF+IbDXU"
X-Original-To: stable@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011032.outbound.protection.outlook.com [52.103.67.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55DC26F463
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287768; cv=fail; b=ccOfSy3xggpd/knfHtdAOkLD5H4FLCIzdoEDw3H8GaaVK8WlI98C3NdTkBdfeNNm5oMiFAz8BcMFK6yuAPN0faMFE9TuQNmWT7OO7+AEvEClwHrjL9JVKydwn2+7D2r9TCwRQqKoKpvlKtdOFB0uLs7c/1dPw5Ng0jqvxcEaZgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287768; c=relaxed/simple;
	bh=E3t9Dod0Sl8z34YCVUTZjsLu7KM5wGMJELlMSWAnpn4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ATj4jEEW+LUO3GqEJ+gSP8g29cFBrlh+ye0DeH74rz4FMSebz4ZTvg1p87rFfHfDKYy7GRpNs0WLW6wUVLp3O2Zqh6T+UifrXGcrlZN0CQl53g4HT4VernHoFSQ3bi/oCkYLJxeVLJG+xiCzXkJxK+wM4rK5bGGfFrgkBeK5Tgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=oF+IbDXU; arc=fail smtp.client-ip=52.103.67.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N339gkNGv/sI5A+4cQWkfzAhbNZzCYYibJ8AgTxjwoHnU2iKzbiyKwpIJ0/N+ABH28B10vMgfmL6qxBL+UKvh+pMgfSh9RFB1Dpv5uzbofcIy5HxO3bLLKiQ2QKUq2/ztWq2H4s2Mv2xAF9TGuRBDuPGLPet2ySwoufuA/ZTc5zsvWjBtlFh2P2euw6AxRax14SxOIMTbyfmyxiwCexQJzfpWyw2v+jQ325dTDVOouHEl764FzeysthPaVl3eH5xo4ALuIQ14ZS4QnZZeCSzaqAv4rv+rI9q27GrZygAx+cykvC6EF9F1eGCnVtUoPwBgkr/6PYFCBz8iC7pDYmOVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXlUVCf/VrdeTzWuoqPW+n2xPq84VzTFnUFALe+XABg=;
 b=ouffAPx7M2UDnRPBgrgHEVG/dswJv8Iw7XyDeOz6XLwDo7nU9C2I3tgjswi0Zv91vOaHOID3/NDgz2ZvlJvzUF2y7zOErpE2EXSYyAjvyt1cVTvbIFyMxnPHr2rih8x5kQHUx5E6hzPH77uAe5gCqn/yuLo2N7+bOB1vbJI6EIzUBCBdUoVNRrJQKzDbG/qh7tZHirFF/21o7dg+ZjzmKl3pFsno0etv0hHpI7qOtEOkTMFuLMXh0BiwaEzXIxJrc8i80BWESI6UzWu8kSf+x7TlLsrME2uezxav/PG+w1ab10V38wA23BezSJzyKfElQJjrvtHtuwxb7Q+PePNcyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXlUVCf/VrdeTzWuoqPW+n2xPq84VzTFnUFALe+XABg=;
 b=oF+IbDXUvSGg/B8SvP20ay94bX9DTp7y9hwnFqqfnwkUDDhXpxaXm3m2Lig1vaNagkVjK/soZELPRzStFMzeeSG2ZrQCZzZgEr3EifGnyFxAVAX+C7wj9SMgnNfTo5b5f2+bjfq+YlqvYPH6uezXHTPe2+06TBB/ZHxwedQsZQvmd6o/trYDOCS0rSNIRUS8C366SG5ov3CAa8abSE0Som2/P+4DC2eqxdv36EAU+F4N4ltV9vczwEGcGHO8HoyEwyL/KDCAICSOQjePt9HAid3zSOW7ps2TSgtJgIftFBQhqua7S/RJwLQVdrpSEOAevv59+OidR3d2YejFpJxj1w==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB7033.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:1d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 30 Jun
 2025 12:49:21 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%3]) with mapi id 15.20.8880.029; Mon, 30 Jun 2025
 12:49:21 +0000
Message-ID:
 <PN3PR01MB959797E4DAA77FC63A819E4DB846A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 30 Jun 2025 18:19:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] HID: magicmouse: use secs_to_jiffies() for battery
 timeout
To: kernel test robot <lkp@intel.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
References: <aGKFmxZ-CkXYFl0V@617460b90d88>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <aGKFmxZ-CkXYFl0V@617460b90d88>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::28) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <e5f58874-3296-452c-a0e5-febbf0decaad@live.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd972df-cbb2-4af3-e45f-08ddb7d488e9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|15080799009|461199028|7092599006|19110799006|5072599009|6090799003|1602099012|52005399003|40105399003|4302099013|3412199025|440099028|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UktXalhhWStwQzR0UERSRXFWNzk0aDd2TjhMM3E1dmVuNDFXaDVCemNOYldC?=
 =?utf-8?B?dHJOWDhpMElodTJkcmlOSXFrQTFxQVJ0NWR1YXptcTltL3pQM2VWeGlnSzBK?=
 =?utf-8?B?RG1pQjdRQ3hKM2xuN1pycTNkdWpTUWxQYlBDeXZicjhma3RVd25Qa29IbFhZ?=
 =?utf-8?B?VU1kM0xXQWdnV0RjM044bmR6UWw5OFVuZ3RxZmZVRTF2VWh5eCtsZndoeTQ1?=
 =?utf-8?B?cWdjdVY0Mjhqbk9SUGxZaWhpbU5VZVc1OTFMRlRISkZKVWYvWDY4QmVWWXo5?=
 =?utf-8?B?bXBZeHlHc2pvWlZlK0liT1A1SUNZTWw2Uk40YWNwZUNoYWFBbTJHNGorTFA3?=
 =?utf-8?B?SG5pQThzMWJsQzY0TXVUeEFtWmxiVkNVSVZoSlJrUFhFVXpGM0tPNWwwanFs?=
 =?utf-8?B?d3VobGNxemE5cFZEWnFOMGRlV0x3R2grbEF1d1VTbkg2dTVvQjVRN21UVnZK?=
 =?utf-8?B?VjVzcjBpbW9jNk5raVhJVnY2WEhSQnFXSG5kenJJZERLMC91d29tZ2gyanRl?=
 =?utf-8?B?R1gvVGF4Nkcvb3ZaeGcwdzBCYkRkWUhkV05EaEdJNXdQbER0N3E4dTJKSzdw?=
 =?utf-8?B?VmVieXR3bWtOSmh6a0l5SW9sQ2JVR0xuSjlPZm1GNmdwZjNEWjdhVVNJQ3hi?=
 =?utf-8?B?T3VqN082SnFHMzdLYkVvSGIrVGlsYXQ4cXZmbEpZVjVNeU9WdnZCV29UNFZ1?=
 =?utf-8?B?d09Gbkd3Y1F0WGZiRHhORDBlS0NlSy8wZFUwYndqTnQzVnJHYUNnNVlNYUts?=
 =?utf-8?B?S3dFLzRCUFA2ekdzZWlmVTZPKzJhQUxkamJOcTBOUndUMTkrUGxYeFNLM21m?=
 =?utf-8?B?MVRBUHJjYmdwNmhKNWNIUXc3TUFHZE5lZktDREEwSy96MmR0SXJ6M1JQWHM4?=
 =?utf-8?B?WHZhN3dpV0l4UGtWSS9qMWZERTNrZ3BjNURoOXV1VnJmbTBLcC9NMXF3OTlB?=
 =?utf-8?B?NndWdC9aT2Jmd3JnZ0VYemkxUlE1WFMrS0ZiY2I1K1B5MnVySnN4VGd1TnFG?=
 =?utf-8?B?eEMrYk1Cc2ZkMmEzTnJiaThhVzEvQW93Y255ZmhKU2FVMXFGQzZwU04zUXZL?=
 =?utf-8?B?VXlNNmhpNHd0QmRvUWxabXFsRXpXU1E0blRPNlVpeW9aRmxEWWxDVUNJb2tj?=
 =?utf-8?B?NVovTEdROUlhZFU1cnJnSTloSVZHai9UeGRLcEVXS2VXekgxM29lZXpKY3pi?=
 =?utf-8?B?MVlldng2bmJqeHZiNWUvcjRrUi9hRWw2T1Q2VzJTaWhMSnRuZ3NFbG1aMk5a?=
 =?utf-8?B?c3dUL2xZY05NRzhhWEVZS2xEd1RGS0Zra3loWGFlc292YWJYMHIrUFg2dmtw?=
 =?utf-8?B?T28rd2FjazdRYVE4aGlUK05sbDBLK2pjZXJGRnV5eG5HK3Y2K0dJZHMxa0ZI?=
 =?utf-8?B?SGlzRXpNMmFXZ0hvRk1wbjU3ODR5VEZqc0tDODRRY3NVL0xxWXhqYlJ5SWo3?=
 =?utf-8?B?TnhpSXpWMzI5bGxBREp3S0Yrb3BNTC93SW1ROHFWSi9EWmIvbTZUZXJOcUJC?=
 =?utf-8?B?c0tiTzluRTJBZzVNbWEwUXd2VmxZcnlxS3ZiU29LY3gva1hHZnhpQURoQ2sx?=
 =?utf-8?B?ZVhNdnI4TkQ5VUJ1MHpBVjlDZ055eWcrNXp5eUcwcG9Ldkc4VjMyQ2pKTCt3?=
 =?utf-8?B?SnlzQjdMdG1iVndUdXlFS1VRbERHbjlIYzZtQXhYRlo5MlBHRlorNDBSTFc4?=
 =?utf-8?B?YmdQV2RMVHNMeENVbSs2NFBlZkJHUkIrSXJ2OUpMM2plS3dIREJpbkpSS0k1?=
 =?utf-8?Q?tKGhv33dWL61gKoM9Q=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEQ3TlM0eERucytHdnZyanRrYkRwL1hTeWZJYWN4TUg1WXg3R2lDVWdhVEZT?=
 =?utf-8?B?Z3pTcFdXbjEwSHh0dlk1WXpKSy9CUGZaVllIRFR5dGF6WFdBYUZyaXdMK25Q?=
 =?utf-8?B?VFhEU0V4L0ttS0dManVPUTRpNXplWXM4eUkwYVdwZ2tRcDFQSTY0bnE2SzFy?=
 =?utf-8?B?RU50c1NFU043SjVPY3JtYTl3SGJaeDNnNTdQVmZKNUxDOVhOMGNDTG5DZ0xR?=
 =?utf-8?B?TklpdTV1dXdVVm9LdzJyTVovM1VsL0JtKzdzU25UT0lYRTlVWWlMYXBCOWtx?=
 =?utf-8?B?c2xNWlNTS2VsMUNOYWhxOWlsZTRlWWprb0Z5OVVTVHZlNlZvWFVtanc2bllZ?=
 =?utf-8?B?TTA2TkRPNkZCOUpFTE11bGIxUzRYWlNaa2xjQzMyNGUrSkxTTE9qWFQyVDlC?=
 =?utf-8?B?QTF2RkFPakFCMDAvZTMvQ0l5TVRHVVZ3a1hET3Rub3FRYnVmNlRoRDNnSGtk?=
 =?utf-8?B?RGJ1QXJPaU1GQzRmNS9ZaVNXUThXdHY0alZMS1FrU2M5ZXlHNXJ4Zi80S3NV?=
 =?utf-8?B?K2NUZGh2OFVHb1p5UEd5L3RhVDBzVjM2MnBFQ0t6WEZJOHdxTEEwOXlKK2J3?=
 =?utf-8?B?QmxWZFlUbUpZZ25tZ0RtS1lhd1dxZjdpRlo3cll6OWY3OXVLNFkwN3V3L0JD?=
 =?utf-8?B?WE5lVXZ0NlVIWGl4MWtTS1hjWG9xV0RGMmFjTHl1UWNsd3dKd2plTWxRR0NH?=
 =?utf-8?B?Yzk5NGpud3lwUUc4L2E2RXNRTFJPVXg3Wm1ZY2toZXdaQjh0WCs2TGRBNzJh?=
 =?utf-8?B?OUFBc3lZTjlEb2pWQ2JmUnlWQm5mb1ZHN1llKzlNVU9KYkh0dzZGbkRCaFFy?=
 =?utf-8?B?Y01rYlZPNkU5K1hZZmpBN2ZGYk9HRFZZc2s0S2xHSEh4Z3BBOXZhK2xtRDdY?=
 =?utf-8?B?SE5vN3JkSzlWOENQS3lIbUpncFA2cVFlb25iSzhGYmpYQnRxcVBYRHd2dG1V?=
 =?utf-8?B?cFk4YnpjallQRDIrQUtqU0pZdFk4ZmJKRHYxMW1RZ2NEaStJWGNvNjBSYis4?=
 =?utf-8?B?MmhiZFhTNGpMOVp1Q1R0blE2QlJjNHBYeThyVm1ITEFUTG94MUhTWm9BK0lQ?=
 =?utf-8?B?NEFsMUttaU5GR2FIV1U1T3ZYS1A3dWVtOU1RVGFlU0NyenJvZlE5dTV1bW1j?=
 =?utf-8?B?TWNhc2szRWF3WGZoY3UyRk1qOUlHdkNML1BEMldvYXRkak96akI3UW45aEc4?=
 =?utf-8?B?dnY0QVA2Rlg5ZjNwV0lGVTRRYm9YU2NONURiTHhrUzhwdGVNUDUrZDd5N0t6?=
 =?utf-8?B?REI1Mzg0TlBrUzAvalllVEkreUFaUHBhZU50ZXFaUDZia0xzb05SS3NOQmpv?=
 =?utf-8?B?c3RDK0JuVWdLZzhMOFRyWHZtdmVTWGxiVXd4U0Z3RmFCOEdJTEVQY1dOZGw0?=
 =?utf-8?B?b3E0dVRjSzZxcFZVTmY2b3BCR0N6K2MrN2hMbHNWVXNsWDF2WmxFd1JPRHQ2?=
 =?utf-8?B?TFptUGFRR0wzZW9XOEZDODBublNqNmc0WStTRTlzT0ltZmpIR1paRlN4NmpS?=
 =?utf-8?B?Q2JCQ2IvSFhaTEtlc1JsSEtSY2lqYmF6cDExQzdxZndTZEEzWWhMUmJFOVNj?=
 =?utf-8?B?SVo3QVBxL1d3RXRSTjVuSi9qaytlQ1J3b3Njd2ZWb3p1ejVWVU11Y3d1Ry9B?=
 =?utf-8?B?cGtpdFp2eXFDd0Ntc0ZlNnlFc1BqZjl5UmZmR0xLakk3WTFsdWl6OVNmQk5K?=
 =?utf-8?B?S2d3bjhjUlJPbjlhNUVYallicUJ5eVBmNVYvSW0zaTg2dzA2U05zR1Q3a2g3?=
 =?utf-8?Q?uqUF8KqjYUcNWpMUqtJJMYggPCsKAIRtUIBck36?=
X-OriginatorOrg: sct-15-20-8813-0-msonline-outlook-f2c18.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd972df-cbb2-4af3-e45f-08ddb7d488e9
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 12:49:21.7317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7033



On 30-06-2025 06:09 pm, kernel test robot wrote:
> Hi,
> 
> Thanks for your patch.
> 
> FYI: kernel test robot notices the stable kernel rule is not satisfied.

3/4 and 4/4 of that patch series are not meant for stable. Only 1/4 and 2/4 are.
> 
> The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1
> 
> Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
> Subject: [PATCH v2 4/4] HID: magicmouse: use secs_to_jiffies() for battery timeout
> Link: https://lore.kernel.org/stable/20250630123649.80395-5-gargaditya08%40live.com
> 


