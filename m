Return-Path: <stable+bounces-10817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF2A82CE06
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 18:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1831C20EEA
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 17:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DF65678;
	Sat, 13 Jan 2024 17:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EunVCuwS"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1758E63B3;
	Sat, 13 Jan 2024 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yWHH56ecZvSqek2dR3aaAVsN5PsmZUBOaXC0wFLvTP0=; b=EunVCuwSlLOkc5W3ErTa0HEECc
	71J62WgSG7OznQu/Vnje5oPyx9/IDhKxOyGup53859Rwk9lNisgU4OcyuSXHv0c5vZdAQZ0zyJxJy
	ur5RJs5MnU0cErGR10Nwt7Eaf7SkBn9pEy7/NROPctiQyq2GMHfCXAm09sDEke+lp4Vg7FT60x+oc
	sZplddzXe8ide5fq68yHaYRijDyr7QCrYYrO5+moyuf6wLEeEsCNbQ/zbKngk/A44bIaVJ6Noy/Fq
	tlVPx0/cduip8oNAuqgd599FhzEPSOqwViIACCYMtZuWOrfgI0JHNBBUngMj1JBRGYfE0c9XC6B8v
	xN7YuGYA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rOiAB-003dzj-Tz; Sat, 13 Jan 2024 17:51:19 +0000
Date: Sat, 13 Jan 2024 17:51:19 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>,
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
Message-ID: <ZaLNlyo8cDCpATPm@casper.infradead.org>
References: <ZZhrpNJ3zxMR8wcU@eldamar.lan>
 <8e59220d-b0f3-4dae-afc3-36acfa6873e4@leemhuis.info>
 <ZZk6qA54A-KfzmSz@eldamar.lan>
 <13a70cc5-78fc-49a4-8d78-41e5479e3023@leemhuis.info>
 <ZZ7Dy69ZJCEyKhhS@eldamar.lan>
 <2024011115-neatly-trout-5532@gregkh>
 <2162049.1705069551@warthog.procyon.org.uk>
 <CAH2r5mtBSvp9D8s3bX7KNWjXdTuOHPx5Z005jp8F5kuJgU3Z-g@mail.gmail.com>
 <ZaLCFboedRPqcrDO@casper.infradead.org>
 <CAH2r5mvN1F0PqeyAQqv8Z__FikYV+3kekVP0yTtLmCmzmg=QGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mvN1F0PqeyAQqv8Z__FikYV+3kekVP0yTtLmCmzmg=QGA@mail.gmail.com>

On Sat, Jan 13, 2024 at 11:08:00AM -0600, Steve French wrote:
> I thought that it was "safer" since if it was misapplied to version where
> new folio rc behavior it wouldn't regress anything

There are only three versions where this patch can be applied: 6.7, 6.6
and 6.1.  AIUI it's a backport from 6.7, it's already applied to 6.6,
and it misapplies to 6.1.  So this kind of belt-and-braces approach is
unnecessary.

