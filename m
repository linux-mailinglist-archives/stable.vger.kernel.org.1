Return-Path: <stable+bounces-127374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81524A786AD
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 05:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92FB1891845
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 03:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53CE1411DE;
	Wed,  2 Apr 2025 03:00:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56A22E337B
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 03:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743562838; cv=fail; b=KrzDJ6LCeuT6ArIy3DDvIDQPkyORiDkQCNiKzZtCrmdTqJv7pEL7TjjiThYjvd+z9xm55B7645hsOlNShEJmECLo+CEabtpsSfiYfAJOrio44E+0N7e0jvS8rKy+VfAAByL8I2UDSF5CPd2+I8/71QYDOsRrnEGQ7hDIIeGT3RI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743562838; c=relaxed/simple;
	bh=lTqVFxtpt+mCi51wfFjAczz2n4+sxENbpM3RgfzeG70=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cM0tv9CrKPV9A7cJQQfys/q3Hh2tRUhE+M4UkzFWpxgVfI9k0+z+s6muYWzhkOSTFRmsMme1/60+7vC/qnTrAHomQL4y2kE10OIU4NwAT4JaMwys/1otQgzADZoXudBassRHlDOSqdme0HPIyzlbZo5OEzhnaooKOnx++GVrWNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53220VXq007042;
	Tue, 1 Apr 2025 20:00:28 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45rtc9r508-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 20:00:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shxGuPbhidCXKIx56DPqOCKmplinzfKRICpmWLOQZCFoMY+RKgsHDh0OaI7Rww+ARGSBMUCm6noxoKx8Lzv/JukW3HmmAqbrQdoNjAe0UUeWtyzRnEOflZNogrTJk2zlABXbcn4qD0unMYZXbfhOPGIuWdp5zmYfgP6IkjkehvkyNkDMs4g5+EX4w8ZOCnjS9B/5Ic5Qj93jrjN/DtPbsLlHUGissfNIpAraGfVAXBQPubdzp8+g+suRxzsBJ3HChKceM2vXs0Q7/4PptW8ZAEmv0Pg/qAYtcxiKNhSKGdRBv75PrNnR+AEZh8sZvBlRWJgPyJyrXB+iiA/wBXfcfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ARFby2G76ncw+nKbaLm/iartgZ04jK3aoZeE/FxZvI=;
 b=KYQrtP81qxyUM7ucl4247V9NLmtmk7n/eZpvreos0efXloHrC2gO4qKGQ9PXhKzJZfpHyWzuI2ibGlK868r4GBUoc5QTirNEIjZndn0ei7AeYKcjm9E9lvkBlZh25FYPybAkxXmTuYCPa16J9C3O7WxrF1pWS8/M0I8aKWOxGCX2jKu2ZscncSZ1ecVhifnhhGSCwU6y6LAm9XfNgg+0strrWJDr2ZtCBYkfi/Skn179AunVtFT9W4KlVwJiKgdEWi/J1tBwoHVEIGZO5tL6z4D6KL3/QwS6hr3M+tZY6fFurYG2ixKrpHLbXtzQUhTJJkQB3D8RL0URNLPSDbFQGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) by
 CO1PR11MB4993.namprd11.prod.outlook.com (2603:10b6:303:6c::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.50; Wed, 2 Apr 2025 03:00:24 +0000
Received: from DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a]) by DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a%7]) with mapi id 15.20.8583.041; Wed, 2 Apr 2025
 03:00:24 +0000
Message-ID: <34c7e7b7-af0b-427e-85c7-f137f8e31b0a@windriver.com>
Date: Wed, 2 Apr 2025 11:00:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y 6/7] binfmt_elf: Only report padzero() errors when
 PROT_WRITE
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        keescook@chromium.org, akpm@linux-foundation.org,
        wenlin.kang@windriver.com
References: <20250324071942.2553928-1-wenlin.kang@windriver.com>
 <20250324071942.2553928-7-wenlin.kang@windriver.com>
 <2025040101-riverbank-kilt-459b@gregkh>
