Return-Path: <stable+bounces-246216-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCc7HaJsA2of5wEAu9opvQ
	(envelope-from <stable+bounces-246216-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:08:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7D7526D9A
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A35C31A512B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78DE3955DF;
	Tue, 12 May 2026 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CFRzJDG0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5539B3955C1;
	Tue, 12 May 2026 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608657; cv=none; b=dnv6lBsMrahuXEkZbINOdLdagQSPA0f9vyaC/0r7tRaiindfSK/OHAlUHPVAJ7xBreNxrVWmfh+40gbd7BnHf90DyLDLlA4cvSqvSERxkI9Aa8wWj6n8hOahNdBQAZ4V1rThX6+DP4P2Bj4d0zHBfS6I95+IjmvAbEYMUjHRjfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608657; c=relaxed/simple;
	bh=w+e6KyIIqv3FeP98c6rrtMN0BFz4xtwNIIcpJTR2aBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSu1Y9KQMiDuJD3lgDPasBIoOd3ur1kAI6onkE5crMcB2oivpx2L4AecrlBg9ENe8K3YTGH4lBnuLHcGBotB9J/8ral4jnHcRn32c8wdrApiqSB5HdPh5GDtXJsVPtt9zMH1/UNRoYjuKyUNA4SHx4OSFA2AAqMkNHvFp/Nfkzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CFRzJDG0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0113C2BCB0;
	Tue, 12 May 2026 17:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608657;
	bh=w+e6KyIIqv3FeP98c6rrtMN0BFz4xtwNIIcpJTR2aBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CFRzJDG0LA4SvI3bpys1xmUOvXwhry0wMWG2Q2jED5XcHWoM/N/N2zsc3S0IOkFpD
	 5Dbe/5AcyN7zvdgz6sfR+Cyc/QpGfPP+qDIZiCniZ+aEBCsVsGqysfjwFmIIm6mEZ5
	 uca7X4N+Hlw81NDuLe9miEpQFpazb9BeTYPPBGv8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	David Gow <davidgow@google.com>,
	David Howells <dhowells@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18 162/270] lib/scatterlist: fix length calculations in extract_kvec_to_sg
Date: Tue, 12 May 2026 19:39:23 +0200
Message-ID: <20260512173941.857323960@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 0C7D7526D9A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246216-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,suse.com:email,c--e.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sashiko.dev:url]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian A. Ehrhardt <lk@c--e.de>

commit 07b7d66e65d9cfe6b9c2c34aa22cfcaac37a5c45 upstream.

Patch series "Fix bugs in extract_iter_to_sg()", v3.

Fix bugs in the kvec and user variants of extract_iter_to_sg.  This series
is growing due to useful remarks made by sashiko.dev.

The main bugs are:
- The length for an sglist entry when extracting from
  a kvec can exceed the number of bytes in the page. This
  is obviously not intended.
- When extracting a user buffer the sglist is temporarily
  used as a scratch buffer for extracted page pointers.
  If the sglist already contains some elements this scratch
  buffer could overlap with existing entries in the sglist.

The series adds test cases to the kunit_iov_iter test that demonstrate all
of these bugs.  Additionally, there is a memory leak fix for the test
itself.

The bugs were orignally introduced into kernel v6.3 where the function
lived in fs/netfs/iterator.c.  It was later moved to lib/scatterlist.c in
v6.5.  Thus the actual fix is only marked for backports to v6.5+.


This patch (of 5):

When extracting from a kvec to a scatterlist, do not cross page
boundaries.  The required length was already calculated but not used as
intended.

Adjust the copied length if the loop runs out of sglist entries without
extracting everything.

While there, return immediately from extract_iter_to_sg if there are no
sglist entries at all.

A subsequent commit will add kunit test cases that demonstrate that the
patch is necessary.

Link: https://lkml.kernel.org/r/20260326214905.818170-1-lk@c--e.de
Link: https://lkml.kernel.org/r/20260326214905.818170-2-lk@c--e.de
Fixes: 018584697533 ("netfs: Add a function to extract an iterator into a scatterlist")
Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
Cc: David Gow <davidgow@google.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: <stable@vger.kernel.org>	[v6.5+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/scatterlist.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -1223,7 +1223,7 @@ static ssize_t extract_kvec_to_sg(struct
 			else
 				page = virt_to_page((void *)kaddr);
 
-			sg_set_page(sg, page, len, off);
+			sg_set_page(sg, page, seg, off);
 			sgtable->nents++;
 			sg++;
 			sg_max--;
@@ -1232,6 +1232,7 @@ static ssize_t extract_kvec_to_sg(struct
 			kaddr += PAGE_SIZE;
 			off = 0;
 		} while (len > 0 && sg_max > 0);
+		ret -= len;
 
 		if (maxsize <= 0 || sg_max == 0)
 			break;
@@ -1385,7 +1386,7 @@ ssize_t extract_iter_to_sg(struct iov_it
 			   struct sg_table *sgtable, unsigned int sg_max,
 			   iov_iter_extraction_t extraction_flags)
 {
-	if (maxsize == 0)
+	if (maxsize == 0 || sg_max == 0)
 		return 0;
 
 	switch (iov_iter_type(iter)) {



