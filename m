Return-Path: <stable+bounces-6464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2039380F1D3
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 17:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92F75B20BFC
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 16:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23447763C;
	Tue, 12 Dec 2023 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fS3GUatv"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27399A
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 08:06:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKej3X46gqxHIXSHOBgXs8f3WbYDpwNvFibFraFN/LC04WKityBd1yi9YLdadDvwR7iHvFTUhxECtmg+N6OjpeI9y5NGafMnbte6nR6w31Zi1rRyMjsWDlYllySCufihhQwNZm9jNPoEYngin71G+mP28yeK/UiotZuuPsyNH2o5wzVWHm+kdQIHsy61ppv8nEveLtazrKJkdqjauSMXKH/af6U/FE6d3EQepqKYXgHHugLgbLHfBqIC2NABzywExfGEgtYluwkvZ336Jbvs3MAaERMlbNAWh1OwKdDRTmK9ytg5c8lYSgHY+j6L0dr5ftgsuySlUkR6oL+UW4Om5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6mJ7A0ELse3qWK5w3JQJ/Td9mTIi3Bkb7z46/GbQGk=;
 b=ES9gA8EU2yNBkHwrPTZdrMFXjHDh7/86Nd3lOb4lfP7/aMVei8vIJxrRFg8a+lwS5HnzSs+ob8OMLtHWop5u5/DSYtIjlcQ/7pA44VShuVFfOzZ+1Z5/ZVkrYHxCM0/eyQcUR1NKJ8FTrxhN/zyKKWmpSZHfl8xspNFFeaO+OHGXRTIjJEsqUvvjKHEuf9kvHS/CFm5gp3ts1Dyx3uHx5jNRWiC3iDN5LYS7FlgCNnX8NzBX1d2UI9Yu1HK2PzvF+v0cGhEeYnF72Rr8SpE/i/klZOLZb2YVcnwqAQulE3yfbL5jSa8jBUC0/jekkrwlTLIcP9gQjQuVEzERAyVQOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6mJ7A0ELse3qWK5w3JQJ/Td9mTIi3Bkb7z46/GbQGk=;
 b=fS3GUatvPRFkUk3oXChxgIfu4d36GqQkbF8r8/OBUIkrPHRZDpIFcZkwFuvCEliYBADWSLwxox99p8u6wCiM8NvfXPB7M0yoHFuwJLFYrCGgu9MeCZC+OjRaY1paNuh0aDoRlIR8YMOugRZxKPKDVwwqezt9ujDS1AEUf0PGOIM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6007.namprd12.prod.outlook.com (2603:10b6:8:7e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 16:06:35 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 16:06:34 +0000
Message-ID: <bb2212b2-5503-49d4-a607-bdf6885681f6@amd.com>
Date: Tue, 12 Dec 2023 10:06:32 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amd/display: Adjust the MST resume flow"
Content-Language: en-US
To: "Lin, Wayne" <Wayne.Lin@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>
Cc: Linux Regressions <regressions@lists.linux.dev>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "Wheeler, Daniel" <Daniel.Wheeler@amd.com>, Oliver Schmidt <oliver@luced.de>
References: <20231205195436.16081-1-mario.limonciello@amd.com>
 <6e941b94-f3e0-4463-82cf-13bac0d22ebe@amd.com>
 <CO6PR12MB54895D053CC24153B3358344FC8EA@CO6PR12MB5489.namprd12.prod.outlook.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CO6PR12MB54895D053CC24153B3358344FC8EA@CO6PR12MB5489.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0199.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB6007:EE_
X-MS-Office365-Filtering-Correlation-Id: fd9e66b0-0871-4b45-c874-08dbfb2c5044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vfwOcemHSD3bZd9sVIdWCkklIdKwONRr7FS4ZN273/Z0Vllss+YFJZMKaRWB4XKkp6Hl85jnwC3uLb6dxmFCliBQpsj3im4TdKD0/y/r7+k9WW30v9zQgykvRk+0J0HjZWRCyuFir1M+Jvpfv/8KelEJn7ojFUYYX62Z+vs2dMVTQnbpesTsnRrlVgehK6dxS8UeZR91vKyZqyPkzogjRg41CuwfPqBeHUzVwyqW2kZhyBhhgwG5Ys5QPYxb1XxSZQfcArhbHpBosUmgp3YpyeqeCjZ6ZyyvmmAAgqwE0IOcCEDAKkyMDRkupnP5zUWupsvJhx4eTUq9H28reYUHOg/GMxo4yQ9WeFBtFn1B8A5QNKT490av7wLm93rrQqIHVetNqj4tds9wEAbbPq4yVO9wdi/L8jZHpQ/lmEVEsd2+kyvnW1JYa59raQ6Z/HIRzQHomZDPAFlljLf93E0DNzsjrwHdclN8bXgyRVKtTWV8HPgYg4834Nn6UgVlVWAIRCRSicvAaaAv4m4gaHejTsl75SRTVFRajnwH2KiNoAk4UQey5PwmzX7xbdQO/jznNTEcwC+tpJ51bpnOBFIHvVJQNMNpHYj9ZLjaJAJjP38Kh5a7pK5mcTvkcPM1KmNjjHKO2TJ9z/ToCZEQeyGvTgJZvDrMjbwKSNzv9KKLml8iD8yoTFlV8V1xty7lKELt4TPz/lPNpA1pP1BVuF8OMg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(346002)(376002)(230922051799003)(230273577357003)(230173577357003)(451199024)(1800799012)(64100799003)(186009)(6636002)(316002)(110136005)(54906003)(66556008)(66946007)(66476007)(6506007)(41300700001)(53546011)(6512007)(26005)(36756003)(2616005)(31696002)(86362001)(38100700002)(83380400001)(966005)(6486002)(478600001)(44832011)(2906002)(31686004)(8936002)(8676002)(5660300002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnZybGxHSE9mMHdLd1VHem95d1JvRlg5WVo0SHdsd1lLaWVHdld2Tm5vNG9t?=
 =?utf-8?B?c3RsV3huQzRqK0tSd0FMVXAxajYzWWo0Qno2VUt5UHdsQlpEVVRCRVZpTjlF?=
 =?utf-8?B?Yk9rdy9kb2t2QUdCZUZFYmxuWHcwMjFQY2FmQjdncEROK1grc2lqaWsvRlZT?=
 =?utf-8?B?T3kzd1NjQkFvR1RkSWxQQUc2c25tSFJQY2U5MUU1ZGdjYy9leGZGdVRLMkZq?=
 =?utf-8?B?M2NUUi9SY3ZYMGVGcmJxL2VSeFNXUDRjclpHZ0N0U3U4NzhZTWJBY2l5NlJm?=
 =?utf-8?B?N0VXWjRZcmpOQmlhR1pRZEVUQ0tFVittTzE0YU9KWllPVVJaQ2loTm5FMFlu?=
 =?utf-8?B?NEtvUHJyTnlyaURZS2hGcHVxZ0VZMkZxZ3YzVDhyckN0aFFpRWo0dFVFMXVo?=
 =?utf-8?B?SW5GSlhJMERhaGZETmM3czdrbk5hN01WWEQrRldDOU9NMWV6N1QyZlRhVUhl?=
 =?utf-8?B?K0xXNjlFYmphWHVicSttNHVYZFZSK1ZOZGZSY0VaRlhDYlp0Nmd5K0NSTnJT?=
 =?utf-8?B?aGV1bEhXbkRpUmMxM2Y0QVJ3WUdOVEVjQzhra2hnTzdFTitwZ1ZsVnJ3NFBy?=
 =?utf-8?B?SkJCVmNXRWdxaEZEVVlCaDFzVklvdUVETDhhNWtOeUwrZ3l6dEdxTyt1SlMx?=
 =?utf-8?B?cjZSdDA2VEY5QXkwaUpkRXV5TXk1bGh2dzNpNU94Yk5BVkZreG9TOGx2UTJL?=
 =?utf-8?B?aStvaDAyQkY3VWlPM2d2U3Z1eDQ0ei9zeXpWT0Y1V0l5SUozd2xiN2NqN3hX?=
 =?utf-8?B?SnJOZXlycDJDRjYvOXhucUdBNmdJS0hrM21xcjQvUGlCQnd6cXVadzZZbG1M?=
 =?utf-8?B?SDljdnk2bG9GbzYzemw1djVIaTV3cWVGZlFlNzdPS3FmbHRsdkdJYTJHZ0s1?=
 =?utf-8?B?ajdNQTJLZnBuVFZid3VNU1V0dzhKU0llTTFPQ3Q4VG10NTIxSkNCK0RxamQw?=
 =?utf-8?B?TjdHeVd1b1krcU1vTEQ3M3JGVDQzUDFILzRTa0Z5ZlJubm5yU2FKTTF3QWcr?=
 =?utf-8?B?UEZ2YXFqQ2x4cFg4d1JjTG9sVjJmMkxSM09TalB2ZWxaMUlndGQxTElPZ2Rv?=
 =?utf-8?B?ck55cFRkNEU3cll6S2puanZtd3I3ZTFzaEpWWTZTbCs4SDg3bnJnWVkvS3U1?=
 =?utf-8?B?c0EyT2JSdzhGQm5GNmJGSXR3ZVlINUJDQXViZUJ1dUlZNDV5TGlkQ2RDZmJV?=
 =?utf-8?B?NHNzdmF3L0U0dGJwYWM4L3BubDMwUlJrQ3k1Q01XNldBLzd5QWNUZ3FRekV2?=
 =?utf-8?B?b0hycThtdGkweUI4SURDZGFSVTE5VnJqbUdIdlJNZ3V5eEVJODJWb284TmF2?=
 =?utf-8?B?MTdzanVDMmVBcVBlWkxlZS8rV3hGVlVraDdHSjBSSFpkVXVOeGpocUVrVXRk?=
 =?utf-8?B?d09NeUFZeDVia1pMaldWUzBqdnlINVVwM1hxejVKN2hmMGptZ0RHZllZaUlC?=
 =?utf-8?B?cXhjUmJOY0NVY0VmRUJ6MWhMajd6aE03VHhDSkZWK2RBemdqTVJQUmFjaHJ6?=
 =?utf-8?B?SGFWekFZdmkyVytDK1pDSGxURzd5VDk4TWZBLzhpb1dkbkk1VnJ0Y1hncHdM?=
 =?utf-8?B?RU5XSXRQcnpmY01hWlZaRUNxM3A3RkxZQ3owSTdIdkhYU3d3cE9zU0RXakNi?=
 =?utf-8?B?NkYxVnJrL0MrNFR2SGl3ZnlMVFJmUVFNTnZZNzJORmRzZEFnWE5jdlBJVTJz?=
 =?utf-8?B?Y1I1S2NNdXBhZ0Rqc0prdUtQMm5uam5TQU9yNG1mOXM0akMyeG45UW8wRERy?=
 =?utf-8?B?bHBwSnl6SWtKR2JMTjdiTFRMMmd1VVJnUVVpd1lDTWFuRDE2azhGZ3NKbzNu?=
 =?utf-8?B?WFZtSjBOdDhQSUJwUnR0UlV4dUpUOXdzN1VXVUV4dVh6aGRGTnd5ZkliV1lH?=
 =?utf-8?B?Vm8yY3NDOE0rVWR1KzZQVlREcEtrdG96TEFUc3lkZm1Rdlp3UmE4NUJkZ3pu?=
 =?utf-8?B?SytlT3ZxMUgwMUs3YkZOa3BuNFY4dklsc1RsRUhVSit2a3hZYXFkZ0srY3g0?=
 =?utf-8?B?dHJ5bDlCVlZJbnZmQ2ErMzZwMmhKYnc5UEN0UTJhaDNCWnNVa2h2RmFxL1Zx?=
 =?utf-8?B?Vk5TSUlERGpyM25wREl4YjRoUUJwM1V5N1dtenRuRjVteWNsc3hKMzc5bTV3?=
 =?utf-8?Q?OLnxYUCDfx9QqC7qS8RtXfg/s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9e66b0-0871-4b45-c874-08dbfb2c5044
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 16:06:34.8473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6DXZ8zKihY+ywjAz5pzJ/5dsLUlPa+BcTxd80T2H9CwyLGcSUmVPX0nUPvrgjeRkHjH80xpjgsZwBf5U/zFPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6007

On 12/12/2023 04:10, Lin, Wayne wrote:
> [Public]
> 
> Hi Mario,
> 
> Thanks for the help.
> My feeling is like this problem probably relates to specific dock. Need time to take
> further look.

Oliver,

I looked through your bugs related to this and I didn't see a reference 
to the specific docking station model.
The logs mentioned "Thinkpad dock" but no model.

Could you share more about it so that AMD can try to reproduce it?

> 
> Since reverting solves the issue now, feel free to add:
> Acked-by: Wayne Lin <wayne.lin@amd.com>

Sure, thanks.

> 
> Thanks,
> Wayne
> 
>> -----Original Message-----
>> From: Limonciello, Mario <Mario.Limonciello@amd.com>
>> Sent: Tuesday, December 12, 2023 12:15 AM
>> To: amd-gfx@lists.freedesktop.org; Wentland, Harry
>> <Harry.Wentland@amd.com>
>> Cc: Linux Regressions <regressions@lists.linux.dev>; stable@vger.kernel.org;
>> Wheeler, Daniel <Daniel.Wheeler@amd.com>; Lin, Wayne
>> <Wayne.Lin@amd.com>; Oliver Schmidt <oliver@luced.de>
>> Subject: Re: [PATCH] Revert "drm/amd/display: Adjust the MST resume flow"
>>
>> Ping on this one.
>>
>> On 12/5/2023 13:54, Mario Limonciello wrote:
>>> This reverts commit ec5fa9fcdeca69edf7dab5ca3b2e0ceb1c08fe9a.
>>>
>>> Reports are that this causes problems with external monitors after
>>> wake up from suspend, which is something it was directly supposed to help.
>>>
>>> Cc: Linux Regressions <regressions@lists.linux.dev>
>>> Cc: stable@vger.kernel.org
>>> Cc: Daniel Wheeler <daniel.wheeler@amd.com>
>>> Cc: Wayne Lin <wayne.lin@amd.com>
>>> Reported-by: Oliver Schmidt <oliver@luced.de>
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218211
>>> Link:
>>> https://forum.manjaro.org/t/problems-with-external-monitor-wake-up-aft
>>> er-suspend/151840
>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3023
>>> Signed-off-by: Mario Limonciello <mario.limonciello
>>> <mario.limonciello@amd.com>
>>> ---
>>>    .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 93 +++--------------
>> --
>>>    1 file changed, 13 insertions(+), 80 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index c146dc9cba92..1ba58e4ecab3 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -2363,62 +2363,14 @@ static int dm_late_init(void *handle)
>>>      return detect_mst_link_for_all_connectors(adev_to_drm(adev));
>>>    }
>>>
>>> -static void resume_mst_branch_status(struct drm_dp_mst_topology_mgr
>>> *mgr) -{
>>> -   int ret;
>>> -   u8 guid[16];
>>> -   u64 tmp64;
>>> -
>>> -   mutex_lock(&mgr->lock);
>>> -   if (!mgr->mst_primary)
>>> -           goto out_fail;
>>> -
>>> -   if (drm_dp_read_dpcd_caps(mgr->aux, mgr->dpcd) < 0) {
>>> -           drm_dbg_kms(mgr->dev, "dpcd read failed - undocked during
>> suspend?\n");
>>> -           goto out_fail;
>>> -   }
>>> -
>>> -   ret = drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
>>> -                            DP_MST_EN |
>>> -                            DP_UP_REQ_EN |
>>> -                            DP_UPSTREAM_IS_SRC);
>>> -   if (ret < 0) {
>>> -           drm_dbg_kms(mgr->dev, "mst write failed - undocked during
>> suspend?\n");
>>> -           goto out_fail;
>>> -   }
>>> -
>>> -   /* Some hubs forget their guids after they resume */
>>> -   ret = drm_dp_dpcd_read(mgr->aux, DP_GUID, guid, 16);
>>> -   if (ret != 16) {
>>> -           drm_dbg_kms(mgr->dev, "dpcd read failed - undocked during
>> suspend?\n");
>>> -           goto out_fail;
>>> -   }
>>> -
>>> -   if (memchr_inv(guid, 0, 16) == NULL) {
>>> -           tmp64 = get_jiffies_64();
>>> -           memcpy(&guid[0], &tmp64, sizeof(u64));
>>> -           memcpy(&guid[8], &tmp64, sizeof(u64));
>>> -
>>> -           ret = drm_dp_dpcd_write(mgr->aux, DP_GUID, guid, 16);
>>> -
>>> -           if (ret != 16) {
>>> -                   drm_dbg_kms(mgr->dev, "check mstb guid failed -
>> undocked during suspend?\n");
>>> -                   goto out_fail;
>>> -           }
>>> -   }
>>> -
>>> -   memcpy(mgr->mst_primary->guid, guid, 16);
>>> -
>>> -out_fail:
>>> -   mutex_unlock(&mgr->lock);
>>> -}
>>> -
>>>    static void s3_handle_mst(struct drm_device *dev, bool suspend)
>>>    {
>>>      struct amdgpu_dm_connector *aconnector;
>>>      struct drm_connector *connector;
>>>      struct drm_connector_list_iter iter;
>>>      struct drm_dp_mst_topology_mgr *mgr;
>>> +   int ret;
>>> +   bool need_hotplug = false;
>>>
>>>      drm_connector_list_iter_begin(dev, &iter);
>>>      drm_for_each_connector_iter(connector, &iter) { @@ -2444,15
>>> +2396,18 @@ static void s3_handle_mst(struct drm_device *dev, bool
>> suspend)
>>>                      if (!dp_is_lttpr_present(aconnector->dc_link))
>>>                              try_to_configure_aux_timeout(aconnector-
>>> dc_link->ddc,
>>> LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
>>>
>>> -                   /* TODO: move resume_mst_branch_status() into
>> drm mst resume again
>>> -                    * once topology probing work is pulled out from mst
>> resume into mst
>>> -                    * resume 2nd step. mst resume 2nd step should be
>> called after old
>>> -                    * state getting restored (i.e.
>> drm_atomic_helper_resume()).
>>> -                    */
>>> -                   resume_mst_branch_status(mgr);
>>> +                   ret = drm_dp_mst_topology_mgr_resume(mgr, true);
>>> +                   if (ret < 0) {
>>> +
>>        dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
>>> +                                   aconnector->dc_link);
>>> +                           need_hotplug = true;
>>> +                   }
>>>              }
>>>      }
>>>      drm_connector_list_iter_end(&iter);
>>> +
>>> +   if (need_hotplug)
>>> +           drm_kms_helper_hotplug_event(dev);
>>>    }
>>>
>>>    static int amdgpu_dm_smu_write_watermarks_table(struct
>> amdgpu_device
>>> *adev) @@ -2849,8 +2804,7 @@ static int dm_resume(void *handle)
>>>      struct dm_atomic_state *dm_state = to_dm_atomic_state(dm-
>>> atomic_obj.state);
>>>      enum dc_connection_type new_connection_type =
>> dc_connection_none;
>>>      struct dc_state *dc_state;
>>> -   int i, r, j, ret;
>>> -   bool need_hotplug = false;
>>> +   int i, r, j;
>>>
>>>      if (dm->dc->caps.ips_support) {
>>>              dc_dmub_srv_exit_low_power_state(dm->dc);
>>> @@ -2957,7 +2911,7 @@ static int dm_resume(void *handle)
>>>                      continue;
>>>
>>>              /*
>>> -            * this is the case when traversing through already created end
>> sink
>>> +            * this is the case when traversing through already created
>>>               * MST connectors, should be skipped
>>>               */
>>>              if (aconnector && aconnector->mst_root) @@ -3017,27
>> +2971,6 @@
>>> static int dm_resume(void *handle)
>>>
>>>      dm->cached_state = NULL;
>>>
>>> -   /* Do mst topology probing after resuming cached state*/
>>> -   drm_connector_list_iter_begin(ddev, &iter);
>>> -   drm_for_each_connector_iter(connector, &iter) {
>>> -           aconnector = to_amdgpu_dm_connector(connector);
>>> -           if (aconnector->dc_link->type != dc_connection_mst_branch
>> ||
>>> -               aconnector->mst_root)
>>> -                   continue;
>>> -
>>> -           ret = drm_dp_mst_topology_mgr_resume(&aconnector-
>>> mst_mgr, true);
>>> -
>>> -           if (ret < 0) {
>>> -                   dm_helpers_dp_mst_stop_top_mgr(aconnector-
>>> dc_link->ctx,
>>> -                                   aconnector->dc_link);
>>> -                   need_hotplug = true;
>>> -           }
>>> -   }
>>> -   drm_connector_list_iter_end(&iter);
>>> -
>>> -   if (need_hotplug)
>>> -           drm_kms_helper_hotplug_event(ddev);
>>> -
>>>      amdgpu_dm_irq_resume_late(adev);
>>>
>>>      amdgpu_dm_smu_write_watermarks_table(adev);
> 


