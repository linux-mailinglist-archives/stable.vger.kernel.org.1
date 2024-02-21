Return-Path: <stable+bounces-23214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AB185E4DA
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 18:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD8A1C237C9
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 17:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DD783CDA;
	Wed, 21 Feb 2024 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s8lup3pf"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D5F69313
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537574; cv=fail; b=jC0l2TNLh4hXzE4GRiqPavO/0km2VP982zov2hXyEf8XkBELMf2ecC91ByHD0ntNkeraeQbRIqbAbLWy01eiwf3Cuc8VaNpzVVp/1jamQh6M4CC0QDJFe7w03Po8HGlST33vnIt5ecCkQfUvUi8OZoOWkGKO4MA5GwNUOs9nC6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537574; c=relaxed/simple;
	bh=z7+EWH5QvMXhEvv/zoaGr8jS0et9t9bsbGdOENCHIJk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lncJs9Ed5bVePDQQR5lXvoU0sZ4O9FRTzzB3uHL4NI4GnP1KkLUDA+NfWjNTZwHaKd2bzwQBP7GZmLnCZHNHRJcVq31M2dRXkkyRC+CUEhB+3IjeG/vBGNHbza9fZJ6+XnAIkvsSoKKzR9LPN4lk4laacBdXLvFFol45yMAegiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s8lup3pf; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBzYappern6iKkgIGpZXOhld8kYwI1RWkeewfrcBKF0CjrC2m+NAK2/LNsRxIO8Nm8zZlIGdqSfKBtfX/ppYmnfki9xsqF+hPIzpbDUaBvaDGMNyhPlrdTuydD9zdlRo7EHhpFtQTN0mT4202BzzpzI9d+1Vz6XqDAFuWWLkd9qhKVaL0HjUQcrj7qyFeZ+W9IIiKwagGRvfrolxhVCfaGZd8qXpyf+ViyK2ZFgyA//kErZDVAefuxlFjF5rcXrvEIk6xMPUSDBAwBYJkgizpFRYvtk6j/OB7zbngBjQ/W81YTGWjncrB2KlJqLyIL9Vu+C/yBNzlXUuIuWRZFtqLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5OTUmqozcZmzin7KcUXYQNUGIpEf3aCCA2Fl8NhT+I=;
 b=P2mhHy++wvRg/i8HPDK0w+bJB2dHVvAjonOMiiUPE7g/7hdMh6EklZ+jCS5n7fDJz7Gb89lfxoWoBMzZGtJdpV4pJsgnS6bcySyqv5p8G3h+o/vA8JhHwAT0efbazfOwCEHmrI61m5j7gKGSUdWahSMtwszash/wSCSNWGpu8FDnexvY124WViT0z+4++XnHjGF/WV2TOg52KNt3iEEvdI69nrmuLVKqJEjE0VgxDR8PoZWDK8HJrs80jWp4KmVxCJUbsQIaHXr2SI7saGMyryrX8wbiaeINOgKC+DXmJCz6ZSUJAAu3CYYOb3k2Higr4oFsa1w0AHghBWZblslT0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5OTUmqozcZmzin7KcUXYQNUGIpEf3aCCA2Fl8NhT+I=;
 b=s8lup3pfFKrTkucAbWu+RjFn25pAyoRy2cj8DyAobBbwzXkMtSqYsA5O7+Yo/Flm9KHImH06zXttS785wWrE8CVAFdsqKGnQtCTVAmjQA147zgdejwC4Ltyc0hc1cg/XdMuKJJ98aOaRrHwMc+lBgbmjA1m7O+HUnhFaMVr34fM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8)
 by SA1PR12MB6821.namprd12.prod.outlook.com (2603:10b6:806:25c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Wed, 21 Feb
 2024 17:46:10 +0000
Received: from MW6PR12MB8733.namprd12.prod.outlook.com
 ([fe80::36bb:f12:cd0b:9e8e]) by MW6PR12MB8733.namprd12.prod.outlook.com
 ([fe80::36bb:f12:cd0b:9e8e%4]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 17:46:10 +0000
Message-ID: <d2eac00b-4ba1-4fc6-b13e-cb6289b6f473@amd.com>
Date: Wed, 21 Feb 2024 10:46:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/display: Address kdoc for 'is_psr_su' in
 'fill_dc_dirty_rects'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20240215125754.2333021-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20240215125754.2333021-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:408:94::35) To MW6PR12MB8733.namprd12.prod.outlook.com
 (2603:10b6:303:24c::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8733:EE_|SA1PR12MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: 76179fa7-9021-4304-fc8b-08dc3304fd00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S+O6tr82TPiCaE1m6GaiP8lS2q2urEePLDmCY97wKgZwcfqV04JDG1bkZ/to6hTGL2P59ZYt2mGguI6faX65rPG7mvSNJ1Jj0RWdwUJhz6itifSQ1epvnP8MD7mhtWi9g4/B18bI2LXljZy9WaJm/MQkLVSb9TWnfzMgT0AeVMzCnEjjS5vKaRiYsg882X4/NkCi3QpX3PwVwEtSc1fA+7L4mVmdQ/f1JUfEEFXH54S80qZr+TkIpo/mmP/8FTg4WlMUKlvGRUVlim/REd0325MTccLPfAMGIz0uFM/fzACmKApicSv5PEudqHjAEtlSPFXFVGd+7CtsV6Ev3Qhws8bYpUA7ggU8C4ZnPbTB7+5YZo7SLG3EoCzFmJ5WMd1wbJgux7XWsesXZ6VejGqrrbYlYs/y3LKixdgTxU2qdQ6OPjVuqLf/IrUSWeLJSru4F7z5rP1bm68J+essfCy1aqahm2SRHCs71jvX4ENp6zYeARw0PY2QGSm2fBh9v32ODWWww17eD9O3Cut04fcKnHmIcFsiB/7BxRNO7G35x+0UvFDqMWbM9gx6bl9XxMe5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8733.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djN4a28wV2FXNjVURU5JV0FPeUIxbjhwZGlYTVl0WDFSKzFCSTZqRlkrQVBk?=
 =?utf-8?B?b0NYcXA2Q0RURGJoRmtuNm40anUrZVErOW5Sb0ova1BxTzY3YlZXZ3N2VTFx?=
 =?utf-8?B?dy9QU21rMWxCUHJ6K2svbXU1WUFvRWlBQWhqcHFZdXJOeTUwb212aU5aQWFj?=
 =?utf-8?B?VUd3cGQ0bEVmVlhzQ3dwNVdxZVRDckxBMCtLaENVWE9kT3FQREVaUjAzRmtC?=
 =?utf-8?B?M2xyeWR5MHhZR3ptdDJWNHloWklqT0J6RXZJaGZ2S21nS3MrbWFmaTYxWVlp?=
 =?utf-8?B?blZjd3UrSUtxRncyRGZLbXpzTjlrSU00WlZrZ3ZrNUR3TEFhSmFXVDFHVUhu?=
 =?utf-8?B?NDFiR2pzV0xRZUNTTFkzTnBUU3RadmdOMnVoY2tmOGNGK2Q3VFh3RVlnNGlI?=
 =?utf-8?B?aHQvS01iNGdHNUcvTUVXcDFDTTZQenNqRFVaaDdVdGF3OGJEV2wwTzZkNVdr?=
 =?utf-8?B?Y24rSW42K290c2w4NEhXTGFLR2graDlDUXZHQ1BXTGVLWXNyaVl6VmlhYStG?=
 =?utf-8?B?bmxwTnNjSmlyYWUzZUI5L0l2S0hpVENSS1gzMFlZK1U4bEJnNFBJVnpmSHY5?=
 =?utf-8?B?am1IZ0R0MFVqODJrWWRmaXMzQmR4aThIOGgzTDF3ek90VkZIVzdYUnhVSllo?=
 =?utf-8?B?WFNvSkxHTXNrNmVjNTVpOTN0Tjk0NGt2WTRIaWJjeGEvdW1WNHIxckhZUlpC?=
 =?utf-8?B?d2R5OWpWL0c5T2E0ZnBUMEtzZFZYczJrM2I4VzNyUTk4R25xaTNwYmxkdW1Z?=
 =?utf-8?B?TEowUmdKeUs0VmxaWHVBTDUxNktRalJBN1BZRHAyR3hRNFVXU2t2MWNLTHJy?=
 =?utf-8?B?SFBmcUJDQ0UzYXc4aS9UNmViMjIyaHF3TmJIcW5ubTFqVFhPWWpMSnlweWc3?=
 =?utf-8?B?K0c1V1ZUR2daUHdwS0hxeFpTVUNXemdKY09GWGY2VFlBSklOZG4wUkpqQXU2?=
 =?utf-8?B?UEpqaWUyTTRHNTF3cFJQNG9OMkViYkRtTTdqOXBIVjV1b3h2Tmg4TnVoZmRu?=
 =?utf-8?B?bGZFWVAxd21rYlNXM0JMSTk4cDBKdDZQOER4YVU5MkpSUFhkaWtoM1pVVWxH?=
 =?utf-8?B?R1FRVVU1c1dTbENZTWF6MUdkNVBpOG5UZTMrQTZ3b29zSVhMMVlxWWY4VGgy?=
 =?utf-8?B?NEk5NFF6elVDeVF5ejRJSjZUR3RSTnRJQmhBUEN3Z3g4RkkwNTJGa1UySXd1?=
 =?utf-8?B?bzBIdHVTNHVyQmJNVUFCd2Z5d1lHVHI1aHNqT2RRQ0hnbG5yNm9VT3FHZXFx?=
 =?utf-8?B?Qk5xYzNhZkY2VTh4dndJZU5MVkh5bjZFbFVvd0xDQjdxeVZ5UE8wU20xODdD?=
 =?utf-8?B?YTlLWi8vK1UreUZWWHhvOS96MnZUeVhLVkZDVGJuZzQvZmkvT1l6dnllaldn?=
 =?utf-8?B?Q1RJdkd5dExWK2lidXV3d3Z2U213M200VkN6akxoMkF4NFdpUUlQWUU4c3RN?=
 =?utf-8?B?QkVheUZOWjlIRVJVOFpwMjhubm9TSVU4dHI2MGRwbEdvYzFHdkR6L2hVZFVL?=
 =?utf-8?B?UnNXcU9PZ0NMYXhOMGRZaHRBSGhoRU42UG5zc2QraldRNlk4aEgrL210YVpL?=
 =?utf-8?B?UEkxL3ZpRXdkOGF1eExZZFR2RDhaWUJlMG1CMUNvd1RCM0MycWtIa1YrMmN6?=
 =?utf-8?B?Z1dGcVNnMXNac1haZFRReXh4K3ByN2U4VkVFbk4zV1kxSlovRXJrREIrbVB5?=
 =?utf-8?B?VjBvOFUwcEhkSlhnS3lsZkx2L1Y2TER0aTF1OGdaUnFlU0xaUURsKzA2TDJC?=
 =?utf-8?B?UmtvUnlsWkJPempMNmxSdzB1MHlaRDlrQmVkRzBuTVpVb3o4NTJobERaWjRv?=
 =?utf-8?B?S1VlUE9oNVlaT3NQWHV4M2lST1pHQVU4bDYrT0wzRWhBRUtYM3BwWkFxdWpZ?=
 =?utf-8?B?Y001WTN0N1R0b3U4MFVqQlFhMFMwVkd6WjJQeEltUmRSQ0RmWTBlVGhVM0JF?=
 =?utf-8?B?VDRkOUhlbUVMTDRQMS9ER1ZmWTd1SFA5aEJ2U3UzRzlZY2JrRXlXZUtGd1pP?=
 =?utf-8?B?Z1FLNmpVaDBheWxZc0g3YVpFMUM0ZTFkL0l0RkJvRytBYUtIWENYKzhpbmJy?=
 =?utf-8?B?M1I0MFRwZTIrTktqTEZpYWlmUDV4eVMrQmFYM2ZQdWVueGxDaGFyeXJNWTBE?=
 =?utf-8?Q?zmX/6V11rcKu5Rz1TSLSmj3X1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76179fa7-9021-4304-fc8b-08dc3304fd00
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 17:46:09.9063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0k4JDtb0durmJlcKSCadzJ70zK3ApvBFVAtV2wEx6SK/KEJ49ruSDufd3MxAaRNhAoi/guICd0z6oXPpRd/7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6821



On 2/15/24 05:57, Srinivasan Shanmugam wrote:
> The is_psr_su parameter is a boolean flag indicating whether the Panel
> Self Refresh Selective Update (PSR SU) feature is enabled which is a
> power-saving feature that allows only the updated regions of the screen
> to be refreshed, reducing the amount of data that needs to be sent to
> the display.
> 
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5257: warning: Function parameter or member 'is_psr_su' not described in 'fill_dc_dirty_rects'
> 
> Fixes: 13d6b0812e58 ("drm/amdgpu: make damage clips support configurable")
> Cc: stable@vger.kernel.org
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b9ac3d2f8029..1b51f7fb48ea 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5234,6 +5234,10 @@ static inline void fill_dc_dirty_rect(struct drm_plane *plane,
>    * @new_plane_state: New state of @plane
>    * @crtc_state: New state of CRTC connected to the @plane
>    * @flip_addrs: DC flip tracking struct, which also tracts dirty rects
> + * @is_psr_su: Flag indicating whether Panel Self Refresh Selective Update (PSR SU) is enabled.
> + *             If PSR SU is enabled and damage clips are available, only the regions of the screen
> + *             that have changed will be updated. If PSR SU is not enabled,
> + *             or if damage clips are not available, the entire screen will be updated.
>    * @dirty_regions_changed: dirty regions changed
>    *
>    * For PSR SU, DC informs the DMUB uController of dirty rectangle regions

Hi Srinivasan,

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>


