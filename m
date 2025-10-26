Return-Path: <stable+bounces-189864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0160BC0ABBD
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 15:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0093C189FA2F
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 14:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CED02EDD4D;
	Sun, 26 Oct 2025 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XYO3MNqt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FB618D656;
	Sun, 26 Oct 2025 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761490756; cv=none; b=akn5MrLHLaPOjaYZHPmH4H/gvjTMlNk0BXVnDxyITeCyFWZrC+6+tGETgoQiYlyB7bWELS4YAAYp7Cfy05plFoqDgnMIyuAgEXM4t8Yz9ydY0XPSsXxo2Mw2x3uDrYW3bGbQmSQbuLuOIiiFYDyP00IBnuyNeHH70l8uruidALY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761490756; c=relaxed/simple;
	bh=KpddgV0znnn5QXIPxx+Ni0x9RLD2fr0xyW73++styO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Svr06lkXFMwfSatIjs7I3o4l1eLYOQlRv9Wvb9KxtGEaByZdd+Rt+Zn7vPnIaNyJFo+EnFslva2Gs4jqp7F6mweXr/G2MOOW1eAlOFBH4Gx6jaToo0/6BkJJnEURDkEDbeixI2Qy8YItaz9JS5mUtIXmTzp6Ktg25T42tlv0K5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XYO3MNqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB74C4CEE7;
	Sun, 26 Oct 2025 14:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761490756;
	bh=KpddgV0znnn5QXIPxx+Ni0x9RLD2fr0xyW73++styO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XYO3MNqtTqqio86sFu0bmDry6xtDdJiCA2YvCgr3lnIKm0unB9sJoLqR0Y+A7MIh+
	 94mCtCWf4Yx5lUzmv6jvRv3OZ5V+GwngDpOkVR6nULCaqODwXSrkAhazsM4YPlQbN1
	 OyU9x6Mo9tx6BVjwlGJIwEjJb9Ckau3oj3WngFTI=
Date: Sun, 26 Oct 2025 15:59:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kees Cook <kees@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	svetlana.parfenova@syntacore.com, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: Patch "binfmt_elf: preserve original ELF e_flags for core dumps"
 has been added to the 6.17-stable tree
Message-ID: <2025102600-mouth-multiple-70c7@gregkh>
References: <20251023152409.1026224-1-sashal@kernel.org>
 <202510230835.964611CF@keescook>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202510230835.964611CF@keescook>

On Thu, Oct 23, 2025 at 08:35:43AM -0700, Kees Cook wrote:
> On Thu, Oct 23, 2025 at 11:24:08AM -0400, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     binfmt_elf: preserve original ELF e_flags for core dumps
> > 
> > to the 6.17-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      binfmt_elf-preserve-original-elf-e_flags-for-core-du.patch
> > and it can be found in the queue-6.17 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> No, I asked that it not be backported:
> https://lore.kernel.org/all/202510020856.736F028D@keescook/

Now dropped from all queues.

thanks,

greg k-h

