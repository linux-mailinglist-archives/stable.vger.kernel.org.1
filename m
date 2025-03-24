Return-Path: <stable+bounces-125848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE40A6D4ED
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 08:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CAF116A771
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 07:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E1F2505A5;
	Mon, 24 Mar 2025 07:21:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351D618D65E
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 07:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742800879; cv=fail; b=e6JyUqKd7W5KIlOPwN69WzyJkFlO1OMaFU1/mFV5eKsITp5G50KYKGRrRVV18XRhQAP9LximzBCHvGhMZkuIEKGu4j6/pw0gMoWGJF2Cauez2EJQc45sT11xOiJdaS2dUWkHqmPnd8NafxbC8mHkH/JOvlSf90l9OJMiypSRbj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742800879; c=relaxed/simple;
	bh=vvzzxqaB2fXqaygPtaJbZrm7gX4jSULdfeRVZryX7Q8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SlkCFJvh0udt1YR+pzGppdpOxsvOr2IMqPv69QZlcCvM5dcqehKB6r1I46a4XzfTMbY+2Lmie6r4GVYcJ/yi4DQRYgda634nF3mIifZu2IyqyCjvwpcN01G16mJ0Vbg/i348oyk5Y6NW/fBqu95Fp0yWr5ge564EFv0f3qsOxlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O61LxS014970;
	Mon, 24 Mar 2025 07:21:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hm68hsh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:21:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmjayBtC3IrtFpxHhFlN8hJLzMtSZM+ZwKWyZ3t5VMjdX0yZPWM09tvtNFm1kgl+h3qAET+7gh+8MoXFu8Ji4nIAISZMd/e76/+jiyaqXG9xuFhXMOLbbpmXy1rd1jLQhSV30kYHXko1LQ/PUvsoNLnPM7ELuBebrB5Vn/Py86S4xLPSDGuXAtAscBX12/MHqozM1vDeYZsHAd0UWvSrf1HqA+bkCYa76M3ujdANdOhJ1Spdv6pigmxayD51oPiexCUBLar3Uy+h9q4f5HJGVFcB12Diy1j0AAGGXJUxqoJ/1bj8N2zMNK/M7zFGA93WQzAPbFOtPOBmso7FP0s3pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t39iiSQxsCNkkJ8mmIe0S8FUfOQX2xeuIrtl2wOzvuU=;
 b=NgO8DAkuIQ6O61vmi5Nwifb7m+8htt91eeFzorEWF8+9E3IPCxcbl5HzuEL8qzT20TeeFPh6d2rvZSaPMD4p1lhv603m82a44mFhqLJ9tVhX2jauC8L246Y2BwOKtCkImzSeEQPZcYeWOkMVFDXI1C6s81w5q7PbNBBvYhV9BmMY1vHxmacRZGIxyp5/1v4fjwnMyGl+zwsMbo1xbV2sCoIGmVEGRWN/L9yIyxVeJpW8pWJCS/3rHzL8XyJ6gub2Gt0CFd8u9dDseOpha1l9RD+f9EuhCw5LrfUJt06jnZp6qF/UsR6ZZJMoZvIzOomEn6rNCL++YG53Pwn13fU1CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) by
 PH0PR11MB7166.namprd11.prod.outlook.com (2603:10b6:510:1e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 07:21:11 +0000
Received: from DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a]) by DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a%7]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 07:21:11 +0000
From: Kang Wenlin <wenlin.kang@windriver.com>
To: regkh@linuxfoundation.org, stable@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, ebiederm@xmission.com, keescook@chromium.org,
        akpm@linux-foundation.org
