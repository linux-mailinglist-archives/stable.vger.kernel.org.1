Return-Path: <stable+bounces-176951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31346B3F94F
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 10:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D104882A2
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 08:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414C22E8E10;
	Tue,  2 Sep 2025 08:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="haAdLEy+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51E52E92B2
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803543; cv=none; b=ZEIrRlWCVSAGWsWIYjktCHqNdSdCgSj3lV4BoR79+sbsFC8/wBpP59998lJdVzPrrfgKDWc5Vi2Cv/BK9YXoTaSJwrsnnUBdWZvvdl+tFZwXjePFbEbeXMp1Y6WE6pJHl7Rm0w3Wc4ypbfpyUD8gMO9thkE620kZ+T0EAHS1PS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803543; c=relaxed/simple;
	bh=URaTAXfZfKy52tPtoYwoF8Wy6Ip+TOtvNKZ1VQ566B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuUrmUR2M8GqaVcny9Ho7lpf7l3eaKkxPU0spf8PwFjOcdRm3UhInn2pJjSCM+O2E524GyE6Ct7vQ/SgXGhRLUxBr7Kafrpy+liYuQk48ErqX1p+cp8QtQ6XI0QqXqrj7M6cd8dvXGXxKXxG2W2ILUc52CLZRaSGk0us1NrdrhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=haAdLEy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE9AC4CEF7;
	Tue,  2 Sep 2025 08:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756803542;
	bh=URaTAXfZfKy52tPtoYwoF8Wy6Ip+TOtvNKZ1VQ566B4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=haAdLEy+2gi0FnHmpXA+Tx069VjwRrm22Rs4HVgTc8PJb2G4TMNd3XqPKA1wVqxDl
	 u6YICar3ZTqJwR3nAujVpOqaBY/tcUtuL9c9wmFwBmTfvFiCVP785wNRCSFiU69QKC
	 mFiDs2RBJYicMwCPLjxyZcAJwyAttHLHknM5JRCw=
Date: Tue, 2 Sep 2025 10:58:58 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: "Manthey, Norbert" <nmanthey@amazon.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com" <syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com>,
	"dima@arista.com" <dima@arista.com>,
	"Yagmurlu, Oemer Erdinc" <oeygmrl@amazon.de>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 1/1] fs: relax assertions on failure to encode file
 handles
Message-ID: <2025090214-rebalance-unscented-8697@gregkh>
References: <2025011112-racing-handbrake-a317@gregkh>
 <20250901153559.14799-1-nmanthey@amazon.de>
 <20250901153559.14799-2-nmanthey@amazon.de>
 <2025090114-bodacious-daffodil-2f2e@gregkh>
 <2025090116-repent-living-b7de@gregkh>
 <ac90cc6067bc7a50d7eb0d606b3dc3718f35b9d9.camel@amazon.de>
 <CAOQ4uxgmc0jexG4uiKT-6rYriqucB6egeFOj0CUUHQQOdg7J4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgmc0jexG4uiKT-6rYriqucB6egeFOj0CUUHQQOdg7J4g@mail.gmail.com>

