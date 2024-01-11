Return-Path: <stable+bounces-10504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1DC82ACD0
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 12:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A095B23207
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 11:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC0014F7E;
	Thu, 11 Jan 2024 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aRPK84yB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7502E156D9;
	Thu, 11 Jan 2024 11:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AD1C433C7;
	Thu, 11 Jan 2024 11:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704971028;
	bh=u7aQsAvFFh84UWTaGJCadbYnk2NDh3rc/Iqx9qIzySw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aRPK84yBfss5X+RCFMGn35A2jIg3qZwhsRelp1dtAN0QcXVReft1/wKjh3Wk79NkF
	 huQdHoNcPOlQutn9fM0Ofhx6NF3+Tv0Q2QWnMbQNLGXQXVOQZAXAqE4v1VSCMb7wzx
	 THgfS03Vb8LH4Sy4x265+PM0IkA/mhWX2J8hl2NY=
Date: Thu, 11 Jan 2024 12:03:45 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	"Jitindar Singh, Suraj" <surajjs@amazon.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>,
	stable@vger.kernel.org, linux-cifs@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [Regression 6.1.y] From "cifs: Fix flushing, invalidation and
 file size with copy_file_range()"
Message-ID: <2024011115-neatly-trout-5532@gregkh>
References: <2023121124-trifle-uncharted-2622@gregkh>
 <a76b370f93cb928c049b94e1fde0d2da506dfcb2.camel@amazon.com>
 <ZZhrpNJ3zxMR8wcU@eldamar.lan>
 <8e59220d-b0f3-4dae-afc3-36acfa6873e4@leemhuis.info>
 <ZZk6qA54A-KfzmSz@eldamar.lan>
 <13a70cc5-78fc-49a4-8d78-41e5479e3023@leemhuis.info>
 <ZZ7Dy69ZJCEyKhhS@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ7Dy69ZJCEyKhhS@eldamar.lan>

On Wed, Jan 10, 2024 at 05:20:27PM +0100, Salvatore Bonaccorso wrote:
> Hi
> 
> Sorry if this is to prematurely to ask already again.
> 
> On Sat, Jan 06, 2024 at 01:02:16PM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> > On 06.01.24 12:34, Salvatore Bonaccorso wrote:
> > > On Sat, Jan 06, 2024 at 11:40:58AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> > >>
> > >> Does this problem also happen in mainline, e.g. with 6.7-rc8?
> > > 
> > > Thanks a lot for replying back. So far I can tell, the regression is
> > > in 6.1.y only 
> > 
> > Ahh, good to know, thx!
> > 
> > > For this reason I added to regzbot only "regzbot ^introduced
> > > 18b02e4343e8f5be6a2f44c7ad9899b385a92730" which is the commit in
> > > v6.1.68.
> > 
> > Which was the totally right thing to do, thx. Guess I sooner or later
> > will add something like "#regzbot tag notinmainline" to avoid the
> > ambiguity we just cleared up, but maybe that's overkill.
> 
> Do we have already a picture on the best move forward? Should the
> patch and the what depends on it be reverted or was someone already
> able to isolate where the problem comes from specifically for the
> 6.1.y series? 

I guess I can just revert the single commit here?  Can someone send me
the revert that I need to do so as I get it right?

thanks,

greg k-h

