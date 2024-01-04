Return-Path: <stable+bounces-9681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE657824324
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 14:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7191C285D19
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 13:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCCE2232E;
	Thu,  4 Jan 2024 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AeajiDfV"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3692230B
	for <stable@vger.kernel.org>; Thu,  4 Jan 2024 13:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0MmZIIHlx37KDLeG1DzyZdC0d8EQOgsSNCQBl1mNtvEsb7iLVgkn6SboU8gQfAB18OFoYX6bMIypHzP9JNjc8Fishq4jFp1bmm9ZmEkLuQhWHP+LBsngM6BYI3EWAYCYyCGhEx58gurpXVPWgC8UB27MkLlCp0GJvpVd44+wl/sjVLOy9Ncup3nyHjgMGFC3ywOz9zxqQlcJrsWr26opA4ysPnm3wOqttpbNaulrarj1T9x4Eb/6Cw3mEoAe3bHvY60bSq0c9zPrOt4GJ7XIYr0gjYkwlXDo3FDKUMJAVGLry4LYGg9c+PtQa6LXXwWD2W03Q5I6MxDB9ldpDc79w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTtfe1czTWgvsf4jQQyyu+QPN4tjc+caescUaNIiWAk=;
 b=geGbDX7yfSm/XMWUfxQZr/YI8/mM/mAwmpvELLjpYpYNA1e9XORUstKo8fG6p1/QvKCG0oQRaSUG3ftpa8At1l14dBZHWG59mg+7MfdUoa4E1mY7ZjfPp+JpfN9KyVAxYfxtW8+8W2UjMCVd7oC6zpHf7xYV9S7QDealFXJ86d1qlfspiGEgeOtJkc17V/qFwUnNUk390Z7IQENQD4Uwt4OpvqhgvucarpH+gpwluNtuvbssHYyG3X85fTi2Ldwud//lnNQDg6U/LKWPXqHuvBhiUt+uSBLYpu5BqPCR3kyjMYjO8fNRfQpWOyMQLcjMu0rsY27aseHdRD8F/dNm4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTtfe1czTWgvsf4jQQyyu+QPN4tjc+caescUaNIiWAk=;
 b=AeajiDfVs9sG/hwoMEjJQc0vggxSkMMu/BfxuIWH9zNUuDy4w0KqU7rvOQx0On5R7SeAtST7LN7wFYur4dUDJhA7VGzeiV7crRkKkhPB1Dnp9BOzy0oSShYBJhmSt+ybPmDC5XYMdURUhCwZDsrFWe777oYDPyw1cRJoJhQnXcU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 SN7PR12MB8817.namprd12.prod.outlook.com (2603:10b6:806:347::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.25; Thu, 4 Jan 2024 13:54:22 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5358:4ba6:417e:c368]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5358:4ba6:417e:c368%6]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 13:54:21 +0000
Message-ID: <fbed675b-7f82-4f33-a9fe-1947425a649a@amd.com>
Date: Thu, 4 Jan 2024 08:54:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix sending VSC (+ colorimetry) packets
 for DP/eDP displays without PSR
To: Joshua Ashton <joshua@froggi.es>, amd-gfx@lists.freedesktop.org
Cc: Melissa Wen <mwen@igalia.com>, Harry Wentland <harry.wentland@amd.com>,
 Xaver Hugl <xaver.hugl@gmail.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, stable@vger.kernel.org
References: <20240101182836.817565-1-joshua@froggi.es>
 <8db3e45e-037a-4dc5-aabb-519091b1a69e@amd.com>
 <aa5dee62-cec8-464c-aeac-38fdac0a4a80@froggi.es>
