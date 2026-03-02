Return-Path: <stable+bounces-222662-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGYOGAHMpWl3GwAAu9opvQ
	(envelope-from <stable+bounces-222662-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 18:42:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D40FF1DDF9D
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 18:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DCBC3044644
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 17:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D485428471;
	Mon,  2 Mar 2026 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a42+4d0j"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0256F41C0B5;
	Mon,  2 Mar 2026 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772473327; cv=none; b=g9QW50GBayRLbtnAJWcoBZHG4P7SoLNor1KIuTqEpETDisKscVrb57rWDOyt4n78otzH6EYmO4bubVCjacF9qQLGMwjJvoUzjlocztTFfTrAgDUgM66JvysdgqzgLqoMt7mWkaPv2im1IKn3EtqQvz3lYn2INqSMtT+7pzTbYpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772473327; c=relaxed/simple;
	bh=OyqRQXmyeow1Ax++bz4eoQlAeCJ22rHQ0OvcJyCtics=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNhol1VoPF0hHAjgbNNOoYmkN3JjTdcqs3QvRM5xiDZ7WObVqlCxWPwsTUfO9AVfs1wbs3kC+TXjW03D2wvIrcvmKfd02Ftf4tG4zrgvZ11yYMnjfM7vOP7VkRmBgyNTm9hg7viKX9u+UIaYjlM6UcKt6IpYk6hS3r2QfiHCiUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a42+4d0j; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OyqRQXmyeow1Ax++bz4eoQlAeCJ22rHQ0OvcJyCtics=; b=a42+4d0jt2MGw+3tvzq6tHZF9T
	KMVGjuKfsUnQbOELMM8O7tKpX9KBPlfUPTJTu5V9RAI1l/1ZUi/OwbSggoyl1msDUmSN+CgfvGYAT
	+XBBExPqckdHeflS1QgVJoyN4innxdporThqLlqay7HSrM72w1UZgjFWZkrOAOdBcxSSyrkwfVSYW
	3Vcsu1BOyOY8g+Uo15LEkC9q9olDZ5UZjXlrCIvHZ8CxBdOGplt1jyp+dNQYrwJ7/LU5baVnDRjjF
	rJPu9vPm3ZIiPQ+ry7lEUYvA4epsMoRgF4rZuvfrNsFUKG0zWz11bT7R+rjb8goRalNtcgaRAkqHX
	Bnexi7lw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx7HP-00000009qlL-0cKj;
	Mon, 02 Mar 2026 17:42:03 +0000
Date: Mon, 2 Mar 2026 17:42:02 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Chris Down <chris@chrisdown.name>,
	Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mm/huge_memory: Prevent huge zeropage refcount
 corruption in PMD move
Message-ID: <aaXL6oJamjnfhh5d@casper.infradead.org>
References: <aaBVz7eb6-VBCvaz@chrisdown.name>
 <6147cf80-9d02-4c5c-ab81-8cb9b00044f0@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6147cf80-9d02-4c5c-ab81-8cb9b00044f0@kernel.org>
X-Rspamd-Queue-Id: D40FF1DDF9D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222662-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[casper.infradead.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 04:17:31PM +0100, David Hildenbrand (Arm) wrote:
> It doesn't make sense to leave something partially fixed in #1. It's
> been completely broken from the start. folio_mk_pmd() should never have
> been used.

... mk_huge_pmd() should never have been used ;-)

