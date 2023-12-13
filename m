Return-Path: <stable+bounces-6575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5987810D13
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 10:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900201C20981
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 09:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601C81EB53;
	Wed, 13 Dec 2023 09:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="MZshgNOj"
X-Original-To: stable@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470D7B7
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 01:10:55 -0800 (PST)
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
	by mxout4.routing.net (Postfix) with ESMTP id 87E8F1025DE;
	Wed, 13 Dec 2023 09:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1702458653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OCHbdLgqW3reNGeMCYDYbDUlWLurQI0BhYSsAGhgkmM=;
	b=MZshgNOjSX7T1cpqLYGwG50A0ONZqgkb0UOnWjQ7cmCWmqDM80YdZ5UGq+L78knaaUn0bM
	KomzTWI7dAdIjuInxR9V6FO9z4ZqvmNWTKXYY4wXc574IgUML/xXIl4+oAbpaTdlgkBERw
	DmCLnOrkuo7pHv5SNxLicYS7B5nwPsw=
Received: from [192.168.178.75] (dynamic-095-116-089-091.95.116.pool.telefonica.de [95.116.89.91])
	by mxbox4.masterlogin.de (Postfix) with ESMTPSA id BA7D6807C4;
	Wed, 13 Dec 2023 09:10:52 +0000 (UTC)
From: Oliver Schmidt <oliver@luced.de>
Subject: Re: [PATCH] Revert "drm/amd/display: Adjust the MST resume flow"
To: Mario Limonciello <mario.limonciello@amd.com>,
 Oliver Schmidt <oliver@luced.de>, "Lin, Wayne" <Wayne.Lin@amd.com>,
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
 <cfb9d9ea-c2ac-42d6-9122-57393c66dd6d@amd.com>
Message-ID: <dc5ec17a-6eed-a5f8-932c-ee8a97d90abd@luced.de>
Date: Wed, 13 Dec 2023 10:10:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cfb9d9ea-c2ac-42d6-9122-57393c66dd6d@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Mail-ID: 98b203a7-2ac4-48ed-8c5a-f80f095a367c

On 13.12.23 02:21, Mario Limonciello wrote:
> By chance do you have access to any other dock or monitor combinations that
> you can conclude it only happens on this dock or only a certain monitor, or
> only a certain monitor connected to this dock?

Mario, that was a good suggestion! I indeed had access to another docking
station, although it's the same type. I than tried this docking station with my
AMD X13 Thinkpad and it was working there.

It turned out, the working docking station had newer firmware. So I updated the
firmware and now it works :-)

Firmware Update: ThinkPad Docking Station Firmware Utility v3.3.4
(cs18dkfw334_web.exe) from https://pcsupport.lenovo.com/us/en/downloads/DS505699

How to resolve my issues on freedesktop.org and bugzilla.kernel.org?

Thank you for your support!

