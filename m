Return-Path: <stable+bounces-152859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCFEADCE67
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ADA83B1180
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 13:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D903A2DBF41;
	Tue, 17 Jun 2025 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cYjATir2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1612E2653;
	Tue, 17 Jun 2025 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750168270; cv=none; b=JWCkuhHQ4jErH6G/+Q8YUBP5/+Bqm9qOsHatKUpCKxEeUUtzIbF3huKdZcsxiGgN+jR2miiJPx1yOikXpNXzVVXJX8qYdcl4uDq1Kfs4j1nJGjPFD6lgucUZyuV9u4IfxSCxJ+atTWRL/nUhq6OGry5BB2mCLxuPqRFIlQOAJmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750168270; c=relaxed/simple;
	bh=NWi+uRXta8oWQebfHIDMx01woZcJZET5T+yzw/3Gd44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKCcx6Ek0jmy5R66fr5ZbxxzZqGeHh7jtiTaPvsosJaXfrMBmMyokYcH8jmb/6CkS10adILNyGjIz4lfE1qrMh7Ak6p5AB9VvE5GpZjSFrtXT2KPjGJhx1LNHlfwu085Lhdl3wIAoIXB12CD/yj1p9UL219//u0BxwA+ugKAErU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cYjATir2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E09C4CEE3;
	Tue, 17 Jun 2025 13:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750168270;
	bh=NWi+uRXta8oWQebfHIDMx01woZcJZET5T+yzw/3Gd44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cYjATir2kiHog9o2WQxMaTt0elCL1GM/j20v5EEpvmuO8KRqZlQHAht565DJn0hCF
	 IEZF/tHt3mY9njXYLJbEYY1Km22mbxJXmtK32TSk/roQe76m7hXMXreUYYig9CcDjT
	 2+Hx+2o8ZifqmtalfyiukEiMi5pLVuLrsyC6qyqQ=
Date: Tue, 17 Jun 2025 15:51:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Sasha Levin <sashal@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"kdevops@lists.linux.dev" <kdevops@lists.linux.dev>
Subject: Re: Request for backport of 358de8b4f201 to LTS kernels
Message-ID: <2025061709-remedy-unfreeze-0a29@gregkh>
References: <612fbc1f-ab02-4048-b210-425c93bbbc53@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <612fbc1f-ab02-4048-b210-425c93bbbc53@oracle.com>

On Mon, Jun 09, 2025 at 04:30:19PM -0400, Chuck Lever wrote:
> Hi Greg & Sasha !
> 
> I ran into some trouble in my nightly CI systems that test v6.6.y and
> v6.1.y. Using "make binrpm-pkg" followed by "rpm -iv ..." results in the
> test systems being unbootable because the vmlinuz file is never copied
> to /boot. The test systems are imaged with Fedora 39.
> 
> I found a related Fedora bug:
> 
>   https://bugzilla.redhat.com/show_bug.cgi?id=2239008
> 
> It appears there is a missing fix in LTS kernels. I bisected the kernel
> fix to:
> 
>   358de8b4f201 ("kbuild: rpm-pkg: simplify installkernel %post")
> 
> which includes a "Cc: stable" tag but does not appear in
> origin/linux-6.6.y, origin/linux-6.1.y, or origin/5.15.y (I did not look
> further back than that).
> 
> Would it be appropriate to apply 358de8b4f201 to LTS kernels?

Perhaps, if someone actually backported it to apply there, did you try
it?  :)

At the time, this was reported:
	https://lore.kernel.org/all/2024021932-lavish-expel-58e5@gregkh/
	https://lore.kernel.org/r/2024021934-spree-discard-c389@gregkh
	https://lore.kernel.org/r/2024021930-prozac-outfield-8653@gregkh
but no one did anything about it.

thanks,

greg k-h