Content-Language: en-US
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <aa5dee62-cec8-464c-aeac-38fdac0a4a80@froggi.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::17) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|SN7PR12MB8817:EE_
X-MS-Office365-Filtering-Correlation-Id: 535b1321-fe09-4ed8-160f-08dc0d2ca751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	USlVHFb0VZ29bzPk23uFvdKsHBHv1MwwcrOCek4q5iZf5G+bx2CExXe5OGrzLLbPEDr+cscbVod86INpOSAbMu2FevHb489hAaz7KXksFB9SPWgUZLq7G5g1ixrMcIpaEdxqJaOh5kUlfAW5FS8xUWzCcsYsgOQ9fFjQhoD2Xazpk9Yq/cg4EDhykHX4ppKKZiFNektIs42yu3PCjxXz7PhnDc7imGqVWcO4eb1peofRmhPyUIERH2z6aiw2lHkmcY6miD1fD7UnRW03BWuXF3S6h/QREiZ57IEkL7axSUt1KrXWW54cI6UG39LYUbvtgSuOmHHEgEtuL7TxXBIGN+9ZGUo+lNtMk8e6psZDipBIcI3EXQSCrXJo8Xrs4/f7LqrkJVXDOwZDJu6ead+L1NLRp4XO0zT8FPbPE11Sq8np6z3Y5PvlPIh6I/yvxjeetuHJt8ZjCLMTqy2Hsj5NkIhYfpOPcQ9ReH/esoiC60wQm2Kofgpk6jqjbUHeNOtK1fddqE+qRdrOyiAXjo9FYegWk4Xp8XjvmnNCRzW8xi+v2Gdav5LHlKHYeENzX6wddm6EmL03pAKBhKvD6wYe9yRj2teZdMhhKRnCfpCppIG+bnTOZNwi/B724d8LgdFzQ1kV8WX5h64AEOY0dAWCaA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6280.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(44832011)(41300700001)(26005)(2616005)(83380400001)(5660300002)(38100700002)(8676002)(8936002)(316002)(4326008)(2906002)(54906003)(478600001)(6486002)(66946007)(6506007)(66476007)(53546011)(6512007)(66556008)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3hSZlQvVFpEMlZXS2hsV3dUeEFlV09aRUZwaER1QlZUNndSallTR056aXU1?=
 =?utf-8?B?cWRCV21reE9wMkdxMFZxV1d6eDhmaXRKWk8ya1FSUS9SM24yd1JtQjdJWTY3?=
 =?utf-8?B?b0xLdDB2YmQrYS9vSUZlTzJjNC9ldG1DaXB4Qmg5TmxIT0ozQk5TTVUra2Zs?=
 =?utf-8?B?U1NCZGtMOWxQZ1c1d2hSS0k5Zm94ZERETTdGTjJUNWtkSUFRT2hOaTMzQTJX?=
 =?utf-8?B?NSt6cEk4WXplK05VZTkvdEUxaXFsUVBUVXJtUVJSWGRqZklCZVZiY3JrNTgx?=
 =?utf-8?B?UHIvOGQ5enkrTzFhT1ZQOXRJM2FnTXZkcGVDS3hWL2hhSHpYZnlwTzRaR1hF?=
 =?utf-8?B?YVdlQ1IrL1JLZGJHTVdaWVk2cndZRnB4dnUxUG5tMmhjNHZmSUY0UkIzcHVU?=
 =?utf-8?B?dmkwK2tyYkZqaGRqMkVaMEdYSEpOU3p3bE1PSUMwUW5GZVdnVHpiUm05RWYy?=
 =?utf-8?B?ams3Ni8zYlJmZHpZWHBlSlFXWFZ4TGFpVWY3Y2dMZDA5N1lTblJ3U2VDS1pF?=
 =?utf-8?B?MjFUMUFpaDY5TnZiT2FXRm4xSTF4MUtKc3U0YnlnQjROUTZPUi92NnRLS3hw?=
 =?utf-8?B?d0xCaExacWphNHM4TDBJQ3ViTC9pcVBqRER6MHAwTlJMcUNNU3daOGxlZ2Nl?=
 =?utf-8?B?dFYyTndjRzA0d3ZzNmhTdFJBTlVHRnF6MERYc3RzQjFUcnJUVURCNVB6ajMr?=
 =?utf-8?B?cFArQm0wMUgzZXFPd05mSitDQ2pIMEp5dWlHKzVOM01OUnVvRU9xVXdwUHp6?=
 =?utf-8?B?Y05QZVM5WkdhTElxbHAwdVpkS3ppcG13N0lRRS9ZZlhwUkFBeFJja0FuM2FR?=
 =?utf-8?B?b21jdi9IY1dLZWllcHRpZnJFU2RvbUFyNlRuZmphekt3RHRRQnFhZzczQ1k4?=
 =?utf-8?B?bDYwcTJHNnRvWFZXR3IwbWVndGFCQjN3b1FoRDcwckhjZDNpZTFINW5SaFRH?=
 =?utf-8?B?bXZ3UHpmTysyK2c5ankySG1RVmFwdlJBNnh1OFlGeDVQZk53dmpRUW8wNURy?=
 =?utf-8?B?QjBhelpGcXY5bVhVRzFyRUZ3UHU5ZXBCUkRVT3l6MUVmUk94RFJUV1Zqb0JO?=
 =?utf-8?B?QUEvMjJCWU0rMFl5R3RpcXFxSXpMNkZMcFNnZ0oxMG9BWFEvODBRb0xkOFRs?=
 =?utf-8?B?aTNtMEJPeVlscHhGT05uZ0NsWCs1WHdkTVQ4T0VlYmd4MGgwemJha2xVWm5l?=
 =?utf-8?B?UXR5MWY5dUtkVGtQZTQ3WXg1dkYvbFh6Y0owL2Y5ektpNjVrU2dDR2pkdCtU?=
 =?utf-8?B?ejlHNGNHV1hSMmhvenR2a1ZudFM5MWpoUE9BcFM1cGdFUTJ2cS9zcjloZGZl?=
 =?utf-8?B?eDhRREpiWnRHdTJteFVCSk1iOElZdzJaVlBwQWExOVZnUHd6SStPeEtKeGQ1?=
 =?utf-8?B?N0JicDBoOS9Xa0l6cGhmcUg4OVB2NzQzMVRUdjBxZGVjejlXRno2aktiMnIz?=
 =?utf-8?B?V09iR1NTcmtEQ3U4YUgxaXJBWHBRcHpvbkdoMUZnYVcyblNJdlp2b3hUc0NC?=
 =?utf-8?B?R1ZTKytiQnBad1hWUnRocnlNb2FRVmJpK2gvN1gySlU2R01CdTZWZjYrOUZ3?=
 =?utf-8?B?UUxiU2hzVUNXbVpBNzhKQVJqVnhkMnZzYStsS1hRbXpEWHF3dnNOOW9vZ2tj?=
 =?utf-8?B?U291dkx0YVFXcHNrSzFmaHFrUURraElCVVo3WVExSWVYMnVZa1BwYjZHRU9i?=
 =?utf-8?B?Vzg2TCtpTHM1K28vN1VBam9MMUU4SFlLM0FLMHhsQ3lPczFDc1JmQ1BnOUc0?=
 =?utf-8?B?SHVGR1VCb3ZoM21TVXZBV2xKK3hIZGZESVF6Vjd3RVJKczB1WG84bmgwS1N6?=
 =?utf-8?B?WGRTWWpubXF6TUNBYzJYcmZTek8wRjlaMEh6NDhVMkRYNHZCOWFxVVJlUDFt?=
 =?utf-8?B?czZIVXBGSGNMRTZocWhQQWNES0EvZ0oxUXEzeWVQaVlLVlorM0hYQ3ZHTzdx?=
 =?utf-8?B?QmdBQnJPWTJkaGtIZ3NwTHJvZmxBVzNCdlc4b0RmOG9wNXd0ZWZpUGZwbGpU?=
 =?utf-8?B?d3lxMHViVGZaWUFuRWQ5OVkrOVRqY2lDcHAxV2xsVDkxMzBreFQxQlh1WmxL?=
 =?utf-8?B?YlpCU1h5NDY2UjBXcWY5M202cjBlZXdBdEE5Y0NpTktva1g5YmZ0bkxDYmp0?=
 =?utf-8?Q?cTs1RPj6hDpaJ2QL+9vPI8BYA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535b1321-fe09-4ed8-160f-08dc0d2ca751
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 13:54:21.8621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vOR0O0Jo6V6oxERYouaT8v6HSEPJkMJdB3PfXbbnNBAEqgZPESqtm8ZdP5kKB8In6kZBtSJEgg4UqxD++InOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8817

