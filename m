Return-Path: <stable+bounces-45410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7898C9218
	for <lists+stable@lfdr.de>; Sat, 18 May 2024 21:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240AB1C208F8
	for <lists+stable@lfdr.de>; Sat, 18 May 2024 19:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817AD26AFA;
	Sat, 18 May 2024 19:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ng0oxEhg"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50ACC2C8
	for <stable@vger.kernel.org>; Sat, 18 May 2024 19:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716060694; cv=fail; b=Q0dpTxCr2Z/UA55LmNzyKrxInC1r8NkFiGp48HYnjs/K0c8qHehz95IozwZ9N840DR1xCT45L1dPeEtWyFHrCgKpVVmcSAtobbdOC6l2BFFwHQ1XeCfYGrvKuO19d0CHfYSoyYZxRwP5eYsgNtDI82ta3BjZYooxPcb4vWbQnQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716060694; c=relaxed/simple;
	bh=EpmBlxvI2isL1AO/yKU92P5HDZdRyc7oSqCFPleSAHg=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=snvoQGoAGn+bs/6/3OeSSysOrmj2QHkGfRynArAS/GzgWQt93n1pCOxKf2weuycOu9eF7N7qyY/4ArsDGx1f+mvx5HRNgWUsFVrhuWMJ+8FoosOaxNdGsQJEQ4GssHMyqEvkuda0veMAkahuYvQPvYsNB8Z23H3907xdQxYo4eA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ng0oxEhg; arc=fail smtp.client-ip=40.107.212.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwqWhHeEE+GdHWZdv3tUnOAS/11ixV2GTEI6fmOhbYU15PfhdMUGszLd9a/ChMrip1uH+waWv7y0j+J1cb8BqJfSOGwkgdLiGp+5iffKww97Z05CDkkEeoQ2RNvJE5lWH2K/K5eKfmwffr2jHSzlBXwXYz7IpCGem6SkGL/D1je0YqHoLOLQPIAvmh05MlUx4q/nlrxsInB3LeaqOus/TAcEuK4W8XxSY6L/jZ38RhVsSODVaB84dT/4FshFpL8fjFTARJhlbj4cxSn+SZGEKbQhBPu/vzgNksqe/MTNl/AYjcqAeS1Zt+6Ft6YI4PpQbDXRLHPmavLA79+Vavk8ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euz0+kdX//UxDM29MY4DCP3Lw/nw6bEpxZZKALdOdCw=;
 b=Tecu8z6VAet8KEYfdxRtxfZikIoaqYcmhJrZelvuZrPzULXkxYxWdbgj7TIdTngnFBU2edvM0OA1jEx85XLEcePLtFCJrDRK2IkpHGbiOZ1QvJOKyOMcOlDWolS4RrCi7VqbFrDxe8bbTQlB0E9UJLoBEG5nkGZ9LzXT7LNhZZMNm2CHtE/0QauYbD0B18ZLHOwv4aRwurDvZdbNjyG8k7J+4/hGCUC8bIZFDx6dPmDQP8OMjsDjcN/Przl28JK1NaKIyX6z8OpBTZkgf9jsm4LwgsVC8UgWwduyE5+ZCc7k6Xa9EuB8YW4mFHn/R4kj+G1t7fVURXtcP4ezgh9Jxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euz0+kdX//UxDM29MY4DCP3Lw/nw6bEpxZZKALdOdCw=;
 b=ng0oxEhgaJarmkoK7/uPoPVyjoihiod7IIBxz6UCyvOIcL1/ehfa07+rovR8ZQ433nPYq2pLJCdFKYPt/Q1uP78LLrg45XJRYlxtLCA3FfzdzqXv+l2+2e47JzPJHfgBoYWwA2CO7gQ8xvGYE4HLNoLNg8nTN9d4BycRJG1Cbjo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Sat, 18 May
 2024 19:31:27 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7587.028; Sat, 18 May 2024
 19:31:27 +0000
