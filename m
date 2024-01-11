Return-Path: <stable+bounces-10533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF19182B51B
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 20:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0F251C239BE
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 19:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456EA54BCE;
	Thu, 11 Jan 2024 19:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nLQOAdo2"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A50615E9B
	for <stable@vger.kernel.org>; Thu, 11 Jan 2024 19:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYmYYeZRD8TfFI3umUcflKWz3+mNXkR9M67FMvZeITAxIqkGq6ZdFIVqbGvU6WfX5rJ+OX+h2ZfhSmXHQsmetd1awMY6Wz7xj/o4jW96FhF5ejjgr2f2dufD0FjUUgpKQLCST7lVEjTXv6rbjjMtRB4f5EMKpOUwfnXbEEsM7tp6WBnlpXuJK08eqpBgyKmV0pAZgr7RVq7UqPejPSWSoe0eBIZHUetULaub9CIE1dbHEbnnrpwMkMGV/QTWtxAvIfw/a/Ma9Pvu9VNDR5i42pn4ObIwNrLV01m0yhNWiAH9yBaUPwDcDP0DGwWCXd65aEmAjAGKkgJRz5cCwY4dJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqNpRemcPO6SHq5OqRae+5I+2b1aaHueFbQtX+B5Lb0=;
 b=HiBdxaYbtiYEsPPtda6I1qdrqAL6Z/NNmDC/btW6IMTIKf4Bn7eydbiIzOhJSv7lywV44WJg2o86xDcYFlhx/K1pp+0cHqveY/y1tgE98aAVFcT1T49HQScA28IkKwVYNhAPQ49KuJsY5mSRyh3ylytezc6Qj2CAZpqtEysMDXmzD/oKHUSERBjgu6+NRuhfTUrfqWzmYjSPqlWfrJdRb4Rvh5Rl9bg/5MxNOa4SfNqGplBvCo5dkZRLf5zCotcanuPoQFaPwfq4LH+yeY8mCw/y8pWqzlW6CJP5Q950/ag1bA03CIIHgHsaCu09pjUH38PyInTem6u5pQ88dG3zbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqNpRemcPO6SHq5OqRae+5I+2b1aaHueFbQtX+B5Lb0=;
 b=nLQOAdo2q7m9pO34h+lJiVcIkk1KFd7jKOz3Ja/zwG4Q2j4bKwMFt9hFKMU3qzyhtEawAWvAdiLaf6jr2398Gf4HN/4c3Z2JNOKJMcruwrzhnXIwXgQgFm/louQNdm/XCmX7KfFIocnWWP7JlXXKDLn67kDVCxxIDWhXt/72n2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.18; Thu, 11 Jan
 2024 19:15:52 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::dd5e:e866:b2c4:2c05]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::dd5e:e866:b2c4:2c05%6]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 19:15:52 +0000
Message-ID: <93632773-9db5-4bd5-842c-6a13cb36d2b3@amd.com>
Date: Thu, 11 Jan 2024 14:15:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Fix late derefrence 'dsc' check in
 'link_set_dsc_pps_packet()'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>
