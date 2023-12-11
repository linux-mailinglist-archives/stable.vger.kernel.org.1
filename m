Return-Path: <stable+bounces-5508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5EE80D0D2
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 17:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E29691C21495
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 16:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBD74C613;
	Mon, 11 Dec 2023 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dzKDbRUn"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E2F199F
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 08:15:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwfMpWEBGx4qrAiwXX7kyiqQSG0ST8U7LaPvhp+KVPPcwuhTgA2ifkBLfU3DOH4L123AjJ5NHTDw5omsDDRiytJ9/Z91TApErHR21/rZXE1A7gY/KXZD6oFBaxNbbbOVvMYiaix0hcZT7z1N9mDInbBKpWwtFHLI0fqc+Wbwoc8ggv1sdfg/U6VNau/3YU5plX6xF3arM1KkMTjZ10MDmwHRJARNT8Yhpgf+8q7QuJjIyH7a55r3Ig9fwx+Yu3IWUrcJvpRWrNuAK60ivc2k9ni0tMKhBGTxS5ohUxfi2c0kjqxiaBtYu5lhK97X7vK2d65VLz+bsuj9kSNOm9bGpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amgQ4tNwviDXL/PoCKFdk9xGJgTVKWdK8ttUl3OV9UA=;
 b=IrodR+wrAyPXd+SjmO1A2xzZO3ECRMF1j9UX8BYqG4xWNsC1QKv1Zjj0VT/O6QudZ2oKYNOUIND5jkHFtRIcOHan+fFu+JxM9ovMuIxHASRPMTb88fB8NmWaH3w/pWYAMQU4DmAouU7efGtvARlMDISVzLi/T+emL0fYD8yr6sOaVV31rbvPnDBrjmNplDEDkH7ctvPG4SpzhSas+/ktFagIT+UvvdCl2b6rA1EnhQl1qy24Y3A6PvcQKSWShm/qoaqc1BoD3RHPBOfNq6SbIShinCqrRI7AVO1GLc7Xmkbp7K8oimr0/92AQmTZURsU5CecAx1hEJYy53d0GGqNug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amgQ4tNwviDXL/PoCKFdk9xGJgTVKWdK8ttUl3OV9UA=;
 b=dzKDbRUnIAkPclnH5iOHVIaP5WM4BEoDTSlaCQVWEtbH2Xc23dNGhrlqAKdkW0qbwr8Q+wlWnw35XR+DTL3zju6hJ2LFB2xSX08vt/9pi8sZnT6edSNSXzdIOtZheUpWiX8PWPhpwTqhJ+ZVVguUhu1sfEPdDQlzMN+IKmBL+Gw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB6726.namprd12.prod.outlook.com (2603:10b6:806:255::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 16:15:02 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7068.033; Mon, 11 Dec 2023
 16:15:01 +0000
Message-ID: <6e941b94-f3e0-4463-82cf-13bac0d22ebe@amd.com>
Date: Mon, 11 Dec 2023 10:14:59 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amd/display: Adjust the MST resume flow"
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org, "Wentland, Harry" <Harry.Wentland@amd.com>
Cc: Linux Regressions <regressions@lists.linux.dev>, stable@vger.kernel.org,
 Daniel Wheeler <daniel.wheeler@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 Oliver Schmidt <oliver@luced.de>
References: <20231205195436.16081-1-mario.limonciello@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231205195436.16081-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:5:334::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: 55582fe5-4852-4caf-6cdd-08dbfa6453f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N0nPJxz+l49gl9/m/2MlUsKXqeQpwjoYraO+Fq/3yjccQTERf7Zib7+Kcrz9U1Xr8zo6R+owmsFncgOcKNFPsK1qBjJBmaWWYFCKjsxURg/Fb/VyrGjx908jGogk++UKwsDe7xidIqPKlTTydX2zu4USgJ3rb0mZFJmtPi2nO/GFTR9pkiaArgJLLmEZJ0ie3QKhS4xQuFROpEZETitgGbqGGvR3SydVutZOPv4o0yLpj+OoPtkO+oyYgxUpxjX81FEz7Ng/mrWxSt7zAXjFwb1r3Q+RLdJKo69SimAIMGUPw4dLE9cPnaKSQcithD5TLSLIZ0jAEAUZ2oD6RHa73vKbvi1NkE4DWnU1bfRT1zxpDTXBR3ZUUrNG7FXfskeyCh2hQ6q2t5u2wY55Tj3WdGDaX83V1A1SwchVVjdi1pBOw+j9nKUmAAkqP2SJKr/ZQV2BmqraiZm7vpxFeSnCHopNwVkS9bwciOIHlymIXmsPqeBWsrtumgqN9JVP/l5qEUTrQlicoBwQWUuPWRQvTLEBDyguVnVf42254R1SDaTOA8IzDH3PtMU50CPJj/f4dowe+gkhxYQtlOKIV5IuOoJHEJ1iZujB/hq2os/roiNC39rC7QkCAy1xWzqiWnNpNm79nGzd58QJnhmECbbv9GCmmSiR3kqPNKwWM2vR4DlhXSPin5IkzxSXodGHiMqZaTAONpjw4h2Zgt/qD+SkUA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(230273577357003)(230173577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(53546011)(6506007)(5660300002)(26005)(2616005)(44832011)(36756003)(66946007)(6486002)(54906003)(66476007)(66556008)(6636002)(966005)(2906002)(83380400001)(31686004)(41300700001)(478600001)(86362001)(8676002)(8936002)(6862004)(4326008)(31696002)(316002)(38100700002)(37006003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEc3RnFPS2Z6VFE4S1o3ektRKzBEVEtaSUFiWlo0cmRNdTRxVW9tcDdEU3g4?=
 =?utf-8?B?ZDdrRXI4M3RpZVFBa1FpYThHVzk5WHF3ZnUrVkdHOTdVeExNTHlvUTdnZ3B1?=
 =?utf-8?B?azcyUjF0TFl0dnkwZm5sOExLRWpuaFI4SllxdFpST1dpZitNeFk5L0RXcEVK?=
 =?utf-8?B?K2xLTXFvTTV6aTdlQWNJWGxDbjg1NnVZc2IzUkI5eU03TlRsSDhrWlprb3JP?=
 =?utf-8?B?OExBczlQYVNDeTFaM2xWbGc5T3VmK25QRmhacDNFU2w1akZHWDY0K1pyQXlB?=
 =?utf-8?B?UStMeS96MUI4azFKMm80cGZHanVBSWdQazVUUkFFL3IvS1U0aVRoaXJWOWtr?=
 =?utf-8?B?K3hwRC9WeGV1anBpZStPRC9HeVRMYUhRaTZsenZ0Qk5YeFVJT040NVhncnVo?=
 =?utf-8?B?WkgrUEYza0FRMVJsSFcraWl0ZnZXaDdiK3dpQ0UyVXVlTUlNMTRnbTVZei9N?=
 =?utf-8?B?REtjeDlNaHdscUIvTW45eVNObWJNWXprR0g1S1FGM3lOdWxnUjAyMEZTQnM2?=
 =?utf-8?B?b1gwSkI4MnRWOXdQUDg1SXJTUEZTMGxzNTFVb3c4NEs5Q1FVNkxmQktEUnZM?=
 =?utf-8?B?RWNTTFBQN2FsdkwvVEtZVGttVnVWcEhHZXFRK29Cd29lVitpelZOK0lWRXRh?=
 =?utf-8?B?TmU5RWF1RGc3cHErcXhYYXZYQ2FYN05ZM3lMTXhMLy90dHM3VDZreXh1RUNK?=
 =?utf-8?B?YUtaS3NVRGRhU2k1MGhveXVnSFVUV2xkNFhBdDJnZmdVQlhmU3hKb3R1UERR?=
 =?utf-8?B?MU1ONkttZEZobFUrN3F1RU8zVjBJekNnbXJMZm1aSGRheVI2RnVaaGUyVXJ1?=
 =?utf-8?B?bVp0djBFbnJWLzByTXdRcDJCaXZ4V2doZmF3am9LcHcrNkFZRlF0OWlTSmV1?=
 =?utf-8?B?MDdrazVYVDVHUGkveEdQTittY3ZhbEt5WlZwYnRzNElFVy9zWnhWQlZyOTRC?=
 =?utf-8?B?L05GQ0pkZDduemtOQnVZMCtvUFhoRTR1TU1vTkd2RUtKWFdoblhFN0YzV1E1?=
 =?utf-8?B?ZVVOanZzcU5DRmgvelhaUnZ3MFpwUDFLR2ZQeEV1RU9BT3hWVDh1dVJGRWwy?=
 =?utf-8?B?c2RkQUI3d0lRMFgyN0l0dVFRVjZnZE5IRjliTTB5UlhCeGgzUVVSYzJ3cDlC?=
 =?utf-8?B?clZDMjRuU3FNWm4wRGlWNldKT1poYkhEU1EvREc0MWdsS3plMGZ4V21zOWs3?=
 =?utf-8?B?ZW1vbFh3bzh0T25pbUMwN25zVjE0YUlSeVFkRlE0WUFtOW9BT1pYR3FRbFls?=
 =?utf-8?B?ckhKdG9vVktwbmYwUU9wQ3dVckJQalR1eVZPOGh2RDBBV2pCdWdnQ0VyRWM5?=
 =?utf-8?B?RlpDTTRsa1FHNnZDYkFLTnRQL3AzMTF3dFpWY0FGeExoWmVuWWJiWEhVL3FN?=
 =?utf-8?B?YzlqQm16aDdHait3MUdzRjJXZ0FieHFsVWhIYnUvVVZoUnAyV1NsaExQUzJt?=
 =?utf-8?B?WWpMRTZYNHlLaXJrM0pRZFBEbjkyVU9CeWFiWUpXQUl2cS93OEdHWFNQc2tF?=
 =?utf-8?B?Yk82dm40SUxpMS9jMnlSTm9lQU4zcVNZMHp6MmNBbklocy9QL3VpL2pST0Ju?=
 =?utf-8?B?dlRPY1ptazdIZ0hlUGI2ZWtiWVlZNlBqcXYrMU9sZzF3ZTdTUFRhS051WUpN?=
 =?utf-8?B?K3d5S1lOajd1UTB4NFdxcXJ6bFhGc1lEekVoMFdKbEJtOGh0cW9seTB4M3U1?=
 =?utf-8?B?aEVlTzB5azRZQzJRRkhmN3A2RjZNSE52RmhTU2IwVmQ1bEQwOTA5RjdKTStY?=
 =?utf-8?B?UjBNQWNoZG9uN0xEd0JIbWdqN3FQeElZTG1RQkNkZjRGb1RkVm02dG5tWWd4?=
 =?utf-8?B?OVd4eUcwcjJxMis1ZTlsakR2aTkydnh4MEwwYy9WSTVtdjhUOTNMSzFVZkFx?=
 =?utf-8?B?ak11dkdWTE1RalBhNmVWQnJLUGJxY3BHQkp5OEwwcXJ2dXUzUG1zQmFFYVhS?=
 =?utf-8?B?Y0c1eXptTytUZ2lBVnM0b0JSS3l3VUVmblh0QnlGL0oyMXhwMzN6TEJMV0Vj?=
 =?utf-8?B?QXBvVllYdzVzWS9pUklCMjdES0orTXJqUVdCMEwrYjl2STh3bTF3bUVxSmY4?=
 =?utf-8?B?QVBUYnFyck1Yci9BWmdnaERDdWxrcmJFdnZvRm50V3RqM1lCd3hCTVZ6MFFB?=
 =?utf-8?Q?TvuLwjThoWY2QY9H+F1tqBfRb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55582fe5-4852-4caf-6cdd-08dbfa6453f6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 16:15:01.7196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnCMwIfA2KccHrAOwbC5kA7mnNawaF/eHc1qbA69VN2r4PaVUVdC0b7CicvjDpqUou3VS4OuN9D8pqyjWElRZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6726

Ping on this one.

On 12/5/2023 13:54, Mario Limonciello wrote:
> This reverts commit ec5fa9fcdeca69edf7dab5ca3b2e0ceb1c08fe9a.
> 
> Reports are that this causes problems with external monitors after wake up
> from suspend, which is something it was directly supposed to help.
> 
> Cc: Linux Regressions <regressions@lists.linux.dev>
> Cc: stable@vger.kernel.org
> Cc: Daniel Wheeler <daniel.wheeler@amd.com>
> Cc: Wayne Lin <wayne.lin@amd.com>
> Reported-by: Oliver Schmidt <oliver@luced.de>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218211
> Link: https://forum.manjaro.org/t/problems-with-external-monitor-wake-up-after-suspend/151840
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3023
> Signed-off-by: Mario Limonciello <mario.limonciello <mario.limonciello@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 93 +++----------------
>   1 file changed, 13 insertions(+), 80 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index c146dc9cba92..1ba58e4ecab3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2363,62 +2363,14 @@ static int dm_late_init(void *handle)
>   	return detect_mst_link_for_all_connectors(adev_to_drm(adev));
>   }
>   
> -static void resume_mst_branch_status(struct drm_dp_mst_topology_mgr *mgr)
> -{
> -	int ret;
> -	u8 guid[16];
> -	u64 tmp64;
> -
> -	mutex_lock(&mgr->lock);
> -	if (!mgr->mst_primary)
> -		goto out_fail;
> -
> -	if (drm_dp_read_dpcd_caps(mgr->aux, mgr->dpcd) < 0) {
> -		drm_dbg_kms(mgr->dev, "dpcd read failed - undocked during suspend?\n");
> -		goto out_fail;
> -	}
> -
> -	ret = drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
> -				 DP_MST_EN |
> -				 DP_UP_REQ_EN |
> -				 DP_UPSTREAM_IS_SRC);
> -	if (ret < 0) {
> -		drm_dbg_kms(mgr->dev, "mst write failed - undocked during suspend?\n");
> -		goto out_fail;
> -	}
> -
> -	/* Some hubs forget their guids after they resume */
> -	ret = drm_dp_dpcd_read(mgr->aux, DP_GUID, guid, 16);
> -	if (ret != 16) {
> -		drm_dbg_kms(mgr->dev, "dpcd read failed - undocked during suspend?\n");
> -		goto out_fail;
> -	}
> -
> -	if (memchr_inv(guid, 0, 16) == NULL) {
> -		tmp64 = get_jiffies_64();
> -		memcpy(&guid[0], &tmp64, sizeof(u64));
> -		memcpy(&guid[8], &tmp64, sizeof(u64));
> -
> -		ret = drm_dp_dpcd_write(mgr->aux, DP_GUID, guid, 16);
> -
> -		if (ret != 16) {
> -			drm_dbg_kms(mgr->dev, "check mstb guid failed - undocked during suspend?\n");
> -			goto out_fail;
> -		}
> -	}
> -
> -	memcpy(mgr->mst_primary->guid, guid, 16);
> -
> -out_fail:
> -	mutex_unlock(&mgr->lock);
> -}
> -
>   static void s3_handle_mst(struct drm_device *dev, bool suspend)
>   {
>   	struct amdgpu_dm_connector *aconnector;
>   	struct drm_connector *connector;
>   	struct drm_connector_list_iter iter;
>   	struct drm_dp_mst_topology_mgr *mgr;
> +	int ret;
> +	bool need_hotplug = false;
>   
>   	drm_connector_list_iter_begin(dev, &iter);
>   	drm_for_each_connector_iter(connector, &iter) {
> @@ -2444,15 +2396,18 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
>   			if (!dp_is_lttpr_present(aconnector->dc_link))
>   				try_to_configure_aux_timeout(aconnector->dc_link->ddc, LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
>   
> -			/* TODO: move resume_mst_branch_status() into drm mst resume again
> -			 * once topology probing work is pulled out from mst resume into mst
> -			 * resume 2nd step. mst resume 2nd step should be called after old
> -			 * state getting restored (i.e. drm_atomic_helper_resume()).
> -			 */
> -			resume_mst_branch_status(mgr);
> +			ret = drm_dp_mst_topology_mgr_resume(mgr, true);
> +			if (ret < 0) {
> +				dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
> +					aconnector->dc_link);
> +				need_hotplug = true;
> +			}
>   		}
>   	}
>   	drm_connector_list_iter_end(&iter);
> +
> +	if (need_hotplug)
> +		drm_kms_helper_hotplug_event(dev);
>   }
>   
>   static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev)
> @@ -2849,8 +2804,7 @@ static int dm_resume(void *handle)
>   	struct dm_atomic_state *dm_state = to_dm_atomic_state(dm->atomic_obj.state);
>   	enum dc_connection_type new_connection_type = dc_connection_none;
>   	struct dc_state *dc_state;
> -	int i, r, j, ret;
> -	bool need_hotplug = false;
> +	int i, r, j;
>   
>   	if (dm->dc->caps.ips_support) {
>   		dc_dmub_srv_exit_low_power_state(dm->dc);
> @@ -2957,7 +2911,7 @@ static int dm_resume(void *handle)
>   			continue;
>   
>   		/*
> -		 * this is the case when traversing through already created end sink
> +		 * this is the case when traversing through already created
>   		 * MST connectors, should be skipped
>   		 */
>   		if (aconnector && aconnector->mst_root)
> @@ -3017,27 +2971,6 @@ static int dm_resume(void *handle)
>   
>   	dm->cached_state = NULL;
>   
> -	/* Do mst topology probing after resuming cached state*/
> -	drm_connector_list_iter_begin(ddev, &iter);
> -	drm_for_each_connector_iter(connector, &iter) {
> -		aconnector = to_amdgpu_dm_connector(connector);
> -		if (aconnector->dc_link->type != dc_connection_mst_branch ||
> -		    aconnector->mst_root)
> -			continue;
> -
> -		ret = drm_dp_mst_topology_mgr_resume(&aconnector->mst_mgr, true);
> -
> -		if (ret < 0) {
> -			dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
> -					aconnector->dc_link);
> -			need_hotplug = true;
> -		}
> -	}
> -	drm_connector_list_iter_end(&iter);
> -
> -	if (need_hotplug)
> -		drm_kms_helper_hotplug_event(ddev);
> -
>   	amdgpu_dm_irq_resume_late(adev);
>   
>   	amdgpu_dm_smu_write_watermarks_table(adev);


