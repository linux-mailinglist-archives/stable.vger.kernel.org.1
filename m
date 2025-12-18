Return-Path: <stable+bounces-202925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59763CCA3BA
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 05:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E735A3007C7F
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 04:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6478B27F017;
	Thu, 18 Dec 2025 04:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/pCWsH6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B793E2116F4
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 04:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766030614; cv=none; b=dzrR6Z4yFqBnQQmaixIP5vSnQyBCalKLSJzhOFthHNb7IoqMf8yLKiG6q0yg9xyR67cMPl5cu6X5TvMKtFK5cHn9rbJ3SHtuNQvq/p8jp/au+uRPUF0tnthVB48LWNOwfaNBjwRIGUYYeYHVwfsdEnMSG0GGjD6dBiXCavw2/QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766030614; c=relaxed/simple;
	bh=wipqmJTb3RPr4bYzc7MlLp/HKbCdY/GhUhkFh7D5GpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3FL5uXSZG8b+PZvKjauLoV68ds7JE/M18H1b6dAVti3cELIPuokp2mQE8wAfXdF539v/+9VWWhkTtLP4wSMC85a2UWs4sXvBdut1o7ivo7U3EK7lKqWWlayIiObx07Zrua+ix+1tqHA5kZmzZmbhzS0CPpNM09GDpwSgo38BB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/pCWsH6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0b4320665so2830255ad.1
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 20:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766030612; x=1766635412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aHI6rvtpgTrf2rQzMwqNIBav/7/ZYbn4AXdiKjSA/wA=;
        b=J/pCWsH6ZIeXwnyY/YhHAxwuz0uapGe68KJYNP9GFw+46jadqqOkN4C/0IqlddkpqN
         sqq60ApIy8TTkiPyDBVoeTR37fmrFajVv6AAWMzwKTYuudIKCZph+l2KvrJLhLolGrM9
         8ObryUBGx1e3xJytQjBpp9UXG4NsDMqgz/Ng/RLPZDq8NyyugpqdrRsAhxpo0qFcK0Eu
         4NKw6Qj9V4ynMr5f+YTXbuDghQtIX3YpCcuD89ticlqIrwACda7KlPNsdr0qbWCRKOGP
         F1IsCrcPo+oRT1WSDAiCTpW07ppOYhe6xqalY4p9NVgAYwQHQGtnUvh7ixe3nJPKpvDm
         zNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766030612; x=1766635412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHI6rvtpgTrf2rQzMwqNIBav/7/ZYbn4AXdiKjSA/wA=;
        b=gr8l2SkC6XVEicl7E+sLC41T8gcCHVcXoGFe6NYUtqd40s75CfRO3aDqFfJtinKF6k
         c6XZsAndcmU83kaAkiE1b3gDurS+GsMtgBMrzlRUO56g7Ok52eUHJqxkJMF39xhdnN7W
         MwS597MT7Zo2WU2gGSHR5jRwQ92zdTeC6bKMwovdkR1d/ZWEsBPOCf1ufo6KeAptLPVG
         PKqlbMQymTv9WuTSNXmQ7hGhlum2h0rfPAuo24cjqlRPdpi70vFlrcJ8drnx42B6G+yy
         rL7GjHgi08ZxAIQu9Ve5u2BY6H2uTC0fvZFNH3DjTHj34N9Ud/QA/fAadgPb+q37f5hc
         xS6A==
X-Forwarded-Encrypted: i=1; AJvYcCVARmJd70AQkgI+gAt9ZIZum8Z9YWa14wq8MHmupR8+d628p8v9Lj0bMnpSgUCQkbtJGF5a1l0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjZoiSZ5zQxL/k00dV4eLgFxWs39SZ+Mz448aVNOFnxlMCoGsN
	JMFVxxw8yw2jayU1uySKTTezDLsMoggeCH4pj0v9v1w7tCkqEUiSgE1z
X-Gm-Gg: AY/fxX7/a416JkGP4i29qw5hcqIZ9r7LWLMuJqzzDAMlWwg7q7Zu5fPE8PI1N5Lt7Cm
	XfR4erMVnYMaEtrOqUsU2SCnqEKY6Uyjh/q3jrdMzPqCbQfP/REGQpUOuJkWv1Lzzw8D9JtERaU
	haeL9QNFWnRuNovUszDMjQwzU7zw2WgFNS4Kbpl3xKdNxJN33K/dpIZfd9vy+b2/LZYYfa2t3ye
	WNwBGnw3SgOKKuqgvHZSRU0Ju3+UbQBn55H8yT7LYFCZrgLuoaRs6mm3h3a6vOrGwgDYixKaalJ
	n6j8YaGNB45ins2GTF52AxhQnZoTgy+SAgSC5XWJTlbs6NcLXjf/ok6vWTiiBYdazBwgiRI+2+I
	rJtbxE9q+wOmVhG8kPfDEXRe1kcwa2JPgjKUo7pHXhosDFAwxrxaPCRHVTXvpWwtCcE0zn5wdMs
	VC1nE=