Subject: [PATCH 6.1.y 2/7] binfmt_elf: Support segments with 0 filesz and misaligned starts
Date: Mon, 24 Mar 2025 15:19:37 +0800
Message-Id: <20250324071942.2553928-3-wenlin.kang@windriver.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250324071942.2553928-1-wenlin.kang@windriver.com>
References: <20250324071942.2553928-1-wenlin.kang@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To DS0PR11MB6325.namprd11.prod.outlook.com
 (2603:10b6:8:cf::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6325:EE_|PH0PR11MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: 0081209b-5a3e-46db-080e-08dd6aa47431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U251M1R2M2JUbkNTNk41eXRRNU9NczI3VzRhMzg0OXpYQzNwUmgxVENnVlVY?=
 =?utf-8?B?STBpNHpqV1E2Rnc2S0xSUkhaYWJSOEhlcS9PRkJjVjFhTG5hWHFxeTYzVDVN?=
 =?utf-8?B?S28xK0RUbTdBU2c5THNnVkFka2VJaEpFOTQybS9ObDNZdGRFZjhvdkRneW44?=
 =?utf-8?B?OEFUdXpFTGRBSDJ4UVB6SE9ncFZhc3JSeUpCc3ZxNmVmRWxNZmQyellQaDhr?=
 =?utf-8?B?Nmd2aFRUWHpZdmhRcmxINmRTZkc1OHg4WnRzTno0bUNGRFhrRDNmRDZTbFAw?=
 =?utf-8?B?Q2hUMmd5VXBGd2tZendHTTNZRXR5bjN3QllIOEQ5Z24vcENUVU9ueFNoVnRu?=
 =?utf-8?B?MllXKzE3c2JGS2Y3cVd5WkpDM0xUdVlpeUMvLzlqNSt1OUUybk5OenB2c3NU?=
 =?utf-8?B?cDNGaDdiL1R5V3E1WGNYaDl3SndiWUJwc0E4dS9rZS9LWXdvRWQ2aENXSjUv?=
 =?utf-8?B?dU1QQTAzRDNMLzB3TUh6N3ZNN0NEcS9CTzhMY2lnL0JvbU0wYVlzV3kybDI4?=
 =?utf-8?B?b2t3all6c0FscFpaYWRMaXRNL0hERDNJYjl5aytRQUlTc0c4SWhtam1KSzRK?=
 =?utf-8?B?eXg0clBybXBRa21Cc095clhEa2RVUmJIVXArcWNvQkl2eWN1WFdKcUxOWGxY?=
 =?utf-8?B?M1Z0OHBJdlM1ekxnckswc0FRdTBkQ29vMERheGhZMHhnc0lJZ0U2VlhOSTZw?=
 =?utf-8?B?K2R1dTRVcGpxN0RtZWkycHlPem9GYXhzT1duY0JsNnlCMmdKYUIrd3JVa3lY?=
 =?utf-8?B?WFhOSG9vOVhodHZqNmtZV1NTVlYrMkswaXFJV0JQdWpIRTljS29XNW5EekYy?=
 =?utf-8?B?cTdsT1FNK1dmTXRWbGczR0w3dGp5L0JKWWMzbGV4dGJHamtBMXFzeTNFd0Fi?=
 =?utf-8?B?ajczYWh5Yk11VGY5UVR0MjhiVU1pUzJncGZ2QzNrYXNDTHZqOGQxRnpzTy9S?=
 =?utf-8?B?aEVDL1FoMlkwd2FTSXFVRWpOdnp5alEzRTluR3pGWjNRcHFIOGNMSFh0K3ZE?=
 =?utf-8?B?Q1ZEaEZ2YjFZMW40dXZ0RzB4N3ArSzJQKzV5RWNlMWw2WVpWQllQQlpXNTJY?=
 =?utf-8?B?cVpJWHA2cE1CRWZQUFRhSzNqYVhhNko3WlhUN3FudDF1L2ZKaXZwbVhIM2xL?=
 =?utf-8?B?eHhGOEphWEU0RVR2MzVzWlRDeVlwZVIwV2tzTTdtbHlRblhBamJteTJuTXFw?=
 =?utf-8?B?N2VlcGhMVEIxNGNNZzdteG5BQUxIa21nU283QjB2bklmNkM1c2FMaHpqQXFm?=
 =?utf-8?B?STVXdGgyakFVNEV1aDNFSGlGa2hnOG9hTGxub1ZjRWcrNXFsVHJpclpWeFBD?=
 =?utf-8?B?VG9OU1NTMS8xc2VpTHViNVpERSs0VGYzcS9SRjU5QjZ6bzBWQlBQWWExM1hF?=
 =?utf-8?B?NVAyN3ROczRYa2xLeUlEbDNVbnA1OGtvUkpOMzNZTlJzWXVwWk9PYng5Wnpu?=
 =?utf-8?B?K2FzRStmT1R6aUwweUVTazVYZkxXSmc4bk0xaUgxSEJQR1lLbDY0MnU3eTA3?=
 =?utf-8?B?dGh5N0JhdnNXUHBvUmx5NmtMN0VRc3IrUFpDdTBoczdnMXVTRWZrM1VYaHMr?=
 =?utf-8?B?RkNDa1Zubk9FVjBIWTdmRVE1N0t5VUQyYmkza3YwUUZaeVZrUWtERmpmR1Zp?=
 =?utf-8?B?WEFkRHcyNisxR2cwYVREcDF6a2VjenVkaHRIbVhsRmluZGJvV0RIcEtNckZ5?=
 =?utf-8?B?UFRTMDA2ZDRScjBraDd2NG8rQkUwT0pieFBubkg5R3F5ZlZuTi9RdXllcWo5?=
 =?utf-8?B?eDZpSVFObm9hUm1nd1kwa2tWNytOMXg1dHFLV0szcHhodU9mRE9mYTNwTUpa?=
 =?utf-8?B?bFBxVlRySENEMTV6a0VGWHBuTHJMWEx6cHpHRnZxQ094NllDMm42MWJ4Z3N0?=
 =?utf-8?B?dzczNi9jdlNlSUVIWTVIZWpaMHZKejdycTRoc0dPRGpmcThGS2Ewd0s2cklP?=
 =?utf-8?B?bXBheitsY1B4RzV4NjBLUFlzaWxDTEhJU1UxK3dtREROb1M4aTdtVUQ2SUlV?=
 =?utf-8?B?TmhTODNGUEtBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6325.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUc2UzRHSHBxZ0FzbmpDTTdOcDREVVBUdWFQOXVsMkdLVHhXeXNQV0phOHp5?=
 =?utf-8?B?YVk4WnNGWmVmVjl4cWprMmc0dUtiMlFwbm8rTXpYczByWFh2aXVqZHpBdzlS?=
 =?utf-8?B?d2JwRWxXaFo5bDh2eFMzZjFmOExNSng0aVlBbXArbWsvSUN3ZXh1RXVUQzYw?=
 =?utf-8?B?Q2xiTnM2MEdYQWJmV2d5OEV0RGwzclE0anZyL2pxUE85djkzbTNnY0J4MXdq?=
 =?utf-8?B?NW1aZUNaWEpEeGpGQSs4YWxBMGJrQ0JoSmt1K2JvWjZkang2Nk1sOFoxNElT?=
 =?utf-8?B?U1phRW5Kc2tMRUhaWlJPOW1mN2tpK21LRmg5a2Vjak5iTzBTZEhjWGp6V202?=
 =?utf-8?B?MVA3THp1ZnR1MmxBSjZ0RGxlMTdoNWgzWXhIeUpDK2Q1UE9GWU5EZzlwQzYw?=
 =?utf-8?B?eW5SbkhqYkRZb2JuT1R1N1ZYdUV0WCtBWUtzVlpka1RpTnBmU1NyYUtzeVhL?=
 =?utf-8?B?UzJiV3RPd0lGM1JvUThxelhvaWV2MWhlcEREZjFGNGM2VUVFSUxyQjd1cVNh?=
 =?utf-8?B?ZmpEeTlLa2ZpcXhpY05qdjlFSThobmxwTXJodjlyVUpqVnhPR3pydWJmR2x2?=
 =?utf-8?B?bGV0bzRuYXhQcjJHbTB5ZUttd1krbGdTUXFGNkVrZjhJQmpwN1JGY0pRYWd2?=
 =?utf-8?B?Qm9abXY4Ui9vVStET2RnMUJXTHg4aVIwc2NJdnJyenN6SFN1UGluK0lybHZr?=
 =?utf-8?B?Y2pnRlVNNk83a3doUW1iODBtSG95NWNsSlY3MklxSnpPQ2NNckhOZzAzb2ZW?=
 =?utf-8?B?QVJiY0sxRXhaUXNYUktUOE4zT1g4Y0Q4Slh0eEhTcjAranFPcThNUDQ5VXlP?=
 =?utf-8?B?RGdROUNORThLcUh0VGg0SFh5cUNteUJadmloZWUyU1pIL1p2RjJBUU5YVFR6?=
 =?utf-8?B?R0w1WDQzV0ZCVUJjZ0NSQzNSTTROMVZNeEtKTEhmU2V4R0JJZDlrTWFlZ2Qz?=
 =?utf-8?B?UlMyOFNYdFBzWDh6TTRiMGtsRTNiOWVxTm5Sd1hFVmtlRmp2azNyTG9teDFY?=
 =?utf-8?B?OXpETklDdTVZVkE4bU0zSHNRRUw4TWRObTdTbE16ZnhZd0xDN3lrZkRDNWY2?=
 =?utf-8?B?bGZQMFpmdTdqK1VraURaeksvdUt0bjd1L1dTYlNaaVFaN1hZYkZONTM2RHlO?=
 =?utf-8?B?QzR3NDVGbXNJSE5rWnRFWk9tL0hJUWVxdGpTT09MQS9Ddy9kdUo3UlhpdWZE?=
 =?utf-8?B?QUdoNkJzdSs4RlNvSDFDMWc4UURVdTVUZnNvVUszSmZOMVIxbU5nRlZ1ckZO?=
 =?utf-8?B?NUptOHZpS3libmJPRDc4MUw1NWJoRXdST21NRUt2UlBTSjZSdTBGNkZ6enNH?=
 =?utf-8?B?OFVDd3BBMTRXM2pNNjdRRXFWNTE4NUUwWXJPcjE2VStKYzNZMi9nYUxGTnZZ?=
 =?utf-8?B?Q0hkYnYvTnFoc2RZanNjOTBmcHFtMXBMVXo5cENzdDRIVlZTcThaUGgvczBk?=
 =?utf-8?B?WkZ1S1c1YTNGeFR5dmdTbXc2UEdqMFFRSEdVNHBtenhnV2xGM3pnT2REcGNW?=
 =?utf-8?B?a2llUmMvTEdTN1Bsd0thblVOUkRUN0d2dnpMOWMxSktYVVc1eThjUGh1N3ZD?=
 =?utf-8?B?MUk1cytuT0pFb2liWTRxbHF6TVlsenc1azgwNVFTeHVWWUlpTzEvSlVRbXdk?=
 =?utf-8?B?WUprOHA4dGxhcjl3azJlQ2JaYVpOUldtWDQxTGZqQy9WbkpyRmV6TmxVMlBI?=
 =?utf-8?B?dHdMWjF2QjV3RFkyQTFhRGNDR21XUmJHYVA4elo1alVEWTYwV2RZYm9jZjNQ?=
 =?utf-8?B?aURueGZiQTlsVFFyUUxZUFFadlR5bmZOVFA3dlBZMDh0T1ZMK3BpVVVkV29u?=
 =?utf-8?B?R0pZeXh5eDR0dU13eUFCVWVvTDRZNmV6Tk5LL2kwc013VTdZNFRkcnZ1bE1L?=
 =?utf-8?B?dEIzNUNwd0h1UWJlL29VUVQzcDZOYjZsS29adHhTT2xWcFFLYnhWUzJaci9i?=
 =?utf-8?B?SnpqRUFrQU1ZbzYyU3Z0ZWIycmxFNTlNQXdmOC9MS3RRQjNKdENEalpyMlBk?=
 =?utf-8?B?b2VBVk5qWVlUSklablp0c2RFQXd3bmNjMlBOSXUxSDFEMm1YYXptd084T09K?=
 =?utf-8?B?RjJzZTRoMFpMYXRyMDYvc0xaaFNVRjhIcGdhclJ3Q0NiQnhUeFlJTlZEYm5U?=
 =?utf-8?B?RkhIMUZZMWdyR1AxN3dCTjViY3lzTlk2N3dKQUROQTNvL05aRFNMLytSeTFn?=
 =?utf-8?B?cnc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0081209b-5a3e-46db-080e-08dd6aa47431
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6325.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 07:21:11.4564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SbhiSqRgL7s/FwmHU77BRYP7FmyGF9IUYe0B5zIRc32XYkwJhMaXbtqje25YfrIRlJvwC8/JjbOx+95AAD1abGCuWeXjOJ6hdS+qvZKFrGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7166
X-Proofpoint-ORIG-GUID: X4Fum3AFtXzyMEblV8i-dp0JgoVsEdiu
X-Authority-Analysis: v=2.4 cv=etjfzppX c=1 sm=1 tr=0 ts=67e107e9 cx=c_pps a=X8fexuRkk/LHRdmY6WyJkQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=VwQbUJbxAAAA:8 a=VTue-mJiAAAA:8 a=tUPbLDLaAAAA:8 a=cm27Pg_UAAAA:8 a=PtDNVHqPAAAA:8 a=dlI4R5ZWAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=4KIj8LpjGsIVfBBbYGkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=S9YjYK_EKPFYWS37g-LV:22 a=QrvNcK7Wzxl7WF_4suK2:22 a=BpimnaHY1jUKGyF_4-AF:22 a=_Et68LT86lDbNqPJMOLW:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: X4Fum3AFtXzyMEblV8i-dp0JgoVsEdiu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503240053

From: "Eric W. Biederman" <ebiederm@xmission.com>

commit 585a018627b4d7ed37387211f667916840b5c5ea upstream

Implement a helper elf_load() that wraps elf_map() and performs all
of the necessary work to ensure that when "memsz > filesz" the bytes
described by "memsz > filesz" are zeroed.

An outstanding issue is if the first segment has filesz 0, and has a
randomized location. But that is the same as today.

In this change I replaced an open coded padzero() that did not clear
all of the way to the end of the page, with padzero() that does.

I also stopped checking the return of padzero() as there is at least
one known case where testing for failure is the wrong thing to do.
It looks like binfmt_elf_fdpic may have the proper set of tests
for when error handling can be safely completed.

I found a couple of commits in the old history
https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git,
that look very interesting in understanding this code.

commit 39b56d902bf3 ("[PATCH] binfmt_elf: clearing bss may fail")
commit c6e2227e4a3e ("[SPARC64]: Missing user access return value checks in fs/binfmt_elf.c and fs/compat.c")
commit 5bf3be033f50 ("v2.4.10.1 -> v2.4.10.2")

Looking at commit 39b56d902bf3 ("[PATCH] binfmt_elf: clearing bss may fail"):
>  commit 39b56d902bf35241e7cba6cc30b828ed937175ad
>  Author: Pavel Machek <pavel@ucw.cz>
>  Date:   Wed Feb 9 22:40:30 2005 -0800
>
>     [PATCH] binfmt_elf: clearing bss may fail
>
>     So we discover that Borland's Kylix application builder emits weird elf
>     files which describe a non-writeable bss segment.
>
>     So remove the clear_user() check at the place where we zero out the bss.  I
>     don't _think_ there are any security implications here (plus we've never
>     checked that clear_user() return value, so whoops if it is a problem).
>
>     Signed-off-by: Pavel Machek <pavel@suse.cz>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Linus Torvalds <torvalds@osdl.org>

