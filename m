Return-Path: <stable+bounces-127504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9A8A7A16B
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 12:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7CB9170D63
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 10:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642C124166C;
	Thu,  3 Apr 2025 10:53:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7402E3385
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743677584; cv=fail; b=kEnYPvwTMAKTXwhMSuxjlsDHJWrWfWkJ9AHDbhslBKYjifzZm802dMQgHWDL3A+ZZSnUyyKWg476/fcYF4M83sTOU2ycMRlctFG1O570+zfCp9xglyEOpAMg0Ul3cV+fafqD3jq2ijXgGn2B07imzI92dCB/U0b6UY43myfzohg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743677584; c=relaxed/simple;
	bh=ZWshzNddHeSAjykaTPmfejYOpEeWW8K0mGKu67C2A5g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FM6c63cBuowycs1xfzVXxXm9axhLfyi5BigQjXVDyr4SqYtJJq7E9pUBaGunN0XgOPTdIBX7cDaiz6FSYG6pA0rd2J8bZQ7aq0C/XuioqVHdFKIFz26HB76G2bY1Q7QG86USs9SeyiuaBRwCWpuCz+IqK+4ixAlzGr+xQlsM8Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5339v2sC018774;
	Thu, 3 Apr 2025 03:52:42 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45sg1u8kwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 03:52:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLGJkqxJ9P8PXedGBpyDoddWf5DT/3PvT8a+5AYkjtyrtyud1nGjv573xvs1ZCEPj1Q3pNwbRbyhwnuDaNf62nvGC9ZnXVNHQpRWuQymOhrMX9z3B4kQeHlb+BPibHrvbfHRDBSDG3L96nTd6pfyXFE/rneR84CtYMMbh3G1IfaoGnfR9mZuJF88+9+0Pk+E5YreGIL333caKi/i7okn6Kc+S1+pm0LFC3JJHvpcJbygcSYhbTc5PWjDRAtkoIKYYFwlOgV9azTnC6OHQ64AqU/qLLQHn6vwd3YjxUe1wrlw1534k8xI78ZiZv6LCSvIweqcNtPJ+bDn/6BzkalUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clFMXwqxzXiq1qn3XiGjrdvACe1pUzX48QiTV9YYF60=;
 b=CGMs+0CRP6gBh3OquU1lhW8wcgni6XasTgrd1qtQxXWrngLBzXUQ6FdJ5XZD9S+NxGK4my9jvfhHkJ0ZvWwK/n2eApuZDCt//KJSuuc0y+n18IdXwBLq0GejzeRhZjd2KYUO88gRMKCkbhki5ckoVpb9UoXkta247QrsYlqx8ApV+V3veUPq+K6zoZjtzqDfxg8JloGjDzxC4mZ3ldc3y33evafjZxA5YuAWPkhNsmTDN9ckZrOFChgSkdEnCLyeQZ34Zy5JC2nsi5NCAi2PUEXbgwAjKTylyJFdaIrHlB6fRfcVuINaDoqmmAGkB3pd630C4EXyPw799Zq6CW7+gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by PH7PR11MB8123.namprd11.prod.outlook.com (2603:10b6:510:236::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Thu, 3 Apr
 2025 10:52:38 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%2]) with mapi id 15.20.8534.045; Thu, 3 Apr 2025
 10:52:38 +0000
Message-ID: <d808abf5-a999-4821-a24a-388fee184ffc@windriver.com>
Date: Thu, 3 Apr 2025 18:52:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y] scsi: lpfc: Fix a possible data race in
 lpfc_unregister_fcf_rescan()
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: bass@buaa.edu.cn, islituo@gmail.com, justin.tee@broadcom.com,
        loberman@redhat.com, martin.petersen@oracle.com
References: <20250403032915.443616-1-bin.lan.cn@windriver.com>
 <20250403032915.443616-2-bin.lan.cn@windriver.com>
