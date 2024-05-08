Return-Path: <stable+bounces-43453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AE68BFB9E
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 13:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9201C212C1
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 11:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08768004D;
	Wed,  8 May 2024 11:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="R3k9r36z"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776D576037;
	Wed,  8 May 2024 11:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166817; cv=none; b=IdKgPhUwgV4LunYajex486fVNP20FjIdls30pfMvziuNv4QOA+l6nevaFk7NtTQm9zXlWJq5TFrC/6WuBL4hXWYtqZRwtzimy+mZo191bHpRy42bpo8Jr5kNAwogefpRS9jkXT2j+q8UQ4YcAa/h4aBI1Tp3MSxvr8JQByR++A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166817; c=relaxed/simple;
	bh=OuiqwbZPjN3DNJB+dDIo/XIoTJXPo3AYywLSJjHomEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KBPtZzeNcHNEUq/CwGG+hqltx0dVHjyZykvLmlxgYnLP7tlOQtSbHoytrxy8SzUCDfhlbicqj673T397l/oi0OkDA/8AXYGS6K3CMKTvILU7lFgG1sXp1ThGJdxYPOeMyAQjplf7CWJL7IXz7Bz+2psEUixTLWMLRO5VvYe6XSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=R3k9r36z; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=C+BWt6OtGLjf0YezjsYLhfFKgUBVhzHo6N0s8x1PpTM=;
	t=1715166815; x=1715598815; b=R3k9r36zBDhru9H0z1QyAmUUvNPC7GMtfL6SaQ3h5Fj3L8E
	f3arBk71J+NJOpDykkZNd1n/a80UfDrMp/vm9e1ok+NGhrqE1atIaM/svV1tNIY+cXZ1ciwzp7U5e
	hPND9Yes8lpbv0mOgnxDZftyGZqJrmSzArymWlckxcKqCdM1C+hMBAVKC0O1ew62LcPVtLzpIfC4Z
	PZqNudp5bByS0muP2PU+JrXR86W6qCA4P/EvcGQEBG2aLHudBGP7K3YnuLn3Skiv+dTvJvH0NDWlD
	kLfy7kzyW+GUj3q2cmOoSJyG+a2tc3MUTt4le/Ms9/F3A0brvoxmiqYAzHmGDdLQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s4fEr-0008DV-8N; Wed, 08 May 2024 13:13:33 +0200
Message-ID: <38928145-8765-4213-b2a7-b81ff3cebb16@leemhuis.info>
Date: Wed, 8 May 2024 13:13:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bisected]: Games crash with 6.9rc-5+/6.8.9+/6.6.30+
To: Christian Heusel <christian@heusel.eu>, regressions@lists.linux.dev
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>, heftig@archlinux.org
References: <gifkxwcrswqevdig33inrsieahso2lcxbhcawu6d2qprnujoij@eqg53vwjamts>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <gifkxwcrswqevdig33inrsieahso2lcxbhcawu6d2qprnujoij@eqg53vwjamts>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1715166815;08aeb795;
X-HE-SMSGID: 1s4fEr-0008DV-8N

On 08.05.24 12:36, Christian Heusel wrote:
> 
> I am reporting this to the regressions mailing list since it has popped
> up in the [Arch Linux Bugtracker][0]. It was also [already reported][1]
> to the relevant DRM subsystem, but is not tracked here yet.

Thx for that!

> The issue has been bisected to the following commit by someone on
> Gitlab:
> 
>     a6ff969fe9cb ("drm/amdgpu: fix visible VRAM handling during faults")
>
> The DRM maintainers have said that this could be something that just
> worked by chance in the past:

Well, that "worked by chance" itself it not much relevant when it comes
to the "no regressions" rule: in such a case the culprit is normally
reverted if the issue can't be fixed in some other way.

That being said:

> [Comment 1][2]
>> Christian König (@ckoenig)
>> Mhm, no idea of hand. But it could be that this is actually an
>> intended result.
>>
>> Previously we didn't correctly checked if the requirements of an
>> application regarding CPU accessible VRAM were meet. Now we return an
>> error if things potentially won't work instead of crashing later on.
>>
>> Can you provide the output of 'sudo cat
>> /sys/kernel/debug/dri/0/amdgpu_vram_mm' just before running the game?
> 
> [Comment 2][3]
>> Damian Marcin Szymański (@AngryPenguinPL):
>> @superm1 @ckoenig If you can't fix it before stable 6.9 can we get it
>> reverted for now?
>>
>> Christian König (@ckoenig):
>> @AngryPenguinPL no, this is an important bug fix which even needs to
>> be backported to older kernels.

This sounds like it reverting might be a really bad idea for security
reasons. Christian, is that right?

In that case it's likely something we should simply tell Linus about, as
he's the one doing the judgement calls here -- and also the one that
maybe should mention this problem in the next release announcement, if
the commit remains.

Ciao, Thorsten

> All in all this seems to be a rather tricky situation (especially
> judging if this is actually a regression or not), so maybe getting some
> input from the stable or regression team on how to handle this well
> would be good!
> 
> (I'll add that I can give no direct input on the issue itself, see this
> as a forward / cc type of Email.)
> 
> Cheers,
> Chris
> 
> [0]: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/47
> [1]: https://gitlab.freedesktop.org/drm/amd/-/issues/3343
> [2]: https://gitlab.freedesktop.org/drm/amd/-/issues/3343#note_2389471
> [3]: https://gitlab.freedesktop.org/drm/amd/-/issues/3343#note_2400933
> 
> #regzbot introduced: a6ff969fe9cb
> #regzbot link: https://gitlab.freedesktop.org/drm/amd/-/issues/3343
> #regzbot title: drm/amdgpu: Games crash if above 4g decoding/resize bar is disabled or not supported

