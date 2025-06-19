Return-Path: <stable+bounces-154733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3246ADFC57
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 06:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CCB33B9AAB
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 04:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A02818DB20;
	Thu, 19 Jun 2025 04:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q1OAEukD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE033085D4;
	Thu, 19 Jun 2025 04:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750306968; cv=none; b=g80EH2RByERWR/DJoHhpZQ2E/4L+3fBehyk4G4HYy/yyoWb9KeIAUCM5xat8BGgeYURtPeua3E4oHaDHc+egMKnjAjfHUmNvMwfVYY5qsrBFP8ph8TgLWlgEeoQ3+L9Zl/9ZJr8gj5eWK6zA1EdwkviP6t3karmE7GBawbfOE6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750306968; c=relaxed/simple;
	bh=OO05Wy/2ru65DWjR/t9IAWEXqKW0i9TpLj50L0IpDfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eg4iN4CJYMAxZm7iKAShwqMbA0jBVkJTCUWBq2MsyoeN/pQcHF1K5xnoBHi90zgjEgArBNQIVBwKq9xeSOzfPI0ot61wO03R+BAsv+TQ4LS88QJxV3vtC3TOtmiTFUBefeYLE0mezaeDfYkXGpwTWGiPpijhH85zEBUfJoMY2m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q1OAEukD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E40C4CEEA;
	Thu, 19 Jun 2025 04:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750306967;
	bh=OO05Wy/2ru65DWjR/t9IAWEXqKW0i9TpLj50L0IpDfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q1OAEukD2kYIY7Hs97BJyARTVjsnZgH4IHjYHE6MY8pdoguYyApI0AR44E5FwzZVk
	 ja0WB8Lw6ooBqVhdkhMl6YaT60fAplmyREbopwZNOlYWziGw5ORUKLxO/vcsy671pt
	 ADUmMhMHJNwXpakBhDkejQeVRP6tMPCErZecqHrc=
Date: Thu, 19 Jun 2025 06:22:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 257/356] net: Fix checksum update for ILA
 adj-transport
Message-ID: <2025061915-uninstall-subtotal-23a7@gregkh>
References: <20250617152338.212798615@linuxfoundation.org>
 <20250617152348.550981340@linuxfoundation.org>
 <aFLv9Ea6Sh2eXjed@Tunnel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFLv9Ea6Sh2eXjed@Tunnel>

On Wed, Jun 18, 2025 at 06:57:24PM +0200, Paul Chaignon wrote:
> On Tue, Jun 17, 2025 at 05:26:12PM +0200, Greg Kroah-Hartman wrote:
> > 6.6-stable review patch.  If anyone has any objections, please let me know.
> 
> Not an objection per se, but I've sent the same backport at
> https://lore.kernel.org/stable/6520b247c2d367849f41689f71961e9741b1b7eb.1750168920.git.paul.chaignon@gmail.com/
> The only difference is that I also backported the second patch in the
> series, which had a conflict. The backported patchset should apply on
> 6.1, 6.6, and 6.12. I hope that was the correct way to proceed :)

Ah, that is nicer, I'll drop this and then queue those up for the next
round of stable releases, thanks!

greg k-h

