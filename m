Return-Path: <stable+bounces-200185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6F5CA8BA6
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 19:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20DD33010F1D
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 18:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3690A280327;
	Fri,  5 Dec 2025 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SxYtcbsg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J0HAGjhg"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A48E11CA0
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 18:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764958224; cv=fail; b=LjA2yhRTFbvnM9uo0hkr8sSoGCfObuIB5MoVW/0EUZjV2OneNeQexZSITSzQoBb6JcFZ7i3SBLsiIbLYdGim+XzFMjsDwxeT3gcy0B8uHGB3iS48BBNCWZr1/aGMfhcfpNdyWE9ElKY+6mWJ2retRrjZ6uSrobc4zhujZeL51i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764958224; c=relaxed/simple;
	bh=Hx9nGj9qrcQkXtY8QoaaCGqou3tP02AofaIlexhYHzE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JL38a8laOBQHYay6tXTScHQ3yKZbGkzvDH/rsx8Su2OSRnR8kdoGgb70lsXDbm9JkiXTaEf52G5JNPqT6jAT32n8CdJxyikn9OwdoT6CPvaUeMkYk5VllJDoLsS4jFrZx+y2EnBNhZjR331K0yQikHesJ/e8Lr2LAdtCP+GTT5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SxYtcbsg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J0HAGjhg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5HZwXu259576;
	Fri, 5 Dec 2025 18:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=psFQGeSfE0lvpY9ViJLrJc5Cc8R1Bz/baAH33J0Vljs=; b=
	SxYtcbsgYIJVTYhGnEHpF+sdXtgg7UxjVzWbaN+dlZ1++o3CwOAKNEMlg/JS7cZ2
	umIwOs69u+D5E9oTjSoV1dNGMBx4G0vIwkRdTuzJUSIG8kv24j8uGv/Rp6JBAYLS
	q0TWn1LguoC5zo6Z8cN/oL5xobnehVkrclyDnWeJdrbHUjsTzrWwRbL3PSS86YqO
	xadBiQBdZ15gEHbPllM5ulUoI8lSVgEYm1s2ih7P20EjASJhiu3DNpTUEq6SI2/V
	54grfoxOubvVbrlZhtqY0im2ujEgreu94v2ZuT/KQ+GjhcJPHfWGgFG+ENZNXiYY
	13wscP6NTdv+Mmi2g3nimA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4av3xa01y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Dec 2025 18:10:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B5GJAXE004715;
	Fri, 5 Dec 2025 18:10:13 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011070.outbound.protection.outlook.com [40.107.208.70])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq9druf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Dec 2025 18:10:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofWXBS47kDV4Y/aXlT/iJ2ZjSe6QSYPEM/18CL9oxs3I2hhipNqWinj4lAKQzxMsPyGdnlurMB34J+VznQfEfo9YJ/K/cg0Y8tYlMBfmgtm8jhZYorujIeq6fPrs3uOag8Kcfq+n3F+K1Py+DWG8iAKz4+kmTLvXcQhBLWBubkJ4kmiWyyyB17cFf+sqDALz3qhzSR7l6yTUeVguupQWC8CrXEGDsxm5EF7rGlplYkmqRMnJ6wjyAgLhKLXeNBl7jvdWYbokx9AdDRRv2+/I/Je7KHjBh5xlfhS/Fz2n976gBF4PmOnoxaTaZy4qVMR4m/pSGGsEyA2qiYzCFYiHDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psFQGeSfE0lvpY9ViJLrJc5Cc8R1Bz/baAH33J0Vljs=;
 b=Asn94q3q8tXFcLmRdXyuYK8YC86Im7Jo2MpqjPSqo9AKpQyMAKtb2ZqbmSdSu2mh3PjY9LmZ2DiQBNyPpTLhJkAFFanrY5vc21BWfAtGfgfzMStVwC2oqZmKYJLdJ2LY7es/G0WgmsjLjsveUtEXN9DTjxTxFG7iW+giBQ4exoQMwm7rz83k3H8HDz+e3LJ9KpVyKAQhyjPGOQI0TpmLEycuSxF+fOqA9X27at8PgMjG4/K26AM3Wau1giJfHYGuwX73bX9StufaIMXQgQvYYk0waEwvKz7sAedJnI+cPoBZDI5shmQMaflFqyVC60DaCjrxkU+QQnyPUwcoeHp4+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psFQGeSfE0lvpY9ViJLrJc5Cc8R1Bz/baAH33J0Vljs=;
 b=J0HAGjhgWwYsu3qGytqjWprvoPqwnLvSSS9yobiOuHtX+4yffGg8oqCvRCTY2V3p5S4twBiwlHXt8qUgMoe2ZHcrc6qB3ifQSw528IjxXxtjEjSQ+dyqne2OloAaEF2+1sg3UNPzuD5PrHFZ0D2Osii3BwKU6OJ6j3fQ2Xo8NlQ=
