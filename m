Return-Path: <stable+bounces-54642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CCF90F07E
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 16:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73078285E85
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 14:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9EB1CAAD;
	Wed, 19 Jun 2024 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mE/dpri4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E261DA4C;
	Wed, 19 Jun 2024 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807340; cv=none; b=IoZPJL9D48M3C/74Rz9/0GcIwCc0P84OWXy9wTSoZ2j7TUSEbKqXXThUTvWpqsmlrXPt8XDQ7GLEMESfeDB7kxxWKAun2arVs/TcrPlmNUjoLE/785tWjMrwbubZ0vcal+gKQ73PDgyz0p55AQCXOXv8n+sSUf9q/fLjC1+S3h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807340; c=relaxed/simple;
	bh=Poc5rpuHca8sqVhG+OgCRFs9bBMhZr30XdnyFXPvbJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XflxnzptuJtHtEGgx9urYYEBSl9ol0A0uUTy1+JExt6O0J+V8KeAfSVPh0ZdB0SIJW9jl+VaUJHn5iiG/M+MqnAFil13fyrtKe3yXkjXisxLxZ/sFG2Ewogfx+guwTWKccu9EenCu97FRyX7lSPYRL8J6O54TTS9b/Y3hwXS6EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mE/dpri4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2F9C2BBFC;
	Wed, 19 Jun 2024 14:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718807339;
	bh=Poc5rpuHca8sqVhG+OgCRFs9bBMhZr30XdnyFXPvbJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mE/dpri4FFGjujei9AvSpsV6rBgfsKiuJaffWqLFgXGfMo2vpUTXAsnC7slV5REmS
	 s1nKWDGcQzlM5jyUm1MITiR+icb0n16QuTzHv4VyDZigOlmOHL7gBOTW2anr/XHhJE
	 wkT8hnsh5SGlaIqEwP6xTOhWFfZu6NxrWp0wkQfxAr5bXgZ2yHWGx9Olqm4ERI3dwo
	 kH5pxJfO270e5fuj1K4/bSSZi0fJ774JaIoIk/PxGjwGwjhLCjj2xLIkOu9ftgOx6+
	 F10lCyhQ8NXI2ATYaEHb+v3biyJSSK/coFGze1X5xM6vgvCzKdnKds4D2LE7lNtfNe
	 yylnqT84vf7Vg==
Date: Wed, 19 Jun 2024 10:28:58 -0400
From: Sasha Levin <sashal@kernel.org>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>, linux@armlinux.org.uk,
	andrew@lunn.ch, hkallweit1@gmail.com, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.9 12/35] net: sfp: add quirk for another
 multigig RollBall transceiver
Message-ID: <ZnLrKjb3cwqASKX9@sashalap>
References: <20240527141214.3844331-1-sashal@kernel.org>
 <20240527141214.3844331-12-sashal@kernel.org>
 <20240527165441.2c5516c9@dellmb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240527165441.2c5516c9@dellmb>

On Mon, May 27, 2024 at 04:54:41PM +0200, Marek Behún wrote:
>Sasha,
>
>This requires the whole series from which it came:
>
>  https://lore.kernel.org/netdev/20240409073016.367771-1-ericwouds@gmail.com/
>
>It was merged in
>  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c31bd5b6ff6f70f016e66c0617e0b91fd7aafca4
>
>I don't think this can be easily applied to older kernels, the series
>has some dependencies.

I'll drop it, thanks!

-- 
Thanks,
Sasha

