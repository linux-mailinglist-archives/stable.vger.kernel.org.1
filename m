Return-Path: <stable+bounces-176952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827C1B3F98E
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 11:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0C22C2299
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 09:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0C02EAB68;
	Tue,  2 Sep 2025 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CWAFg5L6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F552EA743
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 09:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803769; cv=none; b=ngl+ksqnfjh0EwTMzDNsflSUEmKigkjPkD/JMd7N/CZq5LPub+pO9R4AN1b5jBaNbt01VODG2cNlqh7UeNRY/oTVnB4RL0m+9NQ/lqwFqBGmuiuoK2SbSniYVSJ3gD7zy6M1Bo16n7g2P9zVFSdVySjZ8UMk8dUYNQcnTT3hVFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803769; c=relaxed/simple;
	bh=+gSowKHeNCRLIsDVGJ8OfzuMK2bLrYmJfY/EUW2W27A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOsd+jPKFoCrygXn6KvGJngb2ufYX6nR2itl0fPOgvYzV7JUkAqXdD48VRW1OveJyJAbta5JXpojlcz8rfJcaFsevFrv3vYD4BNgCyJ14nbV2U3h+/4PHiF+k4AQvNhqtjPbnlm8P0JwdJwapW+Q3seEsy2QwZdGo2R1bO59rRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CWAFg5L6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A7AC4CEED;
	Tue,  2 Sep 2025 09:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756803768;
	bh=+gSowKHeNCRLIsDVGJ8OfzuMK2bLrYmJfY/EUW2W27A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CWAFg5L6oyc4ig/XBM9D4JtBfvaLzq6v7Hcm5nLHPo5QLUJf8tz14zl9oaFj4dRf1
	 i527f5HQrNZ9gwmNNLWBKqWWuG/TQHzT/q0igKTFIKTW2yZf9sY0DS6vZfIaueO/Vh
	 bTc+k/z7n+jPlhtVkImNI25WtrJsiT+j6KddJd6k=
Date: Tue, 2 Sep 2025 11:02:45 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Manthey, Norbert" <nmanthey@amazon.de>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com" <syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com>,
	"amir73il@gmail.com" <amir73il@gmail.com>,
	"dima@arista.com" <dima@arista.com>,
	"Yagmurlu, Oemer Erdinc" <oeygmrl@amazon.de>
Subject: Re: [PATCH 6.1.y 1/1] fs: relax assertions on failure to encode file
 handles
Message-ID: <2025090200-uniquely-pumice-1afa@gregkh>
References: <2025011112-racing-handbrake-a317@gregkh>
 <20250901153559.14799-1-nmanthey@amazon.de>
 <20250901153559.14799-2-nmanthey@amazon.de>
 <2025090114-bodacious-daffodil-2f2e@gregkh>
 <2025090116-repent-living-b7de@gregkh>
 <ac90cc6067bc7a50d7eb0d606b3dc3718f35b9d9.camel@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac90cc6067bc7a50d7eb0d606b3dc3718f35b9d9.camel@amazon.de>

