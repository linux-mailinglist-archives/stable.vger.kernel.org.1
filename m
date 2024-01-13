Return-Path: <stable+bounces-10827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED93082CE64
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 21:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBBA41C21084
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 20:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C278E79E5;
	Sat, 13 Jan 2024 20:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FE+hCig+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698A45684;
	Sat, 13 Jan 2024 20:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473D6C433C7;
	Sat, 13 Jan 2024 20:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705178290;
	bh=GD77WtFLk9WIEevU7YE4zAkNW4rLtoRnzKrGLlIIggE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FE+hCig+qd+N4WMSbpGi8mijlgwFkwYctRJFagdUjq0y1OKYtMGIHf0QDrA2LgBzt
	 0RTgDolTUqrS/TwNtBv+jaFgF8vvHGMbH0Sn0vXJi4lIvQ34lmfyL9JaChLdgdsUal
	 ZGZyrKCGWvIkpi57TGL0ZmVELS5+dYL7rO0CooCM=
Date: Sat, 13 Jan 2024 21:38:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Steve French <smfrench@gmail.com>, David Howells <dhowells@redhat.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	"Jitindar Singh, Suraj" <surajjs@amazon.com>,
	linux-mm <linux-mm@kvack.org>, stable-commits@vger.kernel.org,
	Stable <stable@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [Regression 6.1.y] From "cifs: Fix flushing, invalidation and
 file size with copy_file_range()"
Message-ID: <2024011357-isolation-muzzle-56dd@gregkh>
References: <8e59220d-b0f3-4dae-afc3-36acfa6873e4@leemhuis.info>
 <ZZk6qA54A-KfzmSz@eldamar.lan>
 <13a70cc5-78fc-49a4-8d78-41e5479e3023@leemhuis.info>
 <ZZ7Dy69ZJCEyKhhS@eldamar.lan>
 <2024011115-neatly-trout-5532@gregkh>
 <2162049.1705069551@warthog.procyon.org.uk>
 <CAH2r5mtBSvp9D8s3bX7KNWjXdTuOHPx5Z005jp8F5kuJgU3Z-g@mail.gmail.com>
 <ZaLCFboedRPqcrDO@casper.infradead.org>
 <CAH2r5mvN1F0PqeyAQqv8Z__FikYV+3kekVP0yTtLmCmzmg=QGA@mail.gmail.com>
 <ZaLNlyo8cDCpATPm@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaLNlyo8cDCpATPm@casper.infradead.org>

On Sat, Jan 13, 2024 at 05:51:19PM +0000, Matthew Wilcox wrote:
> On Sat, Jan 13, 2024 at 11:08:00AM -0600, Steve French wrote:
> > I thought that it was "safer" since if it was misapplied to version where
> > new folio rc behavior it wouldn't regress anything
> 
> There are only three versions where this patch can be applied: 6.7, 6.6
> and 6.1.  AIUI it's a backport from 6.7, it's already applied to 6.6,
> and it misapplies to 6.1.  So this kind of belt-and-braces approach is
> unnecessary.
> 

Agreed, I've fixed this up now, thanks all!

greg k-h

