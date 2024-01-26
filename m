Return-Path: <stable+bounces-15893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3602C83DDD6
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 16:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3FFD1F238A6
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 15:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A651CF99;
	Fri, 26 Jan 2024 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1Fyyw2pk"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5781D528
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283812; cv=fail; b=nWr2xwdnN8ZDhjyxh0I23Wqkfo09bsm/uPdLLskDOv5mJOCzCcJth9huJxOVv5BBMsCaa2ECZP7V3I10fIR2HnzmsMDCXT3+LJFBewAE8pcCWS2bjrfn66oY9ROADH6KOFdbH5epA4AsPyjcZhsdjdShB9qwMdHYvNs7xVEWD6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283812; c=relaxed/simple;
	bh=CXHdn/2ULAs9EU88Ssb9IiYs3IewRMSUejMb1KZb2Vk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RJ8rvlYyZpEprMCfwRqSNpJ+keaNIeY2fe5oecEr9gTZNwV+S2uSZptqnEqOCxmC8I1WNn7u3jFLqD58+LOpmVA1BACKLDBqCqmm5NCFREalAaz0lCDRHWhKeXUcUyuOeVUgRop/PL77rf+925JjYBVXbzdVNXo7EGxP0H6O7+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1Fyyw2pk; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+9tbpkin7T/SBZhUUZq9h32+JQniEBD65pizcSEhQxpJPMGN6/jjZBRelfgAtvsWZs3iH/Qx5J/Uj5JRWnM708+gvzgDxROza978eS4AvweRK5dUhC53xxhm2xHT8Z0qApt9c4I/SDV8A5i/T6qQVLwut2yVrrln3Tj9ljy9MfWxBQGHs+rVBy9sVYqm22luEd9fXv9Ox2WCxcP1VhwSefy6Foro5umBecaYASNzYoAEjn9Io7sDFJw+DHNGfzMnPmTJ5T10LBIrGJ1d+Oy9UfxiARflK07iNZWBYyuiqz8pwI+Mx0JNUBXwfUP2MTN+qQNsfmbANzWG/TW6Ws3Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ow00Uf3C2Q/mZ4k7QvmmsC4dJ6YjhWG6INdEC11vVeQ=;
 b=cOOdHGANiKBEnk2JD8jZtbakE+lo1VW8Dhpuv2iEYfvTpjud4m37P0iZ1KXpb7Pp6rODCUheg7O+v0CHSxYyq73CDTnlW16KtEqDJ3JKKSKFGb77qdtqME6Th+c2+ty1MKA6GxiVQznLNTw1OHIlwB1mMLPKQy0+F0tDayQzaLLcLowIlwFXFdK8cfZVXKbIpLioVv92Q2buzy3VRV5YOv2EHWlErAu84uvhSrZzSKwkwXh3mcrg5k3bBVtYXjy0N8uzSI4C/xKxHb/BfCxED94QMt5Ro7Pu5il5SSitIMswOxoRu5XzeGcp18tEUkSucU5eGkPsZuaE7sUdR3jC3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ow00Uf3C2Q/mZ4k7QvmmsC4dJ6YjhWG6INdEC11vVeQ=;
 b=1Fyyw2pkCD1aDQ8JqtmYBetAziDnVB96fpO43+P8ZoHWdMBYcONVZdphoWxtYBhdUIX7aXGXcrg6M9nJKuh8ACXQBbu2VAkBBsyqrY8MvQMR3yiP5TyvBmCLCQeLdCl56cDgT2gm0ciB9EiuW+wqlIRkhfjicllUWI8w6b97Pec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB7190.namprd12.prod.outlook.com (2603:10b6:303:225::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.29; Fri, 26 Jan
 2024 15:43:27 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 15:43:27 +0000
Message-ID: <af1f3522-6cf6-4a1e-b873-3ee4f9dd19d2@amd.com>
Date: Fri, 26 Jan 2024 09:43:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: duplicate 'drm/amd: Enable PCIe PME from D3' in stable branches
To: Jonathan Gray <jsg@jsg.id.au>, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
References: <ZbOAj1fC5nfJEgoR@largo.jsg.id.au>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZbOAj1fC5nfJEgoR@largo.jsg.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0181.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::6) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB7190:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ac961f-937c-46eb-47fe-08dc1e8589ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e55Nz+FQsUazrjjuqTAFfPHuqoF+FIh8MrcQsLa1PVkXFVMLEc2aQ1nDBq4seCfy90VZR32n5dOJfYcvbHQD9S6IHh/8ye6G6a5v7QJkCq13o/NCUrVpqp0/d4bDdR7JfWAQWEZrdXiH/T1M6pFhqfdHZQOrH64S2R2ty9joczmym09NS4Y0CJGcqyZbmA7DWbfVzIx5zT8ll80PTpuMyenR6cZU5GNr+H/R5IH7n0GvDHH3UjsSt8HiAsQyjPwbn3XcEOThLk2PhB6iSX5nnZyq/DEzFKK2cXQb3x/PhO8BmkmKN8kQZdiniZFfAlXk77K/h1VcNdsaSan2oHkP5SZmGNd4ZwZA52NhbZHFf17QW9aa0fWBdVWDPnAKMZyCFdHu5Fo2a7W3b9gAUdo7HO2qU/gfbl9wy+dXGyj+7hWG9/2RbQT45dJgSx+dTkq0W3Sm/AFcfXTROpwzcbZweiQcJ8Mauk7XyiD1He5THiGf/WKwc19lypvhFDuFDaTQzIp5QC8Rml40XOiqWjzjCU09PLgpsMU2Z4NxOsfnIlfqG1kurEEyNCzKHkwoEPhfNFoVQekPb2MyPcjFmPHd4p0LGskwqI89IAfxCwRJBkdLzIQqjEliMuBulc3fszsmrGh1Y4R/ayYObWhz+p1DbQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(366004)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(2616005)(86362001)(6666004)(6512007)(6506007)(53546011)(41300700001)(8936002)(44832011)(5660300002)(83380400001)(66556008)(66476007)(4326008)(66946007)(316002)(8676002)(6486002)(2906002)(26005)(38100700002)(31696002)(36756003)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dyt5eWVMUVpBenBOdVB0MTdPY1pwcWFrT3dGU3pXUENGcGtGZmJGbXcvV1ZQ?=
 =?utf-8?B?N1NNRU5SZVNBQjkvei9pVWF4UXE1Z0lXc3NCNU1QT2V2THB6OGk3TFc1c3E5?=
 =?utf-8?B?ZUhtVDBNdWpaMkwvOVV1WXRIQkY4WEJGR3BaRWRTOEtHQW81WkxNeEU4SWF5?=
 =?utf-8?B?VXRQRDdzbUc2WlExcFZsQkFLQnRNNUxPVnhFOEJMOVNHbnMrdUJreDdRK1lM?=
 =?utf-8?B?eXhHN3hQV1ZEWkJGMnhVckVjVGk0WVlKdWpyV3JXTDNkQys3ZjRlRmZBOGo5?=
 =?utf-8?B?QjV6alhISzgwdVo5TkJWS2VUcUNFcGhDOUFVUW9tRndaNGN3YkhLVkxuUis4?=
 =?utf-8?B?cnVPaDU3d3ErRjJCNTlIR3k5OHRha3hmYTFFd2Rxd3JJVGxYY3FJYjFVMkEz?=
 =?utf-8?B?QWJxK1FkZXQyZGdQeEFxdFZKZ2JCNkpnTy9SM3V6S0lEMUliT21lcnpSYWdm?=
 =?utf-8?B?cExla09UazBWSndtYytSREt5bmNIejRxc0dJZTBERmxaREJkQmI0QnI4Mkpj?=
 =?utf-8?B?b29sUmpkb0kzOEJrQSsrM1VZWVZqZ1dNRkpCOW0xS2tQTmpnd3UyMzhmTTVy?=
 =?utf-8?B?THpiRDQ0bUFVNWVkcmEzNUdVNkk0bGlVTXovR3VFTFlPNEh0Z1FtN1ZGNHhW?=
 =?utf-8?B?WU9ONnIyZWsyZ3RmOGVXMmo0cWV6WDNrZ1BMR3lhSk9jUVBvUEoveHBZdldl?=
 =?utf-8?B?S1ZqMzZyVkgzbVU0RWdRTmEvcFpGMlVRQzllTkVjUEl4ZkpUQlhldVUybkRq?=
 =?utf-8?B?WWJOOWoxd0RURWczWnNLeHlSWk02TnFBNmpERzk4MVpaNGRaZVRKWVBvUDdq?=
 =?utf-8?B?SFd2KzdwVE40NWwvNnMvUEhqWkhxT2JPVUJXU3hUMnVzR05YdFcwdDJURXR4?=
 =?utf-8?B?YkR0NDA4bGV5ekVTMHhLSmd4YnZYYTZjbENmY2EwRFQrcTVjaStnWjBXZkJP?=
 =?utf-8?B?ek16anRhVFlNazczL01kdjZNeEtYYTU4dVdoeU5ZUzZNWWFmT0hEcHNSdUV1?=
 =?utf-8?B?N0JicExpNUIyTlk5NTdCSUVjRForcXU5aEx3cG9qbnF2dnQ1Sm50dUJVbHpa?=
 =?utf-8?B?cjhIOWNnRG01dHQwODhXSExiU21LSFBEUlBaeUNLVGpseWJSSHdieXpPMGZI?=
 =?utf-8?B?cStWaU9ucys4VTZmaGloLzZNc2dIS3N4ZG9BTWdYQ0l3aUFmZW1TK0tsWW5Y?=
 =?utf-8?B?VlJ4TU9iQzRhU2t3V3lVKzJtYWpaNHVZZFh2MWpSallLa1BlZ3BUSWhYTS9H?=
 =?utf-8?B?QnVKd20xS0dCanFvcjN0Vk9UZDJWdi9FcmxOQ05reHMrMnhsY0Q0SDVoREpq?=
 =?utf-8?B?SFdYSXdUMEtLZlNDU1RMU0JGMndBT241WFRDZXY4bnliRktPcnJXWDdXZEV0?=
 =?utf-8?B?VEJEMXZDNktTaDFPTW9wR1k0bUswaStGeU5HM2hzd2ZaOElDc3hGaTFkM25x?=
 =?utf-8?B?bGFpbzJraGZvSDA1WkNLTXBRbVJxZkxZQ2Y4aTNvWE1XTEJPV1F1dWlMR0xy?=
 =?utf-8?B?a0NBY2RYLzN2VjhwVWZZcUJkNHNkVFBhWUJOVGYzdEtCT2FsNXU5Y2lQR2Ns?=
 =?utf-8?B?K244L1orL2tjM2pjVTVqMk5PNUp6b1Q0L1hYNjc3V3gyTjVhYjlKYk5BVGI1?=
 =?utf-8?B?SmN4Rlh5SkxMdUF2c3lubElqUnY3Mkw0WEhUWUhCQjgxU3pJRnpxMTFXSndz?=
 =?utf-8?B?ZTRWRGJBVCt4c2FOeVlhcCtieHhTdkZ0Nlg0aGdWZnkwQUprQnRXVkVBMC9O?=
 =?utf-8?B?Yk04czh0SmtvN1RIMmdiV25EZWtRd205Y1lYOSt2YzBXRW1aMmJkQm9RdkNo?=
 =?utf-8?B?QjBlL0wwb2h3cTFOeHphdzBEZFdMTVZpZVc2aDNmM0NnZFNPSS9OYmtqeWFj?=
 =?utf-8?B?SFZuL3BXRVNyS0Y0TkpmSENtOHFLaXlGNDlzak52SmhaR1RpRS9aZC92dVVI?=
 =?utf-8?B?dGJFVTUzZE9RY2xhTEZxU3JyQXd1NGdhd2U2NkFLYytGK1lPMzR1eHZOeFVU?=
 =?utf-8?B?S2NMd1FkS09oSlo2U1RQSytpU3JjQjR1SjgxRGttcXNvOU12V1FrT1VWMjY0?=
 =?utf-8?B?azV1QVowUXVzeVJVMUZzYkNQdFNscWorbi9vcEtHN0w0dU43dmNRU0NmR1Jm?=
 =?utf-8?Q?SKEchYJYGedec0vg4+TeL5sd/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ac961f-937c-46eb-47fe-08dc1e8589ee
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 15:43:27.5172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKuFvPIJR/ZC06SH3MYgtEn1NWlGHZLPmg/2ockS91I9V7qTD14rpwdts77ofHcdJybjreluhAlLLhmEMwjd3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7190

