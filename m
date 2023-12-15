Return-Path: <stable+bounces-6850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFC7815402
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 23:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 361C5B20E32
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 22:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7120018027;
	Fri, 15 Dec 2023 22:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HQ8reMnW"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35F049F60
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 22:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcvIWeZzeOkLNESMyQHPRQQzS3DHghqAnL6Z26IAh5xSr6+GtuGW/1mpNNKqA8M7fBuvNOxdz5IUQwhWELbVBeuWRcqePwm3D6BGGHVUQalLWT5VKtXL1IYPus9aUC7acvYL/Tt4x0+kUOMPgILp+aRrq0wVv8YQ3xviwaERK4M9gH5efzxIjXZXI1L87eqozp2bYr+OSn0hCFpg22+jiGTNtcSzpJwAJXDDG86mg51CX05ufCYIEV5Ol7Yasg6Kpk48brbDE0j0o5bk0K+afH2he9nnRXem+ArfCa3VFw4mfm12Z4OfywAD6TT/BQ+5v9K4KfpZRfMC8Dm3WFIXyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2HdhAZuI637Nt703ZGKyEevpmX3I6Hnf00QMjWpmYA=;
 b=BHWcDOC/Ezr9326ips101P8Lq5b7BhrxpNflhUYQxI5TfCc6XYS4rYRXNlQTsHf6YcVSsDyCHDZx2cdQ+8YUIH8E7i2esUAUQFlxO6n74WsNoBGjWNi+3bZdwwDK5KtS0FcQHNZxeSWhuXQORxGrRaLXaN9RRsNd5T5ikQ3Yfedp3bnXiiOkVkfnM5mS9cxlw//RONniJtU70KM7dreA+u1oBIzpVwWUgS55/kSPiLnq4kIZR9le7A+9e2JPFXDX6Ua+wlMaK0HssPHWh4FR+GNt4CZXOfxxQzby6ZlrI1lprBKvU2DO65qFHLwl0hNWgC7iNREUgSL8JcjdxV9lAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2HdhAZuI637Nt703ZGKyEevpmX3I6Hnf00QMjWpmYA=;
 b=HQ8reMnW7M6G+TxMNjMXVuv+VJAl3RTzJrGr+mOhpFoL/TJFn3+sYoWgOhgmu56iTOoQM5qE39rWtlOj6oWgBd06xDw8N7Qog86Sj6dpHqmIMkLFSSjtsruGUUwGssmq+Qy47cTaMjUrkXlQlPcrfWgFgPNcTFwaS/KUy2hr1fg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 PH7PR12MB6586.namprd12.prod.outlook.com (2603:10b6:510:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 22:52:27 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::59a9:6428:ea3:2bb2]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::59a9:6428:ea3:2bb2%6]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 22:52:27 +0000
