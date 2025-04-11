Return-Path: <stable+bounces-132192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F19B5A85127
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 03:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C46347B5D02
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 01:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF21D299;
	Fri, 11 Apr 2025 01:17:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449B7946C
	for <stable@vger.kernel.org>; Fri, 11 Apr 2025 01:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744334245; cv=fail; b=Nb/9BLe2Jxw2XJy/iXeaRpsdf3G79AhUbP/hq8DmQND/in8DgfiaO4VYteLxR1xDK1cnE3qBlTWMBzGc/CdPBaP8X3pMiLXUr3JOd6iInim1DYQI4E/4cwdPyKp1/wbA/Qw+mXfbIrv2oK9jryTmBuMAqdt9fCOlObgz2RV/mkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744334245; c=relaxed/simple;
	bh=qK+qYubKQJOgCndSHPVKPXQxERHIrpgVf+42fbl4P/M=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pF59mwOKEYHSAGDmmWL41RZGpkIs426LK/qeWABoV2mEP6RZ6xlZGyz0TFwSMkz8GId5869bUUptFCnIK+GCnsEXCb7pm211hAZxVfShBHDz/Woi/y6iqBfU7z90yZoEE65y0BL22byolTg6rKtbts93ff/poxYf6vpMlltXMd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B0K4kG008827;
	Fri, 11 Apr 2025 01:17:16 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45tsr1qrmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 01:17:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dy6xeujZ9NeP/HKqUaASUDJ6I9mNTmHNttjfvIExgCcx56HDX5J2Glw09oRuyxF1psDDM86bFhUxBnPWXjnw+S2256IKmLz2CcwdL9lZRBRTDKSKM2DwKRlpVEtCILKj6ZvUqMqqa8/wh9i5bFJt+AGaE8xcxe/ncomgwlwZCakbiUP0/j0bm8Gjsz3TBBB0FphGidSGY9WcSAiax3WG/GVOsQEp38UOVVdOwEyMRN9DijwLC50F38f8tfIGIMlrtRH3EGurVfsgmBSnvQs1NTM+pQicDV8CWSKdDs9rnXx69D3PnLjybG6JDy9Dddl+O5Ley5Dv7/rArrmmzB0I+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuYCK/iWW4ca4ojcVrCyvZQgv8K2SjU1gp3cLzSRABo=;
 b=urW8tSpmTsbU56GDCINg+nxT0sDoWv7sqRaOAQioehSAXKYA0GK4dFbtTABsVs2qBcb6rF+6UMFf5LXfPQ8ibFUAUNeDD+cJOXIgu2hcs1NWyP+gCOy1tdxcSvM3Tt8+v2rhqRbC7GhEWaTlO9w2Hh5s5WM1G5sLSPVDA7BYfegQIZFXcZzUDMldKhEP0Wd2MxD8vCbZn1XPsKAEj12HevJ+0s0C8c+Repum8w+r5+W4obJfDgo5qEgQKJz7ARBiWfx2f1bhthbeUGMWV8wuhBI8ehHI/lipNNkaMjBpx3yeKRpxCqJJlezoChEfcIYfaYUdXrXaRSXJMhtwyeXxkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by CY5PR11MB6390.namprd11.prod.outlook.com (2603:10b6:930:39::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 01:17:11 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%6]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 01:17:10 +0000
