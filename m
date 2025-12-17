Return-Path: <stable+bounces-202785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B77ACC6D89
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 10:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E61C5305F64E
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 09:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB2734106A;
	Wed, 17 Dec 2025 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E955cPQS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F11434105F;
	Wed, 17 Dec 2025 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765964108; cv=none; b=d4LWQdEg34OsAPjUQnz0er3UV970xH3LkUIxWkZfw3R8sbzAsxx6CWM/OH+5QX2ZyuqkboF8shrnZV0o+AadpTe+OO09+6LCX48BoWxQNPhy0Bc4CuT7eNedGicgPvLfRsieOvN+TS8NjEfiQjSqj6JgA64PThe59x01DTpK/58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765964108; c=relaxed/simple;
	bh=dMeTDFXTFnhr5jxwEwAS48XtiMRS5TijhF2JZ0IReUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaVjAmu8vlc7ytYmIhB9GkfIGmHTJx4zQWnEjzoMRM/BRrRi4HCI+HQWzWhZ4B8Sc3vw2iCK6AqhFJgg+FiX0Q6gel+P86KfX7qWMM2osB8ex0HChj7mvusC2/LaZ03L8hfF8JChElWIzCMk3Obu+U7r+7/uTdgHmDqTIPvpIXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E955cPQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778B2C4CEF5;
	Wed, 17 Dec 2025 09:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765964101;
	bh=dMeTDFXTFnhr5jxwEwAS48XtiMRS5TijhF2JZ0IReUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E955cPQSHga6P7Wq+Nr48mQX0Enu6gej/dmpPsCfQ4pLLEFvuBzn2zHV19fLlNqCi
	 s/IqBO+dHMCpLmmlteFiUCfxgy/HJvPQMfxNaCDAq7zFkebt5KcaXk1njijDrT7IkI
	 Nf1oZ+mOBA97UY18cxxwIvfeSHnGUev9uvdt/EtY=
Date: Wed, 17 Dec 2025 10:34:58 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gu Bowen <gubowen5@huawei.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org, Lu Jialin <lujialin4@huawei.com>
Subject: Re: [PATCH v2,stable/linux-6.6.y] fbdev: Fix out-of-bounds issue in
 sys_fillrect()
Message-ID: <2025121715-vindicate-valium-1118@gregkh>
References: <20251217094530.1685998-1-gubowen5@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217094530.1685998-1-gubowen5@huawei.com>

On Wed, Dec 17, 2025 at 05:45:30PM +0800, Gu Bowen wrote:
> This issue has already been fixed by commit eabb03293087 ("fbdev:
> Refactoring the fbcon packed pixel drawing routines") on v6.15-rc1, but it
> still exists in the stable version.

Why not take the refactoring changes instead?  That is almost always the
proper thing to do, one-off changes are almost always wrong and cause
extra work in the long-term.

Please try backporting those changes instead please.

thanks,

greg k-h

