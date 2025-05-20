Return-Path: <stable+bounces-145424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CBEABDB76
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7C3F7A8BE7
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBBD24E4C7;
	Tue, 20 May 2025 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daFOyNth"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87A024E4AA;
	Tue, 20 May 2025 14:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750136; cv=none; b=FEFt9YhW2VebgKDBO4KuhInoVydxg/zG0ZrhLozQDdO3UUfdfIaf0xX02jRojRYFktt91WJGTDgH/82zi8hwaP7bR9F3TfZKuI7/5dYoprGkn2TaTMe7hUMzbevJM8pOERSYQV2tQM3m6NEhpwDxcAN0syWH7jB8rtL4aYWCwmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750136; c=relaxed/simple;
	bh=Q0OPwZj9us2T448S+gJEHZdjESoDfxo2JnJDbTvezD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmTHAxgxyrqT0/KWaGujjZtyFPfnlZJ8KakMhCciNs4RwmU+cxHvpVjlOaHL2h6H1yji3qI0zftyJDsmHEJ5au2uTK3KovDAjP3poe32aiflhc2M+3LM0Y2jRlHxwDPyO43BHiXwq79uPqp+iSoIqWlQdTCLZmQ3tRb8wt6uBdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daFOyNth; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BA0C4CEE9;
	Tue, 20 May 2025 14:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747750136;
	bh=Q0OPwZj9us2T448S+gJEHZdjESoDfxo2JnJDbTvezD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=daFOyNthETvT9vI+3emdqpJ26Qku5+gPH6r4+hGDHJs9Ff3GphU0L0Usq8G9p0YSA
	 RI1VTFy+bTRvMsQXXMxFfFxmXXThIeVNX1hS42WyXljvAfckk47IkhpUm20hWQLeux
	 KJ+Tpib9pmpzBFbvlbbfts6dY+XKxQ5m8hSQiU4L1hkaspetywHD1cul4uUzPinPD9
	 Td+A/HqJnV9rjw4XTcFuzIbMz+i/C7nZNbRD5DJc+oV4mAxiXkeQdGVsBBWCHAXufg
	 8IDBBoYlm8VgggV9X6VPyYoNU88MBiQRTdEDD3ZgwlUw9SZAg08B21Mh9TZMgjJ8KY
	 LpY4jr3g0gDuQ==
Date: Tue, 20 May 2025 10:08:55 -0400
From: Sasha Levin <sashal@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, perex@perex.cz,
	tiwai@suse.com, lgirdwood@gmail.com, lumag@kernel.org,
	christianshewitt@gmail.com, kuninori.morimoto.gx@renesas.com,
	herve.codina@bootlin.com, jonas@kwiboo.se,
	krzysztof.kozlowski@linaro.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.14 601/642] ASoC: hdmi-codec: allow to refine
 formats actually supported
Message-ID: <aCyM9wXkc_FoLHm_@lappy>
References: <20250505221419.2672473-1-sashal@kernel.org>
 <20250505221419.2672473-601-sashal@kernel.org>
 <aBk_6Dh4twLESMv_@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aBk_6Dh4twLESMv_@finisterre.sirena.org.uk>

On Tue, May 06, 2025 at 07:47:04AM +0900, Mark Brown wrote:
>On Mon, May 05, 2025 at 06:13:37PM -0400, Sasha Levin wrote:
>> From: Olivier Moysan <olivier.moysan@foss.st.com>
>>
>> [ Upstream commit 038f79638e0676359e44c5db458d52994f9b5ac1 ]
>>
>> Currently the hdmi-codec driver registers all the formats that are
>> allowed on the I2S bus. Add i2s_formats field to codec data, to allow
>> the hdmi codec client to refine the list of the audio I2S formats
>> actually supported.
>
>This is clearly a new feature which won't do anything without further
>work in the drivers.

I'll drop it, thanks!

-- 
Thanks,
Sasha