Received: from IA4PR10MB8421.namprd10.prod.outlook.com (2603:10b6:208:563::15)
 by LV3PR10MB7913.namprd10.prod.outlook.com (2603:10b6:408:20f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 18:10:10 +0000
Received: from IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77]) by IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77%6]) with mapi id 15.20.9388.011; Fri, 5 Dec 2025
 18:10:10 +0000
Message-ID: <ea735f1a-04c3-42dc-9e4c-4dc26659834f@oracle.com>
Date: Fri, 5 Dec 2025 23:40:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [6.12.60 lts] [amdgpu]: regression: broken multi-monitor USB4
 dock on Ryzen 7840U
To: =?UTF-8?Q?P=C3=A9ter_Bohner?= <peter.bohner@student.kit.edu>,
        amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
        regressions@lists.linux.dev, bugs@lists.linux.dev
References: <9444c2d3-2aaf-4982-9f75-23dc814c3885@student.kit.edu>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <9444c2d3-2aaf-4982-9f75-23dc814c3885@student.kit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::25) To IA4PR10MB8421.namprd10.prod.outlook.com
 (2603:10b6:208:563::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8421:EE_|LV3PR10MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: d6078be3-c3f5-4472-1d12-08de34298767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjFUUm0xcVB6V0hqc2xTeXg5dld2M3Y0NjQ4VHR3UXRTd0NkeUpQTWlSSTZs?=
 =?utf-8?B?NzVuc0hPdkNmTG5NWUlETnVydGRISlM4VEpnd29rZUplWFRQQno0bGJPQlpm?=
 =?utf-8?B?ZXVjRDgyTk4yOEZYYXZuc1duaGlXYW15VmcxaFRwaUw4QWVpS3ZlTDRBdGpB?=
 =?utf-8?B?cXp3MnhRVVV6UWFBNFdGTysxYUFrcUxYWDMyZ1dFSzdjbjR1U3k2VWNEYkdq?=
 =?utf-8?B?UllCdHRkZm9zWVRPTERvY2QydWd2akVsUGUvZitLRDZIVW0rYjYvNjgydXpv?=
 =?utf-8?B?RlVYZzU2MFhxSHZPbkF3SUs2ZlUzNzNpWTRaam9wOTZ3N3VHZHB3VjV3SXhK?=
 =?utf-8?B?OS9LTXRiVldlYytMNlg4aG1JQW91RDJhT2tZbW5HNzZIU1NoeWFDUHRWNXFX?=
 =?utf-8?B?bVF3OXJpOFlabDVKcVhsNzhRcHpvYjZIS3JtWUkvMjhiN1pRVUR0V1pQTmlJ?=
 =?utf-8?B?bk9vQ2QxVTNha2MrRWtna0tPdHpjb2F1Q1dpMkJFcUhvVWgzOElqN0FPM2xN?=
 =?utf-8?B?ZDVsTzFNazBrWTc0WUFTdE82dlU3SHpBcWtPK25lRVE4Ykl4R24zZzFsNG9a?=
 =?utf-8?B?VzFvNFBVMHFxV0daeERLbGRNUE4wcVFvSTNOYjN2MUZVM1hJWkJoelRiUXpK?=
 =?utf-8?B?eUx0MUNuZDBJWmlUVk5DWjh1aFBnd1VCNVQ0SXJqa2xZNlZBalNXVlhNeWlu?=
 =?utf-8?B?UE1wVW1sWGNjbndlQVZ6NDVNa1pET0ZJRHdnK1I3K1ViSnNhc3B1SHlMU2kz?=
 =?utf-8?B?aGxoMDlEeklJeEsyeGJiRmtnRC9aUjl1VGRSVnRybXVkYVdGRGN3YmttUjQ1?=
 =?utf-8?B?UkZ2Y2Vqa1VjSlRvY0tHSjVDdVhBMjFTR3MvcFdlMFpzWWlpd0I5RStIbjVG?=
 =?utf-8?B?cDdrcjduNk50aE45MDg3WlhYdmFvcXRQbVVSWG5tM3ZNZkNJbTlTUnQrQmRB?=
 =?utf-8?B?QnFEekgrc1BaZTV3MGtIMGdNU0tYbGtRZE16VXhNcU92N2N2c0tmbzN2cVB2?=
 =?utf-8?B?ZGg4N2ZpMFY2QU9wNHBHU1I0R2dwb2lPeFJlcDB6QVVmT3ZDekVhVVRiK0gy?=
 =?utf-8?B?VkUwSVZFRUd0UU5POHhHRXB3YkdtZlhHb2ZQYVc5cWVuMlU2N2JpUGVSZUhK?=
 =?utf-8?B?Vm1UWm00cjJVclI1OHczTkQ5NnFlRGcycnBvTm9VSTlMbk1oV2lCUXZDUUQ4?=
 =?utf-8?B?bXFVSjhXbjJ2ZlNGeUp5NjNUc0lWTDNqUHd0TzNqRVNzMGxySm43bW5nMm5a?=
 =?utf-8?B?RUpQMUNVTFUwMTlMOEtoSG9yYkZ1cm9OeWFsS3JhMGZSWkk1aFVjY2ZiVlpF?=
 =?utf-8?B?c1RIRXF3eU1IQXhQSVd6eWpNcWYrVW5jMzRsZjVqSDZhUEFCY0tDbDNvYkx4?=
 =?utf-8?B?Sy81T01PYzRIamtxK2Q2SmR4dTJGZHRBOFNTbHFpZW4vWWNHc2JkTFBwN2dm?=
 =?utf-8?B?cDJFUXJWS2Ztd3kwbkpyemIweVE0M2NJbzJYQlZvK3JvQkx1Qm5ZaEJBQnlT?=
 =?utf-8?B?M2JwazVCcUh6WW9Ka3pHdWFrTi9mOWxweGZxM3VIdVNxWGdYMmlxRi9aSGFC?=
 =?utf-8?B?RDFLNzFyekVXOEcwaTdjVC9Da0VZaEdFK0xCYjFtUy95RWlDbFNwZHVvTFk2?=
 =?utf-8?B?UEVIWEM1QmlXRW1RRXVVdmxWY1FQZFRIMGxNV3BnSDRzWE9jRlE2Q0dlcDZa?=
 =?utf-8?B?djRWZDNzS05XVnN3WWRDMnEwV2tIcC9ROE1hQklaN1JQZW9CdkF1M25ZNGdF?=
 =?utf-8?B?Q2RVWHo5aDJyV3NmY0JvRUloOVk1NldLUDNJQTg4NllPc1BWS3ZkTWRLU1ZO?=
 =?utf-8?B?V01OWUxZR2lzcFRmdmxybE9WNzZEWC9HNGVoVElmcXNLY1p3MW92bEZxOUZs?=
 =?utf-8?B?WldldUZGZjF3azFtYlZwbzd6TzVQbWZnNlpHZkZsZjlHRHBadkFMcWZlNEhv?=
 =?utf-8?B?Ry9ObEg0S0J5UFlVS2drNUdvbVIxNGFhNmRIUWdqdVdHMjIyTFlMNVhnaDBI?=
 =?utf-8?B?SWNDSzZ4K3BnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8421.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mm1MN296dmVUOHFLbDNKMU96VitaSXMzdXAyM3ZzUVVYZG1xWkFUcDFrOUxO?=
 =?utf-8?B?enBSSTVzMTNJc3pwL1A0aHFTWmVlQTJSWEgweTArRHFMWEtDQXN6K2dYQkZm?=
 =?utf-8?B?K25VWjNmUGl0RmdYMGNTUDhYR0VoMG1QSnE0RzZmZU8wdng4RHpqS25XV0pH?=
 =?utf-8?B?djJZSGlEbnJvdCtCSUs0azZOVEJUM0FnbEtCa3lnbzlDVEFFbHl1UnFFaElT?=
 =?utf-8?B?WHVTQ0hhZkR0SHRGTzdXSFV4Rmtmdjgyc2doMm9kWWtYdExlUWZlZzZRUnJY?=
 =?utf-8?B?OFZKdWQyN2ZtVmNTRjVuM2dicmJYTndFeGx1SXlDYW5URVNrZWpwV2oxRElH?=
 =?utf-8?B?UEtRajJRUnBmQnNrU0xXV2VKREJFMjd2L29TanUzNjQ4T3laUDFpejNqakYv?=
 =?utf-8?B?ZFdmV3VtbVg3d09Bc0xmMFUvVzlyNkxCTjlRMTVoVVFaS1MrdXh2WjloNDhB?=
 =?utf-8?B?NVJ5ZnJ5L3krdmxzMnA4SGhRU3FWa1NRWFk5RkVwaW9mTDhqU3gvRHN4cVFj?=
 =?utf-8?B?RlR5YmJJOFV4bjE1SWoyNjg1TURzYWVST2dRbDQzK2lNWTVFODYyVzYzN0x4?=
 =?utf-8?B?aU1OQjcyK0pMdHF4cUo0NndSR3BVV1pTL0R6YWNmOVdKdnJRVW1OWTZxREIw?=
 =?utf-8?B?S3FnNWVNdVlYT28wN1RQZzEvU2lBK1hnNWJhZFBFaytQUGNNeG9XemN4T3BC?=
 =?utf-8?B?MjRuRlVyeDl1K3lMTlpLVzNaZk5ONEdjUFMzZmZod0RrMThnTC9rOGQ4cDNz?=
 =?utf-8?B?REJqRlhlVlpIVlVrdVhrdHFub2pRdDhFUFA5bUI1cVMzWjJjV2J6THlTdldX?=
 =?utf-8?B?WTgwUTJWMVc2eGlBN3NvQjhYY3hRZ1NLY29idDYxcnNSSVNNYWxsN2dKZGRE?=
 =?utf-8?B?Y0Fxc1EyTGxQYVN0bENPbVkwSzhVbTlWV3liRC9qUEIzdmsyaWoweTVxQTE0?=
 =?utf-8?B?dEt4cmxPTWwvbnN5cHZCQzNLQ2taMjVLWndxRXVTZ242UjhzNXVLYnNPM3Bs?=
 =?utf-8?B?RWlWVFZCSHQ2YVRsZjR0Vm5rTll3Z1MvaWt1TUJxQlFKTW8vejlLTWJ5emN5?=
 =?utf-8?B?K0FVWEhmS012dnlsMnNKL1B5VzZVVW5SekU5c1EvWUNZUWVwZVpZclhlSnZB?=
 =?utf-8?B?a1FiMDFMUW5MVi9oNEljZGFGWWZJdGsvaUo2SHhhT2hwVE9ZcHJHbEdPTFdP?=
 =?utf-8?B?bFdJaE1zQlc1amRoZ05pSVdlM0g0RklONnBFRzJRS2M4dWdOMWM5cGk5MGJZ?=
 =?utf-8?B?QjhvelJIdUtwUEpmY1J1TzNSTjJlZ3lHSVVzZCtFeDZJcVBEeGtKOEZ0c0RH?=
 =?utf-8?B?ZVh6UVZ0a3AzTzFlMzlQYUpaZmZZZjJwamFQMXFySGI0b1c4aDJ3ZWphdW9a?=
 =?utf-8?B?TlZhZ0NpMXJ6ODllT1lTT1R2WldZdlIvYTU4ZCtIVFo5NzFVTzZUUldlckdM?=
 =?utf-8?B?T05NUUdYYXV4ZnFIYVkvWUpEQzFwUE5oY3Y1c2IvTlI2RWFaMHk5QUFxU3Bi?=
 =?utf-8?B?eE5aZ2FrSVZLR2JpZkdSZFdVUk9Gck5jUXZreFhmejd6RnlzVTlCeXhxRDZs?=
 =?utf-8?B?bDVKdlJtYVZEV2RJUzdvRmhKbm95V0wxY3dvc1c1ME15cEVsc0ZlVEpHQ1RL?=
 =?utf-8?B?RW1nRkpjaGdnM1ZZRHUzRGRuZmswVkdnMXEyNUdCV0VaSDhwUWplamhHS01L?=
 =?utf-8?B?aHhTV2dLOXduWmxhQ2pYYzBwL1NxR2tuWk0wdFU3THFFc3dYamJHZy95VjFH?=
 =?utf-8?B?ZCtMeStSeG10UW5JRmZYSjA2VnJ6YmpCMlozQTVMTXl6TDZBWkFaT2pQejRQ?=
 =?utf-8?B?Y1B6Qk9IaWFGU2d1Umpra0w0OWxhUm44VVhHT2d3UXVDVlBtSVVaSXUrcnhM?=
 =?utf-8?B?bC92YzI1YjgzdDJ6UlpmSDhsTDNTM0ZsMmZqTmdwdURVb244SDcrV1Q3Y2N4?=
 =?utf-8?B?WmNsbmhLVjVHVDdndWhFczNKVktwVHF1T2lmcVZQVGwyTUFiUTVLa1duSmRK?=
 =?utf-8?B?VWYzdlFhblRhdjNHVVlxSW13UGpqWWo1SEhLYmNBMUhORXRIYUg2RE1BOVBH?=
 =?utf-8?B?K2t1d1ZmZ0NXWU1VS1VlNDFCWStzYzZNdTE0WEI2UTg5QTFqTDhHdEhSZnF1?=
 =?utf-8?B?bEpjdkRyanJLNytiL1JwREZuSElhSjNBUnpmS3pnL0hDanMwM0s0ZG1xd0Z3?=
 =?utf-8?Q?h9/xvqfiZ38Djoi6HM3vdP8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aOsQvPAPdjtMzvbRdUIP8YQy2Dn6udbph6x9q3FyQi+vXT2PwFUzNj+iG+pMTXypL1giVKylHtDbDb0eRqRQgGpO5TXKEDmQrWbcdE1SuozkPiwhFrtREtLoEtCQnmqtgXzQsmgbUS/FrHK8N1d0agJDUkNGv55lKWHOOfV05TSE18e0R6vUCKWjVz3cw088yionH5Ul5ah7pb2ZLdlV0WR0dvjDbgmRTTEqmXn0N0q85HFC+as6d62qLDQZoSt9IjWAaqnambf+QRrOLc2SZUE9HyNytfta6X9XSwGNQmJsmifxY7BsZnGjUeETsxYQPPJ1SaPv6WOCM8O5/1h+VpzF83r1w49EZsyC/D0KebauqLCBm8yceazwh56R/SnZSLDPi8ucZc2ViklBGy4p+lrlodw/VtbEjy+XOXfPDQwufjND9G+EUBE48eOmPRLrQPt1okYsgZcbvrDyIWtQ+1Mmh7XTrdsQmLg0clFMdZi+QnvHvFY+p6pOFIa+6MR+oJGrjTzpe1Qs6LaOZ49hm7wC96mf1YMWjeF2PEADBYgjju99hojbeVt4u+nAjAfaESUBCGs5iExgSqYh3hbinyeqh40dvzK7L8dbiZA5Sd0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6078be3-c3f5-4472-1d12-08de34298767
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8421.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 18:10:10.5055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dvo8B1F5g//1OP0a3+5KCWJ3SEQCvqtgPrnQtvaDbHq+HVKB51MZdvqEDIG2pedg9gy//sJYkD2cnFt5EVCg64uKjwTk+96QFIkMvW/ftVziqRzxeV1K5bKtJgqktfsX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_06,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512050134
X-Proofpoint-GUID: VRPejsmCbFZM19tr_HwuzP3eVhKXHC6J
X-Authority-Analysis: v=2.4 cv=KdXfcAYD c=1 sm=1 tr=0 ts=69332006 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=4Va27nFGvePv3xnm1v8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: VRPejsmCbFZM19tr_HwuzP3eVhKXHC6J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDEzNCBTYWx0ZWRfX/Dgf+IDDhjAe
 IVNYQXMvE2Vl1h8rjbdT/lk9pnU3J3DYM0ioeBE9xIlTEQTfdj8Pd34TRM0LE4K98k34+uT9XAT
 u7BT0UE01cXKmH8RKXVHz6Vq/kkmbEIJlA/ZZaAFTRuHLU/CNIvIrPj5JGo6+Uum/LNB1lppit8
 47hoLXUjxk2TJqPE8SkAFwrwGYDdG3nnwXzy5L4eeQq+WO48j8ydh7SA+66PYyloodfT+lKbTQr
 0jyu8BV17HBsEqKNoeqEgXNgvWjlxsLk40pBTJetorDGKcfP5JkvkO0mKCq4AKjpIEnm20R/pO9
 0ftWdarPPwr7f7XUSFMuvp835sX6Ew9SKN8MpvrjP9E3VjXO4lU6HTbHC55LxHR0xmDrTzkcWeX
 scKJdaNrQ22K7RCzeeeVbfgNljRbOg==

Hi,

On 05/12/25 20:52, Péter Bohner wrote:
> upgrading from 6.12.59 to 6.12.60 broke my USB4 (Dynabook Thunderbolt 4 
> Dock)'s video output with my Framework 13 (AMD Ryzen 7840U / Radeom 780M 
> igpu) .
> With two monitors plugged in, only one of them works, the other (always 
> the one on the 'video 2' output) remains blank (but receives signal).
> 
> relevant dmesg [note: tainted by ZFS]
> (full output at: https://gist.github.com/x- 
> zvf/128d45d028230438b8777c40759fa997):
> 

