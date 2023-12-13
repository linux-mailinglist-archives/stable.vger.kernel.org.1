Return-Path: <stable+bounces-6553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB996810791
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 02:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ACEB1F217BE
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 01:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF730A5D;
	Wed, 13 Dec 2023 01:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p74Cppnn"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20888CF
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 17:21:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IC9H4gvpUQsVpMFkeYlnazYNTMNqkWObEiBSgTA2LDkMEeOzyCd9wL38J18CHFJSJAQ++G9OzxCLnfZdFLEBM57qrv77jxHr2+6GxRw+Zb0SL8s90lg04RQbAQCN6SXEDVXbYJr/10yF2oEyYenzlGDXJHPZtqN33RYueAbtPNFWdxvnEDZB4FFD29wXNMFkvrqzGLksnULFkEvEVcAybyP2CzEM7zJ1eBMZCKq0Rx7iD9MvLFQODRBYCvouc46tmIzgOgHxjpbUXBDfteF9rsDYyALX3YptdOQ5GdLIuhV6f9sauVeryBz53fQfMcDJoQ13tyLrF8H09GXI5yx2Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMRB6T+d8waZ6u8m5BVWGjT+A5cCWYQUCJVaZh6eoGg=;
 b=G7fgFdZdUn8+UacSgTdNa2HII57DjG9kqBrxEvDDmUb6cz/yIy/J3SRboGjygfM/1gijYxRxREbY1iy8L1XFMJvRhluB4czM+OLbEg67JuczLNPPJlRZtBhuArxF0uiS1iPqQBPWQn+NIlHy8FsZbBHXZ4z0f1/JNU663SPbS/N+L23UEofdlnO0W8MpYM0gkvYHI1iAOcj4sMFvhF92njqFVuVR6dtM2XoWfr+ltyezhuacXFDXG11q2MOE4xzDFHraYO8UHgFu16sS5VvrBLW/3nCuXwpUBQJFGn/L1R+KHwLLLAeZRxlD/1P+HAaYdwqPSNV7KVfpAuiGQnBW3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMRB6T+d8waZ6u8m5BVWGjT+A5cCWYQUCJVaZh6eoGg=;
 b=p74CppnnQ7hXn6W3NNy8RyTsTdlOjzK2CZZI80fR+TqgJm+aKl7t/IwFqiQ59IhRq+wdOUDu18Sv2OtAmpLbywTzrFqms8iKe4ME77x+QqjX5VaX6QL3TKqlIy9V54d8kPt7DWxN89okDMcoQKx/ty/Sjl6qta/dVrr+91JdGio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB8917.namprd12.prod.outlook.com (2603:10b6:806:386::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Wed, 13 Dec
 2023 01:21:48 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 01:21:48 +0000
Message-ID: <cfb9d9ea-c2ac-42d6-9122-57393c66dd6d@amd.com>
Date: Tue, 12 Dec 2023 19:21:45 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amd/display: Adjust the MST resume flow"
Content-Language: en-US
To: Oliver Schmidt <oliver@luced.de>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>
Cc: Linux Regressions <regressions@lists.linux.dev>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
References: <20231205195436.16081-1-mario.limonciello@amd.com>
 <6e941b94-f3e0-4463-82cf-13bac0d22ebe@amd.com>
 <CO6PR12MB54895D053CC24153B3358344FC8EA@CO6PR12MB5489.namprd12.prod.outlook.com>
 <bb2212b2-5503-49d4-a607-bdf6885681f6@amd.com>
 <24cd225b-df66-14c1-d951-72c4a5509437@luced.de>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <24cd225b-df66-14c1-d951-72c4a5509437@luced.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P222CA0018.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB8917:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aac8175-1113-4784-c50b-08dbfb79e0ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gmk9G93f9oViFHlL37F7EW2DGKpENnnIXHyHhUc+BBit+Q5EUVDnicudK1fnelCICUOIBSb4DSHNO96eI1/ZMsLDi3qzna/ldFJq4OlNe15KSz/E422bAH0L5Ayy/E+7QiUswXO1Hvgzuyq4Ribf0B06OYsoBHew6QoIl8TYVTVnBTn5CImaycE2rs5SsdC/OTZ5s+G59wjORMThu5SsVcfTWaOVcsNqPYbdOVzufNEnKw6j9Dkn5yDi323T2plkqX2bJ0IdDSQE2Cml1Yd3LaP0TEwhG+nb3bDkxMHf09uJbcL4AUvS43UyngMKvYHA6CPX3+/eSRIJjwn8YoTtsryjdvyVYm4ZM2xbUK/0hHMugNH/DbEGTIrGlNlNBlhG1omKdi25uu3aYSmZ9AQdkok8SXNe8EIIJevb9J4oIXZEvH5klZRA63j8Oms98MbPBxkpSvczFjeyrouiFNYREiGFpvM8hcrtLSJp6ES/wyUIm2WWyfhSccAo4DKdldI0XDbZ33IkvVg/vi1a8MLgdVHQLXCpnWjh5KJ/K8SvQbf/2XAuATURXBtX9IQI14JcmIHjvhiTkrvLofjBXiqWzsbnf6p9o6yWQxTRWYwegqCnqUIXlyvTdUZGqDp+SqloNOo2piqTJWaRtRXQ4q/xoy53nT15Ritz2szP0oYojZkzabx67YkmOher8r5vcVGPqAI0zS/AlK1HICyPVjqBog==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(230273577357003)(230922051799003)(230173577357003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(2906002)(41300700001)(478600001)(31686004)(86362001)(66556008)(6636002)(54906003)(6486002)(66476007)(66946007)(966005)(110136005)(6666004)(316002)(38100700002)(4326008)(31696002)(8676002)(8936002)(6512007)(44832011)(6506007)(36756003)(53546011)(5660300002)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGpjRTd1VVZCcVQxbGVEUGNYSEdXN1kzNXBaM2RtaHRuNjczTWNqam9GOVRu?=
 =?utf-8?B?UVh5SjZDYkxDZUgzSm9qWHNNOTZjM1JXUWZNdXZrRGNRNFo1QjRLWU5jMnpj?=
 =?utf-8?B?anJ6cE5aZ1ppNEt6UkpRUVJDdExlVjJqVWlDVEwxR05obkNrNThIemp5cXk5?=
 =?utf-8?B?ZWlSbTJpcFNTYnNhZmlvYXMrMTVOY1ZlT1V5ZWRBV3pZUFc1TWorUEFHN1Vv?=
 =?utf-8?B?YlEyUDNxNHg0Rk52czUrZ2pQb01wRUNtbmpqWVUwMHVIYXFkbnZCbEU4Wms1?=
 =?utf-8?B?QVRDa3NYV3NzREhZM0lKV0oyUk52VTJ4aEZiZjBsb2UyMy95TzNnT3h5aHdp?=
 =?utf-8?B?UklQMVVleHRYUFVyTHI1UWxsZ29ZSnEwNmNnV21vc1BEYUdxTlEwa2Y3L1dM?=
 =?utf-8?B?YW15dUpFb3AyRHJHM250am9JUTkwTzRFTDVHMDBQOHRGQ2NKbWp4b1JZb2Rj?=
 =?utf-8?B?YldSVVBYQlFaQjB6N0NXVmM1Mm8rYU1GSzk5Ungyb3VmM1REcEt2RzA4b2NX?=
 =?utf-8?B?dW9TY0JXTzFwd2VCVDNRQ2ZjaGZYWFZNS1owVEhUbklHSmNBS21xemxpR0Z0?=
 =?utf-8?B?VVY3d1Zvcm1sMmE1andMQ1M1ek5hbVp4OUtmSkRsSzNBZ2NtV1ZZZ08xU1RI?=
 =?utf-8?B?Ylhma29ZeXRtVEc0SVdZQlJtUUp3Z2RxRTFwWFpQaVNBREhNWDBJMHhyTjlv?=
 =?utf-8?B?dzgrc0syeGZUNVZ5Z3lpQ0lnWWJSOURCTkFLUG9Wd3ZieXRPcVZoWGJCa0ty?=
 =?utf-8?B?azNPejM5NjJEUmlmMXRFZXFHY0ZhVzdTb2VNOTF5OUJmT01GclIxK1FqeUgw?=
 =?utf-8?B?YXE1NkszeVY3WkFEVWszZFNmaVJEczFKMnREK2YwcWdmZG5IVG0wSk5VVmkr?=
 =?utf-8?B?Umt0L1IrMGNqNE9zZXBtNnVRTXFTcTJqamFpbXlLOFJGNy9mN0ZoZUp2Q2pm?=
 =?utf-8?B?MlpaYk1vdHNtem1JTGlscDRvNXQxeVVlZEJDMzZXV25jU3Nock9LQXlydE5H?=
 =?utf-8?B?NTdsNkRZK2tKaXd6OFhhS2VITGEwUFJIYnF5Sk5Uc1QyeGF6OUxoS29ZT0RV?=
 =?utf-8?B?R3NUdG1ZUXBGQTBIWU5GQ21jZGhzcEQ3Vm12V0hQd1l4QS9QNDhxbkNWcDZw?=
 =?utf-8?B?TE1TbzBiYXNPWVRMVEI3YWNTSEpTdnJ6OTl3eXpUaGZZdk5VQ05Cb0FMNzAx?=
 =?utf-8?B?YWxLeGlqRDJaTmw2bDJldWpGc1piMEQ5QkllR1l0M3JiSWgwVm5vVWRtZ3Qr?=
 =?utf-8?B?dTV3Q0lEaDBBUy9tSDVESkh6VEErTUl4SDdjZjkyZzhBK1BQdmdMWldjQmVX?=
 =?utf-8?B?TUNDeWY0ODZFelZ2aDZ3ZERvcVdzZWhsZExhNmdpYXRzdm1zcFcyZmlOS0dQ?=
 =?utf-8?B?TjlxSG51WHE0T1pRQmZJbXM1QnhCUitTRjR3REY4djk5OWdld0JHdmN6QnJ4?=
 =?utf-8?B?dmtiQ2ZsNGVWL0h1cHZXWmV1U2Zza2NsbVBEUkVpWEYveEhJY2sxOE1veHdY?=
 =?utf-8?B?Y25tVjdaRTdlSGp5VksyaG1WOXM1V1NDWjJiTFdHSDZJYXdkTGYySndVMWZp?=
 =?utf-8?B?QitKV25NL1lEMk8xeVZaRlFtYnp5M1RydFdaNFBha0ZsSENLSk02YVVDN3RT?=
 =?utf-8?B?a25XSXVoeHpJaGMwZko0WlNjRkpHZTlSYWtrL2JRKzBwTEhuUWh1NFZrKzRa?=
 =?utf-8?B?eUlJMnFSSnVpNm1LV0FRV1ZyR0d5NWtOWUxzSjIyc1ZjN0RzQXRmb1NsL1d3?=
 =?utf-8?B?b0dRWGEvd3ovTmxNOVVad1U4U1lReHdZY1orV09JNDNoZGhsSzJ6N05Mclkw?=
 =?utf-8?B?dUFJaEQwNHdjb0pnbmM5U0gzT1hUQkIybStibWE0bzN2bTVTVFMxa3djYTln?=
 =?utf-8?B?eDJ5cmpSb0tpU2M3QlFaYjlpUmpia1dkV09weEUyRSt0QU42UmdXUTlVUlp5?=
 =?utf-8?B?dThvTmtlUGs2SG9oR2lSU0JJSjEwaXQ3Q00xZmE2cHhsUDFHSExPUy9SZkFu?=
 =?utf-8?B?ZHlGcmdWUU11MjNWVjlyZGY5bys2eHNpcmpFQnNPWTJpQ2VQVVphaUlacTdP?=
 =?utf-8?B?QlRtMk5FMW5UZ0FwcTRlTDZrbzBVNjUwZUx4WlJ0STV5OFN4aDZiVVJUMzBj?=
 =?utf-8?Q?9OHkUQ0PLxkWw6QaOF6YROP8Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aac8175-1113-4784-c50b-08dbfb79e0ad
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 01:21:48.3604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvW83sCV5kl72HWAMnwkoz8IBUiwspiQm+06LVwKtla9mKqzcYZCYIf4jaYuvYnvW46euNFoJbVEvvYAog7PaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8917

On 12/12/2023 18:08, Oliver Schmidt wrote:
> Hi Wayne,
> 
> On 12.12.23 17:06, Mario Limonciello wrote:
>> I looked through your bugs related to this and I didn't see a reference to the
>> specific docking station model.
>> The logs mentioned "Thinkpad dock" but no model.
>> Could you share more about it so that AMD can try to reproduce it?
> 
> Yes, it is a ThinkPad Ultra Dockingstation, part number 40AJ0135EU, see also
> https://support.lenovo.com/us/en/solutions/pd500173-thinkpad-ultra-docking-station-overview-and-service-parts
> 

By chance do you have access to any other dock or monitor combinations 
that you can conclude it only happens on this dock or only a certain 
monitor, or only a certain monitor connected to this dock?

> Best regards,
> Oliver
> 
> On 12.12.23 17:06, Mario Limonciello wrote:
>> On 12/12/2023 04:10, Lin, Wayne wrote:
>>> [Public]
>>>
>>> Hi Mario,
>>>
>>> Thanks for the help.
>>> My feeling is like this problem probably relates to specific dock. Need time
>>> to take
>>> further look.
>>
>> Oliver,
>>
>> I looked through your bugs related to this and I didn't see a reference to the
>> specific docking station model.
>> The logs mentioned "Thinkpad dock" but no model.
>>
>> Could you share more about it so that AMD can try to reproduce it?
>>
>>>
>>> Since reverting solves the issue now, feel free to add:
>>> Acked-by: Wayne Lin <wayne.lin@amd.com>
>>
>> Sure, thanks.
>>
>>>
>>> Thanks,
>>> Wayne
>>>
>>>> -----Original Message-----
>>>> From: Limonciello, Mario <Mario.Limonciello@amd.com>
>>>> Sent: Tuesday, December 12, 2023 12:15 AM
>>>> To: amd-gfx@lists.freedesktop.org; Wentland, Harry
>>>> <Harry.Wentland@amd.com>
>>>> Cc: Linux Regressions <regressions@lists.linux.dev>; stable@vger.kernel.org;
>>>> Wheeler, Daniel <Daniel.Wheeler@amd.com>; Lin, Wayne
>>>> <Wayne.Lin@amd.com>; Oliver Schmidt <oliver@luced.de>
>>>> Subject: Re: [PATCH] Revert "drm/amd/display: Adjust the MST resume flow"
>>>>
>>>> Ping on this one.
>>>>
>>>> On 12/5/2023 13:54, Mario Limonciello wrote:
>>>>> This reverts commit ec5fa9fcdeca69edf7dab5ca3b2e0ceb1c08fe9a.
>>>>>
>>>>> Reports are that this causes problems with external monitors after
>>>>> wake up from suspend, which is something it was directly supposed to help.
>>>>>
>>>>> Cc: Linux Regressions <regressions@lists.linux.dev>
>>>>> Cc: stable@vger.kernel.org
>>>>> Cc: Daniel Wheeler <daniel.wheeler@amd.com>
>>>>> Cc: Wayne Lin <wayne.lin@amd.com>
>>>>> Reported-by: Oliver Schmidt <oliver@luced.de>
>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218211
>>>>> Link:
>>>>> https://forum.manjaro.org/t/problems-with-external-monitor-wake-up-aft
>>>>> er-suspend/151840
>>>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3023
>>>>> Signed-off-by: Mario Limonciello <mario.limonciello
>>>>> <mario.limonciello@amd.com>
>>>>> ---
>>>>>     .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 93 +++--------------
>>>> -- 
>>>>>     1 file changed, 13 insertions(+), 80 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>> index c146dc9cba92..1ba58e4ecab3 100644
>>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>> @@ -2363,62 +2363,14 @@ static int dm_late_init(void *handle)
>>>>>       return detect_mst_link_for_all_connectors(adev_to_drm(adev));
>>>>>     }
>>>>>
>>>>> -static void resume_mst_branch_status(struct drm_dp_mst_topology_mgr
>>>>> *mgr) -{
>>>>> -   int ret;
>>>>> -   u8 guid[16];
>>>>> -   u64 tmp64;
>>>>> -
>>>>> -   mutex_lock(&mgr->lock);
>>>>> -   if (!mgr->mst_primary)
>>>>> -           goto out_fail;
>>>>> -
>>>>> -   if (drm_dp_read_dpcd_caps(mgr->aux, mgr->dpcd) < 0) {
>>>>> -           drm_dbg_kms(mgr->dev, "dpcd read failed - undocked during
>>>> suspend?\n");
>>>>> -           goto out_fail;
>>>>> -   }
>>>>> -
>>>>> -   ret = drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
>>>>> -                            DP_MST_EN |
>>>>> -                            DP_UP_REQ_EN |
>>>>> -                            DP_UPSTREAM_IS_SRC);
>>>>> -   if (ret < 0) {
>>>>> -           drm_dbg_kms(mgr->dev, "mst write failed - undocked during
>>>> suspend?\n");
>>>>> -           goto out_fail;
>>>>> -   }
>>>>> -
>>>>> -   /* Some hubs forget their guids after they resume */
>>>>> -   ret = drm_dp_dpcd_read(mgr->aux, DP_GUID, guid, 16);
>>>>> -   if (ret != 16) {
>>>>> -           drm_dbg_kms(mgr->dev, "dpcd read failed - undocked during
>>>> suspend?\n");
>>>>> -           goto out_fail;
>>>>> -   }
>>>>> -
>>>>> -   if (memchr_inv(guid, 0, 16) == NULL) {
>>>>> -           tmp64 = get_jiffies_64();
>>>>> -           memcpy(&guid[0], &tmp64, sizeof(u64));
>>>>> -           memcpy(&guid[8], &tmp64, sizeof(u64));
>>>>> -
>>>>> -           ret = drm_dp_dpcd_write(mgr->aux, DP_GUID, guid, 16);
>>>>> -
>>>>> -           if (ret != 16) {
>>>>> -                   drm_dbg_kms(mgr->dev, "check mstb guid failed -
>>>> undocked during suspend?\n");
>>>>> -                   goto out_fail;
>>>>> -           }
>>>>> -   }
>>>>> -
>>>>> -   memcpy(mgr->mst_primary->guid, guid, 16);
>>>>> -
>>>>> -out_fail:
>>>>> -   mutex_unlock(&mgr->lock);
>>>>> -}
>>>>> -
>>>>>     static void s3_handle_mst(struct drm_device *dev, bool suspend)
>>>>>     {
>>>>>       struct amdgpu_dm_connector *aconnector;
>>>>>       struct drm_connector *connector;
>>>>>       struct drm_connector_list_iter iter;
>>>>>       struct drm_dp_mst_topology_mgr *mgr;
>>>>> +   int ret;
>>>>> +   bool need_hotplug = false;
>>>>>
>>>>>       drm_connector_list_iter_begin(dev, &iter);
>>>>>       drm_for_each_connector_iter(connector, &iter) { @@ -2444,15
>>>>> +2396,18 @@ static void s3_handle_mst(struct drm_device *dev, bool
>>>> suspend)
>>>>>                       if (!dp_is_lttpr_present(aconnector->dc_link))
>>>>>                               try_to_configure_aux_timeout(aconnector-
>>>>> dc_link->ddc,
>>>>> LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
>>>>>
>>>>> -                   /* TODO: move resume_mst_branch_status() into
>>>> drm mst resume again
>>>>> -                    * once topology probing work is pulled out from mst
>>>> resume into mst
>>>>> -                    * resume 2nd step. mst resume 2nd step should be
>>>> called after old
>>>>> -                    * state getting restored (i.e.
>>>> drm_atomic_helper_resume()).
>>>>> -                    */
>>>>> -                   resume_mst_branch_status(mgr);
>>>>> +                   ret = drm_dp_mst_topology_mgr_resume(mgr, true);
>>>>> +                   if (ret < 0) {
>>>>> +
>>>>         dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
>>>>> +                                   aconnector->dc_link);
>>>>> +                           need_hotplug = true;
>>>>> +                   }
>>>>>               }
>>>>>       }
>>>>>       drm_connector_list_iter_end(&iter);
>>>>> +
>>>>> +   if (need_hotplug)
>>>>> +           drm_kms_helper_hotplug_event(dev);
>>>>>     }
>>>>>
>>>>>     static int amdgpu_dm_smu_write_watermarks_table(struct
>>>> amdgpu_device
>>>>> *adev) @@ -2849,8 +2804,7 @@ static int dm_resume(void *handle)
>>>>>       struct dm_atomic_state *dm_state = to_dm_atomic_state(dm-
>>>>> atomic_obj.state);
>>>>>       enum dc_connection_type new_connection_type =
>>>> dc_connection_none;
>>>>>       struct dc_state *dc_state;
>>>>> -   int i, r, j, ret;
>>>>> -   bool need_hotplug = false;
>>>>> +   int i, r, j;
>>>>>
>>>>>       if (dm->dc->caps.ips_support) {
>>>>>               dc_dmub_srv_exit_low_power_state(dm->dc);
>>>>> @@ -2957,7 +2911,7 @@ static int dm_resume(void *handle)
>>>>>                       continue;
>>>>>
>>>>>               /*
>>>>> -            * this is the case when traversing through already created end
>>>> sink
>>>>> +            * this is the case when traversing through already created
>>>>>                * MST connectors, should be skipped
>>>>>                */
>>>>>               if (aconnector && aconnector->mst_root) @@ -3017,27
>>>> +2971,6 @@
>>>>> static int dm_resume(void *handle)
>>>>>
>>>>>       dm->cached_state = NULL;
>>>>>
>>>>> -   /* Do mst topology probing after resuming cached state*/
>>>>> -   drm_connector_list_iter_begin(ddev, &iter);
>>>>> -   drm_for_each_connector_iter(connector, &iter) {
>>>>> -           aconnector = to_amdgpu_dm_connector(connector);
>>>>> -           if (aconnector->dc_link->type != dc_connection_mst_branch
>>>> ||
>>>>> -               aconnector->mst_root)
>>>>> -                   continue;
>>>>> -
>>>>> -           ret = drm_dp_mst_topology_mgr_resume(&aconnector-
>>>>> mst_mgr, true);
>>>>> -
>>>>> -           if (ret < 0) {
>>>>> -                   dm_helpers_dp_mst_stop_top_mgr(aconnector-
>>>>> dc_link->ctx,
>>>>> -                                   aconnector->dc_link);
>>>>> -                   need_hotplug = true;
>>>>> -           }
>>>>> -   }
>>>>> -   drm_connector_list_iter_end(&iter);
>>>>> -
>>>>> -   if (need_hotplug)
>>>>> -           drm_kms_helper_hotplug_event(ddev);
>>>>> -
>>>>>       amdgpu_dm_irq_resume_late(adev);
>>>>>
>>>>>       amdgpu_dm_smu_write_watermarks_table(adev);
>>>
>>


