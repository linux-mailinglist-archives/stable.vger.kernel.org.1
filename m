Return-Path: <stable+bounces-208288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC435D1AEC5
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 20:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07BA8301029F
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 18:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B59E352946;
	Tue, 13 Jan 2026 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="enr8HswF"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC5BA41;
	Tue, 13 Jan 2026 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768330797; cv=fail; b=YGUe2Pr7xZ7WZXzYuisPbaqzY80LSYeaxQVqnkE6rZ83Vf4RBDPh63y7Luzz6D2vmCIwfLAFNd/G5P+B3mN918ovdM0nS6WfTIpqwy1stooGgouTY1L0BYYwk6MFbq587qARDqKAbdd461+cviaUQAO3OcgwbqEKaqU4XvT3qkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768330797; c=relaxed/simple;
	bh=tJrkI4AQzhUdiDD1TOr8DcLvLhP5bshO9PQL/oNap9o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b49OSqTHlhqzGNcXNyZeeBW5JQkadYJMt3lNioWomyBx8MkhNnEOiGsbFAlMsg6Uz6O1rgSQ2fAjm8nc9zrEXS9ETpHFlkpq0cSeNHvO2HYNdeBFSuaxWa9SIjJdoH8gHbaoBw5lEFlnzrborNbT3kyLD3ylSGImUTwEWbx+D5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=enr8HswF; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 60DIKUjr1330942;
	Tue, 13 Jan 2026 10:58:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=IoMpnSEjcnp2cAzMw2l64/QdmX6lkYUVdfjWo2I5mWs=; b=enr8HswFv7Pf
	mbCsM1p2We9yh80mBOLFnesyDp47lLx6iYNXJf04C0lU2py0GWrwHVVI+pSxbdWN
	EoI6CaL3FtIJ7nzDGitWFvXzNzk2wQIWQ6UQ3yS2GjUrKhdO5OGK1iJqiIni6WCg
	AxklKyeVB5QVWWFdKxOAeIOBHNw7eXWAyntHJxXVG6GyvyH1dKkcoKBk1GF5fiv9
	/X62qJulEuYDBGipv6apeJ++EApMLlix/MC4SowlLFkuGlPU2SmvVlGaBJ4dXw5D
	wChHflpdOgpp/x6pELyfCCeGc8oyfRAYbz2Jjf12PZJ14t6Vz1/MmeRDgbfBWUkX
	lc9vp+eGsQ==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010020.outbound.protection.outlook.com [52.101.46.20])
	by m0001303.ppops.net (PPS) with ESMTPS id 4bnnr4ugp0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 10:58:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFiZnRRLQv5Xqa/XVv4/tLGh+woY1qk0GQYRdkWcFmq0tdiHzUc3mP/D5kJg+VE50Xls45hMUWxF9iWnj794B5Awpw9Stl0FZWu5dyX8c4MtyujkhugaSFguFog6eufvNYL7alCqiOjM9Xwc7X7ief0MmQOMmHk91X2FjBVqhOYPOhw2HwfTuh/JwOYT/+uwRXBdgU1fC1gijh6rO/QPFHTOI0tBATbt3/EyCrlwnI04gvtu2VYllhOxz8xRrErhFyntnidyKbk7OLWa1cKTOI3O2XhJgtTL6D2ZYeJ7L5pKrnZnwCr/d/i74hVutgiLOHt98Kjv6gj7t6U3LjEfJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoMpnSEjcnp2cAzMw2l64/QdmX6lkYUVdfjWo2I5mWs=;
 b=SsKOUweuOwucO+jpxT/jtNAr0ofmV+C9pfNOaO5iFRGtJU4QUJTBJvBCD8K1KL1CyV0fa5Rpah4xNsjbyBDXLMiIvRhVZOPH/EuOZFBAf12qGnu3LUDUOWKVkiMYueOczUBBen5NK4XAigHJBpb5lDYVcXt3lIOV6pbdXT2JHHKIQPEG0XsloihvXJVtI+s0LlnHK5495S4OHorSnAP0SHIELzjrUnRtpI+R6PlYsv30/t15IWeRRANUBUEDjDqzJQV5K9f56usKR/GyNpD0XIBUaGBCHjt21BX685tA9GdzyNgL3SaPTXnsd8t88ceYbQY6NCxVSDDCeE2zmV6nKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB4702.namprd15.prod.outlook.com (2603:10b6:510:8c::12)
 by IA3PR15MB6748.namprd15.prod.outlook.com (2603:10b6:208:519::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Tue, 13 Jan
 2026 18:58:45 +0000
Received: from PH0PR15MB4702.namprd15.prod.outlook.com
 ([fe80::d77f:116:b03:e133]) by PH0PR15MB4702.namprd15.prod.outlook.com
 ([fe80::d77f:116:b03:e133%6]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 18:58:45 +0000
Message-ID: <dfdb2c31-3cdc-43d3-9e5f-0356cf4c1a0d@meta.com>
Date: Tue, 13 Jan 2026 13:58:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] zstd: fixed possible 'rtbTable' underflow in
 FSE_normalizeCount()
To: Ilya Krutskih <devsec@tpz.ru>, Nick Terrell <terrelln@fb.com>
Cc: David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, stable@vger.kernel.org
References: <20251211171950.852001-1-devsec@tpz.ru>
Content-Language: en-US
From: Felix Handte <felixh@meta.com>
In-Reply-To: <20251211171950.852001-1-devsec@tpz.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0108.namprd13.prod.outlook.com
 (2603:10b6:806:24::23) To PH0PR15MB4702.namprd15.prod.outlook.com
 (2603:10b6:510:8c::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR15MB4702:EE_|IA3PR15MB6748:EE_
X-MS-Office365-Filtering-Correlation-Id: e3dc1231-a2e2-4f82-4276-08de52d5c726
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SCtJeWxjaDhZMUNhdGp0L3NJVVJmeVhQNi9FMDNCMGNXeHF1WkpHM0puTDBj?=
 =?utf-8?B?YUNtd2VDQVdhVW9Wc1BYbEdpdm1uMWdHUTFVNzhteG5DU0hzUTFtN1EybER1?=
 =?utf-8?B?RU1MU0VzTjZBZCtqZXBEandxOFlqRTgvaGtORWN2TVo2RW4vaGh0cFA1ai9V?=
 =?utf-8?B?N2F5MmNMS2JjZ3BSWCtBMjY5dTBVWEx4OXl6WTNqQnZBZWVmbFhsNE9MR3M2?=
 =?utf-8?B?VUsxMDdDWVlVVi9ockpCMzdWSEVoejJZaktkNVJUcUovV2F4b1l3ZDhtOXBL?=
 =?utf-8?B?VXYwU0xHMGZsdG5xS1lENllYZ0ZnZE93OFdOZlZWSjhTbWtKMnJtaVF2OFhn?=
 =?utf-8?B?OTJWYmdiSWxZU0tGQUtsbjRHREV2bm1BVURCVnh1WXdQeFY5VitIM3Q5N2tU?=
 =?utf-8?B?cnZVR0NhL2I4Ylk4YXlPdFc1OEViZkpUeGhuZW5QRTY2T1ZoZjhsT3dwWlpL?=
 =?utf-8?B?OWF5UUVOQjlETWo4Z1l2Ym5ib0Q1N0NzdDROUm5WQmY3dG1VL1RtcGVsV0F2?=
 =?utf-8?B?TXZvUk9vVzR2T3hGR0YvbVdzM3kwaGI0R1hRRXpHVDhQaXpGZ2FVcGE4S245?=
 =?utf-8?B?dUlnTm8xRUpQVzJITklHS0YxTm9raEI4bURUUWVwMDdhdDhlUFk4M2IxRExt?=
 =?utf-8?B?MURRSDdPd1FVR2p2Y1BJWi90dHpjVWtUZlZucmtHRUpNV1NhaHZhdm9NSTBh?=
 =?utf-8?B?c0k4bDhvZGJSdlp1L1VWLzQrekRSQlpuc0t2MUtURUhTRWNDa0dYeDB6MnZK?=
 =?utf-8?B?WUVCYzB0RXdEM2tFakQwWk5xb2dkcW90MlZKazQrTERmQ2hCbzdOZ1BXeVcr?=
 =?utf-8?B?Ly9USGd0UmozRmsrN2RNNzhZNXc5aFJRdkFsaXVneGVhYW1hUzB5b2pFV2t5?=
 =?utf-8?B?YU5SbDZLMDFQNy91YkNsY2w1bEtDcElpcDQ3R1krSFFBQks3dlBFNmlqM3ZR?=
 =?utf-8?B?UW1pdmNkYjRPV3h2RnlYdlh1T2tKTFZqTEJxcHhhOHZXbXZ1Y2pHNHdwS0Jm?=
 =?utf-8?B?S2sxL3ZJenpPOStybmhuR05PQ1dRQkcvT1VqcHl2R0k5RkZsSHQ3TkJYTURl?=
 =?utf-8?B?UDZEYXhDN2tHcElNT1ozYk85VUtWTm1OM3VzQnBtUGVnNHpTeHA2clQ0bVJP?=
 =?utf-8?B?UnpnandkZ3J1TlowRmlqdHkxb0QzbWI0OU1pVFdjRmZYa01QbS9sMmE3WTZ1?=
 =?utf-8?B?VlZCWTU1RE54QTBHeHhNakordVJmTE1YV1FiOG16RE54VWVDNThZQzdJY1kx?=
 =?utf-8?B?M1ovblp6dzdlU29rb3o2YUZnTVlPRzVlNGlTd0RFT2x0RCtyVW5EUEErWmZk?=
 =?utf-8?B?a2hXY3V6SWZ6M2s0d3RqQkV1QXZZVjJZbkNLaVE2L3hPOWdCQnBQMlU0TnpF?=
 =?utf-8?B?aXpIUFFnbWt5di9BNTVrWmpUSkVIWmJUTTArUlo3RDU5U0tsNitZbXk3KzRr?=
 =?utf-8?B?QjdydVVGWXZnTDloYlVyamZzN0tqS3B5WG9MTjIxbC9EbUtVdkQ5VHhoMmkr?=
 =?utf-8?B?VTRLTjNUSm5ldXlka1R0eHJnTEN4MTg4L29FVGo4MXZGT3hNUzc2aXQ4dzJ0?=
 =?utf-8?B?VGJ2MEc2R2wrZXRiWnlLSFk2bGdjQjNSbGRmdU1wTUlzS1N1R2d3OElpRDJn?=
 =?utf-8?B?TEUxVkNVeHdWQ0wyRU9kSTBpZE5XVXN2cW41Tk1sRWVwdi9Eay8wQ0V4U3FX?=
 =?utf-8?B?ZmlBZXhhTktwMi8rZnJNSmVLVDdaWnVZbncvMnpIOU44bVl0RVdTakk3Z0pX?=
 =?utf-8?B?aytoUWRGVUxtNVdwazZjcDhrbE5ub0NJaUVVTU5JR2pWUEZKTXZoZERkd1lz?=
 =?utf-8?B?WTJMazRWbDFIU0lxalh5V3pMeEYyN05pQ0RQK2p4L3phQmpDZUwwcUNjTWJJ?=
 =?utf-8?B?Ym1FcFpJS3A2ZDZBdE52cXNRWVFoR3lMNUN3UXF5aVZIUk5WSGl3YU9kMklJ?=
 =?utf-8?B?d2E5V3dWampqbzdwaG9tMWc2bVhVQUthdTJENXRzNWI3ZFVIUkdZd1lOblRG?=
 =?utf-8?B?Rk1ZOERKaUlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB4702.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUpKdU5CK1NtZm50R2I4OHRLYy9DUStocEtUZUI0M1FGS3MyM1RuTkpvTGxC?=
 =?utf-8?B?SVBkQWZwYkxZZFpqVzUrZzVraUpQOFNWeUdhUllWcEE1U00yakRTcmFRRDE1?=
 =?utf-8?B?RmZFMEs5TjZoMWpmL3kvanBweU53M01BU2tSVjhmV3BQKzRQaGRyc1JPN3RV?=
 =?utf-8?B?Q1lzZTJhNmk0WmlPdU5sNGNoc21abTZEelZxWjdJRDBUV0diTEt0RWxBZjNw?=
 =?utf-8?B?dzQraHFYUS8rV2J4THdCMnlWTzhnRU9hTjhUazBLSWUxOEN3RU14aGErNGR1?=
 =?utf-8?B?TUsrLzF5bUFLOEM4UmplUFF4NStIKzR3VnA0SnFPR1liZ3RYbFZaT1I5djdr?=
 =?utf-8?B?NGNCR0JubFo2T1ZnMlBXVHJKRFloQkNkNDNwRGtuYkNDMFVLdnBRR1I5M1R6?=
 =?utf-8?B?aWdiTGtoUjBPWFFKWmdrdmtCQ0x2VndSVTdIQU5HMjc3b1d3RkorTG54QWEv?=
 =?utf-8?B?VkdmWXVUWVpVRmRZRnlITkVoZDNQMHdDMUFjVCt6TlVMT3ZFZ2VNeDNUTWdo?=
 =?utf-8?B?UklSU0QzcXY4ZUpYV2N2MVBGK3lNeUlQMnRlbDF6VE9XMlFweHVZczEvNTls?=
 =?utf-8?B?aVpia0p3NXR3bkJ1b2xzLzUyRW0zaEtSNHFremVUSW5CS1lUVHNZMEZteFpW?=
 =?utf-8?B?dU91UWZQQnp3aDB1ZEl3UG0zcE9PbTRPOWlzNnE5WW43dVhIVzdYK0VlbUpo?=
 =?utf-8?B?NkNXV25iRTh2MjhkY0VEVnJ4Q0YvRFpJbHNCUk5wQkxZcWdXZ0ZYMit6OTdZ?=
 =?utf-8?B?OU1rUmpCUTlxWDFDMGJFaVVhR2RxNWNYbzUxZ0NZSCtyVi9oaTdtWk12KzVr?=
 =?utf-8?B?aExHbDRxWlpqNHhCWDc5SGpWZ1E1bitqNE5MYVU5TFB0dVhaYU9OMElwTVIw?=
 =?utf-8?B?ajJJUm8vU1hjcVIzT2NzNS8vd0xpTXR5NU1XN1JVZHgzT1BXNklPelBJSGNC?=
 =?utf-8?B?NDJNVVhtOW5Ca3ZPNHpUeCtjeWRqdjRZVUc4MURRdkw5MjlrT1RwNzdENmk4?=
 =?utf-8?B?R0pQd1NkZGZrQXlybVBSOHl1QnpyYVI3Vkp4dUFHQVU3WEtXVVA4ejNyRnVR?=
 =?utf-8?B?ek5HZ0NHN25PQ2dGMEllRzZTVCtuaG16YVVENHVJeFhxMDljd25WbWsxNUlQ?=
 =?utf-8?B?QnlKaVhBTG1qbk1jNGQ0WjM3TnRMYnVvUzRYd1QzQ3ZubEJqV05WZlg4WnIv?=
 =?utf-8?B?Q2RlemtUb0l5TTd2Y2JKMklzWHAyeHd3M0FXVTZwVWxnOW1IZFpvZE5Td1lP?=
 =?utf-8?B?R2d2OGh4em53bEVZeEZ2bEloUTA1NUdQUkJnN3h1OTFkSy9zSWJSZklKK3Nl?=
 =?utf-8?B?MENaTnYxanU1ZGtabytzZXNGcmU5bXJvU0dXWXNZejk2R0lNZU1JZ2dQZnk4?=
 =?utf-8?B?Rk50dlcyMTdnZWIxS01Sa3JhU2FBZnV5UHEwd1cvUHhTMndzbFYxZFVUc0Fn?=
 =?utf-8?B?alZ6WkJZbnM0ZWZ3V0RRVVpFVXd0a3ltS0FRSGtvdCtLcVVBaVc5a3AySEhN?=
 =?utf-8?B?YXByYWNETjY0YW1XZVBwTDFrYzJCalI3VFVlM3JhOXF4OUlYcnVvZVBOOCt3?=
 =?utf-8?B?Q1Z6RW9VeTY1enZvdm55M0FYM1hpUlhWSTA3OFpBTmRPSnJ5L2NuWlMvZ0Ju?=
 =?utf-8?B?eVk2eTZ2RVhXbVVhcjlURks4TWhYZ2JabUFJM2pQNXlTWEFBMVJrVk1Tb25D?=
 =?utf-8?B?ekRTMExSdllWZWI1dnlCUmRUTk15eUFOcjJSamloalFEZDVGRS9vdWhqVUs0?=
 =?utf-8?B?THlSQjlBeHY5bFJaWDVhUXVsU3dSNFR6MDNWRlpTck52TmhRejI4RWVCR2h2?=
 =?utf-8?B?MGhKbEpBSVppMmt0ejZoRDdLRkFPYjdUYkEzbDdndkk0bUJGTy9KZzhJdURD?=
 =?utf-8?B?TzRLMmhkd0NPZDJjc2x0Y2V1TEwrSUVWL3h0Vk9TN1BvL0VVQ0M4QklxODAx?=
 =?utf-8?B?QW5DbjZwMUxnK3RWZThWMFU0Zms0bGlOd3A2L0ZaRjU3N3l6eDdoeDkzN0c4?=
 =?utf-8?B?ZisvY0hjSzd2YnNUam1iTWdlYmlmUEFqN05rNkJwUW5nQzBITTFhL2dpNmlI?=
 =?utf-8?B?MnN2QWk5RUh6cCtlMXFaZVBDVENHL2VjZmZqcnJPQnhMN2hQN0NTTExjQjYy?=
 =?utf-8?B?S0k1dHBjbUVVODFEdUR2SUdSdmVhWGZ2VzloNnFFY082VnRXOGEyVXMwdG5r?=
 =?utf-8?B?OWxkQ2tGc055NlEreW9Rd2YybFV1bVNHT1ZmdGhZSFJzdDQ4SFkxTDBkdzRl?=
 =?utf-8?B?VWM4Um1aS1Q3T2JrVkkrcDZmNEtFR0syZDJwRmR1aC94eCtiYzVHNDJuanc0?=
 =?utf-8?B?YVgzQzBMMnNSTHZCVmlmRTVwWEdGMkl4RzEzVXlaR3VPYzZSTEY4VHp4U3NB?=
 =?utf-8?Q?aB0/9kvqr6btMl1I=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3dc1231-a2e2-4f82-4276-08de52d5c726
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB4702.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 18:58:45.8214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ot4ksbuJ2Q7FJCxpK6NgihHyugbXBhYIIK7TJKn0FtFPhdMGDCA+9Kr3WiSIOtDs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR15MB6748
X-Proofpoint-GUID: oKG-WHFV8kUbiJLlVNKFtzlexwqW4t73
X-Authority-Analysis: v=2.4 cv=Zs/g6t7G c=1 sm=1 tr=0 ts=696695e8 cx=c_pps
 a=VvAZzv+PhNtEUaR8E1V7rA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=_6oNEXWrAAAA:8
 a=fNApumC3obCzAFuWDWIA:9 a=QEXdDO2ut3YA:10 a=mLrRVkhqScQVivb2I5cY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDE1OCBTYWx0ZWRfXyp8QJTN2no1z
 nbli9ZFjQysWH8zC617Ahdg79ffLbS5yj2H56UHm2+DrCyzs6rRlzzdLS9QvLT6LtgxTSzKRa95
 9bsJ5qJT1tNp4YeAeI6qpr510pfkZ2hZEBwdcSAr6uXYpZrjFAFVCrhKV9qyNH/UZLqwagdVH/Q
 r+0XfRcrSGP1MdI4TUESwdhC3fPpGrMZo4utahZobpr94OFhILR0kIaK5WPfgbD0rz+js1rfJsl
 /elXKeaLwXuSIexGcUVpx04kRun5GEXroQE2HGV3X2tJ+xLyXZzc9OvyEk519U6w4c86R3k4+CB
 ASc9B3KYbTGrqTSHuWwQZJdbYsBeD6j2VSpBHH3vm3qZIrKvIYvW8eC45O4M1+HXW9b2qANBOyj
 X6XuWFbYRny/wSTIniIUoyrwUHgtJI9+hNmdhnJZADoOqMv2yMZN3ZUSHzzQ/kC7DwCLm9izPPs
 PjAXpdnLIVqbn748ypA==
X-Proofpoint-ORIG-GUID: oKG-WHFV8kUbiJLlVNKFtzlexwqW4t73
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_04,2026-01-09_02,2025-10-01_01

Ilya, can you share any context for this patch? Do you have any evidence 
that `proba` can be negative?

A discussion was just started about this patch on the zstd repo [0]. I'm 
happy to discuss this here or there, whichever is more convenient.

But to my first pass inspection, this seems to be protecting an 
impossible situation. (Separately: if it could happen, the correct 
behavior would to catch it and return an error, not just skip it like 
this patch proposes.)

Thanks,
Felix

[0] https://github.com/facebook/zstd/issues/4567

On 12/11/25 12:19 PM, Ilya Krutskih wrote:
> 'rtbTable' may be underflowed because 'proba' is used without
> checking for a non-negative as index of rtbTable[].
> 
> Add check: proba >= 0
> 
> Cc: stable@vger.kernel.org # v5.10+
> Fixes: e0c1b49f5b67 ("lib: zstd: Upgrade to latest upstream zstd version 1.4.10")
> Signed-off-by: Ilya Krutskih <devsec@tpz.ru>
> ---
>   lib/zstd/compress/fse_compress.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/zstd/compress/fse_compress.c b/lib/zstd/compress/fse_compress.c
> index 44a3c10becf2..6b83f8bc943a 100644
> --- a/lib/zstd/compress/fse_compress.c
> +++ b/lib/zstd/compress/fse_compress.c
> @@ -492,9 +492,10 @@ size_t FSE_normalizeCount (short* normalizedCounter, unsigned tableLog,
>                   stillToDistribute--;
>               } else {
>                   short proba = (short)((count[s]*step) >> scale);
> -                if (proba<8) {
> -                    U64 restToBeat = vStep * rtbTable[proba];
> -                    proba += (count[s]*step) - ((U64)proba<<scale) > restToBeat;
> +		if ((proba >= 0) && (proba < 8)) {
> +			U64 restToBeat = vStep * rtbTable[proba];
> +
> +			proba += (count[s]*step) - ((U64)proba<<scale) > restToBeat;
>                   }
>                   if (proba > largestP) { largestP=proba; largest=s; }
>                   normalizedCounter[s] = proba;