Just a note:

This looks related to whats fixed in 6.12.61:

https://lore.kernel.org/stable/20251203152345.111596485@linuxfoundation.org/

Try with 6.12.61 maybe ?

Thanks,
Harshit

> 
> [drm:amdgpu_dm_process_dmub_aux_transfer_sync [amdgpu]] *ERROR* 
> wait_for_completion_timeout timeout!
> ------------[ cut here ]------------
> WARNING: CPU: 15 PID: 3064 at drivers/gpu/drm/amd/amdgpu/../display/dc/ 
> link/hwss/link_hwss_dpia.c:49 
> update_dpia_stream_allocation_table+0xf2/0x100 [amdgpu]
> Modules linked in: hid_logitech_hidpp hid_logitech_dj snd_seq_midi 
> snd_seq_midi_event uvcvideo videobuf2_vmalloc uvc videobuf2_memops 
> snd_usb_audio videobuf2_v4l2 videobuf2_common snd_usbmidi_lib snd_ump 
> videodev snd_rawmidi mc cdc_ether usbnet mii uas usb_storage ccm 
> snd_seq_dummy rfcomm snd_hrtimer snd_seq snd_seq_device tun ip6t_REJECT 
> nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_multiport xt_cgroup xt_mark 
> xt_owner xt_tcpudp ip6table_raw iptable_raw ip6table_mangle 
> iptable_mangle ip6table_nat iptable_nat nf_nat nf_conntrack 
> nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c crc32c_generic ip6table_filter 
> ip6_tables iptable_filter uhid cmac algif_hash algif_skcipher af_alg 
> bnep vfat fat amd_atl intel_rapl_msr intel_rapl_common snd_sof_amd_acp70 
> snd_sof_amd_acp63 snd_soc_acpi_amd_match snd_sof_amd_vangogh 
> snd_sof_amd_rembrandt snd_sof_amd_renoir snd_sof_amd_acp snd_sof_pci 
> snd_sof_xtensa_dsp snd_sof mt7921e snd_sof_utils mt7921_common 
> snd_pci_ps mt792x_lib snd_hda_codec_realtek snd_amd_sdw_acpi 
> soundwire_amd kvm_amd
>   mt76_connac_lib snd_hda_codec_generic soundwire_generic_allocation 
> snd_hda_scodec_component snd_hda_codec_hdmi mousedev mt76 soundwire_bus 
> snd_hda_intel kvm snd_soc_core snd_intel_dspcfg irqbypass 
> snd_intel_sdw_acpi mac80211 snd_compress ac97_bus crct10dif_pclmul 
> hid_sensor_als snd_pcm_dmaengine snd_hda_codec crc32_pclmul 
> hid_sensor_trigger crc32c_intel snd_rpl_pci_acp6x 
> industrialio_triggered_buffer snd_acp_pci polyval_clmulni kfifo_buf 
> snd_hda_core snd_acp_legacy_common polyval_generic libarc4 
> hid_sensor_iio_common industrialio ghash_clmulni_intel leds_cros_ec 
> cros_ec_sysfs cros_ec_hwmon cros_kbd_led_backlight cros_charge_control 
> led_class_multicolor gpio_cros_ec cros_ec_chardev cros_ec_debugfs 
> sha512_ssse3 snd_hwdep snd_pci_acp6x hid_multitouch joydev spd5118 
> hid_sensor_hub cros_ec_dev sha256_ssse3 snd_pcm btusb cfg80211 
> sha1_ssse3 btrtl aesni_intel snd_pci_acp5x btintel snd_timer 
> snd_rn_pci_acp3x sp5100_tco gf128mul ucsi_acpi crypto_simd btbcm 
> snd_acp_config snd amd_pmf typec_ucsi cryptd snd_soc_acpi
>   i2c_piix4 btmtk bluetooth rapl wmi_bmof pcspkr typec k10temp 
> thunderbolt amdtee soundcore ccp snd_pci_acp3x i2c_smbus rfkill roles 
> cros_ec_lpcs i2c_hid_acpi amd_sfh cros_ec platform_profile i2c_hid tee 
> amd_pmc mac_hid i2c_dev crypto_user dm_mod loop nfnetlink bpf_preload 
> ip_tables x_tables hid_generic usbhid amdgpu zfs(POE) crc16 amdxcp 
> spl(OE) i2c_algo_bit drm_ttm_helper ttm serio_raw drm_exec atkbd 
> gpu_sched libps2 vivaldi_fmap drm_suballoc_helper nvme drm_buddy i8042 
> drm_display_helper nvme_core video serio cec nvme_auth wmi
> CPU: 15 UID: 1000 PID: 3064 Comm: kwin_wayland Tainted: P  OE 6.12.60-1- 
> lts #1 9b11292f14ae477e878a6bb6a5b5efc27ccf021d
> Tainted: [P]=PROPRIETARY_MODULE, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> Hardware name: Framework Laptop 13 (AMD Ryzen 7040Series)/FRANMDCP07, 
> BIOS 03.16 07/25/2025
> RIP: 0010:update_dpia_stream_allocation_table+0xf2/0x100 [amdgpu]
> Code: d0 0f 1f 00 48 8b 44 24 08 65 48 2b 04 25 28 00 00 00 75 1a 48 83 
> c4 10 5b 5d 41 5c 41 5d e9 10 ec e3 d9 31 db e9 6f ff ff ff <0f> 0b eb 
> 8a e8 05 09 c3 d9 0f 1f 44 00 00 90 90 90 90 90 90 90 90
> RSP: 0018:ffffd26fe3473248 EFLAGS: 00010282
> RAX: 00000000ffffffff RBX: 0000000000000025 RCX: 0000000000001140
> RDX: 00000000ffffffff RSI: ffffd26fe34731f0 RDI: ffff8bb78c7bb608
> RBP: ffff8bb7982c3b88 R08: 00000000ffffffff R09: 0000000000001100
> R10: ffffd27000ef9900 R11: ffff8bb78c7bb400 R12: ffff8bb7982ed600
> R13: ffff8bb7982c3800 R14: ffff8bb984e402a8 R15: ffff8bb7982c38c8
> FS:  000073883c086b80(0000) GS:ffff8bc51e180000(0000) 
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00002020005ba004 CR3: 000000014396e000 CR4: 0000000000f50ef0
> PKRU: 55555554
> Call Trace:
>   <TASK>
>   ? link_set_dpms_on+0x7a5/0xc70 [amdgpu 
> d75f7e51e39957084964278ab74da83065554c01]
>   link_set_dpms_on+0x806/0xc70 [amdgpu 
> d75f7e51e39957084964278ab74da83065554c01]
>   dce110_apply_single_controller_ctx_to_hw+0x300/0x480 [amdgpu 
> d75f7e51e39957084964278ab74da83065554c01]
>   dce110_apply_ctx_to_hw+0x24c/0x2e0 [amdgpu 
> d75f7e51e39957084964278ab74da83065554c01]
>   ? dcn10_setup_stereo+0x160/0x170 [amdgpu 
> d75f7e51e39957084964278ab74da83065554c01]
>   dc_commit_state_no_check+0x63d/0xeb0 [amdgpu 
> d75f7e51e39957084964278ab74da83065554c01]
>   dc_commit_streams+0x296/0x490 [amdgpu 
> d75f7e51e39957084964278ab74da83065554c01]
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? schedule_timeout+0x133/0x170
>   amdgpu_dm_atomic_commit_tail+0x6a1/0x3a10 [amdgpu 
> d75f7e51e39957084964278ab74da83065554c01]
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? psi_task_switch+0x113/0x2a0
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? schedule+0x27/0xf0
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? schedule_timeout+0x133/0x170
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? dma_fence_default_wait+0x8b/0x230
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? wait_for_completion_timeout+0x12e/0x180
>   commit_tail+0xae/0x140
>   drm_atomic_helper_commit+0x13c/0x180
>   drm_atomic_commit+0xa6/0xe0
>   ? __pfx___drm_printfn_info+0x10/0x10
>   drm_mode_atomic_ioctl+0xa60/0xcd0
>   ? sock_poll+0x51/0x110
>   ? __pfx_drm_mode_atomic_ioctl+0x10/0x10
>   drm_ioctl_kernel+0xad/0x100
>   drm_ioctl+0x286/0x500
>   ? __pfx_drm_mode_atomic_ioctl+0x10/0x10
>   amdgpu_drm_ioctl+0x4a/0x80 [amdgpu 
> d75f7e51e39957084964278ab74da83065554c01]
>   __x64_sys_ioctl+0x91/0xd0
>   do_syscall_64+0x7b/0x190
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? __x64_sys_ppoll+0xf8/0x180
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? syscall_exit_to_user_mode+0x37/0x1c0
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? do_syscall_64+0x87/0x190
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? do_syscall_64+0x87/0x190
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? do_syscall_64+0x87/0x190
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? do_syscall_64+0x87/0x190
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? do_syscall_64+0x87/0x190
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? irqentry_exit_to_user_mode+0x2c/0x1b0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x738842d9b70d
> Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 
> 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 
> 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
> RSP: 002b:00007ffe3c7ed230 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000634abd49c210 RCX: 0000738842d9b70d
> RDX: 00007ffe3c7ed320 RSI: 00000000c03864bc RDI: 0000000000000013
> RBP: 00007ffe3c7ed280 R08: 0000634abc4049bc R09: 0000634abce43e80
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe3c7ed320
> R13: 00000000c03864bc R14: 0000000000000013 R15: 0000634abc404840
>   </TASK>
> ---[ end trace 0000000000000000 ]---
> 
> 
> regards,
> ~ Peter
> 
> 
> 
> 


