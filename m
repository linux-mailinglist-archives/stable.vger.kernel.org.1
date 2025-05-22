Return-Path: <stable+bounces-146044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0773AC05FD
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 09:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE7A4A0704
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 07:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00B4222575;
	Thu, 22 May 2025 07:43:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F114D221F0C
	for <stable@vger.kernel.org>; Thu, 22 May 2025 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747899816; cv=fail; b=ksbhbUCcZ11jeuCq5FDf6DCR9sFonaCK/2PyR1w2W5sszCRzs7Jm7RsUPBiwfO52CfajtiyjHaKaimv84pNkVZBFli//gx0YxCEdq4CrXm6K8LlUjl3qVhGfWIDIC7ez+6eFm36ysbdX+G50XRf8emb/HnREbVuyz4ndNCwuhFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747899816; c=relaxed/simple;
	bh=FWYGyo3JyL6wBynHY+iAq194SmCCHVx3Urn2YjqbAEo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qCW3OTdaYgpUvnu7dVBjm66yLVyzcGjL9ZvYs/9nlrOcumCPED7iSAgeLg878klD7jSTT9gsrjpXcD4+LbSV/f1Po2VZyP3opMBQdY6LvbdwXpaX+5QIiX1ogmkkCovGA6baegGV8AcTvf/LudTuk2ZfiL+o+6rPWR7LlIjrENU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M7ZRRB012036;
	Thu, 22 May 2025 00:43:21 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46rwfsa95c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 00:43:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEk2xOiI7sVoAns9YJvd8W6Jemt/gvgb1lrOTWUAJdurJMZwBpzXj3R1+S419oLME1uLwXEkO2Ym88QlVMELhicVE8UuGCQEftXjkabtd59grC1lNexLKtBJT488AsDhkHuzSJpZO+cTurczOM9ufeBtjyWJzFrKc8rRZ9XnR8xjhEzWYaxHgVDpOyaEvRRgTlICB+gOPBaxgkSbogsGGGVCHwluN0/kMgamoOrKuViZktqLhEc68rAhSEAJ4sdteaG/YDXVdkzG3VWf9CBmYYoCCmJpHCqkmfE/T8ZtvGOihocDWY+f0Gs1JRlQzZf0pxSEw8lR7HJeeLy+Ybc8uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcyJoFI+6k0XPVcTdslL3wrYgvuwmG0f+cBpgnwJFQs=;
 b=IlxybYciPPM1TpVfsYhBJpMMUnk40LhLUfySi1Gz+WObFQepVMt9C14a+RIICvAwna3SraCGLcxGTM0lIpkcl4aDASj84aEyf8CP5HzSlsTpyQ7uI9FkNkehX99FOkJYGLuwX4MHXAMpBpc+JlkYNebNsu0AxgL5XFiLgbKwCrx5AstTXoO7wcpp2ZG4T+2vCF7pjhqP3iK9b4ktIAXRXw3PB3W1bKGaVtk4Fq+gKoO1dVO+3kF4BbaFGStnW92hf4q3Ec56+RXN+5hhuKMRwia6L/YFoczw4vD+PlSL4K432RZ7YOPn11HcKtIOWPUNYbXUbr5vpIp5Xgg3UvDlfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 by BN9PR11MB5228.namprd11.prod.outlook.com (2603:10b6:408:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.32; Thu, 22 May
 2025 07:43:18 +0000
Received: from SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538]) by SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::3133:62e0:c57c:e538%3]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 07:43:18 +0000
Message-ID: <fc8f61c6-eb98-4102-bf81-a924df303efb@windriver.com>
Date: Thu, 22 May 2025 15:40:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y/5.15.y] ELF: fix kernel.randomize_va_space double
 read
To: Greg KH <gregkh@linuxfoundation.org>, Feng Liu <Feng.Liu3@windriver.com>
Cc: adobriyan@gmail.com, kees@kernel.org, sashal@kernel.org,
        stable@vger.kernel.org
References: <20250509061415.435740-1-Feng.Liu3@windriver.com>
 <2025052021-freebee-clever-8fef@gregkh>
