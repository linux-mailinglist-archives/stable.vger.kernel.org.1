Return-Path: <stable+bounces-105179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E522D9F6AF3
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 17:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D200C18977BB
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 16:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65931F471A;
	Wed, 18 Dec 2024 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XLxeGA7T"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF79513D8A3;
	Wed, 18 Dec 2024 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734538880; cv=fail; b=o0PhxOqz/8cbSyoqz+zXfa9PxfY9kNc1Ay+KHYZFGzu6KwDFUs9p1jjm0Af6TS4fDvTe1DP5P1QDc8G9dutwrdgY8G2UITrvbSfzzZfbCwn9O8FReAxgXl9vIGW9Ml+TJuNXNNXzf3cazupNkQQCh8NaFyR9eETqjZUtIaVBupI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734538880; c=relaxed/simple;
	bh=8QBiC41omjl2nvJbKTpvDUx/21njzUqZfTlcJgznjbA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o40GaC/8GV9j8825zkW0bXHu0bok89qhHnZw9bgeamQDzyWCoZEYqIFQ+bU3xccjYw89PYXew9SJKCLScMBslier20wqt30AnYsqHdtrITDK98LgQypkyzKetbzNld+t6FySNmBCEICnLEoO0fPXSjPYoINVCd33BrOD5sES+6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XLxeGA7T; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O45zxvyc71tP3y9H7GHSS1N//e10mR/BJ5TAI4BsNt6oHup+hW8hf14J0YCuexgeAEL6b9UdhGfYaradXpVWIYK7UWI6nTfH2W2z559VOa1n1g97FFABor6wFMuieWXEKiMAv9fywLWEFBAuQrbarlg28MQo3661xTF5rbDJ6mQFcaMIPTNe15uImy7kXBd50+lSLNj0BZhXspyDqvGlDxCIpVCnw40Gx4/8gp05DJ8AorEFmzskluKgmUwJN5+OHrgQ5m5qhDp2X5aHkBTQ8sTGhw9RJWlPHAPaAkEJSp2xhckC39PYPmOImNTmZct3f9+oYGVy5qrL+Jja94zovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyWQ26s0m8W8oEKuH/2wiylg6YgR99pyQMV+3lwUAtk=;
 b=ku6jAuYHuZ7nYu5LBBRk9yhceozmAj9WVsU+CPvn2U7F55Kxtg38sWPCXj7jt2+WKR8qK7Na20IEhuY0PLSfGPm410oizcjDSJWbk582CgK9lv5UEAgVaRqfTv5EQs0+LTaG2BK0a5mEi/hj6m8s94H6YAvyobmlkxguqHYT+abA48xBEVigRF+dmPxye7BY4saosPO8n0W1IYxrC1GqBvL0SP353PPtgr2HDZ7tFyaJsbvr9UNR8sAJOwPjzRCNREvgVT6aSiaztFcFqx8jp7/pJsMOvnM8bYb4+SpDyqlAAk1cqGGg3pyrUcJMYt5sHOz2Tnx/Zc5ppCXGRB3mMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyWQ26s0m8W8oEKuH/2wiylg6YgR99pyQMV+3lwUAtk=;
 b=XLxeGA7Tlz5S9D4Nlr4NTtsnd2owPMNzDBeTHTR4CkHW78DtWL5KSkVDTYxTh5wHEdfnmPN2Q4PnkilO0F6quodZE8qHn4JARotxq3vjqniBTlwQ0NeIuUTP3ea6F/yBbkyuoy1XMK3yWsJvMAKKTlFKfeO7VtcQA5s1yZV65i2QkJvPSlUfaOqFNpae06ekpANaCyduhmGFZkdvJb2VJZCnsSLvEhkpVeGlqSS7LEq9y+/DIEmZOgrcyL1ipOtzYxTk6LBVE2gLjNvxeXHA0sIlWKpagKMjHLJIo3N32yonEB8Rhes8vBYCs9HybKpZ+cQ2QPpy+bWWvffbMfT2GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SJ0PR12MB8116.namprd12.prod.outlook.com (2603:10b6:a03:4ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 16:21:13 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 16:21:13 +0000
Message-ID: <dd77fa22-fde8-48c7-8ef4-6e2dc700ef0c@nvidia.com>
Date: Wed, 18 Dec 2024 16:21:05 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] USB: core: Disable LPM only for non-suspended ports
To: Kai-Heng Feng <kaihengf@nvidia.com>, gregkh@linuxfoundation.org
Cc: stern@rowland.harvard.edu, mathias.nyman@linux.intel.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Wayne Chang <waynec@nvidia.com>, stable@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20241206074817.89189-1-kaihengf@nvidia.com>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20241206074817.89189-1-kaihengf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0533.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::18) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SJ0PR12MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 84840a4b-f6a8-4681-086e-08dd1f7ffd4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkVZbjIyMzJvQkhETUtuN2s3cmlxWm41T3Z5RGhIeVpRdEJzd0ZKM1JPUXVL?=
 =?utf-8?B?MFpkNlE1Nm5hTHJEcmloUWxFWng4cFB3cEE0eVdZUmJzUUEwQjlkQ0Z2Mm50?=
 =?utf-8?B?VTlUcHNqeS9ZYXJBcWFjdWdMVi95a2JzQlRSYUhjZGRjVFM1b0RQZEZPdUUw?=
 =?utf-8?B?Rmx5TEcveUpmMkxacGRPUzhlRE9VTDB5TWJubVY2WFJhVFVISEV6Tzk5OGly?=
 =?utf-8?B?MFcxdVRxMnM2dmk0cDhGVWx4MVUrUW8wNHU1a3BnYmtCb1dYY29XeW0vaTVl?=
 =?utf-8?B?S0o3TG8wNlVqaGtPTnVSN0xpeGNudC9jUWFBZ0NIL3NHVDNaQXYrQWNwYUV5?=
 =?utf-8?B?SDVoM1N5TEVhb3M2a0F4a0VZbDJPNFBxNm1JQWorTGk3b1NaS2taUEZJZDhq?=
 =?utf-8?B?N1ZhT1dBL3lkQlUrc1pvUC9FSkc2QmtRSHZKMTdFb01OdEh1YjhZN0F1NzhC?=
 =?utf-8?B?K3dLdWFnOUxHMFU0YWp4ZWo2cVYvR1IxM2c4dkVLcnFHMjFZSmNhcS9LVmVY?=
 =?utf-8?B?Y0lNaDUxM3QyMXJlenRuempCaThyVGx6MGlyVkkyTXVOMGRUMmdZTXNMdk0x?=
 =?utf-8?B?RndqWDdsV29lVmViNVM4ZzIyZkZGWDZpZm4rMW9DTWxmNG01cThIVy83V0kz?=
 =?utf-8?B?eVhSUUlxcGdsT3hlSHl6c1RLRGgxelduWEJqZkJwQzJOTXQzMkdLZEV1dFkx?=
 =?utf-8?B?cXR0OENraEVXd2NZd2o0UWhiYzY5UU1lR1c3d3BBcmRpZGdSKytWNDNMSmlx?=
 =?utf-8?B?S0RqeXp5OXByNHFBeFFMZnZIOEg1MFppd0RWTXV1UEVBc0kyVW8yeFgvZjhB?=
 =?utf-8?B?dDltakQvb2lOMW9EeEpSYkVGbzMydG9xc01hU2UwMW5BZDRzb0YvV09zM2tT?=
 =?utf-8?B?K1RKS3RDWUtkeCt3Ri9pVFY4S3NrNDdGTFZ1bGVxcXFHY1pOUDdVQVgzYXJm?=
 =?utf-8?B?cVcvSXlBR1dML0ZUd093L1YrZUdsdEw5NUg1MlF5Vml0aVJoZTRLY1hCeEpO?=
 =?utf-8?B?cTBoaG5QdXlxQkc0YUcremZqYzY2d0RhZ2ZncTV4Qy9nV0kycmpDcTFmSG9s?=
 =?utf-8?B?QzFEVWVnWXl2RE51RUl2Q2t0SWxCbkJtZ3ZNbVhYUFpHSzBpVTI1K2pIQ2lm?=
 =?utf-8?B?UHpnTmFDN2s1TzRnUSt3NEhWcHpFWUM1b0lHdllOTU0xSXJYVVRHay9QU2Rv?=
 =?utf-8?B?TFBxdnVzRVRLdWx6TEVRYXNBWWgvZ2pkV2NSVnVjNVZiOUNaOEl5MUZ0SmZB?=
 =?utf-8?B?OFhWcmNQYlM5Sm9NWGpPYThhSlF4Vzk3aWd6WWtLZHZqK2M0TUtXdkd6Ri9n?=
 =?utf-8?B?aDVEdFpldFVKcFByWEFSZVBYMHg3M1ZEcjlwT0xIL05uU0w1T2xXN0FvK2Y4?=
 =?utf-8?B?c1c2VTFUQ3hNQ2t0N3gvKzhzN3U0dzVXYjZGem1Ec3lFcEZJWmh0TEFLcytL?=
 =?utf-8?B?K0gvUlBLdElqdUxjS3pUR0xyV24zZzducDBMSjZLUU9lenU1Z0hIUDJvQjdh?=
 =?utf-8?B?VHBlTDU1N3pSK2xNRDFYSWFOYndSaG5UNGZiWjJabTJib055RzR2dmtiSFZ5?=
 =?utf-8?B?Z3FHeHBsekFkdzlMMzRRZzF2Q1ZhUGlpdFJmVmczSnR4M2xzcjdsN0ZHb2tW?=
 =?utf-8?B?WEhmWk5FVkxGS0FLZjNYa2FwU3pNMnl3ejVhYWxUT2l4azBhQytzckFtRmxv?=
 =?utf-8?B?RjMvSUFYdEh0c3dUMEg0emVYWVk0NjcwRkYzUldCYzBhSmtRYVVQbnNtU3FL?=
 =?utf-8?B?bHNRVXE3VnRlclduaE9SNFJudm5SdnYvY00vb00vK0d3cDR6YzJjT2VRT3Fq?=
 =?utf-8?B?OGw2MXY0TG1ERUxOYysrQjEzUjB6L3ZhZG9weTd5SDltU3VrZjUwOE9xRHJu?=
 =?utf-8?Q?/4tOzR4a2olMz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHJ2SHlhOTNqQ3UvN0RxQjhhL1lBMXRIcHJKV1Q4Y0YxMHhyVDRWcWF3WEdJ?=
 =?utf-8?B?VzJ5eGtkVDI3ZmVrZmczTHo5WDFSSzErY0Ruc0ZIQjFuZDdJYW9aSENRTDdq?=
 =?utf-8?B?clNOenZwa2JmSnB1OVViZVBnUnhKV0szU0xSYnRxeG10ck02dnkxMXFyNWNN?=
 =?utf-8?B?ZVNLNVFyOWZ4TkZLYytpcWRxSGxKc284NDNtblFWeG5mWnRNWmVSSUhRT2hD?=
 =?utf-8?B?MmNTWHdHVEtFcFU1bUI3NUgxbmJuSStqVjdYOEpzZzVacTRCWEJKVVFxejRh?=
 =?utf-8?B?ZHZObTlMMC8yMjBvQlZ0K1RGbHVDNXhQWTlZb0Zrd2Y4UWZib3FOSU9RcC9P?=
 =?utf-8?B?T0FmY3diUUMxam55SDBnRlc4RVJRMERoNHNxa0VUVm5xK0FkcGdXbFVwcjNz?=
 =?utf-8?B?OFpwQzBPb3NYMmRndzF4N29Tekc1YzNuN25WRHVMbGJuekZKOW5rdUpNdm5J?=
 =?utf-8?B?emdmWDRJZ3FnNkorWlgxSmZvM2FYS2g1S1BsdkFRVXZaQzZlUVVrem9KMG1S?=
 =?utf-8?B?ZjJISnBtZDE5SlRwdDBIajJPNjJib0kyMDRJQVdLai9QK0F0MUxqRStJTXhH?=
 =?utf-8?B?RksrbkZ1UnhidUw2UFNRM3RTQXV2MFp3QXAwWXVpd0w3S0xyT1RsNW1rMys3?=
 =?utf-8?B?ZWJtcnRLamx3YkNpS2l5d1FQbUJ5ek5tczBVbTlJcXRlbzQyc280elRxWno0?=
 =?utf-8?B?bzd3TGpsTXlRN0F1cjV2b0s2STM1ZTBkMUJJUHd1U3V3cXovdmY0Wjd0M3Zu?=
 =?utf-8?B?ZXY0bGhVLzJSclFSUkx3N1VBRUhOYlhjNEZWMkJvTE9IejJOYlMySmpCYWMz?=
 =?utf-8?B?aVpHMTAzTCtvTDAxSEI0K2lPSzRFYWV4TUlhOWxnTW9hNjltWDRXWnBMY3hX?=
 =?utf-8?B?UzE0dVd2SEM0d1hkRmRaUVltYng4NDl4V0ljS214VjlJclVlOHJQQ3lncjZI?=
 =?utf-8?B?WDJjZkszaGt1YnNQcEZWSW5YNDExR054dVNkaUF5anVaVmR1Z3JGdFZtaXJz?=
 =?utf-8?B?bVJJSzVVb2M4aWlmOUgzWGM1ZHVUZnJBdTQ0Y1FkK1N6N04rK0xFVmNpMWhP?=
 =?utf-8?B?R0RRZktGQ2ZBUGY1RlNtMEs1QTN1Y01ZS3Y4R3JSQjR6L2pnRkxNaithblNU?=
 =?utf-8?B?SWtaK0JQV3N3Q3hXNnN5YlBZS0JNc2x4RlFaT0VVNEpYZE1DSndmbGt4L1k1?=
 =?utf-8?B?Y2FGd1ZhenA2Q2JqYS9UdUJkNFFabFpGcVZOclBSUGY4TTdYaDZRZE1ZL1hI?=
 =?utf-8?B?UkxFL3RMUWp2RHVwS2xKa3lTWUVKekFhVFZSeFl6Q2IwQUttbzlQK3lvd3pZ?=
 =?utf-8?B?Z1A5eTJCc3pyZTZPazVXMDBsVSszQ2FVV0tlaGx3a0J4ek5RZmNMUWFZM3lN?=
 =?utf-8?B?UnRoNlR0RzBsYXhEOW92UEJ6VkUwMnhyWnNXMVVaWVFCaC9BcTNNV2VVUE0y?=
 =?utf-8?B?aGZtc212SVMycURQeEtKbUVCbTJBb2p0NEIvVTRGMzBhOFhoUlBxVi9EQkdU?=
 =?utf-8?B?aWpXZDZyd2dUS0dBeENBUzY0bFRZTk1URTlmTC9sanFRNndVL210bllxVnZs?=
 =?utf-8?B?WTdqNDcxYmVIUk4vYmNFd2JGREZVc0Y4NXBxNVN4TWEwSmlYUEF5SXhIczBi?=
 =?utf-8?B?dlR2SFFZQ0F2bUVmL1VFclRpNXVKS1dtWU9adDhtRWY5M3pHUjRObWlreUU3?=
 =?utf-8?B?V0JKNlpaK0ZYN1krSmJvOFp0TU11cGQyWHNsd2E1WEp6ajZQdjFuTTNmRkp2?=
 =?utf-8?B?cjllNS85YVI4T1l3SjhJVFkzSmxLcWxkN0E2Vy9VSkoyT1c5eHJxeVBiVVdj?=
 =?utf-8?B?YVJadjhqWE5rY21aY3ZxNXhMSWNSQ1pNdU81THUwbjI2Qk5IQ0FRTGsyQjY3?=
 =?utf-8?B?NkdxRFVBRzNWMmFxVjJ3NkM0cFVZaW1rQWN0WjI0Q2tlRnorQmhVUktXdVpx?=
 =?utf-8?B?UTMra0kyazBtK0w2R250U2xDM2hxQXp1NHpqREZQNlJuVStheng0UEtwUXJn?=
 =?utf-8?B?Wk9PL3VxLzhiUFVSVUZsa1pDb0NVZzJiRHp1VUhoNlpVejd6MkgyTm5XWUo0?=
 =?utf-8?B?dTd2ZkhhNDRMTTladktQSk81MERBSzNOYkRxRUh2cjhnN2RseHRRYW9aQWxv?=
 =?utf-8?B?QWJFN2l5bkJ0NlRpcDhWRkFMZjhLVEx0WW9HamlvckVldkpkb2l2VWFuWXpU?=
 =?utf-8?B?UzlTcXpTTG1SYTU1U1hKK0RKc3ZhS2ZESHJmNnZMbk9KZjR4Ujdpa25hdlBw?=
 =?utf-8?B?YWthdy9GSTMzczlBZCt4NG50OFNRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84840a4b-f6a8-4681-086e-08dd1f7ffd4e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 16:21:13.0611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6FrWXwaw+wRTMINmGwNDfHcDv5dc5RxLTVO9PRT3m1EWU8hd0HaJkzI5YmLLW5uBfqtBTChOg1LisfB5DFjzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8116


