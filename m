Return-Path: <stable+bounces-5091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0430480B29D
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 08:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC30F1F210D7
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 07:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B361C1C3E;
	Sat,  9 Dec 2023 07:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szKTXiPT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E25E15AB
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 07:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D26FC433C7;
	Sat,  9 Dec 2023 07:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702105392;
	bh=r9M79cNEJFxf3SEXa36O6l5b3jOguMAeDcO0NvJFejg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=szKTXiPT+pHxZf2Y83nsbEK2fBRtygVzLYJjcaL9CBnsmIjhPvOHg4F6lmk1kxODp
	 xYnFqnuPDuLGKJY2rsCVB/e/qWu/cAGIX9BzSZLiEQ22RJIh8HLosClMCZ03HYNNxu
	 NUmbeQUrRZBmzIm9oeY6CBnc7Gdf65CDLkBy1euWLKrGqKJMz+b1ru17FAz/IMjxHF
	 +cWWxJ4RW+jYjaIAwtkt3NhAuJKPjl5tSRfx2XHLqyTnt3e58GHz+PD4aEiiEJ2i+C
	 fwXCxqmvMd06kuTwTH5AIeOv9ZXV5hNPuImmq5GO4rbcNdXNeBctGFpQdQ7xJRMWAo
	 fNoaHnvazpq2g==
Date: Sat, 9 Dec 2023 02:03:04 -0500
From: Sasha Levin <sashal@kernel.org>
To: Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Cc: stable@vger.kernel.org
Subject: Re: Request for 3 patches.
Message-ID: <ZXQRKHut5BQGBWOb@sashalap>
References: <CANP3RGcj8zskLQLcZTDZUET-LEtvixpp7K25m4c64wQhvg++zA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANP3RGcj8zskLQLcZTDZUET-LEtvixpp7K25m4c64wQhvg++zA@mail.gmail.com>

On Fri, Dec 08, 2023 at 02:17:36PM -0800, Maciej Żenczykowski wrote:
>It appears that 4.14 (.332) and 4.19 (.301) LTS missed out on:
>
>  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=66b5f1c439843bcbab01cc7f3854ae2742f3d1e3
>  net-ipv6-ndisc: add support for RFC7710 RA Captive Portal Identifier
>
>while 4.14, 4.19 and 5.4 (.263) LTS missed out on:
>
>  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c24a77edc9a7ac9b5fea75407f197fe1469262f4
>  ipv6: ndisc: add support for 'PREF64' dns64 prefix identifier
>and
>  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9175d3f38816835b0801bacbf4f6aff1a1672b71
>  ipv6: ndisc: RFC-ietf-6man-ra-pref64-09 is now published as RFC8781
>
>Could we get these included?
>They're trivial.

They're trivial, but it really doesn't look like fixes...

Isn't it there just to support a new RFC?

-- 
Thanks,
Sasha

