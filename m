Return-Path: <stable+bounces-271627-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A7XgE8pER2pNVAAAu9opvQ
	(envelope-from <stable+bounces-271627-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 07:12:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE39E6FE9BC
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 07:12:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=mt3Z6RcJ;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271627-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271627-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13870302A4FA
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 05:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1DA33F8C5;
	Fri,  3 Jul 2026 05:12:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D9E343D75;
	Fri,  3 Jul 2026 05:12:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783055530; cv=none; b=HNwE13ZjxYoSMN/+1SlOJKCN+ykQFENgNxHRk6KLpT35EFDLehuPlw+xdNz+CKk3EdC7gRO0skOBI9VTe8zGh7e6icBhmc6uN9mQheWavs3IQSBighUOXkBzLjEXb1CZDisYyOsoe9AfHrbUgvurxTBXIftXjEWrPmk9afQ2CCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783055530; c=relaxed/simple;
	bh=QodELRbfsPAagFSQb+Am3TLMBlWvPzqHiUnCbRYCO9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OUdoX38Uvz79qBCSJ5npaMtZ5yf98jhhd+3u6L9emOqBWX4vYXthax5itxy84nwZxGF6CMFTVeuvvJRmRJOS8BIOIU4TT4/JfYxgf9Do2xbygAN2yZxpjmouUeu9Aycf+wke4AOPR7mLVTWb/fJOYXy/zT1ozR35lH6nFFV5NFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mt3Z6RcJ; arc=none smtp.client-ip=95.215.58.182
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783055506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TclDFaPZdaXfZinZztmQXDY2osmC9ohL82aKjMqnljA=;
	b=mt3Z6RcJAbFH5qjmNSVJr9og3cANnog5yCm8KOSikIlNWnWUdlzBYYJRAxJJYQPrB9K2v2
	t/yidQofXCp8zmiyWOyphesT3hGz9lnz5aI/EeO8GKygjhDt0FxJZTf68vKAwDGvFvHdqj
	xkCSEJlXdSaVC7mi91P395B1Vyr2Als=
From: Lance Yang <lance.yang@linux.dev>
To: pfalcato@suse.de
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	willy@infradead.org,
	song@kernel.org,
	ehagberg@janestreet.com,
	ziy@nvidia.com,
	gleventhal@janestreet.com
Subject: Re: [PATCH stable] mm/khugepaged: write all dirty file folios when collapsing
Date: Fri,  3 Jul 2026 13:11:29 +0800
Message-Id: <20260703051129.88453-1-lance.yang@linux.dev>
In-Reply-To: <20260702165409.164568-1-pfalcato@suse.de>
References: <20260702165409.164568-1-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271627-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pfalcato@suse.de,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:baolin.wang@linux.alibaba.com,m:liam@infradead.org,m:npache@redhat.com,m:ryan.roberts@arm.com,m:dev.jain@arm.com,m:baohua@kernel.org,m:lance.yang@linux.dev,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:stable@vger.kernel.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:willy@infradead.org,m:song@kernel.org,m:ehagberg@janestreet.com,m:ziy@nvidia.com,m:gleventhal@janestreet.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE39E6FE9BC


On Thu, Jul 02, 2026 at 05:54:09PM +0100, Pedro Falcato wrote:
>As-is, khugepaged and writable-file opening exclude each other. A file
>cannot be open writeable and have THPs (because the filesystem is not aware
>of them). khugepaged will never collapse file pages for files that are
>opened writeable. On an open(O_RDWR/O_WRONLY), the page cache for that
>particular file is dropped. This is fine because nothing could've been
>dirtied.
>
>However, there is an edge-case: collapse_file() might not be able to
>coexist with concurrent writers, but it can coexist with dirty folios
>(from previous writers). Therefore, the following can happen:
>
>open(file, O_RDWR)
>write(file)
>close(file)
>madvise(file_mapping, MADV_COLLAPSE, some non-dirty range)
>open(file, O_RDWR)
> nr_thps > 0
>  truncate_inode_pages()
>    /* THPs are cleared out, but so are the dirty folios */
>
>When this edge-case happens, there is data loss, as the dirty folios are
>fully discarded.

Well spotted, thanks!

>
>Fix it by fully writing back the page cache (and waiting) when collapsing
>file THPs. Doing so provides the guarantee that no dirty folio will be
>observed while there are active THPs. To fully ensure this is safe, the
>invalidate_lock needs to be held while doing the writeout, so that
>do_dentry_open()'s page cache truncation excludes this write-and-wait.
>
>Cc: stable@vger.kernel.org
>Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>Cc: Christian Brauner <brauner@kernel.org>
>Cc: Jan Kara <jack@suse.cz>
>Cc: Matthew Wilcox <willy@infradead.org>
>Cc: Song Liu <song@kernel.org>
>Cc: Eric Hagberg <ehagberg@janestreet.com>
>Cc: Zi Yan <ziy@nvidia.com>
>Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
>Reported-by: Gregg Leventhal <gleventhal@janestreet.com>
>Closes: https://lore.kernel.org/linux-mm/CAFN_u7H_0ECF3jixP=T=U7AH5=Q3wQNvJMo8an3VqUDMerQfUw@mail.gmail.com/
>Tested-by: Zi Yan <ziy@nvidia.com>
>Signed-off-by: Pedro Falcato <pfalcato@suse.de>
>---

Tested on v7.1.2. I no longer see the data loss with this patch applied.

Tested-by: Lance Yang <lance.yang@linux.dev>

