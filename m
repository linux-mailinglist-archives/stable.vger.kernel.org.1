Return-Path: <stable+bounces-43526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E4F8C20D7
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 11:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEFB11F22C76
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 09:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACC215FA94;
	Fri, 10 May 2024 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k9eTypSh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F157B160873
	for <stable@vger.kernel.org>; Fri, 10 May 2024 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715333063; cv=none; b=QJCzaMRAMJvTLH9g09LA1w7OUvrkuwhX6+nDXsbC0MLOswxNX7Ip0doccLQl1Wsv0wbuvyq+USpPlAvGOVDxTgBXwYUopUrQok7JrMqPc+wi98GB6igOpjIjdLGDKLp6HpoHiSSa/LgZlJvOQHMI16HHsTsKAXwX0fRnTQ/GGeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715333063; c=relaxed/simple;
	bh=8yrxVktGEbdgvFPVqR522nuzwUD0TctYiFLeO1R1ImU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O1CWnm/P2uNARmbKZ6UCq2xRlpp2xC2Ksi1Wn0e/8cArBbtyf2rgSDWaSEvK6NwpzsKn/wVIJqt8bCdeUKKFP21GFJKSWDhgZB0SLbGzLmFeCnofwHBWf3m6JT8FMELO0tTtfmOVH2G9I0CtJ9sar+t+jSpLI6S2rUpeLgO0cYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k9eTypSh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715333060; x=1746869060;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=8yrxVktGEbdgvFPVqR522nuzwUD0TctYiFLeO1R1ImU=;
  b=k9eTypShTriaCfPykR+8CwEcnPUzD+LxJUUdAXd7XZziSNml4DbRmeQH
   GfVVzuWlqvyEfPbY0a5iujbikWTap3gA5UrFiLfr3yMOCI7qJYyyTYg9/
   OKS7Nwc/mj4bibQpHy9r5IsROZP0xR625NXeLu4yWgkQVPuBwLZ8a+l/4
   DHNFVDBcIhXI9VnxvJythjy+Bh5ii4mf1Dw63lyCCvM0gKpL20jS1mqy1
   2xy0cNlK/6wRLEgUyPTh6fc7Q/ErYiLWRGj59Ka4ATMtxIy4dleo3AOf1
   Bfi00WTd2h2jAMcP9EaknaRpv0Q/hJWCgBBYita1gxT8UWPITjIvAeOMk
   Q==;
X-CSE-ConnectionGUID: C0ETcxCeQRyaU1I0oVwfKA==
X-CSE-MsgGUID: MOUP72StS42ioFAaxux9Lw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11469104"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="11469104"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 02:24:19 -0700
X-CSE-ConnectionGUID: BuCQ6ZZoQJi2Pt3PWUPNZw==
X-CSE-MsgGUID: jOCnIIIXQW25g55CZF/FqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="29414319"
Received: from ettammin-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.180])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 02:24:15 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>, Linux regressions
 mailing list <regressions@lists.linux.dev>, "Wentland, Harry"
 <Harry.Wentland@amd.com>
Cc: "lyude@redhat.com" <lyude@redhat.com>, "imre.deak@intel.com"
 <imre.deak@intel.com>, Leon =?utf-8?Q?Wei=C3=9F?=
 <leon.weiss@ruhr-uni-bochum.de>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/mst: Fix NULL pointer dereference at
 drm_dp_add_payload_part2
In-Reply-To: <CO6PR12MB5489FA9307280A4442BAD51DFCE72@CO6PR12MB5489.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240307062957.2323620-1-Wayne.Lin@amd.com>
 <0847dc03-c7db-47d7-998b-bda2e82ed442@amd.com>
 <41b87510-7abf-47e8-b28a-9ccc91bbd3c1@leemhuis.info>
 <177cfae4-b2b5-4e2c-9f1e-9ebe262ce48c@amd.com>
 <CO6PR12MB5489FA9307280A4442BAD51DFCE72@CO6PR12MB5489.namprd12.prod.outlook.com>
