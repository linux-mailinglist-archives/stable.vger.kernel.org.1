Return-Path: <stable+bounces-45664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E84C08CD19C
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25EB81C21A9A
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 11:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD6113BC23;
	Thu, 23 May 2024 11:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oq5Y/6bv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B4113BC13;
	Thu, 23 May 2024 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716465542; cv=none; b=k72WITAKLDqy8t/F48RUnbxYwV0Qd781idLrtAhPF7x5pxpKgHGojeEZahonP5iNLI+Qfw6Cmo/IYdD+g3lCKbCW/kX4YVNR1K9HW15hA2xFtz438E04o6NUG3vpxMg+x8W6h316uc9et3bhAdlyOcskqCA5L9Vri9fo/ESRuRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716465542; c=relaxed/simple;
	bh=ovB6iL5IBWmYqxJJOaGrT6tWCnVgJJf3GENQRYszLvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPL2hHnhkj39v7VV4QR4hTE3UKcHOaXQdFeYJQp963IMbk+7zauxM2tRykBnIxKFvgGx+7JrQOS1CdQdebh3wrII/5HWxuIppy+/+v4x0yvxZ0v4bbrlsPklLn/RJCRX8+8ZFa7gfCEjhEg/gPt1JG49y4CJixEuk2cj9UTASJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oq5Y/6bv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3A6C2BD10;
	Thu, 23 May 2024 11:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716465541;
	bh=ovB6iL5IBWmYqxJJOaGrT6tWCnVgJJf3GENQRYszLvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oq5Y/6bvRjWdw7HFKcnz6DhROjLv61OtHELAPMTdCf/sVtGEfO5SKEr3bek2LxRS2
	 URyZbxxyAB3t9iethVKZrGuan0nXcyAQ55yPdW5jYNhNwn6IOFFS2qgKikZjUP64km
	 lPX/nR9U/4GrAu/XRBoguYNjTc/uggApkbzeawUw=
Date: Thu, 23 May 2024 13:58:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Dominique Martinet <dominique.martinet@atmark-techno.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH 5.4 / 5.10] firmware: arm_scmi: Harden accesses to the
 reset domains
Message-ID: <2024052351-outward-skinny-c38b@gregkh>
References: <20240513003837.810709-1-dominique.martinet@atmark-techno.com>
 <ZkHbzRahnQgptrVr@bogus>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkHbzRahnQgptrVr@bogus>

On Mon, May 13, 2024 at 10:22:21AM +0100, Sudeep Holla wrote:
> On Mon, May 13, 2024 at 09:38:37AM +0900, Dominique Martinet wrote:
> > From: Cristian Marussi <cristian.marussi@arm.com>
> >
> > [ Upstream commit e9076ffbcaed5da6c182b144ef9f6e24554af268 ]
> >
> > Accessing reset domains descriptors by the index upon the SCMI drivers
> > requests through the SCMI reset operations interface can potentially
> > lead to out-of-bound violations if the SCMI driver misbehave.
> >
> > Add an internal consistency check before any such domains descriptors
> > accesses.
> >
> > Link: https://lore.kernel.org/r/20220817172731.1185305-5-cristian.marussi@arm.com
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> > ---
> > This is the backport I promised for CVE-2022-48655[1]
> > [1] https://lkml.kernel.org/r/Zj4t4q_w6gqzdvhz@codewreck.org
> >
> 
> The backport looks good and thanks for doing that. Sometimes since we
> know all the users are in the kernel, we tend to ignore the facts that
> they need to be backport as this was considered as theoretical issue when
> we pushed the fix. We try to keep that in mind and add fixes tag more
> carefully in the future. Thanks for your effort and bring this to our
> attention.

Now queued up, thanks

greg k-h

