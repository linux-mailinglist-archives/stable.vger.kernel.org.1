Return-Path: <stable+bounces-263498-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2MOTMt2aMGoMVAUAu9opvQ
	(envelope-from <stable+bounces-263498-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 02:37:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1908468AF86
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 02:37:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=g8PKPYbT;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263498-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263498-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99A7B316E88F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 00:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507621A316E;
	Tue, 16 Jun 2026 00:33:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258ED243376
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 00:33:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570037; cv=none; b=WKuue3nRCRgsM8IUkkL/ImFveKNmgth+yFYrOjp7V4MRsymaJ+nK/GZr5MpRYSAgXhf0a2TwgllWss/Nq+ox33fQfn9sJM+jdFxqKthlc/uONbsMwyMBN6tjS8RJUxZIJ9wTm/qq8xc+G54+udK1WzUtmynWkadqi21dGXzP+j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570037; c=relaxed/simple;
	bh=dhG0qTmxRJCFeDxS2zULR97K9iw81i0kKqjbWCkeJTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfUg1qxeK4zjBrePzH0MUE/dyFcA5rEeq4R8vQmyeY7ExXanDunlD4INlF37bXeisCWetn/WWI0qBYI04oUS2iu4f0W+1uin1kKUTW7UUXo91TBdiVt37NBj/UBjZitzZjxAISoBoOVS/ula7K6gO8jVQYDprVYuHNViSsIa3OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8PKPYbT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3771F000E9;
	Tue, 16 Jun 2026 00:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570036;
	bh=RC5cz7R8sad6+KQpxwVwOduOOhcwydpgcJc3JovOP84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g8PKPYbTgYCPastN3gvC4Unv51An6mB+b0rCw9FTkDKC6+RhdfBKYzMktvccs1YQU
	 zRtMFsLa40pP40cXYw4s/ifLFMFDqMZg8TcjW1Ku3bRYlZyKTHnqEEtp/GuSlCTe6J
	 JPA9RvqbYpfUqr4Hl7K5V+SBUgxz3ikWN2ycetOEj2jhYYW8+U50C49LFInQbSeYrP
	 toGfSgaRxIU8BAh+libXjRNlK0beRjS/ERULanhg84kRws5H5Id5ZAXOkuZ7RFf8he
	 JBvN8tw4dtO/Na0ERQeD3gvga/3Y0wig5Ovrofjz2WSJT0Hj4RSA7hOIqIc+hPzePs
	 y0k9ABtwPmVSg==
From: SeongJae Park <sj@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Fernand Sieber <sieberf@amazon.com>,
	Leonard Foerster <foersleo@amazon.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm/damon/ops-common: call folio_test_lru() after folio_get()
Date: Mon, 15 Jun 2026 17:33:45 -0700
Message-ID: <20260616003346.141166-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260615190329.2368312-1-sashal@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:sj@kernel.org,m:stable@vger.kernel.org,m:sieberf@amazon.com,m:foersleo@amazon.de,m:shakeel.butt@linux.dev,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263498-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux-foundation.org:email,amazon.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1908468AF86

On Mon, 15 Jun 2026 15:03:29 -0400 Sasha Levin <sashal@kernel.org> wrote:

> From: SeongJae Park <sj@kernel.org>
> 
> [ Upstream commit d6b8b02a27b3dd09ec12144322b3dac46d9bc9ef ]
> 
> damon_get_folio() speculatively calls folio_test_lru() before
> folio_try_get().  The folio can get freed and reallocated to a tail page.
> In the case, VM_BUG_ON_PGFLAGS() in const_folio_flags() can be triggered.
> Remove the speculative call.
> 
> Also mark folio_test_lru() check right after folio_try_get() success as no
> more unlikely.
> 
> The race should be rare.  Also the problem can happen only if the kernel
> has enabled CONFIG_DEBUG_VM_PGFLAGS.  No real world report of this issue
> has been made so far.  This fix is based on only theoretical analysis.
> That said, a bug is a bug.  A similar issue was also fixed via commit
> 3203b3ab0fcf ("mm/filemap: don't call folio_test_locked() without a
> reference in next_uptodate_folio()").  I don't expect this change will
> make a meaningful impact to DAMON performance in the real world, though I
> will be happy to be corrected from the real world reports.
> 
> The issue was discovered [1] by Sashiko.
> 
> Link: https://lore.kernel.org/20260525162256.8317-1-sj@kernel.org
> Link: https://lore.kernel.org/20260517234112.89245-1-sj@kernel.org [1]
> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Cc: Fernand Sieber <sieberf@amazon.com>
> Cc: Leonard Foerster <foersleo@amazon.de>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: <stable@vger.kernel.org> # 5.15.x
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Thank you for fixing the conflict, Sasha!

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

