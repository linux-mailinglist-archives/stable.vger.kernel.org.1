Return-Path: <stable+bounces-6599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C010E81146D
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 15:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 076ABB20C75
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 14:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB302E845;
	Wed, 13 Dec 2023 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiTNknc/"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE0BAC
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 06:17:13 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b9fcb3223dso3797471b6e.3
        for <stable@vger.kernel.org>; Wed, 13 Dec 2023 06:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702477033; x=1703081833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwwopG1pmZ2n3upcRHX7NHadWpkrg2UdfeITzRxKMpo=;
        b=GiTNknc/cPm2jOFsf1c9ScEDkyPR1TiXNcUmmaA3KtAUU/xZr89Uo4Px6zEaeH3fms
         wMCw3CxY4hhdS6fEm91YK5lhHYmcf94buUyBB3cgXOxlazWLrllNuIy40aEGcI4QoUTg
         7cIXutf9CnjwX10q+D+ErJ8eZZiegReLXAkxgFiMYbHImGvE9cGuiPgjqOnl4ruLTj29
         iiDLNbONo376ODnE/jQdL337Eifoxd7I+hIX/GH5fnUml2iLPU8vCGvjvckglxUhipSz
         wz+oK4voVPhBWLXSitRz4/wbDnlnHwzv77kP6Oc0NyTGNst3qp0oe3Ms+RBtPfG0O3AM
         +5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702477033; x=1703081833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwwopG1pmZ2n3upcRHX7NHadWpkrg2UdfeITzRxKMpo=;
        b=k6Z+cBpM89ihYiyaKzAqlTRPfPNieMD5a4aNuwmVoHIllPM3aFofim/mAiM7clCXZF
         sLZabAJemGBP+/0ik/uLVaI//rwphQXhWiw9WAP05M7G6cF/rWAO2cybVhjaeRK/xGdh
         hcKrR4ojTWHQsrf6P62bQ3nBESXQRJUoMg+IC32KiqqU1SsJrHEUXr3xIbKCIp650yGj
         aMrjmgrlW7rMB0sQisnLAYN4/oXJ1uG1tAdhWxT3lNLJ3UsdjFyhdAgJ2wYebHJPqsM1
         8jSsQp8B9w9RiFhCNsZLaKiWw9YNjSZxcZuWBKeMFSNe6ZYZvISK1YxzQcv/r5NFHKm6
         hLmg==
X-Gm-Message-State: AOJu0YwHR4et+ZjrWGY7rO9FxFWQg4funfx9jqmxPGYUUjG3U7l7aJwM
	Sm02k/SfgseLKOUrIuzMQi9ZdMpK8qNgSamOsVn2jFss
X-Google-Smtp-Source: AGHT+IHiQYT1aI9+To0TcbM6Qafqu2xfpE2tdsbWAIxcqq2YLIoMek0twPV0WrR2DFdS4UwMQgbDEvvvs/HDqYZbS4Q=
X-Received: by 2002:a05:6870:9123:b0:1fb:75c:3ff3 with SMTP id
 o35-20020a056870912300b001fb075c3ff3mr10876097oae.83.1702477032855; Wed, 13
 Dec 2023 06:17:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205195436.16081-1-mario.limonciello@amd.com>
 <6e941b94-f3e0-4463-82cf-13bac0d22ebe@amd.com> <CO6PR12MB54895D053CC24153B3358344FC8EA@CO6PR12MB5489.namprd12.prod.outlook.com>
 <bb2212b2-5503-49d4-a607-bdf6885681f6@amd.com> <24cd225b-df66-14c1-d951-72c4a5509437@luced.de>
 <cfb9d9ea-c2ac-42d6-9122-57393c66dd6d@amd.com>
In-Reply-To: <cfb9d9ea-c2ac-42d6-9122-57393c66dd6d@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Dec 2023 09:17:01 -0500
Message-ID: <CADnq5_NtVufiPfTyLS-pDKcqkU9uEu23=bEasoQvy6iOQ-9snA@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: Adjust the MST resume flow"
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Oliver Schmidt <oliver@luced.de>, "Lin, Wayne" <Wayne.Lin@amd.com>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wentland, Harry" <Harry.Wentland@amd.com>, 
	"Wheeler, Daniel" <Daniel.Wheeler@amd.com>, Linux Regressions <regressions@lists.linux.dev>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 9:00=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 12/12/2023 18:08, Oliver Schmidt wrote:
