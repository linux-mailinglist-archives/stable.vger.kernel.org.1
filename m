Return-Path: <stable+bounces-163714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B72B0DAC3
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 15:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7401C257B6
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 13:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B992EA14D;
	Tue, 22 Jul 2025 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v10T7jH8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9412EA17A;
	Tue, 22 Jul 2025 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753190902; cv=none; b=Ey4yVOV/tY3EXhKd/BWcXbHlI/eEpGepClFf38BwvOnNpwt8IaAsKo13AdSi1KdzjpKwBVutmmmpcG1oA4vRnRnmGJHfg5uWG+nufVkXx9M2qR4jcMjk7KUO9BpOlgXUo3F5D7hvDuefnVf39oYfDpZoP0obWSaxoAy18v84gVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753190902; c=relaxed/simple;
	bh=/asWMbbWiP1Edx0lLFSF2thybCdJ2cxLOk37xOpDeq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJmEb1SW9Ms6wlibC/b3WccpE7LqCHpBI/CTqfkrJF395zlvYPiP5ZKGiRU+d1vJG5OIuwnF4yZAfm8sAJzO7Jw2Co3igdFp7lsPfx6gAWNqIyQf6Of7U8ua0EGplCPIrHVm8HsitY1Pxlqspl0RSp/RCeIep45AuNwphTl6X+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v10T7jH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB04C4CEF1;
	Tue, 22 Jul 2025 13:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753190902;
	bh=/asWMbbWiP1Edx0lLFSF2thybCdJ2cxLOk37xOpDeq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v10T7jH8JS1iwjVcjzPScwf39tAk5M+Up9sJj0VBTEepfinemOam1JcuW8kzSEd0R
	 DQuKaMXNmVoFIRE6Y4PnmwhgB0pMX5ddXZpYn/6/aXCgZQ4LRYPFW+A4+F/QlzvAGq
	 UJNEgiAg+SDiUPXRLN4S5Fh8B58mVV4bUg+ujmPg=
Date: Tue, 22 Jul 2025 15:28:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stefan Metzmacher <metze@samba.org>
Cc: Sasha Levin <sashal@kernel.org>, Stable <stable@vger.kernel.org>,
	stable-commits@vger.kernel.org, Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Steve French <smfrench@gmail.com>
Subject: Re: Patch "smb: client: make use of common
 smbdirect_socket_parameters" has been added to the 6.12-stable tree
Message-ID: <2025072211-wrangle-hypnotist-be34@gregkh>
References: <20250629142801.1093341-1-sashal@kernel.org>
 <e3d3d647-12a7-4e17-9206-25d03304ac65@samba.org>
 <CAH2r5muFzLct62LPL-1rE35X9Ps+ghxGk=J0FQPfLXwQeTXc6w@mail.gmail.com>
 <73624e22-5421-492c-8725-88284f976dc9@samba.org>
 <2025070824-untreated-bouncing-deb0@gregkh>
 <28fde5eb-42d0-4e41-b048-d5b6f1593bcf@samba.org>
 <2025071523-recant-from-b56a@gregkh>
 <2025072253-blend-fondue-a487@gregkh>
 <2f980e55-f9bb-40f0-88dd-f96dc45bc4f0@samba.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f980e55-f9bb-40f0-88dd-f96dc45bc4f0@samba.org>

On Tue, Jul 22, 2025 at 03:23:09PM +0200, Stefan Metzmacher wrote:
> Hi Greg,
> 
> > > > > > I'm looking at v6.15.5 and v6.12.36 and the following are missing
> > > > > > from 6.15:
> > > > > > 
> > > > > > bced02aca343 David Howells Wed Apr 2 20:27:26 2025 +0100 cifs: Fix reading into an ITER_FOLIOQ from the smbdirect code
> > > > > > 87dcc7e33fc3 David Howells Wed Jun 25 14:15:04 2025 +0100 cifs: Fix the smbd_response slab to allow usercopy
> > > > > > b8ddcca4391e Stefan Metzmacher Wed May 28 18:01:40 2025 +0200 smb: client: make use of common smbdirect_socket_parameters
> > > > > > 69cafc413c2d Stefan Metzmacher Wed May 28 18:01:39 2025 +0200 smb: smbdirect: introduce smbdirect_socket_parameters
> > > > > > c39639bc7723 Stefan Metzmacher Wed May 28 18:01:37 2025 +0200 smb: client: make use of common smbdirect_socket
> > > > > > f4b05342c293 Stefan Metzmacher Wed May 28 18:01:36 2025 +0200 smb: smbdirect: add smbdirect_socket.h
> > > > > > a6ec1fcafd41 Stefan Metzmacher Wed May 28 18:01:33 2025 +0200 smb: smbdirect: add smbdirect.h with public structures
> > > > > > 6509de31b1b6 Stefan Metzmacher Wed May 28 18:01:31 2025 +0200 smb: client: make use of common smbdirect_pdu.h
> > > > > > a9bb4006c4f3 Stefan Metzmacher Wed May 28 18:01:30 2025 +0200 smb: smbdirect: add smbdirect_pdu.h with protocol definitions
> 
> I see the above in queue-6.15/ now, thanks!
> 
> > > > > > With these being backported to 6.15 too, the following is missing in
> > > > > > both:
> > > > > > 
> > > > > > commit 1944f6ab4967db7ad8d4db527dceae8c77de76e9
> > > > > > Author:     Stefan Metzmacher <metze@samba.org>
> > > > > > AuthorDate: Wed Jun 25 10:16:38 2025 +0200
> > > > > > Commit:     Steve French <stfrench@microsoft.com>
> > > > > > CommitDate: Wed Jun 25 11:12:54 2025 -0500
> > > > > > 
> > > > > >       smb: client: let smbd_post_send_iter() respect the peers max_send_size and transmit all data
> > > > > > 
> > > > > > As it was marked as
> > > > > > Cc: <stable+noautosel@kernel.org> # sp->max_send_size should be info->max_send_size in backports
> 
> 
> But 1944f6ab4967db7ad8d4db527dceae8c77de76e9 is still missing in 6.15 and 6.12.
> 
> Can you please also add that?

Oops, missed that, now queued up.

greg k-h

