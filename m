Return-Path: <stable+bounces-245971-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJGaFDtpA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-245971-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:54:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 985BA526451
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09EE6311F937
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566CB3955C2;
	Tue, 12 May 2026 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kREhkjz/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173CF3E171D;
	Tue, 12 May 2026 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608023; cv=none; b=A82aC398VmJh2s7ILWP7LLmJrDjp/yWGv0zLZDqWKIo0xe5NxiifHu1xeZqNc9DPk43PPGTq2LALAsiIXxCOa1ThsDt12UdQKP+qPFzETi3tvRV7GSir/w63zdv2IcuWR80f9/lhlfGybXM5P0PcPnWWhJYeqzVfB2ecpvb61rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608023; c=relaxed/simple;
	bh=gRFl3yF+zUYd5wBn6sFb4FAKMZjHonU8TFnkgCwxyZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lrh2K9LyDWVG+yrQbh3tBX3HvAklQFMWtWXtY5PuTkINI+7mVpuXhOYwHJhh7pB2em1m3TQygeQMrIQ595oa1J2TzAZVvHDm8Dtx8WbuvSsOlP6O9BEMQF2zjP6JoW6kl5A/p8YhRGTfFjg40ufjpcYKf0DxtsR972U8uL73OBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kREhkjz/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31042C2BCC7;
	Tue, 12 May 2026 17:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608022;
	bh=gRFl3yF+zUYd5wBn6sFb4FAKMZjHonU8TFnkgCwxyZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kREhkjz/TPPlT1szmkfA31xybP1BU9v0CwZKlOhHNvAqGHtunYZI8BQw39X+MR9Vd
	 5LyKnzF1e5fSH35ObCZ8Ku4eJCZ4vIowPom8MUVsdzeonNZ9a17x0hyAcGAkHvvRQO
	 /FzH/iGyutf4p83AY4YUSlWEN7uwgp9yS5BKoQSI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	David Howells <dhowells@redhat.com>,
	David Gow <davidgow@google.com>,
	Kees Cook <kees@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12 126/206] lib/scatterlist: fix temp buffer in extract_user_to_sg()
Date: Tue, 12 May 2026 19:39:38 +0200
Message-ID: <20260512173935.525979274@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 985BA526451
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245971-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.com:email,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian A. Ehrhardt <lk@c--e.de>

commit 118cf3f55975352ac357fb194405031458186819 upstream.

Instead of allocating a temporary buffer for extracted user pages
extract_user_to_sg() uses the end of the to be filled scatterlist as a
temporary buffer.

Fix the calculation of the start address if the scatterlist already
contains elements.  The unused space starts at sgtable->sgl +
sgtable->nents not directly at sgtable->nents and the temporary buffer is
placed at the end of this unused space.

A subsequent commit will add kunit test cases that demonstrate that the
patch is necessary.

Pointed out by sashiko.dev on a previous iteration of this series.

Link: https://lkml.kernel.org/r/20260326214905.818170-3-lk@c--e.de
Fixes: 018584697533 ("netfs: Add a function to extract an iterator into a scatterlist")
Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
Cc: David Howells <dhowells@redhat.com>
Cc: David Gow <davidgow@google.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: <stable@vger.kernel.org>	[v6.5+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/scatterlist.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -1118,8 +1118,7 @@ static ssize_t extract_user_to_sg(struct
 	size_t len, off;
 
 	/* We decant the page list into the tail of the scatterlist */
-	pages = (void *)sgtable->sgl +
-		array_size(sg_max, sizeof(struct scatterlist));
+	pages = (void *)sg + array_size(sg_max, sizeof(struct scatterlist));
 	pages -= sg_max;
 
 	do {



