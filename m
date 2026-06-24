Return-Path: <stable+bounces-268165-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oNsELxndO2p3eQgAu9opvQ
	(envelope-from <stable+bounces-268165-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 15:35:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E926BEA74
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 15:35:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=gct7EzQR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268165-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268165-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADDCA302C78F
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 13:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953673B6C0E;
	Wed, 24 Jun 2026 13:34:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D7E368D5E;
	Wed, 24 Jun 2026 13:34:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782308083; cv=none; b=U7faW/3x0oZr7irdFMoB/GzXo6yh3XK6L6aZwC0ktP5KpbkazHDmKdsK89qpmOxOhQQehf1rBmGPlK0Raso/24FnWgZYQcB+aUX7W1kK14ycCMktlO3Tz35ofUrbqQzzu1Q34jJV2ndCuaEnagEud5kgo60QHWOiKi4YELZGabk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782308083; c=relaxed/simple;
	bh=ySTgdXSLxA68VjwcqL3JPNndsXFUYeV0caTDcUsSCBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkEuaNgzUBD92u5aZMXq0vTHgylEipVgphbpOaqRXaCSg0Rpz07ED7Mpfgt5flm5n5mrEawuQrhfzIbNn/wQIb42EQFuld6EPgDTK36BPDQ6+nlI9MTcjfA4cFqqpRc8fKT9+/eD3YtEMbx8YaAKVVy2NSYJQoo+AndU3tIIyDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gct7EzQR; arc=none smtp.client-ip=198.137.202.133
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=WnIbvnh3iSm52wFeB2rpH5sTTY+sTkta8vjSnNdSMJk=; b=gct7EzQRkOA+lmJ8C6JMtmipYW
	m86AxGSJHqWIFyXSiA6QvPytgC/XEKIyi0+SpxESW+nnmk7kxSYAk0t841uEhuSX6zDqOdSvQjGlG
	odylKrJcGOIKgguo2n9ongjsOyEWl4OItBrgl1PZ8NFzVB25Tw7ebpnCkofQrOp8DZQwOAvNt6QWF
	8kPLcphVqLs9hxpanXtsKxN3qm2djkm+LK7vwOCJWFefaBx6VON/juALMmQBMuMqrrXivg7/Ow+Uv
	TfYQnrwYBcHfffJaH1dNz+wNTz+eQT+tPMphVYiw4R/SP9UGDWjMFYbIx1KTWtcMTujZoFUwiwmH2
	s5jjBVbg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcNkT-00000007pWy-0VhN;
	Wed, 24 Jun 2026 13:34:37 +0000
Date: Wed, 24 Jun 2026 06:34:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Salvatore Dipietro <dipiets@amazon.it>
Cc: ritesh.list@gmail.com, willy@infradead.org, abuehaze@amazon.com,
	akpm@linux-foundation.org, alisaidi@amazon.com, blakgeof@amazon.com,
	brauner@kernel.org, dipietro.salvatore@gmail.com, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org,
	stable@vger.kernel.org, vbabka@suse.com
Subject: Re: [PATCH 1/1] iomap: avoid compaction for costly folio order
 allocation
Message-ID: <ajvc7fSDngyx0X5j@infradead.org>
References: <20260527162412.19922-1-dipiets@amazon.it>
 <20260624080639.17100-1-dipiets@amazon.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260624080639.17100-1-dipiets@amazon.it>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268165-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hch@infradead.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:dipiets@amazon.it,m:ritesh.list@gmail.com,m:willy@infradead.org,m:abuehaze@amazon.com,m:akpm@linux-foundation.org,m:alisaidi@amazon.com,m:blakgeof@amazon.com,m:brauner@kernel.org,m:dipietro.salvatore@gmail.com,m:djwong@kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-xfs@vger.kernel.org,m:stable@vger.kernel.org,m:vbabka@suse.com,m:riteshlist@gmail.com,m:dipietrosalvatore@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,infradead.org,amazon.com,linux-foundation.org,kernel.org,vger.kernel.org,kvack.org,suse.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:mid,infradead.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32E926BEA74

On Wed, Jun 24, 2026 at 08:06:36AM +0000, Salvatore Dipietro wrote:
> 
> Hi Ritesh, Matthew,
> 
> I wanted to kindly follow up on my summary from May 27th regarding the best path 
> forward for this patch.
> 
> To recap, we benchmarked all proposed variations and shared the results:
> 
> | Patch                          | Change Location        | Avg TPS    | % vs Baseline |
> |--------------------------------|------------------------|------------|:-------------:|
> | Baseline (no patch)            | —                      | 101,979.75 |       —       |
> | v1 (original, iomap caller)    | fs/iomap/buffered-io.c | 141,194.20 |    +38.45%    |
> | Ritesh's suggestion            | mm/filemap.c           | 139,200.61 |    +36.50%    |
> | Matthew's suggestion           | mm/filemap.c           | 143,863.82 |    +41.07%    |
> | kcompactd background           | mm/page_alloc.c        | 134,278.47 |    +31.67%    |
> 
> I'd really appreciate any guidance on which direction would be acceptable for a v3 — 
> whether that's the page allocator approach (kcompactd background), one of the filemap.c
> fixes, or something else entirely.

Do you have ointers to the patches for each approach above?

