Return-Path: <stable+bounces-103909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF259EFAA8
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 19:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14D6B16FE61
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889E8223C48;
	Thu, 12 Dec 2024 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wozxl7Fj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19240222D75
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026875; cv=none; b=qOl7C5SGhXQje1WSld9XsMePk8ZqwhNfrAURJW/eBHCjpQzbNf8OR/BB/8r3KTqZ2kBfAs3COQ5+rHeDJ1Ped4UbzdbkZP4ZVe7zYNWlcC5O0r7V2o9aKs4B4rrXApxhcIUf7i9fK+2WO/MrMeog+x69ktNZ6FwmU9FeFqsqC3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026875; c=relaxed/simple;
	bh=5FNFbdhwur+vcUAWoDhMvyE2NpnaTsJn2/3XCAod5l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQ7rSnsixQMUip46RyaIrwN/CLWzeyc2DRKIBm8QHlMEVtIfKUk5/sa6vfzbZa/M6B5erH3HBHcs6i6iYYNe/BsZAIhbhFMldkclRu26vwk1mh6lAgY3DNPIqnIfaHSFItiLqaagghaIaO33n/lSyujSR1hZIPhdsVKWN1yCBys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wozxl7Fj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B67C4CECE;
	Thu, 12 Dec 2024 18:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734026874;
	bh=5FNFbdhwur+vcUAWoDhMvyE2NpnaTsJn2/3XCAod5l8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wozxl7Fjg8yuMM57q6KSWiLbcjJdl8p0kMXOoZuE2CFJbcqfQJ8WVEeyViV3bgI/Y
	 VKQteiWokLfalm0qYEyZfOc5btrckQVO1LL4fCtvLxK3SpIqORkB5rcD0q0QghKLGR
	 StiV7nVZDLh1PjmTULjbYR0prdHHF8BYvEuQEv9A=
Date: Thu, 12 Dec 2024 19:07:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: stable@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] KVM: arm64: Ignore PMCNTENSET_EL0 while checking for
 overflow status
Message-ID: <2024121202-gradually-reaction-2cd6@gregkh>
References: <2024120223-stunner-letter-9d09@gregkh>
 <20241203190236.2711302-1-rananta@google.com>
 <2024121209-dreaded-champion-4cae@gregkh>
 <CAJHc60zMcf7VZKwc61Z3iGaWHe_HayhViOv=rdFxwoRB=AyH6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJHc60zMcf7VZKwc61Z3iGaWHe_HayhViOv=rdFxwoRB=AyH6w@mail.gmail.com>

On Thu, Dec 12, 2024 at 09:41:28AM -0800, Raghavendra Rao Ananta wrote:
> Hi Greg,
> 
> This is an adjustment of the original upstream patch aimed towards the
> 4.19.y stable branch.

4.19.y is end-of-life, so there's nothing we can do there.  But what
about 5.4.y?  If it matters there, please resend it in a format we can
apply it in for that tree.

thanks,

greg k-h

