Return-Path: <stable+bounces-33072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514B888FD45
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 11:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC50AB22E04
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 10:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645257CF34;
	Thu, 28 Mar 2024 10:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CR7kpwJZ"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7916C53818;
	Thu, 28 Mar 2024 10:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711622453; cv=fail; b=aLYYdhSnqI6ECDs2oNu+7lzEQCzpopLBaZmsJM1LldsDNVF21zYE+3nihEjsoRn2yBIQVgs+3BrHxiDkLMXLJBZ4w+TdFRnWe41UOVA8V3xQOkENNnjVOgMrQxL3AwgK3GBpQAsUL8e1UfUA3RJ1yu+t+u/FTqTAR/4sHXw6bJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711622453; c=relaxed/simple;
	bh=Bu0HWQCpxJRRXTjDLKJzfr9emLTN0ClaSU07PiZWnWQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gcRDWpU+YR/4Ocrn/XFQXucGNYB8lyubDAN7KB6wqE1vajpfo7zGA52fnqLIY+VcbswVVbJE76AzlSvyyCK6pU5zjQ7iCnOTBG/VwjH1NzOUgaAYM5k9jYWVwmeQeFSVCTFsrUyoKPeD9KX044VkIFI3Fcigi9e6QpxZbID3Jpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CR7kpwJZ; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMzbp2vmtIAtpupqN/sfRG60X/lvlzM9ggmBXuV12FKmdfsQHHmvVUL4jSMdfvkx/yq1MZVXvwvp3vVpWQDCbtuzFbH8hOf89o00oV8AHQlqcAf5A4UBbnNKE1M5ua14YhP4KEwEkNp0NkoAiAIpk+BlTgMRz178EgCJOxA5tEkJ4+RNXj4zhdb3Vd1mA/uzoB65lqrwNE0K9nXIqad0iza368blpmmsCnB7UE45TebTYxdgrwKK18Gl263bSGnDUivVxE78LorfmeE4DeAJV9zK+bpWEaXlMylFHUM7qJaVp3GVKXM9bvWXn/45vzz3WI7T82M/U2H8hkzOUKsJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbpqGgcT2X/SZ0AikHLynE/TbnuDV2LmUPpJTXk5YD0=;
 b=E8VNdZuw6JgcyC8yRffg7nKcKS8bNBsEMNp4G1W3me/iXYuut4LFXAR2Uw4JxhPduHF2xpI8CgvRkgJXW1fq0/eeOnnW04VMtLp++M0eQd3XEGoyzGpzJaNrZihxLbyXchGjcrsjL7e9l1c6EQ1jvg1qitg2ac6I9up3K3CCFiPVLSMNM47+0aVBECIS6IOP/ABCNX395Ab6TZYuVe9lCkrM/UduuhZU5iE9RrP9FGHfp5I1AN1eBzbm3c/8RfZzEPezgQvpFfi2D1kb0iaDUBg+7bxDemjVWQ5KtPkMkfv7m9YUq7ljwFYFI2VPZKYP5oS7ySYao03xfuS46/MO4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbpqGgcT2X/SZ0AikHLynE/TbnuDV2LmUPpJTXk5YD0=;
 b=CR7kpwJZqHCIvbVCP8e7BwMXifVAO3423FCp+0HXRv9yRM+NydKTFZRdszvZHhJtg3XclAZAozNPEzbOGsYYRMRbpCkPf04741546dGZIfa+fJKJjZnqC76baZ3nIiTmvvU4pDCiXF8fjHo1S22Dq2AMRQceeeIN60wHQIpo86k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DM4PR12MB8521.namprd12.prod.outlook.com (2603:10b6:8:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 10:40:47 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::57a8:313:6bf6:ccb3]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::57a8:313:6bf6:ccb3%3]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 10:40:46 +0000
Message-ID: <465c52a1-2f61-4585-9622-80b8a30c715a@amd.com>
Date: Thu, 28 Mar 2024 16:10:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Revert "ASoC: amd: yc: add new YC platform variant
 (0x63) support"
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>,
 Luca Stefani <luca.stefani.ge1@gmail.com>, Sasha Levin <sashal@kernel.org>
Cc: Jiawei Wang <me@jwang.link>, Mark Brown <broonie@kernel.org>,
 linux-sound@vger.kernel.org, stable@vger.kernel.org
