Return-Path: <stable+bounces-163455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4F2B0B497
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 11:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B385717BEFD
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 09:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4E4195B37;
	Sun, 20 Jul 2025 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b="YeiRoC5A";
	dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b="mGGitpLg"
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594BE7E110
	for <stable@vger.kernel.org>; Sun, 20 Jul 2025 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753004108; cv=none; b=dSam25yQCjty1ecqqFQlg//7DEUUShnGBDI0HRgylDtrJ8wyzEmEoD7Wm08f2xtTkSoVjVTWc+llV7/W18ooJDRl8CUVZsnQNfzilF+T/2zc/B7GMNHdBuoDjH5UrsMPQLyRtOeNvE2uCXW31wemVHK4qapPHits9gIRi2lNnnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753004108; c=relaxed/simple;
	bh=c6xLT7R4rsPrcZoIIXPvKmVYK+4perYCo/WWrcY3+H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoljeP0vcGho5gWzr3MJtBWpVH0r2vJOq6QjcHNKdcrecbgjj31wnAJtcL5FfZs/KOCeJMlP81mNR6zBfcqZjSxj86nr+QJ2apLX0vx8ofmkd7dFWDkznfU8iifG5FU/A2fcEEAp0IWmTdjp9md/iKr+FZpIuXo5LiSPJJdGiqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hacktheplanet.fi; spf=pass smtp.mailfrom=hacktheplanet.fi; dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b=YeiRoC5A; dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b=mGGitpLg; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hacktheplanet.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hacktheplanet.fi
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=gibson; bh=c6xLT7R4rsPrc
	ZoIIXPvKmVYK+4perYCo/WWrcY3+H8=; h=in-reply-to:references:subject:cc:
	to:from:date; d=hacktheplanet.fi; b=YeiRoC5Aqj4UkkdNbZyb6sXT/F6KQ+wqRL
	otau/GYjH8fD9pvDfwmEvtwJrjHiKTzAyHOhElCTYvtzSlovQn+PlKYAYS5B2298BumJip
	Mzex9m1PL+GMIsynAHVwiyid4K4oGjN2iwL8nvksXG9y6NSgnjbtqyiMkC6F2XtlV18/un
	Y9Zse3+h2ycny7P68tygZ88Fqx5cx9sbtnd4vQXw6WL30/CjhW2aWTcToxWzE6EzbHjVBz
	HCJhIUo4sN4bvBpR/9uI08nSeDG87mCHtnVldqSCUy2FAfe8tlbhwigl/Jn32warU6ReKF
	5gf4cmumh/8pzDXnIggAwrviy/JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hacktheplanet.fi;
	s=key1; t=1753004100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WuGfig2RuolkoRHs6+n/AApMMpUjfPdDzkJW9yTyPJM=;
	b=mGGitpLg4MMvtETi8+65DMmcDXb0Aj5ya/nj3u+oeI3RhNiNX8S+si8C/a3YQDrGx6q1FA
	Idhd2mKJ8jMMDmCUtUgA+DJXCjwOC6opzp5X7pwAoQQX4RRuNNRNgTpoxPUgeQynF2ibon
	M5bpsOUW2DD+K4Z5Ic7qfmfr4Kyg5G968ygo2cF67kycyB8or7tN6s0zLr65y8Ob0JPm0v
	62lfmCcNJk4yyAgPuto25VJdYvNPtYJFeElsVdXhrpibCKmTC+syHv2/Gvx6YA9pbBP5ga
	PI4UpAhqtKSBInDEL6P+XlwFFppH/OaQulP9OyGB0jfj9ydJBeMXXY2GrZGXkQ==
Date: Sun, 20 Jul 2025 18:34:50 +0900
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lauri Tirkkonen <lauri@hacktheplanet.fi>
To: Mario Limonciello <superm1@kernel.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
	amd-gfx@lists.freedesktop.org, Wayne Lin <wayne.lin@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [REGRESSION] drm/amd/display: backlight brightness set to 0 at
 amdgpu initialization
