Return-Path: <stable+bounces-191659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8A5C1C232
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 17:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F9CE5C0FF2
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 16:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED36F34DCFC;
	Wed, 29 Oct 2025 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="C1M3XGyT"
X-Original-To: stable@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F6834DCCF;
	Wed, 29 Oct 2025 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754112; cv=none; b=r8R2h0vnEILhoE0cEFggPBPMwC7ZeEuuhu8zlVGKmolF/ktqmaUUFicssN+G6EZnBhaO66GJARmT/bdhqhu/LMCAcKLl95qP9A/8OI+f4KZvpM+P/CDoVrganas8CqRIJwi82I5S76QAVzyL+MPHLFQYn54QAv6T50x9k2GauHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754112; c=relaxed/simple;
	bh=FvheU5MZYCN14xHdWx6Kg7JoYWn2MMAEe9/SqQLNLnc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=imwyRZBUk/zt/kxlF7NKNT+TtYDO1P+gSBrP7cJ7dn/p/Y15fhKpl3Tt+NQl0Jw+hWlfU13kNnVstbIHv6c7dY+ucEw+LYOuSi5Y/Up6JVjL28e1FfbSvUHmIeencIt7fxv618pszewh0AuCyTWuENhgLEJt0hJZFjRFMMlx1WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=C1M3XGyT; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 24C1A406FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761754110; bh=UX7vSfd/TNTub1AvMxw2PX8R0Jt/IunPvXfu0oAPX00=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=C1M3XGyTvOhRKJaAIuPeQoJzo34wRvVAEfH7fCBvFj0MWhZuSYSgw4xBoH+k0+8tA
	 qg4cCGhNYufz4FBYsIMxJbMSaztmIQWyxGTzGysIpe91MypR+a/Pbsl+zEk9zP0/gm
	 mESRju9sDHB5pqta+E4v/HnndeWCmw1spgxQNttik39foz0wWsUz0U7f5Hru1NSfTk
	 9Tl6B5ODRdnt5qUyxLlQE/USLroXWQelsI/aRN3pL6vHKvrjug0a0/sL8RGkMPdwxB
	 zEwtB79pV/dYVnPQJbylRVy68prN97yPkMydPYKXak18VxYVPgYOrXgRAgxe2yzig6
	 KBcMderD0oeCA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 24C1A406FB;
	Wed, 29 Oct 2025 16:08:30 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux Kernel Workflows
 <workflows@vger.kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, Bagas
 Sanjaya <bagasdotme@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] Documentation: process: Also mention Sasha Levin as
 stable tree maintainer
In-Reply-To: <20251022034336.22839-1-bagasdotme@gmail.com>
References: <20251022034336.22839-1-bagasdotme@gmail.com>
Date: Wed, 29 Oct 2025 10:08:29 -0600
Message-ID: <87frb1r8qq.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Sasha has also maintaining stable branch in conjunction with Greg
> since cb5d21946d2a2f ("MAINTAINERS: Add Sasha as a stable branch
> maintainer"). Mention him in 2.Process.rst.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/process/2.Process.rst | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/process/2.Process.rst b/Documentation/process/2.Process.rst
> index 8e63d171767db8..7bd41838a5464f 100644
> --- a/Documentation/process/2.Process.rst
> +++ b/Documentation/process/2.Process.rst
> @@ -99,8 +99,10 @@ go out with a handful of known regressions, though, hopefully, none of them
>  are serious.
>  
>  Once a stable release is made, its ongoing maintenance is passed off to the
> -"stable team," currently Greg Kroah-Hartman. The stable team will release
> -occasional updates to the stable release using the 9.x.y numbering scheme.
> +"stable team," currently consists of Greg Kroah-Hartman and Sasha Levin. The
> +stable team will release occasional updates to the stable release using the
> +9.x.y numbering scheme.
> +
>  To be considered for an update release, a patch must (1) fix a significant

Applied, thanks.

jon

