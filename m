Return-Path: <stable+bounces-75-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EB97F637E
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 17:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC12B210E1
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 16:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A1C3E461;
	Thu, 23 Nov 2023 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3mX3O/6R"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D7510D7
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 08:00:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgBjkr4ydIUeXohElJfReCw0C8T9D2oFZsa486ObwRHdD1IkLsuxkXwIp2eJZWDtSeP7A/3PYso8w5DuRyulkpL67jmA3zdbrZNkwzPNtSJ+Yj1LpNK9vBoL2KhjdMnx287HoPQvV18hAQ/fMxXF8hfIENFHo+MOQaOyOAsbbCSp/LBptZDvS3x56G4of2GOFz7AvqeWWFlzD2LEhzJU6waugmNJhhdPbfQmRkJSFJ8ZWfI2fPOeNlzteGvzKRnu3G0toCyFoccFFtQNwV28i3tVfB2Hq5dhVcEwQ/Q0KhNHwRnb7BExPHHKtS1irRL2ArlCUG0axlUFI1P4sU/sWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qy//WPxLlUPtQUZOHTTy0og7xxWOstpktdIZxu/lyDU=;
 b=oP/p/QqpLsGmtI6UrVdKnw4V4r4YYvdM3NP7Oh2N7lpuXzlZl7n6QmI3iTZW05lIjKVYXuspPPeX6NqhsT8Z9f3lM0O8xkr4XFabgu1cReOCSGaZP7BWoI+ZGc4NgXH+DVkTzgivV/vYDtt2FhLxJdgHPebylawPoxKSGD/bYZ/XurbDdZ6Q5alhWlabO73heD0SPFrKJlm/P8P2QPzoo8biL3CnSPFj+FTjzDk6RaeO4Z/1jK9ds0W2BtGW6bycaY2ELoJHeGtM+DhqkL7nXX0iYrpVouA8MIWofdIhiE9k99x27eNIBpp6AQmiI7JtOuKmAz4MGOjSFY/B02cU7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qy//WPxLlUPtQUZOHTTy0og7xxWOstpktdIZxu/lyDU=;
 b=3mX3O/6REcVcBbSlm0K3YVcSOxawqU6Dzjr0CxbSEg7hNTTPZayC3qUs0GBihvruZ66YI0BFryvmsF50akTzq674TT0VwHtmd2erx0sh1I1sZP1narmoaOICtbjmSjOTu2Rg0jUUKxL6POsYsnIXMl5sEAH8eA3TteitPYDHdiM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 SJ2PR12MB7799.namprd12.prod.outlook.com (2603:10b6:a03:4d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 16:00:41 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5358:4ba6:417e:c368]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5358:4ba6:417e:c368%6]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 16:00:40 +0000