Message-ID: <aHy4Ols-BZ3_UgQQ@hacktheplanet.fi>
References: <aHn33vgj8bM4s073@hacktheplanet.fi>
 <d92458bf-fc2b-47bf-b664-9609a3978646@kernel.org>
 <aHpb4ZTZ5FoOBUrZ@hacktheplanet.fi>
 <46de4f2a-8836-42cd-a621-ae3e782bf253@kernel.org>
 <aHru-sP7S2ufH7Im@hacktheplanet.fi>
 <664c5661-0fa8-41db-b55d-7f1f58e40142@kernel.org>
 <aHr--GxhKNj023fg@hacktheplanet.fi>
 <f12cfe85-3597-4cf7-9236-3e00f16c3c38@kernel.org>
 <cc7a41dc-066a-41c8-a271-7e4c92088d65@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc7a41dc-066a-41c8-a271-7e4c92088d65@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Sat, Jul 19 2025 12:39:45 -0500, Mario Limonciello wrote:
> On 7/19/25 10:25 AM, Mario Limonciello wrote:
> > 
> > 
> > On 7/18/25 9:12 PM, Lauri Tirkkonen wrote:
> > > On Fri, Jul 18 2025 20:14:08 -0500, Mario Limonciello wrote:
> > > > OK, I think we need to do two things to figure out what's going on.
> > > > 
> > > > 1) Let's shift over to 6.16-rc6.  Once we've got a handle on the
> > > > situation
> > > > there we can iron out if there are other patches missing or this is also
> > > > broken for you in 6.16.  If it's not working as expected there either we
> > > > need it fixed there first anyway.
> > > 
> > > Same behavior on 6.16-rc6: brightness is set to 0 (max 399000),
> > > minimally visible.
> > > 
> > > > 2) The starting brightness I don't expect to be "0".  We need to
> > > > see what
> > > > values were read out from the firmware. There is a debugging
> > > > message we can
> > > > catch if you boot with drm.debug=0x106.  Keep in mind you
> > > > probably need to
> > > > increase log_buf_len if your ring buffer is set too small too.
> > > > 
> > > > https://github.com/torvalds/linux/
> > > > commit/4b61b8a390511a1864f26cc42bab72881e93468d
> > > > 
> > > > PS: I would rather you add logs into a gist, pastebin or a bug
> > > > somewhere if
> > > > you can.
> > > 
> > > [    3.210757] amdgpu 0000:03:00.0:
> > > [drm:amdgpu_dm_connector_late_register [amdgpu]] Backlight caps:
> > > min: 1000, max: 400000, ac 100, dc 32
> > > 
> > > full dmesg: https://termbin.com/o2q3
> > > 
> > 
> > Thanks for sharing.  Can you get me an updated output with
> > drm.debug=0x106 set and with this applied?  I want to see what values
> > were set.
> > 
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/
> > drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 5df7f8c34231..cdc43cfb39dd 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -10489,8 +10489,12 @@ static void amdgpu_dm_atomic_commit_tail(struct
> > drm_atomic_state *state)
> >          /* restore the backlight level */
> >          for (i = 0; i < dm->num_of_edps; i++) {
> >                  if (dm->backlight_dev[i] &&
> > -                   (dm->actual_brightness[i] != dm->brightness[i]))
> > +                   (dm->actual_brightness[i] != dm->brightness[i])) {
> > +                       drm_WARN(adev_to_drm(adev), true,
> > +                                       "Backlight level %d does not
> > match actual brightness %d for edp %d\n",
> > +                                       dm->brightness[i], dm-
> > >actual_brightness[i], i);
> >                          amdgpu_dm_backlight_set_level(dm, i, dm-
> > >brightness[i]);
> > +                   }
> >          }
> > 
> >          /*
> > 
> > Also, does turning off custom brightness curves
> > (amdgpu.dcdebugmask=0x40000) help?
> > 
> 
> In advance of getting that updated log; I have a theory what's going on.  I
> think the first value programmed to brightness happens as part of that very
> first modeset.
> 
> If that's what's going on, then I think doing an explicit programming cycle
> at the backlight registration will help.  Here's a potential patch.
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b19e7964060d..4b99efbaf481 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4996,6 +4996,8 @@ amdgpu_dm_register_backlight_device(struct
> amdgpu_dm_connector *aconnector)
>                 dm->backlight_dev[aconnector->bl_idx] = NULL;
>         } else
>                 drm_dbg_driver(drm, "DM: Registered Backlight device: %s\n",
> bl_name);
> +
> + amdgpu_dm_backlight_update_status(dm->backlight_dev[aconnector->bl_idx]);
>  }
> 
>  static int initialize_plane(struct amdgpu_display_manager *dm,

This patch was malformed, so I applied it manually. It didn't help
though - brightness still zero.

I came up with a patch that does help; will post in this thread shortly.

-- 
Lauri Tirkkonen | lotheac @ IRCnet

