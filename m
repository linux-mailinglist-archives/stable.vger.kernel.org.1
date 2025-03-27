Return-Path: <stable+bounces-126884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF87A7372C
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 17:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FCE4188C911
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 16:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BC71B043C;
	Thu, 27 Mar 2025 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKzFd5Q1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6301A00D1;
	Thu, 27 Mar 2025 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743093753; cv=none; b=tXZRHtA93wC0mjovTAaIXTaKypQmJsPjvBw90c4C9/UpR9mkQvN5wEDluyzNwPLM58NTG7XUrAFBt7tEP8/LnkFV5kyDVMV2SznV1R4/pcSBXJHvYMTa+HXzvURlVWyJmMEY1ObL7R9VzHcOc8ym9K662rhdifp7Iq1AxUAmLfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743093753; c=relaxed/simple;
	bh=QyH77tECH3lylpaKyou3K7E3snQSAJIhR+N1IUAgi74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fhk82+sqdwCfgcc9QDtwT4IlEtlN1XKMcNPp48ygD2QFnL9JjmtCPLHVwQzyb7h49UzTkIgJcRiHcFKW1ad+VaPnVhFKmnfnC8ivGUNgEair0buqs44jkFJQWKH8Z/Qrk0R4M0gDWBwiwN16jm4306FEzxUQZX0aj5UWmwsGjIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKzFd5Q1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A43C4CEDD;
	Thu, 27 Mar 2025 16:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743093752;
	bh=QyH77tECH3lylpaKyou3K7E3snQSAJIhR+N1IUAgi74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eKzFd5Q1gv6S4vMmsJlrOy8tVOkL3QoYdYVyoWXZHR8rCdqsBWNeeoThrTDPKrGJ/
	 P5hUtgsIfH7HMHZ+nIjVS7TmPSu5MyENL7uXNuY+3bENEclSCwoovuR8sw2LLD3yGM
	 ZSspOavMRFSBPPiIk6/tb+EiVNiSSwGhkxX2GSMMVuf2mBqebTQ0HUCCVcEp5pGKDl
	 en0jKCEWsM3Iier9NbtVzy6sk32xNuDkMe25Edq32hyl8M7ZfZY4O//VjuRCr7SkBB
	 98Hoxh9L5YNeAyyvTewGFzzuPyxUmYEAnW8R5XjRlmQ9hMh6WALQYW0Ny0k4GYZ/xL
	 LPt97A7IHKojA==
Date: Thu, 27 Mar 2025 09:42:31 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>,
	stable@vger.kernel.org, David Binderman <dcb314@hotmail.com>
Subject: Re: [PATCH] arm/crc-t10dif: fix use of out-of-scope array in
 crc_t10dif_arch()
Message-ID: <20250327164231.GD1425@sol.localdomain>
References: <20250326200812.125574-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326200812.125574-1-ebiggers@kernel.org>

On Wed, Mar 26, 2025 at 01:08:12PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Fix a silly bug where an array was used outside of its scope.
> 
> Fixes: 1684e8293605 ("arm/crc-t10dif: expose CRC-T10DIF function through lib")
> Cc: stable@vger.kernel.org
> Reported-by: David Binderman <dcb314@hotmail.com>
> Closes: https://lore.kernel.org/r/AS8PR02MB102170568EAE7FFDF93C8D1ED9CA62@AS8PR02MB10217.eurprd02.prod.outlook.com
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  arch/arm/lib/crc-t10dif-glue.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied to https://web.git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=crc-next

- Eric

