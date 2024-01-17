Return-Path: <stable+bounces-11871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8984A830F8E
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 23:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A19128CC30
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 22:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB29C1E883;
	Wed, 17 Jan 2024 22:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pmXAJALR"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E03A28DA0
	for <stable@vger.kernel.org>; Wed, 17 Jan 2024 22:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705532096; cv=fail; b=Q4XXZ2TtkGfk+wU45+vijQA2Cv7HpETAUvCum7lurlPn4/Da5Mk9vjjPLZ1qt2iS2n1wbkSVdATqcPQDJXSW9rxWrmt5rdicFkPJAfCmHbDr1Bh1f13VexWRszvuwogWFTf4ryGOvaPM4o1p+9TNDVUX8++BToRIptrmk9OnsqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705532096; c=relaxed/simple;
	bh=ckVhvaFNkj6dJRfb6UXSHNBkxEg6tWXUSA5NRo8UUHU=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=En+VgWIvFzpI78S/jWFZd2RM5ermvyyzHf8xyLzASM8gnp3fxuL+WC7iRX+eXo8uawF5SqKWggDxaizeRxlPi0ADbrUTHiwSUfmEJ5lqI96fiuLwpixyF+mD16g1R007r5hqdi/PPiBbe8Mf+DSnTa5R7v+Y0sWQPIWx/VkoFXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pmXAJALR; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9Ipfzd7JAEbIwa0MNeVlrqnXn5m7UmedP1ftpyjrGcl4LVE7DhakkXFsMN2PLq9+xuyXs0VTbpUHZUhYTfcjtnZe13wZsoJsVqgMsPG+vm4KPh7edFLvEeiWqb4EistT2r1JXJYiAK95+xclFjBC++mDDIihhi6FjOV6XR0CFqJKSEBK/9bIlpyj3XgH11YsxCLLW36JYNlabqBBKXowHcJn66DJsUPniSShQNU0s5f1dOLJS4VLE2xuKnyngGYksg1uCfNPovALih+epdG0zm0DW5Lk7pRolYdlYR0c5VS/myY6Ycynnmm4SmjIuBh8IKzpFkeCNqfxuE8UfXGgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEj6gaX+5cfmLnEiVhNq9ZsGLA11+Adb/BoNpd4bh40=;
 b=AOHFyHScggw8Ml1OFIfcMnBB6uDJyFROJlEG4GEvc0kzHH67ebJdHkPcFeOu/PBPPq49r99dBCCsLEbIHTrprAMxR4frr/bf0aE0fLQkGVbkPxJGPGjH7AvdAae+GXvgCNkg5uZ8Ns0ysDoTg9uaHO8KUJ2y4iWxQhMwWpq1TKraRPRscTcIph+O7z3ZokYlZXW/bVGTay7joL+c7MMbKiFfNze1jJkzdRUiH89XIZp7HJ0LEh7Aqiy8GNXEW4Y+5FDWv2uZjO+QYV2W1TK7umUTRHUFd4xLR+nFYcTp5Xak7ag7/N4297meGwIZbjk8wyyXQctxlOEg/6GNp4PLNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEj6gaX+5cfmLnEiVhNq9ZsGLA11+Adb/BoNpd4bh40=;
 b=pmXAJALRjctZHQFp0nDzGStUM7nqpfulxvW53LY0NyD74S5jjLuHnvJGn8ibM8NduT9A3Wv7KQr6hvHK6x3a7X5Lnao2nVeI+WzPiR0HDfZBVsDNoXKMXJQZI4+EnxMCumKyXk7YVehISFJf7W7LrkH2MeKp3+cOve2VKOkDej4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB8722.namprd12.prod.outlook.com (2603:10b6:806:373::9)
 by DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Wed, 17 Jan
 2024 22:54:53 +0000
Received: from SA1PR12MB8722.namprd12.prod.outlook.com
 ([fe80::6539:cd4f:cb1d:3507]) by SA1PR12MB8722.namprd12.prod.outlook.com
 ([fe80::6539:cd4f:cb1d:3507%6]) with mapi id 15.20.7202.024; Wed, 17 Jan 2024
 22:54:52 +0000