Message-ID: <d4536bfa-9b67-406b-b5e9-b27494b93099@amd.com>
Date: Thu, 23 Nov 2023 11:00:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: fix ABM disablement
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 stable@vger.kernel.org
References: <20231122222409.53901-1-hamza.mahfooz@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20231122222409.53901-1-hamza.mahfooz@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::40) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|SJ2PR12MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: 896c896e-dc00-43a1-f66f-08dbec3d5763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bdC1q+Vq/AHn/NScNq1+DzlYuVGWGP2ol6+mh+eE2xBejoW5sJBO7veL4tHM7HPUnUzp9aJot67U7OjsxoCOoTKPSvp/8yEqYBegwFz0PREZi3i8r9JZIqBCDDzifvcvHI+3g4ADAfwFSaP9ZEgH0Q8Z0pBr3PGo1h579I1y3ak8eq//oHsrJomwk88UPkGg5bC0G/ovBy6xmbAWIe3PfX9JUJXMdmYhh8qstGTA6kwCVkRo/F5402oFJjhnfQ5wlOfnKOHf1a14FmJcQsq3N8IQzTQujg8Y9oW+AnuUtzZzgWmobnrcY3A0fyw1FJankV7Hs8yx+Yzi1M/pEq1dqhwy7UwQWCYq2jKdtYoAUcw61TH3GRpeAGezD7ZQXUnSMLBug4FJRGWHks2WIi/x7u+QlIUUJKbatHCWBQwYt1/HsF+cNGS4ReIe9QRf+4xIZnUqURHvyaeMVz1+79lIclyjrO5N5nFy/iQjEihY+TfZdv90R/89p5nF4wFyLuz2qVHrqqfNYa+g8T5M9YFqDuwfBkcQPKMFBeF4heWTV0xKdYv+7N++OJPpnIzm4kBUHPL6yQ8nB1YwNncF3N1eVFnxSQWlI3oo109RmW0a+IgDo3OJF8wWMR59Ka+MiYXWb+DW9iGH5Vn5kLRjR8hVpg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6280.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(6512007)(2616005)(26005)(316002)(38100700002)(8936002)(66556008)(54906003)(66476007)(6916009)(66946007)(4326008)(8676002)(6486002)(6506007)(83380400001)(478600001)(53546011)(44832011)(5660300002)(31696002)(41300700001)(86362001)(36756003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnp2MGR1c2xXYUJPanI1Q21jalBoUVVJSjVMcWNtcVpBNW13M292WG5mNzNN?=
 =?utf-8?B?bTBUd3pVSWp4T0Fkc09hdURxZVdKdXE5UU9OUVpwNWtseTgwUnNmcW16dWlv?=
 =?utf-8?B?c25PNEhmMHpvdWhleGtUSkE3cnVoZVloVDdXSkE1b1lxN1paekJ6UGliRjdI?=
 =?utf-8?B?R0ZTR0tuWGY0YkZZN0haY1haaTRGMlh6SldYbVFnbmNWVlFERmxZY1BZeURL?=
 =?utf-8?B?V2lCWklVdHBlSTZseHBzNVpSWm5Hck9rVDVXR3ZibFczOE1McUtHSWxYaGQv?=
 =?utf-8?B?Wm5wZDRPd29NZUNqS0E1Vkl6cU0vZllVN1NsbTRqTGM0RTRRS3Vob0NaaEVo?=
 =?utf-8?B?Z2xRdThoeTU5eng4Ui9NZ1hxemo5YzFNOVJOSGpBa3hSVlBHcnZuMUJJOXFO?=
 =?utf-8?B?emhRaytiYXhOTWFPeVkzSmhiVWVYVmNTWkRjMmtaRUE1Mzd4UHY3NmVlWGJL?=
 =?utf-8?B?S0xJclFpcXBJWjF2ZHBsOGpvUklUN3N1czlaOFFLQ0VZSnVlaFhxa01JeEJK?=
 =?utf-8?B?K2pSRlRsY243ai9heFMzblYvYkVQUG5URGR3dVB3NHZxNUtyRHp6NC9JcWpV?=
 =?utf-8?B?aUMyZ25CMUlLVlFSeFU3ZUptbFBEUmI3NHNHbXNydW5jSjZrbzJRbzVCMXBW?=
 =?utf-8?B?VDRvd05OK0NpclNsM2J2YVV0R3E4YVFRbTlrRi9KcTlEU0pDTUt4RTU5WmV1?=
 =?utf-8?B?Q0drck5rTjhQTTBlTmVQOHZudjRBNStic2pwdDY0cWtQaVhVZ2Q4TUxjL3VV?=
 =?utf-8?B?ZWhXeGdJRTQyQ3NlYk41ZXcvSzF2eVhlMVpKZnZVUmNzQzBJaFpQSnY1cDJj?=
 =?utf-8?B?MS9VZmtqMVJxUC9NK2U1OTRIRUxDMGxxQ0RubG53NzZaZXRUdG5SbDF3dE42?=
 =?utf-8?B?eEcyMHg1a25kMS9Yb2FZNXNTT1Rsd3JBVUZtbzhIU2ExRVRZaVdvQmdJUk8v?=
 =?utf-8?B?clJXWjg0Ykp3QUdEKzN3ckdxVXYybzM4NVZsOGRpVC91Mnp0K1dIV3luMGs1?=
 =?utf-8?B?S2RRUGlJK2tPN1pxY2pkU1pFbzMzUWJjQmUyb3hUZDlINDVCc1pScGYrMzVH?=
 =?utf-8?B?V1NJYkVJV2pOMHJtSXhYWGp6SnRuQmNXeHp6Y1AyRmJmRFJKM2hTTFhySnZ3?=
 =?utf-8?B?OWJEQklzWjFmdTB3dVRmMlJndGdYZG9xY0E3RkJ4b0c5cnJPZHRtNnIxVkl5?=
 =?utf-8?B?ZEgyY05Md28vanNzYmZqVXladklqQXJuUDA5OXVBUDZGYVBnSWxOOHByVVZZ?=
 =?utf-8?B?eHY3ajMzTlI0NjhZOUUvZWZCS25qMjBVTDR0OVVqS3phbGhja25YYlA2d3Zi?=
 =?utf-8?B?Nk9YUG40QTdYaFdrSWllWTZJY3E5Wkd0eXVIcFV2cHk3dmZrZU1KU3VWWVZY?=
 =?utf-8?B?VXZTMlUybGppL01saGw3TzkvTUJOWTR2RW5GckN4MHo0bUlBM1RYNnZkMmF1?=
 =?utf-8?B?N0pLQVNRYnZaN2NURmxoRmNxbncrMlFIUEVtK2JmSTZCVWVJbS9nZWFJUWtu?=
 =?utf-8?B?ZDFUeitOMFIyUTFyQmlHN0NFbzBTZkpzakZVU3o4NlM3STYyaXVNNTVWcllT?=
 =?utf-8?B?V1B5YXJpU2NLdkRjVER1cU1YWG0rYXZJaEtwSmcyTldKdHNoQkNTR1lIakJo?=
 =?utf-8?B?TmpKSzJudnNsVnRNdFJVRnBYeVIwTlpUa1FhSytPeHRpYVd3Y3Q0Sk4zTFpP?=
 =?utf-8?B?U3N2Wi9MVkd5Vi9GQlYvcDdPays1VGo4enIwNitJWStEUUlqZi8zVTVvcUoy?=
 =?utf-8?B?WWlpVWZFV21FSGVIdk5nQS8rRlpxeWpuQnZlWlZNQ1BxV3hJY2YxOFl0KytP?=
 =?utf-8?B?d0N1MVR1eE12QnRwVE1YZW1oNUNmK0lkZ0paOS9DYmpiajE2NDU3Tjd1Wlc4?=
 =?utf-8?B?ZzVwS3Y4NFJmbmNVVE13SExVUE0rdW5wZmpseGVRV0V0bllrQnlodjQ3SGZH?=
 =?utf-8?B?U21jcFlGZ1NVNHFwV011dzgvZTQ0bDNsRjhzS2tMTEl1WERuWXZPWXVpWG5F?=
 =?utf-8?B?MzNzekQ0Q1VVQlV3VDR4SS9NMVZxL3NMT1ZuTlJJbHEwMlJDQWMwTTUvTFhJ?=
 =?utf-8?B?S1d0MU4waitGV2owNy9VSzc1d1loc2JReW91d2hTODBRZjh2clBtd3Nla0RY?=
 =?utf-8?Q?hTt3SMXIWz9TZv3Kt1XNPjBkU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 896c896e-dc00-43a1-f66f-08dbec3d5763
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 16:00:40.7912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9SAYEpJ7Ewxz5dc3dk2OrkmNOD5Ab2ZLo0C0TnGNZAMr6Ocsragk+T/zHgSn05akSC2gwgYWOl/KuYs+W2PR+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7799

