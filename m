Return-Path: <stable+bounces-230528-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFYNANeTxWmq/gQAu9opvQ
	(envelope-from <stable+bounces-230528-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 21:15:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5283333B4F4
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 21:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C53C301B708
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 20:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E433976BB;
	Thu, 26 Mar 2026 20:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Kc48d92s"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63F530B529
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 20:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774555754; cv=none; b=qqAkf6XQw+WzaAkayQdC+rXbBtGmIwvkpqYvzh/kyFBIdRNRybvJqhUCcmDZllPjSDfMtWPI0BmE5wU9EjOGEMhLmn1LGEU9rcy6hZ8DwA1YwJoaEIOG7ZYvAwfMt9iMXPK2+uD+v8F+zBfHv3JXIZXakFkLiur/GiCOGe9TnYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774555754; c=relaxed/simple;
	bh=O08vcziHn5E/h2BMlzMYY1qPElNvRHUnS23RXL/skmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULZC0aYLCOFWOJq8PkKIk4umcniwDc0nCyB6H5ShHdaxnKxEHupAZZrB097G70YLNrictMcw5sRDlB3jcq2g73Ln+A1fXonQ7M8RioDI3MXso9HCXN/ux/JwO3qmhqLTXGutCKOgFYZKyxBbqGSB4AVZ6msrc3PDGNJnPKiqCog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Kc48d92s; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506aa68065eso12175421cf.1
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 13:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774555752; x=1775160552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ayPORQNh1ZJY3KlTlGuZGlkLSPgnYGKfyoymf89E6/4=;
        b=Kc48d92sYkZTDcy3q456P/xVKGZKfA+xGg9I3vp5GdwK1XMkyfImia/fj+MKEzXqbF
         q2axkF89HT19f8vU7LNkpLQpQb16ugZSjak+YnbD4nIa0+D875N3uDzDseWjAMYqdWah
         LGybVxUIuwAFJuogmP1Y+kysMd0V/tk61Y2rDYFx5RE4DYKQcjMbCbm1bQe6TAOjkT7o
         no05AXru9n5PowsiKvzdQ0T7PNkEeJ+u7kUaePuo//Frmxw4Qz5DFxFbDtAqQ6Mp9y64
         8w4y8kw3v39M66KRg43KZVntwGWZzYcIvFP9nLUKH/0t4LwwExH2l49oKSjjaG7K5dmG
         W6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774555752; x=1775160552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayPORQNh1ZJY3KlTlGuZGlkLSPgnYGKfyoymf89E6/4=;
        b=bb5HK5QRFC6l7zki3XB5zWpAKBjQZv6lNlh79KpnmTAPgoC3qtAKS6wsXCpKAleUr6
         eNsqaSmJ1vaBf8h6vEqCNAyoWUg9cxqjAe8638454vNn04Z+/4wL2Xr+K/ntU2ujlKFe
         oH6atUa62eLpMNhlAUQAbKWMgqmVsV53sr7OrHcSEytsRvCLhDopiQjcXoMW6uRdHTpR
         d+2ZamSodmwKaGMsgsucorqWCx5HDE1KnpVEuAEv/RWkYfsw6E6GbS42XxGzGjaIC4Uy
         +aZxTaSc9rUYQ/j91qybfa8+3N03xKUavwQm3RBJkC4L0D4rnS/mL3hpq4vlzhpcyi1G
         eXPA==
X-Forwarded-Encrypted: i=1; AJvYcCVDqN23bq5yeP6Av3ROlDMEio7SMNklSRrStTh1K64JeCCO6fKRP9agldNsRS/wLChMJN9e+9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+wGgB5Zrj/jgZBkQ95RIRFw9eTS3GXJOLT/HrJeB2EnCJqQhA
	g4nKjVyAwu00bbIX5fBnftqBV91E8Ggehak2IAKr8Is64P3T3shfWvShvZDe32YNfbk=
X-Gm-Gg: ATEYQzyuDiZq0Z4++mZCPFoP6MCYi7IfVUMGfuatKy9/5VmTv+OPvH2XQYsgt4pS4Ad
	BW3ybZ29BcK43iKAINcXpQQ65P+IPpkqPoY6FhokLuIPgH7raVJ1Nvoqy1OHglaMEBJd6OllgTa
	zVRiqGihzp4F7XSvUCT90PYYVsY8Px7BlN+6ImDPPyfDvDWxaql89mM9UA32T+/sWY46Ll8g5wd
	AI73aw7AWdySQm+5trHgpExQeGqvyiTBR7rVTBTHShBzNX5nkrXaby1rgQB5Q4LBDjZIkdW96rO
	L4g1k1IcjSE5L9I1CqfGDdytEfLuELkJ1Y/YUue9ZRQweqMj3XgPj0h7c7toBtBjAHpHqdAv9PN
	sRV6+hAdxkQz0l6ixci5Oon7JhOdIv95M44xHwg3oxalrEM+L9Cfpw4i5LxQdg3q/EbHTk6PG9x
	7uqXIqdDMc8CFrgVZOeMkLluD5RSthhdU=
X-Received: by 2002:a05:622a:20c:b0:50b:4778:ac60 with SMTP id d75a77b69052e-50b80cd380fmr124966951cf.10.1774555751762;
        Thu, 26 Mar 2026 13:09:11 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:500::2:e5e8])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b9237a40asm31637111cf.21.2026.03.26.13.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 13:09:11 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:09:09 -0500
From: Gregory Price <gourry@gourry.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hughd@google.com,
	david@kernel.org, ljs@kernel.org, Liam.Howlett@oracle.com,
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/shmem: use invalidate_lock to fix hole-punch race
Message-ID: <acWSZZ1MPGZi6PH8@gourry-fedora-PF4VCD3F>
References: <20260326162611.693539-1-gourry@gourry.net>
 <acWHMQ2MPFjOSq5T@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acWHMQ2MPFjOSq5T@casper.infradead.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230528-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gourry.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5283333B4F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 07:21:21PM +0000, Matthew Wilcox wrote:
> On Thu, Mar 26, 2026 at 11:26:11AM -0500, Gregory Price wrote:
> > This also requires removing the rcu_read_lock() from
> > do_fault_around() so that .map_pages may use sleeping locks.
> 
> NACK.
> 
> ->map_pages() is called when VM asks to map easy accessible pages.
> Filesystem should find and map pages associated with offsets from "start_pgoff"
> till "end_pgoff". ->map_pages() is called with the RCU lock held and must
> not block.  If it's not possible to reach a page without blocking,
> filesystem should skip it. Filesystem should use set_pte_range() to setup
> page table entry. Pointer to entry associated with the page is passed in
> "pte" field in vm_fault structure. Pointers to entries for other offsets
> should be calculated relative to "pte".
> 

Hm, I follow. I was originally thinking this was scoping issue given
we take the rcu_read_lock shortly after the call anyway, but I see.

If the invalidate lock ends up being needed then i could leave rcu
and just use trylock/fallback to fault.

But I need to test a few things, nothing else protects filemap_map_pages
with the invalidate lock at the moment but only shmem appears broken.

~Gregory

