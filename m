Return-Path: <stable+bounces-25435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E5386B7B6
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 19:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AFC3B26CDB
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 18:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5664179B85;
	Wed, 28 Feb 2024 18:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wS9naQQH"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819DE71EB9
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 18:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709146308; cv=fail; b=IhJgHhB5WTXoOe5bnXDv89TH7EJJOXibrqc822TuSyOPmnEbWZiD3ufwoik9V3FGQj/1IrXl7W5714ALI1KOLvq59B5lGkUmuuC9Xh34Ap4nmK9m6kegmcn5Lq07p/SO4LcyWYcB2GmH1280XHWfo77vvgMSG/PArRSuxnd9m00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709146308; c=relaxed/simple;
	bh=QgVXzTaWTOIxGiUAad1W/KQWXrX5UkQNth13WO+DLsA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OekQyXyeBuMOI92fds9QkF6pHRIo2/k2Yde2l/ycKjH+rURYeri20XRYigfUEpR2VnHiJKLQe7IIilWrwAn//xa3OaDXGMN+zamcJ1DqkXcuzWIhFa+PNd2RLSQKzRgDAWKajiAGaIwtS5/2ThXfLYXea+kxJWAWTAX/k4ujoyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wS9naQQH; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1+xZJyeLLwGA/nV1KD57beAm2PK34wmPx9jd8weFmXPQSjIncJcjRXZyiwyEH4d8sU60VI1r3iL6w2BoL9zv8lLd/4XEqSmqVSlq1iJ2FhkZbLJKYAjQe6gJ1JppCLKA9ynT8e+XoLXOCzooWspfhRb3Z5TCfHy0UI1Gdo4ZMxHKb6lDIptyWIthed3x5gANCW+HMO8rug8vNbkDbN4h+riL8PBbbFIgesXPTkIp1MzVSgGRNeNEjazpIHNurf/IC5Z6RQOJfXeTJ6m7vZ7yKWx1GHCxAJzT7GX5hU4CElNQD12M/DnQKNem9lPnrKutXc7yQouadCsNsgvOJqBwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgQGTjjumxBcN57fsXybHUSp+XptPqSr4i3n5qCH7a0=;
 b=BDdAvPzqFAmgznfTykgFagulKofSj0LzN76urPvaApxU/RUi/iOuJ3iAF4bb+QeUiftYc3YSwJwBVU6hQkrkAcGuM0eB6lacOT3cTuAoYAv5EP13b+ANVi2nBFFI+GpDfjb/6orZykZR70He4hv7bn6k2e01vPyYMIuG5kzrTMX09eUOYtXR/3oUYk1FnyeJHGEoVdV1QuPTD6o95RWi9Dg/NNWyY7D4vwGtczX+PWFO4mDDFzM9yLE4AjyeY7ORzAeQq/1A5qM7TFCzW+rEDexyxa6aMKRhmht/HIP7EeDADbcKJB8Edi33PlWG1p1yZuJ0JGy5XC6VES05KgxGLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgQGTjjumxBcN57fsXybHUSp+XptPqSr4i3n5qCH7a0=;
 b=wS9naQQHeaxaqIiebnJcYxg2d3mUOB5fynjzqPuqquGo0Xo0SvvySyJp0Yiqa0ottK9GKRq3L3DtRGdYCSge3tWkpP4r7xCPmLbx8zVZgsK3LElC+P54ZAKRhNwU1+kSVqesVUWkVLT6LkWbn4hONoVPVxYVBehLWjDHAcJcVtY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB8242.namprd12.prod.outlook.com (2603:10b6:930:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 18:51:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a1d0:2930:8c24:1ee1]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a1d0:2930:8c24:1ee1%4]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 18:51:44 +0000
Message-ID: <54c3aa20-f041-4843-b4b5-362b7ff77844@amd.com>
Date: Wed, 28 Feb 2024 12:51:41 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/34] drm/amd/display: Set the power_down_on_boot
 function pointer to null
