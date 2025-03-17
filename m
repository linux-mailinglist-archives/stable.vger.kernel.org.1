Return-Path: <stable+bounces-124607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D47A642DA
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 08:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F09166076
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 07:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B9021A433;
	Mon, 17 Mar 2025 07:10:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AFA21A424
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 07:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742195410; cv=fail; b=TgMryXxM6qQkLL9SiaMj3DvAHWNlaE0jcLlHyjpLFuRC+fKSW/p7vAWyDNI9x15EoQdRgKBJTEUtNY8l+fSL4xMwaYCpf2/bMnrYHE1iXFNS0A2wiGdUQruRzen8bg7yCTBrxOhuLaQsy5uIpQTJX4n8Y4F+UDqkJyM38MCaTQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742195410; c=relaxed/simple;
	bh=JoqFeAe6Hgav+SCfe3Q0yZK7qBh+xpCYAfBGVR6OZHs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n4jVmbHL/5Qsa1GELL5vyUXvxzSyYDnnWrjMB8foC7ak+on8zj5vo9uXwJbJtbcPWAuFlWSMjRSVeERHK+fL1yri6uPlBUnYd9fAmNwfogmYOVVXUkTW9eC1vaxYB97X/oEAXJ4/GZMNM3LjNvvyNYTt0bISK+DTBh9MaDJORUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H6wDpS031692;
	Mon, 17 Mar 2025 07:09:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45d0h91rqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 07:09:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJD3QAqzIPYOZkDMEG7jVOFZUhFRQX6ZbFlGAQBbGZVWPjLL3/LcNJjr05sA0OtlA2Gt1zdIh67691yDVTbsF1qn/aAZjz0wV8MnfDUP2iWQjVKfBV+roaib3X/7PE02IaEUwN1T9B2dkiSnEAqWtXxwLjdk3BXKdpZxxyx6U+Bd44otN8D7kDW4mUdxz/gtkGVuz+eyAXwpeI7SZG5Thcr1rKQl3Oj8rnce7LEoffm42i30kow+sJfIKiMZAz+TLJ2oqAeMBsG5jarBkHkSImzZT6GYKyeDJWVP8Pocc9vI2l5B7owmJrLtkyvvxO5G0Yq839agp7LThle5PTad+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LToSH4qDRbfWWfchzYx+N3H6F0DDqH2ZFSxCJPPspSo=;
 b=O2heBHIa1EjwjQnn9spN9EsYs+XZvYVk0GssaOlnWD7JgAKCXctI0mF3IYoV77IHr0vmi9MXTeUY+Ic0Fq6UUQmt8AQWLGlOkpsWGnCjNeKV02p3QUxnSbbWNX9p+BLerfUGCw4kWgzauDdMIK7Os6iSiBR1jTWh1JKJySUyKLNforWdkA8TpSdH4X05/HYJbETnT+dfoL+rLbVQxa2pWR5mobXip/HXqiNSm2jVG3Xwbd3OikWEwbqCzyrbn8moKOYpw5IJnwMhMMsrDUG+xpU6EBXxx7kp+WU5aDPf45fj7Z/FDT/ipG4MU4GKklH2PsdA4vOXm1OhoMRVPorh/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by SA0PR11MB4672.namprd11.prod.outlook.com (2603:10b6:806:96::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 07:09:56 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 07:09:56 +0000
Message-ID: <3fd37132-0162-43a3-9543-f26ecec9a7c0@eng.windriver.com>
Date: Mon, 17 Mar 2025 15:09:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5.15/5.10] uprobe: avoid out-of-bounds memory access
 of fetching args
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mqaio@linux.alibaba.com, mhiramat@kernel.org, stable@vger.kernel.org,
        zhe.he@windriver.com
References: <20250317065429.490373-1-xiangyu.chen@eng.windriver.com>
 <2025031710-plexiglas-siding-d0e8@gregkh>
