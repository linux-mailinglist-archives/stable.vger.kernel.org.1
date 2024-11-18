Return-Path: <stable+bounces-93792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BD69D1051
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 13:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA701282716
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 12:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EED198A35;
	Mon, 18 Nov 2024 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="r9h46YPh"
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0607190468;
	Mon, 18 Nov 2024 12:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731931496; cv=none; b=Y3FbY9o2yKLJua7iwoDkp1/mtUbXvRB82tTVl5E7RJnE/ww7P86co+zKZKwh2WGVsWrYYG0xaUSik3DJgNUyMXytq0XVz1Edcc/SZ6JlSwTfHgn5dxkzFmnVfJNR73/Su2H9vrHfqjEw3dfudwP67pzoirmIyzu8z+iR2ilFAIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731931496; c=relaxed/simple;
	bh=SJM0ho/3D4sWt0Ay5bp6OufDOilYcKEaL63lve+VGPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMuzFvBpaJRx8Qwh4FR2V/0kGC0lRu9M47nSKV8yGyEc/DkpwszehNT/0W/ECrldHWM3QP+Vh/zKx80o1/5ZoNA8UOKCDVIa7g7I6AOTTNF9j2n9iSPQ4DdPspj4AqHaXgjlHhYOmpMkex6pEcKeo71sugIrRxfZmPM2jhlPRmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=r9h46YPh; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731931492;
	bh=SJM0ho/3D4sWt0Ay5bp6OufDOilYcKEaL63lve+VGPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r9h46YPhvdrf0l1i4Wew5j1uXas2mF7c5Da2uX+xtlsnOclY+oEkXcZlky8i5RwxC
	 pmCShqYjEGsdHdlZDIfmAptJMAR4gEpQvsAVQA01BzcR8IaeT1ZQjmh2P4AjA9Y86V
	 nidui5IbPf5ufWtxc9dtWQtmOnYF5I9nNdVBoEdg=
Date: Mon, 18 Nov 2024 13:04:51 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] perf: arm-ni: Fix attribute_group definition syntax
Message-ID: <b09e1bec-f42c-4f36-8548-b912f59a88f4@t-8ch.de>
References: <20241117-arm-ni-syntax-v1-1-1894efca38ac@weissschuh.net>
 <fc308d9b-9b8b-4932-9f24-1756f5c089db@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc308d9b-9b8b-4932-9f24-1756f5c089db@arm.com>

On 2024-11-18 11:55:17+0000, Robin Murphy wrote:
> On 2024-11-17 10:20 am, Thomas Weißschuh wrote:
> > The sentinel NULL value does not make sense and is a syntax error in a
> > structure definition.
> 
> What error? It's an initialiser following a designator in a structure
> *declaration*, and the corresponding bin_attrs member is a pointer, so NULL
> is a perfectly appropriate value to initialise it with.

Yes, you are correct. The warning only occurs in my series which changes
bin_attrs to a union [0] and I got confused due to some missing and
inconsisteny build bot feedback.

> Of course that is redundant when it's static anyway, and indeed wasn't
> actually intentional, but it's also not doing any harm - the cosmetic
> cleanup is welcome, but is not a stable-worthy fix.

Agreed, it's not worthy for stable.
Actually I want to make this patch part of a series, so please ignore
it for now.

> Thanks,
> Robin.

[0] https://lore.kernel.org/lkml/20241115-b4-sysfs-const-bin_attr-group-v1-1-2c9bb12dfc48@weissschuh.net/

> > Remove it.
> > 
> > Fixes: 4d5a7680f2b4 ("perf: Add driver for Arm NI-700 interconnect PMU")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> > Cc stable because although this commit is not yet released, it most
> > likely will be by the time it hits mainline.
> > ---
> >   drivers/perf/arm-ni.c | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/perf/arm-ni.c b/drivers/perf/arm-ni.c
> > index 90fcfe693439ef3e18e23c6351433ac3c5ea78b5..fd7a5e60e96302fada29cd44e7bf9c582e93e4ce 100644
> > --- a/drivers/perf/arm-ni.c
> > +++ b/drivers/perf/arm-ni.c
> > @@ -247,7 +247,6 @@ static struct attribute *arm_ni_other_attrs[] = {
> >   static const struct attribute_group arm_ni_other_attr_group = {
> >   	.attrs = arm_ni_other_attrs,
> > -	NULL
> >   };
> >   static const struct attribute_group *arm_ni_attr_groups[] = {
> > 
> > ---
> > base-commit: 4a5df37964673effcd9f84041f7423206a5ae5f2
> > change-id: 20241117-arm-ni-syntax-250a83058529
> > 
> > Best regards,
> 

