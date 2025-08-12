Return-Path: <stable+bounces-167113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547FEB22230
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 10:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D30E3B1EB2
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 08:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC522E5B1D;
	Tue, 12 Aug 2025 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KS7HfJt5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029DB2DCF7C;
	Tue, 12 Aug 2025 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988796; cv=none; b=REtdtZ92KSTGM6UXjdkGABd121q1JdlIAZhxrCzWU80lDS0CIjLGliAl3wrSH7Sce5gHQvz4ILvI7swbqxJNwSCmSBN6UldOamIRS2LncwQ6/6Zrkehkqc3zPnXVhem9dl/MX/HoJe/k6TDBu2fyoa5fmIdcTcthJ+Q2KujB3gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988796; c=relaxed/simple;
	bh=9N3PLYa2OY1y/FTofQvg9RDzTZigqxMMs6HBj6/Kal8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOCy2opvmHip9aRYMZ/S6lMShncenhWT9BmEyiKKVMLYMAxuFknvEQEZi43EA0Sxlr/pDkl1oawPyNHprgEwEi52/CJReNt1YWOVUgNNXtm6JMwqnvXuw2OkfMuJBgX/xkG88l1cVSH2FTE8NpLQkTQObfnMVcgTTB5EX4e2y9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KS7HfJt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DF9C4CEF0;
	Tue, 12 Aug 2025 08:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754988794;
	bh=9N3PLYa2OY1y/FTofQvg9RDzTZigqxMMs6HBj6/Kal8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KS7HfJt5i7k8jhDh8FmhE5/fs/zR6m2gxcgL0bKzk3MXp0iHo8TLsga8ALH+8Dlov
	 ZQ+97GJat9UbT46A07XsW6mJQti/ellDvQcF1F8Kj6eDc44Wb4tEVWfqtM+lccGvJW
	 ds1Zb5goz3J4Hr7qSriaoiLx9rrVD9PXU39NnnIM=
Date: Tue, 12 Aug 2025 10:53:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	nicolas.frattaroli@collabora.com, Heiko Stuebner <heiko@sntech.de>
Subject: Re: Patch "pwm: rockchip: Round period/duty down on apply, up on
 get" has been added to the 6.16-stable tree
Message-ID: <2025081236-moneyless-enigmatic-891b@gregkh>
References: <20250808223033.1417018-1-sashal@kernel.org>
 <c5s7efnva5gluplw65g6qqxjqpmcgprgtm6tsajkbdqibe73lb@lw5afb6b725i>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5s7efnva5gluplw65g6qqxjqpmcgprgtm6tsajkbdqibe73lb@lw5afb6b725i>

On Sat, Aug 09, 2025 at 11:45:23AM +0200, Uwe Kleine-König wrote:
> Hello Sasha,
> 
> On Fri, Aug 08, 2025 at 06:30:33PM -0400, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     pwm: rockchip: Round period/duty down on apply, up on get
> > 
> > to the 6.16-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      pwm-rockchip-round-period-duty-down-on-apply-up-on-g.patch
> > and it can be found in the queue-6.16 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> > 
> > 
> > commit 51144efa3159cd95ab37e786c982822a060d7d1a
> > Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > Date:   Mon Jun 16 17:14:17 2025 +0200
> > 
> >     pwm: rockchip: Round period/duty down on apply, up on get
> >     
> >     [ Upstream commit 0b4d1abe5ca568c5b7f667345ec2b5ad0fb2e54b ]
> >     
> >     With CONFIG_PWM_DEBUG=y, the rockchip PWM driver produces warnings like
> >     this:
> >     
> >       rockchip-pwm fd8b0010.pwm: .apply is supposed to round down
> >       duty_cycle (requested: 23529/50000, applied: 23542/50000)
> >     
> >     This is because the driver chooses ROUND_CLOSEST for purported
> >     idempotency reasons. However, it's possible to keep idempotency while
> >     always rounding down in .apply().
> >     
> >     Do this by making .get_state() always round up, and making .apply()
> >     always round down. This is done with u64 maths, and setting both period
> >     and duty to U32_MAX (the biggest the hardware can support) if they would
> >     exceed their 32 bits confines.
> >     
> >     Fixes: 12f9ce4a5198 ("pwm: rockchip: Fix period and duty cycle approximation")
> >     Fixes: 1ebb74cf3537 ("pwm: rockchip: Add support for hardware readout")
> >     Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> >     Link: https://lore.kernel.org/r/20250616-rockchip-pwm-rounding-fix-v2-1-a9c65acad7b6@collabora.com
> >     Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
> >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> while the new code makes the driver match the PWM rules now, I'd be
> conservative and not backport that patch because while I consider it a
> (very minor) fix that's a change in behaviour and maybe people depend on
> that old behaviour. So let's not break our user's workflows and reserve
> that for a major release. Please drop this patch from your queue.

Now dropped, but note, any behavior change is ok for ANY kernel version
as we guarantee they all work the same :)

So good luck with your users in the 6.17 release...

thanks

greg k-h

