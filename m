Return-Path: <stable+bounces-69611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F789570AE
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 18:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096471C20C8D
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 16:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6391741FD;
	Mon, 19 Aug 2024 16:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="oxHAhN7o"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2071.outbound.protection.outlook.com [40.107.105.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921471422D2;
	Mon, 19 Aug 2024 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086048; cv=fail; b=Povza1dPV66mWyoxV2cqUBioRD58CM/m7rrs+9as2VUaiAp6RKWaIM1X60e68NvU2moDhOiQmC1O7e7nb+F4LH54NjVHy7fYXWibMyMFGkMey+8GhPOEktfjIeEj/ClQrV+AOv4iJIzteBSWCeakLqw2VciAjz7nXlA+Ar1VACs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086048; c=relaxed/simple;
	bh=Vjy4xFXKz5DKI63k5y+4R8F+XOPodgKoXAHnMFKrQ3w=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=nt0Sn/S4uXz4unj6nCLbl+EWMum1XaYU/LFhMf8HYjex3fJCqy/0aUmHbr8SWUiwSv9P14Cd1eygeek9cNxQDw/XR290kLWpMBj1wRrsDeXW7f5fqsibRDvrQ2SdVo9L1exKNUNkjRj40apoR1bVLuIio/SBGeT43zlvfdWugmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=oxHAhN7o; arc=fail smtp.client-ip=40.107.105.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tP3Xr4RYi6F381hISkgZYFIS4ARTDHnc8rCLF5APWVmdXHEHzdQwmVq473ZSxJYkrJdo0kP4vPRLs7Nv9zrpaXFH0fhCkrIeq+2gpR23a5TtQwS8RloJvK981F/plEnpbqB3wcXlyyQpnPpWBK1vOWduMaVYad8sgepIT5OgA5ruunRGhtzR0oj0S7yJU3ScqD8qzEUCA4FeEjS4d7uBeJ7xzLyZWVHRiUlBh/GxtAo9ry+n1v0RQdjadshr5WHMhwQ/35lptP0/idzkvasDTzcRd+6jWKNAJx487Ph9/kj2b8HS33dgcuTgDPeYpEcqYKlBMrEh6K+dWHYU+jcVbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8FBTElBdhmV0DJEfFDqju5Y3nhEZSc/mXHS5hkwC3c=;
 b=tljB5qlxRDiIygRAIzkCtH1zbCalHVHKMGnbEPSkAgqTqbHYMrCn3KS5FA7sW6pQkCHPffStI2NpFFmHJISK9nZKLRlKtCFE987z6CJ0Ji48ETXzyrgW6sC7bZXWTX6aZsL5ew0DQH2UqWz0ZuPkgrAxQps4i5UT5O2MNmbznYZ4o9Ko6uR1AoeS2/4MJCf0+un6PYWTLdLGx1vp7huxhLX8ZbIBRj7G2jN43zkJtWFGlobtFRww0iRx7gczWP7kXbj4e3RUSeQEjimw6B8/DXwPIgtD7wJthZmIBap4Lu0f6xSH9phM8Zw+pK7urjN6BCTAMQZKXrCYCiKkPDriCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8FBTElBdhmV0DJEfFDqju5Y3nhEZSc/mXHS5hkwC3c=;
 b=oxHAhN7oOZ0YKWIp8V/1/IjLm1ShlZgi42JXNUf22Y7OOOeICVPL2p9QoRjMcANimiolg53jrEh9j30Tkg3ZmsIHdfl6TT9rFBZnI+kebZut9E9QNlAha+mBD+m3tAv6jWMODbEw7ZZVCF4nr1q1QKL/nvUo0ZEg3uqGYWzQTo+eXxNqyPGcGIhubq2JekCu21WnAo8SobsTd9c9vqBCN3hR6/xKK0PX67eLLkVDv3lWeLuTFICtWSgjRy0ALSoA1pxmTsckQdtdVZOCAz8DV1O91CfjihyZLZjrOpFdqmITZI6F7+0OZFr3Z00TSBHBXXIAryOk5npjj4kSh3/10A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7786.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:46e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 16:47:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 16:47:23 +0000
Message-ID: <bf2bd3df-902f-4cef-91fc-2e6438539a01@siemens.com>
Date: Mon, 19 Aug 2024 18:47:20 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] remoteproc: k3-r5: Fix driver shutdown
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 linux-remoteproc@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Apurva Nandan <a-nandan@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, Nishanth Menon <nm@ti.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: 4829583c-99e2-468c-e632-08dcc06e994a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjNwT0FtdU82Wld5MDBKNzQ4MUhRVEh5alVDMThmS1VRZlpQRmw4L25MbzdE?=
 =?utf-8?B?L2FnQmVzZ0xHS0lBVVVYQ3NPMUJyYXhIK29Ia3VGVFVqZk5xVVlWV00vbVN0?=
 =?utf-8?B?NnVEMHlGNzNpR3BzbWtqMEtyb25RZURuM1pHSEpnckh3bDFldzVEL2tlR01r?=
 =?utf-8?B?cGtHUitjb0Jla2hVVHFMczhGS2xYNThHb1J2bDM5cnhRc0c4OGRmZVdrRng4?=
 =?utf-8?B?d1M2S25zelFpK29MY21XbE5sRENVSXFRT1Y3MUM4UEdneUZvVHhRbE1DZm9v?=
 =?utf-8?B?c296SVhsaTgwU2RVZERWRWFwN2VqSzhuQnJOVHZmWWpSNHZHalJqNmZpZzNS?=
 =?utf-8?B?dlU2WW80RW90ZmpJVkhDakZCWlFzeGJSb1F1M3BwTGwwMnV3Q2VLSVpITWxU?=
 =?utf-8?B?VkpUZ3pCWmFUcGdWVGFJQmdSbGdjbmNHSFhyUk9wTWFCVHdua1kyMnE0czB3?=
 =?utf-8?B?b2pPSjRJbGdVdjFtajNqN09WdEFQdXNlWFdCcjZ6aXMxRll0NEVpcE5PWEJj?=
 =?utf-8?B?bTVsMjZDT1YwRUROc0MxUkhMeXJRTUJRV3hZYmxLTUdxd0djbXhhaUdlMWpU?=
 =?utf-8?B?QzMvM3BMOEFVdFBBUG4rbVRzdC8zZXgzdXZYREhnKzRkb0d6R2NwTVVzaU92?=
 =?utf-8?B?RDExN05WekplaEVYeUU2VUNqdkVuTlg1aXk2MGxXT2ZsbFgrc1kzYXNSS1ZI?=
 =?utf-8?B?THlJUDJCbkZTRTRGYVF6RlpTckVGbHFvVzc0MWFPMTN4RE9BblhCSVFpakp6?=
 =?utf-8?B?UU9yWm1QOFhsTlRwUklKVnhod290cmw2dDdFZm16RDlsWkNTSTRsQUJHTmxT?=
 =?utf-8?B?Z2Voc0dhYU9tc3JDdEdPVjYrS0tLOVByRXdMZFdzVnE5VktWNUFzQlJMVUFz?=
 =?utf-8?B?ZEhOMDlPemo4U2cvTWg5b3FhWlVoTlNDS2REVkdCVHNrK1hiRmdYc1BsLy9w?=
 =?utf-8?B?cnZzUVlEYXMxbGMrNmRLakdhMEFybmNLVnFpL2dTUVBOVWVDU3NIb0RmL1Av?=
 =?utf-8?B?dThXdTcwbEhFN2pUc0ZENkN3UzZJcmt0bm5iYStQUERtWW5jcHIvbUdqcXp4?=
 =?utf-8?B?RTI5K0R2dzBZQ3BSOEZQTmdJVnMwbFo2OGlhL1FhVElidjdNblBRdkhsUHJZ?=
 =?utf-8?B?NmxDV0t0ZVNSS0NhcEpWcVRRM0dTeENMaU1US1h4S0RIeUFheTRmY3Uyb2FV?=
 =?utf-8?B?SzV1aytoUng2UUNibUYySTB0YmNUWExpQVZ6YWhGRlNSOS9DVmlOTlJrNlF3?=
 =?utf-8?B?SHBRZ2FYMm01UXhscEc1bDNyNnR0cVpWUG01T1JRek9aYy96T0N1WWZZOU9K?=
 =?utf-8?B?M2R3NGtuamZjelVkdmQzUjd6MmtPWWQ0MzF4ZkthUFVDWk9IazFIU24wZzRh?=
 =?utf-8?B?MTR3N3A2UldmOUZhM3U4QVFxMVA0M2ZndUQ5a0ExQVo0RFNmcG1mWmZKUnp1?=
 =?utf-8?B?OTNXeG53M0hXSEp2Q3BxbkxXQVlGb1hrK2J4Tno5M0JIcGdYVVRPMnIxS3Az?=
 =?utf-8?B?R2hWa2g2N3hKS0V3bW5FSHNnWEw5M0s5WGJkd0lVQVB1bUEzUXNERENKVHJs?=
 =?utf-8?B?WjdxaWZpaW1FSnVOWDQ1N0JUNkF3cUZNOXRNY0xUcGFwaVJGOHI3TDZhMXk0?=
 =?utf-8?B?SzBDR0dHUUlOY2ZCOVlya1EvVUM3K3Q0ZFJFV3daUDJlcFR4MzU3dHN0ZUdi?=
 =?utf-8?B?MDFqeDU3ZWFFN25pZnBjSHlnN2ZkeGFHeEJETGlMV3dVL1dHV05FRWVrS0tl?=
 =?utf-8?B?Nll5TUdUU0NsVHlVYk9FSDU5SVd6Zk5XQjNhN2dkVTY1WEJRTkoxemlmR3Bz?=
 =?utf-8?B?b2ZGdjdOdm5ldWVDZWNuZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjMzbWp1UHFrUU11WjdNWGowQStVYnB4bEJNSkZGT1hKempEMWZVR3hsclZw?=
 =?utf-8?B?NGlWMCs0TEJlMEM2WGVVWlZZbjFXTkRtdFpXVm1Ydk5WVVVDamVaeUk5QXVB?=
 =?utf-8?B?aFdPUFk4cG8yOEkxaGpFTXV4bXhRaHZpN3J3WE41cGM5eDNFUUVKaWRUSEI2?=
 =?utf-8?B?bDNkVjZWVlQyZms2MHF2U3N3djZUdFRodElLbDdVZnEyd2pXV05KM1VxWnhS?=
 =?utf-8?B?WWM1VVg3Vk5wOSs5NHdoS1BHbTIxdzA4QzZ3WVZva01uZzhKWCtHZ2xJb1dQ?=
 =?utf-8?B?ZHh4WGxoWkNYVjdnckJvVk1ZQ24zVWRNeTRpQW9jcHVqMkRpSnRJZGVpM3I0?=
 =?utf-8?B?amFuUUlwWjFjZkFLNC84aGZZY3BjTnJhMnkxOWVFdnc1MWhIVW03bVEyY1hS?=
 =?utf-8?B?SmIvc3l2VksxTFhOUVVZMnR5cmFoSlI2dzIwTFEzbnBrbmJaVGY1MjlkS2dq?=
 =?utf-8?B?T2V0UG9QRkFtOUYvYTFReGh1ZWpYMTdoT2NiRDg5UDRwT0RHa3lMOXlkRTJD?=
 =?utf-8?B?Tm55dysyUnMyTnRSNUxRTFhZeWRyYzFpZW5tM29OM0d1c3FRdGIwT0FyK0oz?=
 =?utf-8?B?VEg3S1hsaVhVdmwzK2JyYWlycllCR3BlRVJ0S1hheHlVZTAvWEVrR2R2aVZr?=
 =?utf-8?B?UVhEZHV5dU5kZmRsY1ZvWEFPbzRUSXhuU2hybU43emt3VTVmdmtSbkk2M1VD?=
 =?utf-8?B?VnRNTUZDbm1KOXBVQk5QdUV0QXI3SUtxb09QTjhiZ0NPc09xVjlhUDFvUk81?=
 =?utf-8?B?aVFJU1FROTFyRkFvZmN5YmFBVjhtM0FHS2Zqazl3eUJ3azZldVhhdzhEWVlL?=
 =?utf-8?B?UElFNDBBc0F3MVVER1o1YldtNG8vblAxSWVNak1tYWczeGFvNWJ6NXlsdUFE?=
 =?utf-8?B?QXlicVBkdHlVK1FPQ0I1blFPanh1bWd1WlJoUGliU21GRm1pV3AzMUZoOXQ3?=
 =?utf-8?B?dm5vekpXS1BJd1YxUXhVL0xJTVBFeHVic2YySTZaVUNPNXEwZEN2ekwyQ1BU?=
 =?utf-8?B?VGhMZTlvWi9kVnhoMGphSzNqdm5BcGp5NUlZNXRwVmM1UVJ3K21LMkFudkJy?=
 =?utf-8?B?SkxLUGZvRVh4bllYemtWSncvZ292Ukl4SFY1UFVtazgveGNJNWpoVUU3TENx?=
 =?utf-8?B?ekdJR0E3YW9BblJYMEplS002SmlJWnlkRmlLMGwyd1VKM2psQlZSWW9XWm9K?=
 =?utf-8?B?OUkrVnltRkRKR0ltQWRnNFBTSFAyekcvS2tqMzY2Z2x0d1RoQ1RSYTZDVnM0?=
 =?utf-8?B?MGNXZDN6RGM3WkZJWHBjZzhWdEM5eVl0ZHB6MDNUOGF2SU0xQmU2bTZDemNV?=
 =?utf-8?B?K0FlS29Ma0dpQlNXSnRTZXRIOS9kTWpIbkxnb05NS0o2aC9mRVdRVFc5TGpV?=
 =?utf-8?B?eDFTNi9JTzVBQTZnVmFNeHE5bUxKZ3dtMVpGZlBDeWI1QUxVd0hqV0hJSyti?=
 =?utf-8?B?ajR2L0ExYTV3cm1mUmpycStWTkp6T1VBV0lQRkYwN0NyL1NxOVhabXVKYmdo?=
 =?utf-8?B?SzBOQ1VwSUVPTm82M0JJREFkbVFkY1lYL2lWbHVYVUtSWUN5ajJic0R4bFRQ?=
 =?utf-8?B?enFsbjR3ZXhMK2RJZjF0YVdrL2hTV2QzcVVTaGZ5UmN6K0Y5TVA0UlFYdXhW?=
 =?utf-8?B?N2tTbEw3TXBvWExNei9YdC9IaVM3TlE1ekZ6N0FQc2VGU2szeEx1TlA4UDBP?=
 =?utf-8?B?V1ZmRGgvb2xYWWlrL2RwaEYwczVEOEJ0bVhYc3dUcjNJMzlMUUxnYU5OeFZj?=
 =?utf-8?B?ZXNUUWhsRXFrV0xDOFllam5ZUkxjRzcrV2grcys2ZncveUpnREE1ay9MN1Nq?=
 =?utf-8?B?aU50V2hXVWZmUzhXcDlRZ0hPT2JsOWhuUUxzbURwNEpoTlp5RHVrcEVqaVNp?=
 =?utf-8?B?OG0rUGg1UDlZRW9YdE5MV2h1L0pNNThJTUF2cHFsYVNJL1h0Y1FlLzU1OVNm?=
 =?utf-8?B?ckxzaU9zQTIxMDBTUTY2cEdNd21oTHFCUjNQVmtwaC95d3ZYeC9pV21TM3FV?=
 =?utf-8?B?Q2VOeFd2OFFqVzA1MW9sK29GdUYrY1U1RVZNeG4xLzN3QjN1ZFg4TnFjUkRj?=
 =?utf-8?B?OEt4ditpSVZ6cTl6aEEySm9aQUJCMDRSUUc0UklqOUJtNC9semVBeE9oNXl2?=
 =?utf-8?B?Z2UxVTlRazBMdkJyZmdlRGcxZlllS3lKdlBKdThWM0J4L0xGQnB1b3BzZ0dt?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4829583c-99e2-468c-e632-08dcc06e994a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 16:47:23.1274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IqgiNqcTlkeF+2yJ3t2oSYSlxl5cPHIU9yHGH79zz8iraaqEHmCoYuex61ijnEn2QPRaCFxnYtz7UG/0qHE5vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7786

From: Jan Kiszka <jan.kiszka@siemens.com>

When k3_r5_cluster_rproc_exit is run, core 1 is shutdown and removed
first. When core 0 should then be stopped before its removal, it will
find core1->rproc as NULL already and crashes. Happens on rmmod e.g.

Fixes: 3c8a9066d584 ("remoteproc: k3-r5: Do not allow core1 to power up before core0 via sysfs")
CC: stable@vger.kernel.org
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

There might be one more because I can still make this driver crash 
after an operator error. Were error scenarios tested at all?

 drivers/remoteproc/ti_k3_r5_remoteproc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index eb09d2e9b32a..9ebd7a34e638 100644
--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -646,7 +646,8 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
 		/* do not allow core 0 to stop before core 1 */
 		core1 = list_last_entry(&cluster->cores, struct k3_r5_core,
 					elem);
-		if (core != core1 && core1->rproc->state != RPROC_OFFLINE) {
+		if (core != core1 && core1->rproc &&
+		    core1->rproc->state != RPROC_OFFLINE) {
 			dev_err(dev, "%s: can not stop core 0 before core 1\n",
 				__func__);
 			ret = -EPERM;
-- 
2.43.0

