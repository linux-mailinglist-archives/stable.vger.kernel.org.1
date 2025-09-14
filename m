Return-Path: <stable+bounces-179563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD359B567F7
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 13:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA731899D7C
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 11:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B704247281;
	Sun, 14 Sep 2025 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eE/4/8tI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B81469D
	for <stable@vger.kernel.org>; Sun, 14 Sep 2025 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757850223; cv=none; b=riharR61TdJojLxhc0AGEOrhJltfXGUHmRCo7hG0wC2CLZBhlDd6+n8rdQ1/ILUqIVdtODPlpWuvPmYTdgkgzD6rkJUuA5vLyVQl0Y3d9KGzXqt4pGgrFPyYz0x6tvfTjEIxcmrCx0Ex+C6+gcHaxa2PfEfoyOyzNV8HLFHySE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757850223; c=relaxed/simple;
	bh=S9xDkMrfN84gCqOd9+ICGvy6KBGi+TZnoy/cT0DUhw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rrju3iHZlbyJZN0/ABg1j8v9V4+Xzinigrj96zWk1mulO9/oxsWQqZaKqBPD8Ys+urxfu1Qr/9znVnx5g1KKSmGtvmYSBaWHzB+yHKBnVABrTPaFab8zNV4sfEpDSXrb+kN2RGAOWGyN2kLpW9czyB9Ey0j6Go73DQuLjzdSMz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eE/4/8tI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86ACAC4CEF0;
	Sun, 14 Sep 2025 11:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757850222;
	bh=S9xDkMrfN84gCqOd9+ICGvy6KBGi+TZnoy/cT0DUhw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eE/4/8tIaGeVdwyjsUnXXOVv6gb5B4LeZVc70DmrOGzoKH/dHia5fPWRj21FdD7Qt
	 bq1oAoYVZeEsWAMm66RDsziILOVgh21S9Je/51lSRsPoHV3dCQ96BIqJVDKP0qJ2K1
	 rIMMiB+hrs1ym50vEvAPYiEJRkLGG6GrW4UZRonA=
Date: Sun, 14 Sep 2025 13:43:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Marcel Jira <marcel.jira@gmail.com>,
	Niklas Cathor <niklas.cathor@gmx.de>, 1114806bugs@debian.org
Subject: Re: Please backport commit 440cec4ca1c2 ("drm/amdgpu: Wait for
 bootloader after PSPv11 reset") to v6.16.y
Message-ID: <2025091431-manpower-osmosis-b679@gregkh>
References: <aMakc-rP93XNJaA6@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMakc-rP93XNJaA6@eldamar.lan>

On Sun, Sep 14, 2025 at 01:18:11PM +0200, Salvatore Bonaccorso wrote:
> Hi
> 
> In Debian we got the report in https://bugs.debian.org/1114806 that
> suspend to RAM fails (amdgpu driver hang) and Niklas Cathor was both
> able to bisect the issue down to 8345a71fc54b ("drm/amdgpu: Add more
> checks to PSP mailbox") (which was backported to 6.12.2 as well).
> 
> There is an upstream report as well at
> https://gitlab.freedesktop.org/drm/amd/-/issues/4531 matching the
> issue and fixed by 440cec4ca1c2 ("drm/amdgpu: Wait for bootloader
> after PSPv11 reset").
> 
> Unfortunately the commit does not apply cleanly to 6.16.y as well as
> there were the changes around 9888f73679b7 ("drm/amdgpu: Add a
> noverbose flag to psp_wait_for").
> 
> Attached patch backports the commit due to this context changes,
> assuming it is not desirable to pick as well 9888f73679b7.
> 
> Does that looks good? If yes, can you please consider picking it up or
> the next 6.16.y stable series as well?

I have a revert of the offending commit in the 6.16.y queue right now,
as this was pointed out as causing a problem:
	https://lore.kernel.org/all/20250904220457.473940-1-alexander.deucher@amd.com/
so that should resolve this issue, right?

thanks,

greg k-h

