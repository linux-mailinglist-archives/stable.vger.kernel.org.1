Return-Path: <stable+bounces-28111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DC087B653
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 03:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1804B22733
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 02:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18B11C06;
	Thu, 14 Mar 2024 02:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7NBJ+B6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900FB4439
	for <stable@vger.kernel.org>; Thu, 14 Mar 2024 02:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710382335; cv=none; b=pmx5UIGXVNaNeaQ7sJ6A51EDr9u/ZRmzA5qjOfbYuueU1Fz7y8kLOIU2Six7b6ZL9WFrs1H925SxGkxy+HPb4QlIqZTkNLyPhx/juHWNXpLH8JO1Fl+h9pL9DvS76t9DMCm51j2K9J6jtfArxrZCpx0cvfjlZy292LyH6XBmovo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710382335; c=relaxed/simple;
	bh=/Ge76hT16SrhHpmRVb8jxTxyEzZV1N8JWqiAU1vNuzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6ggV9QAaPiNck4xuPD9XuL2Er4V7ZPQygN/fwFlHJFvNFOO/B08G3n+fliUqFtAoYFx0E/7McNNjp4Zj5rJBF5wbUiA8Ky8ju8ZUkFEBGKJP8lOhHqy1Udi3ZOtZKM42Ukp7vHagO9Jl2x8t9S/4orFurkO88KKSCTIk1kyhlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7NBJ+B6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E314DC433C7;
	Thu, 14 Mar 2024 02:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710382335;
	bh=/Ge76hT16SrhHpmRVb8jxTxyEzZV1N8JWqiAU1vNuzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l7NBJ+B6W5bXraXVTW0x1w9mGD1BystQXHAESICWi49HT1PmT+msEpZAczBF8jjGZ
	 rAKqjHUOTM1XmnOw6EDKSAYDF6UBzUiDJoJ7wShNMaa1Pyb9rLbqQzG/hkuyF5qsXV
	 HvNDZyj5VZaRA+GqgTqGFEaRrAOXut+4JXTFyYLyRe9l1Eb2T+OVi8insQftKKWeAh
	 hlzYEYKd6RqSdp1U/E/4nujwSqyOK7OyLBxeJg5yEAUBW96KqVwhdbfmgjrtXSfbrL
	 VGd8OLwpu14M5eD04SiEM/uhu9QI3Woy6kU8Kiys6ai7s2ex4fjp7i+L4GjhJc0d2r
	 ZwRr9vy7SB3+w==
Date: Wed, 13 Mar 2024 22:12:13 -0400
From: Sasha Levin <sashal@kernel.org>
To: Richard Narron <richard@aaazen.com>
Cc: stable <stable@vger.kernel.org>
Subject: Re: [PATCH 5.15 00/76] 5.15.152-rc1 review
Message-ID: <ZfJc_ZDWdTD8UjNC@sashalap>
References: <7f21928-bc75-adac-7260-d2b0cc8dd3fe@aaazen.com>
 <ZfIKCLek_q-Wzn0D@sashalap>
 <762cfca9-45b8-752b-3fe8-f59bca716578@aaazen.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <762cfca9-45b8-752b-3fe8-f59bca716578@aaazen.com>

On Wed, Mar 13, 2024 at 03:27:33PM -0700, Richard Narron wrote:
>On Wed, 13 Mar 2024, Sasha Levin wrote:
>
>> For some reason the v5.15.151 release tag wasn't pushed.
>>
>> I've pushed it now, so the link above should start working whenever the
>> git.kernel.org caches expire. I'll check back in an hour.
>
>Thanks Sasha,
>
>   This new kernel 5.15.152-rc1 compiles and runs fine on my x86_64
>AMD zen 3 system.

Thanks for the report, and the link is also working now :)

-- 
Thanks,
Sasha

