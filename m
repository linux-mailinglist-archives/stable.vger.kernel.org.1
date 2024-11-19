Return-Path: <stable+bounces-93944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1049D21F4
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 09:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0839C281E77
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 08:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCCD198A25;
	Tue, 19 Nov 2024 08:57:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217AE1798C
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732006638; cv=fail; b=nn8Af03biPdgkD2TOqBtz8TptxGWcv7y3bDW9kF/5yIxLxNtjGYcq6FKZEVfoY7Xq+iRsK4iSB+X064RwgdrMylu8bthUFj9fIkQMhMuDy6hl2qfcQUTdPSZKWTQngoGyQmK+ARSQXDx9N/eXQA5bqvgc+k5URSvGPVq+EYWNUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732006638; c=relaxed/simple;
	bh=XjyjfLv2klHrt8Yk8cqjjeVJxr1S2AvPjtoPM856sno=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H88Y4rC0HcS9hZuw30VQBWK1jqhzQKgvxwDszj4xuTVlJKymXTtCAUbrwFdfXQ9iZtkJFjQONgjbVM/fMLlcP4DQLPFlLNSN+uGAi8BDE44xmjicpXCMRwPxLdxz+uxDJowretL9TC70F4v+vX1sj5lkx+p85uL6MnXxPij3utY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ7o1B2027683;
	Tue, 19 Nov 2024 00:56:59 -0800
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42xqj7tnsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 00:56:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nc9LKL5Y4oepxmm76U25DGFjHO2zPDCfVPg2nNy89Cchn5slx9l61AvAvzNzUMbNUAXxXYR0YgszvFPCqCoNCr0wPQp6BMzeboz9h4VtQKWzikyrynvh8i9Qd6xfJ88MxwMdBAwY3yzNBcXYwhcrcGdIjJGIsnLiUKDp04u9/Hdp0b/j/1Sw8HvZWyQxLWsGYA2tL/5jmmPDjnWCZSiaZVTTuPLU0omEAHZGLFhdRUthu5zR9QYajULdzHq7SZlIVZf9MVsLRO/OEAyeGu9F/UPZx1dp7u8Dw1b4gEaWcBYgpKcM1Ri4tq9nwO0zwXiGjrV9Bp1/rPH2D4cm08HTLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SvJkydq+I1uezOUTzc/Tucz4urSkXlHz9Ac0m12QAk=;
 b=H0VU2P856RAhbOI9fWkfYQTjMEm7Q0gv98HStnNGAbVAbh6QqFCO8OmMB7pri9eHoXe2JU/uMjMT2i4r57LU5haSVwKTsNS6Dgpyn5wSvvsKBAsAQD80L2+rNZsQCzVXp0laD8MYQ5abOYg3cy78vyB2qK2Tfmv4Q4cpe3Vs11F+kOXTp0LS0mGS5c+Oncyl4c8ldJkl6GFMZdHi0lji13X5Q5L0JOu9wDyoohM4AVCjdIdHRsc81rUC5is7XmvK9GkzLM96Fou3XRjTwLtS1dvTlk1mxnAmhCAqFSIO2PoecPw6NqEGgkmsaEkSXPcr+Ea7NFrDeEMQBoHkIEJOSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by DM4PR11MB6357.namprd11.prod.outlook.com (2603:10b6:8:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 08:56:55 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 08:56:54 +0000
Message-ID: <9041814d-7274-477e-b511-dbcf6f830995@eng.windriver.com>
Date: Tue, 19 Nov 2024 16:56:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y 0/2] Backport to fix CVE-2024-36478
To: Yu Kuai <yukuai1@huaweicloud.com>, christophe.jaillet@wanadoo.fr
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20241119082719.4034054-1-xiangyu.chen@eng.windriver.com>
 <6250e1f3-cdc7-b172-e9c2-4ac82db9c21f@huaweicloud.com>
