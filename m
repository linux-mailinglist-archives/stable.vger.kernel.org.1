Return-Path: <stable+bounces-109340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25675A14A5C
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 08:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B66518858DE
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 07:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAC71F667B;
	Fri, 17 Jan 2025 07:45:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C091B4F0C
	for <stable@vger.kernel.org>; Fri, 17 Jan 2025 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737099938; cv=fail; b=MjLizZmSB8iWfcQiqZ4IxzoWX8FUfZde0ojO59ELwZNlGY+vN8sGKDpYERkAyboIWKd6phHIgYKp2oMTMJeIZL26F8PbD/CTKRKVCa6CfneIzzityVB5goJ54qUPWIEUa69p03g6C2jBkWla6UV98IIuLZK0PxnMK0ucz67khYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737099938; c=relaxed/simple;
	bh=uQTspZgMYS7kHrmMgwbd636Zrz5krQ2HdxHiKn2lvGI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O/SVtPQDzKAluhSnJHsXEG/Vm7aPPYv3skYWpBdJArGjqMZS0cBuXJrMUCGWMMGpu7VJTEzZA16dcd4z1/uJVGnvtOdZlQLI1vytBaJQE03S6hjXFk0LmbFX+q+7T2jV7+M+FCU/6OBBuZBsQp/UTIJJDYx0E0mEJb94nNdg+4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H5Z2EK021713;
	Fri, 17 Jan 2025 07:45:35 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 443dv16mhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 07:45:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xr6lndu5x3aX1jGLzAwzb8k3a/4WBTbxXaVS/Bc4H3hamBCrRsH42isDDdZnTxU2zrxrT9XoPeSeqTjoIrD3Y9Wkgi+ZnzITOtxgJW1MjWvkQgl6XTw34tfZvGt1fCz8ccrhfLc8NOmsYwp9+njUCrdT8GlpFjHFCJPmmb+z3+pLw8AIC3Ajb4TIuHi/TdEyXI95hlvaQePY3ONVG9MgRgNk05lRUwUMEWiiVk3P8RAT6h/KxF9vSuFrPl4XZVWT/mhUsyBYbz4ZQ/ZSNkxUfoRQg5/CQDOx01T0trFxtKvYpJk2JGhPCVLDbRfsj3GbLKizbipVgsMNH+hlJ7MTBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOYwKdPXWRballFMuh0j9B7khDZHhcHcsOivsvYIKJY=;
 b=AT+800YMLztkMYR7ejni846MVQzQT4dvDQwwTUPGkIXEYibEjlgBYrhoj9mwYRCnX1M6MHoS7lUdtO5pax2SK38Nfxgpfdxk3Z92Epns4Bc0T0zyvvf8s9jXDBu+rtkjGQYB7wYXiZIFs0id0ygpl9TmHwn4JmE/dAcrtRRyxP78WUXGzhGVfUi/Nz7r3ba9lPx8fgfJ91yWvqR/SHy/qIUeIzKsIflR/a7Mu37/Wu9YG4uhuZbPu8osqLtH3z8cJgiE6GipX6o4Wa/EInnQc59dBb4/0daK2oWxu0dl3TEzUsWgBoORAtR99LQCK8ls36SGKYx2bIQT75WXsVTpTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by MW5PR11MB5858.namprd11.prod.outlook.com (2603:10b6:303:193::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 07:45:30 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%7]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 07:45:30 +0000
Message-ID: <8deb309b-2069-44c9-a8c0-74f8ba98734a@windriver.com>
Date: Fri, 17 Jan 2025 15:45:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: controller: Restore PCI_REASSIGN_ALL_BUS when
 PCI_PROBE_ONLY is enabled
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
References: <20250117072933.28157-1-Bo.Sun.CN@windriver.com>
 <2025011745-smite-banister-392b@gregkh>
