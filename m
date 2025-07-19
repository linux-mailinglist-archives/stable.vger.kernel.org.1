Return-Path: <stable+bounces-163435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE0FB0B09C
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 17:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77A777AA1B4
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 15:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136202874EA;
	Sat, 19 Jul 2025 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPEzXFW7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95D54438B;
	Sat, 19 Jul 2025 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752938732; cv=none; b=AHFGhYbr27Xo8BSFe2fRxGE64a6zkJbTIka2m9juFutjTl7gGEciP/HtfjwsplVhMwjoyaIzI1WwxDW+3ByBfI4oGvyLMiqbUrkAUdonapohgvyL5FzZGs0kZw6uxGFyf0Uwsbt3jwRTSct+34cIspU2sl78IStxXKeitimrv00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752938732; c=relaxed/simple;
	bh=htuXBkCrt9vdNauDywfgm48jqQyzMM8JL90JusDBtKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/vJUkhAlA9n+SHhkntoIfyf3d/ccq8DoJjxM54YFE0OByaTkyWsV4c+g4gyV0ljjaEpimPXkGicGfEKbM9406kqF9xK3qnuWdEhYQicV2HbmwhmXwYvtr4SOjFxHaFyQIvs821xQdV1tdOu6n0BGBVqW9JIXAyju9fkE0/X/as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPEzXFW7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917B3C4CEE3;
	Sat, 19 Jul 2025 15:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752938732;
	bh=htuXBkCrt9vdNauDywfgm48jqQyzMM8JL90JusDBtKo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cPEzXFW78OpbPU5VotFza9DL9AjQOL16KxsPrPwaP+9lczUyWnDSUDpZve1UK9DAe
	 JLDZQmN56o0W0BzZMOlR9WIB5z75bagsKFmQk+NoRplTKuQk85bFWoK39iWB5WkMJy
	 TTYqx/YrAs1evZGyNlQlGcG4YPzunXnrBFK1+3Y+Xdby+H+0DYU6BgWcUIga9mV1F3
	 hGKms0NEzxP0OoQ5KZjfDfTp0KezEIQNsAQo5foLmfIYAZT1zYUxIS65bg/YkQkglV
	 jjkz6vdC0+KGJjhrO7s2LWvXDuGy8+ENNTD3zf6gYICOxRYyg/UqkgH+uW+V1UhxLi
	 R8lGxH2eIElRw==
Message-ID: <f12cfe85-3597-4cf7-9236-3e00f16c3c38@kernel.org>
Date: Sat, 19 Jul 2025 10:25:27 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] drm/amd/display: backlight brightness set to 0 at
 amdgpu initialization
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
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <aHr--GxhKNj023fg@hacktheplanet.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/18/25 9:12 PM, Lauri Tirkkonen wrote:
> On Fri, Jul 18 2025 20:14:08 -0500, Mario Limonciello wrote:
>> OK, I think we need to do two things to figure out what's going on.
>>
>> 1) Let's shift over to 6.16-rc6.  Once we've got a handle on the situation
>> there we can iron out if there are other patches missing or this is also
>> broken for you in 6.16.  If it's not working as expected there either we
>> need it fixed there first anyway.
> 
> Same behavior on 6.16-rc6: brightness is set to 0 (max 399000),
> minimally visible.
> 
>> 2) The starting brightness I don't expect to be "0".  We need to see what
>> values were read out from the firmware. There is a debugging message we can
>> catch if you boot with drm.debug=0x106.  Keep in mind you probably need to
>> increase log_buf_len if your ring buffer is set too small too.
>>
>> https://github.com/torvalds/linux/commit/4b61b8a390511a1864f26cc42bab72881e93468d
>>
>> PS: I would rather you add logs into a gist, pastebin or a bug somewhere if
>> you can.
> 
> [    3.210757] amdgpu 0000:03:00.0: [drm:amdgpu_dm_connector_late_register [amdgpu]] Backlight caps: min: 1000, max: 400000, ac 100, dc 32
> 
> full dmesg: https://termbin.com/o2q3
> 

Thanks for sharing.  Can you get me an updated output with 
drm.debug=0x106 set and with this applied?  I want to see what values 
were set.

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5df7f8c34231..cdc43cfb39dd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10489,8 +10489,12 @@ static void amdgpu_dm_atomic_commit_tail(struct 
drm_atomic_state *state)
         /* restore the backlight level */
         for (i = 0; i < dm->num_of_edps; i++) {
                 if (dm->backlight_dev[i] &&
-                   (dm->actual_brightness[i] != dm->brightness[i]))
+                   (dm->actual_brightness[i] != dm->brightness[i])) {
+                       drm_WARN(adev_to_drm(adev), true,
+                                       "Backlight level %d does not 
match actual brightness %d for edp %d\n",
+                                       dm->brightness[i], 
dm->actual_brightness[i], i);
                         amdgpu_dm_backlight_set_level(dm, i, 
dm->brightness[i]);
+                   }
         }

         /*

Also, does turning off custom brightness curves 
(amdgpu.dcdebugmask=0x40000) help?