Date: Fri, 10 May 2024 12:24:12 +0300
Message-ID: <87wmo2hver.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 10 May 2024, "Lin, Wayne" <Wayne.Lin@amd.com> wrote:
> [Public]
>
>> -----Original Message-----
>> From: Limonciello, Mario <Mario.Limonciello@amd.com>
>> Sent: Friday, May 10, 2024 3:18 AM
>> To: Linux regressions mailing list <regressions@lists.linux.dev>; Wentla=
nd, Harry
>> <Harry.Wentland@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>
>> Cc: lyude@redhat.com; imre.deak@intel.com; Leon Wei=C3=9F <leon.weiss@ru=
hr-uni-
>> bochum.de>; stable@vger.kernel.org; dri-devel@lists.freedesktop.org; amd-
>> gfx@lists.freedesktop.org; intel-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/mst: Fix NULL pointer dereference at
>> drm_dp_add_payload_part2
>>
>> On 5/9/2024 07:43, Linux regression tracking (Thorsten Leemhuis) wrote:
>> > On 18.04.24 21:43, Harry Wentland wrote:
>> >> On 2024-03-07 01:29, Wayne Lin wrote:
>> >>> [Why]
>> >>> Commit:
>> >>> - commit 5aa1dfcdf0a4 ("drm/mst: Refactor the flow for payload
>> >>> allocation/removement") accidently overwrite the commit
>> >>> - commit 54d217406afe ("drm: use mgr->dev in drm_dbg_kms in
>> >>> drm_dp_add_payload_part2") which cause regression.
>> >>>
>> >>> [How]
>> >>> Recover the original NULL fix and remove the unnecessary input
>> >>> parameter 'state' for drm_dp_add_payload_part2().
>> >>>
>> >>> Fixes: 5aa1dfcdf0a4 ("drm/mst: Refactor the flow for payload
>> >>> allocation/removement")
>> >>> Reported-by: Leon Wei=C3=9F <leon.weiss@ruhr-uni-bochum.de>
>> >>> Link:
>> >>> https://lore.kernel.org/r/38c253ea42072cc825dc969ac4e6b9b600371cc8.c
>> >>> amel@ruhr-uni-bochum.de/
>> >>> Cc: lyude@redhat.com
>> >>> Cc: imre.deak@intel.com
>> >>> Cc: stable@vger.kernel.org
>> >>> Cc: regressions@lists.linux.dev
>> >>> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
>> >>
>> >> I haven't been deep in MST code in a while but this all looks pretty
>> >> straightforward and good.
>> >>
>> >> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>> >
>> > Hmmm, that was three weeks ago, but it seems since then nothing
>> > happened to fix the linked regression through this or some other
>> > patch. Is there a reason? The build failure report from the CI maybe?
>>
>> It touches files outside of amd but only has an ack from AMD.  I think we
>> /probably/ want an ack from i915 and nouveau to take it through.
>
> Thanks, Mario!
>
> Hi Thorsten,
> Yeah, like what Mario said. Would also like to have ack from i915 and nou=
veau.

It usually works better if you Cc the folks you want an ack from! ;)

Acked-by: Jani Nikula <jani.nikula@intel.com>

>
>>
>> >
>> > Wayne Lin, do you know what's up?
>> >
>> > Ciao, Thorsten
>> >
>> >>> ---
>> >>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
>> >>>   drivers/gpu/drm/display/drm_dp_mst_topology.c             | 4 +---
>> >>>   drivers/gpu/drm/i915/display/intel_dp_mst.c               | 2 +-
>> >>>   drivers/gpu/drm/nouveau/dispnv50/disp.c                   | 2 +-
>> >>>   include/drm/display/drm_dp_mst_helper.h                   | 1 -
>> >>>   5 files changed, 4 insertions(+), 7 deletions(-)
>> >>>
>> >>> diff --git
>> >>> a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>> >>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>> >>> index c27063305a13..2c36f3d00ca2 100644
>> >>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>> >>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>> >>> @@ -363,7 +363,7 @@ void dm_helpers_dp_mst_send_payload_allocation(
>> >>>           mst_state =3D to_drm_dp_mst_topology_state(mst_mgr->base.s=
tate);
>> >>>           new_payload =3D drm_atomic_get_mst_payload_state(mst_state,
>> >>> aconnector->mst_output_port);
>> >>>
>> >>> - ret =3D drm_dp_add_payload_part2(mst_mgr, mst_state->base.state,
>> new_payload);
>> >>> + ret =3D drm_dp_add_payload_part2(mst_mgr, new_payload);
>> >>>
>> >>>           if (ret) {
>> >>>                   amdgpu_dm_set_mst_status(&aconnector->mst_status,
>> >>> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c
>> >>> b/drivers/gpu/drm/display/drm_dp_mst_topology.c
>> >>> index 03d528209426..95fd18f24e94 100644
>> >>> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
>> >>> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
>> >>> @@ -3421,7 +3421,6 @@
>> EXPORT_SYMBOL(drm_dp_remove_payload_part2);
>> >>>   /**
>> >>>    * drm_dp_add_payload_part2() - Execute payload update part 2
>> >>>    * @mgr: Manager to use.
>> >>> - * @state: The global atomic state
>> >>>    * @payload: The payload to update
>> >>>    *
>> >>>    * If @payload was successfully assigned a starting time slot by
>> >>> drm_dp_add_payload_part1(), this @@ -3430,14 +3429,13 @@
>> EXPORT_SYMBOL(drm_dp_remove_payload_part2);
>> >>>    * Returns: 0 on success, negative error code on failure.
>> >>>    */
>> >>>   int drm_dp_add_payload_part2(struct drm_dp_mst_topology_mgr *mgr,
>> >>> -                      struct drm_atomic_state *state,
>> >>>                                struct drm_dp_mst_atomic_payload *pay=
load)
>> >>>   {
>> >>>           int ret =3D 0;
>> >>>
>> >>>           /* Skip failed payloads */
>> >>>           if (payload->payload_allocation_status !=3D
>> DRM_DP_MST_PAYLOAD_ALLOCATION_DFP) {
>> >>> -         drm_dbg_kms(state->dev, "Part 1 of payload creation for %s
>> failed, skipping part 2\n",
>> >>> +         drm_dbg_kms(mgr->dev, "Part 1 of payload creation for %s
>> failed,
>> >>> +skipping part 2\n",
>> >>>                               payload->port->connector->name);
>> >>>                   return -EIO;
>> >>>           }
>> >>> diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c
>> >>> b/drivers/gpu/drm/i915/display/intel_dp_mst.c
>> >>> index 53aec023ce92..2fba66aec038 100644
>> >>> --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
>> >>> +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
>> >>> @@ -1160,7 +1160,7 @@ static void intel_mst_enable_dp(struct
>> intel_atomic_state *state,
>> >>>           if (first_mst_stream)
>> >>>                   intel_ddi_wait_for_fec_status(encoder, pipe_config=
, true);
>> >>>
>> >>> - drm_dp_add_payload_part2(&intel_dp->mst_mgr, &state->base,
>> >>> + drm_dp_add_payload_part2(&intel_dp->mst_mgr,
>> >>>
>> drm_atomic_get_mst_payload_state(mst_state,
>> >>> connector->port));
>> >>>
>> >>>           if (DISPLAY_VER(dev_priv) >=3D 12)
>> >>> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c
>> >>> b/drivers/gpu/drm/nouveau/dispnv50/disp.c
>> >>> index 0c3d88ad0b0e..88728a0b2c25 100644
>> >>> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
>> >>> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
>> >>> @@ -915,7 +915,7 @@ nv50_msto_cleanup(struct drm_atomic_state *state,
>> >>>                   msto->disabled =3D false;
>> >>>                   drm_dp_remove_payload_part2(mgr, new_mst_state,
>> old_payload, new_payload);
>> >>>           } else if (msto->enabled) {
>> >>> -         drm_dp_add_payload_part2(mgr, state, new_payload);
>> >>> +         drm_dp_add_payload_part2(mgr, new_payload);
>> >>>                   msto->enabled =3D false;
>> >>>           }
>> >>>   }
>> >>> diff --git a/include/drm/display/drm_dp_mst_helper.h
>> >>> b/include/drm/display/drm_dp_mst_helper.h
>> >>> index 9b19d8bd520a..6c9145abc7e2 100644
>> >>> --- a/include/drm/display/drm_dp_mst_helper.h
>> >>> +++ b/include/drm/display/drm_dp_mst_helper.h
>> >>> @@ -851,7 +851,6 @@ int drm_dp_add_payload_part1(struct
>> drm_dp_mst_topology_mgr *mgr,
>> >>>                                struct drm_dp_mst_topology_state *mst=
_state,
>> >>>                                struct drm_dp_mst_atomic_payload *pay=
load);
>> >>>   int drm_dp_add_payload_part2(struct drm_dp_mst_topology_mgr *mgr,
>> >>> -                      struct drm_atomic_state *state,
>> >>>                                struct drm_dp_mst_atomic_payload *pay=
load);
>> >>>   void drm_dp_remove_payload_part1(struct drm_dp_mst_topology_mgr
>> *mgr,
>> >>>                                    struct drm_dp_mst_topology_state =
*mst_state,
>> >>
>> >>
>> >>
>> >
> ---
> Regards,
> Wayne Lin

--=20
Jani Nikula, Intel