Message-ID: <e1937591-708b-4fe9-a43c-2027ddc1c657@amd.com>
Date: Sat, 18 May 2024 14:31:24 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
Subject: DSC divide by zero solution
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0033.namprd05.prod.outlook.com (2603:10b6:610::46)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 144f7dff-be4f-4ae7-6570-08dc77711c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHBMRzV4N2xUbzZsNkpBV3VrZTVPNm9pdVRxK2FxMTNJcE1zZFphbUNFblpG?=
 =?utf-8?B?Mmh6K0VDRUNEWFZMZkdYeHlBdUJCS3U2MVdxSzBBZmV2SEY2SHYxYlZlVXFJ?=
 =?utf-8?B?dTE1NTlEL0w2ampPWDlucHVNdExHV2c5WHE1dTlqaUlpQVRsY2ZyaFAyN1F1?=
 =?utf-8?B?NzB6bjdmcXcyTGsyQlk5QlFPOGpHTURTZXpTaHY5bUs5M0dKZ1dhV2luVzMz?=
 =?utf-8?B?NW9hUVZodjRQYTB2d2ZkRkpQU0gvdVBzLzRXRjdFNGpYcGpaTmZYZzBxVFJ5?=
 =?utf-8?B?eFh5SGxMVzFQaTQ4TnB4L1NMVzMxZ0RYRWk5T3dHaEwxbjJOWlF2aWJydVpC?=
 =?utf-8?B?ODZPa3NyVytSd0tpQmxobWw5bWdwYUdSaVZWdVdqa1Vlb0pFRGhQOXBOSVkv?=
 =?utf-8?B?YUx5UDRMRVhHVnJrb3N1RWdWNGFCT1AyL2h6WEhQb0U0K0NWU3VUYURaYmlu?=
 =?utf-8?B?QzZZVlVLekU0TXVOUjhCbDIvczBLRnY4VkRGWVBBTzgrSE5mSWJ5a3dLbGdF?=
 =?utf-8?B?OVlXNEJsTkY4SzFFNTdmTHp3dGdQVkk3N1JFN1FFSG5aRjRwV3UzV3B2b3lG?=
 =?utf-8?B?UFBuZkEzakJGTE85UU1tK3JPNzJ2bjFyT3BkdGNEay80M1BDWUFDeTIxb3ZJ?=
 =?utf-8?B?NXh0ZURDZk9uMHhoaUVoMm5HWm1xMlZCWUpRT0JOa0pyTXJ5aXNFMnp3UlVP?=
 =?utf-8?B?eEVxMk9vQllYZGNxTVIxSCtmaDlUdit2d3RNbU9nNmhUeDVCMnRPb0xXRHRo?=
 =?utf-8?B?RFJ4UXBnK2RzMTJ3UlhhRXhBbVhPUncrMVZEeGRVbVB6Q3lNODRza0tQNGlS?=
 =?utf-8?B?ekpzaE1UQjR6alExaWVCSmR6YVE1NWl0bzFmRjAyZmRhRTU3UmI5S1BMU2k0?=
 =?utf-8?B?RTVtV0RUTUxIWkR4NVFWK2NKeTIzdTBGSFZvTkhhN2lvdDJCN3BydDF2d2o2?=
 =?utf-8?B?U0pMdUU2WTJCdi81cllqYXkyZmcxVGMwRk9tbGI5UnVPRldHTEtOMGorSkFY?=
 =?utf-8?B?MTNYSHpQcTRCcGtQNGVJK3VmZmllamZrb0xzWGczQjliQmdxSnFaUUVKckRa?=
 =?utf-8?B?YmlFSC9pdGt5bHVNZXByaWgxUlRqclZxOXpzbU1HdjRkdmNtN3pkamQ4alVF?=
 =?utf-8?B?a29XUEVpZGRDUVV6VE9zVTZ4aURVNnR1QXVoRERBdndDQjBGTzF5UWxwUUdD?=
 =?utf-8?B?QmpkdmJuME9GQjZUSHhMRDhDZTVOMFBjZDNzcWhMeVROTUR0MTQwWW0yaDJo?=
 =?utf-8?B?QVdXaUM3M1ZtS2pkVzFzZWJNN3RXTDM1ZVN0V3dsSkF5QnNFSERWb1dCTkVw?=
 =?utf-8?B?dFI0MURPd2I0T2xEWFh5QWE5c0pIaTRHbUJ5dUlvbHh4ZGdPeEZNaXBFZ1pE?=
 =?utf-8?B?US9YRG92aTVuL28yUzdnWjIyWTdEM2hoUEhlbzFkK016L0VOY0dXQXBXTGtp?=
 =?utf-8?B?cXlTZ1J6Zk9wQkdiV1FGdjYwMm1LSGRyMEo0WTRTWXAxL0V1bUhlcUo5eXNs?=
 =?utf-8?B?Ry90aHBlL3FBbk5EYmFCTU8xR0s0aXNjZUVYMHp3bDc0b0hEMGtGdXZWTTRl?=
 =?utf-8?B?YnZ2ZHpmYnVWalpCaWJPS1o5WGh6QWF4UkMrU29PaEtUVEdoRzN2YTNRTHJw?=
 =?utf-8?B?TkZ5cFFpSTBMZE1UMUdYb2c0SmJuS2lOVFVCeTlaUzJuM0dJZWtENGdXRXo2?=
 =?utf-8?B?OUt3ZVRVWktMWXZUY2VzVk1TRDZkbEtHTnR3VVozbnk2QWt2Wk1udm1BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REdCSDVveVlSVzBPRkViVGFuSGU2SngvZEdaQ0I3RVhFQ1VZMnVZWWx6TE44?=
 =?utf-8?B?R25WbzZJbHJHZ0xBck52VDgzQ29COVdURHdCQldZYlN5RDJTb2gwVi9TMk9s?=
 =?utf-8?B?eWhaNmYzNUI5UUdnTjMwVTRVZ3hUMGFlWlgrNHJWZFEyUEFYNVFNZzhKcUp0?=
 =?utf-8?B?SUhkZFY3djkwa085WXZ4Q2VZTi9jWmJBWFBtQXVpaFUzdFpGSnZsRUVmSUk2?=
 =?utf-8?B?NklpMHZSVVRSdGxmeUJoOUc4M0dZcGlVcStoWm5HQUZpYkJMN1gxb282SHFL?=
 =?utf-8?B?KzZWcmdXbkxvMGtXNlJSaFhIeWRzMWhZeXF0YjlDT2VUUWJocGtMd3E1ZHRM?=
 =?utf-8?B?VjJHUWorbDB1eE03SVlSQW8vRG5qellZbDlvblhZVkpWbWhYUmdTOHFhZzFw?=
 =?utf-8?B?ZXhja1VYTi9KL21kc0htWnZSK3FHVnFmRW5lZmRhbWhWZGdmZXZyeHR1K29E?=
 =?utf-8?B?NS9aV0dDOGtlekVwNTQ2QTRlVklkK3J5MFlTMGdTa3JkcGlqTWlRdWNiS2V0?=
 =?utf-8?B?dHNYb3ZZak9tamtYOS8ra3ptQ0ZpK2xYemFoeGN5b3hNVVBTOGNBNmRyMHZh?=
 =?utf-8?B?RThZNXVKaTBod2l3TmtTeU05WTJleFBoUHlxSWJHU3U5cndPVEZWQ0xrV0FE?=
 =?utf-8?B?NzBVK1piLzBGeno3SFladkhmRE0wQWUzT3RBUFBtMkJZUE1JTUxmWjRKK0RL?=
 =?utf-8?B?anpmOW9DdEZGNTZ3QlVueDB1aEFMUU1SajVYNjhSS1pOemowS3p5d0hFT3VZ?=
 =?utf-8?B?MVpRTFdpYWViTkN5MlordUdhNGdnOFZPUEptd3ZGVDRqcVBRTEd1ckRjWnhu?=
 =?utf-8?B?ZG5wUU9VSWFyM1RNNXRaWllSRHFDMjA0VU1ZUzh2QWd0bkJEenh5eEl6Unhy?=
 =?utf-8?B?Z0lraWwwNnJ6T1I1Y0dpN3JTbWxuMm9DSlZtend1czdwTEhEMEV4RUhRRHZr?=
 =?utf-8?B?WTV2OGE1ZTBIV3ZaazlYbXlBbVlNVXZiM2QrbFV5cVdGc3hxK2V2b281S1R3?=
 =?utf-8?B?dGM3MWdteDJkUCtNZnBCck1XUHhHMkc4clVEY2FUMVI0bXZUNXdGVzB4Tm1B?=
 =?utf-8?B?bit4L0VuT0VMYTgwQWlQMGlCVmhnT1NsdTM0ckRRbHF2S011TkhFSUlLSHJa?=
 =?utf-8?B?RkVUV3Bwcld4aHFUcGNVWnE1WUVzSGpwQ0QzYXhJN21HTmRKa2FiM2liOGhS?=
 =?utf-8?B?R0ZrRmIvQjRQbjZpUXJTNFVsVHlRc0NhMHJUMll2VGZ2MFFXNWhoblZhaDZO?=
 =?utf-8?B?aTRrWDl1MXFIdjhuc3lUYmZtM1BIYzE1bWNBSkZidVNvUVlrakExNzhPbG03?=
 =?utf-8?B?bXlkNWNucWlMTE9HS0d0NEZtcTVuZ3VuRGtmNlBUN0FtL1ZyeFh6ZTBpZjU5?=
 =?utf-8?B?QTU1ZHkvVElNT0R6N0xKd1ArTk5mRjJoQnVhbTRsZEFLODZHZ1ZoRXpSTG5P?=
 =?utf-8?B?L1JFa21DMC9EdGozWHh5czJ4THpZdjlZWi9Sbkk2VHEyTjI1Y01BWkhta000?=
 =?utf-8?B?NXEzbXNQdktzODlXT0Z0UCtTWityMFBBK2xlMHZ3bmdZdlZxa29UU21SRVhN?=
 =?utf-8?B?TldlQWxlQkpBS3g4NU0wc0VrZzB0L0NIejFQaVBWdUZVY2pQaStZdEZ1ZndO?=
 =?utf-8?B?K0ZCTTFFVDRIR3Q3SUF5UURSa0UzdnNlYTlPZVZBQ1I4VkJMdlRoMlpKTHYx?=
 =?utf-8?B?dWdMaTd1SkZKUkNrVVM1TlBSMlFxTFdLV1poQ0hDeGIySmhQdU1VbzVuYlJz?=
 =?utf-8?B?VVBhR0ZZc081NEppd1QxZlVVcElUZDJxZHJQUHJFSlQvQ082OWhZRTNmUWhC?=
 =?utf-8?B?UHlVTHQzVWNMK0c5YlkyNXdkMlgzSVpEbVI1bHdvYlo1WUMrRkNoZmFuQ0F6?=
 =?utf-8?B?UHRFMkF0YXM5UW1ZUWlESnl3RldEOTJPdjJJREd4VlNLd1ZoWnhadmRSN2pV?=
 =?utf-8?B?a0l4R3JESGxSZ2NYdXRxNW52RGh3UVl1bmhQdGQrSy9IcEFTSWN6UUJyVUhz?=
 =?utf-8?B?NnA4ekIxUnBweGhrQU5xRmkzaHNBK2Z3L0RuQmFYQ3BvWUUyT0V6YVZ5djlL?=
 =?utf-8?B?bnFqNlJEQWpwQmpRbElraTRxWlA0UU5JNHB2bU5pUW9wU2Q0Rzk3QWtmR3R5?=
 =?utf-8?Q?9OVzu8LCoXySWXksmffPzyetf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 144f7dff-be4f-4ae7-6570-08dc77711c65
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2024 19:31:27.6073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZLImbmmmTaku6J3N6loTYMxmJpOKOijmJtL7/VxfnQYMuO9XOUq+Zah00XB37eagBjMh5qujyVcbdRbOuMahQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

Hi,

In some monitors with DSC a divide by zero has been reported and fixed 
in 6.10 by this commit.

130afc8a8861 ("drm/amd/display: Fix division by zero in setup_dsc_config")

Can you please bring it back to 5.15.y+?

Thanks,

