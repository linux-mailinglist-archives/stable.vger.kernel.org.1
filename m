Return-Path: <stable+bounces-66313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA11294DBDF
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 11:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECDD31C20FB9
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 09:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AA814D451;
	Sat, 10 Aug 2024 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fF282oPu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAA93C062;
	Sat, 10 Aug 2024 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723281241; cv=none; b=OWBXFznuWAsouEyQSUZdHdiB9fYNfwXNde0DMUGhthIKgbop7b299nL3PkF8ToZ4wdQ7lIsUiA3AEITZQnSCWY3zr8MhRNz/ABbJGMbt2/Ji4ViRlxzwVLbyF0i6SwDmn7PxAL99Gbyxyib9G2DvRCNIQD82GBMdlJmmvEYgado=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723281241; c=relaxed/simple;
	bh=Ob3FxBBXolQb8TSNkw7wVEqH25eTxoNzKRSeMRC4IGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xm1mnxkWfIovhiTuflOcEW0GG2wUUF9EFExGidyXzG3zGLVH7vn81VtuKZVqKcdrtU74cYnQcQS1PQ6ErIkjEkWdOM2bfGP2i4sJiAS1w17ivUCS7YnWmy8rxKfmnE2IDrXRhi5GPItOYsgWOFjY4+JPVw316Uu9Yh+3MGNY+UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fF282oPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFE7C32781;
	Sat, 10 Aug 2024 09:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723281240;
	bh=Ob3FxBBXolQb8TSNkw7wVEqH25eTxoNzKRSeMRC4IGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fF282oPuVU2f4UxhRPjzu/9f1ONAbASiPCu4oAe8mCQmU8Gx4pXdBWOe/aYOo1qws
	 YF0K8X4sHrU4apZP2pIFqxiHYa6ZC/ru+Y+lkDL5Z8obKKK6Tkzlt9MGx5l1tfj/dx
	 2EiTOh8yLri7akXpsQYnenlGykwtFSi/5+kq+ozNRTtcjETqqEaO7T8Y0jZrXMkUnh
	 g8cldeFUvPLYRyEHTGCYPiAqkBuLYbaBW6CmthVodzIK10dHjzFMxyxjWRYnH/P6f2
	 o2TkcMEaKIeqa1eLwWZgEk1kgv3ZNNCQm2Pg/1HwMylw5vkCtK8f5GBAFa3Sy3iA0L
	 wWESk/wCyuJVg==
Date: Sat, 10 Aug 2024 05:13:59 -0400
From: Sasha Levin <sashal@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>, cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
	ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
	perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10 02/11] ASoC: Intel: sof_sdw: Add quirks for
 some new Dell laptops
Message-ID: <ZrcvVz_5EQioiFft@sashalap>
References: <20240728160954.2054068-1-sashal@kernel.org>
 <20240728160954.2054068-2-sashal@kernel.org>
 <ZqdFCzqqkEWFl8tA@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZqdFCzqqkEWFl8tA@duo.ucw.cz>

On Mon, Jul 29, 2024 at 09:30:19AM +0200, Pavel Machek wrote:
>Hi!
>
>> From: Charles Keepax <ckeepax@opensource.cirrus.com>
>>
>> [ Upstream commit 91cdecaba791c74df6da0650e797fe1192cf2700 ]
>>
>> Add quirks for some new Dell laptops using Cirrus amplifiers in a bridge
>> configuration.
>
>This is queued for 5.10, but not for 6.1. Mistake?

Yup, needs to get dropped from everywhere. Thanks!

-- 
Thanks,
Sasha

