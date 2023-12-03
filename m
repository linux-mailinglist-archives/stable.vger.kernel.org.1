Return-Path: <stable+bounces-3719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 653248021DA
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 09:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DBFB1F21009
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 08:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9FD33E9;
	Sun,  3 Dec 2023 08:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hH/CCIp+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A966138C;
	Sun,  3 Dec 2023 08:38:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBAEC433C8;
	Sun,  3 Dec 2023 08:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701592716;
	bh=WzZdUmGTrfTPnWx030hxSj02JaRqdt/tZ6wGGHUliS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hH/CCIp+8VI0ux9jP5EMxYlCn25Yn4hVKfX7tKWzcAfp/2TxFPtgJv3Twk7pHHe2d
	 uOFyqXrakEV4+hkupmSsgO/o4oVZp/Mr4auPrUiOYIwEWot14ZVX7SSeWHHM4vABIS
	 35E3uPqyObpAcZyeOPvQy80vAOxqXPnMqeu2uhok=
Date: Sun, 3 Dec 2023 09:38:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	stable@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	regressions@lists.linux.dev, linux-bluetooth@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org
Subject: Re: Regression: Inoperative bluetooth, Intel chipset, mainline
 kernel 6.6.2+
Message-ID: <2023120329-length-strum-9ee1@gregkh>
References: <ee109942-ef8e-45b9-8cb9-a98a787fe094@moonlit-rail.com>
 <8d6070c8-3f82-4a12-8c60-7f1862fef9d9@leemhuis.info>
 <2023120119-bonus-judgingly-bf57@gregkh>
 <6a710423-e76c-437e-ba59-b9cefbda3194@moonlit-rail.com>
 <55c50bf5-bffb-454e-906e-4408c591cb63@molgen.mpg.de>
 <2023120213-octagon-clarity-5be3@gregkh>
 <f1e0a872-cd9a-4ef4-9ac9-cd13cf2d6ea4@moonlit-rail.com>
 <2023120259-subject-lubricant-579f@gregkh>
 <ef575387-4a52-49bd-9c26-3a03ac816b61@moonlit-rail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef575387-4a52-49bd-9c26-3a03ac816b61@moonlit-rail.com>

On Sun, Dec 03, 2023 at 03:32:52AM -0500, Kris Karas (Bug Reporting) wrote:
> Greg KH wrote:
> > Thanks for testing, any chance you can try 6.6.4-rc1?  Or wait a few
> > hours for me to release 6.6.4 if you don't want to mess with a -rc
> > release.
> 
> As I mentioned to Greg off-list (to save wasting other peoples' bandwidth),
> I couldn't find 6.6.4-rc1.  Looking in wrong git tree?  But 6.6.4 is now
> out, which I have tested and am running at the moment, albeit with the
> problem commit from 6.6.2 backed out.
> 
> There is no change with respect to this bug.  The problematic patch
> introduced in 6.6.2 was neither reverted nor amended.  The "opcode 0x0c03
> failed" lines to the kernel log continue to be present.
> 
> > Also, is this showing up in 6.7-rc3?  If so, that would be a big help in
> > tracking this down.
> 
> The bug shows up in 6.7-rc3 as well, exactly as it does here in 6.6.2+ and
> in 6.1.63+.  The problematic patch bisected earlier appears identically (and
> seems to have been introduced simultaneously) in these recent releases.

Ok, in a way, this is good as that means I haven't missed a fix, but bad
in that this does affect everyone more.

So let's start over, you found the offending commit, and nothing has
fixed it, so what do we do?  xhci/amd developers, any ideas?

thanks,

greg k-h