Content-Language: en-US
From: Wenlin Kang <wenlin.kang@windriver.com>
In-Reply-To: <2025040101-riverbank-kilt-459b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To DS0PR11MB6325.namprd11.prod.outlook.com
 (2603:10b6:8:cf::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6325:EE_|CO1PR11MB4993:EE_
X-MS-Office365-Filtering-Correlation-Id: d22b6aef-6434-4f02-1acf-08dd71928322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dU03Y1hWYy9ZQ3FkK0xoUkNMbHJtZTZRbDh6NDE0V21qbzkvdnFRejJaVzFh?=
 =?utf-8?B?RHR6OG5uUU0wMUQvblVZeVZVdFFHeVFVbFhGbDdhU0NNZWxPdTg0RFk1QkRh?=
 =?utf-8?B?ajJzMmZ2NWVvZ0FKQjUvYlFrVkxnWmU1V0xxYTFIQ1AxNnJ1bVhwYVBuSWJE?=
 =?utf-8?B?V056V3k1b0FkdWxlb2U0OWJWS1ZSejVFbFlkUGNKcHFqd0dhQ3grYzFzSnUy?=
 =?utf-8?B?VWtRNHVxYVd6RUFsQWJxbWdFOFZhVlovRVM0ZGVFbVYrZVZTdUJxckxzeWhr?=
 =?utf-8?B?N01Zb1Z4R2dCSUtLOFprc2pvRmIvU1drdWpkdXFHUFM1V01KeGhPZ0hxbzJZ?=
 =?utf-8?B?dG1hS2g4M2tEaWRDOFpFM1ZKbzhUQ1U2MFB1Uk4xeEhQbWRFZWd0TWRrMEFW?=
 =?utf-8?B?U0tWZWFZYTZPcTZjSUNHWFhnUWxoMHVNalpvT25hcDZyUXNRUzFHWUxzMmoz?=
 =?utf-8?B?VTNqVXRFLzYwcXRZbFlQWVplNE9xcHVEc0l6a1YyWlVGZlVNWURzUXVTWXdl?=
 =?utf-8?B?bzFNSnhTLzluNEpRYjVzYUF5U1lKc3NpeFFQQ3VONE1PVlJRQXd0aURaVDUy?=
 =?utf-8?B?M0RVaG4vUzBMSElicnhHMC9ucUZJa2tyNWE4U0J1RStSVnhsS1JaamhidlZv?=
 =?utf-8?B?SUYybittM05XN00raXdOb1gwd0w4bWVCbHpzK2VlYUJITFRJcFhxMUZpSTRo?=
 =?utf-8?B?NEYvTXc3WHhXS3NpNzJHUzZWdFNNaEppZTdveUNUUGlPSWxLMlc4ampVTzJv?=
 =?utf-8?B?M05uYVN1Tm9HYUVCM0JrK1BNUG9HU2w0eEF3SEdEaWxwMzArTHBIYmpOU0l1?=
 =?utf-8?B?ckxPLzBVaXFlMUJoMU0wT0VXWktXYlgwOVNDMHpYRy8zSkN3cHUwdjJvMncy?=
 =?utf-8?B?cy9KU3RJVWRGcGRtbFNiK0UzWnQybkltek9BNXE4SGR0R1U4dlIyU2F4QkFU?=
 =?utf-8?B?czNlZUVCdzVBSW91UWxDNG94QXd2ZVFPcW9DTTY0c2h5OEVzRFdNNmxiemlO?=
 =?utf-8?B?SGN5T09VUWROR0hmaFh0bVl2STVRY1R6NHZVcXA5RzNrdGNPK0FlTkNUaDU1?=
 =?utf-8?B?dEtYOFNmaFJkL3NpYndZRWh1NitxNnk0N054UGlFNEY4ajc1TzNKU2FsZkNY?=
 =?utf-8?B?S0ExU2Z3UmR2ZUFmam9HTVBXanFFY1UxSWRGSWhwdHUrbjh2bml0NXpEZ1VF?=
 =?utf-8?B?dHJHU2xsMVMxdXBDeFptSlEwZ1l3U2NMb3JBWXpJQUh5QjBnREtVVVlQVzJE?=
 =?utf-8?B?d3R5bUVtYnpwRENxVGpLUzdEcUQwc2hadllZSXNWVWhTeDVNVTFQaU1GQXFo?=
 =?utf-8?B?cDAvUGtKZjd6L2lKa2hnc1hhcVB2MFJZWTZtaFQ3aG00UUtsT0JENFVSMXlD?=
 =?utf-8?B?R29haUVwTmFmVW04Ync5aHZOUXRPQ1NJUm9MaVFxb0pWejU5RlJlOERyU3di?=
 =?utf-8?B?ZUpRODFlSWkzb1RYMXlyaFU1a214NmdiL3ZrbHRsMTlwWjBvemlYczJ2b25z?=
 =?utf-8?B?d05HK2FiME1qbTRpQ0ZLa01SdGkwSGVNSDFESWxCU1dPamc0RWJUeGVsbVN6?=
 =?utf-8?B?WTlzVkkyYTFUMElvcHNSUDZyL0hpc1FFWUtZSEdIbStlQjBrenlQeHFJZUov?=
 =?utf-8?B?WGwwYTFYNHF5anBNSTZMQVBaOGFZTW5MQTIxSzBna3UvT2xLWEhqK0diV0lJ?=
 =?utf-8?B?cTErcWtpWGNWNEVidElZOVJpYmJPOHpqZmU3bkdZamdGeXZEOFhyKzZwdUF2?=
 =?utf-8?B?MEZaVXI5R09TUXcwNTdCRHB6T3h2T1FkbzVEZ1NsSUhZUC9RcUZsc0NuUjVP?=
 =?utf-8?B?ZmZOZFJEMmNZc1pPRFdUK0RDUEZnUVJqQzh0OFVlZXJUWE1GSGd2NlJKSjlZ?=
 =?utf-8?Q?8zO0SG8p50U0H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6325.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjFFeHZQMkpKTXZlKzQrL3BvMnhNckJVZjhVSjNmenMrZGdlUHdONTVoc20v?=
 =?utf-8?B?NVdOeFFLc2M1WWYrSGpFTVlDc0pMVFp2Y0NPOWdZYmF2aURJR3UrNVFBcXdC?=
 =?utf-8?B?MFlyS1p1V0lJclo0M3NlQkxoT3BLRnJUeWd0QWd4N0pHWjVuTjRwL1hFUWd0?=
 =?utf-8?B?K29xMGtab3dsUjhnWC9QL08vSnpDZCtDZDkzYkQwY2M4L1A1aWhYRXYwUmxM?=
 =?utf-8?B?dHRpVHNXUTRXSWFCRnljMzkrUm1LMWRpakEyZUljUnhGVWpiTyt6NG9OYkYx?=
 =?utf-8?B?U0ZzSFdFV3NKTkVoU1ZvTkZqR0kzTzZZdUd0SnAySXU4YjF2K0p3NWJKUnhU?=
 =?utf-8?B?Wi9xVUNaV1JCYVIzaU16MVJpcXZrSVNYdlU3RTVBNGRweTJ5Y1ZlM3hnN1BY?=
 =?utf-8?B?RUFUNGlCZVhWMGRsSzltd0ZMcmFkVFpFRTFwSS9mMFltT29uK1dCRmNnMFh0?=
 =?utf-8?B?c0IxVTJVRjZXc0hXaVBnKzJGb3FtNUYzWXRJb1JoK09udWNyTXZPQVpTYmkz?=
 =?utf-8?B?cldyWWlpUXlWMDArWjB2Yytwbm5jNVVPTUtVbWh6LzlEU2M1dGY3Z2pkSFQ0?=
 =?utf-8?B?ZkZWMDlpSmp0UFFYbGRmWmt1cmNjZUV4dmpOOWVwWlR3WFRkR01vc0ZRS2Zz?=
 =?utf-8?B?Q2lROVl2UFpkM1JDZXNGM0J4WWxFUFZ6aVQxSmMxd3BWeUU5OWN1WU9IQTk5?=
 =?utf-8?B?VmRIajZ0MmtNSE5yNEpPbWRZM3RLU0ttZDh0cExtNXA3Z2V2R1pKOW9vYyta?=
 =?utf-8?B?emxwTlo4endvM1hHa0VPdGRjSjZMbjZpSGp5RGlqUnNCMkJWZUwvQnZYSG5Y?=
 =?utf-8?B?WWtmRHMyMzF4ZldhL2JJaEdoK0JHa2kzbTJ2NGRQNFg4NUpOdWF4M3BqdGdT?=
 =?utf-8?B?YVNaQTJveVpwTWhwRXBEZjhpZnBkVnE0TFB6WGlMQjNuUWlORE10UmZsWE9j?=
 =?utf-8?B?ejhvVmRWQW81QUh2c2twVHZGbnh3bUE1blh4MHIrQ254TXFsNnpPZ3dkYTFC?=
 =?utf-8?B?amRweVZSbDhsa1h4bitGb2N3azY5YkhvcEhSaUNjYmRtSHI1NktUcVhoZkht?=
 =?utf-8?B?Z0t5eGU4ZitvR1V6dUNZNVNWYVhvOXRpYnpET2ZBdkRqUFordGovRVJIZGtw?=
 =?utf-8?B?dGI2MlJJbytNTWlpOTZEam8xSTdlZXdsaE1SakJFQnliOVRlL3pKSlhuNHM0?=
 =?utf-8?B?K2d3bC82ZnRuc2NqczFhTzgyTDdES3BmdnZUYWlxVTRlSGdPVVZWdmFVZUFi?=
 =?utf-8?B?bGIzUDNDK05GN2RJTDVyYmdNQVBJck5zVGNJdzB1ODRxc3Z1NzNtOTFHNXlF?=
 =?utf-8?B?NzNTV1ZzTDRxN0grQ2pIMDRQR0h5eTZuQituNncrSVBWc2p3U1BlQ2hJK0dY?=
 =?utf-8?B?M1o4ZWJLQThtd0hRQUZaWVJ4TjJvMlY2NDJ5SHZ4bHNzdjBzYXdvcWFKVk1F?=
 =?utf-8?B?RFNPV1E1RkxSZHlTMnFaRDRGSGRXaHFrZVVrQUluYzJNU0JsYnlwbUM4OXdD?=
 =?utf-8?B?OVFINlJTTFgvcllVOGt3Y0dVYmwza2VOTERSMnQxeVk5d3Z4S0EyR01LNEI2?=
 =?utf-8?B?aEQ2cndWKzAwWjNPcXlhbkdZdk5iaUhGYWpKVGVvTE9nQmxaZ3o0OGZBT1cw?=
 =?utf-8?B?c2MyZE9CNHFWRVRua3VtU05YdFpoVThDYnhrb3lYdXJZczF3WDIvNzNUOHBX?=
 =?utf-8?B?cUp2bFdQRmhvaXlYOXhCUFIzY2Q0TTRCelBQeFlDOXpQVWJMQ28zQ3RQZXpE?=
 =?utf-8?B?V3VTc09rQXQwTmFReExsWG9yNFIxRzY0MzdRa0pxWCt4QlplT3FmWlJVZ2JT?=
 =?utf-8?B?dnFGVUdTZHlVeWc1OUFoQ09Vd2tpc1Z0ZTBvOERQSVpQdDVXc01XcktKalYv?=
 =?utf-8?B?NlhzcXZ1TlNqTUJBVlp4T1h3SlJCV1A4YjZGSG5RTEdPeGNpaGlQa245clZZ?=
 =?utf-8?B?ckc5dXUzVjlWY2k2RVpnZjQ1bmFTdnFxSHFWUGFHcUtoa0FhUnFXZ2N1TjdY?=
 =?utf-8?B?QWVNZHl5ZmRTY28xQ1ZMaS9oNmtkbmJtUUl1MGVteU0rOUQweWNnMG9tb285?=
 =?utf-8?B?OEZoRlROT0p4Yk10Y1hQZjcyelVFTGNaeXBFRTZnOU1lNXN0LzlrSThWVWt1?=
 =?utf-8?B?b3EwaFZsZDQ1Q2NDOEw5Y05KV3JUSVNFR20xR2MxZVRGWGpQajRtdVA0N0o2?=
 =?utf-8?B?K2c9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d22b6aef-6434-4f02-1acf-08dd71928322
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6325.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 03:00:24.0315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8uoILaLrJAmIu3zzvX9/xmvgc5oIap6oUT+E7FjpvkEnP9g/03vtefxKn1CU+MGlhi/2Bj6KCWznuMaIO+NL/wwNcRrwwTXev+Wu2sW1hQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4993
X-Proofpoint-ORIG-GUID: hVVVEXoFBiOL-Bkr0Uze7PqeMlvhXwe9
X-Authority-Analysis: v=2.4 cv=Tb2WtQQh c=1 sm=1 tr=0 ts=67eca84c cx=c_pps a=9T78G36u1E64A7MtQSounQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=H5OGdu5hBBwA:10 a=AavjGrmX96Td9qndra0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: hVVVEXoFBiOL-Bkr0Uze7PqeMlvhXwe9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_01,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=906 adultscore=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504020018


On 4/1/25 17:58, Greg KH wrote:
> We obviously can not take a patch for 6.1.y that is not already in
> 6.6.y, right?  Otherwise when you upgrade to the newer version you will
> have a regression.
>
> Please fix this up by sending the newer kernel backports first, and
> then, if they are accepted, send the older ones.  As it is, we can't
> take this series at all, sorry.


Got it, thanks for the clarification. I'll submit the backports for
the newer kernel(6.6.y) first, and follow up with the older ones
if they get accepted.