Content-Language: en-US
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
In-Reply-To: <6250e1f3-cdc7-b172-e9c2-4ac82db9c21f@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0227.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::23) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|DM4PR11MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: 876ae4ad-d3f1-4e08-89f2-08dd08781dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVFnUjdpcUdXaExCdHZISXNCeFNYZktHSTBEb0xwTkFaZkJqSnc4MzdLbGIw?=
 =?utf-8?B?OENEbWhvUS9aUHppdUhnUlBYb1FpZFZnOWlrMWVGWUtNYW4rUGxOMkc1di9k?=
 =?utf-8?B?dVpNMXkvcFV2ZFVILy9UMnJ5UGhBOFBnRnJQRVpRZjhDRFUxbDFiSU5DbnRq?=
 =?utf-8?B?YnAvdUh4aklxaEtna2dLN3dnemRicHdrQUd6SHZvaUxzaEpUT2ZiTXhHTlhG?=
 =?utf-8?B?cjFDS0lLekxQTk9XbTUwaWtpUkI1b3J6NEozYU0wcERLamFFVFhBUisyTWpk?=
 =?utf-8?B?dnVSTElkNEN2NU5KWkJxZW5qVEZRbXZyYkpia21RQlZOL0JBbXBUWXdObG05?=
 =?utf-8?B?UUZ6T3dvWGtyRWpBT2dqM04rQ0NSOC9heS9iMjBMY2VxZVgwaVlScElQTmNB?=
 =?utf-8?B?Qmp2Wm55aEFJRU1GRitWTVIrUkhObkx3c1U3ZjVSa3JJQmNQR3NFMGhSWjh2?=
 =?utf-8?B?MnBmQklEb29jN1dUaUV0THNNM0R3Qll6MzdqclpuRGZTZXdPY0s1VDZ1K3li?=
 =?utf-8?B?Tm02d3ptSE4rWmo5V0gycEhMd0FjNVhzcVcyWlN5RnRabWF6NStrNTNJVFNS?=
 =?utf-8?B?VmFRdUtxbGkwa0N1MmFJWW5jKzdMZzA4MGVxNngwd2NYQ3krb1Q2UVlYbXZo?=
 =?utf-8?B?dW04TW9DQmtTbStwSTZzZEEyV05QaHAreFRWb0hXNDNUUFN1TEE1UFFaUG8z?=
 =?utf-8?B?K1puM0p5S0RiRzVDM1Q3bzNoQlVadkZ1MVZUYmswTEVNRi9NT2lYQjJMV3JK?=
 =?utf-8?B?YS9vL3MvUVFia0Y5V2RkWHZSeE1NZGI4TE1Sc2plTnpzR0tJM3pUNEtJaGxu?=
 =?utf-8?B?ZnRrVkNoVktnaG1sVS9zYm5tZnp2eXFRa1RMelUxQytiWlMzRUlRN0dKMElQ?=
 =?utf-8?B?cU5QYXZENEozOEdVNzh4dGxjUEZ0NUQvdEx0TnVvdVpYeThCVFB1NUdoSU13?=
 =?utf-8?B?alZjQ25iNzhUUlpUQ21yTlRGTjRRZlhBK1ZNblBsVWRLeUdoY2tMWjY5a1dY?=
 =?utf-8?B?R3RPRVd5YXpUUmI1R20xNFlGTm1JVnhZMVNRZkRIY1JCd3N5Y0hwcWJOWUUx?=
 =?utf-8?B?Vk1JYzNTVzdwQjJudWdzQUNCaklSemNZV0pBeDd0UDd6aHFWcVRNRzRvTkFG?=
 =?utf-8?B?emtLRmRMODl5akpFNUEyVUNVYnJ3T2JaMEpnQ1NsRStkQjcvbXc4YUR4TmZE?=
 =?utf-8?B?dUJMUDl5cVJQZ21jMHAyUE96UEpQNmEzeGV3TGNwR0JKckFOOHk3WVlZMUx1?=
 =?utf-8?B?VGgraUt5NzVXNlZMZmhuTnhSbFhoMU1mUkxtNGpqMjhJcmdqcFVXaytOdjJa?=
 =?utf-8?B?UGZZZ3JZaDJwWnp5K0tHTGVOQUpvRVlBWTVhN3J1UENiWTE5bjIyVVFJWGwx?=
 =?utf-8?B?NUZTTjZhNmFaZCtMc0lobzMwWFRvZ0hWRmU4cmFqNkUvOVFrN1FjU0RJeDVa?=
 =?utf-8?B?TXkzcEVrdXFrdTA2aytUYVF0dlJoUlgrdElYblIyZ2tkRjA0UDhCYTM3WU9X?=
 =?utf-8?B?OTBaYXFlRCtjVldiQm9RWnJBRURhVGFJNWF5QVVyZDNaTUtFaVJGNjlNYmxE?=
 =?utf-8?B?QWRqV0UxOUhOWElDSW9ETE5ta20zNlo2R1FPTE5wUU9lL1hKMEI2ZEdtYXFQ?=
 =?utf-8?B?TUg1ZHpMNThOZ3pwM0lCY2pZdjY1dXRFQlpCMUNLUGdrSXFDTXBsdlExeTNU?=
 =?utf-8?B?NUVLdDRyUG5qQ3Y5WS9DRm9SNWNoN0dTQjBxbFdNL3JsMkplK01vbGUvK0d4?=
 =?utf-8?Q?fCrgy/eqJNU55nBc4ELNJH7pwVsu0mg29wqboMv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3UvdzBBSmFrYkJMNDQyajU2dHJta2tha1RWaDdPQlF4VHA4bWFBb2pkRWNT?=
 =?utf-8?B?WmRyR2dNRlZWRHlqdlJINDZsT21kUVB6cVdkY0pMRk1zQTBwbW9nME8wS3JX?=
 =?utf-8?B?TUhsWHpreWZzVDF3QTA4Q1BCUWp6VVZCTU9VbTJobC96TndkTFNzbmFEV2Ur?=
 =?utf-8?B?MU4wTDF4OTQvaHBkbFhmWHA2V1lYRmdXdjRQZzgxVmVMRGV6TzBYVWZXbFdD?=
 =?utf-8?B?bTg3M0d3WHM0KzlYRWMxdlA2dTJsNVErVUxVRE8vOU56YjVJMXMvVDZzaEs4?=
 =?utf-8?B?TzRkOVlpU2ZZVWk2R0NTTVdSeUNqdy9YSDZPZ1BIU2x2S1RmbThRdUcyeWNX?=
 =?utf-8?B?KzlGaU1TR085SDFSL3BiN0NyZ0VJaHVwYXhlNzhVSmxueW9PQ1pKeUV3MGwr?=
 =?utf-8?B?S0lPN3hxRlo4b1pxYlk5WWkreWxrTHJXMURCV2ZUbUg5cS93ZkVSeWMwcmJi?=
 =?utf-8?B?dzl4ZUQ0Y1Z4aXgxeWxINDd0UUs1WERicTY5ODBMVTNzb0NwQUdDbnpQOGRS?=
 =?utf-8?B?Zkg0OGsvR24zRTNranYzZUtpSEpEY1QxYnNpVjhPcGh6YUhENUZkQVJJTHJr?=
 =?utf-8?B?bVYyUHN4Y0VuaGlCZEY3OXpNTkNWdDNXSUZISHNFd1llRGlqWWM2aDhxd2Nm?=
 =?utf-8?B?N2RjTjRPbDV5bnVXV29PQ3RhWlZJZmJtYVVQZUJsUSs1V2ZyeWFoY3JRN2lx?=
 =?utf-8?B?bEU4aHpOSVlDa1ROQUZvL2ZGUXhwZTNVWjlwTzhSc0dQZmNmTnRsVlNxb3ZC?=
 =?utf-8?B?V1lsSXFCQ0VTOE9lV21JamJVVlFqVjFqcXRnL1JpdEFiZ2laOEhkZDBhVlRo?=
 =?utf-8?B?UUVFK1JLU0Q4amRiREhUb3hZWTV3clBYckw4QmNhTXNOSURKRUpHdmFZWVFs?=
 =?utf-8?B?a1pCU2E0Z3k3VkxMMlp6LzVLUmt5MEx3eGczU1ZRRlBPaWhOMys0VEhSSzgy?=
 =?utf-8?B?aURSRGxjOWE4aGdZY2J6UFF3Y3hIaXJMTVFWS2V4cCt1bEhXNE1hZUZBOFBh?=
 =?utf-8?B?NHE0MG9Vb3c3U2dZODFpWHVKcWdIMzdiMk9oMUlvM2RBTkdTN1UrQjVpeXpi?=
 =?utf-8?B?Wk53ejBOUVp3RTVSRGxCNTRra1BnMWFEcU9NbWlMUFQ5MEtLWmEralNmTEdM?=
 =?utf-8?B?bTgraUpQdDhxL0M3dXhXMFcxZmVkZjQ2Rjd5Rk5Lc3l5VHlOY2gwenZvRHc1?=
 =?utf-8?B?c3IyU2ZncCswdFNHKy9VdXZSSlpvMHF1M1BzSzJHZ09YNjFHQzBDTE9XUXhk?=
 =?utf-8?B?cWZkS2UyUUt4TmppbXBZM244Q1dNU0dELzFjRmZqWXBvM3hIZkFNZmk0WWZL?=
 =?utf-8?B?Y3RYdWFUVXBIUWJFWFc0cW10d2FMdzhzd2R1UnluR0cwMUhMREMxaG5hSm1p?=
 =?utf-8?B?ak81aGdab1VXM1VENWh2cjJVSUFLREhzc2o1YituaS9Dc3FmSWtCT3RJanAz?=
 =?utf-8?B?MDlCanNDS1pzYzd1ZkNpNmpUVStwb2ZjUmtYRnF1eFZxRzE0RDV5L1dPaW1q?=
 =?utf-8?B?RVBQMERTL0EzMERJUkw5aFY5Uk5idDVxbHVUL1M4Q0xnUitJdC9BclljSktI?=
 =?utf-8?B?eUJFb0pmSEpQakE4bXhWdEdIaW44aGxCZGR5cFJZRnQwNkI1MC9RSEd0UnI4?=
 =?utf-8?B?T1Z1VUdaZ2xjUXBvK1BwRzRPU1cxUHo2b2tvWXFSTVV3S3Y4QVR1M1dJYytr?=
 =?utf-8?B?NVh0WTZFMVVtQmFSdERZN1hvRXBFV1lQcmJOUVRVQ0pZUjlKRHVoZkNSdFpp?=
 =?utf-8?B?aG9PSkNtNk55QzEzTVhBQVdiOERGbDVLZGZ0Tk00S1E5SjJIRERwbzQvdzQw?=
 =?utf-8?B?WjJsQm81VmNNRG12R2RHaGZUR3RDcTlrckxORFlneTYyb3dnaUpmMlNlNERM?=
 =?utf-8?B?bEZIWW1DZmpHK2tHanpRUXUvTXRZeXJaMHFkT3ZmTk1rNEpWb25EblkvNnRM?=
 =?utf-8?B?OG0wbWhsMUVKVTBLWE9DanJyaFJBMXcxWWVwK3VPeDczbWVnRGV1c2Z0WFN6?=
 =?utf-8?B?SnJYVG1yVFRPSWNrdzNTNzlLaUtCV1dEYisyMyt1MDRPS2k5TnFteGxiTDhI?=
 =?utf-8?B?aDBIQ2R6Z3JLV29scWt0N2E0WVZPTVpiRStaNnVUbEdvNXgrZlkwdU50VmVv?=
 =?utf-8?B?UFU1TWd1a3kxL3RMR1g3cjBUK054RkVmd0p2Tjg4NHJoRWFydS9rbVdGRnRC?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876ae4ad-d3f1-4e08-89f2-08dd08781dd8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 08:56:54.8420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7LpgmCYcQaELJ0QDMq24EhNOCwnwH7j1USDv4dHO9bcCnJkDBoVaIYfgUw8j6Ssv13Nza+7y2FtnVCam7PSdEjzDorNvFXDdHe5Lbgv7P0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6357