Content-Language: en-US
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
In-Reply-To: <2025031710-plexiglas-siding-d0e8@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|SA0PR11MB4672:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a25404-b59e-4d1f-d904-08dd6522b8c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUVNdTQ3c2NmQjAyUkZrQ0VtMFczRDZlK2UwWW9ia1B1d2dmbU1XSGZreXJI?=
 =?utf-8?B?RFB4Mm15S2cxSE13M0JFQnd0enpNYkYwY0Jvc0VqQ2g3cUtJSmNBZEtuM0I4?=
 =?utf-8?B?VjIrU3UzTGQ2cGVsTExML21ReUZBeGQ0S3BZV05iZW5vQnlmR2s4c3VsM1ZM?=
 =?utf-8?B?Q3NpUWw4VHRTVHYyaktmS0RLQ0hwVThZc2VCQ09HeFE2eERkVHZzcHpRSHV4?=
 =?utf-8?B?SDNEbFpwZitaRGFSUVBlMWpXTVVZUTl1N3RSV2ZQc1p2ZFQybWk3ZG5ienJG?=
 =?utf-8?B?K1phR3NKK05GWlRrYWhZdkJxbm9EMnhrTVVPNDdjWTJwMXhwV0EwN0hkR3lj?=
 =?utf-8?B?TmVXSSs5Zi95VHBDSFV6cE5LWmtPU3BWUWJwSXdsbTlJdHlDM3I1OEw5Y1h2?=
 =?utf-8?B?eERNOER5dWpsdU12L1NBRkJ2RFlqaEEyeVNKQjN6L2dqZkRkaytnTlphTzZW?=
 =?utf-8?B?MWRpelRQRjVsNFFMV25BT1dWWGIxczVaUitNYXNxcERtVURhbkNzQ0NGTk5o?=
 =?utf-8?B?eXdMY3NrTXo1VFVHMUduNEZWR1JtUWFvaFkrcDlTNGVEVnJ1NDhHZFZJcTFQ?=
 =?utf-8?B?enNWb3Via2IxSnNmNDVUbXJOU1dNOWl6UFNKUEQ5TjZqNUlhbEMrQUs5Kzdw?=
 =?utf-8?B?Z24rUngvSUhXeWtJVHU3NnFnUW9aeVlLS2x3YU1FeXM5d0FPeTZZd0dkeTNB?=
 =?utf-8?B?VXdYL3R6M2xBWHZtUjdHbklSbXJvallRa1hsM3EwdlNza0t4TDMvTzI2M3Zn?=
 =?utf-8?B?WEhMNUxhck5rdDBOSmFFbFZ0M3JlN1dYWnByZjhDeHNDbWlzeGFiSzBWQS9Y?=
 =?utf-8?B?MHJndmVLVlV3Wkx0S2NqRkhHZEQ5cWYwOVp6VkhaTXo2dERhLzgvbHhiZUEx?=
 =?utf-8?B?Q0tva2xnZkVKU2UxUG03NFNpNkZDeGJ2aXJhb05HWUxWZXBXNjFCa2Z2RWt6?=
 =?utf-8?B?dW9ERU9wd3pPajh0QnQ5Y2IrcW9GYjIvazRHeElnalhCbkJyZmgxbUVyME5V?=
 =?utf-8?B?MXJranphRlJSdytCQ1JWRVF2UDJMeFJJL2NEdEtMTkFEbTAvY3lWMHNmNE9x?=
 =?utf-8?B?YmQ4MkFrb2RCVDZuVUNiT2lOK0pqNERXOFAwZ1F0OWc3ZlN0LzV1bVQ2OGV5?=
 =?utf-8?B?ZnhyOEp6bmZ4VVhkdFFLU1RzTG9ZUnd1MkVJS3lMWHVBakhCa1dCYWhjbHFU?=
 =?utf-8?B?bjFDclhqWWM2WVBaaTAza050SjVEY3dNVk9XSlZLRERGN1g0b2w3WGVtMm5L?=
 =?utf-8?B?Q1p3UHZsVU9yNDZpNS8wUk5kdXZaY044cWNNai9sdWUyQVVZUG9ZZHk1WnJj?=
 =?utf-8?B?aUFFNzZ2K2RDY0NKQUcxSVQyQjVybXQ3SXkvdDM4bHpEenhQM2gwWnZOSEtr?=
 =?utf-8?B?bEh4VkliSXo0WThUZzRUc2tlZVBaQTdvaGp4YUoyWUF4YWE1c0t0ZTlIRWh2?=
 =?utf-8?B?cUp2cGpkYXROa0UzLzNyd0szMWljM2tRZUVqbzZ4eEFiSUpheXlXeTltSjVa?=
 =?utf-8?B?RlkrdHJhYTlHMUwxNTM4cVpXRTJDZ2dYMWZ4ZWhQdWpyallJakErN2lHN0dH?=
 =?utf-8?B?a3oxV1YzdUlvTDBUVTh6OXVFeEZvVjMyQkxPam5Ia1JLMHhqamNWUEFYY0hk?=
 =?utf-8?B?NDVuTHNTTmJlenkzNThCeUtxRHhnMG5tY3dueHNycDFIQjRUNi9hUHJPdm9R?=
 =?utf-8?B?MnE0M0R2MThOZ1NWWTUwYURKVk0zMS9FNXNFL040YnJVbXBZMk1XOEVsQ0pD?=
 =?utf-8?B?bU9iU3phWWIrOUIzMElnUEN0aTh5MGhmSGFiTjk1VGhFaUVlQ0pldEY2WVZU?=
 =?utf-8?B?Q3BxdnBIc3dsRnpxZ0srYzd3UFdKSUJrRFFBSGd5YzF2NEZja24ramVxZ3JL?=
 =?utf-8?Q?4fL+sc1PMqL62?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVlJS0NpVFFjN0tWMjBheEVoa2NCL1IxNXFkV3JTbmtpd0RmMEVtQmZVcThE?=
 =?utf-8?B?KzhNT0JWTng3TmFkS3JqbFhiN2g1RUw1ZkZjbmx0T1BjL3YxdnAzc2QzdXBv?=
 =?utf-8?B?dkhxWWpMOEZDTHlRNkNRWHR5dzRJZEo2VEpnU1RXU0pvalFrT1djTGJjaGVq?=
 =?utf-8?B?QnJSVVFLbnhFWXcxYUJZVytBL1ZOalhzNmRud25HWTdMTTNEMjhrNXBpeGdU?=
 =?utf-8?B?bHBlT3d6RDVVOGdSb1JSNnRmZG9Mci9COTlsT3JpQVRMenFJamxCWk9FMnF4?=
 =?utf-8?B?Y2JhZjB4eUtOdlo5cFd0TUZ4UlZNOGViYWlxa3hhTWhzY2NUdmErZEtrMGp1?=
 =?utf-8?B?TW9ROXNXWWo4bUEyRXZlYmRkV2lmc2xWYUlYcE9OVC9HUzlaeTkrbWJZSHkx?=
 =?utf-8?B?N2hzQXoxQ3FWWEtlYkpWSHN3aUJzODhPMWhia2RxN0pCb2pjbWpUM2RBNWdL?=
 =?utf-8?B?NjZFL2xLYkhlRFUremdFa2N6QjRuQzFhZ0p5WjFpY0UzNFZ3L3poMjl0WEcy?=
 =?utf-8?B?cUJ3KzFVbG1oM1luZHEyOUJMLytyT0tra2owVnl4dzdHenRaRnFITTlkdnBV?=
 =?utf-8?B?Nkcvc2NlcTdFbkl6elpmazhKWmZudlF6MEEwbWdkbkFwN1JnbTJQQlpWeit4?=
 =?utf-8?B?L1I2a0pMS2thNVNDNTV0YUxqWmFHSnkyTElpMHd3S2ZkOFdMWXpzSWxTamlt?=
 =?utf-8?B?cWJxWG5pdEUwWWNrVXcwVTFGaCtHeWNOSHMyQzRPbGUxa2hMK1JIREliRWk4?=
 =?utf-8?B?VjJiMDY1MzluUW5mN2R4K043eVByaGh1cU9lZS9zalVCazVmTWNyeVhxSWtz?=
 =?utf-8?B?SHlTSCtrWWJSOEJURE5DVzRyUHNDSElmNXFZa0ZYeFByNFpxNlRwaVZOLzNV?=
 =?utf-8?B?YUh0YkNOUGR6TzVJd1JkZzJQTHN0bGthd21YZGgrZXYwakNyZ0ZKVkhMQ094?=
 =?utf-8?B?dVRCa01JVXhucG5HMTg0LzJ3ZjV4TFNROEpDbnRrM1ZyTm11ckQ4bWk4SUl1?=
 =?utf-8?B?RnQ0eWZ5RnB0Nk9xSVRHS0dyWXVoV1M0NEJWNUdIUWlLUERFcm11LzlHMVcr?=
 =?utf-8?B?RDRUYmJFRjlQM21FNTZqWXNsTDRkb1hqeWZ3V0xxRU9pOHIvYjl0QlZTbjFQ?=
 =?utf-8?B?Uy9XN21jMC9VUDhmUDlPb1A1ajZ3dGo5SlY3MEpoZWFleVc4cnFUNklha0Jp?=
 =?utf-8?B?azhhYlZYOTgvT2FEbmNYc1JsMW1NYkExWDhZUm42Z3FKSTE5S0lLOFprcVN4?=
 =?utf-8?B?TU5sMHFaMld2ZGVBOW51dSt4NlRqeEpJcG9VTDRIUWZMTDI0bGpKNzhSUHhk?=
 =?utf-8?B?YUcwdmpxMzVhN3VpbVdTdDhLbTJIZTAxZlNUL29YUnlFU0RreFZhcE5BR0JJ?=
 =?utf-8?B?QVhDV2p1OCt4dXZobW04UFZvQ3FrVzAzT1VqY1plMlRKM3o0YU95ZW9UQjg0?=
 =?utf-8?B?eFc4MjBteDI1SmR1dVNhSUdSRmhRN01tZ2V5UEFqMS85cWx5WkZUclRsRHEy?=
 =?utf-8?B?OGQ5aEVNT0NUa2lXTnRRNGJVOEFNZVc3alBja0lTRndYSlpabW5vcFpGMXhv?=
 =?utf-8?B?dTM1WG1xc2kvejJHTG5EOW5hL253cHpLK3M1dWFoTng3OFdkbkl4MjVuVEpt?=
 =?utf-8?B?d2xYdnMxS1VadDN0YWZYdXB6NnY3bVZSZHVWdFJ3ZFNLTWZRTDZnTGVEZDNJ?=
 =?utf-8?B?SlczRWlHRWdOZDdvVjd0OHRKeTVZR0tHT2cyM2pkLzJEQ0RmRmdNcisybGlG?=
 =?utf-8?B?QUYrejBhWlZnajQzdnJQTWRkUWt1UFZ3Y3gzaXJvL1Avc3UwSWl0UTI3UytJ?=
 =?utf-8?B?K0pURDRFRzBpNUk2RjU3SUZ1eGpZaDZ1SXZ0a0FxRVMxK0UrOXJpdFQxNzNX?=
 =?utf-8?B?ZXJrcVRDQlZDbEtQTWgrZXNFU0xWTmxubENSMmJEWkpGUGR4ZDFlTlpLcHJL?=
 =?utf-8?B?OHBmMTBMOU84RVpCbnNySFU3WWVTQ3hjSkNTZUI1MW84UnF0YzlZTTRVRCtE?=
 =?utf-8?B?VTZKTXloZ09wRnI3N1FYZURZTE5CUmx5aWZIOFp1Wk8zbXdvU05xczVkbDBE?=
 =?utf-8?B?ODNyNlZod2Z3ZnVkSmhDTWpJSElFY216cDJOYnpyckFjbTlsdGgwQWhxaXg0?=
 =?utf-8?B?ZnVtaUE5U041RnRCNXpjVFNEWE9uZUt1endlR2I2TU1CU2QzcUdoMHlYSDEx?=
 =?utf-8?B?c3c9PQ==?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a25404-b59e-4d1f-d904-08dd6522b8c7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 07:09:56.2461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vMW9WjrPWRN5Ls+JBqZyyvQyRkphwC8q4lVXXy4sJIPo6TprsAv4iBd1j31rjpQoI3q+7rrQJoQLzEXYTofAsxYDm0pbnLKsSGr9UpTCfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4672