References: <20240312023326.224504-1-me@jwang.link>
 <bc0c1a15-ba31-44ba-85be-273147472240@gmail.com>
 <2024032722-transpose-unable-65d0@gregkh>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <2024032722-transpose-unable-65d0@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::15) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|DM4PR12MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: e67f4b41-835a-4b17-7584-08dc4f1386b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hsAYxIogHvgDM+zkDI5aoyzphVtJhE+Zw+ahCv3sfqgqMov4TzBqbXAleZyPV+jKJ+MIYUlHQ/jPkEe84EEGGjE+igUFrWDO08vbRVOgWquT0b5Yzy+2z1ljM2ddjh1fRZ/hK56mOA9l8NgoY335EZfw17cwdu2rsCJbFG91KgXIUTlWDObMGWHti0jdwrk75mLohikwNN9xEfX7U0gcgAVsA6RhY3+Tqoa06sizvueel93qA5CAmV5DL3RY0m6HBS3+klKGyQRo8gwTfXJGWwi/DSZJnoK9sZRhJWaqOXyUvqxbvyzeNrVY0cOA7A6FG8Msjnm4gpnU/y3RM6AUSGD1cSybcj1096dUqVLeZdYEt0qZ7yv0n5VuZa3Livhf0At1FOpM6UYRAxANpIaMV+aIz7czmoT44PzP/UbrMBjzgiBpTCNReb3myHYB7TgZw2HyGrtFuY/T6QidZrDNkRd/4abkh/3Xdx4Dvk0VyaCkUR1C2O9GAjg6FIoAUzPo1XW88IWmy6jpqTF/lwyU1G5IfRAqC7/ojv31HXxTXiu6gJo9aWDu2nYM/mcGuazRC5g7pznjJd6416gPuz7rr7oFA4vUt52iauJrTqGF9Bny4Lwp3isGJZgTwtQxxHYhAHnQHcVmVf4KxBmcyhKsJ5IVCdYrA8lQ9bKfgiEp3uE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dW9qRE1FQ1hQWjJRUzJnSG5wTVRRRkJnQW0vSTEyVSszdDlpanlOajVUcmk0?=
 =?utf-8?B?SFFjNXFwOW1VaDE1MmQxOVlQaEo3cE90TEdmbng0UFBmcCtla21vZis5Z0dL?=
 =?utf-8?B?a1FGdmdDenlRaWNNRWp1dms0ZURNTEFQSDkyeTUvVUpub2QwbnU0bkhvTXA1?=
 =?utf-8?B?bnpaM0pnd1pURmd2QUhVMTNWZVdpaWV1SUxaU2VPaFpnbFJKKzIrZGo5M1VT?=
 =?utf-8?B?d3VaZjB3QkFlUXJKNHZXQTlqRU9vK0tVY09QK3RNUmthZys5dzJqV2liSkRB?=
 =?utf-8?B?S2xGRHNYbldpYmdoZ2ZoZnZ1cnJEbGUvOHlGbm4vSGZyWUw5R0JscDJrRmZu?=
 =?utf-8?B?MVF5RDVsZ1FXRWhxSFJaU1gwdXBocUFRMzVQNExjYnpidTFYSnVNV3ZkcGJC?=
 =?utf-8?B?cWZyMzN6THBDZGN2TWQzMlIyeTFTRzNIMC93ZlBoVzdTbHc1aGJjNitGdlRY?=
 =?utf-8?B?by9JVmhmdXIvKzFRNCtGamZ1MVRCelpib0hSUUZ0R1Q2T2M5VWpRRnByVnJE?=
 =?utf-8?B?cTNBOVBaVkNDRXNZckMvQTk4VHplTktDYTMyWE5CMlUrWVRDV243dHpWWWQv?=
 =?utf-8?B?WUZRamFVZXBJVm1MYk9sNHBQUnNGOVF6VW80VkxnYTlGdDRycnpKVXBheVUr?=
 =?utf-8?B?R1BKQWRka0RUQ1ZoeUdCQzBqZFlXeTNQVk5QdnFHU1BXNXNWZVFBazBZRjdw?=
 =?utf-8?B?RUsyYXFFUjljL29QZkJvU0lUVEt2ckxqWmpUVUhMcWZaZElnNGJWWHdyM2F2?=
 =?utf-8?B?NFFKbVJaWXlMM3ZqdUExaFNySTB6SFJ4Q3NhQUUwamlKUm9COXd6MkJQTU1s?=
 =?utf-8?B?cVIybjJqbU9PdTByTnJmOGZjSTE5cWVRaFEzTzkzRjFFZytuT2gxa2dLVm5P?=
 =?utf-8?B?U3hQL00yVlBYVkpuMUZmWEdYYzVReFlxV3RwNFpQdS9pNFY0anNKNzArTDdR?=
 =?utf-8?B?VlkxdHJhY05hWkNwQ2Z6cW9IdDEyMStwYXFvYmRRdU1TZG5zTEgzMy9GeTJz?=
 =?utf-8?B?WEtPN1BqR2ZHVnA0YnB5VWNCKythcXBQdFpBVFIrUlo3dzg1ejYzQ2NIdGlQ?=
 =?utf-8?B?Y3c0U0pPN0tsbG9pbEZSbFFJdTBpbEZVU3ZSRjZGdy9CamswRGR5VzBpeWpS?=
 =?utf-8?B?eEhoK0N0OG84Z1NoTU42WVp3RzNKbmV2SitvTVM4SkM0VjNCS1hNMWJ3aUFu?=
 =?utf-8?B?dy9jMEpqZU9NbzBwQzMyYmxJaFFKVzhSeGlKd3RUMExkN3JNeGpMOGtJZzlq?=
 =?utf-8?B?VE1icmhobEhoazR6NjdZWEFzOGFuU0x1aE5JZEdWWmRIVnk4NGo4MGxoM0NW?=
 =?utf-8?B?Ri96N2Noa2RNQU9SSHJXMy9NbTQ4VGRnNndYTEFpRVIydTZtaVc2MU9rQTVu?=
 =?utf-8?B?cFFIbG50M0RIbmFZK1lmWFZUeXh1dDJtd2JxeWNDaVZ6NEVqTHJTUXIvd3Vo?=
 =?utf-8?B?RXVINHprdW03bEVYUVUwQVAycmNHc0RZR3hVMGdWb2FyVGpTUFhEWmdEajND?=
 =?utf-8?B?ZWdRTlVDOXBQMFRXZndITzBiWTZOR2VCcFU3NGpIdERxRjRXOExrSEJTaWUx?=
 =?utf-8?B?Zkk3QVREWVQzN0JKWCtRNUIvRElWNm9SMnR5V2Y1TUdVVzIrT2hPK3ZWQWcv?=
 =?utf-8?B?WVhWL2hwV0NqeWZoMnBVYXBpUlAyd3ZuVVRYNEhVbXA5SlhJa0NGNjcwYm5o?=
 =?utf-8?B?MnQzWGJVcXI2QUFobm1zbzRzamZkdGI2T2VNc1NpSExHOS9xd1dVdk82UG5V?=
 =?utf-8?B?bTFJMk1qVzV3MU81T05LSytGNjZIS0cyK25tWHBKOStHNW52dnpORzg0OWhy?=
 =?utf-8?B?UmZTU2VDY2N6dVlwQTVVd3FocjFrMU9OdGY5Ujk5Zk0reVdQZXlsaEVJWTVV?=
 =?utf-8?B?UjJHT2lVT3p6UVN3Y3VxTE8remJxMWFwL0pBU0FnZUhrczVoWUZpS3JQS1Rv?=
 =?utf-8?B?TUFOWWQycXNHTWwxNGxYSEhyNUJOWHJBLzBGK2tEbGVTQ01lYmkrMUdLdmhq?=
 =?utf-8?B?eEozUFFtaTRveHFkRXBMT3hpUzlHOWVYdTBvcFRLSkx5VHlCTTlHZnlYUUwy?=
 =?utf-8?B?Sm5MWGlNMjBzVFA3d1BDWlpZUmtqeHdJOS90U2JJM2RpbWR4akluWDhERjJP?=
 =?utf-8?Q?mGxY3N172boqTbkV3y3XZMpkc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e67f4b41-835a-4b17-7584-08dc4f1386b4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 10:40:46.8861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1P/+2W4You1yOTMaWBYzk3Gr/7dNw3/JCboWThxuRaSIIF55ONxvfViYu/x/Fd1lglQPih2/U6t/fI6gVB0Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8521

On 27/03/24 23:39, Greg KH wrote:
> On Wed, Mar 27, 2024 at 06:56:18PM +0100, Luca Stefani wrote:
>> Hello everyone,
>>
>> Can those changes be pulled in stable? They're currently breaking mic input
>> on my 21K9CTO1WW, ThinkPad P16s Gen 2, and probably more devices in the
>> wild.
>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
>
> </formletter>
These patches already got merged in V6.9-rc1 release.
Need to be cherry-picked for stable release.

