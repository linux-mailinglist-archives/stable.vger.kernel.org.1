Return-Path: <stable+bounces-27135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4873E875F9D
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 09:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27D16B23566
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 08:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5573E53800;
	Fri,  8 Mar 2024 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yob93JqC"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B0853E1B
	for <stable@vger.kernel.org>; Fri,  8 Mar 2024 08:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709886829; cv=fail; b=S1XmCSK3NvVAV01B6FoJKvkG2810zr9QhKmNHyBduGRQzeEXEj2vFaZ5H3VB3ovZXxCLCqaJfEYTVlp8H2J8o0H3fYfH8wKug3WF8TIwYHYL4j/U+jiWPswxrMHxirY71QRgogCgZ+8pxZYzxGBjx1zFUYGxskLUkzZa+JPh/+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709886829; c=relaxed/simple;
	bh=YTQWJlhBCINswARrRZPnF9zXHURE+EOtldFO8cT6GfU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CxWjeODDqCXOClwhmDtbCcDW1ujpy1kx1iP6FIkaNDyIMzOMVjuCMjgDQgIEk/WHYyraJsRQkVFMjm4e7k1MhLiu2Y6EQ8Ji1X+LqxrxCoRy041nI/hFalJKfoIjaXehAA/Cp2us54otE6t32nUHTMIc+zjbM8F6S0A5J1+FGwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yob93JqC; arc=fail smtp.client-ip=40.107.212.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4V0h/xGC769oUPluqkV5UXNx0chwwGodaYL0XzglqUY66T7cCrjBUiQ7iibJlVxboMwKIdWazFyOwZKM+0COsmeaKxN1A1Hk6JP6i9j9dW5E8U+j/i+KHn2FJJsoCe5QriU+usRVMdWgYgXVzqbcqGbUWMkpFZB+6r8CeVlP9nr5ZD59NvjaLZ6QleCH5s0LN2RCdbD1cZRN4LqI5ci/BN8F/G5DTScKWkWtZ7YKHq7pfajlYWgN7dLPCA0ksm9kKRVB4CFcE4tkP3gWR6o+TbOxZLQmM8IWNG/hWMokCitJCp/9bClbcmnuGeGXL90cwFAWQ/QLREG1cDNkAA7CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siR3t8j29ovf94wny82YYPJgtRPs9Qz7BuJyodJorHA=;
 b=S8s/SecyyyOzOpTSYz2F59lhYQccuWpcXmLW3nh9D93zZFxuHXjMoSK7aoAHjI/1esGQG7aMpqVrQ7ju9rfRA4tEHp5Xt+5h04VRhuvgdSQuaMqHyIDy+IoF7ObI7tCJjJbpB18p9X7W9VKme4FsbB7/TnnzO4S68iDAIo89GkUXnOmmn35godMnRda214AMM82JSV6xd8xOF618bPASw9Wet+zoIbYf1Lp7CExE0PY3tXYRCJOeLLTsQL7SomQOjaEwEQohDxYKDb0xIaVh00Zyb0yJ374PLSoU7Ctk5v0jovUKaihYJgJQo6d1q7e90tHX/SzgmT/zHF70C0xpZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siR3t8j29ovf94wny82YYPJgtRPs9Qz7BuJyodJorHA=;
 b=yob93JqCRIUIo5N2CUnQBxcjGH35SXdiOG8lui+yJOvatJP7cDWYkwnkAO97K9f8XMs9sR3ljUwAkCD/RojR9Y81PnY8lnxTeWRjtX7wcqx+skH7whmzRN6L90OrpMD1sQ8t9vfJvyrE3CWiv89q6EDAYt24l/AyB15loMaaVro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 08:33:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 08:33:44 +0000
