Return-Path: <stable+bounces-158822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD6FAEC78C
	for <lists+stable@lfdr.de>; Sat, 28 Jun 2025 16:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195131BC2B06
	for <lists+stable@lfdr.de>; Sat, 28 Jun 2025 14:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63974237176;
	Sat, 28 Jun 2025 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEurUrvG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D8519DF7D;
	Sat, 28 Jun 2025 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751119851; cv=none; b=HszJ5cOJVKmfb6mGpBX57CruhyeR/qZNo1EdontBx5fjgj9+R/OOvpWI6qQq2AuyHOA1QmYAUq046qi6mY/M1VZ7GjYtMCljzLBhe/mYKjMpqi9+pB2n0RJ8OZEEcx1mwsIQDIItv9488q9hH7Rl+XimlPjRc6FROT2QbXDQFuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751119851; c=relaxed/simple;
	bh=EWMvZHLXv+LObce0Zva7VFTJ1206LMiGsdfGpHgoDAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVe4vwRJRucA+tkl8h+XuKA/oLwZE2Ovg9zhZETPbTFbIUnIuyFicKxMURx6JUl48bixXel/3e+K0zAOG6wb2glVe3hV6SoPSFIr7PRaZ0PDVmsFvNgu8QPKHtGDJn7EExM3e3ykohkwN+nEgjv9jxs10aZQPXGlyXdSIHL9Q04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEurUrvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723B3C4CEEA;
	Sat, 28 Jun 2025 14:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751119850;
	bh=EWMvZHLXv+LObce0Zva7VFTJ1206LMiGsdfGpHgoDAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QEurUrvGDA1fqLjjseB29GipzaKxaq5h0UOIAvNWputpNBYGiMTdrJE9XhH2o0Gkr
	 Md2UmkS2sL7WdQ31d6ojACKaUv1Spxo+LshHJWFCGIh3irvVguvsd3Skqld6GfIdH1
	 rS62IeI0BkdXDFVRfCDNOAdQFhiKX/NPbWGmV2sMEsSFZ9TBGC46B2EtcvWRA7sdrs
	 ZX0XHXDbaLxPOoz25WgP1E9pPNhbE+MLvoIW0lz3c5pYOJHHO6LRa1a0Jpl1mKCiKD
	 eeuj+CLNO3Nq4xsleT1drh9dK2XAKEerop3LSy2GBK9GRFkzJRaI3DkzaQeZAyCYFy
	 iZMRj5VHmF11w==
Date: Sat, 28 Jun 2025 10:10:49 -0400
From: Sasha Levin <sashal@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	peng.fan@nxp.com, Srinivas Kandagatla <srini@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: Patch "ASoC: codec: wcd9335: Convert to GPIO descriptors" has
 been added to the 6.15-stable tree
Message-ID: <aF_36YgeZqJW1QLF@lappy>
References: <20250627140453.808884-1-sashal@kernel.org>
 <CAMRc=McpWPQx2f-7zR9AovKiA1B5BF5QiXHrPXVpT+Xu1uH7cQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McpWPQx2f-7zR9AovKiA1B5BF5QiXHrPXVpT+Xu1uH7cQ@mail.gmail.com>

On Fri, Jun 27, 2025 at 05:34:10PM +0200, Bartosz Golaszewski wrote:
>On Fri, Jun 27, 2025 at 4:04 PM Sasha Levin <sashal@kernel.org> wrote:
>>
>> This is a note to let you know that I've just added the patch titled
>>
>>     ASoC: codec: wcd9335: Convert to GPIO descriptors
>>
>> to the 6.15-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      asoc-codec-wcd9335-convert-to-gpio-descriptors.patch
>> and it can be found in the queue-6.15 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>>
>>
>
>Why is this being backported to stable? It's not a fix, just
>refactoring and updating to a more modern API.

You've cut out the rest of the message, which hase:

> Stable-dep-of: 9079db287fc3 ("ASoC: codecs: wcd9335: Fix missing free of regulator supplies")

-- 
Thanks,
Sasha

