Return-Path: <stable+bounces-198109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 172FDC9C09D
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 16:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07C624E3130
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 15:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F59321441;
	Tue,  2 Dec 2025 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fz2ez+iL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C060331ED7C;
	Tue,  2 Dec 2025 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764690788; cv=none; b=qpfK8Ya16GXetSsiuafmry2cYZ3oj4CgcXqTC0aWeAtuxlwCkNOAKSAV0Jwldjcf8DUZurNc4nfEPhpioLexj0f5Tqm11R8Z51EPLi635hqMrJXLCwNDKG+tBv84kCD1eTqoRe9NOwLeM+JkVRBSOGcbT4LNEsYFml8GPaT4OQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764690788; c=relaxed/simple;
	bh=dAuiJuoctUPi+JO/hbGHwGpVusbOU/8eCH/UeKEZfNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYrAg8cVPZ/6Sw9rghHf5ryNBawOPDL6rSjLz1Bo5/k147PgnRa3GVei9aY9dL3u77QadmuvfTBv7NjnhaUtr/p/YIlJNyhXUK0N48PHdL1DVGTzLl4pIm0h1ZQQbQTsDYZ1lBtiwQzWPKv3CoOnsg1ydytJss5tEin8nmeSRic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fz2ez+iL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098C8C4CEF1;
	Tue,  2 Dec 2025 15:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764690788;
	bh=dAuiJuoctUPi+JO/hbGHwGpVusbOU/8eCH/UeKEZfNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fz2ez+iLP9STXL5YjoRxhOjyPsvrIc6RDVKWcIDX/1QHHsSM4sdWrzjHE7v0dVjjG
	 doEQ2sMlHbZ2+eoyAL143a1glI1ItnsWn5Ut/ZXkdORSlbk7GoGXwGoXYJgP6DV6fb
	 MB/QfJSpLVds6QHP0BZ3SNQNKQztmcuQgvQ94VDo=
Date: Tue, 2 Dec 2025 16:53:04 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Javier Martinez Canillas <javierm@redhat.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 6.6.y] drm, fbcon, vga_switcheroo: Avoid race condition
 in fbcon setup
Message-ID: <2025120251-polymer-disobey-ccc4@gregkh>
References: <2025120119-quake-universal-d896@gregkh>
 <20251201225123.1298682-1-sashal@kernel.org>
 <250b44b3-e75b-4f8d-af44-d3a985ea554c@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <250b44b3-e75b-4f8d-af44-d3a985ea554c@suse.de>

On Tue, Dec 02, 2025 at 08:42:52AM +0100, Thomas Zimmermann wrote:
> Hi,
> 
> thanks for backporting.
> 
> You also have to remove the calls to vga_switcheroo_client_fb_set() from
> these files
> 
> https://elixir.bootlin.com/linux/v6.6/source/drivers/gpu/drm/i915/display/intel_fbdev.c
> 
> https://elixir.bootlin.com/linux/v6.6/source/drivers/gpu/drm/radeon/radeon_fbdev.c

Also, a fixed backport would be appreciated here.

thanks

greg k-h

