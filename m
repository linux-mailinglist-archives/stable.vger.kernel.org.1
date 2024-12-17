Return-Path: <stable+bounces-105051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1AE9F56BC
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 20:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 957B4166111
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 19:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3831F7579;
	Tue, 17 Dec 2024 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TK4o7ZJB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC021629;
	Tue, 17 Dec 2024 19:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734462945; cv=none; b=bZwTWnI8TNN2G9JFQ+5cWJNg3vPAAokHuzAQh0eE/u0de9T7F7MDp61eIJ8TKDXzLFmg+abmbG04AzIhk58CwGzJ6gVz4vOTZ2WLZ5OoHpiUiM57qSgaXUj0CNyz9iHeCfh+/UXwL9MJsvOtkMsnmgAtOgAl0FfN9ekswN3QG4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734462945; c=relaxed/simple;
	bh=y6GS3u5mmSve1hLodFE193rtDZ23mXknM3YOmd/lX5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXXnKGrtxSgNBwhw2E93HhZU1iFb+nHahViO98IF7eOzEr0bsrE0eLVRaNeyFQOUFRw3jNlKXDAElnAZgtJuA3boJAHYJ31HUp/8NuGhrq/HUQCL83M4qaEq1nphpqvWcvI81hl8HVQw0G9AcTkdbGqmRHVSsUFICc6oOrFdTrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TK4o7ZJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2584CC4CED3;
	Tue, 17 Dec 2024 19:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734462945;
	bh=y6GS3u5mmSve1hLodFE193rtDZ23mXknM3YOmd/lX5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TK4o7ZJB2prkyLYo4lGmtQgi3V+IW/eRubKTjoPLrWg/402gLT5kvIYvCpmv8J3Ev
	 9xomSIyS1aoZsvaZLT1ijz4Z9CzVfcKOLowt3lUyFndg2fSOiBkD68CmuMHZrIS1Cw
	 xRucypAM2Fgti4i7fBHAEzNZALOcDLnsdQFpkD/7S4WbFzhB6mpwRPJKa00Gt/lkkb
	 20N9AUcnflkbHUF4zA86Lj14DWNEDwtrGXs23rbOM9Z6YtAj/1FNred4gXNnULHA8B
	 XJMwO3X7lVKNZd7GjTD59kIpVn0dd7RWZSRWFAYH/NxDeHiOx7lAoFioFXpUe+sh+e
	 Yhgci1i/FhMFw==
Date: Tue, 17 Dec 2024 14:15:43 -0500
From: Sasha Levin <sashal@kernel.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	syzbot+78d5b129a762182225aa@syzkaller.appspotmail.com,
	perex@perex.cz, tiwai@suse.com, kl@kl.wtf,
	peter.ujfalusi@linux.intel.com, xristos.thes@gmail.com,
	linux-sound@vger.kernel.org,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH AUTOSEL 5.15 13/13] ALSA: usb: Fix UBSAN warning in
 parse_audio_unit()
Message-ID: <Z2HN39E2yUoqtCGh@lappy>
References: <20240728160907.2053634-1-sashal@kernel.org>
 <20240728160907.2053634-13-sashal@kernel.org>
 <92eb4af2-8a38-4075-9353-21afe34d57d9@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <92eb4af2-8a38-4075-9353-21afe34d57d9@oracle.com>

On Tue, Dec 17, 2024 at 11:54:49AM +0530, Harshit Mogalapalli wrote:
>Hi Sasha,
>
>On 28/07/24 21:38, Sasha Levin wrote:
>>From: Takashi Iwai <tiwai@suse.de>
>>
>>[ Upstream commit 2f38cf730caedaeacdefb7ff35b0a3c1168117f9 ]
>>
>>A malformed USB descriptor may pass the lengthy mixer description with
>>a lot of channels, and this may overflow the 32bit integer shift
>>size, as caught by syzbot UBSAN test.  Although this won't cause any
>>real trouble, it's better to address.
>>
>>This patch introduces a sanity check of the number of channels to bail
>>out the parsing when too many channels are found.
>>
>>Reported-by: syzbot+78d5b129a762182225aa@syzkaller.appspotmail.com
>>Closes: https://lore.kernel.org/0000000000000adac5061d3c7355@google.com
>>Link: https://patch.msgid.link/20240715123619.26612-1-tiwai@suse.de
>>Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>FYI: This 13 patch series and similar AUTOSEL sets for other stable 
>kernels didn't go into stable yet.

Huh, thanks for that.

I've tried to look at the history, and I'm quite confused about what's
happening. My scripts must have gone rogue at some point.

-- 
Thanks,
Sasha

