Return-Path: <stable+bounces-60383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9222E933701
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 08:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C346B1C21166
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 06:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61727134A8;
	Wed, 17 Jul 2024 06:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ExwohI5Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA3018643;
	Wed, 17 Jul 2024 06:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721197602; cv=none; b=scviHcaLEg2OTEcIceYVx0ygdOyu6qj8UzQWpfBUf4FDsi/bqcA/u1uw21Etj+Sayg5wGnlxZiWXQGjNQTi8ElN2UkoFoJo0UoTop5rTdIBSN5oNe2OCALrEPAfOYELfaErMqJviE0Ti8GcVS4EvjsH+8QMGH47xBtahrrGQcDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721197602; c=relaxed/simple;
	bh=TaTKwduvzWNdw4nBlJexfY5qBgFDvuZwsL/yMzvaJLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jW3a6edIjTTdGe/eOFXWOwTHWY/eBeyh+kUQi0p1+qsRi5+Qrne6qgA0CbV5WLEVnwXV2OWxcnGtuawWVF4drZddbzMjfbM59X7admX6PVw2sJOSlKQlBVAWe55e1RtkGk9TXI7HkgXp9adrj/wmlwrp6XeeOMbOwTqoxgJLvwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ExwohI5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A2CC4AF0C;
	Wed, 17 Jul 2024 06:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721197601;
	bh=TaTKwduvzWNdw4nBlJexfY5qBgFDvuZwsL/yMzvaJLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ExwohI5QQoo3XT1IsF1PEXTe63C4puBJhiIPRsGT5V+eXKL7uMhkSfOPlFzhlRb7x
	 V1bd1xelG8Nc29D9Rf5Mdjt5Tse08m2BhuGNURgCjY8srKyJW2yj3Wc6rTd9LRn389
	 gxxYrcnBly/wGsCUZtH9SOdJwmB1kFPrbO9KeYH0=
Date: Wed, 17 Jul 2024 08:26:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrew Paniakin <apanyaki@amazon.com>
Cc: stable@vger.kernel.org, Benjamin Herrenschmidt <benh@amazon.com>,
	Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
	Paulo Alcantara <pc@manguebit.com>, Paulo Alcantara <pc@cjr.nz>,
	Steve French <stfrench@microsoft.com>,
	Steve French <sfrench@samba.org>,
	Ronnie Sahlberg <lsahlber@redhat.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	"open list:COMMON INTERNET FILE SYSTEM CLIENT (CIFS and SMB3)" <linux-cifs@vger.kernel.org>,
	"moderated list:COMMON INTERNET FILE SYSTEM CLIENT (CIFS and SMB3)" <samba-technical@lists.samba.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6.1] cifs: use origin fullpath for automounts
Message-ID: <2024071751-manhandle-taunt-00ef@gregkh>
References: <20240713031147.20332-1-apanyaki@amazon.com>
 <2024071535-scouting-sleet-08ee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024071535-scouting-sleet-08ee@gregkh>

On Mon, Jul 15, 2024 at 01:48:44PM +0200, Greg KH wrote:
> On Sat, Jul 13, 2024 at 03:11:47AM +0000, Andrew Paniakin wrote:
> > From: Paulo Alcantara <pc@cjr.nz>
> > 
> > commit 7ad54b98fc1f141cfb70cfe2a3d6def5a85169ff upstream.
> > 
> > Use TCP_Server_Info::origin_fullpath instead of cifs_tcon::tree_name
> > when building source paths for automounts as it will be useful for
> > domain-based DFS referrals where the connections and referrals would
> > get either re-used from the cache or re-created when chasing the dfs
> > link.
> > 
> > Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
> > Signed-off-by: Steve French <stfrench@microsoft.com>
> > [apanyaki: backport to v6.1-stable]
> > Signed-off-by: Andrew Paniakin <apanyaki@amazon.com>
> > ---
> > This patch fixes issue reported in
> > https://lore.kernel.org/regressions/ZnMkNzmitQdP9OIC@3c06303d853a.ant.amazon.com
> > 
> > 1. The set_dest_addr function gets ip address differntly. In kernel 6.1
> > the dns_resolve_server_name_to_ip function returns string instead of
> > struct sockaddr, this string needs to be converted with
> > cifs_convert_address then.
> > 
> > 2. There's no tmp.leaf_fullpath field in kernel 6.1, it was introduced
> > later in a1c0d00572fc ("cifs: share dfs connections and supers")
> > 
> > 3. __build_path_from_dentry_optional_prefix and
> > dfs_get_automount_devname were added to fs/smb/client/cifsproto.h
> > instead of fs/cifs/dfs.h which doesn't exist in 6.1
> 
> Now queued up, thanks.

Nope, now dropped.  This required me to apply d5a863a153e9 ("cifs: avoid
dup prefix path in dfs_get_automount_devname()") to the tree (and
attempt to backport it myself), but that didn't work, as it caused
reported build errors as seen here:
	https://lore.kernel.org/r/aaccd8cc-2bfe-4b2e-b690-be50540f9965@gmail.com

So I'm dropping this, and the fix-up patch.  Please be careful when
sending backports that you do NOT miss additional patches that are
required as well.  I'll be glad to take backports, as long as they are
correct :)

thanks,

greg k-h