> > Hi Wayne,
> >
> > On 12.12.23 17:06, Mario Limonciello wrote:
> >> I looked through your bugs related to this and I didn't see a referenc=
e to the
> >> specific docking station model.
> >> The logs mentioned "Thinkpad dock" but no model.
> >> Could you share more about it so that AMD can try to reproduce it?
> >
> > Yes, it is a ThinkPad Ultra Dockingstation, part number 40AJ0135EU, see=
 also
> > https://support.lenovo.com/us/en/solutions/pd500173-thinkpad-ultra-dock=
ing-station-overview-and-service-parts
> >
>
> By chance do you have access to any other dock or monitor combinations
> that you can conclude it only happens on this dock or only a certain
> monitor, or only a certain monitor connected to this dock?

IIRC, Wayne's patch was to fix an HP dock, I suspect reverting this
will just break one dock to fix another.  Wayne, do you have the other
problematic dock that this patch was needed to fix or even the
thinkpad dock?  Would be nice to properly sort this out if possible.

Alex

>
> > Best regards,
> > Oliver
> >
> > On 12.12.23 17:06, Mario Limonciello wrote:
> >> On 12/12/2023 04:10, Lin, Wayne wrote:
> >>> [Public]
> >>>
> >>> Hi Mario,
> >>>
> >>> Thanks for the help.
> >>> My feeling is like this problem probably relates to specific dock. Ne=
ed time
> >>> to take
> >>> further look.
> >>
> >> Oliver,
> >>
> >> I looked through your bugs related to this and I didn't see a referenc=
e to the
> >> specific docking station model.
> >> The logs mentioned "Thinkpad dock" but no model.
> >>
> >> Could you share more about it so that AMD can try to reproduce it?
> >>
> >>>
> >>> Since reverting solves the issue now, feel free to add:
> >>> Acked-by: Wayne Lin <wayne.lin@amd.com>
> >>
> >> Sure, thanks.
> >>
> >>>
> >>> Thanks,
> >>> Wayne
> >>>
> >>>> -----Original Message-----
> >>>> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> >>>> Sent: Tuesday, December 12, 2023 12:15 AM
> >>>> To: amd-gfx@lists.freedesktop.org; Wentland, Harry
> >>>> <Harry.Wentland@amd.com>
> >>>> Cc: Linux Regressions <regressions@lists.linux.dev>; stable@vger.ker=
nel.org;
> >>>> Wheeler, Daniel <Daniel.Wheeler@amd.com>; Lin, Wayne
> >>>> <Wayne.Lin@amd.com>; Oliver Schmidt <oliver@luced.de>
> >>>> Subject: Re: [PATCH] Revert "drm/amd/display: Adjust the MST resume =
flow"
> >>>>
> >>>> Ping on this one.
> >>>>
> >>>> On 12/5/2023 13:54, Mario Limonciello wrote:
> >>>>> This reverts commit ec5fa9fcdeca69edf7dab5ca3b2e0ceb1c08fe9a.
> >>>>>
> >>>>> Reports are that this causes problems with external monitors after
> >>>>> wake up from suspend, which is something it was directly supposed t=
o help.
> >>>>>
> >>>>> Cc: Linux Regressions <regressions@lists.linux.dev>
> >>>>> Cc: stable@vger.kernel.org
> >>>>> Cc: Daniel Wheeler <daniel.wheeler@amd.com>
> >>>>> Cc: Wayne Lin <wayne.lin@amd.com>
> >>>>> Reported-by: Oliver Schmidt <oliver@luced.de>
> >>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218211
> >>>>> Link:
> >>>>> https://forum.manjaro.org/t/problems-with-external-monitor-wake-up-=
aft
> >>>>> er-suspend/151840
> >>>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3023
> >>>>> Signed-off-by: Mario Limonciello <mario.limonciello
> >>>>> <mario.limonciello@amd.com>
> >>>>> ---
> >>>>>     .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 93 +++---------=
-----
> >>>> --
> >>>>>     1 file changed, 13 insertions(+), 80 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>>>> index c146dc9cba92..1ba58e4ecab3 100644
> >>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>>>> @@ -2363,62 +2363,14 @@ static int dm_late_init(void *handle)
> >>>>>       return detect_mst_link_for_all_connectors(adev_to_drm(adev));
> >>>>>     }
> >>>>>
> >>>>> -static void resume_mst_branch_status(struct drm_dp_mst_topology_mg=
r
> >>>>> *mgr) -{
> >>>>> -   int ret;
> >>>>> -   u8 guid[16];
> >>>>> -   u64 tmp64;
> >>>>> -
> >>>>> -   mutex_lock(&mgr->lock);
> >>>>> -   if (!mgr->mst_primary)
> >>>>> -           goto out_fail;
> >>>>> -
> >>>>> -   if (drm_dp_read_dpcd_caps(mgr->aux, mgr->dpcd) < 0) {
> >>>>> -           drm_dbg_kms(mgr->dev, "dpcd read failed - undocked duri=
ng
> >>>> suspend?\n");
> >>>>> -           goto out_fail;
> >>>>> -   }
> >>>>> -
> >>>>> -   ret =3D drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
> >>>>> -                            DP_MST_EN |
> >>>>> -                            DP_UP_REQ_EN |
> >>>>> -                            DP_UPSTREAM_IS_SRC);
> >>>>> -   if (ret < 0) {
> >>>>> -           drm_dbg_kms(mgr->dev, "mst write failed - undocked duri=
ng
> >>>> suspend?\n");
> >>>>> -           goto out_fail;
> >>>>> -   }
> >>>>> -
> >>>>> -   /* Some hubs forget their guids after they resume */
> >>>>> -   ret =3D drm_dp_dpcd_read(mgr->aux, DP_GUID, guid, 16);
> >>>>> -   if (ret !=3D 16) {
> >>>>> -           drm_dbg_kms(mgr->dev, "dpcd read failed - undocked duri=
ng
> >>>> suspend?\n");
> >>>>> -           goto out_fail;
> >>>>> -   }
> >>>>> -
> >>>>> -   if (memchr_inv(guid, 0, 16) =3D=3D NULL) {
> >>>>> -           tmp64 =3D get_jiffies_64();
> >>>>> -           memcpy(&guid[0], &tmp64, sizeof(u64));
> >>>>> -           memcpy(&guid[8], &tmp64, sizeof(u64));
> >>>>> -
> >>>>> -           ret =3D drm_dp_dpcd_write(mgr->aux, DP_GUID, guid, 16);
> >>>>> -
> >>>>> -           if (ret !=3D 16) {
> >>>>> -                   drm_dbg_kms(mgr->dev, "check mstb guid failed -
> >>>> undocked during suspend?\n");
> >>>>> -                   goto out_fail;
> >>>>> -           }
> >>>>> -   }
> >>>>> -
> >>>>> -   memcpy(mgr->mst_primary->guid, guid, 16);
> >>>>> -
> >>>>> -out_fail:
> >>>>> -   mutex_unlock(&mgr->lock);
> >>>>> -}
> >>>>> -
> >>>>>     static void s3_handle_mst(struct drm_device *dev, bool suspend)
> >>>>>     {
> >>>>>       struct amdgpu_dm_connector *aconnector;
> >>>>>       struct drm_connector *connector;
> >>>>>       struct drm_connector_list_iter iter;
> >>>>>       struct drm_dp_mst_topology_mgr *mgr;
> >>>>> +   int ret;
> >>>>> +   bool need_hotplug =3D false;
> >>>>>
> >>>>>       drm_connector_list_iter_begin(dev, &iter);
> >>>>>       drm_for_each_connector_iter(connector, &iter) { @@ -2444,15
> >>>>> +2396,18 @@ static void s3_handle_mst(struct drm_device *dev, bool
> >>>> suspend)
> >>>>>                       if (!dp_is_lttpr_present(aconnector->dc_link)=
)
> >>>>>                               try_to_configure_aux_timeout(aconnect=
or-
> >>>>> dc_link->ddc,
> >>>>> LINK_AUX_DEFAULT_TIMEOUT_PERIOD);
> >>>>>
> >>>>> -                   /* TODO: move resume_mst_branch_status() into
> >>>> drm mst resume again
> >>>>> -                    * once topology probing work is pulled out fro=
m mst
> >>>> resume into mst
> >>>>> -                    * resume 2nd step. mst resume 2nd step should =
be
> >>>> called after old
> >>>>> -                    * state getting restored (i.e.
> >>>> drm_atomic_helper_resume()).
> >>>>> -                    */
> >>>>> -                   resume_mst_branch_status(mgr);
> >>>>> +                   ret =3D drm_dp_mst_topology_mgr_resume(mgr, tru=
e);
> >>>>> +                   if (ret < 0) {
> >>>>> +
> >>>>         dm_helpers_dp_mst_stop_top_mgr(aconnector->dc_link->ctx,
> >>>>> +                                   aconnector->dc_link);
> >>>>> +                           need_hotplug =3D true;
> >>>>> +                   }
> >>>>>               }
> >>>>>       }
> >>>>>       drm_connector_list_iter_end(&iter);
> >>>>> +
> >>>>> +   if (need_hotplug)
> >>>>> +           drm_kms_helper_hotplug_event(dev);
> >>>>>     }
> >>>>>
> >>>>>     static int amdgpu_dm_smu_write_watermarks_table(struct
> >>>> amdgpu_device
> >>>>> *adev) @@ -2849,8 +2804,7 @@ static int dm_resume(void *handle)
> >>>>>       struct dm_atomic_state *dm_state =3D to_dm_atomic_state(dm-
> >>>>> atomic_obj.state);
> >>>>>       enum dc_connection_type new_connection_type =3D
> >>>> dc_connection_none;
> >>>>>       struct dc_state *dc_state;
> >>>>> -   int i, r, j, ret;
> >>>>> -   bool need_hotplug =3D false;
> >>>>> +   int i, r, j;
> >>>>>
> >>>>>       if (dm->dc->caps.ips_support) {
> >>>>>               dc_dmub_srv_exit_low_power_state(dm->dc);
> >>>>> @@ -2957,7 +2911,7 @@ static int dm_resume(void *handle)
> >>>>>                       continue;
> >>>>>
> >>>>>               /*
> >>>>> -            * this is the case when traversing through already cre=
ated end
> >>>> sink
> >>>>> +            * this is the case when traversing through already cre=
ated
> >>>>>                * MST connectors, should be skipped
> >>>>>                */
> >>>>>               if (aconnector && aconnector->mst_root) @@ -3017,27
> >>>> +2971,6 @@
> >>>>> static int dm_resume(void *handle)
> >>>>>
> >>>>>       dm->cached_state =3D NULL;
> >>>>>
> >>>>> -   /* Do mst topology probing after resuming cached state*/
> >>>>> -   drm_connector_list_iter_begin(ddev, &iter);
> >>>>> -   drm_for_each_connector_iter(connector, &iter) {
> >>>>> -           aconnector =3D to_amdgpu_dm_connector(connector);
> >>>>> -           if (aconnector->dc_link->type !=3D dc_connection_mst_br=
anch
> >>>> ||
> >>>>> -               aconnector->mst_root)
> >>>>> -                   continue;
> >>>>> -
> >>>>> -           ret =3D drm_dp_mst_topology_mgr_resume(&aconnector-
> >>>>> mst_mgr, true);
> >>>>> -
> >>>>> -           if (ret < 0) {
> >>>>> -                   dm_helpers_dp_mst_stop_top_mgr(aconnector-
> >>>>> dc_link->ctx,
> >>>>> -                                   aconnector->dc_link);
> >>>>> -                   need_hotplug =3D true;
> >>>>> -           }
> >>>>> -   }
> >>>>> -   drm_connector_list_iter_end(&iter);
> >>>>> -
> >>>>> -   if (need_hotplug)
> >>>>> -           drm_kms_helper_hotplug_event(ddev);
> >>>>> -
> >>>>>       amdgpu_dm_irq_resume_late(adev);
> >>>>>
> >>>>>       amdgpu_dm_smu_write_watermarks_table(adev);
> >>>
> >>
>

