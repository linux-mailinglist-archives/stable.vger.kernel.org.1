Return-Path: <stable+bounces-10828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6CA82CE67
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 21:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2EBB1C2105C
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 20:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A236AB6;
	Sat, 13 Jan 2024 20:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fmVbJOuT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F9F168A3;
	Sat, 13 Jan 2024 20:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0BBC433F1;
	Sat, 13 Jan 2024 20:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705178353;
	bh=5ZFcxQ0f8lZVgR8idKLkwLj/YKjuub5Y9EYeRGnr5/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fmVbJOuTbK/kUFFLgamKPN04LSfc0urlYNPzDqkrIxx2WwysPTE0q4vwVO9iTj8Sy
	 Qjy204PENFadBvI9Ye3WPoSzPGeK+Q7yFx+1AqclVw6qtl6FJRP9Bsr5mai6W+8Yvl
	 XiRkv2fm0lH5C5u2qPoh84c6vfbMYkoDe8f5ua0k=
Date: Sat, 13 Jan 2024 21:39:08 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH 6.1 1/4] cifs: fix flushing folio regression for 6.1
 backport
Message-ID: <2024011345-strangle-upright-3d3c@gregkh>
References: <20240113094204.017594027@linuxfoundation.org>
 <20240113094204.068608649@linuxfoundation.org>
 <ZaLt0qdHACUjlyOv@eldamar.lan>
 <2024011336-oppressor-ocean-17c2@gregkh>
 <ZaLxjaye2GcRlok2@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaLxjaye2GcRlok2@eldamar.lan>

On Sat, Jan 13, 2024 at 09:24:45PM +0100, Salvatore Bonaccorso wrote:
> Hi Greg,
> 
> On Sat, Jan 13, 2024 at 09:19:46PM +0100, Greg Kroah-Hartman wrote:
> > On Sat, Jan 13, 2024 at 09:08:50PM +0100, Salvatore Bonaccorso wrote:
> > > Hi Greg,
> > > 
> > > On Sat, Jan 13, 2024 at 10:50:39AM +0100, Greg Kroah-Hartman wrote:
> > > > 6.1-stable review patch.  If anyone has any objections, please let me know.
> > > > 
> > > > ------------------
> > > > 
> > > > filemap_get_folio works differenty in 6.1 vs. later kernels
> > > > (returning NULL in 6.1 instead of an error).  Add
> > > > this minor correction which addresses the regression in the patch:
> > > >   cifs: Fix flushing, invalidation and file size with copy_file_range()
> > > > 
> > > > Suggested-by: David Howells <dhowells@redhat.com>
> > > > Reported-by: Salvatore Bonaccorso <carnil@debian.org>
> > > > Signed-off-by: Steve French <stfrench@microsoft.com>
> > > > Tested-by: Salvatore Bonaccorso <carnil@debian.org>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > ---
> > > >  fs/smb/client/cifsfs.c |    2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > --- a/fs/smb/client/cifsfs.c
> > > > +++ b/fs/smb/client/cifsfs.c
> > > > @@ -1240,7 +1240,7 @@ static int cifs_flush_folio(struct inode
> > > >  	int rc = 0;
> > > >  
> > > >  	folio = filemap_get_folio(inode->i_mapping, index);
> > > > -	if (IS_ERR(folio))
> > > > +	if ((!folio) || (IS_ERR(folio)))
> > > >  		return 0;
> > > >  
> > > >  	size = folio_size(folio);
> > > 
> > > Note, this one needs to be revisited:
> > > 
> > > https://lore.kernel.org/stable/ZaLNlyo8cDCpATPm@casper.infradead.org/T/#md6a3f0beceaa886ca0d1e4a47ff5a575340d7e8f
> > 
> > I see that, thanks, I'll go fix this up.
> 
> Thanks!
> 
> Please note, the metadata for the commit needs as well some fixup: The
> actual first reporter was here:
> 
> https://lore.kernel.org/stable/ZZhrpNJ3zxMR8wcU@eldamar.lan/raw
> 
> and was "Jitindar Singh, Suraj" <surajjs@amazon.com>. I only reported
> it as regression from the Debian perspective following up on Jitindar
> Singh, Suraj first reporting.
> 
> Sorry did not spotted earlier that reported-by was missing in the
> above.

Added that, and found the original link of the issue reported here and
added that to the commit.

thanks,

greg k-h