Message-ID: <d9632885-35da-4e4a-b952-2b6a0c38c35b@amd.com>
Date: Fri, 8 Mar 2024 09:33:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Forward soft recovery errors to userspace
Content-Language: en-US
To: Joshua Ashton <joshua@froggi.es>, amd-gfx@lists.freedesktop.org,
 "Olsak, Marek" <Marek.Olsak@amd.com>
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 stable@vger.kernel.org
References: <20240307190447.33423-1-joshua@froggi.es>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240307190447.33423-1-joshua@froggi.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 054fdf79-1d4c-422f-2e5f-08dc3f4a7768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DTHVqJD3l2DRsreJbiFq1ywdcN08OCzCkN+WOm0yapndur86DyXDbHJdyJaialGdRnUt31hO92BfxxleVk3J2+vJnSBXKZIBNFqbQA/2wo0idGXkceVM+VNPHyHEHos4ntg1bHKqutiP/BKFEkHs26BA4R0Nd5klAqm+RhRdGIzDy8cvUbcB6cMswqKo2kiGG5ZCXxA3NWs5zDPNPQfpzeUuBfrZRqqWNTI7KYdMt4cYYWnYGp49gbXUBtd/N0ZS0phRTPIWUBls6PIlAOngiHgmKD4cVnOCg9+th7QVH6yU+7G263lMx2idXfYzIKKufj5YoXLbxK7lry/aK8MH4WLpNCookns9oe6b456SQqGzewcQEzzkwSGtU474lI5GrVVN/dQZrQFQF4p9QLhQVWRNjr8yhpJ63EuOld3gTgZdHRYHujm7vDmztXksLUVoL4oEM9BZlR6UQ9ATGPGF8xXuJU2wazPBgk+LgoU8SdYd2RjrD/JqH8VnTLdN7LN5nlpyw39Cv239f1sBtAaZDtCWG4k+JUhfh5KLcVZocaoYvcjf48FqJFw55FkuBd8h4thR5ETPDccPKXjiA09FlJwYf1JxaNDj2/QhUsm6lkg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGdNNS80NnM0Ty83aVZDVk14SEtYQzQzODRwVDJQUTV4dDBOUUthdXVrYjNL?=
 =?utf-8?B?QktkazRKSjhkTDdtWU91SEU5UlN2K01xeklZS1ZnaW1mNHM5aG9MVHV1U3pk?=
 =?utf-8?B?dmdCaCs0T01jaHBXSXF0WndTUUJZNVBzdy9tZ2tDMmRPYW5obTZsU1hYUDFu?=
 =?utf-8?B?eVlKYk9IaWFuV1dVSC9DakNuSUVwYTc1VnNoV3d2Wmx4czlacmNWZXQ3Y2JW?=
 =?utf-8?B?c2h4L09KQlNLSVptWmlTdVhaenRGVXlvanhkM3lWQVdWajhONDNFS1BXK0tw?=
 =?utf-8?B?NlgyWUE1bDhVMlE1M3gySkVzemhtYVZ4K3V3UExLanE5Um1aemVtT0oxeUxX?=
 =?utf-8?B?OUpLMUk2eWRDc0g5TnMvRDk3UGM5Nm85OU9oR3VubWc2bDhsRFFMbkZvRzNC?=
 =?utf-8?B?NnJ3bUllckNhZXpZeFZxMEExd3hNWHdNcVVZOWdkM3NUbklsamVyRGRzaEZ5?=
 =?utf-8?B?YzZZTUwrQjRsemhMWXM3TmNITlM5WURzRWEwa2RQUmkvQ1R2bWx2S015NnFG?=
 =?utf-8?B?SjhSRnQyR295Rk5QVjlnM05JRkZ2dlJqQ09YSjlvWVEvNisrY3RKZW04M2c5?=
 =?utf-8?B?cm1IcjAvdXIzU1JwMDhmaFB5cThNWHg4WmppdCtNSWtNUE9zdmhncy9jT0No?=
 =?utf-8?B?bzc3aG1zTXZ5REhoK3pud2tuQ2R4eTc3eDIzeVZROHgzcGxpbWlLdC9CZkF6?=
 =?utf-8?B?R1dvelBuOWY1TFBldG13ME83V2M1QlIwSTdXODVZUlZ3NmhyOVNqaG9hSURF?=
 =?utf-8?B?UmpIZmkrMkJUZWpaOGlEV0F3c0ZwSWtCY283QTBPRXBha1R0d1JhdlFVd1BG?=
 =?utf-8?B?UXMza1dBbStMQ3EyYS9RVVMzRmdNbjY2Vk55WE9VSmxYZXNKYmQ0dUlYY3l6?=
 =?utf-8?B?VitFYzl6aG8vSXBMaFJFcm9aYkZpR3oxV2pBTmd6Sk1ESzRXOHVTR3VsRGQy?=
 =?utf-8?B?NDNUNHF0bWhFeXdTNHcwVEI2aVg5MS9EbmNrcUkzZDlXQ0xPSGFDYVZrUHdz?=
 =?utf-8?B?TkM1b2xlekRWWkhwR2s4RkF1RGgzSXlvWm54b3czamJIQ2VYODdjZ1ZoMG9l?=
 =?utf-8?B?RDdwbGp6djlTMWtWU3hOVHhXeEFhMGY0aEl3a0trNlNDYUhXZzBCVGI2U2Vm?=
 =?utf-8?B?YlJQdVBLNTdDTTAyMTlpcHBSVEt3R3hEZm41dDFwMFZ3WTBOQm0ycTArTVVH?=
 =?utf-8?B?bHBJMytMQzBIRGtFWk5lempqMmkyWTI1YWwwcWxTaE5aaFRBV0tYdDM4dWpS?=
 =?utf-8?B?ZFJNckJBQ1BBZEFnbFh4c0xZS2NIc3paZTFsakR4WW5mdUhJLy9ZK2dnV2ZZ?=
 =?utf-8?B?R05kRmIvN0ZNWHl2QVk1Z0VTaUpYcVdpK2xlcThkMW1FS0lZQnNhRzFUTUJp?=
 =?utf-8?B?cGlIMUMxTmp6ajhUTVlRVGQwYndJNFk0WmxWbnA2azZENk1kWlp1QkYwQjNH?=
 =?utf-8?B?MTJ3Y2xGOUNpYWh6bXlOZVRCTC9vcytvMXdSTS9zMTFudE1MOHJkV1J5eTlH?=
 =?utf-8?B?MmcxVkx1c29OeWlsY21zM1JGQUVxT0FkMFYrV0NYWXJtMUo2d21yd0g3dExj?=
 =?utf-8?B?UGpWbUtMa2ZvaEk5YUdzdU5jT0xuSjcrR05NK2JyM1RyS1FxQmhUSlIzcDVm?=
 =?utf-8?B?V21adC92dlAwODN4dENPM1ErVUZnNWRLaWRnbWFnT0lpdHE1SWhkZytkaHhv?=
 =?utf-8?B?UnVTZXNYTGlUbzIrR3hDVVNrU1h0c1F5V1kyWXBIb3NEekwvTTRMOU5pWWZI?=
 =?utf-8?B?Zi9Db1lXU2gyN2xTWU5KSS9TTDZwZDhTK2VCeHBydGhKRVBvSlJLMG1ZQXZQ?=
 =?utf-8?B?QkRzRWJWRGxOc0pnWXFlZHZtNWpmZkplZHo2bUtqL09WWW1kaEVhaXE0Tmh4?=
 =?utf-8?B?REVxZm42UlF1Q2hONnFSYTNBcXgrKzZKcGJSdFduejRnSy85WVZKRCtTWjQv?=
 =?utf-8?B?QTBSQXplaTdxOEFIRUc1RlFBMWZjUTNUNUtUYnpVYXhUWFpOdmFvaFY5SGZ1?=
 =?utf-8?B?TitwcXNVQkwzRUpqdzZMeXpMMGY0c1UwdG52ejVzSXZzYlBlWjhzMXdzeE1j?=
 =?utf-8?B?KzlNSkdKcG9lUm9nOVVQZk4yelZxV09MY0NrWWE4dmtDQVI4OUR1L0tyYWtk?=
 =?utf-8?Q?fsKy4ZmeMgsokKCNV4xmMpsek?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 054fdf79-1d4c-422f-2e5f-08dc3f4a7768
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 08:33:44.5747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBdrwyvaHetu6LHZiSGE+i0DW/BNTOAo72TRqhqTnbtivNXnhuPOGq2jCzazYjor
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936

Am 07.03.24 um 20:04 schrieb Joshua Ashton:
> As we discussed before[1], soft recovery should be
> forwarded to userspace, or we can get into a really
> bad state where apps will keep submitting hanging
> command buffers cascading us to a hard reset.

Marek you are in favor of this like forever.  So I would like to request 
you to put your Reviewed-by on it and I will just push it into our 
internal kernel branch.

Regards,
Christian.

>
> 1: https://lore.kernel.org/all/bf23d5ed-9a6b-43e7-84ee-8cbfd0d60f18@froggi.es/
> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>
> Cc: Friedrich Vock <friedrich.vock@gmx.de>
> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: André Almeida <andrealmeid@igalia.com>
> Cc: stable@vger.kernel.org
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 4b3000c21ef2..aebf59855e9f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -262,9 +262,8 @@ amdgpu_job_prepare_job(struct drm_sched_job *sched_job,
>   	struct dma_fence *fence = NULL;
>   	int r;
>   
> -	/* Ignore soft recovered fences here */
>   	r = drm_sched_entity_error(s_entity);
> -	if (r && r != -ENODATA)
> +	if (r)
>   		goto error;
>   
>   	if (!fence && job->gang_submit)


