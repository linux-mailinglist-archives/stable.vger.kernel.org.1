Return-Path: <stable+bounces-45651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB34E8CD138
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD9A1C2162F
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 11:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7551474B6;
	Thu, 23 May 2024 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EhHrlFZS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10BD7EEE7;
	Thu, 23 May 2024 11:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716463782; cv=none; b=e7kbihbUQe04RHGarkbuhkPGhPlEMHeXpRA7kmSWZF98RNUk47TBGLxrvZYQPcHWrgN/ktUpX36ZalmASYptk3xLO/c/9o2M/1dKD+GtcgIYOBWqshVaickK5YmmU41xm/TpRjMROp6MhMo90vuQFsBgyNger9ABRc9aPVx4tNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716463782; c=relaxed/simple;
	bh=4ge3E4ZeokmDbphVFHM0rLp+VaYRYn80/b7KG19Gj7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnNeaFOMtWA3OGzqt94CBqvDyOrR4Iug1z5JSugJgDNGtq8EDOlIZDtFJiwDtIKsQlGmmcr0Znx8hG8EFeMT1/V7E5RkSYp2ysYul8Tak4xcM4ScLTvCXoTpK6kAsZGmtoualAetHu05iy2/ciBd74HkXv0ffzmvb4QQ13hox88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EhHrlFZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0832BC2BD10;
	Thu, 23 May 2024 11:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716463781;
	bh=4ge3E4ZeokmDbphVFHM0rLp+VaYRYn80/b7KG19Gj7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EhHrlFZSs4w4Dnio6EdIgcwKrA7hyOKaGwzuAXqROf5ukvGWcBjwDZi8P8gaYn2EN
	 wJZEA0p9jlyTeIvotrlGQ/kcf2I4e7cqjN3eUHwMFyrTXHvAGE1YBWMhQzNjQHwGvV
	 y609h1SvU9lS4YR1OScmuuijFhvnQ/niwFl9iuXw=
Date: Thu, 23 May 2024 13:29:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Doug Berger <opendmb@gmail.com>
Cc: stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH stable 5.4 0/2] net: bcmgenet: revisit MAC reset
Message-ID: <2024052332-cinnamon-oppose-98a9@gregkh>
References: <20240516211153.140679-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516211153.140679-1-opendmb@gmail.com>

On Thu, May 16, 2024 at 02:11:51PM -0700, Doug Berger wrote:
> Commit 3a55402c9387 ("net: bcmgenet: use RGMII loopback for MAC
> reset") was intended to resolve issues with reseting the UniMAC
> core within the GENET block by providing better control over the
> clocks used by the UniMAC core. Unfortunately, it is not
> compatible with all of the supported system configurations so an
> alternative method must be applied.
> 
> This commit set provides such an alternative. The first commit
> reverts the previous change and the second commit provides the
> alternative reset sequence that addresses the concerns observed
> with the previous implementation.
> 
> This replacement implementation should be applied to the stable
> branches wherever commit 3a55402c9387 ("net: bcmgenet: use RGMII
> loopback for MAC reset") has been applied.
> 
> Unfortunately, reverting that commit may conflict with some
> restructuring changes introduced by commit 4f8d81b77e66 ("net:
> bcmgenet: Refactor register access in bcmgenet_mii_config").
> The first commit in this set has been manually edited to
> resolve the conflict on stable/linux-5.4.y.
> 
> Doug Berger (2):
>   Revert "net: bcmgenet: use RGMII loopback for MAC reset"
>   net: bcmgenet: keep MAC in reset until PHY is up
> 
>  .../net/ethernet/broadcom/genet/bcmgenet.c    | 10 ++---
>  .../ethernet/broadcom/genet/bcmgenet_wol.c    |  6 ++-
>  drivers/net/ethernet/broadcom/genet/bcmmii.c  | 39 +++----------------
>  3 files changed, 16 insertions(+), 39 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

Both now queued up, thanks.

greg k-h

