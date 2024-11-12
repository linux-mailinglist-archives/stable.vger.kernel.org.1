Return-Path: <stable+bounces-92797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6D79C5B29
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 16:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65FF51F221A7
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 15:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647CE1FF7CF;
	Tue, 12 Nov 2024 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0CoTyZyi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25A81FF033;
	Tue, 12 Nov 2024 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423455; cv=none; b=qAJg4pDH0xAW8DUjulhpT39qtyXfP8DMzh7vSIYDusCHnjVBJ2T3xUb+VSfx0wbQkqRydOC4DVOT5LbOkgL/LrN+jHpz+QaaZEujxGTZWMvKX+mOXBOHoczU12Riwd5VjcoyyH6YpA3/4iZqUnjFai38J6l30iLl7yL8sROvoAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423455; c=relaxed/simple;
	bh=lorSjsjUIClZF21SmrbwnV9pzBktsy7ULGLS8AYTuRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhdFT0K36IJQWJEr65JtSQGVSUWbUAXgspS5Skerg0nOY9MDVUeSvPPCeJVV371dJoubIiUbXo49Li1PPrjJyjHU/m+wdJYY8yWiGsVbMxsF2QXBT3oSwATkpGownwuv8j8QwGgbhSGuSGmmjYiJ2vC0Ab+Fv669tY5lwhy6UmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0CoTyZyi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD68BC4CECD;
	Tue, 12 Nov 2024 14:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731423454;
	bh=lorSjsjUIClZF21SmrbwnV9pzBktsy7ULGLS8AYTuRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0CoTyZyiojaxvpLapT9dDjueGk4ZW0ChTu0p9y5D/yTPblE1NjCVWRBVyRAdswXjG
	 BlSyOH8gnkjiUFNI9SsO033kBxbASOqmSQDiu3fYb1jheO0hgXLrKGPTJ42CVFGbVt
	 NzJHgHmIA5kuCCCh3GWIwXOV44479mti9bBThJb8=
Date: Tue, 12 Nov 2024 15:57:31 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] driver core: class: Fix wild pointer dereference in
 API class_dev_iter_next()
Message-ID: <2024111230-erratic-clay-7565@gregkh>
References: <20241105-class_fix-v1-0-80866f9994a5@quicinc.com>
 <20241105-class_fix-v1-1-80866f9994a5@quicinc.com>
 <2024111205-countable-clamor-d0c7@gregkh>
 <2952f37a-7a11-42d9-9b90-4856ed200610@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2952f37a-7a11-42d9-9b90-4856ed200610@icloud.com>

On Tue, Nov 12, 2024 at 10:46:27PM +0800, Zijun Hu wrote:
> On 2024/11/12 19:43, Greg Kroah-Hartman wrote:
> > On Tue, Nov 05, 2024 at 08:20:22AM +0800, Zijun Hu wrote:
> >> From: Zijun Hu <quic_zijuhu@quicinc.com>
> >>
> >> class_dev_iter_init(struct class_dev_iter *iter, struct class *class, ...)
> >> has return type void, but it does not initialize its output parameter @iter
> >> when suffers class_to_subsys(@class) error, so caller can not detect the
> >> error and call API class_dev_iter_next(@iter) which will dereference wild
> >> pointers of @iter's members as shown by below typical usage:
> >>
> >> // @iter's members are wild pointers
> >> struct class_dev_iter iter;
> >>
> >> // No change in @iter when the error happens.
> >> class_dev_iter_init(&iter, ...);
> >>
> >> // dereference these wild member pointers here.
> >> while (dev = class_dev_iter_next(&iter)) { ... }.
> >>
> >> Actually, all callers of the API have such usage pattern in kernel tree.
> >> Fix by memset() @iter in API *_init() and error checking @iter in *_next().
> >>
> >> Fixes: 7b884b7f24b4 ("driver core: class.c: convert to only use class_to_subsys")
> >> Cc: stable@vger.kernel.org
> > 
> > There is no in-kernel broken users of this from what I can tell, right?
> > Otherwise things would have blown up by now, so why is this needed in
> > stable kernels?
> > 
> 
> For all callers of the API in current kernel tree, the class should have
> been registered successfully when the API is invoking.

Great, so the existing code is just fine :)

> so, could you remove both Fix and stable tag directly?

Nope, sorry.  Asking a maintainer that gets hundreds of patches to
hand-edit them does not scale.

But really, as all in-kernel users are just fine, why add additional
code if it's not needed?  THat's just going to increase our maintance
burden for the next 40+ years for no good reason.

thanks,

greg k-h