It seems pretty clear that binfmt_elf_fdpic with skipping clear_user() for
non-writable segments and otherwise calling clear_user(), aka padzero(),
and checking it's return code is the right thing to do.

I just skipped the error checking as that avoids breaking things.

And notably, it looks like Borland's Kylix died in 2005 so it might be
safe to just consider read-only segments with memsz > filesz an error.

Reported-by: Sebastian Ott <sebott@redhat.com>
Reported-by: Thomas Weißschuh <linux@weissschuh.net>
Closes: https://lkml.kernel.org/r/20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Link: https://lore.kernel.org/r/87sf71f123.fsf@email.froward.int.ebiederm.org
Tested-by: Pedro Falcato <pedro.falcato@gmail.com>
Signed-off-by: Sebastian Ott <sebott@redhat.com>
Link: https://lore.kernel.org/r/20230929032435.2391507-1-keescook@chromium.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
---
 fs/binfmt_elf.c | 111 +++++++++++++++++++++---------------------------
 1 file changed, 48 insertions(+), 63 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 584b446494cf..90151e152a7f 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -109,25 +109,6 @@ static struct linux_binfmt elf_format = {
 
 #define BAD_ADDR(x) (unlikely((unsigned long)(x) >= TASK_SIZE))
 
-static int set_brk(unsigned long start, unsigned long end, int prot)
-{
-	start = ELF_PAGEALIGN(start);
-	end = ELF_PAGEALIGN(end);
-	if (end > start) {
-		/*
-		 * Map the last of the bss segment.
-		 * If the header is requesting these pages to be
-		 * executable, honour that (ppc32 needs this).
-		 */
-		int error = vm_brk_flags(start, end - start,
-				prot & PROT_EXEC ? VM_EXEC : 0);
-		if (error)
-			return error;
-	}
-	current->mm->start_brk = current->mm->brk = end;
-	return 0;
-}
-
 /* We need to explicitly zero any fractional pages
    after the data section (i.e. bss).  This would
    contain the junk from the file that should not
@@ -401,6 +382,51 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
 	return(map_addr);
 }
 
+static unsigned long elf_load(struct file *filep, unsigned long addr,
+		const struct elf_phdr *eppnt, int prot, int type,
+		unsigned long total_size)
+{
+	unsigned long zero_start, zero_end;
+	unsigned long map_addr;
+
+	if (eppnt->p_filesz) {
+		map_addr = elf_map(filep, addr, eppnt, prot, type, total_size);
+		if (BAD_ADDR(map_addr))
+			return map_addr;
+		if (eppnt->p_memsz > eppnt->p_filesz) {
+			zero_start = map_addr + ELF_PAGEOFFSET(eppnt->p_vaddr) +
+				eppnt->p_filesz;
+			zero_end = map_addr + ELF_PAGEOFFSET(eppnt->p_vaddr) +
+				eppnt->p_memsz;
+
+			/* Zero the end of the last mapped page */
+			padzero(zero_start);
+		}
+	} else {
+		map_addr = zero_start = ELF_PAGESTART(addr);
+		zero_end = zero_start + ELF_PAGEOFFSET(eppnt->p_vaddr) +
+			eppnt->p_memsz;
+	}
+	if (eppnt->p_memsz > eppnt->p_filesz) {
+		/*
+		 * Map the last of the segment.
+		 * If the header is requesting these pages to be
+		 * executable, honour that (ppc32 needs this).
+		 */
+		int error;
+
+		zero_start = ELF_PAGEALIGN(zero_start);
+		zero_end = ELF_PAGEALIGN(zero_end);
+
+		error = vm_brk_flags(zero_start, zero_end - zero_start,
+				     prot & PROT_EXEC ? VM_EXEC : 0);
+		if (error)
+			map_addr = error;
+	}
+	return map_addr;
+}
+
+
 static unsigned long total_mapping_size(const struct elf_phdr *phdr, int nr)
 {
 	elf_addr_t min_addr = -1;
@@ -830,7 +856,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
 	struct elf_phdr *elf_property_phdata = NULL;
 	unsigned long elf_bss, elf_brk;
-	int bss_prot = 0;
 	int retval, i;
 	unsigned long elf_entry;
 	unsigned long e_entry;
@@ -1042,33 +1067,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		if (elf_ppnt->p_type != PT_LOAD)
 			continue;
 
-		if (unlikely (elf_brk > elf_bss)) {
-			unsigned long nbyte;
-	            
-			/* There was a PT_LOAD segment with p_memsz > p_filesz
-			   before this one. Map anonymous pages, if needed,
-			   and clear the area.  */
-			retval = set_brk(elf_bss + load_bias,
-					 elf_brk + load_bias,
-					 bss_prot);
-			if (retval)
-				goto out_free_dentry;
-			nbyte = ELF_PAGEOFFSET(elf_bss);
-			if (nbyte) {
-				nbyte = ELF_MIN_ALIGN - nbyte;
-				if (nbyte > elf_brk - elf_bss)
-					nbyte = elf_brk - elf_bss;
-				if (clear_user((void __user *)elf_bss +
-							load_bias, nbyte)) {
-					/*
-					 * This bss-zeroing can fail if the ELF
-					 * file specifies odd protections. So
-					 * we don't check the return value
-					 */
-				}
-			}
-		}
-
 		elf_prot = make_prot(elf_ppnt->p_flags, &arch_state,
 				     !!interpreter, false);
 
@@ -1164,7 +1162,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			}
 		}
 