From: He Zhe <zhe.he@windriver.com>
Content-Language: en-US
In-Reply-To: <2025052021-freebee-clever-8fef@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0121.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::8) To SA3PR11MB7527.namprd11.prod.outlook.com
 (2603:10b6:806:314::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7527:EE_|BN9PR11MB5228:EE_
X-MS-Office365-Filtering-Correlation-Id: e0fd2fac-48a8-4245-49cd-08dd9904513f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFVhdElFcUhpZUt4RlB6WldXWEc0WS81UzhuZ1B4OEMyK0dKTjQ5b3BTQjIx?=
 =?utf-8?B?aFVkZXpjQVdnSHFhVzFlbDc1Z0hxOWhXNXRyOFVjYWxlYlJGb3RBdDQ5Rmd5?=
 =?utf-8?B?OGhaL2FOeTNUZUhYbGl0ZFhZZVJnUndrckcySERJcjJwaFJVMW5mb0w0QXJT?=
 =?utf-8?B?YjBNSkYxaW5TNWF5MDZZZ0N2dXpZbVZpYnZWSm1EdU5hd2xXOU1sUlNXOHZs?=
 =?utf-8?B?MnF2SGVLWmh0VVp1U2RoOFZoanU5T3VuZGpnUUlLY252U1lrVHJubmlSNWVT?=
 =?utf-8?B?L1pBZjhUbjdQd3VIUGhheDdWZFd5cGovRHoyclhYd0FiNU4wWW1BMlRMelFL?=
 =?utf-8?B?TmVHbk9EUS9HbmVISkdCc1d6QW14SVZGeXBYSVVjZmdmUHJDNmkxTm15ZDU3?=
 =?utf-8?B?RHJBRDBTaSs0dklUS0JNSXhuWGJCZENZWnA0T3h2ODFyTWpya3RQTVVxT05w?=
 =?utf-8?B?eTlaS1U0VmtSODcxenNiR04waVR4VEJQdk5yVlVKS3ZrVW9DOG1kR3lwdldB?=
 =?utf-8?B?eXFiSWYxWTJmKzN5VmRXZkhDRDYxYXJOaUJSd2tSVUZyUElUOVdGU1Awd2l0?=
 =?utf-8?B?cXZXM1lRMTRlWEtjQnZvdDBJVXpRZlFFMm9QSXZyRzVhS200d0k1R21qenhR?=
 =?utf-8?B?UzViWnhJeHpRMzZaa0lLRDZtSEc1VWxmbktjTXUrYm9JN3hXR3U3YzVORnZX?=
 =?utf-8?B?dWo1aFZnc3UxL0NFTmo1QUgremYvb09OSXdJUTZ5N25MNndMSkdKQW1NNmdP?=
 =?utf-8?B?NDFHMmtDS0pMWU1DOUJYRlFSM1BvZTdaTnRiQ3BhUjlXMkpWTjdKTkwvT2hm?=
 =?utf-8?B?TjY1MXE2Mm1NMUFWUW4zZjVYZXcrSkgxZklHaWVBVE5EOHIxMEZLWDI4SFlv?=
 =?utf-8?B?K2dhR1lMQUVIc091SHpwTDA0VEtkQVRTUGtHaDgxSUFCREI0ZytZVjJBaTdT?=
 =?utf-8?B?d1lkckd2OUw4OEo0WERHZitNMFVhdnBRaEpNbVRnWWtLZk5KYUFUcHJSZ1N2?=
 =?utf-8?B?cWY3S2lvZ2FOVGJsNnRBTHREQkRMdkk5SGowcDBYelFBNy9COHM1dGU5RThG?=
 =?utf-8?B?YXR4UWNWMzFoZnU5bS9yQzV1cUxBaEo5WkVWN3VLYjB1NHRwckN4UVRNZ0Fa?=
 =?utf-8?B?dDdJYmVHaURiODdBYytNd09BTDRIR291NHlMOWtvbFBlMHNPYlNxS2kzdjJk?=
 =?utf-8?B?K2hOeTBKSHc0SmFCZG5PUk9Fb29BT0xUYS95WkNsbnNDWmdjc3lVbmpqTWNC?=
 =?utf-8?B?aEZnYTdwZWF4blBWU0g2TitydHQ1LzVZdWsydTFWOW95QnZJVnFZbFdHRkll?=
 =?utf-8?B?TlUvN2JVU1doeEljTFVvQ1hxZThKQ05QbmdPWVlBV1cxVkVNOHJPV3ZoNnhp?=
 =?utf-8?B?ZVZuVG1XK3BrN2J3KzJOMFloZll1aWFLNTkxL2gyRGcxWXJuWUhmYkpURG45?=
 =?utf-8?B?am5IOTc1cGpOSmsvaGlZL3p5NVYvYkIwWGltZzByL0VoaVM4VjFyYisvVDZL?=
 =?utf-8?B?eHN2YXhoZTREOGdQQlVZQ3ZJaXU1aThLR3ZSeDVEaXcrdzZVNXJQSEFNajF3?=
 =?utf-8?B?Vm15MnZmQnFnYUtGT2xYenVDNjN3T3ZWZUxTUkNmbEFNL2wveVNrd2h3OXNP?=
 =?utf-8?B?dzhPbFRjd1RWaGN1VjdKck9BdzJHMHpUK2RDcmpscmZhK09VL09xVFpTL3lK?=
 =?utf-8?B?Rkk1VGs4RENWSVJlMUdFVEFxTzhabHFYOVY2d0hPeDBNYjEwb253VVNGYU1l?=
 =?utf-8?B?U3I3a0V2L0lyQ2E2c1JiSlU5QmRobEpkWmh5R21SaFZYQ09DamRoem9vMnZ4?=
 =?utf-8?B?cWV1OVZWaFNiY0tJdDZGOFJHWGllWjY2bUQ0TFQwTktyeTlOSWpuRmdIbjVr?=
 =?utf-8?Q?qOirj80MctXWj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkpFQUswTmFpaXZGV2ZieTBTM3dsclQvVlFUbjBIRG5XOVJnd0ZVRXd1WnNy?=
 =?utf-8?B?Vkl6Tm4wd3hCSUxpbm5hWTJ6RFBZa294Q2kyRmFpYlFKOXdtL0FzREZsUzM1?=
 =?utf-8?B?R0JuRFEwVG9kZVF3dFVFTE8wcWduNXRKdXMzemZ5cUlISVN5OUJZTlhZOHZI?=
 =?utf-8?B?MldRZ2VBZGppcjlRWkhuN1BiV2hCZkN4dE9Dbk1ieWYvblVXZS9hTEpFeDhG?=
 =?utf-8?B?Tk9oUDQvakhUS3Q3SDMzdGkyU0c2VXNoby9GZVYrRjJ0M1BzR041STdybUJC?=
 =?utf-8?B?YTU5UVJON2tsV3Q2ZDhmV1VOcEt2ZjR0bkY0eDFkUE51cHRBVUpya3hMVGVR?=
 =?utf-8?B?ZmFYMFJPMTdCa3BtcnNXUmtUVWhSUEVKY0hDSUVxTEozNU9RRmNJU0xaVjNw?=
 =?utf-8?B?WGF1R1RyWE5CTm1rbGxoMVd6clo4VUlaNnFzN0pqNjBFWUVoRkhHc2JPLzlw?=
 =?utf-8?B?ekRBWUlOUENaYng0NW9YOHlyTmt0UndPTmRFcVBnRkpURmh2d0dQUHJpckIr?=
 =?utf-8?B?SEhhRzhNVnJPY1l5bW9TM0s3eTRiZzJBMENjeEI0dXI0OHVGUXlqdFVjbVNW?=
 =?utf-8?B?V0FHbTFGTi9IekZaM2o3OWRBOFNxbU9oWS9VcXY1OWFFc2FCQ0NPaDE1T2ZG?=
 =?utf-8?B?aGwra1J3bUptcWUya2grRlJFS3JtUlU5SE1PakFicXphYnJKY0RjeDhYU1hz?=
 =?utf-8?B?YUhUMytMclVhcjRuNnVpNlliUzJZOWhFZ3BpcWtyTW5qWHRXRFZsM3Zkdmcw?=
 =?utf-8?B?NzdRU0xoMC9tM3JTNXRNRkxpUjRZTXZ2dFpmK2JLNjNQNTJOUFZJUDJvTnpD?=
 =?utf-8?B?T2pXUy9VQStDbTgwSDkvRlBmblBBUE1XUTBtUVpBMDh3NlhGcWQ5NG5zQm5p?=
 =?utf-8?B?OWFFa1FuMmxISTF2VzBYRVRPZDFPQnlxMVFraHpiK0kyTEZEbTlJR2tYU3NF?=
 =?utf-8?B?WVI4cllqL3BGRU4xclYxWXRqd0NTT2NxWlFnM1pDZVQwRUxRM2pVSE9BTmxm?=
 =?utf-8?B?RnN4SG5WQVYxWWQ0ajc1aXRPb1ZoUHlTNkVTUmtuNWZnL0MrUWhKOXJKZWky?=
 =?utf-8?B?cGhaNlUyaVp1bXJ5a1l3NWFvRTdXVitiYXhXdTl3RDMydm8rWUJuSkxKbXJD?=
 =?utf-8?B?b1kwT2pmMU1WUkMzR1VNY2NVVjA4dTEzME1BdFVwcE5jb0RvaXNNT2pnL1kw?=
 =?utf-8?B?YTl5bWduUGJ4YnJKZU9WVjNqaWdyZE03RWdNMnE0cWVkTVI1dDdmKy83Rk5j?=
 =?utf-8?B?cHlaRTAvTHdsaEMrR1JlcXFPWUJjaVJpKzNKbFcxOU5pc28wQ0ZVblJUVkIv?=
 =?utf-8?B?VzBGNHJ6MytmTzdZZ1RXa3FCR2E5QUViT2lDemlTa0NOMFZ2OURHdS9ycDdN?=
 =?utf-8?B?VncvSjNISmFldVl6aEdObkJDYkFVeWxCMUxjMnVEcWdET21MOHZqNndLYU5p?=
 =?utf-8?B?V0t3NEJxK28xTW5sb2JYNWNJQ0xsMlRuQVZLRmZlcmhqeUZJUU5XcGg1R0NV?=
 =?utf-8?B?MkhhczlLTGl4L2pCMkNPYmxqUlpaUHhNQlNFbHFOK1ZiMnpxcXpvc1dkQXAv?=
 =?utf-8?B?VmkvZmtqZTVzMmE2dXhXVnRGZTc2aExyYi9aTzJJNkxWdHdDeGNwbmZ5Z08y?=
 =?utf-8?B?alRvNENORklZdVNHU2RCQUc4ZGRSY293dGJDOUNyUzBzOVFVeXpXQUcyT1Js?=
 =?utf-8?B?Sy9GeWZ2bkFWL2hpTDZNUm5YdWNkUGYzMWtXeWI0aDRHcmtWTDBtWHVSWFc0?=
 =?utf-8?B?dnhkZHFreHdHRDVaazhVaFJJUGdzdFhWWFA3bWtqQ3lQU3RDUHRTRkthOGx4?=
 =?utf-8?B?RDhmWDZKVFBUK3Z1Q0plcUZVTWRiaVhVSkdWUEwreFowTmgyR250MVRsYUYy?=
 =?utf-8?B?OGUrS3hSMlRuUTJpRy9odkc4bWcycWFCMFhETCswbWZaY1FKL0o0KytaQTM1?=
 =?utf-8?B?UW00VHZUR1VEZTdLaVZRUmd5UFhnVWRHdDhmYnF4WkJqMVplVjdKTXB6SHhU?=
 =?utf-8?B?b3orUys2NExseUlsMUp1dG9yYnowOWtGQXVDM1h2UHl2bHN0aGExRWtHM3pP?=
 =?utf-8?B?ZXZlc3RxY3VNZzRJSUpnT1dxTGlOOHNEQkFINVhjYjdjaTNUMks4TS96UFlQ?=
 =?utf-8?Q?zA6mJs7khiJ8rWH3/d1e/VfyG?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fd2fac-48a8-4245-49cd-08dd9904513f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 07:43:18.0825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6hBfp/vyufwwwQHYYeJfYNPZiDF6RMTIQtvLhF0zkTUqyhfzQjbehJ7XJ8SPYun7D4pGI3pnqclq4TaI9vvAeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5228
X-Proofpoint-GUID: I0lAHTVpRzHnKpVttNbrGDk_a_sywylP
X-Proofpoint-ORIG-GUID: I0lAHTVpRzHnKpVttNbrGDk_a_sywylP
X-Authority-Analysis: v=2.4 cv=KJNaDEFo c=1 sm=1 tr=0 ts=682ed599 cx=c_pps a=joO5rFOndlhnht97C4Lqsw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=hYGOQRKA6NgTi-JG50oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA3NiBTYWx0ZWRfX83iL40JyvRpE 29/BlpnGOMl8wbLUbTls9X1cflso0s3pRxfyIK26ZPwOVsOPqPGfUV0uoRn6B5UAD/FjmsYCtVA H1p+MupkuoF/91h6ghsLmVbrBh9/UBVGjdfSwWc+dTZ4JjDMsWLxl22uFWyMXWVDuwoHCPoEjbd
 8jm3uW/PTB/ZBMja0ElX1v4QiZ3/08hRNb9+foWolsjDdq4txWCe/c1k62Q7nbITTGbos5orCFr Hbn3ER0Wk5nhKpRtfGCkCdVvOxJ/ddYzDETTEgdEGmCaSXTEEHRCG3tg155/tx4gRtR784Awt7g yuy6Gc3aRCLsmfi56F+gMxmgJJ3DmO9FrGViE3fw65+2G5/745BVVvqcvUd5SoZvkfGQft0Uzpm
 zqLIBPBhRCVPNQrFBKyvldl0Fyy6WN/tJQF13nsr8H1InfLo4tmFnVRhfuvkcxeF8AOQ5SPt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1011 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505160000
 definitions=main-2505220076



On 2025/5/20 19:25, Greg KH wrote:
> On Fri, May 09, 2025 at 02:14:15PM +0800, Feng Liu wrote:
>> From: Alexey Dobriyan <adobriyan@gmail.com>
>>
>> [ Upstream commit 2a97388a807b6ab5538aa8f8537b2463c6988bd2 ]
>>
>> ELF loader uses "randomize_va_space" twice. It is sysctl and can change
>> at any moment, so 2 loads could see 2 different values in theory with
>> unpredictable consequences.
>>
>> Issue exactly one load for consistent value across one exec.
>>
>> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
>> Link: https://lore.kernel.org/r/3329905c-7eb8-400a-8f0a-d87cff979b5b@p183
>> Signed-off-by: Kees Cook <kees@kernel.org>
>> Signed-off-by: Feng Liu <Feng.Liu3@windriver.com>
>> Signed-off-by: He Zhe <Zhe.He@windriver.com>
>> ---
>> Verified the build test.
> No you did not!  This breaks the build.
>
> This is really really annoying as it breaks the workflow on our side
> when you submit code that does not work at all.
>
> Please go and retest all of the outstanding commits that you all have
> submitted and fix them up and resend them.  I'm dropping all of the rest
> of them from my pending queue as this shows a total lack of testing
> happening which implies that I can't trust any of these at all.
>
> And I want you all to prove that you have actually tested the code, not
> just this bland "Verified the build test" which is a _very_ low bar,
> that is not even happening here at all :(

Sorry for any inconvenience.

We did do some build test on Ubuntu22.04 with the default GCC 11.4.0 and
defconfig on an x86_64 machine against the latest linux-stable before sending
the patch out. And we just redid the build test and caught below warning that
we missed before:

../fs/binfmt_elf.c: In function ‘load_elf_binary’:
../fs/binfmt_elf.c:1011:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
 1011 |         const int snapshot_randomize_va_space = READ_ONCE(randomize_va_space);
      |   

Just to be clear, is this the issue that breaks the build from your side?

We just used the default config and didn't manually enable -WERROR which is
disabled by default for 5.10 and 5.15. After searching around we feel that
we should have enabled it as suggested by
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b9080ba4a6ec56447f263082825a4fddb873316b
even for 5.10 and 5.15, so that such case wouldn't go unnoticed.

And as you mentioned in another thread, we will definitely enlarge the test
coverage and provide more details, for example:

Machine: x86_64
OS: Ubuntu24.04, Ubuntu22.04, ...
GCC: 11.04, ...
Tree: https://web.git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/,
Branch: linux-6.12.y, ...
Commands: make allyesconfig, make bzImage, ...

for the first step and then introduce some automation and provide public link
containing more details.


Thanks,
Zhe

>
> greg k-h