Content-Language: en-US
To: Alex Hung <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, roman.li@amd.com, wayne.lin@amd.com,
 agustin.gutierrez@amd.com, chiahsuan.chung@amd.com, hersenxs.wu@amd.com,
 jerry.zuo@amd.com, Muhammad Ahmed <ahmed.ahmed@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
 <20240228183940.1883742-26-alex.hung@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240228183940.1883742-26-alex.hung@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0079.namprd11.prod.outlook.com
 (2603:10b6:806:d2::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY8PR12MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: 8777e718-e6a1-43b5-c92b-08dc388e4ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y3XDmOjNvponwWm4VI8AM8My6W8psHRTM99LjUtY15Ez0CmvgDDrzgx/FCke8iAnJfaOQwwg58HO94VHofi/ohg7dSo1qDBTYr3r662GPsceyj9njHshME9/NO2ASTBhpZjz2rMApg9es8OHouqvtAVlcjAxg7VaJlx8L4v8CdBYtjJxdRIJITJ1vfGgCXAvIK0T9b9MAccBDy26dXDzQ5WdYwf14Hgf1bWnwiptABzhCmf+ZqSIxnvCGi8QDiJ4Qd/snB7mcLGrBY/0gD1HHOIcvikqOWYpV4NjWoCURS2hfIPOsSyyUxLXav2wKPLcIVkZXpJg5ltvni7nlxwy14SIFmlWbzymuO6u4x8Fe+J+TchdKRa96VqLJg1PX4TCOQreZLqJng7+dpvdk3huWNTkm2y1Lh3F/2M9SLBc/Xri209IA24NjxfxONqWNwM/CjEIVo4dgYmqn742wVcxvPIRmmcUqLba9ytopD2JrUaYnQpoWsNR2c71tT3wdN0CuI6AK1KQJrq/WB8zOsjtCwgPdyj0gUFD/6Mqo5TLFj6ak9VMsXzVtGZb5UmGgxE3EYj/LzHJwTR+XnbWbJO18hH2+X/KI9A9wMy0BDERGYORr7d85kmjX/UiaqvyfZcGdexMTWktTQ93l+y69A6Ibw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlhvajFBM0ZEVEo4MlQ4SW4xMEJFVEFxNnJ4Skw5cU1zSXZ4eVRiS1lMSVFV?=
 =?utf-8?B?eHcyb3p1a1krSWliSVZ1YStWd05ybDh0a21mQStTRXJBOW5IZ25ldWFPdHBO?=
 =?utf-8?B?Y3dTaDBFem5pRGJxL3pVbEpvSER5MjBQazY5VTE2K0FnUFplYjZtSmhrNU5P?=
 =?utf-8?B?NE1uNlR5ZWw1akhuWjM2M0FCS1lTeUVKM3lmVmNaclM1bkowVmN2bVB2R0Vu?=
 =?utf-8?B?MnUrdkpORk1SMVNlQnQ1Y29FZWlMQlpwM3pNR1YxdWtJNW81SitCRmJvbWU4?=
 =?utf-8?B?SW9SYzZ3aFRHSkZJUE9lQmpHU1hJa2tSS0d6Mm1TcEduNStpU3AxN2RPdDJj?=
 =?utf-8?B?NGhOaTVtYVdXNklWK21UVldPOWtMSmEvRi96dFJKN0QrSXVqek1lbTd4aS9M?=
 =?utf-8?B?RFhsMFFDN3o5ZGJPZXpVL3QyblV1dko2em84WU5qUE1nZTNuMWNqT0dpekc1?=
 =?utf-8?B?REZLQVNGWDA5MnVqQWZxS09oeUhCK091QU0rTnZucDFoYldtTGllZ2MyTWRJ?=
 =?utf-8?B?aFh2S2xGNW9mU0hhdUF4TVJyaStDS2VJR0FPWC9EY3RDRE5ESFhLRFFIMTAy?=
 =?utf-8?B?c1lMdFZlSk84N3NxKzBrRGprSkRPcmdXa1U5MXJKak40d3NEZk5zWnBSZkZB?=
 =?utf-8?B?MDRCRmUvdjhsd0hmUHdaWWpvNGFScGsweTc0VnlhNHZYM2EzeXlJbUJrQmcr?=
 =?utf-8?B?elJvckxoT1RwdXh6N3EyYlhadXl3eUEzSjJPYjFSZWR0WnVXdzBqenFGL3Jk?=
 =?utf-8?B?QWxqYjR3TlRSYzk5ckp3cnNVazNNMGdBdEVCR3JVL3hETnpZbzl4Vk9yaFRJ?=
 =?utf-8?B?eEhaQWJoL2puekJrME1VVE5yUkZ5RjlGbC9DYTBtVS9wYkd2UmM5YzNpK3RW?=
 =?utf-8?B?N2JBNXcyRVY1SEVtbTY5eXFEZTB3Mk9JUHA5ajQrbXFPalhTNDhscWFzRnJP?=
 =?utf-8?B?Y3lRU0cxT3pHQzNRUW9meXFlZExlY0s3d3BDRTVjUjhGcUZYRkJqMmZUNWFB?=
 =?utf-8?B?Y21ISm9WaTdCanNiRnVsaWlIYjA3aGNyMXJNVllTTkxYbEdKZUpnTGZ3TjhB?=
 =?utf-8?B?T2Fpc3BKZkYvRStYU1ZranNSbDZTR25wRWVqWlZyMjFvMjFKU09jMm9QaUpR?=
 =?utf-8?B?eEdXWGFySnF1OS9CSGVMVXhvNWpIMFRVbi9WMlg4SWhVa3kxNVN6ckk0eTh6?=
 =?utf-8?B?bTNabHlhNjJOVFJUbUlvdzJubmJiN1owNHZsMVlMTXJRcWlmQmtBYlJka2xN?=
 =?utf-8?B?aTl3MUMzT2Vlb1g4MDJKeHJzMDVyNDZNdi9vQmg4WUN0U1E2bGdJQjlyeHRX?=
 =?utf-8?B?QW9HWDFuMjQ5c2ZiRzh2bnFWVUQ2K1lMZHNHNks2ZVJaNUx2WWdYREUrSEkr?=
 =?utf-8?B?VUFTN3pocWVGblRNL3pRRllZM0pIQUdwSzhkZmxGK201ZUFlYlVjeHFjWFpG?=
 =?utf-8?B?R1dMcU56L3NpeExSczJNT0k2NklvTGtHZ3hsV0toUmNwUzdGaW1wVTFxRm5B?=
 =?utf-8?B?WUZtWWVUb2dHTzZLZ3lrN20xOG9FYjA1Q0dnT1FMZ015MzArMFRHenh5OFlN?=
 =?utf-8?B?OFg3T25iZkp4NFFXd0VDSnEyTmZVMXpYVWlmOStCMGRwc1Z2Q2JlWHFvSUx3?=
 =?utf-8?B?L0FFWDZlRmxORTI5TDBkRXcyNGt4OWRhaUdzeENGM1BIdjQ1UE0vcTBlVGlZ?=
 =?utf-8?B?R2RZMWhTdElpc1FIZEp3LzFjNmdSdHhlcks2dG5kejd5WjIvT0tzWVFoUlA3?=
 =?utf-8?B?bFlZbGR0Ulo4U0RyVDBwdmQvczJzUEpLSzh1Z3ByMnJWVkVMVGNWYTVkVjNO?=
 =?utf-8?B?VHdYL3FaSXA4aEc3Qi82c1RoMVF3NGVpUER6Z2QySEp0TXl3OUc0ckZBT0d1?=
 =?utf-8?B?TERPNlhqU213NUVpdk1wMzZDR2dlTjlEUUQ0NXhqQ2V4djF6QmgwWDF1ZXJW?=
 =?utf-8?B?RmlsMDV3bWFNWGZsWHo3eVU4OTAva1hybStXQ3ZuZ2R6Tml3dmZXQW1lNDVp?=
 =?utf-8?B?ZXNXeFgyUUFpZlhIYWtXRHh5aGlVeHNuUGU3VmFKa1pyNnV1c082SEFlTzl3?=
 =?utf-8?B?VG5FVmMvRlFQZWlLbXlnOVdEWlhvUjZWMFFNeUlmVUVPMXJja1g5TWxVODB2?=
 =?utf-8?Q?2Zo9Zp4AiTPnisKANEa0ekt14?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8777e718-e6a1-43b5-c92b-08dc388e4ed4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:51:44.1462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWu5mCtoYQM2lGI/uN+3VN3EZ2the0MEncBDtV0dMvPaw5zQu31eNVfrcPp2kSNribIZ0hOF83nif9Ss+rPaTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8242

On 2/28/2024 12:39, Alex Hung wrote:
> From: Muhammad Ahmed <ahmed.ahmed@amd.com>
> 
> [WHY]
> Blackscreen hang @ PC EF000025 when trying to wake up from S0i3. DCN
> gets powered off due to dc_power_down_on_boot() being called after
> timeout.
> 
> [HOW]
> Setting the power_down_on_boot function pointer to null since we don't
> expect the function to be called for APU.

Perhaps, should we be making the same change for other APUs?

It seems a few others call dcn10_power_down_on_boot() for the callback.

> 
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Acked-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
> index dce620d359a6..d4e0abbef28e 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
> @@ -39,7 +39,7 @@
>   static const struct hw_sequencer_funcs dcn35_funcs = {
>   	.program_gamut_remap = dcn30_program_gamut_remap,
>   	.init_hw = dcn35_init_hw,
> -	.power_down_on_boot = dcn35_power_down_on_boot,
> +	.power_down_on_boot = NULL,
>   	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
>   	.apply_ctx_for_surface = NULL,
>   	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,


