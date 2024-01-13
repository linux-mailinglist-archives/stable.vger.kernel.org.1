Return-Path: <stable+bounces-10826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F67682CE62
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 21:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF5028399E
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 20:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276F86AC0;
	Sat, 13 Jan 2024 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9Im5Go1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11EB6AA6
	for <stable@vger.kernel.org>; Sat, 13 Jan 2024 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e69b31365so10742845e9.0
        for <stable@vger.kernel.org>; Sat, 13 Jan 2024 12:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705177487; x=1705782287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cKEq8xL6hjiRfQkJvWxWBqnYfOkhF+HaDfsjTwVFzGo=;
        b=a9Im5Go1Jmyrkp6RPWTR0OnnM4VQt6JpPn/ud7JV0d2gRxC12r818LpXCFcVhEwdTZ
         5ol/9XAR+gH9fXbeCFwxz7Ealae2L3s4WEWQ8HPvge794HK1YBHCcbNwfzivLGmwEaQO
         M+gS34qEpvkSOdpUJPQD8Jj7CRH2p/NQtV+gylusc4DE68WGte8VY5/2NkZjk01r2Scg
         WdZkEs99ouc8SjIXUycGh5qoNxNRvbUWk+AxfOigtPirml2v8T/ytnqaE96hMh+FYBRq
         NDgsl3crgPsxHE+VUtF/et3YO5ENueZmaDkhNZZk2xZ00JJOM9wOU9hA9dSKgYdKtQkr
         8YQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705177487; x=1705782287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKEq8xL6hjiRfQkJvWxWBqnYfOkhF+HaDfsjTwVFzGo=;
        b=G4/zJmPvv2QXzk53cQgYAK3ZnPexlbzJOHGNvKw0AAVKlHzvH96dOPSko6Ung49Or4
         9VTefNrdqSRmnuu5ATL+RHNmsCbyTeG4MHHPN95NrQ9LoOYmBb7736Dh+80SP3hk+64P
         I0flJbwTqXb0VxhJgKSzVw1AkmhIZ1ab3n2x2+V4WdEgntHz4Pu2+ZmVTRcwiXUXD7EQ
         Sp0DdixYWhx2xHNvxTVd9QOexhNisZOlECy7RmqBgUi7oeJieWPUYqkjXzoAsbZ486th
         AKt/B8/D+ZrNQPRQUs/AYSgiq/OU2a5xcXfOhz4VPYO6R8EHzl1tteGXCV8C55GTc+Yn
         DkkA==
X-Gm-Message-State: AOJu0YxcsaUivi+TocmVFtcuzf+2RcEnfTGTJl1DxDeITjH79/1FIcu4
	wz9NGs8GEjzaogmYMK8L4y0=
X-Google-Smtp-Source: AGHT+IG0sf8/ujoTWS7Y2SB8Ls44pQqw2T4a4xp/I7KtzrSiYqoH6B0v9j4B7OzANTeXBZo+2iQijw==
X-Received: by 2002:a05:600c:754:b0:40d:8557:8d85 with SMTP id j20-20020a05600c075400b0040d85578d85mr1781839wmn.80.1705177486961;
        Sat, 13 Jan 2024 12:24:46 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id c8-20020a05600c0a4800b0040e4746d80fsm10396845wmq.19.2024.01.13.12.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 12:24:46 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id A4471BE2DE0; Sat, 13 Jan 2024 21:24:45 +0100 (CET)
Date: Sat, 13 Jan 2024 21:24:45 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH 6.1 1/4] cifs: fix flushing folio regression for 6.1
 backport
Message-ID: <ZaLxjaye2GcRlok2@eldamar.lan>
References: <20240113094204.017594027@linuxfoundation.org>
 <20240113094204.068608649@linuxfoundation.org>
 <ZaLt0qdHACUjlyOv@eldamar.lan>
 <2024011336-oppressor-ocean-17c2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024011336-oppressor-ocean-17c2@gregkh>

Hi Greg,

On Sat, Jan 13, 2024 at 09:19:46PM +0100, Greg Kroah-Hartman wrote:
> On Sat, Jan 13, 2024 at 09:08:50PM +0100, Salvatore Bonaccorso wrote:
> > Hi Greg,
> > 
> > On Sat, Jan 13, 2024 at 10:50:39AM +0100, Greg Kroah-Hartman wrote:
> > > 6.1-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > filemap_get_folio works differenty in 6.1 vs. later kernels
> > > (returning NULL in 6.1 instead of an error).  Add
> > > this minor correction which addresses the regression in the patch:
> > >   cifs: Fix flushing, invalidation and file size with copy_file_range()
> > > 
> > > Suggested-by: David Howells <dhowells@redhat.com>
> > > Reported-by: Salvatore Bonaccorso <carnil@debian.org>
> > > Signed-off-by: Steve French <stfrench@microsoft.com>
> > > Tested-by: Salvatore Bonaccorso <carnil@debian.org>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  fs/smb/client/cifsfs.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > --- a/fs/smb/client/cifsfs.c
> > > +++ b/fs/smb/client/cifsfs.c
> > > @@ -1240,7 +1240,7 @@ static int cifs_flush_folio(struct inode
> > >  	int rc = 0;
> > >  
> > >  	folio = filemap_get_folio(inode->i_mapping, index);
> > > -	if (IS_ERR(folio))
> > > +	if ((!folio) || (IS_ERR(folio)))
> > >  		return 0;
> > >  
> > >  	size = folio_size(folio);
> > 
> > Note, this one needs to be revisited:
> > 
> > https://lore.kernel.org/stable/ZaLNlyo8cDCpATPm@casper.infradead.org/T/#md6a3f0beceaa886ca0d1e4a47ff5a575340d7e8f
> 
> I see that, thanks, I'll go fix this up.

Thanks!

Please note, the metadata for the commit needs as well some fixup: The
actual first reporter was here:

https://lore.kernel.org/stable/ZZhrpNJ3zxMR8wcU@eldamar.lan/raw

and was "Jitindar Singh, Suraj" <surajjs@amazon.com>. I only reported
it as regression from the Debian perspective following up on Jitindar
Singh, Suraj first reporting.

Sorry did not spotted earlier that reported-by was missing in the
above.

Thanks for all the work of the involved people.

Regards,
Salvatore