X-Google-Smtp-Source: AGHT+IHa7r0mYrLhWHjYQHKjTjGzpva8/SmCDywQMnfbi/eRtfbpSa8NAyazhiN4pJFcNwjNZ5uZlg==
X-Received: by 2002:a17:903:11c8:b0:2a1:388c:ca5b with SMTP id d9443c01a7336-2a1388cced6mr90213585ad.39.1766030611814;
        Wed, 17 Dec 2025 20:03:31 -0800 (PST)
Received: from localhost ([2a12:a304:100::105b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d087c690sm8680035ad.20.2025.12.17.20.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 20:03:31 -0800 (PST)
Date: Thu, 18 Dec 2025 12:03:28 +0800
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
Message-ID: <aUN9BFdxHQj8ThMS@ndev>
References: <20251215141936.1045907-1-wangjinchao600@gmail.com>
 <aUAZn1ituYtbCEdd@casper.infradead.org>
 <aUC32PJZWFayGO-X@ndev>
 <aUDG_vVdM03PyVYs@casper.infradead.org>
 <aUDOCPDa-FURkeob@ndev>
 <aUDXrYgwZAMYkXVu@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUDXrYgwZAMYkXVu@casper.infradead.org>

On Tue, Dec 16, 2025 at 03:53:17AM +0000, Matthew Wilcox wrote:
> On Tue, Dec 16, 2025 at 11:12:21AM +0800, Jinchao Wang wrote:
> > On Tue, Dec 16, 2025 at 02:42:06AM +0000, Matthew Wilcox wrote:
> > > On Tue, Dec 16, 2025 at 09:37:51AM +0800, Jinchao Wang wrote:
> > > > On Mon, Dec 15, 2025 at 02:22:23PM +0000, Matthew Wilcox wrote:
> > > > > On Mon, Dec 15, 2025 at 10:19:00PM +0800, Jinchao Wang wrote:
> > > > > > page_cache_ra_order() and page_cache_ra_unbounded() read mapping minimum folio
> > > > > > constraints before taking the invalidate lock, allowing concurrent changes to
> > > > > > violate page cache invariants.
> > > > > > 
> > > > > > Move the lookups under filemap_invalidate_lock_shared() to ensure readahead
> > > > > > allocations respect the mapping constraints.
> > > > > 
> > > > > Why are the mapping folio size constraints being changed?  They're
> > > > > supposed to be set at inode instantiation and then never changed.
> > > > 
> > > > They can change after instantiation for block devices. In the syzbot repro:
> > > >   blkdev_ioctl() -> blkdev_bszset() -> set_blocksize() ->
> > > >   mapping_set_folio_min_order()
> > > 
> > > Oh, this is just syzbot doing stupid things.  We should probably make
> > > blkdev_bszset() fail if somebody else has an fd open.
> > 
> > Thanks, that makes sense.
> > Tightening blkdev_bszset() would avoid the race entirely.
> > This change is meant as a defensive fix to prevent BUGs.
> 
> Yes, but the point is that there's a lot of code which relies on
> the AS_FOLIO bits not changing in the middle.  Syzbot found one of them,
> but there are others.

I've been thinking about this more, and I wanted to share another
perspective if that's okay.

Rather than tracking down every place that might change AS_FOLIO bits
(like blkdev_bszset() and potentially others), what if we make the
page cache layer itself robust against such changes?

The invalidate_lock was introduced for exactly this kind of protection
(commit 730633f0b7f9: "mm: Protect operations adding pages to page
cache with invalidate_lock"). This way, the page cache doesn't need
to rely on assumptions about what upper layers might do.

The readahead functions already hold filemap_invalidate_lock_shared(),
so moving the constraint reads under the lock adds no overhead. It
would protect against AS_FOLIO changes regardless of their source.

I think this separates concerns nicely: upper layers can change
constraints through the invalidate_lock protocol, and page cache
operations are automatically safe. But I'd really value your thoughts
on this approach - you have much more experience with these tradeoffs
than I do.

Thanks again for taking the time to discuss this.