Message-ID: <5d42649b-7e59-4887-bccb-227d3d0cc213@amd.com>
Date: Fri, 15 Dec 2023 16:52:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: disable FPO and SubVP for older DMUB
 versions on DCN32x
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Leo Li <sunpeng.li@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Samson Tam
 <samson.tam@amd.com>, Saaem Rizvi <syedsaaem.rizvi@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 stable@vger.kernel.org, Jun Lei <jun.lei@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20231215160116.17012-1-hamza.mahfooz@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231215160116.17012-1-hamza.mahfooz@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:806:21::25) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|PH7PR12MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: a38b8a31-a464-4706-36c9-08dbfdc082d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ADfgNx73lqOsqJoOfobk7ZrXQB/0KIu6PsxZQNiZqHiCTz/wd4GmZkbPply1Y5yNaq3wk9ssgK0eSZ8IJHAaHlrFYGrtUgz0YIfFLQ/fCk94bQkHMrA8V684k6fziuyg11Ul3UjYc98JcOT4Eb7mIN/94fiPiRMkybKl3cZbUxzuXuLjDCgRE68GUhY388zRIxOpBIRsOiYPM//jE4JWljyivt78yAXYlEYIWpAszOH92EPpxD3sUwx5ddbkIDWj34yVEHUFhl6RLo5xVwtJcQ5wYJCsekwTAdEj0uW5AyecgNcHPHp3cF/iUbk63aBrlW/AVNLoPAw1IvKIdcVkMgFz0QKh/PbHuMF9q7DfZpfoSQqZeVI5yUsQJ9jV+JVAngOw6/pUBF8/q3DNM0ESb/IbbbrlClMLqzto93aJZjW/Tf6Wogm0aoti5Ej7bBEgoGQ9SnXNrEILR1D9h2MFism3Uap5zRg+700RD+7dttn6f0uK4CWjcscvwfG1cgl7irbhoVbgvRC1M08SZBEhg53Uo4OIUI1hi+ZHW8jAqNLVcsKibymQRF2M+0QNzt2EUOxlbhjriglztslmtX0Ud24YNrfsUw6peT/aXxNkWaPhzDZamhVCcxek2u5PEvfuT6ZoqTkkYID7yMuacfLPzLR3P52ped33lsOi+yXtipU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(39860400002)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(38100700002)(4326008)(8936002)(2906002)(316002)(83380400001)(36756003)(8676002)(5660300002)(44832011)(26005)(31686004)(41300700001)(31696002)(6512007)(2616005)(478600001)(6666004)(54906003)(6486002)(6506007)(966005)(53546011)(66556008)(66476007)(66946007)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1VNR0JwbTl4OGo5NGRDZ1ZJcXpUeGlQN2R1bDgvRVdVS3VuSkZ3bDR4YTk0?=
 =?utf-8?B?djNTQUYvN0hGNUVqRXVQbnAwSmlLWUx4ZC9EN1lOc21hekI4SFh3TkdjNW5s?=
 =?utf-8?B?UkNLaloxMlM3WjVvSzdLV2NNVjRpYXlweFNBWGwxRDYrWW05dGl2Vk12eUV6?=
 =?utf-8?B?YXlTNFU1d28vNnFTWVVhR3gxbTFjS0txSkd6Z3dWZXhQT3dvSEpLTzF3ZGxO?=
 =?utf-8?B?MzRLQVY5cmxXdnFOcHBmK3dmN3JTdHdWVkcwSGliMnVRZkFMMWt2V3k3cTBG?=
 =?utf-8?B?N2lvRjFFYWtLUDVPM0t5VUNFZjVobW13Tm95ZkRXNDUvekp4M2dZRDdLSGhm?=
 =?utf-8?B?U1IxaHMxTVdITVBqcXlBbnNVQnFwejhOOEZqdHRyQUJ0NEoyVlJMUUMyeUFC?=
 =?utf-8?B?Vk5SWkEzTVBZa1Ivdlg0cm15S2VtOEZSMTl1ZWt4bUVLcWFTKzBWR3NEblB1?=
 =?utf-8?B?VTArcVEzUUEvUjBjdEsxSEdMNFZ1czJoak5hUDhoaDluWHpiVkw2NmJqMStW?=
 =?utf-8?B?allMQ0RLeFVvZS9IWm9YOGJnOWdJNjNmY016Y0JUcGhUbXpyRi9Za0l4eE54?=
 =?utf-8?B?RXhwVTZYVGQ2UWdDOVRNdnA2ZHFwWkxvMXJrdUlvaGFBMFVEektUNVBvVEdw?=
 =?utf-8?B?cUVzN2lmV2VOaHMxZEt0aVpXN2dHK0x6ZXZqaFlrSFJsZlR2ZHMrTWw1VFVG?=
 =?utf-8?B?MkxjWkZjcXBXdEF2eVdFQkxGdHNsOFRwbHpQYlNhcXV6N1VoWWtPVktydEVs?=
 =?utf-8?B?dVY4azhuZDcvSUdZUEFybG5DcTNpOHRCUEVhTnhQQ2RFcEs3b0J3dCtkeUhO?=
 =?utf-8?B?ejcwNUdYRHVaY1FQaXZ5Tzh2aXlWdXB0NWJLTm80ZlRNNFBwbUc0OWR0NlRm?=
 =?utf-8?B?d3BxMTE1NVBSYzlRd1pRZm1wckVKSGY1MEtqamtTck1YOExKbExMdG91WnND?=
 =?utf-8?B?TU5HNzM2TWNyZHpZR29UMndiUlpUclV6WVgvWmdINk5yc3hNUnRhczE4S1Ry?=
 =?utf-8?B?QUN1QVh6d2t5YldTWk1NbHZHWGViY0JVMi8ybTAxcjRyaGdpcDhCRW9TT2lB?=
 =?utf-8?B?WDNtWUpnZjdaZWViNnIxS2Mxc1dvZWp4eExlTHFpQUsxMEh5YUxDYUJlRks4?=
 =?utf-8?B?MHVES3A2QXFmd25rN2luM0V4bHA5MkF1SVJZQzgySFRUeXdQSlBmR1BjM3Ry?=
 =?utf-8?B?WDVERktnaXh3a3JqL29CaWpBNmE2K2Nnd1FwZm5QOGNMQURvcG95SW1JT1V3?=
 =?utf-8?B?M1FZS1NLemM2SUxjTVNtbUpTR29ra2UxVTZOYVQvTDEyZmo3Y04zNnM1QmUy?=
 =?utf-8?B?WXl5aTVPZEpsQmxqL3lFWmV0ZU1kcjhjYjgwYjk5QzIxYlZKS01yb0pmNWlq?=
 =?utf-8?B?cnV5MzN6V01WWnlnQms5bW9vaFgyS3BRdU1keXRxSkQ2VjhBTFZWanZDdE9Q?=
 =?utf-8?B?NUdXOEQ5S3JIZUhpYUxQWU10RzRqc1lHRXBOVkhEZ0pDTWZCckZLb01lbllu?=
 =?utf-8?B?Z1NJWVNtbk1tWUFJTDNqMjk2MENIanIwQmI4MzZkbkRmLzk1bDRxKy9nZm5r?=
 =?utf-8?B?VGN6b2dOblVpdjBVRVhoaC83TDlZRUJxY1V0WWFJcjc0YkxxZWtWcXVzNmFB?=
 =?utf-8?B?NndyRzRmSERFcXdOaDN4TDRwQnZoamlDOHpBdzI1V283Y1NKVVhqaUpkV2JZ?=
 =?utf-8?B?aGgrZUkwYy8xcnBJNjJ4WjlCNmZUS2JkUzBaVHhCblVtbWhaTmwyR2pDVUZq?=
 =?utf-8?B?VXhKdUlSTkxDNElaejRhay9uanhYUE1hVHFqWW5nbTRGeXZWR2IvZ3RMZVZL?=
 =?utf-8?B?TmprUWw0TG5iZXM5YUJkQTc0WHZZTDJ3MExxVmloaXU5QWlReXlpUm53Y3dQ?=
 =?utf-8?B?TlE0dkNlWUQ0N0lScG1BdHhxaEdSdUhlTkkrSkFiMWsyYVpBRWkyQitWRmpH?=
 =?utf-8?B?VUt6VVJYSElwcDRRaStDSkNpZ3N4REhLTnJnWkxGNUR0RVdtZm1LVUUxeDlT?=
 =?utf-8?B?cyt1K3ZkYlRoTjFjSlozTmVQamFZaG41d3R6VjR5dnp2YmoybU82N2g1dWUr?=
 =?utf-8?B?Y2VqVEkrWmhtL25TaGRzUnp3dEJoNnhVbDBFVHl0TVJrN1NhWlNOM2dpc0pp?=
 =?utf-8?Q?Z5YayI/FmiM2nkxhahHoHI0PV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38b8a31-a464-4706-36c9-08dbfdc082d0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 22:52:27.5359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpG8mwmcJj5n2WKvVI35ERfRNutcuahU47lkUZn8Ji7aCHY6Hx9v89joqC8KBo28pFACOGpcY/lp792YbXXqxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6586

