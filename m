Return-Path: <stable+bounces-160494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 335C0AFCE1A
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC844486994
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 14:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558D220F091;
	Tue,  8 Jul 2025 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RZ5Qd7d/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43AC40BF5;
	Tue,  8 Jul 2025 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985959; cv=none; b=JCKF+PSbk2YuV8KGshItKEzwaRENDsNSCmYQ0NlTmHhOkzOxKhj/jkWRHgL7Ot7sOAfNRF2dQIzv+nOySHq3P3JtSyOe4K/fwWyihi9B0+MaRdybeFQAOZ43dKrAqIcSvLYiml7k8rdYuIwnZxowLHdrnt2k8M070jnwISUDMvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985959; c=relaxed/simple;
	bh=7LrqDWjAD919VlFKyllO8QBvgDoO9BqmvC4qGlEGbGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjQ6RGQqmaAxflEdTpVJ0I5OeLQhyEoJ+rjRVjmaozb++PZ0od3KXWJcmpekBIZcWvcguSa1fQLvCRtSpYCFd/Lgq+krou5nPBqTH8PEoMUzD/eslOohLqqgFyk3lf3B893DZQ6hyokfYD1dLvMZ10HjIff5W6n+e0HTz5S0wqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RZ5Qd7d/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B16AC4CEED;
	Tue,  8 Jul 2025 14:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751985958;
	bh=7LrqDWjAD919VlFKyllO8QBvgDoO9BqmvC4qGlEGbGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RZ5Qd7d/teVbyYtpgvaBYc9ATVzznY7o6lDRGdqU5EhCOrkXqYIaB20XPrQh1/j9K
	 rybtYWnyaWBsExLIuGqpfADhRBv+0eaqMPRkalnlw2xaNPsVHPpp3bi0vUDJlbAK3b
	 +CV0bDJ/iN/JGDpv6YzvTBR98A+HoJFDetswb4RE=
Date: Tue, 8 Jul 2025 16:45:50 +0200
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
Message-ID: <2025070824-untreated-bouncing-deb0@gregkh>
References: <20250629142801.1093341-1-sashal@kernel.org>
 <e3d3d647-12a7-4e17-9206-25d03304ac65@samba.org>
 <CAH2r5muFzLct62LPL-1rE35X9Ps+ghxGk=J0FQPfLXwQeTXc6w@mail.gmail.com>
 <73624e22-5421-492c-8725-88284f976dc9@samba.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73624e22-5421-492c-8725-88284f976dc9@samba.org>

On Tue, Jul 08, 2025 at 02:23:53PM +0200, Stefan Metzmacher wrote:
> Hi,
> 
> any reason why this is only backported to 6.12, but not 6.15?

Looks like Sasha's scripts missed them, thanks for catching.  We need to
run the "what patches are only in older trees" script again one of these
days to sweep all of these up...

> I'm looking at v6.15.5 and v6.12.36 and the following are missing
> from 6.15:
> 
> bced02aca343 David Howells Wed Apr 2 20:27:26 2025 +0100 cifs: Fix reading into an ITER_FOLIOQ from the smbdirect code
> 87dcc7e33fc3 David Howells Wed Jun 25 14:15:04 2025 +0100 cifs: Fix the smbd_response slab to allow usercopy
> b8ddcca4391e Stefan Metzmacher Wed May 28 18:01:40 2025 +0200 smb: client: make use of common smbdirect_socket_parameters
> 69cafc413c2d Stefan Metzmacher Wed May 28 18:01:39 2025 +0200 smb: smbdirect: introduce smbdirect_socket_parameters
> c39639bc7723 Stefan Metzmacher Wed May 28 18:01:37 2025 +0200 smb: client: make use of common smbdirect_socket
> f4b05342c293 Stefan Metzmacher Wed May 28 18:01:36 2025 +0200 smb: smbdirect: add smbdirect_socket.h
> a6ec1fcafd41 Stefan Metzmacher Wed May 28 18:01:33 2025 +0200 smb: smbdirect: add smbdirect.h with public structures
> 6509de31b1b6 Stefan Metzmacher Wed May 28 18:01:31 2025 +0200 smb: client: make use of common smbdirect_pdu.h
> a9bb4006c4f3 Stefan Metzmacher Wed May 28 18:01:30 2025 +0200 smb: smbdirect: add smbdirect_pdu.h with protocol definitions
> 
> With these being backported to 6.15 too, the following is missing in
> both:
> 
> commit 1944f6ab4967db7ad8d4db527dceae8c77de76e9
> Author:     Stefan Metzmacher <metze@samba.org>
> AuthorDate: Wed Jun 25 10:16:38 2025 +0200
> Commit:     Steve French <stfrench@microsoft.com>
> CommitDate: Wed Jun 25 11:12:54 2025 -0500
> 
>     smb: client: let smbd_post_send_iter() respect the peers max_send_size and transmit all data
> 
> As it was marked as
> Cc: <stable+noautosel@kernel.org> # sp->max_send_size should be info->max_send_size in backports
> 
> But now that the patches up to b8ddcca4391e are backported it can be cherry-picked just
> fine to both branches.

Ok, will do.  I think I might have dropped these from 6.15 previously as
the "noautosel" tag threw me...

thanks,

greg k-h

