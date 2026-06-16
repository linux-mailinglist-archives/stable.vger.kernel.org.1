Return-Path: <stable+bounces-265147-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rPwyCTCGMWpslgUAu9opvQ
	(envelope-from <stable+bounces-265147-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:21:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 226EF69307B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:21:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=RFNEtZvR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265147-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-265147-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0BBB6309491D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3338A47CC79;
	Tue, 16 Jun 2026 17:08:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC6F47CC7F;
	Tue, 16 Jun 2026 17:08:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629710; cv=none; b=IfTyDUP/75pBckV/eFRoNXUNJoWf2888eVRZb6Ml9bi7f5WUSRy41aI93JedLfa7eU0BwPFJu76nFo6Oelq7r54zAVNgUmbwbEOsQrzGEOO/X5/Usdlmq7cJ/0zjpWSl1PDXWZLvBXUeDu2o7JgvmocONj7lH5plFRVtIFQd34E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629710; c=relaxed/simple;
	bh=M1LbFfkyhU8Uo5GVV154Vas9WAXuFxQiLWQ11wKB7G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2TaGOYosXxVSqbPLp8upE8ZMoPeEzDj3TKLbk8+v+YM2nnINjLIfn2Kv9YjIY5Ms6H6LSDt9/S3W/iMLaLFv2QZ5kPYh2I2pIpcnUxYB9a8dECZGXfCyjqOBnYAJO5AA+2w1EWVe+jmc57h1ZUmVB47kPuPN6gUNicwa17AeQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RFNEtZvR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36A01F000E9;
	Tue, 16 Jun 2026 17:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781629708;
	bh=nDphKQB/rc+HpjwkKFJ+ErbaMqIFH6nq9uZPOV0FTxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RFNEtZvRL8tKJbSFZ/G4nEfmMjpVXIvPEqGArbRytSYMtovfEV8BDpQGo0pQm8r+l
	 cDDgnEHUAh4I/ElSBryRcS4SIo7SEZ9fxOzCVbMBueULUK4osQQrOyTBCJzTSklINC
	 uvtO8NpQKTdYRpGT+WMTH2tfn6B+PcZZrdqymu8U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Fernand Sieber <sieberf@amazon.com>,
	Leonard Foerster <foersleo@amazon.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 307/452] mm/damon/ops-common: call folio_test_lru() after folio_get()
Date: Tue, 16 Jun 2026 20:28:54 +0530
Message-ID: <20260616145133.633519397@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265147-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:sj@kernel.org,m:sieberf@amazon.com,m:foersleo@amazon.de,m:shakeel.butt@linux.dev,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,amazon.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 226EF69307B

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: SeongJae Park <sj@kernel.org>

commit d6b8b02a27b3dd09ec12144322b3dac46d9bc9ef upstream.

damon_get_folio() speculatively calls folio_test_lru() before
folio_try_get().  The folio can get freed and reallocated to a tail page.
In the case, VM_BUG_ON_PGFLAGS() in const_folio_flags() can be triggered.
Remove the speculative call.

Also mark folio_test_lru() check right after folio_try_get() success as no
more unlikely.

The race should be rare.  Also the problem can happen only if the kernel
has enabled CONFIG_DEBUG_VM_PGFLAGS.  No real world report of this issue
has been made so far.  This fix is based on only theoretical analysis.
That said, a bug is a bug.  A similar issue was also fixed via commit
3203b3ab0fcf ("mm/filemap: don't call folio_test_locked() without a
reference in next_uptodate_folio()").  I don't expect this change will
make a meaningful impact to DAMON performance in the real world, though I
will be happy to be corrected from the real world reports.

The issue was discovered [1] by Sashiko.


Link: https://lore.kernel.org/20260525162256.8317-1-sj@kernel.org
Link: https://lore.kernel.org/20260517234112.89245-1-sj@kernel.org [1]
Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Fernand Sieber <sieberf@amazon.com>
Cc: Leonard Foerster <foersleo@amazon.de>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/damon/ops-common.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -28,9 +28,9 @@ struct folio *damon_get_folio(unsigned l
 		return NULL;
 
 	folio = page_folio(page);
-	if (!folio_test_lru(folio) || !folio_try_get(folio))
+	if (!folio_try_get(folio))
 		return NULL;
-	if (unlikely(page_folio(page) != folio || !folio_test_lru(folio))) {
+	if (unlikely(page_folio(page) != folio) || !folio_test_lru(folio)) {
 		folio_put(folio);
 		folio = NULL;
 	}



