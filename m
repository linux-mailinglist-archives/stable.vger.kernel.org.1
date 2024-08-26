Return-Path: <stable+bounces-70250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA9795F5AD
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 17:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44EF52834D0
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 15:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF92C19408C;
	Mon, 26 Aug 2024 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gILgF3YG"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E104F215
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687782; cv=fail; b=UgEFMKlnuZwl+aOebJdaOWMXVfFNueazmirTsJJ6GFsGEvtF4gU02OFQSqEu8wjujChdET6nbTF2EltxEhy7EXXNa7q1WN44bd804KmmWvrBxV0J+XAB2cuNbCS6qa+nnVQRcFyZEERVUGuU0bq7sO0g9QqRw/TA5rY12F4rLaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687782; c=relaxed/simple;
	bh=chxwIdMmDro8kStkStyHMfkP3Piuw/rUfKlYwILhNLk=;
	h=Message-ID:Date:To:From:Subject:Cc:Content-Type:MIME-Version; b=G3D6kWUlJHq2/pBCX0iVjOBNGgOcoW0tYcGy52kjOFmmGJYkkLAEzRLg8D0lHCueG2HvMjMlkSyJYkYUejakjyFwzIN0PtTRQNOMFLmZMuKJWdsk7pz4hnH1FLV/PvkM0eRGBHkymoEpTpWJzDs/Mo1VQNBfHNgLIrujsbk3tiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gILgF3YG; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKBjeFcgEJB95OF3Ybqbn0CpU8QGHd2IayIOJUQOolWmNMxfwpeJsjWLSYj3QaKkH/XdmatKxvLO0EIdk8pS7LIb2UKIvVDjR7DYGYZ+lQbN/a22LyIZsLHrZJqkRSy8XUYrkzKerJeS5Dg1k5i2KuEE8WHshbzXKIYaFV6JAsESMl67C+RBFV//Gy+gsWt5U7goWCNwhUrLtvTgrjv/oJxTWkIISraio4Ysaf/lLtpLHyrr6UcMrUxGygBDzw/sICuey2WW6VSURXxNv3MKec53ChxDTE+VKIZGJAoqx3zoKjvbyloM2AFurY4JENvH/3YKm+n8HbNLtywfQfb/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSpMnS/Y+7AuH5Y5ZupdhC9JkjXcsWlMozzKKNgIn7I=;
 b=hLI+cA62CrL+LY4MHOG0Abh2+cdVJjR36J6kMVloSskzEmiQvR60gf1znZ9MDLXHW+nJBsPa9Ztmwp1Ehlhmd8k3AuPDVcqB+3M7u1EYU/b6FWlTzX8G0Jm+Oi5pkaye5pathQfbjPstevJY40G2XYzUAxlvBmIQANKqC17xfxS+BHOZG04GeKmuNpwfxdM3yG/AVZNiGfsZOy9G+KU34M2fZTpdKlY1CZJX37O6J4aa3ko7Qg14t6Sq+8AqR6IDe0q4oB5YWMPX48js8P3IU9dFgBDhg9e3a/8AgJKQu7JUlMzt/GVtl0eG4hltW2XcwXVsnFudWrNCuqqVq4aQSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSpMnS/Y+7AuH5Y5ZupdhC9JkjXcsWlMozzKKNgIn7I=;
 b=gILgF3YG+3KsPcPRbXNN68ehRWd3vFChIE9gmx7SfnoEj2zoIv9QEKdeWvYAE2dpO5HlYRJwzi5Rn0OsIEpSMd0pjFZ3uoSnUkLsykrzDAMqvdFrw2+ABCWanoImnsfclD9ofrt6L+p73FYx4ro90+VOQ+hSujIsbzd8JbBoFJ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4271.namprd12.prod.outlook.com (2603:10b6:208:1d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 15:56:17 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Mon, 26 Aug 2024
 15:56:17 +0000
Message-ID: <0cc223ce-5350-4780-94d5-513079531cc4@amd.com>
Date: Mon, 26 Aug 2024 10:56:15 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: VCN power consumption improvement for 6.10.y
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4271:EE_
X-MS-Office365-Filtering-Correlation-Id: 988e74ad-2e36-4031-56ce-08dcc5e79e92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2ZqT0hMRlpkd05LRlllNGFwSkJKUUQ3Nm0zL2xEREhIbERZZ3VIYU9vbDcx?=
 =?utf-8?B?VHd0NDJBZ29mOGEzODZFRDVCOXY1L3NuZTFBOC8yR1k0NWcvckp5dG5YWUVE?=
 =?utf-8?B?c2I3V2lOendTZlVFYlE0U0dSVmtUSlVIR1dwcGtLRUNzN29TaGJZd2FBQzJo?=
 =?utf-8?B?S1Z4NnQ2d21XSTcyaS9jUzdzV1BYbnNKRlRmTmJ0dHB1L2tMTktRQ3VKSk54?=
 =?utf-8?B?SHVzTisxejh0OTFJSnBESzFLdU5xOWg2aTQzbnQrL1hNT0d0MDd6d0dMZmd6?=
 =?utf-8?B?RkkwZk8vc1Ayekg4STBucnJnZUNCMzF1RmZRM2pHeUlIK0l2b0gxcDY0VDYr?=
 =?utf-8?B?d0t5SkJBMHJGTkZFNm9oSDNOdEY0QUJ1S1JBSUo1MmNWN2pXSEJRaEplWXdn?=
 =?utf-8?B?VUdtckVpSGs0dVJSMmJNQkVIZXRXZXJmRHhrR0FEcnV0YjlLYjI2bW9VT3BV?=
 =?utf-8?B?L1BiVGZtaTQ3RFNtd3IvNUdiaEIzTEpVZmxwbnpZUFU5YVFzRjZ2NWRwUHgr?=
 =?utf-8?B?bmIwTXJIa1NYbk5scHlnbDh4R2ZvSkJhSWVmM0FZUldXN1hzMWZSSHdDRlFQ?=
 =?utf-8?B?NVVrbitENnFsdGEwaFRtb050R1A3YjFtMVJCSzVibk95WWVGYVozTHhmTTRy?=
 =?utf-8?B?YWdjYWppRll3T0JZRnVZaTE2KzBEWFpDR1p0bFZDQzRUcE43MDkzL1d1Y3lx?=
 =?utf-8?B?WjlrQXNhWjdLSmN3dXhLN2lYWFJyTWpXUXFMQVZURWhvUTdLRVBsRUVzVSt6?=
 =?utf-8?B?cDJ3dkhoVGhlclhWcjZ3VHIvOEVEZGFrQU0xNFRnZFhUc3MxS3NveUVYYTFU?=
 =?utf-8?B?T0lkd0N4S0owakZQYVhrSmRVTFp3WkVXdnF3Q3hkSXc0VkloZ1V0bEFKZ3NP?=
 =?utf-8?B?ZW5DNDRBWm1EbWZNR2ptNTh1bTg3MEMzOFE3ZlBCM2NtZmVWS21QamFHcFVK?=
 =?utf-8?B?VFdyY3FBci9vK2hLNjdBN05MaXowMDZ0K0JqeldKdnVmWGZxRW0rUkhMUTRh?=
 =?utf-8?B?QnNCSkNDdjVLa042NkhyZnNIdi83M2d0OVNiWitVTXdnSjBiZ3hNaFZrMFB5?=
 =?utf-8?B?RXJ2S3JsVXpFN2lLTGVXZ3gyQ3lWM2cxc2xxYisrc3ZiUHlGWUR0R2JmaGJS?=
 =?utf-8?B?Y3RZcFA3VlF4OGFkc21WclEwU0dLTUE4MWpEN3ZKanM5cTZXdHlad1NmZTRL?=
 =?utf-8?B?Ym1CNld0TUxGSlpWS3NaUm9qalUxOVREUllYWDFORlBZTFJiNUNEblNsUHdj?=
 =?utf-8?B?MkJVZ25nQ0xxU25qYVJETGIwV1BzVEN4SDdtMHRtVk1mWUxnRm1FcHZqeWNI?=
 =?utf-8?B?cXpVdWhuMnFvdkZKU3FjV2xDRjVVbm5SZVFmaUc2Qnl0NU1DSk1ZTTBCdkY1?=
 =?utf-8?B?Y2V6TTJQUDZtbGFNdHl0YlZxRkFLdWFJdm1IOUJKemZ5MmswVkVBNWZSRTZG?=
 =?utf-8?B?VlJxTmNBbEpIN2UycEpRSityT2tucUxrWnZnaHF3alRlZkEzdTJwUDV1WWpS?=
 =?utf-8?B?TmZnOXlVUElwaEloTUNhby9xMHJtSlJLTU15bHFXU0NLb3NweGRNTnJDN0oy?=
 =?utf-8?B?a1hNaXo4aWJlU0F5azdoc0pQOHVjNERxRWowUWRrZCtyb01FWStwMWVZSVBN?=
 =?utf-8?B?RkpORFpHNnhWT0RBNHcwNXBxUUlqeVlvWnFFMk1rUERvTHpwQkVTMGpaaFdW?=
 =?utf-8?B?OHliZXVkcFBHNDhIUXJka0gzSWFieFNzY2RnQ25BTmlIS1BPTUx3M3U3aFRx?=
 =?utf-8?B?RVV5R3dDUWxoNndIc2UzWDRUWkJKS0hidnJ1aU9ORmNpZHNNS002WVJ3cUsv?=
 =?utf-8?B?K3RoWVpuUVUxb29HNlNGZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEFheW5HVEN4UStkM2pRTWxHUGFTc3Q3TlJuc1JZMU5TSkY1akhHcllqNUV2?=
 =?utf-8?B?Z25DYXVQTThFbCtaTHIwdFZ6Y3ZoekRBWDA4VHZ2aDlBOEE5cHNXaWpySWdj?=
 =?utf-8?B?dkpHYjZIa21uSU95ZS9Na3g0YXE5ZGVqRmRobnZNVG1mMktsd3lEOFUwcjYr?=
 =?utf-8?B?M3NjK0NWQk1ZTmpKVHNnVVFpTXB2ZkZQUDhWS0txNXp3NDVnSngrdDZiaGV2?=
 =?utf-8?B?WGRDWkFWMUtVcDBmdTNVSis1Z1dqYUhlWFFkZjBYOWc5REprbXR6cnYrNU5F?=
 =?utf-8?B?Ny9YWDM3NzI4OHZXRE81a1lzNTVNcDByVENOL3F1cmNET3lyU1ZRcTRTUm92?=
 =?utf-8?B?ZWk5WWI2Z09lRU5XNHpzeTI4MVlYTVBzZUswWk9kRGFFRUpJMEtMRDkzRC8r?=
 =?utf-8?B?UHRrVGh5WWdBSGJHN3dWQVhqb3dTbnVKYUIzdjFzWGxxa0d5dC93aXg4TGVH?=
 =?utf-8?B?STl3WjhuR3FrZHRqK0dLTmpYWVVhVzJJSWlBVm5oV0plQUhKajM2QmJ5a013?=
 =?utf-8?B?LzR3aTVaeDI5d0x3NGd4WjNWN2FoYk9wQWwwMWdZeTBKaWdlampCSk5qeVVC?=
 =?utf-8?B?aVVVUThRZGJXblcyZjFOVjVlUGxnVkNFTXVMaXdxQ0JFVHM5YVB6MTE5MFZw?=
 =?utf-8?B?TWhOdThBd2szZmFsNHFLV1VXejdmMEpTb243WGE3eGhYSmdoM2NFaXJZMVo4?=
 =?utf-8?B?ZERUSFN5bjQybEM2T3k4cXRvVXlsZWZDcklRTjJCR0t1MW1hR3ZjdUg3Z1RK?=
 =?utf-8?B?WHZZZHgyUWxBTWR1UlFHSmpBeEwyZEpUUHExQzVsbTc1WE1RQ3llYVFrZ2ho?=
 =?utf-8?B?cW5xa3p3cGlpNEpITStjd3pwc2xvMFNUa0xSeUNyeGFJUWJ5YmxRcURSaDZT?=
 =?utf-8?B?Rk1jRzhSNTFuWjdIK2JTOHVCMmxSV0JxaWFXcWh1dS9ZVHRZd3lyRnh6cU5I?=
 =?utf-8?B?ZHRaejhZQmxWT0pIYW1DeklyYkhmQUFzYnNLNmRuczBwSGUxekVGaEVlTjF4?=
 =?utf-8?B?Q05sbmsvajkwR2ZRL0h4d0dEZzlNMzNyN0gwdmVhVVl3ditpMk9UQm1DMng2?=
 =?utf-8?B?WjJ4elRxZGZSSi9vMzZCVGF3VktYc0JlSWtpT3VXL2VRVGZjblJFU2ZVZjVC?=
 =?utf-8?B?K3NZSk12SlVEYlNoT0g5MGlhck9pNVBvMGZ5NFpRWUJCRS9HYWxuMmhOcnI4?=
 =?utf-8?B?Q3pIUTFlWjN0ekZ6aCsrWGVzTzFiVWFsYUFGd21yY1BLNjJ3SjFmbEZ4RStl?=
 =?utf-8?B?bDI5WVkxTXhEQm5ubUtDaTE2eUhscm45blpzWkpQWTBmODl5cmtTK0ZPVita?=
 =?utf-8?B?TFhaUCtiUkh4QitBREMxbjVRNWRYWEh1RjczbTJqMjBYd09wS3IvTmpiNC9o?=
 =?utf-8?B?WkFMUXExRnkxL0l2VWZyZHkyMGlyN29yZ08rdUE3OEFRdERxMjhrMU1PYU02?=
 =?utf-8?B?eFU4SllPTGxPODBkcmI4RkZmMHZ3YnF5ZGRIVVZFSzJ5a2ppUmF6dnVXOWJS?=
 =?utf-8?B?ZEMvd05Fa1JibGoxZ1NMaytHU0dudGxBNDkxZ3ZpRG1ub0ZyRXFRYkthWUQr?=
 =?utf-8?B?M0RUSlF3RmExVTRQQnlORnRubFNNR25POEVpWkFuVU1XQjRiUnZqRVYwUzdk?=
 =?utf-8?B?M2plcisvSVhPUmFiUUttamk1VGI4cThVMjdseXYwSDdJVUFFb3lOaHU0SGRJ?=
 =?utf-8?B?dXJJL1NqU3M1TlB1ZFdYOUs2bXFmc2U0cU1TZDRWZWlnNWYyMXN1RTJjNis3?=
 =?utf-8?B?MUdFM1F6eTBFSWloZUlrZmJORjZQWjJYbGNWWGdBWWpVVWsra3ZvWFRTOHEz?=
 =?utf-8?B?cEErQzBUUDJZd2tDQVJCdlNWTlNkT2dmL2xINkFMalRYbkhMdnJPKzQzOVRo?=
 =?utf-8?B?WTVHREY0cDJKb0ViaGY1ZVNkRkQyTzlCbzBwR21aT09hWkM1d0VIYUlZeFZj?=
 =?utf-8?B?aWNISG5iVm93dEhoNG5lMHZ1THpMZUFGMzJmQjdKN3hGdTdSdlZxVnBSdGw5?=
 =?utf-8?B?WklwY3lscmpVMk13T0g0a0I4Zjlqd3ZOakdJV1NydThsdlpTckhGeEt0M2Mw?=
 =?utf-8?B?YWEzYmEzOFVyMXRLb3crdXpzbkVjUEVEMFZSQUZMcXI4YmZ2V3IzZzJHSEZV?=
 =?utf-8?Q?aOJ2qUExlgnp8wxFjcyZHRtX4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988e74ad-2e36-4031-56ce-08dcc5e79e92
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 15:56:17.0090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1z2ueTPNE/4jnfR2jKAvyqKQ8faGEkWcQeSJTPUDH+Xi/hQA0FbbD2FimXUTY4pfWD+tpT6RbIEXfPyrdrPjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4271

Hi,

The following patches in 6.11-rc1 help VCN power consumption on a lot of 
modern products.  Can we please take then to 6.10.y so more people can 
get the power savings?

commit ecfa23c8df7e ("drm/amdgpu/vcn: identify unified queue in sw init")
commit 7d75ef3736a0 ("drm/amdgpu/vcn: not pause dpg for unified queue")

I've also sent out backports to both 6.6.y and 6.1.y separately.

Thanks!

