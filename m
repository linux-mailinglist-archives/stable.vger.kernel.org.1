Return-Path: <stable+bounces-3702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAD4801B70
	for <lists+stable@lfdr.de>; Sat,  2 Dec 2023 09:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1DD8281DBF
	for <lists+stable@lfdr.de>; Sat,  2 Dec 2023 08:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071D6D303;
	Sat,  2 Dec 2023 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mc/5K3pp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C3B619B7;
	Sat,  2 Dec 2023 08:15:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BF8C433C7;
	Sat,  2 Dec 2023 08:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701504910;
	bh=jq83GxZf9uvvQ4nhoCC1k6tKxzxInmqnxKl5OtXKEL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mc/5K3ppCatptQLE0W2Rvm+62ek/fHepV1AXqEmy9mwHe41NwTBDdth7yr9KLMzgW
	 jujRubb4A+e19jBiREbXiG4FacJrp28F4FFzfhnQT0Z/woYZnJ4oC/fvLR6XCGwU9O
	 jfKl8uRjKAC+e6hBbUcjNQa6E1hmFcp+mltUdXEY=
Date: Sat, 2 Dec 2023 09:15:07 +0100
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
Message-ID: <2023120259-subject-lubricant-579f@gregkh>
References: <ee109942-ef8e-45b9-8cb9-a98a787fe094@moonlit-rail.com>
 <8d6070c8-3f82-4a12-8c60-7f1862fef9d9@leemhuis.info>
 <2023120119-bonus-judgingly-bf57@gregkh>
 <6a710423-e76c-437e-ba59-b9cefbda3194@moonlit-rail.com>
 <55c50bf5-bffb-454e-906e-4408c591cb63@molgen.mpg.de>
 <2023120213-octagon-clarity-5be3@gregkh>
 <f1e0a872-cd9a-4ef4-9ac9-cd13cf2d6ea4@moonlit-rail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1e0a872-cd9a-4ef4-9ac9-cd13cf2d6ea4@moonlit-rail.com>

On Sat, Dec 02, 2023 at 02:58:32AM -0500, Kris Karas (Bug Reporting) wrote:
> Greg KH wrote:
> > > Am 02.12.23 um 07:43 schrieb Kris Karas (Bug Reporting):
> > > > When Basavaraj's patch is applied (in mainline 6.6.2+), bluetooth stops
> > > > functioning on my motherboard.
> > > > 
> > > > Originally from bugzilla #218142 [1]
> > > [1]: https://bugzilla.kernel.org/show_bug.cgi?id=218142
> > 
> > Should already be fixed in the 6.6.3 release, can you please verify that
> > this is broken there?
> 
> Double-checked and confirmed.  6.6.3 shows the bug (hci0: Opcode 0x0c03
> failed: -110) and my currently-running system (6.6.3 with
> 14a51fa544225deb9ac2f1f9f3c10dedb29f5d2f backed out) is running fine (with
> its MX Master 3S bluetooth mouse).

Thanks for testing, any chance you can try 6.6.4-rc1?  Or wait a few
hours for me to release 6.6.4 if you don't want to mess with a -rc
release.

Also, is this showing up in 6.7-rc3?  If so, that would be a big help in
tracking this down.

thanks,

greg k-h