-		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt,
+		error = elf_load(bprm->file, load_bias + vaddr, elf_ppnt,
 				elf_prot, elf_flags, total_size);
 		if (BAD_ADDR(error)) {
 			retval = IS_ERR_VALUE(error) ?
@@ -1219,10 +1217,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		if (end_data < k)
 			end_data = k;
 		k = elf_ppnt->p_vaddr + elf_ppnt->p_memsz;
-		if (k > elf_brk) {
-			bss_prot = elf_prot;
+		if (k > elf_brk)
 			elf_brk = k;
-		}
 	}
 
 	e_entry = elf_ex->e_entry + load_bias;
@@ -1234,18 +1230,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	start_data += load_bias;
 	end_data += load_bias;
 
-	/* Calling set_brk effectively mmaps the pages that we need
-	 * for the bss and break sections.  We must do this before
-	 * mapping in the interpreter, to make sure it doesn't wind
-	 * up getting placed where the bss needs to go.
-	 */
-	retval = set_brk(elf_bss, elf_brk, bss_prot);
-	if (retval)
-		goto out_free_dentry;
-	if (likely(elf_bss != elf_brk) && unlikely(padzero(elf_bss))) {
-		retval = -EFAULT; /* Nobody gets to see this, but.. */
-		goto out_free_dentry;
-	}
+	current->mm->start_brk = current->mm->brk = ELF_PAGEALIGN(elf_brk);
 
 	if (interpreter) {
 		elf_entry = load_elf_interp(interp_elf_ex,
-- 
2.39.2