On 1/3/24 14:17, Joshua Ashton wrote:
> Thanks! Is it possible for us to get this backported too?

Sure thing.

Cc: stable@vger.kernel.org

> 
> I forgot to add a Fixes: tag to this commit. It should be
> 
> Fixes: 15f9dfd545a1 ("drm/amd/display: Register Colorspace property for 
> DP and HDMI")
> 
> - Joshie 🐸✨
> 
> On 1/3/24 14:35, Hamza Mahfooz wrote:
>> On 1/1/24 13:28, Joshua Ashton wrote:
>>> The check for sending the vsc infopacket to the display was gated behind
>>> PSR (Panel Self Refresh) being enabled.
>>>
>>> The vsc infopacket also contains the colorimetry (specifically the
>>> container color gamut) information for the stream on modern DP.
>>>
>>> PSR is typically only supported on mobile phone eDP displays, thus this
>>> was not getting sent for typical desktop monitors or TV screens.
>>>
>>> This functionality is needed for proper HDR10 functionality on DP as it
>>> wants BT2020 RGB/YCbCr for the container color space.
>>>
>>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>>>
>>> Cc: Harry Wentland <harry.wentland@amd.com>
>>> Cc: Xaver Hugl <xaver.hugl@gmail.com>
>>> Cc: Melissa Wen <mwen@igalia.com>
>>
>> Applied, thanks!
>>
>>> ---
>>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   |  8 +++++---
>>>   .../amd/display/modules/info_packet/info_packet.c   | 13 ++++++++-----
>>>   2 files changed, 13 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index 2845c884398e..6dff56408bf4 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -6233,8 +6233,9 @@ create_stream_for_sink(struct drm_connector 
>>> *connector,
>>>       if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
>>>           mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket);
>>> -
>>> -    if (stream->link->psr_settings.psr_feature_enabled || 
>>> stream->link->replay_settings.replay_feature_enabled) {
>>> +    else if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
>>> +             stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
>>> +             stream->signal == SIGNAL_TYPE_EDP) {
>>>           //
>>>           // should decide stream support vsc sdp colorimetry capability
>>>           // before building vsc info packet
>>> @@ -6250,8 +6251,9 @@ create_stream_for_sink(struct drm_connector 
>>> *connector,
>>>           if (stream->out_transfer_func->tf == 
>>> TRANSFER_FUNCTION_GAMMA22)
>>>               tf = TRANSFER_FUNC_GAMMA_22;
>>>           mod_build_vsc_infopacket(stream, &stream->vsc_infopacket, 
>>> stream->output_color_space, tf);
>>> -        aconnector->psr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
>>> +        if (stream->link->psr_settings.psr_feature_enabled)
>>> +            aconnector->psr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
>>>       }
>>>   finish:
>>>       dc_sink_release(sink);
>>> diff --git 
>>> a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c 
>>> b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
>>> index 84f9b412a4f1..738ee763f24a 100644
>>> --- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
>>> +++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
>>> @@ -147,12 +147,15 @@ void mod_build_vsc_infopacket(const struct 
>>> dc_stream_state *stream,
>>>       }
>>>       /* VSC packet set to 4 for PSR-SU, or 2 for PSR1 */
>>> -    if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
>>> -        vsc_packet_revision = vsc_packet_rev4;
>>> -    else if (stream->link->replay_settings.config.replay_supported)
>>> +    if (stream->link->psr_settings.psr_feature_enabled) {
>>> +        if (stream->link->psr_settings.psr_version == 
>>> DC_PSR_VERSION_SU_1)
>>> +            vsc_packet_revision = vsc_packet_rev4;
>>> +        else if (stream->link->psr_settings.psr_version == 
>>> DC_PSR_VERSION_1)
>>> +            vsc_packet_revision = vsc_packet_rev2;
>>> +    }
>>> +
>>> +    if (stream->link->replay_settings.config.replay_supported)
>>>           vsc_packet_revision = vsc_packet_rev4;
>>> -    else if (stream->link->psr_settings.psr_version == 
>>> DC_PSR_VERSION_1)
>>> -        vsc_packet_revision = vsc_packet_rev2;
>>>       /* Update to revision 5 for extended colorimetry support */
>>>       if (stream->use_vsc_sdp_for_colorimetry)
> 
-- 
Hamza


