Return-Path: <stable+bounces-201131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A641ECC0B15
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 04:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DB5030281A0
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 03:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FE82E175F;
	Tue, 16 Dec 2025 03:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOFBuCyj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4590130AAC0
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 03:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765854747; cv=none; b=Qa3mgeSP1Gh2lN4/2VuaNOgpWAuHmzLVGHdNiJRHUcQ5iwCuu0cfu7bdWJaC9WnJy9aWBKUcBewDot5ctDp8hQf0nalNbmlemdRSc4fUk0STGzS5ZpSNkdPixawwkNpz17vekmlitLih9hezAjl6wDTt1W7CrGtGBv5URcVQFnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765854747; c=relaxed/simple;
	bh=MHj5eMaKpbXLESG/oNUTKn3hO7O7opkUhpED1G1y26E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmN9v1rU2wRcYthfbP9eMBwZGuE+bUHjpl9tnX0owHqVz6zeBppjdieb77IYYtAiYBh3VtsU6tfr0FQOkglc+y5z7nyUeUhLBGszQfHLMQVw7YbGUSvfImlhZUqH4ygxyTgsNY+1+QYz7uoEql9234iEhWhTj4md73vvdk4Caec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOFBuCyj; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7f0da2dfeaeso4158263b3a.1
        for <stable@vger.kernel.org>; Mon, 15 Dec 2025 19:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765854745; x=1766459545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v1XTKIE7lS6ISh9SSrfsgd7hwp0qO7clmkEC+ykt48o=;
        b=AOFBuCyj5biOosYWEPnJZmYqmDNs/s4hEc8ENSzZJM6QjNPTyOKpB/75Onk+oNaLlZ
         tQxfk89kAQgkNSxUtrkBgHZ3O2x3+w29YQTDTM92xEgDMPbtBytuX/m2VpkjBlV+raqA
         5oMfy/dlcGuGW7xk6hu7I1gPBzhuNEpZP0+JQSr5JyiSbGX/to4lTAFW0SYQrGSbOkyh
         AuG2PVToLgtczCi/sAONDEaJOMzR5LCFYoFJkQzgWemSiRZkCdACniI63GmTGOIKMc4m
         x8jcOIyjj7a5NARv2pHmMEBnKtx1hKeNmUZwQl7kTgSL+7RSmt44QVNCK3BLLjQYw326
         7oTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765854745; x=1766459545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1XTKIE7lS6ISh9SSrfsgd7hwp0qO7clmkEC+ykt48o=;
        b=jWC9YpmcJSAHjyJ7vIMRQFiwupH0trIWrqi5ZlkRsZxNituzLZnAQHilPGbc/0aMEh
         qmrX0l51CSmAmY8PAwNGzvTbRDRSKkLxGL0jGYkoKtQe4084IriokcEusBJNcHqmWfba
         cOAkSuWsJVAQ4xr+sjRmjhAPL5Q1LrH2HlQq3iM5YLth0TNbT5sG1QeGxyrZ7jXlkbCx
         oEoMI+WhvPdii61pNhaWZMaBQmhv/+4bxRCShFtXLDqKEhj33GRqBJhXUrmg6rCYJ8IB
         5ihorsyk0XzKFW3P7sOcaQV35OgW0Xczo+flrL4x5u7IC+oT+jhjEDGSuo/4FbkWgqlf
         NIAA==
X-Forwarded-Encrypted: i=1; AJvYcCXRgha5nZrI/D1eUOm//nmbzR/KtppGLHDhEQGwBEKPJwp1y7UcMBwJY9VRWF2fyBaWXh7co88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjA+8vukMOWRa9lEM71ZLkY78N6gpUqhrSHELjF/Sb+EbNSsur
	nSzvw2E5xCosN/Bvy4np6a1Jo1DkMrxGyMojMwJ9rcMnGG3ym04SD4A+
X-Gm-Gg: AY/fxX5y9noN9x4rRF14l5UqPREyXH6/Jip40ItqEYcS+8+lo9uM0HE9r3D5xFIxGqa
	yid3Xiq1PTwQvPnDZlr3yBqf1BXfANJOE8BazODTD4BGbr6XNL/XLTnPb+o5IwjNHmXHq4JShFM
	rzsawqoUp1PAorv6pCCtYeTwFULIHq0LNzokFPYQdo5wb7iOZHPPfZqnc1VTPEvotpKjxsxh/mi
	Iae75+6t7iLC+MJK7KeRcFR4UXDGqxAL8S9eOJeSAaZag9FnwXga/NHM10M8UWLemYZTSQdBWgn
	n8/NMuwlv6tGcrUc0aGKjubX9MsJ4na99aih7Qe5sebEjItc/BNc+0l4kf0Ui7EYDGGiBPYBoVN
	4zK8O5Vn6a0tVvFKDlEKwvCuQuHXWrE261iWweJrUV8uWso1BGkmGwV3TjgRavFwD2JAMyQ9NK8
	mxMH4=
X-Google-Smtp-Source: AGHT+IF0tz0zYbc0FACU6KRTQzZw3IhUO2xklXRdt4pY23/rn5onAkq4lgOwW+t2ZMZ15thjO9SINg==
X-Received: by 2002:a05:6a00:288e:b0:7e8:43f5:bd2c with SMTP id d2e1a72fcca58-7f669c8add9mr10107967b3a.65.1765854745459;
        Mon, 15 Dec 2025 19:12:25 -0800 (PST)
Received: from localhost ([2a12:a304:100::105b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c585cde0sm13791160b3a.69.2025.12.15.19.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 19:12:24 -0800 (PST)
Date: Tue, 16 Dec 2025 11:12:21 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+4d3cc33ef7a77041efa6@syzkaller.appspotmail.com,
	syzbot+fdba5cca73fee92c69d6@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/readahead: read min folio constraints under
 invalidate lock
Message-ID: <aUDOCPDa-FURkeob@ndev>
References: <20251215141936.1045907-1-wangjinchao600@gmail.com>
 <aUAZn1ituYtbCEdd@casper.infradead.org>
 <aUC32PJZWFayGO-X@ndev>
 <aUDG_vVdM03PyVYs@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUDG_vVdM03PyVYs@casper.infradead.org>

On Tue, Dec 16, 2025 at 02:42:06AM +0000, Matthew Wilcox wrote:
> On Tue, Dec 16, 2025 at 09:37:51AM +0800, Jinchao Wang wrote:
> > On Mon, Dec 15, 2025 at 02:22:23PM +0000, Matthew Wilcox wrote:
> > > On Mon, Dec 15, 2025 at 10:19:00PM +0800, Jinchao Wang wrote:
> > > > page_cache_ra_order() and page_cache_ra_unbounded() read mapping minimum folio
> > > > constraints before taking the invalidate lock, allowing concurrent changes to
> > > > violate page cache invariants.
> > > > 
> > > > Move the lookups under filemap_invalidate_lock_shared() to ensure readahead
> > > > allocations respect the mapping constraints.
> > > 
> > > Why are the mapping folio size constraints being changed?  They're
> > > supposed to be set at inode instantiation and then never changed.
> > 
> > They can change after instantiation for block devices. In the syzbot repro:
> >   blkdev_ioctl() -> blkdev_bszset() -> set_blocksize() ->
> >   mapping_set_folio_min_order()
> 
> Oh, this is just syzbot doing stupid things.  We should probably make
> blkdev_bszset() fail if somebody else has an fd open.

Thanks, that makes sense.
Tightening blkdev_bszset() would avoid the race entirely.
This change is meant as a defensive fix to prevent BUGs.