On Tue, Sep 02, 2025 at 07:20:46AM +0000, Manthey, Norbert wrote:
> On Mon, 2025-09-01 at 22:00 +0200, Greg Kroah-Hartman wrote:
> > CAUTION: This email originated from outside of the organization. Do not click links or open
> > attachments unless you can confirm the sender and know the content is safe.
> > 
> > 
> > 
> > On Mon, Sep 01, 2025 at 09:54:03PM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Sep 01, 2025 at 03:35:59PM +0000, Norbert Manthey wrote:
> > > > From: Amir Goldstein <amir73il@gmail.com>
> > > > 
> > > > commit 974e3fe0ac61de85015bbe5a4990cf4127b304b2 upstream.
> > > > 
> > > > Encoding file handles is usually performed by a filesystem >encode_fh()
> > > > method that may fail for various reasons.
> > > > 
> > > > The legacy users of exportfs_encode_fh(), namely, nfsd and
> > > > name_to_handle_at(2) syscall are ready to cope with the possibility
> > > > of failure to encode a file handle.
> > > > 
> > > > There are a few other users of exportfs_encode_{fh,fid}() that
> > > > currently have a WARN_ON() assertion when ->encode_fh() fails.
> > > > Relax those assertions because they are wrong.
> > > > 
> > > > The second linked bug report states commit 16aac5ad1fa9 ("ovl: support
> > > > encoding non-decodable file handles") in v6.6 as the regressing commit,
> > > > but this is not accurate.
> > > > 
> > > > The aforementioned commit only increases the chances of the assertion
> > > > and allows triggering the assertion with the reproducer using overlayfs,
> > > > inotify and drop_caches.
> > > > 
> > > > Triggering this assertion was always possible with other filesystems and
> > > > other reasons of ->encode_fh() failures and more particularly, it was
> > > > also possible with the exact same reproducer using overlayfs that is
> > > > mounted with options index=on,nfs_export=on also on kernels < v6.6.
> > > > Therefore, I am not listing the aforementioned commit as a Fixes commit.
> > > > 
> > > > Backport hint: this patch will have a trivial conflict applying to
> > > > v6.6.y, and other trivial conflicts applying to stable kernels < v6.6.
> > > > 
> > > > Reported-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com
> > > > Tested-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com
> > > > Closes: https://lore.kernel.org/linux-unionfs/671fd40c.050a0220.4735a.024f.GAE@google.com/
> > > > Reported-by: Dmitry Safonov <dima@arista.com>
> > > > Closes: https://lore.kernel.org/linux-
> > > > fsdevel/CAGrbwDTLt6drB9eaUagnQVgdPBmhLfqqxAf3F+Juqy_o6oP8uw@mail.gmail.com/
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > Link: https://lore.kernel.org/r/20241219115301.465396-1-amir73il@gmail.com
> > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > 
> > > I never signed off on the original commit, so why was this added?
> 
> This cherry-pick is not for the upstream commit, but for the backport on the 6.6 tree. The
> respective commit hash is given in the backport line. Is this additional information you would like
> to have in the commit message?

You should be backporting the original commit (which is what you said
you did), and for that use the original signed-off-by lines.  Otherwise
adding mine here seems very odd as there is no "hint" anywhere that this
is what happened.




> 
> > > 
> > > > 
> > > > (fuzzy picked from commit f47c834a9131ae64bee3c462f4e610c67b0a000f)
> > > > Applied with LLM-adjusted hunks for 1 functions from us.amazon.nova
> > > > - Changed the function call from `exportfs_encode_fid` to `exportfs_encode_inode_fh` to match
> > > > the destination code.
> > 
> > Wait, that was just fuzz matching, the real body didn't even change.
> > 
> > > > - Removed the warning message as per the patch.
> > 
> > I do not understand this change, what exactly was this?
> 
> I need to rewrite (here: drop) this manually. The LLM was also describing the content of the
> original patch, not only the diff it created. 

I still do not understand, sorry.  What exactly should I do with this?

> > > Please put this in the proper place, and in the proper format, if you
> > > want to add "notes" to the backport.
> 
> IIUC, the changes applied to the patch so that it applies should come above my SOB, no? What's the
> format requirement (except the 80-100 char limit)?

See the many backported patches that have comments in the signed-off-by
area for where changes were made.  We have thousands of examples in the
tree and email archives today.

> I am aware of the discussions about AI generated code. I wanted to explicitly mention the AI use, if
> it was used as backporting helper. Do you suggest to still move this into the notes section of the
> commit and sent patch, instead of having this in the commit itself?

I have no objection for it being in the commit itself, just put it in a
way we can follow and that follows the ways others have done so in the
past.

And make it something that is useful.  That line up above about fuzz
makes no sense.

> > > But really, it took a LLM to determine an abi change?  That feels like
> > > total overkill as you then had to actually manually check it as well.
> > > But hey, it's your cpu cycles to burn, not mine...
> 
> I prefer reviewing the code instead of writing/massaging all of it, and on success have the change
> tested/validated automatically before I reviewing.

Sure, you do you :)

> > Again, total overkill, 1 minute doing a simple git merge resolution
> > would have done the same thing, right?
> 
> For this example, yes, I agree. There are more complex commits where this works as well.

Doing complex things for simple examples seems odd, I suggest you pick a
more complex example to show how it actually works well :)

> > confused as to why this took a whole new tool?  We have good merge
> > resolution tools for git these days, what's wrong with using one of the
> > many ones out there?
> 
> There is nothing wrong using any other tool. The git-llm-pick tool allows to automatically backport
> more commits and supports user specified validation for the changes. The LLM is only the last
> attempt. A human needs to review the output either way, and eventually do the
> backport interactively.

Yes they do, and hopefully you will actually measure your productivity
here to see if the LLM is helping you do more work or not :)

thanks,

greg k-h

