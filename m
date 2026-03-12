Return-Path: <stable+bounces-224825-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMZUCmx/sml2NAAAu9opvQ
	(envelope-from <stable+bounces-224825-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 09:55:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C008A26F3A9
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 09:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 309A8301D0F6
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 08:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E6838AC8F;
	Thu, 12 Mar 2026 08:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="To79ECfu"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013022.outbound.protection.outlook.com [40.107.159.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719BF38AC87;
	Thu, 12 Mar 2026 08:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773305705; cv=fail; b=WzK5dC/+vl50FdeY41Mo7ZFlKkiJHQ96WwZSGY7AQm4Z+ueeXa4oogAVagGQALojppPcxiwdGXDg6Owmq/kEnmFGVdNSYAJc2oMUND2jUnc+0iyt8CL/44THIkkuugvi9rMPG7sjSqfajIsiQX5/8khZuDjz8NFZhRD0UssEK+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773305705; c=relaxed/simple;
	bh=3XEBbCb9OieLRQFXyFnGiUhcK/OCRhGmflI/lBToLls=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XF62cBRRdINRrJTVaRAHqNXXDHg7bKtBjqcuhCGXOGuiiAteiLs/GK+if+qfkWOWO7xhQ/VBSvO4dA8f6WAK9BSjOoIcPGjY0nXADbvOvj3cuuXLtJWZFiYmLN4ernxIh+47i1oe5bfS7jhx2OtXfJCCxwxmuRTf67ZcpCrMO8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=To79ECfu; arc=fail smtp.client-ip=40.107.159.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzeTy/pGqANj7dSUnaue6aIsSfKx0JzmtWScVfXRKeG6wHSNfsfuR/5ufYQU7NUDg0OnRPPLRo63mS9dNK87ZzlIWQ1efY8zVr/s8BHpFlBuR12Cym98niCcRC7Wf3ot+esPW7pw1SH8NPNKfJgD+entBplv6X+vU73oVRPdYkBpBBqTLVYvS8pyqes4twuyW4HE+4gsKMiv/CXvBu7+OB5EnIieV+582EAAdG8gMVMEQZZLes4H64o86j++NZj6NBF5iMAVCXvFuNSVgASoOMcHdwKXw5YLsyQE3Oc6PywkCQaGqgsGfoTYxpSNWSZnSUax+uE7hRQaMWPGaDs47w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XEBbCb9OieLRQFXyFnGiUhcK/OCRhGmflI/lBToLls=;
 b=Yi1IahF1uDiNrQMYWXDVs+7Ez2ePLMxkEtxQt12tvXzZgIPjLPbBmTWXXfp8w3o4JGPhLvGYxAGh/73LIpOeI9M1OXNfhNXGsRB9cXWxsUa6iIv5Z+QLDGuGDJfw71H2b+1FAuvF+lc2S4Wud0pscTzmPb6p4uzJWpL6TmAObObcD0NTKsM7va6wYOJzU/HSZicK6OGptMm+Kp/KG8eJyuo0oy4hleKoNp2MJh6t/Is5msgGs7Fp/tUeDf9SNsWtD7Hhlw0caEoICoYouAunIZhQvpOWAsVOfoA5xr/FZ0Sk8LiMW2azmndwsNHNY5oKhLxTGNuqhlYcNchJ86TD6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XEBbCb9OieLRQFXyFnGiUhcK/OCRhGmflI/lBToLls=;
 b=To79ECfuPdPoQq3MCtJ8GU7CdbS+WQLl+ki+tizD/3h0ffWHQ78fj9tkT9ZMPAOW2xaYc+Rz2xoBE7Ul6JVfo9SGsKIeLDrd8e6SeZh2m8Ckk7qCm882KUoiwpReS0KR10LDUPnejHqDpF8a3t9Sv/2w0zTjt1VyHiGXgj0qjnMkZTaoXcvqkZugTEdizkJ0VUA+Dvn7WB1Tsej6lnw9A+XSSnpjabVXEyjn3Qo9eu0CtsMcia9iPAOiKXDP0P6CPxHte8EZrRkIcV8VkNDS6draxpIBSYMZBE412pkszlAws/tXZZ+5UZlAGtqa8/ygd7PHrpP597NhIHfEoG0iEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by GVUPR04MB12196.eurprd04.prod.outlook.com (2603:10a6:150:33b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 08:54:54 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::e99:f504:ce75:9bed]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::e99:f504:ce75:9bed%3]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 08:54:58 +0000
Message-ID: <603a09c7-1b08-4d49-92a0-58e6c1b9a003@oss.nxp.com>
Date: Thu, 12 Mar 2026 10:58:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pmdomain: imx: Fix i.MX8MP VC8000E power up sequence
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
 Jacky Bai <ping.bai@nxp.com>, Frank Li <frank.li@nxp.com>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Peng Fan <peng.fan@nxp.com>, stable@vger.kernel.org
References: <20260228-imx8mp-vc8000e-pm-v2-1-fd255a0d5958@nxp.com>
Content-Language: en-US
From: Daniel Baluta <daniel.baluta@oss.nxp.com>
In-Reply-To: <20260228-imx8mp-vc8000e-pm-v2-1-fd255a0d5958@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::26)
 To AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|GVUPR04MB12196:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a7b9b3-807b-4903-8776-08de801509ed
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|19092799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	uOsjoPeixQaFc7jc+GN6Rm8PohKFA3U6Yp3N8wGPxnA5BBvE75q0ZSgK0vhkSog4RKQmmv8LNtikNC7SZyfO6WhgTAHN+qOgxBrei+U4+ER+krlF15lg7uwk8+yCQcaiXOaSftVRDsLcNJi6bIXSINZKhaYLYlf28SRwnFJwJZwBI8iv5bXyun3l8BYP3xrHKAv9qtJ/Hok7wkfJRTNF/UdaTtgsjsOIsp4yaWveUOEEUWL+bXTm26Ks7qchRT8DbZoRRvN+FnkTkEmZzpkFyRoVvmE23gg1IRi18HVjzCvAStk7Bq9vuwZz9UFNPX/RVX56LS3Sc2v6/LkMNNwhqA4OB1JDb9fW+cc9IYh5mUTpHydZKLoqblDHsVBNGB1qb7a2eCb9DBG/7xeHR7cn3LEfBnpQHhN7NUJFVFNdNfeheGRbs9YrGCjkiyjihHO7C18DdkM+HGEIXAMKFFB7680URpfL2Pdy2M6s9uB2YMhYz/n9JIm4xxbDuA2N7pWD72c7rELcRUSvClfsdyNc/na+f6qMasYwlXDHzP9Y5twH8Pu9/zxU3zdRJ+MovoS/kYKQSq42X5qIU3/gPYtHwut1zKimi61e/oljuC5VD5fjhC8fPlDeoiSnfmnPEO0zLxiUBSLnH03HEWC/IoYcGshiVSL7UU4RTaT/sd9XuGgHHZu7tA45X41LnottWKM98S32/wzuqChPRyCA2tW8TIy94l9RgUO0XF4/hi6iOBgC36ALScOAkI6DaEbzGqsc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1Y2cXJBNzRMVXVBSUFWb3NORVZsWTZsRlhWbHo3ZzZVTWEyQ29YamNOYUVZ?=
 =?utf-8?B?OU5DcUVXUG92TUVSQ3Byd2xYNUI4T1pnbTZjZUxtOUZwbUJZUFJvQ3F5UWts?=
 =?utf-8?B?TXUyWnpFN0VSWEpES2hkSGZnZ0d1VTV2RWZFWHVNenQxOWVXcy9tVFJoYTB1?=
 =?utf-8?B?WkowdGo0cDNWQStJTjczUEpleGoxM3FSVUREcGt6UHVhZWRmMHBBdVk0dXI0?=
 =?utf-8?B?aitlZ09uR3JOK01YekhRelRYT2FmTnJtMVRPMWFYVnhjL1UxZ2VWOXNVNUNl?=
 =?utf-8?B?Q0QvazNqRFVjZ1dZUzQ4clU0bzZrMVcrUkgrR3lubko4ajQybXF0SlVKK2VT?=
 =?utf-8?B?M25RUE10YmMyU01sa2Q3aGtXZ1NFYzVRK1kveFRnZXdyUGowTE94N1RHd2xt?=
 =?utf-8?B?UDVCQU10R0xhVzVyRGlVZlFaQXlzUHNNOGU5S2kwK3E2bmN4VVpZZGtxeXM1?=
 =?utf-8?B?RGdNZ0ZMUU51TTlpbVhnWHR5YUczVGxJbkVTM2FYTWhwd0d6Ymk0ZDNhQ2oy?=
 =?utf-8?B?dUQrRk5leEZRcDVZTGp1bjNlRjRsTVRFSlhrY2JqSFhSRjVBRm1yQTZXTFky?=
 =?utf-8?B?c2YwWG1jTDh0VXh6NTFiU2w3d0tiODBuM01qN2lqMG1qSUtva25WRTZ2Z1Mr?=
 =?utf-8?B?azRwOTZYZzB5SmMvcGFzOUpudndNZEdxcWJ3S3RveWc2aGVFem5tblVpQUNz?=
 =?utf-8?B?NXorOVAvcUhsM0ljSXkxK04rN1JDenNmZCs5TzIvdUlsSGpTSHhvTkhEalpK?=
 =?utf-8?B?SjdnR0dTZ2ZWaHA3UHgwaUR2bkFtVzNtYm5JMDc2SHU0aTFvYWQ4YzZNSlJG?=
 =?utf-8?B?ZWt3bFFqaW1JYzMza1crNzMwaDcyVGtlckpLQy90bzA4R3pjQm5Rc29YWXhs?=
 =?utf-8?B?Ky9NaXFjVGJXRnNrZmJJZWVvMFFuNmJvVkg0dlhJcTdZZUdkU203OGhLNURK?=
 =?utf-8?B?R0dPd0Y2RWJWY0N0RWh6Z0daQ0ZjTDZvUU1Tc01mNVArb0d6aytLeGwyYXBT?=
 =?utf-8?B?TkFjeW0rUHA5QVdUU2NlOEE4akNlaVk3MW9NVHlFcmp6ZFp5MUVJbGUxY3FF?=
 =?utf-8?B?SFQvZ1NIdUZ5WklkcjN3V2kycFdTNTRpbnZEaGtXaTNyVk02ZVJML09MRFdD?=
 =?utf-8?B?TmJQTVNkU0R0eGxmK3owbGlFbCtxUjkyeFlFanhGcFFyWmRMelVnbU5WRWZX?=
 =?utf-8?B?a3h6TE1mOUVoeFdUbkhqZnRvUFg5enRxbWRQRXZzeW05RHdxWGhVVnN3RjUr?=
 =?utf-8?B?dXFCQlBFSkNPNlhNVWdUemxlaTFrYWFkYmlFVnVpWUxMTks1VDZEVVBwYktT?=
 =?utf-8?B?SXpaMnNpdGhwdXdvN2xuTk8va2MyS0RRQStzOXRwRmN2TEFJK2I4RWovM3dI?=
 =?utf-8?B?THFhaC82a3VCMTVzN2VYbVNFRnB2ZHVLT3p4RFRBM0hoeGRVT0wwbElMTHIz?=
 =?utf-8?B?ZXl5aWszeUczMkM0dXRsY2JiVk9hNi9JQVdESnQ5VWk4OC9mK213dEg0Mity?=
 =?utf-8?B?SEt5NUIzbk95WjhFQUtVTjhNYTMvTDdKL2hidmJ1NzlYaHI0Vy8rYjZ3RkJI?=
 =?utf-8?B?bWIyZlMrb3ZUTG5wVklCUVdWd1BhekVTNTJnazhleDIxTmxTVHRqL1pEN1BZ?=
 =?utf-8?B?ZVQ1ZENWbzFZZFNpbENCWGxzajJxYjlVa0pGOGJWTStMdWVuVEN6dnorS3lV?=
 =?utf-8?B?N0pLc2NMcHdmVUxHMlNCQ2JDYmJ2OUIvTXpYaHFsZ1Rtd2VrY0FXR1JJdXJJ?=
 =?utf-8?B?OXZCd01JcDZSZmg2SEMvaHBEMHNSenE0eTBVRW96RE83QWVNZ0hOSnA4OGgy?=
 =?utf-8?B?Z0pLMWZEK0RiMC85aG5HU2VDaXpaQjl3ZGhHNUpLYm9tV0xhSThla2ZKMW9h?=
 =?utf-8?B?eENPQ2tEenZUc2M1WUlTZjJBRkF5TEk1bUE2enlwRjNVa3Zqcjh1c2ptd1Fk?=
 =?utf-8?B?ZlNVOFhkb05BNzlPd2JKMlNqeHdsb0tvcDRhM3dRcHM4UG9xaHE3citBdFAy?=
 =?utf-8?B?bGFzNHBqeENhZjVDMXlSSGpqd3dLZUNqblkydStJeTNxemdrcWVlNjkxeG13?=
 =?utf-8?B?VFZJT3lWSmkyNlZ3cjBWWER1WTdHYTl4WDRPcExJSFp1Yis3RzdBMHhCRCsv?=
 =?utf-8?B?czZvb3N1WCtSYWdOWER6WkdYT1JkNVJvUTI4bkwwN09yVzNaOUI0M3J1UXdo?=
 =?utf-8?B?RzNvUG1lMEs3VXJKWVI2SDU1NjZ6OWFHU3p4VXhwaEEvYnRYYmFlZFQ2T2lr?=
 =?utf-8?B?bmtFRkNFNWUxK0xhV3RhcTJndEg5bUZuWkFsYStyVXdQRnl4cXYxdHNwZ1VC?=
 =?utf-8?B?aUI2MDhkSFNDdTNpZkhtMUwzaHZBc1d5VVRCWDhhMTc5WHpsaGJOUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a7b9b3-807b-4903-8776-08de801509ed
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 08:54:58.7111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tzBeK38NBP9maxR7w1uJY3k1vpscMKYj5UJ+ghxFbX0FTKATBbcuhfvAQE9SqFpbjcUYBGWFRjFs7cZIdz09Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR04MB12196
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[oss.nxp.com:server fail,sto.lore.kernel.org:server fail,nxp.com:server fail,NXP1.onmicrosoft.com:server fail];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.nxp.com,linaro.org,pengutronix.de,gmail.com,nxp.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224825-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.baluta@oss.nxp.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C008A26F3A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2/28/26 03:12, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Per errata[1]:
> ERR050531: VPU_NOC power down handshake may hang during VC8000E/VPUMIX
> power up/down cycling.
> Description: VC8000E reset de-assertion edge and AXI clock may have a
> timing issue.
> Workaround: Set bit2 (vc8000e_clk_en) of BLK_CLK_EN_CSR to 0 to gate off
> both AXI clock and VC8000E clock sent to VC8000E and AXI clock sent to
> VPU_NOC m_v_2 interface during VC8000E power up(VC8000E reset is
> de-asserted by HW)
>
> Add a bool variable is_errata_err050531 in
> 'struct imx8m_blk_ctrl_domain_data' to represent whether the workaround
> is needed. If is_errata_err050531 is true, first clear the clk before
> powering up gpc, then enable the clk after powering up gpc.
>
> While at here, using imx8mm_vpu_power_notifier() is wrong, as it ungates
> the VPU clocks to provide the ADB clock, which is necessary on i.MX8MM,
> but on i.MX8MP there is a separate gate (bit 3) for the NoC. So add
> imx8mp_vpu_power_notifier() for i.MX8MP.
>
> [1] https://www.nxp.com/webapp/Download?colCode=IMX8MP_1P33A
>
Peng,

Is using imx8mm_vpu_power_notifier wrong no matter on the errata? If so, I think you should fix

that problem first, e.g create a separate patch that fixes the notifier and then add support for the errata. In the future, if the chips with the errata are deprecated we could only revert that given patch. thanks,

Daniel.