On 11/22/23 17:24, Hamza Mahfooz wrote:
> On recent versions of DMUB firmware, if we want to completely disable
> ABM we have to pass ABM_LEVEL_IMMEDIATE_DISABLE as the requested ABM
> level to DMUB. Otherwise, LCD eDP displays are unable to reach their
> maximum brightness levels. So, to fix this whenever the user requests an
> ABM level of 0 pass ABM_LEVEL_IMMEDIATE_DISABLE to DMUB instead. Also,
> to keep the user's experience consistent map ABM_LEVEL_IMMEDIATE_DISABLE
> to 0 when a user tries to read the requested ABM level.
> 
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

Cc: stable@vger.kernel.org # 6.1+

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 5d9496db0ecb..8cb92d941cd9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6230,7 +6230,7 @@ int amdgpu_dm_connector_atomic_set_property(struct drm_connector *connector,
>   		dm_new_state->underscan_enable = val;
>   		ret = 0;
>   	} else if (property == adev->mode_info.abm_level_property) {
> -		dm_new_state->abm_level = val;
> +		dm_new_state->abm_level = val ?: ABM_LEVEL_IMMEDIATE_DISABLE;
>   		ret = 0;
>   	}
>   
> @@ -6275,7 +6275,8 @@ int amdgpu_dm_connector_atomic_get_property(struct drm_connector *connector,
>   		*val = dm_state->underscan_enable;
>   		ret = 0;
>   	} else if (property == adev->mode_info.abm_level_property) {
> -		*val = dm_state->abm_level;
> +		*val = (dm_state->abm_level != ABM_LEVEL_IMMEDIATE_DISABLE) ?
> +			dm_state->abm_level : 0;
>   		ret = 0;
>   	}
>   
> @@ -6348,7 +6349,8 @@ void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)
>   		state->pbn = 0;
>   
>   		if (connector->connector_type == DRM_MODE_CONNECTOR_eDP)
> -			state->abm_level = amdgpu_dm_abm_level;
> +			state->abm_level = amdgpu_dm_abm_level ?:
> +				ABM_LEVEL_IMMEDIATE_DISABLE;
>   
>   		__drm_atomic_helper_connector_reset(connector, &state->base);
>   	}
-- 
Hamza