On 13.12.23 02:21, Mario Limonciello wrote:
> On 12/12/2023 18:08, Oliver Schmidt wrote:
>> Hi Wayne,
>>
>> On 12.12.23 17:06, Mario Limonciello wrote:
>>> I looked through your bugs related to this and I didn't see a reference to the
>>> specific docking station model.
>>> The logs mentioned "Thinkpad dock" but no model.
>>> Could you share more about it so that AMD can try to reproduce it?
>>
>> Yes, it is a ThinkPad Ultra Dockingstation, part number 40AJ0135EU, see also
>> https://support.lenovo.com/us/en/solutions/pd500173-thinkpad-ultra-docking-station-overview-and-service-parts
>>
>>
> 
> By chance do you have access to any other dock or monitor combinations that you
> can conclude it only happens on this dock or only a certain monitor, or only a
> certain monitor connected to this dock?
> 
>> Best regards,
>> Oliver
>>
>> On 12.12.23 17:06, Mario Limonciello wrote:
>>> On 12/12/2023 04:10, Lin, Wayne wrote:
>>>> [Public]
>>>>
>>>> Hi Mario,
>>>>
>>>> Thanks for the help.
>>>> My feeling is like this problem probably relates to specific dock. Need time
>>>> to take
>>>> further look.
>>>
>>> Oliver,
>>>
>>> I looked through your bugs related to this and I didn't see a reference to the
>>> specific docking station model.
>>> The logs mentioned "Thinkpad dock" but no model.
>>>
>>> Could you share more about it so that AMD can try to reproduce it?
>>>
>>>>
>>>> Since reverting solves the issue now, feel free to add:
>>>> Acked-by: Wayne Lin <wayne.lin@amd.com>
>>>
>>> Sure, thanks.
>>>
>>>>
>>>> Thanks,
>>>> Wayne
>>>>
>>>>> -----Original Message-----
>>>>> From: Limonciello, Mario <Mario.Limonciello@amd.com>
>>>>> Sent: Tuesday, December 12, 2023 12:15 AM
>>>>> To: amd-gfx@lists.freedesktop.org; Wentland, Harry
>>>>> <Harry.Wentland@amd.com>
>>>>> Cc: Linux Regressions <regressions@lists.linux.dev>; stable@vger.kernel.org;
>>>>> Wheeler, Daniel <Daniel.Wheeler@amd.com>; Lin, Wayne
>>>>> <Wayne.Lin@amd.com>; Oliver Schmidt <oliver@luced.de>
>>>>> Subject: Re: [PATCH] Revert "drm/amd/display: Adjust the MST resume flow"
>>>>>
>>>>> Ping on this one.
>>>>>
>>>>> On 12/5/2023 13:54, Mario Limonciello wrote:
>>>>>> This reverts commit ec5fa9fcdeca69edf7dab5ca3b2e0ceb1c08fe9a.
>>>>>>
>>>>>> Reports are that this causes problems with external monitors after
>>>>>> wake up from suspend, which is something it was directly supposed to help.
>>>>>>
>>>>>> Cc: Linux Regressions <regressions@lists.linux.dev>
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Cc: Daniel Wheeler <daniel.wheeler@amd.com>
>>>>>> Cc: Wayne Lin <wayne.lin@amd.com>
>>>>>> Reported-by: Oliver Schmidt <oliver@luced.de>
>>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218211
>>>>>> Link:
>>>>>> https://forum.manjaro.org/t/problems-with-external-monitor-wake-up-aft
>>>>>> er-suspend/151840
>>>>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3023
>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello
>>>>>> <mario.limonciello@amd.com>
>>>>>> ---
>>>>>>     .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 93 +++--------------
>>>>> -- 
>>>>>>     1 file changed, 13 insertions(+), 80 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>>> index c146dc9cba92..1ba58e4ecab3 100644
>>>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>>> @@ -2363,62 +2363,14 @@ static int dm_late_init(void *handle)
>>>>>>       return detect_mst_link_for_all_connectors(adev_to_drm(adev));
>>>>>>     }
>>>>>>
>>>>>> -static void resume_mst_branch_status(struct drm_dp_mst_topology_mgr
>>>>>> *mgr) -{
>>>>>> -   int ret;
>>>>>> -   u8 guid[16];
>>>>>> -   u64 tmp64;
>>>>>> -
>>>>>> -   mutex_lock(&mgr->lock);
>>>>>> -   if (!mgr->mst_primary)
>>>>>> -           goto out_fail;
>>>>>> -
>>>>>> -   if (drm_dp_read_dpcd_caps(mgr->aux, mgr->dpcd) < 0) {
>>>>>> -           drm_dbg_kms(mgr->dev, "dpcd read failed - undocked during
>>>>> suspend?\n");
>>>>>> -           goto out_fail;
>>>>>> -   }
>>>>>> -
>>>>>> -   ret = drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
>>>>>> -                            DP_MST_EN |
>>>>>> -                            DP_UP_REQ_EN |
>>>>>> -                            DP_UPSTREAM_IS_SRC);
>>>>>> -   if (ret < 0) {
>>>>>> -           drm_dbg_kms(mgr->dev, "mst write failed - undocked during
>>>>> suspend?\n");
>>>>>> -           goto out_fail;
>>>>>> -   }
>>>>>> -
>>>>>> -   /* Some hubs forget their guids after they resume */
>>>>>> -   ret = drm_dp_dpcd_read(mgr->aux, DP_GUID, guid, 16);
>>>>>> -   if (ret != 16) {
>>>>>> -           drm_dbg_kms(mgr->dev, "dpcd read failed - undocked during
>>>>> suspend?\n");
>>>>>> -           goto out_fail;
>>>>>> -   }
>>>>>> -
>>>>>> -   if (memchr_inv(guid, 0, 16) == NULL) {
>>>>>> -           tmp64 = get_jiffies_64();
>>>>>> -           memcpy(&guid[0], &tmp64, sizeof(u64));
>>>>>> -           memcpy(&guid[8], &tmp64, sizeof(u64));
>>>>>> -
>>>>>> -           ret = drm_dp_dpcd_write(mgr->aux, DP_GUID, guid, 16);
>>>>>> -
>>>>>> -           if (ret != 16) {
>>>>>> -                   drm_dbg_kms(mgr->dev, "check mstb guid failed -
>>>>> undocked during suspend?\n");
>>>>>> -                   goto out_fail;
>>>>>> -           }
>>>>>> -   }
>>>>>> -
>>>>>> -   memcpy(mgr->mst_primary->guid, guid, 16);
>>>>>> -
>>>>>> -out_fail:
>>>>>> -   mutex_unlock(&mgr->lock);
>>>>>> -}
>>>>>> -
>>>>>>     static void s3_handle_mst(struct drm_device *dev, bool suspend)
>>>>>>     {
>>>>>>       struct amdgpu_dm_connector *aconnector;
>>>>>>       struct drm_connector *connector;
>>>>>>       struct drm_connector_list_iter iter;
>>>>>>       struct drm_dp_mst_topology_mgr *mgr;
>>>>>> +   int ret;
>>>>>> +   bool need_hotplug = false;
>>>>>>
>>>>>>       drm_connector_list_iter_begin(dev, &iter);
>>>>>>       drm_for_each_connector_iter(connector, &iter) { @@ -2444,15
>>>>>> +2396,18 @@ static void s3_handle_mst(struct drm_device *dev, bool
>>>>> suspend)
>>>>>>                       if (!dp_is_lttpr_present(aconnector->dc_link))
>>>>>>                               try_to_configure_aux_timeout(aconnector-
>>>>>> dc_link->ddc,
>>>>>> LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
>>>>>>
>>>>>> -                   /* TODO: move resume_mst_branch_status() into
>>>>> drm mst resume again
>>>>>> -                    * once topology probing work is pulled out from mst
>>>>> resume into mst
>>>>>> -                    * resume 2nd step. mst resume 2nd step should be
>>>>> called after old
>>>>>> -                    * state getting restored (i.e.
>>>>> drm_atomic_helper_resume()).
>>>>>> -                    */
>>>>>> -                   resume_mst_branch_status(mgr);
>>>>>> +                   ret = drm_dp_mst_topology_mgr_resume(mgr, true);
>>>>>> +                   if (ret < 0) {
>>>>>> +
>>>>>         dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
>>>>>> +                                   aconnector->dc_link);
>>>>>> +                           need_hotplug = true;
>>>>>> +                   }
>>>>>>               }
>>>>>>       }
>>>>>>       drm_connector_list_iter_end(&iter);
>>>>>> +
>>>>>> +   if (need_hotplug)
>>>>>> +           drm_kms_helper_hotplug_event(dev);
>>>>>>     }
>>>>>>
>>>>>>     static int amdgpu_dm_smu_write_watermarks_table(struct
>>>>> amdgpu_device
>>>>>> *adev) @@ -2849,8 +2804,7 @@ static int dm_resume(void *handle)
>>>>>>       struct dm_atomic_state *dm_state = to_dm_atomic_state(dm-
>>>>>> atomic_obj.state);
>>>>>>       enum dc_connection_type new_connection_type =
>>>>> dc_connection_none;
>>>>>>       struct dc_state *dc_state;
>>>>>> -   int i, r, j, ret;
>>>>>> -   bool need_hotplug = false;
>>>>>> +   int i, r, j;
>>>>>>
>>>>>>       if (dm->dc->caps.ips_support) {
>>>>>>               dc_dmub_srv_exit_low_power_state(dm->dc);
>>>>>> @@ -2957,7 +2911,7 @@ static int dm_resume(void *handle)
>>>>>>                       continue;
>>>>>>
>>>>>>               /*
>>>>>> -            * this is the case when traversing through already created end
>>>>> sink
>>>>>> +            * this is the case when traversing through already created
>>>>>>                * MST connectors, should be skipped
>>>>>>                */
>>>>>>               if (aconnector && aconnector->mst_root) @@ -3017,27
>>>>> +2971,6 @@
>>>>>> static int dm_resume(void *handle)
>>>>>>
>>>>>>       dm->cached_state = NULL;
>>>>>>
>>>>>> -   /* Do mst topology probing after resuming cached state*/
>>>>>> -   drm_connector_list_iter_begin(ddev, &iter);
>>>>>> -   drm_for_each_connector_iter(connector, &iter) {
>>>>>> -           aconnector = to_amdgpu_dm_connector(connector);
>>>>>> -           if (aconnector->dc_link->type != dc_connection_mst_branch
>>>>> ||
>>>>>> -               aconnector->mst_root)
>>>>>> -                   continue;
>>>>>> -
>>>>>> -           ret = drm_dp_mst_topology_mgr_resume(&aconnector-
>>>>>> mst_mgr, true);
>>>>>> -
>>>>>> -           if (ret < 0) {
>>>>>> -                   dm_helpers_dp_mst_stop_top_mgr(aconnector-
>>>>>> dc_link->ctx,
>>>>>> -                                   aconnector->dc_link);
>>>>>> -                   need_hotplug = true;
>>>>>> -           }
>>>>>> -   }
>>>>>> -   drm_connector_list_iter_end(&iter);
>>>>>> -
>>>>>> -   if (need_hotplug)
>>>>>> -           drm_kms_helper_hotplug_event(ddev);
>>>>>> -
>>>>>>       amdgpu_dm_irq_resume_late(adev);
>>>>>>
>>>>>>       amdgpu_dm_smu_write_watermarks_table(adev);
>>>>
>>>
> 