X-Proofpoint-ORIG-GUID: 91J4BXtHUrBxgJB17NhbdpUyxO7_GswY
X-Authority-Analysis: v=2.4 cv=ROOzH5i+ c=1 sm=1 tr=0 ts=67d7cac7 cx=c_pps a=zzjaJ2HwkiRAih7KxKuamQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=SRrdq9N9AAAA:8 a=GAiKg1D5Wh3Fm5ys0KQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-GUID: 91J4BXtHUrBxgJB17NhbdpUyxO7_GswY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_02,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1011
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503170051


On 3/17/25 14:57, Greg KH wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Mon, Mar 17, 2025 at 02:54:29PM +0800, Xiangyu Chen wrote:
>> From: Qiao Ma <mqaio@linux.alibaba.com>
>>
>> [ Upstream commit 373b9338c9722a368925d83bc622c596896b328e ]
Hi Greg,
> <snip>
>
> Why is this an RFC?  What needs to be done to make it "real" and ready
> for you to submit it for actual inclusion?

We try to backport the fix to 5.15/5.10, but some logic functions are 
different, the prepare_uprobe_buffer() in original

commit is not exists on 5.15/5.10,  we moved the fix to 
uprobe_dispatcher() and uretprobe_dispatcher().

It has been tested in our local environment, the issue was fixed, but 
due to it different from original commit,

this might still need to author help to review, so I added a RFC label.


Thanks,


Br,

Xiangyu

>
> thanks,
>
> greg k-h