On 12/15/2023 10:01, Hamza Mahfooz wrote:
> There have recently been changes that break backwards compatibility,
> that were introduced into DMUB firmware (for DCN32x) concerning FPO and
> SubVP. So, since those are just power optimization features, we can just
> disable them unless the user is using a new enough version of DMUB
> firmware.
> 
> Cc: stable@vger.kernel.org
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2870
> Fixes: ed6e2782e974 ("drm/amd/display: For cursor P-State allow for SubVP")
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Closes: https://lore.kernel.org/r/CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com/
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> index 5c323718ec90..0f0972ad441a 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
> @@ -960,6 +960,12 @@ void dcn32_init_hw(struct dc *dc)
>   		dc->caps.dmub_caps.subvp_psr = dc->ctx->dmub_srv->dmub->feature_caps.subvp_psr_support;
>   		dc->caps.dmub_caps.gecc_enable = dc->ctx->dmub_srv->dmub->feature_caps.gecc_enable;
>   		dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch;
> +
> +		if (dc->ctx->dmub_srv->dmub->fw_version <
> +		    DMUB_FW_VERSION(7, 0, 35)) {
> +			dc->debug.force_disable_subvp = true;
> +			dc->debug.disable_fpo_optimizations = true;
> +		}

One potential improvement would be to emit a message in this case to let 
the user know that this has happened and if they upgrade their firmware 
they can get additional power optimizations.

>   	}
>   }
>   


