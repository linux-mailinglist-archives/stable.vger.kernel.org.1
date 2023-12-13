Return-Path: <stable+bounces-6605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0D58114D9
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 15:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA129282889
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 14:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D4C2EAEC;
	Wed, 13 Dec 2023 14:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sCw2YY7P"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA43101
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 06:39:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLOpAmijkfNhN2R1OAeyysclYhz4wWX1o6GG84yr2T3vqe8vKzEF9IN0+iVGf7XfFVSIN2QXy5XdMpyVfkmUPyX4wsBWWAnE0/0lEALGsuIpfzlNEwprOQQWpU2AP8vOCGUViFXWbbh9cG97YtLXx/PiNE5i0gdZe282+xQ3mX46mgku6i1MXUCr0lfBnHeH+xzTwBqaWV+yFAAN8S1R40KRni94DGoXnccgYO7dE4XNxwbiyxCQGv6DEyJrhJhR/4UGm+CB1cqPg1jY1QIayaxQQA9FLjk9bUqjTb6heHNSQEIpNNa7Yt2pt/xNYPKL7P33QCra1TSIDr9PpPJExw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agb154yIqNB8LZ9GKHV9Vltj7veVifM0GBU2NSR45uc=;
 b=cJUHLhlqYwE88KjIKsurHPPiAfF+J4iGKFKhOIji8I1QyB4cktzxL0A3eZ/IFiuqmw5vPSyedjRPEVtyIWYJ6wO7dHoGCl6hVQ0fSb1vke01HYwPN6BKxTR7WN1bqszCxEA/gim2gkyiP66mEKpaCz5/Qrd1cyCXsS+UATvNfEOgw8snVJv7IYreiyc4dc/PJ589m4vhog5/RF1GsXCgnVdVaxi7BuitxmCcTAN/eXRakFIT11ExSt4wVdLIXARJSMGDmlfkiO79htIVBebEJfSylq4Gip841aKjFNd6SuYOkj2OUjd9cTcb1SEUt9DSTCjHHXDQXXZsHa+jjrytQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agb154yIqNB8LZ9GKHV9Vltj7veVifM0GBU2NSR45uc=;
 b=sCw2YY7Pltu1DUF76VougoFz/lc3WiuwudyWD6r6m51Gb2Go0hYtpIYqGr4kR/V6w+/vEtdEHT0HMbeH5NiJvsndmzofOJHVbpD6vSPT4zV6wadyKUpc7laW3LDF7CtWphuuNbc3UMp8ScL1BQzh/EfGPjwkINkFEcLlx3c4xLM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6936.namprd12.prod.outlook.com (2603:10b6:510:1ba::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 14:39:02 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 14:39:02 +0000
Message-ID: <5c7abd99-b4bb-4573-b2d5-2708c6ab2644@amd.com>
Date: Wed, 13 Dec 2023 08:39:00 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amd/display: Adjust the MST resume flow"
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Oliver Schmidt <oliver@luced.de>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Wheeler, Daniel" <Daniel.Wheeler@amd.com>,
 Linux Regressions <regressions@lists.linux.dev>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20231205195436.16081-1-mario.limonciello@amd.com>
 <6e941b94-f3e0-4463-82cf-13bac0d22ebe@amd.com>
 <CO6PR12MB54895D053CC24153B3358344FC8EA@CO6PR12MB5489.namprd12.prod.outlook.com>
 <bb2212b2-5503-49d4-a607-bdf6885681f6@amd.com>
 <24cd225b-df66-14c1-d951-72c4a5509437@luced.de>
 <cfb9d9ea-c2ac-42d6-9122-57393c66dd6d@amd.com>
 <CADnq5_NtVufiPfTyLS-pDKcqkU9uEu23=bEasoQvy6iOQ-9snA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_NtVufiPfTyLS-pDKcqkU9uEu23=bEasoQvy6iOQ-9snA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:806:23::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: 6059355d-5aed-4dc5-feda-08dbfbe9402d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OPdJA+z2qSNmwxMYAksiCqqPHg3zSgSWkbMZfdp6ghZDhAnCOSRm0l1L0j8V/F9hukCpiaH61Om2GbGp8kQj/UhfM0oq1dZQM5QW5+uXDfW030zXcVQt4CiDj1NS6FsABniFOcA13KqsW4mC0wIgouvJ8/Ie/yHfO6KRJYHmkgFcObW7lX3v9idm5oM6I7DKK9TnpeF/518zt6mhccapbGjYmvVYbX3DM9XcssawrjXorliuLmLjRNVf3ScKuiBSwH5vR/aZiN1lPCaQJOIRGFAxp1wbZuaBjfy8b58sDDwJo+CAGjhi/oDT8XJmoSPB6m1d7J7WDhidmn1Dm4/TRaSDK1JpROVGtFZuQTeWSMSKoz0ZtHJJvWehitAF3qly6NZZO6vYPCU9bxqRmRf3oV9CUjep1/NxjLRBfxrkngfAXCkgA0aWZXdjfxOsxNXeQ6aZASlLvbgHrWm5Gm1Kkh5Y0tc4LtuvR0jf6p5WXINKHAEWnuXzax5PDSzCueSgTJSMoYCQDd0SvkH08iM9ARPDUg3odPmRUTMK+lbVhah8jf4lBCtT3fslrfn3kAnfftYDkC5hpHCQtC8QbFZkYv5pQgzn1l8ukH0pgmgfBWSk8qxF3Zv3j1BiIG4P0SW92FqnI3UV3DNI5CRJ/SMb9tVrx/ur/Fii2v1Z0LLImHVhb11yAwF1W0cQoYIfgUTT1RQZblbBGyb0Om113vMq8A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(366004)(396003)(230922051799003)(230273577357003)(230173577357003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(6486002)(53546011)(6506007)(6512007)(2616005)(966005)(44832011)(5660300002)(4326008)(8936002)(8676002)(41300700001)(2906002)(478600001)(38100700002)(26005)(316002)(66556008)(54906003)(6916009)(66946007)(66476007)(36756003)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1JvaEl5UWNHU2ljWm9Dc0xDNVNZNlpZaFIzb3dHM2xEMVJMRXo4RlJvQklu?=
 =?utf-8?B?YkxKWTZBUjFkc3oxRWxBQ082cks4MGJEeVY0QmRMUmhPU1FrMHFZcnBIbUhK?=
 =?utf-8?B?eUtGYUM3bEJuMGlwdEJRMEtVMmFRNDBwSDRoWDg5cWg4cm1DVVVRcDg5WlBq?=
 =?utf-8?B?Y0g2UHZoUjRUSm9ZWTBKQVc2LzVkZXJrditQY0h6MUFxckN1MzYxWkEyZHVF?=
 =?utf-8?B?eUhCRFRWcFo5cVhURm9MaTNiTStNTjUvMWZOeDlDOGxvdFkrVC9wTHg2dkhj?=
 =?utf-8?B?RndhYUljRVpta1B6T3NEcER6Vkp4RVh2aGNUeGltcjJOZmNCQ29SYTJqV2lx?=
 =?utf-8?B?OUJ6eDFxVUNic1lzS24xVytXdGlWSGxFL1ZqSEwxTEowNC8veWhtV00yUWNm?=
 =?utf-8?B?aURlQWtrSDdOd2pnRTM2Rll1Rm9McnViaUlTYXBEbndrQlVYMFZXTlRFTlQw?=
 =?utf-8?B?SW1JOW4vUmZyeFFTMTRETFRHMmtvcENjV3pmM1RTOFE4MVR3MEdzdkM5alNX?=
 =?utf-8?B?eTZrbTFpc2JZNklWTEpjWm5GSnVMVVBzcVJXUGF2UnowRjdtMzRaSThUNG9p?=
 =?utf-8?B?QTlFbHJRd2FWM1lWVS81YzBrNTFxOXhCbXIvS3B1aWRwRnREejlEeFFqKy9V?=
 =?utf-8?B?dmQvU0lpLy8zL1F5SnZOeWdtUXNka1RIV2g3K1FPTjcyWktlMWdiZlE5WnJQ?=
 =?utf-8?B?K1NYa3dRUEswSVByUWFyUWRIaEhMclhTdUtBbHpqdjRBcG1lRDFXY1JVMVVz?=
 =?utf-8?B?Uldzc2kxbW95ajVFVkZLTUVUeW9rQ1NybHFaU0hzVjVkQ3Y5QjA5bEVUaDJI?=
 =?utf-8?B?NGZPT0EzMnFXNS8xRG9oNlZDK1MrNG5DV1lRd3ZqUmpVL3RvMmVNL2pJVmJw?=
 =?utf-8?B?bnVzUUtGZm5IaTZYb3RZV3BDaWdyb3pIdTd2ZkJqbWlIVk9QMUVhTmhaWExR?=
 =?utf-8?B?Z3orZUIzSk5oRmhRc2xSdk1Gd004SklvbTZjNTd1MFIxblIxQkVhMlZoeWNw?=
 =?utf-8?B?U1AzMmVoUXJmMTlaWGUxUU13Y1k5RzBNQnJvR3U2Um5VM2dCa1ArMTAzbFM3?=
 =?utf-8?B?U0hodyt2MmZBZTNYKzg1eTR3ZkszMjZyeHhpOHc3NC94TlArMnpHalJlbGRu?=
 =?utf-8?B?Vk5ST290ait0RlFEUnJuNUpVS1lyb2UwSHZOSzNqUThWdW5OWGNRZURKYjhx?=
 =?utf-8?B?b1pRWHErM3lBYk1QaHR1MGlqSTAraGVaVEVPTktleVgyYlZaSzNsc1pBOHhJ?=
 =?utf-8?B?M3ZoVmJqTm5YQlYzWEQyOWcrUHRPbE85dUthZnVqYlV0VVJoNXZ3S3FTQ0Fx?=
 =?utf-8?B?cVNYbVBSREdhRm5LaXdGK3BvY2xGd2QxRi9MbVk4VW10YXVCYVRKRjhrbkxL?=
 =?utf-8?B?cFBqUndTQjN6WkJtK29VWHp5WWhVaXByRWIwZ3NwV2ZsQXgrNWF3bVllWkxr?=
 =?utf-8?B?cDFzdmp2Sjg4R2RzaHNyTTZPQXJjZEVDeHVuWU1DRHZRdS8yMmMvdXUzZm5G?=
 =?utf-8?B?cW1OeHh2K3IxMkpzK05RNnhlMTdpTTRCY0VGUG1zM21iMXpYQzFRZlBoOUdz?=
 =?utf-8?B?STBXdFlVSXIyZ01kQ3NMYzQzQTJ1Tm1xeEQyR2NqeE1uYnJSQmtaSHM4cmVx?=
 =?utf-8?B?OVQ3Y29oc0lZT1NUQm1jelEzTitpcWZ0ZXhJZ3hBR0w3emwza2pETTN2Sjkv?=
 =?utf-8?B?VElKcy9VOUxuR2FERFRZUmJtcVB2WFh5dy9DTWx3c0FZZUJxMURZSER1NnFB?=
 =?utf-8?B?YmR6Y2NrMWIxWURacWdlTXdSZ3A2TkNmUzI4VW96Z3JPelJNUlg5cVNjcUhj?=
 =?utf-8?B?ajFvM3VjRXp3d0Yxc3NYbkRkNmlIUHplTGNuc2dRTHY0ZnhzMGtBRDRZYjUr?=
 =?utf-8?B?ME53b0xWWmwydnRWVE1odDdVZXdpY2VoSk1yOXJrcDBheTkzQ2lzSDJPNGRM?=
 =?utf-8?B?bHZPNFV2dld5UW9BRkVNTFZiTXE0Zis3elBzZFFPL2Q1R1FzeEhkSjZMVDFO?=
 =?utf-8?B?dllHUkJvaHhpbTE2UnZiYitKQmlySi85dngxTDBvQXJKNkF1djdMSnJ4V3Js?=
 =?utf-8?B?aE9NcE5yQzBGNU5KSVZWQ0dOSFd1N2dDdE83TU5BRzl6aUFGc0p1aXNMQTQz?=
 =?utf-8?Q?2YLyKJIDk5Rk7/Wyl8xYNDym/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6059355d-5aed-4dc5-feda-08dbfbe9402d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 14:39:02.7196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5hhpCCH3W2SKNuUVL+pbjPUrYE3wKZyv5gfZ0M6JNhosfVA8p5x0xwzIPXCxHz4fLrFCpqqEc1R6AOLfy4Tquw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6936

On 12/13/2023 08:17, Alex Deucher wrote:
> On Tue, Dec 12, 2023 at 9:00 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 12/12/2023 18:08, Oliver Schmidt wrote:
>>> Hi Wayne,
>>>
>>> On 12.12.23 17:06, Mario Limonciello wrote:
>>>> I looked through your bugs related to this and I didn't see a reference to the
>>>> specific docking station model.
>>>> The logs mentioned "Thinkpad dock" but no model.
>>>> Could you share more about it so that AMD can try to reproduce it?
>>>
>>> Yes, it is a ThinkPad Ultra Dockingstation, part number 40AJ0135EU, see also
>>> https://support.lenovo.com/us/en/solutions/pd500173-thinkpad-ultra-docking-station-overview-and-service-parts
>>>
>>
>> By chance do you have access to any other dock or monitor combinations
>> that you can conclude it only happens on this dock or only a certain
>> monitor, or only a certain monitor connected to this dock?
> 
> IIRC, Wayne's patch was to fix an HP dock, I suspect reverting this
> will just break one dock to fix another.  Wayne, do you have the other
> problematic dock that this patch was needed to fix or even the
> thinkpad dock?  Would be nice to properly sort this out if possible.
> 

Oliver responded back that a firmware update for the problematic dock 
fixed it.

So in that case I'll revert it in amd-staging-drm-next.

> Alex
> 
>>
>>> Best regards,
>>> Oliver
>>>
>>> On 12.12.23 17:06, Mario Limonciello wrote:
>>>> On 12/12/2023 04:10, Lin, Wayne wrote:
>>>>> [Public]
>>>>>
>>>>> Hi Mario,
>>>>>
>>>>> Thanks for the help.
>>>>> My feeling is like this problem probably relates to specific dock. Need time
>>>>> to take
>>>>> further look.
>>>>
>>>> Oliver,
>>>>
>>>> I looked through your bugs related to this and I didn't see a reference to the
>>>> specific docking station model.
>>>> The logs mentioned "Thinkpad dock" but no model.
>>>>
>>>> Could you share more about it so that AMD can try to reproduce it?
>>>>
>>>>>
>>>>> Since reverting solves the issue now, feel free to add:
>>>>> Acked-by: Wayne Lin <wayne.lin@amd.com>
>>>>
>>>> Sure, thanks.
>>>>
>>>>>
>>>>> Thanks,
>>>>> Wayne
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Limonciello, Mario <Mario.Limonciello@amd.com>
>>>>>> Sent: Tuesday, December 12, 2023 12:15 AM
>>>>>> To: amd-gfx@lists.freedesktop.org; Wentland, Harry
>>>>>> <Harry.Wentland@amd.com>
>>>>>> Cc: Linux Regressions <regressions@lists.linux.dev>; stable@vger.kernel.org;
>>>>>> Wheeler, Daniel <Daniel.Wheeler@amd.com>; Lin, Wayne
>>>>>> <Wayne.Lin@amd.com>; Oliver Schmidt <oliver@luced.de>
>>>>>> Subject: Re: [PATCH] Revert "drm/amd/display: Adjust the MST resume flow"
>>>>>>
>>>>>> Ping on this one.
>>>>>>
>>>>>> On 12/5/2023 13:54, Mario Limonciello wrote:
>>>>>>> This reverts commit ec5fa9fcdeca69edf7dab5ca3b2e0ceb1c08fe9a.
>>>>>>>
>>>>>>> Reports are that this causes problems with external monitors after
>>>>>>> wake up from suspend, which is something it was directly supposed to help.
>>>>>>>
>>>>>>> Cc: Linux Regressions <regressions@lists.linux.dev>
>>>>>>> Cc: stable@vger.kernel.org
>>>>>>> Cc: Daniel Wheeler <daniel.wheeler@amd.com>
>>>>>>> Cc: Wayne Lin <wayne.lin@amd.com>
>>>>>>> Reported-by: Oliver Schmidt <oliver@luced.de>
>>>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218211
>>>>>>> Link:
>>>>>>> https://forum.manjaro.org/t/problems-with-external-monitor-wake-up-aft
>>>>>>> er-suspend/151840
>>>>>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3023
>>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello
>>>>>>> <mario.limonciello@amd.com>
>>>>>>> ---
>>>>>>>      .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 93 +++--------------
>>>>>> --
>>>>>>>      1 file changed, 13 insertions(+), 80 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>>>> index c146dc9cba92..1ba58e4ecab3 100644
>>>>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>>>> @@ -2363,62 +2363,14 @@ static int dm_late_init(void *handle)
>>>>>>>        return detect_mst_link_for_all_connectors(adev_to_drm(adev));
>>>>>>>      }
>>>>>>>
>>>>>>> -static void resume_mst_branch_status(struct drm_dp_mst_topology_mgr
>>>>>>> *mgr) -{
>>>>>>> -   int ret;
>>>>>>> -   u8 guid[16];
>>>>>>> -   u64 tmp64;
>>>>>>> -
>>>>>>> -   mutex_lock(&mgr->lock);
>>>>>>> -   if (!mgr->mst_primary)
>>>>>>> -           goto out_fail;
>>>>>>> -
>>>>>>> -   if (drm_dp_read_dpcd_caps(mgr->aux, mgr->dpcd) < 0) {
>>>>>>> -           drm_dbg_kms(mgr->dev, "dpcd read failed - undocked during
>>>>>> suspend?\n");
>>>>>>> -           goto out_fail;
>>>>>>> -   }
>>>>>>> -
>>>>>>> -   ret = drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
>>>>>>> -                            DP_MST_EN |
>>>>>>> -                            DP_UP_REQ_EN |
>>>>>>> -                            DP_UPSTREAM_IS_SRC);
>>>>>>> -   if (ret < 0) {
>>>>>>> -           drm_dbg_kms(mgr->dev, "mst write failed - undocked during
>>>>>> suspend?\n");
>>>>>>> -           goto out_fail;
>>>>>>> -   }
>>>>>>> -
>>>>>>> -   /* Some hubs forget their guids after they resume */
>>>>>>> -   ret = drm_dp_dpcd_read(mgr->aux, DP_GUID, guid, 16);
>>>>>>> -   if (ret != 16) {
>>>>>>> -           drm_dbg_kms(mgr->dev, "dpcd read failed - undocked during
>>>>>> suspend?\n");
>>>>>>> -           goto out_fail;
>>>>>>> -   }
>>>>>>> -
>>>>>>> -   if (memchr_inv(guid, 0, 16) == NULL) {
>>>>>>> -           tmp64 = get_jiffies_64();
>>>>>>> -           memcpy(&guid[0], &tmp64, sizeof(u64));
>>>>>>> -           memcpy(&guid[8], &tmp64, sizeof(u64));
>>>>>>> -
>>>>>>> -           ret = drm_dp_dpcd_write(mgr->aux, DP_GUID, guid, 16);
>>>>>>> -
>>>>>>> -           if (ret != 16) {
>>>>>>> -                   drm_dbg_kms(mgr->dev, "check mstb guid failed -
>>>>>> undocked during suspend?\n");
>>>>>>> -                   goto out_fail;
>>>>>>> -           }
>>>>>>> -   }
>>>>>>> -
>>>>>>> -   memcpy(mgr->mst_primary->guid, guid, 16);
>>>>>>> -
>>>>>>> -out_fail:
>>>>>>> -   mutex_unlock(&mgr->lock);
>>>>>>> -}
>>>>>>> -
>>>>>>>      static void s3_handle_mst(struct drm_device *dev, bool suspend)
>>>>>>>      {
>>>>>>>        struct amdgpu_dm_connector *aconnector;
>>>>>>>        struct drm_connector *connector;
>>>>>>>        struct drm_connector_list_iter iter;
>>>>>>>        struct drm_dp_mst_topology_mgr *mgr;
>>>>>>> +   int ret;
>>>>>>> +   bool need_hotplug = false;
>>>>>>>
>>>>>>>        drm_connector_list_iter_begin(dev, &iter);
>>>>>>>        drm_for_each_connector_iter(connector, &iter) { @@ -2444,15
>>>>>>> +2396,18 @@ static void s3_handle_mst(struct drm_device *dev, bool
>>>>>> suspend)
>>>>>>>                        if (!dp_is_lttpr_present(aconnector->dc_link))
>>>>>>>                                try_to_configure_aux_timeout(aconnector-
>>>>>>> dc_link->ddc,
>>>>>>> LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
>>>>>>>
>>>>>>> -                   /* TODO: move resume_mst_branch_status() into
>>>>>> drm mst resume again
>>>>>>> -                    * once topology probing work is pulled out from mst
>>>>>> resume into mst
>>>>>>> -                    * resume 2nd step. mst resume 2nd step should be
>>>>>> called after old
>>>>>>> -                    * state getting restored (i.e.
>>>>>> drm_atomic_helper_resume()).
>>>>>>> -                    */
>>>>>>> -                   resume_mst_branch_status(mgr);
>>>>>>> +                   ret = drm_dp_mst_topology_mgr_resume(mgr, true);
>>>>>>> +                   if (ret < 0) {
>>>>>>> +
>>>>>>          dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
>>>>>>> +                                   aconnector->dc_link);
>>>>>>> +                           need_hotplug = true;
>>>>>>> +                   }
>>>>>>>                }
>>>>>>>        }
>>>>>>>        drm_connector_list_iter_end(&iter);
>>>>>>> +
>>>>>>> +   if (need_hotplug)
>>>>>>> +           drm_kms_helper_hotplug_event(dev);
>>>>>>>      }
>>>>>>>
>>>>>>>      static int amdgpu_dm_smu_write_watermarks_table(struct
>>>>>> amdgpu_device
>>>>>>> *adev) @@ -2849,8 +2804,7 @@ static int dm_resume(void *handle)
>>>>>>>        struct dm_atomic_state *dm_state = to_dm_atomic_state(dm-
>>>>>>> atomic_obj.state);
>>>>>>>        enum dc_connection_type new_connection_type =
>>>>>> dc_connection_none;
>>>>>>>        struct dc_state *dc_state;
>>>>>>> -   int i, r, j, ret;
>>>>>>> -   bool need_hotplug = false;
>>>>>>> +   int i, r, j;
>>>>>>>
>>>>>>>        if (dm->dc->caps.ips_support) {
>>>>>>>                dc_dmub_srv_exit_low_power_state(dm->dc);
>>>>>>> @@ -2957,7 +2911,7 @@ static int dm_resume(void *handle)
>>>>>>>                        continue;
>>>>>>>
>>>>>>>                /*
>>>>>>> -            * this is the case when traversing through already created end
>>>>>> sink
>>>>>>> +            * this is the case when traversing through already created
>>>>>>>                 * MST connectors, should be skipped
>>>>>>>                 */
>>>>>>>                if (aconnector && aconnector->mst_root) @@ -3017,27
>>>>>> +2971,6 @@
>>>>>>> static int dm_resume(void *handle)
>>>>>>>
>>>>>>>        dm->cached_state = NULL;
>>>>>>>
>>>>>>> -   /* Do mst topology probing after resuming cached state*/
>>>>>>> -   drm_connector_list_iter_begin(ddev, &iter);
>>>>>>> -   drm_for_each_connector_iter(connector, &iter) {
>>>>>>> -           aconnector = to_amdgpu_dm_connector(connector);
>>>>>>> -           if (aconnector->dc_link->type != dc_connection_mst_branch
>>>>>> ||
>>>>>>> -               aconnector->mst_root)
>>>>>>> -                   continue;
>>>>>>> -
>>>>>>> -           ret = drm_dp_mst_topology_mgr_resume(&aconnector-
>>>>>>> mst_mgr, true);
>>>>>>> -
>>>>>>> -           if (ret < 0) {
>>>>>>> -                   dm_helpers_dp_mst_stop_top_mgr(aconnector-
>>>>>>> dc_link->ctx,
>>>>>>> -                                   aconnector->dc_link);
>>>>>>> -                   need_hotplug = true;
>>>>>>> -           }
>>>>>>> -   }
>>>>>>> -   drm_connector_list_iter_end(&iter);
>>>>>>> -
>>>>>>> -   if (need_hotplug)
>>>>>>> -           drm_kms_helper_hotplug_event(ddev);
>>>>>>> -
>>>>>>>        amdgpu_dm_irq_resume_late(adev);
>>>>>>>
>>>>>>>        amdgpu_dm_smu_write_watermarks_table(adev);
>>>>>
>>>>
>>