References: <20240111175723.2807563-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20240111175723.2807563-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::29) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|DS7PR12MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d2c6feb-4190-405c-dcd4-08dc12d9ba50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c1NPuwJ016U4HcVV6ArGlEZvm5HKfH/YYRs/zWNduyhmWmuABxCcs3E3drSuj5UKhs/nlJ5AKto4XVNHEAz7LEU/kcAXmOlWk+9Qt6/Kj0927MVTa63z0lnuxVoOVDASPS95T+Vvflt7Tu0qgKesXi84W2lBiZndyPY6bAYVdaDVRJkgScMbn96O1x0KFVKbXppkEcJqLgu318qxfAHnJsIt0cYlZkaYgOPsUo6F8THIpweqmSJ4OhHTBNFdc/xCvc74iPaPN7Y/D6OM+UgH49WRVmGayd81U/UiTuc9gyOzzk83kpUv7gEj6MRDPXbFkKbWEPvvW85sxag/JexY7NSOnjHt5RNkTcVk99SQD1SyYb7za0+xxGTxb06O7ermqlpG1g+3wx7PpX2K5pD6mO8x6wq4eewmbHaDAgG4QhRTwNhcP4GDVrWA+FrNxF/VMFhE8rQEymh5Tdl5EUgtGuBdVC58nzj/s3sVkw7G34SYoCbwEHRuQot2q4fjJvfwiCLDlWPUsIyKYZ7JoQbp7h/BA/gjP0Wp/H+Qyc3moHFD04YJKiERzbQN3LLc6d7pzoyIfWGd+OLoydnZ4LoQuZDapmWUVgLD5NOVRyP3bLATjXCshPyEvLdsaWT0FAWgLtHu9xIpWfd+qMj83tuZzA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5284.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(6512007)(6506007)(53546011)(26005)(44832011)(83380400001)(86362001)(36756003)(2616005)(8936002)(8676002)(2906002)(41300700001)(38100700002)(5660300002)(31696002)(4326008)(6486002)(6636002)(66476007)(478600001)(66946007)(316002)(66556008)(31686004)(54906003)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXVnT0tSSmpvYmdjOUFlUXlpT29DQjIra0NkUDRsWW9Qa3gxeFNiVlBVNG41?=
 =?utf-8?B?NkNiMnVGT0JuNjVlZ09ZcExsVDByaUYrNUNyejNJY0xheEk4RlgzUVE5ak1I?=
 =?utf-8?B?dkcraDJKM2piYnhFSUxxVm1jZkRvb3JlVGdiaTM5dUFkMElsVU43Y29sR3Y3?=
 =?utf-8?B?RVlQRElHMkZFd0Z6TXZSa1JMQVFLQjZGc1hWMnRDVm5seWIxUmF0VDVERVlB?=
 =?utf-8?B?VGpJQWRRSGwxLy96S2Q0Q0RDWkZEdThFRnNaNm5HNG9lbDd3ektFNFF6MUxv?=
 =?utf-8?B?dmFkWFVJV2tzYjJWZTBaV0NZWEdOS1RiQmRjb1FFNndoUGxXZDlUQlpLODFh?=
 =?utf-8?B?TkZNTit1bHJMejg0ZFlNYVFPbGZ6dlBBSHhVTEc3QXdCSmNMaFB6RFhzWkl4?=
 =?utf-8?B?UlJDUENXVmIxVGp2Zll6aUxua1k4NnRnKzhsU1F1RGFKQ1FUeklYdG5haFMx?=
 =?utf-8?B?eE02S20rQXlsc0g3c05TemxON2FlTEltNStzTGwxNjlqWndCL0JrOXY1SGxO?=
 =?utf-8?B?TVlCUTFHWVdLb1BsQVVoeWpIRkRyZUdnM1pMdjhoUjhYd21UVSt6QTlSMWda?=
 =?utf-8?B?eEpvb3NNWGtlUE5mL2ZGeDdVK2FCeFRwcU9EUlR3YTRrcytIYkNHR3lUYjFB?=
 =?utf-8?B?aE9aZm44M1hQbk5lekI5K0JuNjRDMUVTSE5OajVENFBKNFJDSzhOUmVmc0Zy?=
 =?utf-8?B?RkpBdWtndjFrZWN0a3l5eVRYUjBLeGR2cHpPZ2dvMHZFQ2FCVWlPSkVRRDI5?=
 =?utf-8?B?cVlUY3VrM2VhbmlrYXh3ZEN5cncyZnNKS05xa0RuK1JweTNDclJvOGI2MHZk?=
 =?utf-8?B?NHRCa21LWlRLQVZPa01NZkRHNit3b3NnZjFrK3haOVk0SFgrbm1KKzJraFpO?=
 =?utf-8?B?bzhJV1JzOXFjckJwdjcvSkR3QXkvK1FYNjlkWmZDd09zRjNUakVZN05QQ3V5?=
 =?utf-8?B?cXFmaGYyWUxYVnUzTzhzM1U3UXJEY2FZL1d0V2hQNG84dUlhQkkrM3o4L0xO?=
 =?utf-8?B?clorUm5BV2VEemF3enRaN1NJQjhndWJ0SEFaL2ZOcEE2UDhlWUd3QUs4UkNG?=
 =?utf-8?B?N0JJaHdFa1d5a2IvMUxreXE5QlVnNnZOd283dUJLZEQ2bGtOQjZNZmVndWkx?=
 =?utf-8?B?Uk1WeUZEOEk3T0dCSTdkSHpnTStpNVBNMmNaQnA0aHFXejIxRWVPOXQ5NlBl?=
 =?utf-8?B?eldKeW1DaFNZbWk1RXFnaTVTc0krWFdQZXlDVUhzek1qTnBjQkNnRDJkZzNZ?=
 =?utf-8?B?RFZvN3BnQmJ5YU5sOStwQWxLZEZ1WGhNL2NZckViVGFYdUdCRWY1MDZEc01r?=
 =?utf-8?B?cHpveHk4cjF0cER0RDY3ZGNhRUlnNndOekJPNTFUb2Yxay9uZVV5TnhJUXBK?=
 =?utf-8?B?RDE1cmZLRUNIUndZYWN2dDBIaXhIeExDUUphbWdwbXZPYkxLUDdlbWhEeVVW?=
 =?utf-8?B?NTR6Rmc3ZmNrWE05RDdzSmR5bXFpbXEyNy9BVEtTRUs5bmQrRGNYSkFncVhn?=
 =?utf-8?B?SElzaDFpU3ZSQmwwc2JmNFVzeUptUXR4Z2luWUpzM2xndmJ5NXhFdTZ5SHow?=
 =?utf-8?B?RGRadjEreDZYcjRhWEhsUU1sUnZEQkxBNUFCTWFmNUk0QUpncHFkSGVZcGNl?=
 =?utf-8?B?V2xYc1hESE9ja0lMeVdjVCtNWjRmdHpCeFBBRzBzTVRnMzF2K2ZGRHJyZGVy?=
 =?utf-8?B?T2ZtNkZmcmpkNWxxL3k0aDJZWStYblExbVZVUHdBVnphdk5BcFI1dkZORU5C?=
 =?utf-8?B?YW41R3VQM2dKakpJWlFpRmF5YkwwL1VPMnlzUkkvdThoaDFNVk55VkEydDJO?=
 =?utf-8?B?TjBBY2hwdTVHeGFLMzlwN3N4aUxLNFlUTXdYSVROaTlEL3huQyt5empNb0JQ?=
 =?utf-8?B?YW5oN0tIYUd0M0xJTklTTzByaWJPL1EzZWpPTXNFWnhFMDRoaGpxRzU3Q0hE?=
 =?utf-8?B?bVAzOFAxaTNqTFdxMlluTTh4LzZOU0kzMEJHMFZlbmZTL1RWZVpuNVNaOGxI?=
 =?utf-8?B?ZVVCWXhiNWFPM1JaV1JUOTdqUUYyS3MwUU5NTWgzdVpMb2gvalh1aVRRZkdI?=
 =?utf-8?B?N1k0YnVJam1QZEM0cmxyazk5VUh3aXZVUytLaEJEQW1rOHl3VHFUSWJxdmZo?=
 =?utf-8?Q?hzuE0wYkb5fUkj1RCGetuF45P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2c6feb-4190-405c-dcd4-08dc12d9ba50
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 19:15:52.5144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vV6QJkt+yte+Uzu0+g8byL9/S+eA4mazXw2X3gUF0QoFpOc3nDsu7+2BNMxV4t1dys5xAU8hHOR9bEiE0GlcNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189