X-Proofpoint-ORIG-GUID: dp5PY9ZY55pBzrhTLaDSaWFbLnFSPFsd
X-Proofpoint-GUID: dp5PY9ZY55pBzrhTLaDSaWFbLnFSPFsd
X-Authority-Analysis: v=2.4 cv=Sb6ldeRu c=1 sm=1 tr=0 ts=673c52da cx=c_pps a=7Qu+2NBwJcyibZ5HEcOKcA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10
 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=5Ks7_4hvhtdJzPKNmEcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_01,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411190063

Hi,

On 11/19/24 16:35, Yu Kuai wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender 
> and know the content is safe.
>
> Hi,
>
> 在 2024/11/19 16:27, Xiangyu Chen 写道:
>> From: Xiangyu Chen <xiangyu.chen@windriver.com>
>>
>> Backport to fix CVE-2024-36478
>>
>> https://lore.kernel.org/linux-cve-announce/2024062136-CVE-2024-36478-d249@gregkh/ 
>>
>>
>> The CVE fix is "null_blk: fix null-ptr-dereference while configuring 
>> 'power'
>> and 'submit_queues'"
>>
>> This required 1 extra commit to make sure the picks are clean:
>> null_blk: Remove usage of the deprecated ida_simple_xx() API
>>
>>
>> Christophe JAILLET (1):
>>    null_blk: Remove usage of the deprecated ida_simple_xx() API
>>
>> Yu Kuai (1):
>>    null_blk: fix null-ptr-dereference while configuring 'power' and
>>      'submit_queues'
>
> Thanks for backporing the patch, there is a follow up patch you should
> pick together:
>
> https://lore.kernel.org/all/20240527043445.235267-1-dlemoal@kernel.org/
>
Thanks for your info, I'll submit a V2 patch later.


Br,

Xiangyu

> Thanks,
> Kuai
>
>>
>>   drivers/block/null_blk/main.c | 44 ++++++++++++++++++++++-------------
>>   1 file changed, 28 insertions(+), 16 deletions(-)
>>
>

