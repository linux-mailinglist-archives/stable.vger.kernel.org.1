Return-Path: <stable+bounces-163377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD66B0A66E
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 16:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F621C427A7
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 14:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5DD2DBF43;
	Fri, 18 Jul 2025 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b="ipPcvZM3";
	dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b="XJuhlFvi"
X-Original-To: stable@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B35217B425
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 14:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752849390; cv=none; b=QN68M/6nBTPjvIBXeUcTK/3PVhlJgNFbfExr3WUzrKoIoNWnNZnbrxyhou95yn2xA5z6qHwwX6AQDNcw2wWCj6RGnfeOE6A/rbi+NIgixMUQVpxICzP1BHPLvv2f78agqPJTF7h74cBHsHtF7IKXm/cAe+Cm1Y7QCzp4fFvwVT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752849390; c=relaxed/simple;
	bh=mCJTMl6hmU/t/n7RMrAexSGMCuHAoxTnyKTXuygkquM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qu4tpm4OTOW2e7fLjLhc3NlVvEIEmRZahSLM1ldkgsN7W77eJQC6s0FLSoq9MMB1L9jfPoQfkAOjxlRmp0ZhuyRTaOoEKKC/HtDaUm8QGtexdinVNyrcwkaWupjF+nQW7tSilzMTDG1Cxg6M1P7BW00BFosl3qfxPqIuO3x1Iuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hacktheplanet.fi; spf=pass smtp.mailfrom=hacktheplanet.fi; dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b=ipPcvZM3; dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b=XJuhlFvi; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hacktheplanet.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hacktheplanet.fi
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=gibson; bh=mCJTMl6hmU/t/
	n7RMrAexSGMCuHAoxTnyKTXuygkquM=; h=in-reply-to:references:subject:cc:
	to:from:date; d=hacktheplanet.fi; b=ipPcvZM3bpMRJzxRS0cot5qFHDc+uFbNh/
	hJrhoxcKvc68HaecB44RlKS7zlclhqvmPniNnPsgpormEgUYIVt6FDOowL7BvGrzRvlvjN
	otPTSFQUyLVli7gPNsRtNMZlz9J2nvVjLHpcDvUn2N9IQhYfUx3uh57SqfMgMRkc3bsOH0
	YXVuBwLGfTW5mwbyxFuTVNwfs/r6vkgDRihTr+MeGUrCO0Q9wT1Y264pYbO5NiR2Ub5/I7
	je7NJ2i8fwnZOy9YJkZMXLdWZrsX6ja4gVfP5V8KpCcUZxmIEfvG0a0vaTnNky58NwqVaR
	yO13azxNMKaq2ZkNDH/eVRUdb84A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hacktheplanet.fi;
	s=key1; t=1752849384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U4fWzDUDVjTYg2bPTnEOawxX6k0jS8mMVyArseOI0Ro=;
	b=XJuhlFvinkI3yznxCnIYv2c0XaEPy6pnW/s+axNlivjtyGr1LBuHtl9DMslPWcbGJOEUI2
	NJKOpBr6bVvFxOtkeDf2x/i1lqyo0h3D0fk3h7GvAnkI189C++7fCwsBPCcd9+1beaeaKk
	vlBmjvmrd1fG82LdTsqNjDR1Up5AZepcwFD/6XEcyCn9TvbQK1pJSJeAQa37bOZYEUTNR1
	6+fC2dKgKnu+70i+2Hrdy5ajG6SUg59oPhq9YuuImiVhC5735Mcz7oLPX06Y/ywteZK77h
	AbGzTzFLwmQqmBtfqA28gVhfve6tglukDQQ+EnkyfN4seCDrbWcNjhknLAcDxg==
Date: Fri, 18 Jul 2025 23:36:17 +0900
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lauri Tirkkonen <lauri@hacktheplanet.fi>
To: Mario Limonciello <superm1@kernel.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [REGRESSION] drm/amd/display: backlight brightness set to 0 at
 amdgpu initialization
Message-ID: <aHpb4ZTZ5FoOBUrZ@hacktheplanet.fi>
References: <aHn33vgj8bM4s073@hacktheplanet.fi>
 <d92458bf-fc2b-47bf-b664-9609a3978646@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d92458bf-fc2b-47bf-b664-9609a3978646@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 18 2025 08:10:06 -0500, Mario Limonciello wrote:
> Do you by chance have an OLED panel?  I believe what's going on is that
> userspace is writing zero or near zero and on OLED panels with older kernels
> this means non-visible.

Yes, this is an OLED panel. But I don't believe it's userspace writing
anything at this point in the boot; before the bisected commit,
brightness was set to 32 (out of max 255) on this hardware when I
checked from the initramfs rescue shell. At the bisected commit, it's 0
(out of max 255).

> There is another commit that fixes the behavior that is probably missing.

Which commit is that? It's not in 6.15.7?

-- 
Lauri Tirkkonen | lotheac @ IRCnet