Content-Language: en-US
From: Bin Lan <bin.lan.cn@windriver.com>
In-Reply-To: <20250403032915.443616-2-bin.lan.cn@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0145.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::9) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|PH7PR11MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: c3140613-a54b-41f1-43dd-08dd729da5fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFkzKzA2TEl2bUJWVUpqZ2dCWXRTR25Ja0JSbHVWdVZwTXROY1BERlFKbU5C?=
 =?utf-8?B?WEREczU0YWt1Zlo1Z0xEVmRzYnlNYVEvMVBYOXJ3QUhnQTczczZDWnZxVlhB?=
 =?utf-8?B?V3ZEOElIdGgxRFRnZnVVUDVKU2NQZHVGRGJZcjJZWEpjelpnWXZzVnNSdnFH?=
 =?utf-8?B?ZFJDcTVoNEQzVEV4MGUva01vWVVjdUJmODdwVWQ2VWpMTHV3d2hYaWxBK2lV?=
 =?utf-8?B?dWF1NXcrZXBSMlZpL3VEaVFsaFdQZTNxRHljcHpReUIvZkxKeGNKTW82WmJW?=
 =?utf-8?B?N1JDdDFkVVFWa1JpRTUvQlU0ekc2dUxTRjBoT0NFSEZxdFhGKzMrbWgxTWxJ?=
 =?utf-8?B?dkxmRDB1Y2FsbEN1NmFPWTUremhsNTJkeC9PMVU4aW1heGVvSndDa3pOR3JS?=
 =?utf-8?B?R3RmSWhlSDRDQ2xmSlkvRElOV2xRTE1reExISlJ4aEpCZ216Nm8rbGtVNEox?=
 =?utf-8?B?S0Faak9zU1lvVlZ3RFJ6UHBUU3Bkb2tLM3ZDSnpUaGxybVhtb2w0bm1lRkRn?=
 =?utf-8?B?Z2hMTmZFRWVIZG9keUVtNU4zc0FUc2l6SVVNTW1mUVRySzB0bmMza3l1Z0ov?=
 =?utf-8?B?aUVnYXJMWUxNbUVnRy9rR2lCYWVIZ1F5bXdXSGxVSjZoS2ZkTjR1UWxOQkxr?=
 =?utf-8?B?TUl2ZXpCZHRtRW9Jb2l3ZmJYdmJtTnFNOTYrTjVpK3lldXJHZTd2Q09ic2lH?=
 =?utf-8?B?M2kvVTEraFF5YS8wMkRxZlhtajR6UFZpeG1vQ09HRWtEMmk2UGNJVGJFaG1i?=
 =?utf-8?B?cU9WRzBycFhJUHdFVGU0VlZrNzFoU1U3YUlKcjdCVHBtbmVjK2JIekJ6ZG54?=
 =?utf-8?B?dTZ2TGZmeGVDbXBSaDcvaU9sdDZrbWx4R0M4bFczMkFWb1kzWXpjNndqRXAr?=
 =?utf-8?B?WVdNWXB0WXhJWlNhb21LRG44WnAxSExQb0dqYXRkaEZ3R08wSWlHdXFJQVZn?=
 =?utf-8?B?R0RuMU9JVm5BdzlraFhZUzdWVHptdGdVa2pZcVM5dnlOTFYvNHAxL0lMWE8v?=
 =?utf-8?B?cU54UEhkTEJtTU5SZENmVVdXSEc4Z2RhRlZBcXhhOVRxK2ZaTHk0VmdPV2NO?=
 =?utf-8?B?NDlxTHA5MmpWRm9KeExGVnl6U1crcjJSbXBBVnJ3aUV1bTdSeXFBNGNPWjNp?=
 =?utf-8?B?STJRRUUvY2JXQ3Q5SFhsdVhoY3J2S2lFTkRlbjB3K0NHR2h6S05ObGlTOEZm?=
 =?utf-8?B?MExmbERZUjd5Um1GVVppYnFmSDhSNnZmdHJ6WWJjTlM1OWcwZVdLMTVQZ0Rl?=
 =?utf-8?B?VmJHaVBKdFpUaklLUG5FV1FOaTgzTjVPSlAya0svV29Gb2tOLzNZcHF2TXVs?=
 =?utf-8?B?OGRnblpzQThBVGNDMGdHbUFudERrbXhjaUh3dTdSczFNYlFLeGNxTldqMUpW?=
 =?utf-8?B?blpmaHNmdHdCdmRKQlplcC9rM3lEUHBvOWg4TXdjTFNVRW4rZmd5czh6UjBp?=
 =?utf-8?B?MGNsYmRaMGZzM1lHRGpCZVBleEYzVGpRUEtacEs4MnBFenZIRnZCTzY3ZmVy?=
 =?utf-8?B?ZTErdlExSU5IQkwvWjBnbW5EWUpxaytyZys3elNXUnFDQmh0VVdjcDBFRXFE?=
 =?utf-8?B?d3JQdyt3QUFrSmZ1NHQxenFXUzF4aU9ickVlK0xORXdDVlY5ckJOaWNtTitp?=
 =?utf-8?B?cnZJR0U5aDVaSWJ5Vk52NlJ6OFk0MFNJSXBzajdTUzV3UDg2aVlQNWMxdlQ5?=
 =?utf-8?B?NlpMVWIvaWkrTnR1cVpGVGEySldRR0xMOHloRnZJaUs0eGtyM3lUN0cvVWlR?=
 =?utf-8?B?L3VkSk1BUlo2NFR1Z0gxQkpOY3Z1VHpkNnBFVGtGcFhpS0k1Mjg0VnBlSXhB?=
 =?utf-8?B?N0M5NVpzcU9GWWVxVCt3Y0FVOGVaZTlKMlpMK3Y1ZVl6Y1U5RERVZHdQSjlp?=
 =?utf-8?Q?rZYjODD3Vo+od?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ykc2eDdHMTlJMEV2K1VxQnRMWXpFMnIwNHJBN09MQnVnU0ZpREpFOW5UZXJM?=
 =?utf-8?B?TmNQZGwrTk5zTUVpL0JRZ3FlVjRNYk51UVFNWGx6Tk9HbTZUakJFNXhjQ1Nt?=
 =?utf-8?B?T0FtT05oWm94WjhtK2VLOUk3YWlPb3NxdkZvZDJMVGcrbUNGbVRUWW9wVTIz?=
 =?utf-8?B?OHJmOEs1ekxpT1hjNDZUQ3pXTDhkU2czcTBuaC9QS1J0elE2dDN2dHJHRFB3?=
 =?utf-8?B?eEIvbW0zaVVBOFVZZGh2Z29vekQzU3FpeUp3QlpzTFZnM0NiNjhNMmQybGpo?=
 =?utf-8?B?VHlRTmVwQUVrZy9VV1BGUFU1aHNhMFoycEJyUGV4SmRtMTZRVnovRUlxTVlS?=
 =?utf-8?B?TnN1Qkp4aTlEd1pDejRMWXZHelI3c1ZyMDRjKzRmQk4yUzRveDRBYzdvMFlz?=
 =?utf-8?B?RHo1WTFWUzNycnhvK21RcVVkTi90SW42K1M3MEFhdzBxQVR6ZHZsZHpwTkJR?=
 =?utf-8?B?VFdnTUFrallQd3RobS90T05LSkh1VFVJTU5udVVWcWRmWTNhSmREbVozdmE2?=
 =?utf-8?B?ZjlWVFBEY2pVUXJyNTdCZ3h4cGl2eDBCeDYwYUNPREpmekRQb3RtYlI0QWd1?=
 =?utf-8?B?Wjd6ZFZhQ1FOcUNWRjR2TSs2QkU3TzRqNkE4eGlHbCsrSm5WMUhROEZjb3ZJ?=
 =?utf-8?B?aXgvSFFxellxck1ZOFhUMCtjUkRrdWh5ZjgyTkRxQkkxU21RUk4yZDlxRldY?=
 =?utf-8?B?dDEvVE5hSVNjbmJ5d1lWU0dPY2tUbnQ5bThuUVZOOHZ2ZnhlakdOMXhNZkNX?=
 =?utf-8?B?bzNmRTczQllNeGFxMnN0L0IyS2c5QkFadlVJVDVxYVZFUmtGUkhNaWxIWmpz?=
 =?utf-8?B?MnlJVkhEK2tyaGpzS0M4Z3BmS2VzVDF3enlCM0VJSXdrdWNLTUpNMWNhMlZ5?=
 =?utf-8?B?RnlrdW9WMTloNklBRkQzWS9SUXFTejhBdmhIWFNkNklHQnRJRm1vT1Q3M1o2?=
 =?utf-8?B?RHFMKzhwSm03bG45Vk45bDlGaVE3cjVMeDlNK3RJVG5RMWVxQjhpQmxhQUVM?=
 =?utf-8?B?UEN1OUdGWmtwS2toWUZzTGxOZG9KMFROSHl1YmJDMm0rYTRlU3FxRXV6N0Yz?=
 =?utf-8?B?dE1uQkZFK3BtYmd0ZzVNSzVxeTAwVGYxSnUySTd4RjU5bzJPcVRYMG0wU1hD?=
 =?utf-8?B?UUVFTElXSklTOXRqVm9NRGEyN1diSVVXU2lXTW80K2hFeFpNZ3pUQkhLUmRk?=
 =?utf-8?B?cW1sd1gyK3NJTVdBR3JPMDVoOWpqaTB1SXBoZjd4R1pkWkh6b1dGMmdwU0k1?=
 =?utf-8?B?bXJzUE95QVVaUzRHVXRPWUJ0NkZQMXZpMm1oVTFvOU5mb2tEM3ZnWXpvS2Nz?=
 =?utf-8?B?SEtacGVlS0VXM2QyaW5yNzBQZG1Nd0tpUU5xeFZYZlU1RnJJY3RRQTR1VmJD?=
 =?utf-8?B?OUVxUDJWTkNnaGtQSmRIdFlSN09uMmZVRDVGS3V1dTJwenMwcElXUklrKzM0?=
 =?utf-8?B?V0xjVzBrMHk5WnlwTVJPeVdDWjFLR3ZJZ1hiTmhYd2FGTjg1dHJPajBUYUwz?=
 =?utf-8?B?dFpYY1JJZW80djl4bnFINkZDZW5RUHdUMmF6ZWxVdkh5YlJwV0wvTmZqcmkx?=
 =?utf-8?B?aWNsQkZzYUs5a3RycnA2ZVpBNVh1Q1FRSDM3alhHUmpIclcxOSt5bVYxbisy?=
 =?utf-8?B?RjNicmZSV3NNT29nV09lakVUazZkVmJOUU1jUTVvOTlCL3JJUTM0SVh4N3RE?=
 =?utf-8?B?MzVOdVFRS3RydlFnTkVrd2xiOHpnMW16Z0I2TDF4dXdkTC9SRVpDby9oL2lI?=
 =?utf-8?B?V1BiWCtIczNJdndPaGQyMDYvbHlRYUJKTHJaaWxGbEhUWU1rTlBVQThrWDM1?=
 =?utf-8?B?bjZuUFM3Y3RlakF6QkVrL2s5NDdPL0lNVFlBUzlGb01QdnFuc0I5R29vY0VL?=
 =?utf-8?B?OHNudUh6cUJmVVN4bDZMZHB3UDR2dXFzTGZzajBibkZUOStlVXdLYTIxclJO?=
 =?utf-8?B?dElEenFwSVlTUXBGL3I0SkZjcTlEUHZDOHFxMlR3WkRmTUI0UFdQc1grYlNm?=
 =?utf-8?B?dUZ0ZTBuRzBHd3hMZjJyYUx3VjhvaU5DaUtCRjc3b0p0TWphLzFkbldmS3h2?=
 =?utf-8?B?U0J6ZlVHOEVzakQ0V0ZsVWhRUVByMlZVekUvWVZwblU5UWRtQktWNXVMblRx?=
 =?utf-8?B?TmR4eUJ0dHNPanBrSDgrRWM1clN6dnRYZXBPejdRTVVaY08vYjY3bERLUkdQ?=
 =?utf-8?B?S2c9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3140613-a54b-41f1-43dd-08dd729da5fe
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 10:52:38.0242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: um455Nav9EYTJabrwpQD1FWM58apf+3ZB37q0hPdbO1ydLRVrwJZwku01fvKbsMlVPaRrsuk4O3O2NXlENYvpySwJqSkYoo7Xt3c3Zo2Dk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8123
X-Proofpoint-ORIG-GUID: SnUkrssmNlQx4wDq1fs-NSAEj0h_sD7A
X-Authority-Analysis: v=2.4 cv=Aqnu3P9P c=1 sm=1 tr=0 ts=67ee687a cx=c_pps a=SXeWyiAXBtEG6vW+ku2Kqw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=Q-fNiiVtAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=I-VpvNiDLu8R5hHaiYMA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: SnUkrssmNlQx4wDq1fs-NSAEj0h_sD7A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_04,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504030041