Content-Language: en-US
From: Bo Sun <Bo.Sun.CN@windriver.com>
In-Reply-To: <2025011745-smite-banister-392b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0348.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::11) To SJ0PR11MB5866.namprd11.prod.outlook.com
 (2603:10b6:a03:429::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5866:EE_|MW5PR11MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: 50d43c8f-0c34-4d0b-666c-08dd36caeaad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmRnL09STm40YVIxcHdXUUI5QXI4U21XVVMvWmZXMW5vbDUrS09maElOMk5Y?=
 =?utf-8?B?b01NQnQ5WlNVRksrenQ3WXpORTNscmNSRWlxVXVTYUZGT1ZkZnJ1RmlEekRI?=
 =?utf-8?B?WFYxZWVwRW52UEFCdnJmR2ptS3JKVHNKOEpPUHlxbnBGYlJRZTc1VEFNNFNp?=
 =?utf-8?B?Q0Q1R0FEME00S1ZGUWtRZUpLdjdTWVdDd2dYb2UvVDNuQWlQejh2YnRLVkJN?=
 =?utf-8?B?QWNsanFaNXNna2g3MHpkZS8wd2t2UnFJVnNDSUtjLzdoTjA0U2czRUtUU1FO?=
 =?utf-8?B?VjhzbmcvcVRlUXdJajc1S3BRVHdkaS9jMmxkVmliRis3MDFTS2NvSk1LQmFm?=
 =?utf-8?B?cDhYMWExSXlPWng4NUx5N21JSkJEQzNtbnRoLzNDT2JNK3dWQkhKUkgwOVNv?=
 =?utf-8?B?OW9RMzIwWi9ENW9xK0Jwa0VIWXcycyt3TE84SDdLLytLa2VSTEhWUVRWcFQ2?=
 =?utf-8?B?Wk53bTd6M0RTWGc5YlJ4dWpMcFlaSndkOGkyUGJlWVIzcmUxZDZqbjBsY0Zo?=
 =?utf-8?B?RDhUdDFqbVdRTWcrNzJtaklhQzZwK0RhZ2NuU2llOTlwK3dGOVpJaG1lV2RO?=
 =?utf-8?B?ZWNOVk1zdEVNYzNXU2x1VURkWW0vT2ttMFpITWllTGNMTWN0UkNCYVFSN1Jy?=
 =?utf-8?B?ZzZrTnIwdDdma2N4eGNUY1NKUng5QThLUWtOc2VxQk9iLzBQc3ZhaTdQVGJG?=
 =?utf-8?B?VnM2bkRtT3oxelNPbmRuY2VFMFZLTDZ0RGJadTlRanNCdTkrS0IrN2FIV1U3?=
 =?utf-8?B?N2grUEFUZW1ZMk5wMituQk5rQWc5RVRoU0V5ZFdORER0RzdZQ2VQN2szLzZJ?=
 =?utf-8?B?K1ZvVWUvMGhuS2s2N0cwMVVDWVdlQ1BrcEEwM0NUaUhUemVlQm1jellaMU9O?=
 =?utf-8?B?UnZBNUJySlpMbzVXZ2V2cVNpcnZwclFtWXdBemhOZy9UYnBIWlJrQ3dteGQx?=
 =?utf-8?B?Z0pXdXhFdytDM2VuMXhLSTBBaG8wemdOU0VDdk95cS8xR013dUZSQk9Pdnhm?=
 =?utf-8?B?R3NiM293d2NWSWdpeURBNkx3VW1vK2VoWVZUN29ZWHFzTHczQ1Q4N2UzY3I1?=
 =?utf-8?B?NWtCT25QNTdEbzcxNGhvSFFjNWZQUzNkVitLTlorOWZnM1hmcy9EdHIyQk5C?=
 =?utf-8?B?WkxaaGtYa2tOaGtOZXZHR0JpdFQyTkVKb2dEc211YUZkSWhyTElKV1M3VC91?=
 =?utf-8?B?OE5RbnFMNWFhQ0M5QXp6cFltWVRid2EySHcxL2dpL0h1SytwcDJYY29IcVBD?=
 =?utf-8?B?WUt0cDEvU2Z5Z214T01PVERzZW4rbWJDVjIyWE93VUFJVUI5dXFZeER5Q2ho?=
 =?utf-8?B?Z0hrVDZPZ0RqUzVTZTFZd2NUR1VQV0lVcjB5R0U0T3ZhLzEzL1RMVkE2b1VO?=
 =?utf-8?B?M2ovSlcxbVZSVXVoc2pjSVRyNkJnRi82ZGJqNDZpNFFzZ1RFakR5blF6cUs0?=
 =?utf-8?B?Qzl5WWlKbG9ISnRsSU15TlZoT284anpveDRJQURRdENFbWdoMm9Hekt1QmJR?=
 =?utf-8?B?aG5qL3hDamI5Z05IL0g2UEQ0c0kyWEU2elBaQnUyVHU5bWVLQjNkQ0J4d3lp?=
 =?utf-8?B?YWRzWmFNb3BxR3NiVnZOYisveURIeXpiQzEveDVuY0ZmYm5VVzRYTFBDMUh0?=
 =?utf-8?B?Q2o5WXpIWVlWQ3hxNUxUQTdkVVRjWnd3NTlhRFYyRUZHVWd6bE5GTFVIMUt6?=
 =?utf-8?B?aGJHa1FyZWIzbnkrbTlTTHI0bUdvdkdDeURvT20yUDBEWFhpazI5bVhhaW9H?=
 =?utf-8?B?V0JmK2lOV0h5dFdNV1hBTGkxYlU0NE1yY1duTFp0TDIraEJxWFhRVUh0SUQ3?=
 =?utf-8?B?V0ZHdDBLVW8zOUp3aUNncWJ1RThvRmVXM21FU2taVmlldWJoWDVhT29rWE9I?=
 =?utf-8?Q?BtuS5GldbEt8t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elkvUTFFdW5uQnJvWi94YWxUMERnN0k4UWl1S1RXM2tqRk1PK01XSDNKVzFK?=
 =?utf-8?B?a1Z2djBwYU9NcE9zUk5neDlYVXNRQys0QXEyaFNDZHFjWTRYQWRSak1VOTEw?=
 =?utf-8?B?N0x1V2NOV1V0cWYydUkrQ0ZxLzJVWU1lb0VUdDZ5YVVzRDZvSk8rcTJydVBT?=
 =?utf-8?B?K2dVYjN3cFlic0JTTnJybHhHeFRwUlVTcUszazBDV1FtQTI5S2tQTC9LTXlR?=
 =?utf-8?B?N1BqTStST2hpWWcvMXhzRzF3dng2Y2Y2SGJ4NDd5cmxRWlVhVlFGRTlTcjBW?=
 =?utf-8?B?QXFUM1FKMVMwdW53U2NwUmFKLyt1YmpEdWsyemdkY3pORkdUUGJHclAwRjhX?=
 =?utf-8?B?TGY1YURpZjhxck5LTVJsQjZFZGhFODk2cGQ1TXRzSlVFM052byt3T0FRZ2N6?=
 =?utf-8?B?cEdYQTN4cXVLNHVySUhVbC9rNHU5d2c3NUhqV3k5YUJ0UDNnR0IxZ1RDbUQr?=
 =?utf-8?B?SUNyYVZWVlByL25XaS9ZSGFTN0ZKT0E2T1pzTDJET0dudVFpenhETC9vMHFh?=
 =?utf-8?B?MGxSS255Nzl1cDBwKzVudDZKSU5jVWVWakd3cjVQeXpHWnNMNmVma1ZYSHZZ?=
 =?utf-8?B?MUdNemcvYUwrT2E3UUFiUmpjY0pwSlk2NkNvY2ZjTjFXTnYwaXAwS25OcGMv?=
 =?utf-8?B?aTF2Yld2TFlsQ1g5VTh4bEY4THJBUzg0L29ZRm9vNDRudVlHTnVvMnpOb05w?=
 =?utf-8?B?T2VOczF0N0FDL29RZ2ZBOUdBNjZMN1RDM0tEb2F3MFpNYkNyTk1BS3V5ZXJt?=
 =?utf-8?B?N1h6TXJ1ay9WRXAzRU9weFZIMXpBR2F0RXlvS1NpZmcydURjWVlQbndHOHNU?=
 =?utf-8?B?TERudTlDVFFrdmc3M3hTUmdBVytvUEtJdXhnVHYwNHFLQ2VlUEFScEM1VHBw?=
 =?utf-8?B?L0FkSDV1dGxkQ0FaVCtJdWhQMUIwQmhYQUpmNmxVNGFNSUxsRjlKblI2R0ky?=
 =?utf-8?B?RUI3cERBWDlFMlhBYzVGem4xSCtaYnh1aWRZYVo5Qm8rbzZHUHkxV0ZKcDd6?=
 =?utf-8?B?MElOVUtvS3pOVVpDVzhoQnV0c2hscDdWZURja2VsVHRwWVlaayt0U0JvRExD?=
 =?utf-8?B?S0djREVLM3pIY29EckRoS01nUXhqVHBxbW9XQmFsdTBweW51U3AzSDhPdGEw?=
 =?utf-8?B?WmcwclNJMW5xR1F4L0N4RTNHcm9jSzBkTW5HbXRHYnpmMUNxZ1B0MGJSR3Yy?=
 =?utf-8?B?RVVvbFhQSm5aYWxmNlNENDdyYXY4NjFmcnRLb2ExZ2szQ3FiVzlGdkhRdjBx?=
 =?utf-8?B?a05Rb2t1WGZ4dUM5dEdhMFNPekdlOTV6VHhia2YwYml2d2pjM29ndTB2M2Ja?=
 =?utf-8?B?Z0FFa0l1R3pRd1ZONmVDNVJDRDN0MGZ0dnYwblhOOTVadytYYmJ2NTA1ci9j?=
 =?utf-8?B?a0QvNW85WXFUR0JsVWhaMFZFMXpZdkxlSEFLNktjb01NcERleDRSK2Z5enVx?=
 =?utf-8?B?YWhTQ2s0bmEyZEhTb25QM0Z0UW9HYVRTazZJQ3JBYWtTWWVFNUNzS1N2bDYv?=
 =?utf-8?B?MWVLT054QkRsNTlqQmlReDdkTnJ4bmhFaHZ6Rks3YVZmSTdabUpFV2k3emhV?=
 =?utf-8?B?NWNyb2pkUDVpVjFMczZlWmFTdW9ZVnpZa1JzSFlkUlkyNEhIMENadDBxN0c2?=
 =?utf-8?B?ajYySXZnMWRDbWZDeVc0bExNeXcvSzBRdUtSL05ENmcreDc2bldYMjM4ZERm?=
 =?utf-8?B?b3AzakhxYUlrR2dhVUhWNTFvdm1CNUxaS1ZMYm1NaitQSFg2S3RLbzRIOGx6?=
 =?utf-8?B?Wm8yZGNBRUdya3R1bVFCZnJyR0xQaXRDVms4MVdaeVRIRlcyTzdVeGZsWm92?=
 =?utf-8?B?eEVIc2ZaVGtLUUE5TGVZaFRFSkQ4ZHdnTVY1ZDdlZTF4eENZSUVqT2hCL2U1?=
 =?utf-8?B?TGUycHVRTGQ1c1NEdDlOU1BrRFhYMmZZY01TK3drN1o2cmNPUjdtV3YwN0Jw?=
 =?utf-8?B?RVlWenF4czlHeTJqRTZEMmMyMjNsSDgyaU1CZ1p1cC80YzdGUE5tUjIwQnE5?=
 =?utf-8?B?NTJrbjBpUUE3Rk5tM0labjNtK1RHemRUdm5Nd3E2ZitxYjBEMjJScldCSzJa?=
 =?utf-8?B?N2gzM0hINldpb3hNaENzNGpYRjFPdHVSNUZSNGhtZWYrTlhtTXBKMHpZT3oy?=
 =?utf-8?B?Q1lNU1lMaTU0S1VaaG90emxtY2ZJVThmdG93cDY4VVpiRExEZng2VHhzT1dQ?=
 =?utf-8?B?TFE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d43c8f-0c34-4d0b-666c-08dd36caeaad
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 07:45:30.5761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6pqGx0EaHB4xYnzlH/Jx+UidCulR0nCpKqgwXmJNJPaZ7e9/GNNN+C/NNXUlIjkMg0D9bETK5H4/nhauVK8bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5858
X-Proofpoint-GUID: mkZnDaN_KYyq2LRvfqr9puXwIKslignc
X-Authority-Analysis: v=2.4 cv=N5zTF39B c=1 sm=1 tr=0 ts=678a0a9e cx=c_pps a=eKE3A02riAhCxcKrmNn0fw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=bRTqI5nwn0kA:10
 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=cGopdeYx9dtS0d82ICYA:9 a=QEXdDO2ut3YA:10 a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: mkZnDaN_KYyq2LRvfqr9puXwIKslignc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_03,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 clxscore=1011
 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.21.0-2411120000
 definitions=main-2501170060

On 1/17/25 3:35 PM, Greg KH wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> On Fri, Jan 17, 2025 at 03:29:31PM +0800, Bo Sun wrote:
>> On our Marvell OCTEON CN96XX board, we observed the following panic on
>> the latest kernel:
>> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000080
>> Mem abort info:
>>    ESR = 0x0000000096000005
>>    EC = 0x25: DABT (current EL), IL = 32 bits
>>    SET = 0, FnV = 0
>>    EA = 0, S1PTW = 0
>>    FSC = 0x05: level 1 translation fault
>> Data abort info:
>>    ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
>>    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>>    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>> [0000000000000080] user address but active_mm is swapper
>> Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
>> Modules linked in:
>> CPU: 9 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.13.0-rc7-00149-g9bffa1ad25b8 #1
>> Hardware name: Marvell OcteonTX CN96XX board (DT)
>> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> pc : of_pci_add_properties+0x278/0x4c8
>> lr : of_pci_add_properties+0x258/0x4c8
>> sp : ffff8000822ef9b0
>> x29: ffff8000822ef9b0 x28: ffff000106dd8000 x27: ffff800081bc3b30
>> x26: ffff800081540118 x25: ffff8000813d2be0 x24: 0000000000000000
>> x23: ffff00010528a800 x22: ffff000107c50000 x21: ffff0001039c2630
>> x20: ffff0001039c2630 x19: 0000000000000000 x18: ffffffffffffffff
>> x17: 00000000a49c1b85 x16: 0000000084c07b58 x15: ffff000103a10f98
>> x14: ffffffffffffffff x13: ffff000103a10f96 x12: 0000000000000003
>> x11: 0101010101010101 x10: 000000000000002c x9 : ffff800080ca7acc
>> x8 : ffff0001038fd900 x7 : 0000000000000000 x6 : 0000000000696370
>> x5 : 0000000000000000 x4 : 0000000000000002 x3 : ffff8000822efa40
>> x2 : ffff800081341000 x1 : ffff000107c50000 x0 : 0000000000000000
>> Call trace:
>>   of_pci_add_properties+0x278/0x4c8 (P)
>>   of_pci_make_dev_node+0xe0/0x158
>>   pci_bus_add_device+0x158/0x210
>>   pci_bus_add_devices+0x40/0x98
>>   pci_host_probe+0x94/0x118
>>   pci_host_common_probe+0x120/0x1a0
>>   platform_probe+0x70/0xf0
>>   really_probe+0xb4/0x2a8
>>   __driver_probe_device+0x80/0x140
>>   driver_probe_device+0x48/0x170
>>   __driver_attach+0x9c/0x1b0
>>   bus_for_each_dev+0x7c/0xe8
>>   driver_attach+0x2c/0x40
>>   bus_add_driver+0xec/0x218
>>   driver_register+0x68/0x138
>>   __platform_driver_register+0x2c/0x40
>>   gen_pci_driver_init+0x24/0x38
>>   do_one_initcall+0x4c/0x278
>>   kernel_init_freeable+0x1f4/0x3d0
>>   kernel_init+0x28/0x1f0
>>   ret_from_fork+0x10/0x20
>> Code: aa1603e1 f0005522 d2800044 91000042 (f94040a0)
>>
>> This regression was introduced by commit 7246a4520b4b ("PCI: Use
>> preserve_config in place of pci_flags"). On our board, the 002:00:07.0
>> bridge is misconfigured by the bootloader. Both its secondary and
>> subordinate bus numbers are initialized to 0, while its fixed secondary
>> bus number is set to 8. However, bus number 8 is also assigned to another
>> bridge (0002:00:0f.0). Although this is a bootloader issue, before the
>> change in commit 7246a4520b4b, the PCI_REASSIGN_ALL_BUS flag was
>> set by default when PCI_PROBE_ONLY was enabled, ensuing that all the
>> bus number for these bridges were reassigned, avoiding any conflicts.
>>
>> After the change introduced in commit 7246a4520b4b, the bus numbers
>> assigned by the bootloader are reused by all other bridges, except
>> the misconfigured 002:00:07.0 bridge. The kernel attempt to reconfigure
>> 002:00:07.0 by reusing the fixed secondary bus number 8 assigned by
>> bootloader. However, since a pci_bus has already been allocated for
>> bus 8 due to the probe of 0002:00:0f.0, no new pci_bus allocated for
>> 002:00:07.0. This results in a pci bridge device without a pci_bus
>> attached (pdev->subordinate == NULL). Consequently, accessing
>> pdev->subordinate in of_pci_prop_bus_range() leads to a NULL pointer
>> dereference.
>>
>> To summarize, we need to restore the PCI_REASSIGN_ALL_BUS flag when
>> PCI_PROBE_ONLY is enabled in order to work around issue like the one
>> described above.
>>
>> Fixes: 7246a4520b4b ("PCI: Use preserve_config in place of pci_flags")
>> Signed-off-by: Bo Sun <Bo.Sun.CN@windriver.com>
>> ---
>>   drivers/pci/controller/pci-host-common.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
>> index cf5f59a745b3..615923acbc3e 100644
>> --- a/drivers/pci/controller/pci-host-common.c
>> +++ b/drivers/pci/controller/pci-host-common.c
>> @@ -73,6 +73,10 @@ int pci_host_common_probe(struct platform_device *pdev)
>>        if (IS_ERR(cfg))
>>                return PTR_ERR(cfg);
>>
>> +     /* Do not reassign resources if probe only */
>> +     if (!pci_has_flag(PCI_PROBE_ONLY))
>> +             pci_add_flags(PCI_REASSIGN_ALL_BUS);
>> +
>>        bridge->sysdata = cfg;
>>        bridge->ops = (struct pci_ops *)&ops->pci_ops;
>>        bridge->msi_domain = true;
>> --
>> 2.48.1
>>
>>
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>      https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>

Dear All,

I apologize for the oversight in my previous email, where I 
inadvertently sent the patch without including the relevant maintainers 
in the CC field. Please disregard that email regarding the patch.


Best regards,
Bo