On Tue, Sep 02, 2025 at 09:29:50AM +0200, Amir Goldstein wrote:
> On Tue, Sep 2, 2025 at 9:20 AM Manthey, Norbert <nmanthey@amazon.de> wrote:
> >
> > On Mon, 2025-09-01 at 22:00 +0200, Greg Kroah-Hartman wrote:
> > > CAUTION: This email originated from outside of the organization. Do not click links or open
> > > attachments unless you can confirm the sender and know the content is safe.
> > >
> > >
> > >
> > > On Mon, Sep 01, 2025 at 09:54:03PM +0200, Greg Kroah-Hartman wrote:
> > > > On Mon, Sep 01, 2025 at 03:35:59PM +0000, Norbert Manthey wrote:
> > > > > From: Amir Goldstein <amir73il@gmail.com>
> > > > >
> > > > > commit 974e3fe0ac61de85015bbe5a4990cf4127b304b2 upstream.
> > > > >
> > > > > Encoding file handles is usually performed by a filesystem >encode_fh()
> > > > > method that may fail for various reasons.
> > > > >
> > > > > The legacy users of exportfs_encode_fh(), namely, nfsd and
> > > > > name_to_handle_at(2) syscall are ready to cope with the possibility
> > > > > of failure to encode a file handle.
> > > > >
> > > > > There are a few other users of exportfs_encode_{fh,fid}() that
> > > > > currently have a WARN_ON() assertion when ->encode_fh() fails.
> > > > > Relax those assertions because they are wrong.
> > > > >
> > > > > The second linked bug report states commit 16aac5ad1fa9 ("ovl: support
> > > > > encoding non-decodable file handles") in v6.6 as the regressing commit,
> > > > > but this is not accurate.
> > > > >
> > > > > The aforementioned commit only increases the chances of the assertion
> > > > > and allows triggering the assertion with the reproducer using overlayfs,
> > > > > inotify and drop_caches.
> > > > >
> > > > > Triggering this assertion was always possible with other filesystems and
> > > > > other reasons of ->encode_fh() failures and more particularly, it was
> > > > > also possible with the exact same reproducer using overlayfs that is
> > > > > mounted with options index=on,nfs_export=on also on kernels < v6.6.
> > > > > Therefore, I am not listing the aforementioned commit as a Fixes commit.
> > > > >
> > > > > Backport hint: this patch will have a trivial conflict applying to
> > > > > v6.6.y, and other trivial conflicts applying to stable kernels < v6.6.
> > > > >
> > > > > Reported-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com
> > > > > Tested-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com
> > > > > Closes: https://lore.kernel.org/linux-unionfs/671fd40c.050a0220.4735a.024f.GAE@google.com/
> > > > > Reported-by: Dmitry Safonov <dima@arista.com>
> > > > > Closes: https://lore.kernel.org/linux-
> > > > > fsdevel/CAGrbwDTLt6drB9eaUagnQVgdPBmhLfqqxAf3F+Juqy_o6oP8uw@mail.gmail.com/
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > Link: https://lore.kernel.org/r/20241219115301.465396-1-amir73il@gmail.com
> > > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > >
> > > > I never signed off on the original commit, so why was this added?
> >
> > This cherry-pick is not for the upstream commit, but for the backport on the 6.6 tree. The
> > respective commit hash is given in the backport line. Is this additional information you would like
> > to have in the commit message?
> >
> > > >
> > > > >
> > > > > (fuzzy picked from commit f47c834a9131ae64bee3c462f4e610c67b0a000f)
> > > > > Applied with LLM-adjusted hunks for 1 functions from us.amazon.nova
> > > > > - Changed the function call from `exportfs_encode_fid` to `exportfs_encode_inode_fh` to match
> > > > > the destination code.
> > >
> > > Wait, that was just fuzz matching, the real body didn't even change.
> > >
> > > > > - Removed the warning message as per the patch.
> > >
> > > I do not understand this change, what exactly was this?
> >
> > I need to rewrite (here: drop) this manually. The LLM was also describing the content of the
> > original patch, not only the diff it created.
> >
> > >
> > > > Please put this in the proper place, and in the proper format, if you
> > > > want to add "notes" to the backport.
> >
> > IIUC, the changes applied to the patch so that it applies should come above my SOB, no? What's the
> > format requirement (except the 80-100 char limit)?
> >
> > I am aware of the discussions about AI generated code. I wanted to explicitly mention the AI use, if
> > it was used as backporting helper. Do you suggest to still move this into the notes section of the
> > commit and sent patch, instead of having this in the commit itself?
> >
> > > >
> > > > But really, it took a LLM to determine an abi change?  That feels like
> > > > total overkill as you then had to actually manually check it as well.
> > > > But hey, it's your cpu cycles to burn, not mine...
> >
> > I prefer reviewing the code instead of writing/massaging all of it, and on success have the change
> > tested/validated automatically before I reviewing.
> >
> > >
> > >
> > > Again, total overkill, 1 minute doing a simple git merge resolution
> > > would have done the same thing, right?
> >
> 
> 1 minute is a lot of time when multiplied by the number of "almost
> cleanly applied"
> backports ;)

In that 1 minute you will "know" you got it right.  Otherwise you will
have to spend more than 1 minute reviewing the result of an automated
too.

Again, your waste of cpu cycles and review cycles, not mine :)

have fun!

greg k-h