On 2024-01-11 12:57, Srinivasan Shanmugam wrote:
> In link_set_dsc_pps_packet(), 'struct display_stream_compressor *dsc'
> was dereferenced in a DC_LOGGER_INIT(dsc->ctx->logger); before the 'dsc'
> NULL pointer check.
> 
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dpms.c:905 link_set_dsc_pps_packet() warn: variable dereferenced before check 'dsc' (see line 903)
> 
> Cc: stable@vger.kernel.org
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Cc: Wenjing Liu <wenjing.liu@amd.com>
> Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> v2:
>   - Corrected the logic when !pipe_ctx->stream->timing.flags.DSC is true,
>     still skipping the !dsc NULL check
> 
>   drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> index 3de148004c06..d084ac0d30b2 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> @@ -900,11 +900,15 @@ bool link_set_dsc_pps_packet(struct pipe_ctx *pipe_ctx, bool enable, bool immedi
>   {
>   	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
>   	struct dc_stream_state *stream = pipe_ctx->stream;
> -	DC_LOGGER_INIT(dsc->ctx->logger);
>   
> -	if (!pipe_ctx->stream->timing.flags.DSC || !dsc)
> +	if (!pipe_ctx->stream->timing.flags.DSC)
> +		return false;
> +
> +	if(!dsc)
>   		return false;
>   
> +	DC_LOGGER_INIT(dsc->ctx->logger);
> +
>   	if (enable) {
>   		struct dsc_config dsc_cfg;
>   		uint8_t dsc_packed_pps[128];

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