Message-ID: <37c4c2ac-0482-4820-a587-4db03e78ffca@amd.com>
Date: Wed, 17 Jan 2024 15:54:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Fix uninitialized variable usage in
 core_link_ 'read_dpcd() & write_dpcd()' functions
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
 Jerry Zuo <jerry.zuo@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240117032354.20794-1-srinivasan.shanmugam@amd.com>
 <20240117152327.204465-1-srinivasan.shanmugam@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20240117152327.204465-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR16CA0019.namprd16.prod.outlook.com
 (2603:10b6:408:4c::32) To SA1PR12MB8722.namprd12.prod.outlook.com
 (2603:10b6:806:373::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8722:EE_|DS7PR12MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e831936-d2a6-4001-0990-08dc17af511d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aYye/vv2GBB2cl1LAb5JreVpTPrqqpGxXFHhfgXn+J/tDfaiDWvCm3RFA79wslVKUKW/fq863zmpGzhDjvuN1Caik6zd9i6mLWS6Z66e0lcTWtWt6PMG8EnCP5pHZguF/F85bM2O2QVMMLKr74LNStFLT7+7E0ai9cXUiSVcUIXxvH24L18SvxdpdsrrE9RwhrKIDmnAn+fzwpzcObUecxzPPcys4Q6BNKVwac5KgSGj9I94s8Ik3aJdEqoCFPJqHe6f0vQwwu8OxfzTQMetT9P73NtGTc+G+E9lj12cSDXKyvscH6bjOOPswUf1NcOV9EHlIoEPAwz4akXl6GmhySN1eoCRmcke2uUQX+IwCZ1EHcxkiuOWiuzYtV3uLUVBvpcnaAzVEdUxRiWzuBTWieZIwqF5OyIPYwUGavTv71tTuuj0siMLSHNsGkoMCQ+XqEN7XUsVSf0dp6BHii1fQoauPscqG5f+LUYQbvt1jStYGvMBELLu0EtB4dDU67LAj+RQElh9UwlowlhXrbTkYmZ3vSTuhsWot01P0lDXmCN7VceqWMJ6hEtGtwFjhqHoASxtvzD6qcztltbyQ5A924A4YendiOX+fe6oFyMjt4VbYwNzyU1kZ7p6C+SINul3BGDvIhH3wv4nZsjLeEG6Yw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8722.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(53546011)(2616005)(66476007)(6666004)(36756003)(6506007)(478600001)(31696002)(6486002)(26005)(41300700001)(83380400001)(6512007)(5660300002)(110136005)(2906002)(38100700002)(8936002)(66556008)(6636002)(31686004)(54906003)(66946007)(8676002)(316002)(4326008)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGJUbm1VSDhxVERwWG1YZUIvaFNMOS9FUXhrUDBZd0czejF6czVnaFdQWlpr?=
 =?utf-8?B?ZzE4Y3o3K3M3dGtaSElDN2xlTGE5eDlsSnFSbDZmbmhpZm5xUlcwVXFoVHBF?=
 =?utf-8?B?OWJoUFRXTlV2OHp1a09rOGxqZVRvcFp5NHFCWjk3TzZnTGNDUEN0ZGtMTTl2?=
 =?utf-8?B?ckNiaXJDU2UzRytYWVFtTlFvVFpJc2JXMDBYOEhxNXJjejFNMld0SkJFK1Y3?=
 =?utf-8?B?T0RGUVJVNEcrNm1RSlBaMU9tcWxnTWdOZ3ZoQ1orcVd2TERISzFuSk50OWJv?=
 =?utf-8?B?eXhidUREdVV5ZW9PVUYvT0RQZCt1TXNxQ1FkdTBIZ1FqWDViQlNGNEJwaTFJ?=
 =?utf-8?B?S090dTl3TUU1YVZFc1d2K0N2NUo1UlpoU1k0VjVWSXo4WjFMWWRuTWpPL0V1?=
 =?utf-8?B?YUF2aUpKWUs4ZGlqY2tjWG5OMktJVkhFbUxVS0N1UnJiSEQ4akpTT0psNHJU?=
 =?utf-8?B?OW9Ja1YzSE1BWXBObnppQXJJNkNpVWxwOUJYN0t2ZThTdkQ0YlZweXhtQTc4?=
 =?utf-8?B?Wkc0UWVET01VWVlQS2ZzMW8zRDhkcGVlaXF3b1RrQU9jeTVaN2MyeXVhSm4z?=
 =?utf-8?B?NUwwYnNCTEFDR3BwQzZPemg4M0NtNS9JTEtHNk0xaGpFVzNpdFVERUpJQ3lG?=
 =?utf-8?B?dERoRDU5SHhreFYwRGIxZHdlSm9HOVliZCt2V2o5Ni9QVE9JZ2lGZTk0Z2xU?=
 =?utf-8?B?YkV1aTdWbkVTY0ZmNFlKQUoxNkJzbkFLV1oxUW9zb09VU0plY081NHQraWxV?=
 =?utf-8?B?WVZaWHVocVpvTFNqKzdPSk00S01nVVRCSHV6dzdndVJ5NjNpMUppWjgxaGpQ?=
 =?utf-8?B?SElqMTdnSmltMGozRFR2OERxZXBaaUlsb1RiNXVWVWV1WGxnUTFJcldSak42?=
 =?utf-8?B?UksxMFdCdjU2SmNuclR0RzlrQ0ZDWTBwSi9kWEpLV2oxKzhEM3JCS29xTXRB?=
 =?utf-8?B?d2lXWENRcy9tUWFuWDRMOElIQXM2aHF4dGxsSkF1R0tTNVRWR2RWaTM1WlRY?=
 =?utf-8?B?Y2V5MGxWSzFkV3IxL2NPQXJrQTMwbnZWL2M5MlJHWC81K042dHZDLy84MmJi?=
 =?utf-8?B?R2wzRUJTd25LMk42bXd6cnRXNk1EQ1l1YmZVRzZLQjdMY0hNYjN1SVFKbVV6?=
 =?utf-8?B?ZjhVeWJFQXl6Lzc5N25PWFRGNkhEdDFscGtUNkIzQVJJVmRRWjh1aXJmb1E5?=
 =?utf-8?B?VG42QUM0Q1hWZmcwbjlkeVN0TmpSL3JGblZaNUU4b2l0bmh3aDlEakNMTmVj?=
 =?utf-8?B?R0gwRkZsb3M1dUN5SUxoNWJheHd0Sm51MXZDSHBrQTlCSjNtQzhzek01Y0h3?=
 =?utf-8?B?WGg3eDVNakJhSFowWVNOcDdnWFozWWdKVGNWVThaNFVSQUxyRHFnU2JPUld0?=
 =?utf-8?B?cEZGVGFRMm5WWFZiRnN1WUxDOSt3N2lRa1F1bjV2L1FlZXh0TmZvSUVhSVBx?=
 =?utf-8?B?ejV5ZFdPa05TMDdjWmFyaGVYMnhrejhZK05rdmdraS9HWnRyUXF2Y29sOFl1?=
 =?utf-8?B?NUo0N0N6a09zRURkR2U3OW4rdWQ1K3MvZE84dGtlcGU2WThnM05FQk5reFlk?=
 =?utf-8?B?UitxTUUvZnlqUzhyTXB2Wnl6YlhTNEk3eURxVjZxSStadVdLT240ZDBVbkk1?=
 =?utf-8?B?dW0zQjZzcC9kMllxVFplUDNZL3AyajhPc2hrQ2hFdVFBRERXRFBqaWVLMmRs?=
 =?utf-8?B?RW1YcG02R0RLRFB3UzFSSFlwMlBxd2F4VlBkdnJhRFJ6UnQ4d2JGblplWnlW?=
 =?utf-8?B?aHQvUkRIU2Q2dWtuUEFCNnZNNnI1RlhTWlZQc3dtRjJWZ2R5a3RycEg1Qk9J?=
 =?utf-8?B?REVCUGR0NXc2a0QwMENuOUpza1FTQTZsWjhLenZOOWFUZWIyOWJhWFFEa0dv?=
 =?utf-8?B?cVJGSmVvay9iWFI3SS9hcGtoV1hEWk1Ddkl0NEh4MVFUMHNGeVdxN0hRbXRH?=
 =?utf-8?B?UnJodEU2NEpmTnkvWmpwK0J0WXFtMllCWTQySW4xMUtlTGx5emdicUI3cVFZ?=
 =?utf-8?B?L0RGSVpobmdCdGVvVWxjWnVIakx6ZmthSmJ2d2hpSklpRkY1NUg2eVh2S3lS?=
 =?utf-8?B?NnNhcVNMUm54a0w0NXR0clN6RlUrOTYvN1BGTDJhK3lKeGN6Mjh2b0xZMndB?=
 =?utf-8?Q?ZiTKc521HRaKouCafDxUdSrmZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e831936-d2a6-4001-0990-08dc17af511d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8722.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 22:54:52.8773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: khmwmOU7olnwaovVLz3HbcVIQjMARCS8nAtaMgufS1da4B/3h6E5O1RGXrGPGZ9EXtzZWRdWFFL2KE71Vbiahw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5765

Hi Srinivasan

On 1/17/24 08:23, Srinivasan Shanmugam wrote:
> The 'status' variable in 'core_link_read_dpcd()' &
> 'core_link_write_dpcd()' was uninitialized.
> 
> Thus, initializing 'status' variable to 'DC_ERROR_UNEXPECTED' by default.
> 
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dpcd.c:226 core_link_read_dpcd() error: uninitialized symbol 'status'.
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dpcd.c:248 core_link_write_dpcd() error: uninitialized symbol 'status'.
> 
> Cc: stable@vger.kernel.org
> Cc: Jerry Zuo <jerry.zuo@amd.com>
> Cc: Jun Lei <Jun.Lei@amd.com>
> Cc: Wayne Lin <Wayne.Lin@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>


This change lgtm.

Btw, avoid to send new patches as a reply of the previous one.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Thanks
Siqueira

> ---
> v2:
>    - Initialized status variable to 'DC_ERROR_UNEXPECTED' default.
>    - Added Jerry to Cc
> 
>   drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
> index 5c9a30211c10..fc50931c2aec 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c
> @@ -205,7 +205,7 @@ enum dc_status core_link_read_dpcd(
>   	uint32_t extended_size;
>   	/* size of the remaining partitioned address space */
>   	uint32_t size_left_to_read;
> -	enum dc_status status;
> +	enum dc_status status = DC_ERROR_UNEXPECTED;
>   	/* size of the next partition to be read from */
>   	uint32_t partition_size;
>   	uint32_t data_index = 0;
> @@ -234,7 +234,7 @@ enum dc_status core_link_write_dpcd(
>   {
>   	uint32_t partition_size;
>   	uint32_t data_index = 0;
> -	enum dc_status status;
> +	enum dc_status status = DC_ERROR_UNEXPECTED;
>   
>   	while (size) {
>   		partition_size = dpcd_get_next_partition_size(address, size);