There is a configuration dependency issue in the original 5.10.y, 
CONFIG_SCSI_LPFC should rely on CONFIG_IRQ_POLL.
So it is needed to enable CONFIG_IRQ_POLL also when building the changed 
source code. Otherwise you get a link error:
ld: drivers/scsi/lpfc/lpfc_sli.o: in function `__lpfc_sli4_process_cq':
lpfc_sli.c:(.text+0x37b6): undefined reference to `irq_poll_complete'
ld: drivers/scsi/lpfc/lpfc_sli.o: in function `lpfc_sli4_process_eq':
lpfc_sli.c:(.text+0x41b1): undefined reference to `irq_poll_sched'
ld: drivers/scsi/lpfc/lpfc_sli.o: in function `lpfc_cq_create':
lpfc_sli.c:(.text+0x1281f): undefined reference to `irq_poll_init'

--

Bin Lan

On 4/3/2025 11:29 AM, bin.lan.cn@windriver.com wrote:
> From: Tuo Li <islituo@gmail.com>
>
> [ Upstream commit 0e881c0a4b6146b7e856735226208f48251facd8 ]
>
> The variable phba->fcf.fcf_flag is often protected by the lock
> phba->hbalock() when is accessed. Here is an example in
> lpfc_unregister_fcf_rescan():
>
>    spin_lock_irq(&phba->hbalock);
>    phba->fcf.fcf_flag |= FCF_INIT_DISC;
>    spin_unlock_irq(&phba->hbalock);
>
> However, in the same function, phba->fcf.fcf_flag is assigned with 0
> without holding the lock, and thus can cause a data race:
>
>    phba->fcf.fcf_flag = 0;
>
> To fix this possible data race, a lock and unlock pair is added when
> accessing the variable phba->fcf.fcf_flag.
>
> Reported-by: BassCheck <bass@buaa.edu.cn>
> Signed-off-by: Tuo Li <islituo@gmail.com>
> Link: https://lore.kernel.org/r/20230630024748.1035993-1-islituo@gmail.com
> Reviewed-by: Justin Tee <justin.tee@broadcom.com>
> Reviewed-by: Laurence Oberman <loberman@redhat.com>
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
> Build test passed.
> ---
>   drivers/scsi/lpfc/lpfc_hbadisc.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
> index 68ff233f936e..3ff76ca147a5 100644
> --- a/drivers/scsi/lpfc/lpfc_hbadisc.c
> +++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
> @@ -6790,7 +6790,9 @@ lpfc_unregister_fcf_rescan(struct lpfc_hba *phba)
>   	if (rc)
>   		return;
>   	/* Reset HBA FCF states after successful unregister FCF */
> +	spin_lock_irq(&phba->hbalock);
>   	phba->fcf.fcf_flag = 0;
> +	spin_unlock_irq(&phba->hbalock);
>   	phba->fcf.current_rec.flag = 0;
>   
>   	/*