Message-ID: <c60b49b7-451c-4d66-aa20-0c211087d402@eng.windriver.com>
Date: Fri, 11 Apr 2025 09:17:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y] perf: Fix perf_pending_task() UaF
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        xiangyu.chen@eng.windriver.com, gregkh@linuxfoundation.org
References: <20250410104653-ae35cbb8469d8d56@stable.kernel.org>
Content-Language: en-US
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
In-Reply-To: <20250410104653-ae35cbb8469d8d56@stable.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|CY5PR11MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 54590657-31ba-49b4-11ec-08dd78969528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2hITnkrd2tocGFsMW83UEdmN2Evem9WVVRUOVVkdDJKOHJHK3hGZXpOMWpk?=
 =?utf-8?B?QWtzUTlhb2c5NWFxSUdlWlMrNS9yZmRWTzc0REVQUFhISm5qMVBlTmhuM2FH?=
 =?utf-8?B?bCtBMmJGQk02RDY0UE5HYlY4SjJNd0NzcXVEN2R5Zy9QVVdoMTdjVFB1a3Ry?=
 =?utf-8?B?UzMrLzl0N0gvb280RzdlMEFmYyswSzJpSHdaVmNLTS9BM255UzlTMWJ5aUhj?=
 =?utf-8?B?TGczV2M4UVJwZ2tCSVVLQkcrbmRsRmJlV1d4Z2p0aFRjQzdLd2w3ZFNienhJ?=
 =?utf-8?B?V2phcW4vem5XSi9lVU5vMkFsQlJDSFNLbnlIdEk1ZnZMdy9SL3VzRTZ6dFIz?=
 =?utf-8?B?cFJubkhDL2FvTUtKRWJNQUxUb2U4elV3VUtkQnlEeDJBNVI5bXVTa1lxb2hh?=
 =?utf-8?B?ZnlNM1RzOE1hYVFHMEJXR0dqTmtWcnF5RFZEWkJ3M1E2anBrL3lweE5rRXVx?=
 =?utf-8?B?LytPT3RMMWNWdmh0SW4rUGxEemtLVXhxWGhPeklTd3RiZk52WlhhcTV5MjZx?=
 =?utf-8?B?N2M2NmEzRXNraTY3a0JyWTg5S1MraDJlY254Ungrek9nKzZmTTFTQ0U4WDl0?=
 =?utf-8?B?UUlrZTRJVmNVRGhJV0FNYnAyNi8xUEZseU9xcDhoMkc1OUtSZzFmOWpkbVJt?=
 =?utf-8?B?L0pkeG16RDFpUlVtZXN5WHJCSkEzR29nMDg3Z0dHZWVCeVAwaDd0TXZac1VB?=
 =?utf-8?B?U3I1cmhJbWNiOENFemY0ZytaQlQ0NDVTYkpUTlpjNVdrVVhBWXZoZDNPS21o?=
 =?utf-8?B?Z3o5aHU4QjAzMjFyWWt2b3NMZ0MzbERMN25ZbFU1Ym5mQkNDakhhM29YS3Yz?=
 =?utf-8?B?c3JFSEVoak9oVlN1V1ZZVlhrWUhPenllWW9zNFVSalNFekY2cHV4MWpPbm12?=
 =?utf-8?B?Z0hEUnd2aXE0b3pOMUI2NjNsc3JrU3RvZGI5ZWdkRDB5akZmNmNXbnU3Nk80?=
 =?utf-8?B?NDhDYXBYYXF2eXRYZjZBNzJtK1pFWFRWV1Z0RmZXdXVvT3FjSmZMTjNUdSts?=
 =?utf-8?B?TjZldTVURGdiUmlIRCtrNGdRL3d4dloxeGRrc1dHK0dEOGI3VDN5TDRNY29i?=
 =?utf-8?B?R1VaeHFpMFYxV1VzeE1MNkdkUnNzTUVJQ3c4QVZTV21Oa0ZLdGxCdnB1bHpo?=
 =?utf-8?B?VSt4ay9CR29TSS9lVzJJTHRpVlVlN0V6NTA5VzZHd1NZS0dmM25UY01lRW9Z?=
 =?utf-8?B?TkRoM010dmxEVkQvQ0pxRjgycThKOTIzbVorZlpxcWZUSXVRQWdRL0RXV3F4?=
 =?utf-8?B?UkpZSVM3bkpBSFJPVFpXNUpNWTdjM2NiemNaeVI0VDBxa3laNEdtcEZqd1pN?=
 =?utf-8?B?ZHUrMzErZEJOVFEvZEJYb3ZiM0NDTVBnTTdRK0xWVVdYYVJNcHF6SFlyTEli?=
 =?utf-8?B?Yk96WDlHZFAwQlBERmQzdlJrK2krc3MzM1NwSHpzVmM2dExhVlZ3SEgvTEVj?=
 =?utf-8?B?UkZGWElwN2FkdmNQWC9Ed0VnS0tZbjFJdjNBVTBJbjFZZy9GQTVkS1RtZ0xZ?=
 =?utf-8?B?c0ZCNmM5cGJSQXhtei9BOXFpQW42am4yVmYyL1F0Q2FNMEluS0F4NUxlbFlK?=
 =?utf-8?B?UXUvODRzN2tkMXhoeEQraHB6QjhzUXBna0lGWVh2aUF0d1h2c1Fla3R5dFhQ?=
 =?utf-8?B?S0FJK08ycVFaVUhuTHR2bnV2cWdqbmxiM1dtd0RZR0k5Z3Q1VE4rOVNtdnlZ?=
 =?utf-8?B?WGZRVGJhZ25zS25DV3VYd1NQR1RBbnp4dmEvOFF5QThQTFVHZkRGbVR5MUxn?=
 =?utf-8?B?ZzZQTkF3aGFzcWM5SnhQajF2RHJUSnFxU0p0ajNOS25SbW9lYVg1N3Z5cVgx?=
 =?utf-8?Q?86GIy3uiJZqqk8od53P8Ok3C0LPHztxyt3bFc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFFqRFB1Ukp5SXpTZ09iNEVUSkxYNzQxRHZWNU1tSlhJcDdqZnF1Uy9lTmNk?=
 =?utf-8?B?R21QcGljczY2MnhsNEFkbWoydFNFRjExUWg3U01jVFFISWpZanJDVmdib3li?=
 =?utf-8?B?RENqNGlqS0xUMmZ2WWNIOThjWk9PTUYrM25kSWQ3OTZaZVVDTlN5VGpWWHpV?=
 =?utf-8?B?dTkxT2tmVkRTT1ZpR2pXcGFhWFEySTNlOVhMVmtGdlhnZXZyaW9lSkRBdENT?=
 =?utf-8?B?SWJQaXo3cGFHcmNNZG9Kand6N0FETnB4eTRrUFhpMUhxTXRQQldwZGdBY25u?=
 =?utf-8?B?dnBDUEFlcjY5WG8rSXlTNHk2ZEdVNkxBNW5qNmFLSElMemlWT21DSGZHVGFO?=
 =?utf-8?B?Q1Y0RERqNVN3WEFHSkxCRGFmcnN6RHRJaE90WGhBT1E2Z3Q1dk82bmw2dk9z?=
 =?utf-8?B?bVRLM3NEcTh4dG5RQW9CTkcwTHRhbG9FSHg2U1JGeXpSRVBRMllqTE9WSXYv?=
 =?utf-8?B?cndYSm13d2hPYzNzdnI0bWw2dEdlRExFWStORkZmUWIzVVNvUk9ObVdyYzFL?=
 =?utf-8?B?TnZybXNVaFg4blVwTUFwK2ZxWFhPSnRINTR5YTZzUGJYWGFBbHBNNSt4Ulpa?=
 =?utf-8?B?Nm84NmZ0OSs0bE9DcXNkQllDV0NzKzVmS2JmNitYQTdCUTRieFFYZGNYRlBt?=
 =?utf-8?B?M2FHYnh3U1dGVTU1Skt1QndLWXJpUGgxbmJ2RDdjZkVqVDFJUWNyQ0x1YmdM?=
 =?utf-8?B?eVBFQTNkS3ZXZGZvS2grMHlBdldiVER5dytiQUVNdnlGVlJBdGFFemVDODJR?=
 =?utf-8?B?b0gwY1dqNUZUK3NOZVJYRHl1YStjczB2VDZXTksrN0NKMVlHeEtWdlpVSGpX?=
 =?utf-8?B?ekhzcWpRb09kcHZQZ0dSWW4vZHpoeUxjMHp3WkUxN3ozR1VRSEVtWG85VFhw?=
 =?utf-8?B?NWlZTzNOUlphbkZFQmhHbFFkNnRFRVd1OXBEWSs2bWxlUGdDdDh5b3ZxanZl?=
 =?utf-8?B?MlBBVWJsUGtrSkNXcE8yWnpKek1oR0tKMjdkVjl2dFpLa2hjNG9wN25jdGhq?=
 =?utf-8?B?eStFa1cwUGt3TWtBVFAyUCtadEc3d1pnY3lqMVo5NlZhWHZhbjZYaU9ia3RU?=
 =?utf-8?B?MUZQbUszM2w4NjRUaGJXMWhLUmFESVJ6RmZkVjRBbk8vMkZYZXBvcmZLN1JK?=
 =?utf-8?B?NnNvb21xUXJPRU1lV2VjSWJLZWsyOU8yV1hyejVXYklpMk94U1dpK24vSWUz?=
 =?utf-8?B?czZ1WkprN05jbUZQeE92V093Q0ZSTm5abXRzdTl2UXJBUm9LY1czMFFocUly?=
 =?utf-8?B?UFNwQkxKY3AwMVV6NFAyV1p3Tjh0L2VQZ1JmMDYzZ2VEVHBoYWQvZ1RBUDkr?=
 =?utf-8?B?a2w2YXRSWVRVOEJMKzZIbW9Db1o4dVRrb3R5MEVscWRVUlNTYlZtZ3FTWGV1?=
 =?utf-8?B?RlRGUnA3aXUxZU5ZaWtQUkp4VUgrS0RNOXM0TEYxZkRPSWR6VEkrRUlscjl4?=
 =?utf-8?B?UWk4WmhKTkRQSEFUaU9YWGFKQmlBeTZMRGp5cmdWNjI3ZWpHaCtDTGRSREto?=
 =?utf-8?B?TXpjRGI3Y3BmVmh1K2dqUGJnb1hjM09KdERnVHJta3JRSjY1b213UkFtS0Q5?=
 =?utf-8?B?N2dTalFZT1VudDhveU5FVzkvb2ZpTVlodERLS3BqY2EwZDJzcGVrbTMrZFdm?=
 =?utf-8?B?dll0S3p3b0w3Vm5tdCttT0kxM2hMZ3JJZ3FMK3p0MUI3QUxZV01vQUsyTTNk?=
 =?utf-8?B?U0FhanBUREhUeEQ3ZWU0RERzemZMd2VtS3JLdUVHYU9Tb1FvZzBMKzFYWDB6?=
 =?utf-8?B?bW9FYW02RS92UXkwTXBSeUxzd0JsUTU3cXZwdWtOOTNhdDQ2YmV0d1lCeVMr?=
 =?utf-8?B?b0RoTUI3Z0lFMkxFS09NQklWLy9NQVBlOERPZnlWTVdCYTFsL3h2YWI2bWpN?=
 =?utf-8?B?UDRhZmh2R2VQUFlLQm9OaFppRkpBYWFQMUdCeWlCY3hycUlPejF4Y0s4UWFD?=
 =?utf-8?B?V0VXM1lVdVFNMDdVOGZjWmdITFR1MWpjQ3dXZHFiY2NHVTR6OEREcUdVaER4?=
 =?utf-8?B?aUdwcXNXN1gxUnZkZXptRzkwTzk1WW9uVmtUUjMyU01zVFhUUUxPelh2YlVm?=
 =?utf-8?B?TFdYTFB6U3R3SWl2b3NQa3kxN3ZqRkwySi9ZTG9IMWQvd1Bwc25jQ1hyVVpz?=
 =?utf-8?B?S29MMm02ZE92VTUrZStVc3RCbGRZWHVTVmVLM0xiVTY2SzMxa3VCWHU1UnY1?=
 =?utf-8?B?NGc9PQ==?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54590657-31ba-49b4-11ec-08dd78969528
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 01:17:10.0619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hnj2Z7VLSARtj6cpZ3Yj+azq4/J6+cd+492q28GE/tqsPRQSXAh7JOhUs1VNbjYj6fBMqnGpRXAj1Z/AWKKJU7+oB4iLxV38xS0M2NnN2R8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6390
X-Authority-Analysis: v=2.4 cv=Td6WtQQh c=1 sm=1 tr=0 ts=67f86d9b cx=c_pps a=BUR/PSeFfUFfX8a0VQYRdg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=mDV3o1hIAAAA:8 a=t7CeM3EgAAAA:8 a=JfrnYn6hAAAA:8 a=hSkVLCK3AAAA:8 a=1XWaLZrsAAAA:8 a=3CpiQXi6ZKjA1XfMmrsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22 a=1CNFftbPRP8L7MoqJWF3:22 a=cQPPKAXgyycSBL8etih5:22
 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-ORIG-GUID: 6LRUficVxZiR-resZOaNvUJCTTD3wxMe
