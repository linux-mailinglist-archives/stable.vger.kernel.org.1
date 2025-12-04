Return-Path: <stable+bounces-199964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CA3CA29B6
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 08:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C8F23023549
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 07:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261872741B6;
	Thu,  4 Dec 2025 07:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WXmTWvgR"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011007.outbound.protection.outlook.com [40.93.194.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC7B1DE894;
	Thu,  4 Dec 2025 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764832337; cv=fail; b=aQvOiNWuluaDi/ZOvm2++TMclPZfQBhFn696AOksw3DjPztfSvwkRWFkFFCinbLeaZPX+2JBQzEM1giak0zj1FkljWPN2qC8Qkag6TVlI37d6sOv7WC1z8JgJ3+p27iY7NsvBw/wiALgTiJFWqHbyQWaN2klwz9bq9b3M5srUWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764832337; c=relaxed/simple;
	bh=1DP2M8GgMf9A0Xo/p0nkidmJvf6LdGxu/vmva9a0fZw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lYDFUg3GWzf+gfrcSZyiv1S3ibi+jP3/tEmWQ2E3fItZ0nWqjaTN14iPceNJsk7sD4mevW+bLncSz8PnNOUbRNIueVSefunDvfI0q57zwOu5PTcwzAxzTNNhjILKvEqsed2yn5GDvNafAf/l9W4dP0KDwrv1phBHLwRjTtg51pY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WXmTWvgR; arc=fail smtp.client-ip=40.93.194.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAKhI3Ye5UGp0YGvJSaOex9WKXp+ogY00LH6SytHzcOPsk5KHTELIgA+0Oc/Q23VuV+u9vPs0goximjEw4/cD5q7k35W5O+pCoy/lFf8AgKM2eOhkO8wrkJMCrSVE1z8SYhJ9iBSWk26hFtl6/2zyRbUz8YDmlq3YW5bL0ebIm6Po/1Dv56cFQoJgYtGCSyIYi5DqS2Hf+qNAvLRDE+E9OAYGrbQJHCQDtHbsYtLc3GwjlvJlWDgJ8ONVYvJIne/KZF0wQkkQGFcbJpNB8+HYWIerznRYhUKuQ3O7pyiT6xA9uP2cOlWhvutan1eXfdYRdWxK4TkwtogLOxNzZ8Iyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClYUetRolTO+uoUjQ125IJA/RZ+oc0eCdehr4KcYIJg=;
 b=wixgiYked88Fj/hYETjrEsiUrolqLO5lizWtopgVb+VFFWp6bArXN6QJXilMIpyQOHKN7bXYWjBgY07dugiyYrZNIqz+O7fey9EqTx5b8UMrciiXgjZhr3g5ik9UvPYf3cClIxFELajjrxs0hHglg5rxdus9hfY9G/MaNMypWfw7PoI3I6BVgkxpCRWkKQUuatLASN0fwXkQ9MZ4sLozrLEw2xe4ONB/DhwFEfwM3Qotv3Xiq2EmNgbc/nSEw66HKBTVjUAWP6B9TIjmUnGzwX1NYfG5o3NGGPmMq91/Blcwfa1D5HTB8Nk0u+HqSrU1/JGZEi+Yw3HUC4GzU56tDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClYUetRolTO+uoUjQ125IJA/RZ+oc0eCdehr4KcYIJg=;
 b=WXmTWvgRIytZ7AUENjl3TPRmecmTCq/ri6ROg6LrMumw+7Qc2fTNcwC585q1xtai/0LRFJiAs5cvSqZVf/CGB6TwNLDov0kBSInETU3wfi2+u/aEVH22C6PgqSOhNCnx3OdOMRCARVMTMhDo+fsWFbIBow0Smoy6/NMySH7eTUiNQC4I0uvIDEZtCguBa8OqUp2tEpmqWKfJZzbdhQUv4h2/j4dwtuq0Y1PNwmnzx/2K1vVV54dPMmY8wOXG2Gh0Vn/AkwVyjYOxGe/GMAHqWghi+kJrNHxsHJ1ue2H+0cWyfajEecRtd4q+Ya6JtA4hF7oFT7lZ5zozwhJZFc4X0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5195.namprd12.prod.outlook.com (2603:10b6:408:11c::19)
 by SA1PR12MB5660.namprd12.prod.outlook.com (2603:10b6:806:238::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 07:12:13 +0000
Received: from BN9PR12MB5195.namprd12.prod.outlook.com
 ([fe80::de30:34bc:cb2e:1ec1]) by BN9PR12MB5195.namprd12.prod.outlook.com
 ([fe80::de30:34bc:cb2e:1ec1%3]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 07:12:13 +0000
Message-ID: <7d3c711a-bc33-4dbb-a8e5-bcb420d5b536@nvidia.com>
Date: Thu, 4 Dec 2025 15:12:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] phy: tegra: xusb: Fix UTMI AO sleepwalk trigger
 programming sequence
To: Wayne Chang <waynec@nvidia.com>, vkoul@kernel.org, kishon@kernel.org,
 thierry.reding@gmail.com, jonathanh@nvidia.com
Cc: haotienh@nvidia.com, linux-phy@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251203024752.2335916-1-waynec@nvidia.com>
Content-Language: en-US
From: JC Kuo <jckuo@nvidia.com>
Organization: NVIDIA
In-Reply-To: <20251203024752.2335916-1-waynec@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0147.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::27) To BN9PR12MB5195.namprd12.prod.outlook.com
 (2603:10b6:408:11c::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5195:EE_|SA1PR12MB5660:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1d935a-d252-43da-de57-08de3304725c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGN5cjdrME80MzFoeUk0eGtJZDIybkx1bmtmY1U1SDRHa3hERG1jcjRXaEs1?=
 =?utf-8?B?em42c3lQNDVvaHczQjdxQnl6YndLUzBQZUREVE5TYkdVTWZtSm4xMXFHd3Fk?=
 =?utf-8?B?UWFhblA2d2doZjQyUDlZZ1VOTHRydFJUaEJHZUoyb3JZc0tuaHgrTzRYVUgr?=
 =?utf-8?B?S0poV3MvVTFDVkJVWWltc3ZvVmVGa1NPV1FBWHJVWldOem1lTkhZSXpjZTZJ?=
 =?utf-8?B?YWdXY1FpN0dBMGRsdTRRZWl1bDg1bnZtNldiUUM0bDA1QU50M1FjcnpzK3Q1?=
 =?utf-8?B?YTlRZS8zamFhcUFzU1FzR0lkemY4Kzd5NFFod1Yyd2huYmpORytVU2FZcjhK?=
 =?utf-8?B?eDdKSlI1Q3E2cnRwRUwvWG05aGhaM0w3cHl5amlzcjk5QlVhejI2VXpwQWFN?=
 =?utf-8?B?WTFrS1drcFovTjYwbXBiQVpGejh4ZFp2dTFkeldQN09mbk4zeDV6OW0xWDZO?=
 =?utf-8?B?YVU2UzhuZXMrMTk1dW1XSnFEK1c0ckNIcmRCTi9SS3pRcnIzVmdPQzIvVkkw?=
 =?utf-8?B?c0ZkRmdkMmFrOTZHUmxZamNXTVZMdE1SQjdaaXVib0wxSURhRFo4RlVjZWlW?=
 =?utf-8?B?RlBTNTliMHBjNVM0N29aYVVldCsvbDNwVmhUNjc4OXE3eVE1TTlaMXdIU2JL?=
 =?utf-8?B?V2Y5dmFnMUh1a0EvdzF0MXNRNjIxd2cwN3R1OHRJbk1sZ2tOTFlUTGVSci9X?=
 =?utf-8?B?Q08xemxZbDBXV2V0WkhxMHdEdU5OMEdMdE9jbCtqZnA2MTVFeEhVdUdnMStR?=
 =?utf-8?B?OWpxamxERFJkTUJ6ZldqdU9jdk5wZ1dab0pDamZQVTIydWxFUXpmTmI0OW1E?=
 =?utf-8?B?SGVCRGlVYndHTzBlZlFpR0lJT09FNi9ZVjJMVDNSZ3BVOWpvQ09Za0UxMHpJ?=
 =?utf-8?B?QmxLMVIrc3I3OWlSNTk0ZXlueWh4RitjdmMwK1g4RTdKWGtDc0pPUGREU2FF?=
 =?utf-8?B?N3ZxNWQ3eEZJUTl1cDdnRnp6WHJLTFpZNzhTOTUvZk1qRkFXQ3pUdU9kZStq?=
 =?utf-8?B?S0FHQzRCYVlOeTlRdS8zNGJZQVdRVlF6OTJvMnBCcVNEV3dYdnMyM1gvTjUy?=
 =?utf-8?B?VmZKdENtRmFSRG5jOXRsZDFmSDRPM1ZQbTJhZTRacXlRRVUrcUc3OHFDLytr?=
 =?utf-8?B?bDd0WlNlUW5YUmUrUzQ5R29ZNHp1K0VlZUkrSHlEVDViYUtkMmN5b1hYUlpL?=
 =?utf-8?B?NFlTYUZFcUVSQ1pVM1A1YmRCNGp6dWN5eW83WFRxZHlJSWgwdUJKd0tvY0d1?=
 =?utf-8?B?c0l1a09Pd3ZMNGJ0dkcvS0REa2orUGErU3lXeDNUT0MwTGdwZDFJL2tGamRr?=
 =?utf-8?B?NldtRUNWWmpxRmsySEN0WFU4YnVvYWliUk9vbCs5bldrUWlLbmYwVHZLajJW?=
 =?utf-8?B?ZnpVc1JncGhmWTkxTlgwMlEzR25vaUdnYVp0SHg2TjRnUGxBWkZxRXdDR21Q?=
 =?utf-8?B?bXNXM1U2elB6bllnVkxybzR1eEZFZisrSDAxQ0t4MTRzK1BGV1hxcDRMQzBk?=
 =?utf-8?B?YkFROS8wazVCeWNWWmpFNDNlZWxZNndvS2lZcGNmWlI0UkVZbjJodjlLbHkx?=
 =?utf-8?B?OS9OL2lrdVc3cnpxSjNzOG9Ma3dMZGxBZE9yV01ZdWxDUVB0VGxYNmNKblQ0?=
 =?utf-8?B?Z2JDTG8zZllFQ1hqS2pIdTM2NEIrWHJPaERkSzl1blowZFloMHl3NnJpa1Nx?=
 =?utf-8?B?TnllUVAraWpNbkhKUHZQMzZQRi92Mm15MXZYbXdhN3EvSXBINDRDbjFkTW9W?=
 =?utf-8?B?SU0vZHhLVFN6NEt0a2l6UmpOMU1PNERwN3VycFJNWVU4NHZGM1JCbXJsN1dW?=
 =?utf-8?B?eVFnbUppNHVxV2huNzgwb0tCcjNqRTFNMVhYSDdnRmlkM1hpV1E2azM1eWZO?=
 =?utf-8?B?ZDZYYkdHRUYycWVOZ0J0UlFUVVBxcXk2L3Buc1lLZDFmWHZtZjRTVXZJUmoy?=
 =?utf-8?Q?jMGj0BIK53xjE2sGFqGZokNwY3Y750ia?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWpsTExqRU0vaWl6MEtCM25RbUg4cnF3MjFLL09CWThmOGNmVjRtQlNiK2Va?=
 =?utf-8?B?bUQ5V25VOEdqdTJSRU8zc1FFaVBOdkxId3VyVEh1UmpDWUNVZzRsQW9CamFv?=
 =?utf-8?B?dlZkL1FiS1RXTVBnK1J0ZTZVU1dwY0lZQmR5SHVYVDB3c0hiYzlvbG9Xcnp3?=
 =?utf-8?B?dlFQaURiOEpGallkVmUvWjBGV1htNGVIQUlFMzlZNFlJN2xVdExmRW40ZWxP?=
 =?utf-8?B?K2luanpGM2tXbUJ1R2c0SXdqelQwUFptUmo5L1g4MGtaMTRVaGNMNmw5Q0pR?=
 =?utf-8?B?anBmUzloazkyMzl2dkFLUzhhUzIrS3BhYm1zWi9zRVhwaC9UMmw5WnBzZ2h4?=
 =?utf-8?B?MFk2Q0lxRWx3Y2JGQ1EwRGlmT0cvZEthV2RZTHFoVFNOOHRpQllSREN6dTV1?=
 =?utf-8?B?eHRhN3A4UWFqalJ3M2R1UVlrTnUxTEJoc2ovdlFJZEtPV0NES2dDMVNMUGxY?=
 =?utf-8?B?TzB1eWNiYWMrbnNrMnNVamdySW9jREtuOFREZ3hiY2x5N2N1clhjMGVuNTRt?=
 =?utf-8?B?c2lGVGRoSVBaSVpyaHpteGNpUHNrL0FFb1FMK3hCdVdndHh3NC9UWnBoMmxM?=
 =?utf-8?B?ZlZEbU5WY1hieFVhRGV6QUtXOVNEcHdsNFZQM1hZdm5TalM3RmgyS2FISjBT?=
 =?utf-8?B?dGxpaEhnK1pwZEo0REdHK3BIVHZocmd1RzVNbkppQUl4TVhNVWVVc0NKc3ZN?=
 =?utf-8?B?QktQVHovVmQzQjc0WUVacmlKdnBCTnJsZEN2V25kay9zV2JPTkJTRXd2ZC9B?=
 =?utf-8?B?bjZqWTlNaUN4dUlNWlFFKzlYaWJ4YW1ob284QkpvTm0rQUFjemNaa1M4dnhz?=
 =?utf-8?B?L0dzVG1kRnNLTmMzZzIzbVZmQmZNNzJQYjNmVE50MjFEY2M5cXlENjU0MGU0?=
 =?utf-8?B?L1g2b2J2TmxObXduV1JXeGV2L1B6U3ZwZkl0VFVhci8rbEgyN0RwTzFERmtW?=
 =?utf-8?B?eGQ1TWZHdUdBQ0xCNk5ZcjZCQ3o3NEVMTXhOVXNRTU9RaDNOZUQ0TGVCQjhM?=
 =?utf-8?B?TGR5SnVqQ2QrTnpwUEc1QmljSlRrTktQb2E3Mkd0VWFUZG96QVZ4ZmxUT3kz?=
 =?utf-8?B?ZTZ3b1dhSzZkbjc1VFU5TTJWSElGZEZEVEtkdmI5TlFIa09mVWN0TnZQOHor?=
 =?utf-8?B?Y2M1RXZWOVVJT0FWOWwrR2N2K2ROczU3RFdQQVcyaXVIYkJrbk9EcU9JVXZp?=
 =?utf-8?B?UWU2V0U2WTlzRzVWMzdyOHlYMTRhR2FJVUZmK05NTm9LVmY3dWs2cCsyOUV3?=
 =?utf-8?B?NGtyOXRHVWdxUGtUZzV6ZExBMGNvVXUvYVJBRTBEUkRCeWRoOFNhaDZrd3po?=
 =?utf-8?B?cXRqMXRzVFFjMTdYRnNTTWVQVEd4WitEVkV1RzR5b1NId0lFZU5hRVRzR0xY?=
 =?utf-8?B?dUtRalptTnJsZHpNZ1BnVkFhQ3pHTkNOTm8ya0JZY2NPOGFQRDUxeXFtUUNK?=
 =?utf-8?B?ZXJVa3A0U25hd1QrZGVuclBYcmZlK1FOMURydDNHblV1WnR6TU5GNjZudmRW?=
 =?utf-8?B?RGFnOXBMbWVSdW5YOFdLVTFIMDhXTDA0ckx0ZHlrOUpLYlIvTG1QYlp2aXpI?=
 =?utf-8?B?WXRxQUVqT2hFOUNtNVdlSDZWTEJKWXZZc0xUeGNRd0d2OGxIZ1hRZ3pQUzhs?=
 =?utf-8?B?TmlJSkEwcDNsbGFuQ3RabmRSZDBxMFNGNjJoQmpjOXgyMlVFdzFDU2RUY1k4?=
 =?utf-8?B?Kzh0TFExWkIrdXpoQzNrWUxPSXdmUmtrdDBTSDdPQVBKVGZtVG00SmhQbkFn?=
 =?utf-8?B?WkxwYldWaWFYZHZ2c2ppeVFFaTZLbzVmTjcycXJJdkU1U3pwNnBia3ZIYmVK?=
 =?utf-8?B?UzA2RUs2TmxWcjAzMmRqdXczdlpXYThoOE1VTTh4QUJWT0lBaXBlWjZvL0VN?=
 =?utf-8?B?amRGUTU2bkR5VHBVSEFSc1hIQXZKUnZyaE1rdFRKQXZjbjdTMlVrdFRYYU5Y?=
 =?utf-8?B?emtSU2RNcno3V1hyVnE0TTFLVnJlWksrUG9NUk1GaUNtZlJTdWlwbWxBNWNT?=
 =?utf-8?B?dzVuZmtuSVZUc01OWTJNN3FLdzlkRnU3c1haQzhwdlRQVGUwZlBvcTBCTVpT?=
 =?utf-8?B?NDhrSmlWTHFGalc4RnZVUU54V1JYOHZZMExvTzhKalRJbVR0SW5mOFA1TE1F?=
 =?utf-8?Q?tAnv37GfNbNCziA/zl4yfLF1b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1d935a-d252-43da-de57-08de3304725c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 07:12:12.8476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGlUm1jNNrrbzZBqXWPX9Ctptob9MYAM6z1EnHlajf9U//14ESGxTWhkb9+Of6iw4Mg2BtRWZzfOGGY6xorw1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5660

Hi Wayne

On 12/3/25 10:47, Wayne Chang wrote:
> From: Haotien Hsu <haotienh@nvidia.com>
> 
> The UTMIP sleepwalk programming sequence requires asserting both
> LINEVAL_WALK_EN and WAKE_WALK_EN when enabling the sleepwalk logic.
> However, the current code mistakenly cleared WAKE_WALK_EN, which
> prevents the sleepwalk trigger from operating correctly.
> 
> Fix this by asserting WAKE_WALK_EN together with LINEVAL_WALK_EN.
> 
> Fixes: 1f9cab6cc20c ("phy: tegra: xusb: Add wake/sleepwalk for Tegra186")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
> Signed-off-by: Wayne Chang <waynec@nvidia.com>
> ---
>  drivers/phy/tegra/xusb-tegra186.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
> index e818f6c3980e..b2a76710c0c4 100644
> --- a/drivers/phy/tegra/xusb-tegra186.c
> +++ b/drivers/phy/tegra/xusb-tegra186.c
> @@ -401,8 +401,7 @@ static int tegra186_utmi_enable_phy_sleepwalk(struct tegra_xusb_lane *lane,
>  
>  	/* enable the trigger of the sleepwalk logic */
>  	value = ao_readl(priv, XUSB_AO_UTMIP_SLEEPWALK_CFG(index));
> -	value |= LINEVAL_WALK_EN;
> -	value &= ~WAKE_WALK_EN;
> +	value |= LINEVAL_WALK_EN | WAKE_WALK_EN;
>  	ao_writel(priv, value, XUSB_AO_UTMIP_SLEEPWALK_CFG(index));
>  
>  	/* reset the walk pointer and clear the alarm of the sleepwalk logic,
WAKE_WALK_EN has to be set with '0' according to the ASIC designers. Tegra234
and Tegra239 TRMs have been updated. We will get Tegra264 document updated as well.

Thanks,
JC

