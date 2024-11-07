Return-Path: <stable+bounces-91849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2569C098D
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 16:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48061F24A0A
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 15:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A662101BE;
	Thu,  7 Nov 2024 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sB0Ua042"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555D680C02;
	Thu,  7 Nov 2024 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730991851; cv=none; b=N0pgEgFvgnQJIhY84ae5ZVxZSlb4poidUbR0w8mlj4T69VFjfiV4VVyZaGvMAiTpc/aQlfOP6r6chapYNDl2DFI4qOhQ1DgDX9G3YNmr4rplW9Xov7KlOluNO+K0PLpr9UP61MjQjoOGuaNS3aPYmhkmzHR0xtbV1EE+lniUCdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730991851; c=relaxed/simple;
	bh=rGYzyX2tTcmLGwVQ8RDN6FD2brY2WsudAWi9QD6RziI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzmgGHAVPSLibvSXN3f76Y+eq8kKvdlK31a1JVv5gYWu1erURSpW5vWdQy1AukvSv0gj/MLGGLszKN+rGZYQspmYe/3HsuvVK/kFdqGHJkI/CyzAxuYfJbPOt+qRV+SssovJzjhAzs5N76TLQsEGqN/ytSOZLXEeNGxlnKXEkC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sB0Ua042; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771F7C4CECC;
	Thu,  7 Nov 2024 15:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730991850;
	bh=rGYzyX2tTcmLGwVQ8RDN6FD2brY2WsudAWi9QD6RziI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sB0Ua042jHGdb1TnAKVTCQ3kVAddvpY2Zkvs+XItV/SLtidAAEF9y8jnFBoVfeLSO
	 Q4v8cnrlEJAfFUb1WI3hwvS8HHHVWjgB5MLJRoceFyMQNELpdcK3mhzqJ/06mnpqc9
	 oekSgzSXQlFNr+tXZLE4yogpjvWZnDU2L36bmsPA=
Date: Thu, 7 Nov 2024 16:03:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: me@meirisoda.online
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: Kernel 6.11 breaks power-profiles-daemon on NixOS unstable
Message-ID: <2024110729-paddle-selected-cabd@gregkh>
References: <tRrhWMFNiTeCGps2p7WCa6mrpbeCMCgYfeXGsJNOjttrbCyth-0_5EsgpkAZ9zqeMBR4kS6axOZrZxJwnA3LhYtGMgmRnmL2-xrpI0oVkxk=@meirisoda.online>
 <Xw3BDSu6nGp8D43shw707_3JcIzRhictWhTjZpThlOWIyF69jtxhq11eV2ExaObroqAhGypRaS86DmN2f2e2IgmGSC4U1AFRW95qOLometo=@meirisoda.online>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xw3BDSu6nGp8D43shw707_3JcIzRhictWhTjZpThlOWIyF69jtxhq11eV2ExaObroqAhGypRaS86DmN2f2e2IgmGSC4U1AFRW95qOLometo=@meirisoda.online>

On Thu, Nov 07, 2024 at 02:55:57PM +0000, me@meirisoda.online wrote:
> Upgrading to kernel version 6.11 breaks the ability to switch between power modes on KDE Plasma 6.2.2 and NixOS 24.11 (unstable). I am using a ROG Zephyrus 14 GA401 with a 4060.
> 
> I thought it may be Nvidia acting up so I've tried:
> 
>     Re-enabling power-profiles-daemon in my NixOS configuration (did not fix the issues)
>     Disabling supergfxctl on NixOS configuration (did not fix the issue)
>     Switching between nvidia latest and beta (did not fix the issue)
> 
> Switching back to kernel version 6.10 fixes the issue. Since 6.10 is considered EOL upstream, I had to manually switch back to a specific commit hash to get 6.10 to work.
> 
> Hoping this gets fixed on 6.11.

Can you do a 'git bisect' between 6.10 and 6.11 to find out what the
offending commit is?

thanks,

greg k-h