X-Proofpoint-GUID: 6LRUficVxZiR-resZOaNvUJCTTD3wxMe
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 clxscore=1011 lowpriorityscore=0 adultscore=0 bulkscore=0
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504110008

Hi,


Could you share the config with me so that I can reproduce the issue on 
my setup?

I have tested with x86_64 default config without error, seems there is 
something different with my local setup.

Thanks.


Br,

Xiangyu

On 4/10/25 23:53, Sasha Levin wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> [ Sasha's backport helper bot ]
>
> Hi,
>
> Summary of potential issues:
> ❌ Build failures detected
> ⚠️ Found follow-up fixes in mainline
>
> The upstream commit SHA1 provided is correct: 517e6a301f34613bff24a8e35b5455884f2d83d8
>
> WARNING: Author mismatch between patch and upstream commit:
> Backport author: Xiangyu Chen<xiangyu.chen@eng.windriver.com>
> Commit author: Peter Zijlstra<peterz@infradead.org>
>
> Status in newer kernel trees:
> 6.14.y | Present (exact SHA1)
> 6.13.y | Present (exact SHA1)
> 6.12.y | Present (exact SHA1)
> 6.6.y | Present (exact SHA1)
> 6.1.y | Present (exact SHA1)
> 5.15.y | Present (different SHA1: 8bffa95ac19f)
>
> Found fixes commits:
> 3a5465418f5f perf: Fix event leak upon exec and file release
> 2fd5ad3f310d perf: Fix event leak upon exit
>
> Note: The patch differs from the upstream commit:
> ---
> 1:  517e6a301f346 ! 1:  b2173ec15f3b2 perf: Fix perf_pending_task() UaF
>      @@ Metadata
>        ## Commit message ##
>           perf: Fix perf_pending_task() UaF
>
>      +    [ Upstream commit 517e6a301f34613bff24a8e35b5455884f2d83d8 ]
>      +
>           Per syzbot it is possible for perf_pending_task() to run after the
>           event is free()'d. There are two related but distinct cases:
>
>      @@ Commit message
>           Reported-by: syzbot+9228d6098455bb209ec8@syzkaller.appspotmail.com
>           Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>           Tested-by: Marco Elver <elver@google.com>
>      +    [ Discard the changes in event_sched_out() due to 5.10 don't have the
>      +    commit: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
>      +    and commit: ca6c21327c6a ("perf: Fix missing SIGTRAPs") ]
>      +    Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
>      +    Signed-off-by: He Zhe <zhe.he@windriver.com>
>
>        ## kernel/events/core.c ##
>      -@@ kernel/events/core.c: event_sched_out(struct perf_event *event,
>      -               !event->pending_work) {
>      -                   event->pending_work = 1;
>      -                   dec = false;
>      -+                  WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
>      -                   task_work_add(current, &event->pending_task, TWA_RESUME);
>      -           }
>      -           if (dec)
>       @@ kernel/events/core.c: group_sched_out(struct perf_event *group_event,
>      + }
>
>        #define DETACH_GROUP      0x01UL
>      - #define DETACH_CHILD      0x02UL
>       +#define DETACH_DEAD       0x04UL
>
>        /*
>      @@ kernel/events/core.c: __perf_remove_from_context(struct perf_event *event,
>          event_sched_out(event, cpuctx, ctx);
>          if (flags & DETACH_GROUP)
>                  perf_group_detach(event);
>      -   if (flags & DETACH_CHILD)
>      -           perf_child_detach(event);
>          list_del_event(event, ctx);
>       +  if (flags & DETACH_DEAD)
>       +          event->state = PERF_EVENT_STATE_DEAD;
>      @@ kernel/events/core.c: int perf_event_release_kernel(struct perf_event *event)
>
>          perf_event_ctx_unlock(event, ctx);
>
>      -@@ kernel/events/core.c: static void perf_pending_task(struct callback_head *head)
>      +@@ kernel/events/core.c: static void perf_pending_event(struct irq_work *entry)
>      +
>          if (rctx >= 0)
>                  perf_swevent_put_recursion_context(rctx);
>      -   preempt_enable_notrace();
>       +
>       +  put_event(event);
>        }
>
>      - #ifdef CONFIG_GUEST_PERF_EVENTS
>      + /*
> ---
>
> Results of testing on various branches:
>
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-5.10.y       |  Success    |  Failed    |
>
> Build Errors:
> Build error for stable/linux-5.10.y:
>      kernel/trace/trace_events_synth.c: In function 'synth_event_reg':
>      kernel/trace/trace_events_synth.c:769:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>        769 |         int ret = trace_event_reg(call, type, data);
>            |         ^~~
>      In file included from ./include/linux/kernel.h:15,
>                       from ./include/linux/list.h:9,
>                       from ./include/linux/kobject.h:19,
>                       from ./include/linux/of.h:17,
>                       from ./include/linux/clk-provider.h:9,
>                       from drivers/clk/qcom/clk-rpmh.c:6:
>      drivers/clk/qcom/clk-rpmh.c: In function 'clk_rpmh_bcm_send_cmd':
>      ./include/linux/minmax.h:20:35: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
>         20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>            |                                   ^~
>      ./include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
>         26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
>            |                  ^~~~~~~~~~~
>      ./include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
>         36 |         __builtin_choose_expr(__safe_cmp(x, y), \
>            |                               ^~~~~~~~~~
>      ./include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
>         45 | #define min(x, y)       __careful_cmp(x, y, <)
>            |                         ^~~~~~~~~~~~~
>      drivers/clk/qcom/clk-rpmh.c:273:21: note: in expansion of macro 'min'
>        273 |         cmd_state = min(cmd_state, BCM_TCS_CMD_VOTE_MASK);
>            |                     ^~~
>      drivers/firmware/efi/mokvar-table.c: In function 'efi_mokvar_table_init':
>      drivers/firmware/efi/mokvar-table.c:107:23: warning: unused variable 'size' [-Wunused-variable]
>        107 |         unsigned long size;
>            |                       ^~~~
>      .tmp_vmlinux.kallsyms2.S:196892:57: internal compiler error: Segmentation fault
>      196892 |         .byte 0x0b, 0x74, 0x77, 0x77, 0x5f, 0xb6, 0x73, 0xfc, 0x6e, 0xbd, 0x6d, 0xed
>             |                                                         ^~~~
>      0x7f74e8f6cd1f ???
>          ./signal/../sysdeps/unix/sysv/linux/x86_64/libc_sigaction.c:0
>      0x7f74e8f56d67 __libc_start_call_main
>          ../sysdeps/nptl/libc_start_call_main.h:58
>      0x7f74e8f56e24 __libc_start_main_impl
>          ../csu/libc-start.c:360
>      Please submit a full bug report, with preprocessed source (by using -freport-bug).
>      Please include the complete backtrace with any bug report.
>      See <https://gcc.gnu.org/bugs/> for instructions.
>      make: *** [Makefile:1212: vmlinux] Error 1
>      make: Target '__all' not remade because of errors.

