Return-Path: <stable+bounces-163436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A12B0B11F
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 19:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62783BFBC2
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 17:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68368286D7A;
	Sat, 19 Jul 2025 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdvb+jAb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245C814F70;
	Sat, 19 Jul 2025 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752946788; cv=none; b=mQDPm4YyM7yl2L84oV54Q6vuJsYP3nd5MeWntuSYVaVeNWjkDw/eW63oLCRi0MmVHSa645NbNnnYHKDoQdb8QnZYa5TKpPZf9mIyNqJMuUf8MG8qiANKmjNH1VUDJIbb9qR/2j4oYEcmJGF7hJV7VSzm4OPM+T1UxQSajcg2fUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752946788; c=relaxed/simple;
	bh=7/NdWaVru2bXgWxe3grex5sXv09jXLsi35lKwOHFWh0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=da7GuItPEy5Uj+spqEgH66S7K78qcM4V5mgCW+zTradUzqv9/h1ORXwp4wEytX27E0A/q+cONPBXOXWZ9+/ukfx+VwH0KX25xd3iCRib1RyFGMaxtbUJC5/QxD2GLlHtwIJHiQ4Oo1orMgWkAJi7i2j3AcJm3LcZreLIYjJZ0SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdvb+jAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EA6C4CEE3;
	Sat, 19 Jul 2025 17:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752946787;
	bh=7/NdWaVru2bXgWxe3grex5sXv09jXLsi35lKwOHFWh0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=tdvb+jAbXtaH2Ug6CLe4ggGjF5CN42xkvX+zRWi3CMxsuwuy+q8zbaRqvAWsSxUpy
	 rucGUWrniij4QDyNKZ+U3dzBI5WBWr+GuywfXOlyky7OUZ73vJoHsYhtlEovMlzv7i
	 fLYU4/5W1Lb2q9N/p/BtdgyLC57/5Np8VTDdIA+7GQv+ekzpi9/m71vrAIyPuZed21
	 lqDbCi0SU/sdP8zsEzD7wAt2fZYGP1d1XKkBSrcLqbAG93KvoWVrFruMNZ3lHAUtld
	 kRmCOY+k2dB4xfMl33iF7o4/FKSrp/E4yCx6p0/Ryi6P3c2NsVrDzwPr7JX7VAvZgU
	 JxXELil88LiSw==
Message-ID: <cc7a41dc-066a-41c8-a271-7e4c92088d65@kernel.org>
Date: Sat, 19 Jul 2025 12:39:45 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] drm/amd/display: backlight brightness set to 0 at
 amdgpu initialization
From: Mario Limonciello <superm1@kernel.org>
To: Lauri Tirkkonen <lauri@hacktheplanet.fi>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Wayne Lin <wayne.lin@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <aHn33vgj8bM4s073@hacktheplanet.fi>
 <d92458bf-fc2b-47bf-b664-9609a3978646@kernel.org>
 <aHpb4ZTZ5FoOBUrZ@hacktheplanet.fi>
 <46de4f2a-8836-42cd-a621-ae3e782bf253@kernel.org>
 <aHru-sP7S2ufH7Im@hacktheplanet.fi>
 <664c5661-0fa8-41db-b55d-7f1f58e40142@kernel.org>
 <aHr--GxhKNj023fg@hacktheplanet.fi>
 <f12cfe85-3597-4cf7-9236-3e00f16c3c38@kernel.org>
Content-Language: en-US
In-Reply-To: <f12cfe85-3597-4cf7-9236-3e00f16c3c38@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/19/25 10:25 AM, Mario Limonciello wrote:
> 
> 
> On 7/18/25 9:12 PM, Lauri Tirkkonen wrote:
>> On Fri, Jul 18 2025 20:14:08 -0500, Mario Limonciello wrote:
>>> OK, I think we need to do two things to figure out what's going on.
>>>
>>> 1) Let's shift over to 6.16-rc6.  Once we've got a handle on the 
>>> situation
>>> there we can iron out if there are other patches missing or this is also
>>> broken for you in 6.16.  If it's not working as expected there either we
>>> need it fixed there first anyway.
>>
>> Same behavior on 6.16-rc6: brightness is set to 0 (max 399000),
>> minimally visible.
>>
>>> 2) The starting brightness I don't expect to be "0".  We need to see 
>>> what
>>> values were read out from the firmware. There is a debugging message 
>>> we can
>>> catch if you boot with drm.debug=0x106.  Keep in mind you probably 
>>> need to
>>> increase log_buf_len if your ring buffer is set too small too.
>>>
>>> https://github.com/torvalds/linux/ 
>>> commit/4b61b8a390511a1864f26cc42bab72881e93468d
>>>
>>> PS: I would rather you add logs into a gist, pastebin or a bug 
>>> somewhere if
>>> you can.
>>
>> [    3.210757] amdgpu 0000:03:00.0: 
>> [drm:amdgpu_dm_connector_late_register [amdgpu]] Backlight caps: min: 
>> 1000, max: 400000, ac 100, dc 32
>>
>> full dmesg: https://termbin.com/o2q3
>>
> 
> Thanks for sharing.  Can you get me an updated output with 
> drm.debug=0x106 set and with this applied?  I want to see what values 
> were set.
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/ 
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 5df7f8c34231..cdc43cfb39dd 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10489,8 +10489,12 @@ static void amdgpu_dm_atomic_commit_tail(struct 
> drm_atomic_state *state)
>          /* restore the backlight level */
>          for (i = 0; i < dm->num_of_edps; i++) {
>                  if (dm->backlight_dev[i] &&
> -                   (dm->actual_brightness[i] != dm->brightness[i]))
> +                   (dm->actual_brightness[i] != dm->brightness[i])) {
> +                       drm_WARN(adev_to_drm(adev), true,
> +                                       "Backlight level %d does not 
> match actual brightness %d for edp %d\n",
> +                                       dm->brightness[i], dm- 
>  >actual_brightness[i], i);
>                          amdgpu_dm_backlight_set_level(dm, i, dm- 
>  >brightness[i]);
> +                   }
>          }
> 
>          /*
> 
> Also, does turning off custom brightness curves 
> (amdgpu.dcdebugmask=0x40000) help?
> 

In advance of getting that updated log; I have a theory what's going on. 
  I think the first value programmed to brightness happens as part of 
that very first modeset.

If that's what's going on, then I think doing an explicit programming 
cycle at the backlight registration will help.  Here's a potential patch.

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b19e7964060d..4b99efbaf481 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4996,6 +4996,8 @@ amdgpu_dm_register_backlight_device(struct 
amdgpu_dm_connector *aconnector)
                 dm->backlight_dev[aconnector->bl_idx] = NULL;
         } else
                 drm_dbg_driver(drm, "DM: Registered Backlight device: 
%s\n", bl_name);
+
+ 
amdgpu_dm_backlight_update_status(dm->backlight_dev[aconnector->bl_idx]);
  }

  static int initialize_plane(struct amdgpu_display_manager *dm,