On 06/12/2024 07:48, Kai-Heng Feng wrote:
> There's USB error when tegra board is shutting down:
> [  180.919315] usb 2-3: Failed to set U1 timeout to 0x0,error code -113
> [  180.919995] usb 2-3: Failed to set U1 timeout to 0xa,error code -113
> [  180.920512] usb 2-3: Failed to set U2 timeout to 0x4,error code -113
> [  186.157172] tegra-xusb 3610000.usb: xHCI host controller not responding, assume dead
> [  186.157858] tegra-xusb 3610000.usb: HC died; cleaning up
> [  186.317280] tegra-xusb 3610000.usb: Timeout while waiting for evaluate context command
> 
> The issue is caused by disabling LPM on already suspended ports.
> 
> For USB2 LPM, the LPM is already disabled during port suspend. For USB3
> LPM, port won't transit to U1/U2 when it's already suspended in U3,
> hence disabling LPM is only needed for ports that are not suspended.
> 
> Cc: Wayne Chang <waynec@nvidia.com>
> Cc: stable@vger.kernel.org
> Fixes: d920a2ed8620 ("usb: Disable USB3 LPM at shutdown")
> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
> ---
> v3:
>   Use udev->port_is_suspended which reflects upstream port status
> 
> v2:
>   Add "Cc: stable@vger.kernel.org"
> 
>   drivers/usb/core/port.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> index e7da2fca11a4..c92fb648a1c4 100644
> --- a/drivers/usb/core/port.c
> +++ b/drivers/usb/core/port.c
> @@ -452,10 +452,11 @@ static int usb_port_runtime_suspend(struct device *dev)
>   static void usb_port_shutdown(struct device *dev)
>   {
>   	struct usb_port *port_dev = to_usb_port(dev);
> +	struct usb_device *udev = port_dev->child;
>   
> -	if (port_dev->child) {
> -		usb_disable_usb2_hardware_lpm(port_dev->child);
> -		usb_unlocked_disable_lpm(port_dev->child);
> +	if (udev && !udev->port_is_suspended) {
> +		usb_disable_usb2_hardware_lpm(udev);
> +		usb_unlocked_disable_lpm(udev);
>   	}
>   }
>   


This resolves the issue I have been seeing [0].

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

[0] 
https://lore.kernel.org/linux-usb/d5e79487-0f99-4ff2-8f49-0c403f1190af@nvidia.com/

-- 
nvpublic


