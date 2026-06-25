Return-Path: <stable+bounces-268374-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TBy2KugbPWqPxAgAu9opvQ
	(envelope-from <stable+bounces-268374-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 14:15:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D88E6C5773
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 14:15:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=CRXNOXrV;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268374-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-268374-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E0AE303E111
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 12:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223363DFC7E;
	Thu, 25 Jun 2026 12:12:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AAC329E46;
	Thu, 25 Jun 2026 12:12:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389521; cv=none; b=EQu8LeGmbkYCxQx9NkKechh1zb1tcnDqw7coRbzgGvVg1DJnQmMKoyJlcduypTgBnbDjDJqE/4k+wyKnl0JfQ8DGD+aqwmspJbHinCPuJdn0jG0V3u59GPG66pNv+Ar4AUa5NgZwtBMQ21WDOC5MKM/tGMoJzEt0/PYZSMIt2mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389521; c=relaxed/simple;
	bh=KlmQV4tEVDrxf8sVOorcuSyS1DcYFMKjw0saPFmmK+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwVPlKrvxVrCyd2EQB591VbfruBhy8Zoz8YSD9UDM/oucOutFKiOg8+S3ax0XP33C+QG+EdeGm10kcHUAjpUzHsL+iMTSxff7G0rVp6b+Ax9/CHbcm3KewaJjuXjHokLGdIkgcWvTCB91iZQ5N2lJKhHCU5/cVDF4mxrVGvez+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CRXNOXrV; arc=none smtp.client-ip=198.137.202.133
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=HliYnva+5KN1E+V4bq3PVoEHb8bbV3JhWLB6Y70JEp4=; b=CRXNOXrV9IbbHk009wQGE7S2Zc
	63ozwRQpJek7txIp03qIs+/lptFXVmZRQV+QouHmJ/QXoL9wBwN7XjpcHbbtemwqtWlbn8B6K1bBx
	r1gUNMTrfaVAHMesutX96zlS2RsIJ5PLfE4Rvx3FAR0d655ALcZHKku8mc3zbNNmaTKpbwXakTdg1
	nBHOwBaggaeQzwtuyTwr5czwLSjbtI111M6oEpJYxH+YjgmDsTS8cazxmXRwkoeIPGsUgX0qr+mjf
	BEk8QDwwtmIxEs6/ai3Lkzl7M1H1pvXFe0N7EdsxAFbF6mVh14At8eLm+8PQsvE4bk+Au5pTMUzqv
	2+2DySuA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wciw2-00000009AIS-2CXF;
	Thu, 25 Jun 2026 12:11:58 +0000
Date: Thu, 25 Jun 2026 05:11:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Salvatore Dipietro <dipiets@amazon.it>
Cc: hch@infradead.org, ritesh.list@gmail.com, abuehaze@amazon.com,
	akpm@linux-foundation.org, alisaidi@amazon.com, blakgeof@amazon.com,
	brauner@kernel.org, david@kernel.org, dipietro.salvatore@gmail.com,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, ljs@kernel.org, mhocko@suse.com,
	rppt@kernel.org, stable@vger.kernel.org, vbabka@kernel.org,
	vbabka@suse.com, willy@infradead.org
Subject: Re: [PATCH 1/1] iomap: avoid compaction for costly folio order
 allocation
Message-ID: <aj0bDijqj1-Bjxq1@infradead.org>
References: <ajvc7fSDngyx0X5j@infradead.org>
 <20260625091039.24501-1-dipiets@amazon.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625091039.24501-1-dipiets@amazon.it>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268374-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hch@infradead.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:dipiets@amazon.it,m:hch@infradead.org,m:ritesh.list@gmail.com,m:abuehaze@amazon.com,m:akpm@linux-foundation.org,m:alisaidi@amazon.com,m:blakgeof@amazon.com,m:brauner@kernel.org,m:david@kernel.org,m:dipietro.salvatore@gmail.com,m:djwong@kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-xfs@vger.kernel.org,m:ljs@kernel.org,m:mhocko@suse.com,m:rppt@kernel.org,m:stable@vger.kernel.org,m:vbabka@kernel.org,m:vbabka@suse.com,m:willy@infradead.org,m:riteshlist@gmail.com,m:dipietrosalvatore@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[infradead.org,gmail.com,amazon.com,linux-foundation.org,kernel.org,vger.kernel.org,kvack.org,suse.com];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,infradead.org:dkim,infradead.org:mid,infradead.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D88E6C5773

On Thu, Jun 25, 2026 at 09:10:37AM +0000, Salvatore Dipietro wrote:
> Yes — all the patches in the result table are shared within this thread:
> 
> v1 (original, iomap caller): The original PATCH 1/1 in this series
> Ritesh's suggestion (mm/filemap.c): Shared in Ritesh's reply on May 3rd [1]
> Matthew's suggestion (mm/filemap.c): Shared in Matthew's reply on April 4th [2]
> kcompactd background (mm/page_alloc.c): Shared in my reply on May 6th [3]

The page_alloc.c change definitively seems like the right thing to do from
the high-level POV.  It would also be nice to find a way to centralize
the logic for which flags to set in a central place as we have quite a
few other places that want to allocate large folios optimistically.