On 1/26/2024 03:51, Jonathan Gray wrote:
> The latest releases of 6.1.y, 6.6.y and 6.7.y introduce a duplicate
> commit of 'drm/amd: Enable PCIe PME from D3'.

Good catch.  I think this happened because the same commit ended up in 
6.7 final as well as 6.8-rc1 with different hashes.  This tends to 
happen when we have fixes right at the end of the cycle.

In this case it's fortunately harmless, but yes I think one of them 
should be dropped from stable trees.

> 
> For example on the 6.6.y branch:
> 
> commit 847e6947afd3c46623172d2eabcfc2481ee8668e
> Author:     Mario Limonciello <mario.limonciello@amd.com>
> AuthorDate: Fri Nov 24 09:56:32 2023 -0600
> Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CommitDate: Thu Jan 25 15:35:45 2024 -0800
> 
>      drm/amd: Enable PCIe PME from D3
>      
>      commit bd1f6a31e7762ebc99b97f3eda5e5ea3708fa792 upstream.
>      
>      When dGPU is put into BOCO it may be in D3cold but still able send
>      PME on display hotplug event. For this to work it must be enabled
>      as wake source from D3.
>      
>      When runpm is enabled use pci_wake_from_d3() to mark wakeup as
>      enabled by default.
>      
>      Cc: stable@vger.kernel.org # 6.1+
>      Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>      Acked-by: Alex Deucher <alexander.deucher@amd.com>
>      Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 2c35036e4ba2..635b58553583 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2197,6 +2197,8 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>   
>   		pci_wake_from_d3(pdev, TRUE);
>   
> +		pci_wake_from_d3(pdev, TRUE);
> +
>   		/*
>   		 * For runpm implemented via BACO, PMFW will handle the
>   		 * timing for BACO in and out:
> 
> commit 49227bea27ebcd260f0c94a3055b14bbd8605c5e
> Author:     Mario Limonciello <mario.limonciello@amd.com>
> AuthorDate: Fri Nov 24 09:56:32 2023 -0600
> Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CommitDate: Fri Dec 8 08:52:17 2023 +0100
> 
>      drm/amd: Enable PCIe PME from D3
>      
>      commit 6967741d26c87300a51b5e50d4acd104bc1a9759 upstream.
>      
>      When dGPU is put into BOCO it may be in D3cold but still able send
>      PME on display hotplug event. For this to work it must be enabled
>      as wake source from D3.
>      
>      When runpm is enabled use pci_wake_from_d3() to mark wakeup as
>      enabled by default.
>      
>      Cc: stable@vger.kernel.org # 6.1+
>      Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>      Acked-by: Alex Deucher <alexander.deucher@amd.com>
>      Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 81edf66dbea8..2c35036e4ba2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2195,6 +2195,8 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>   		pm_runtime_mark_last_busy(ddev->dev);
>   		pm_runtime_put_autosuspend(ddev->dev);
>   
> +		pci_wake_from_d3(pdev, TRUE);
> +
>   		/*
>   		 * For runpm implemented via BACO, PMFW will handle the
>   		 * timing for BACO in and out:


