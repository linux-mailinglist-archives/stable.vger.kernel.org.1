Return-Path: <stable+bounces-271456-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1fztN+WmRmoYbAsAu9opvQ
	(envelope-from <stable+bounces-271456-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:59:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C476FBC0D
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:59:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=a5PIINNC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271456-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-271456-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2179730AF3DB
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295D526F46F;
	Thu,  2 Jul 2026 16:59:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC47433E87;
	Thu,  2 Jul 2026 16:59:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011591; cv=none; b=lLySKEUJt2/VIbK0qelYjmywMIp9VOa/LIyq/15IBBc1OTZcUbI/BdqrIVDr3Ifhl3NjYJQVzpyCwKSxeKO1CIEaJfqkrXR1bOF9CSmK7VkhzwsbG0T6okhKpxx0SEEoSilYNGivpMdmMmzUXSDRjup8AJJ3vzPkalI6034Dkb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011591; c=relaxed/simple;
	bh=RoFvOg+DiInAI9DD3wtSv/ma3Bx86e82kAxXLiNe9sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USE0M//6Jqvn7oCfcOOnlaOOuqOuoDp0g+OWH1ifzPC1kKk715iyzDNsGOi5w2YzhiOmAY5zm7a71utI2LgnSaTz8J2K0Xj3XxZU2wOoqjar4Chpbykcqx2K+WJk8wGPzIgOu08Y9HQEsbYhm8xH/6oaWysDShjQIWvfmQXLt08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a5PIINNC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E12B1F00A3A;
	Thu,  2 Jul 2026 16:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011590;
	bh=yqx9mBlJC4mh0t3DaeRfhSuw590oPHC81b//5TU6hWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a5PIINNCjz26Me+ivM/DaOc36eT8DIXXyYeFC5Xn059awJ19+QeTEZQmIlKxMstBM
	 wrKinksUXCRIakExj0IYFDE91wg8nwhWsn8/fwJZ8caovaJRKWkJtXD9K05ZeHu7p5
	 osNwWI3wlpblY3Rga7nfKTvw+SUd2SnDlthZaA2E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Wenjie Qi <qiwenjie@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 7.1 059/120] f2fs: fix missing read bio submission on large folio error
Date: Thu,  2 Jul 2026 18:20:55 +0200
Message-ID: <20260702155114.183965302@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.964534952@linuxfoundation.org>
References: <20260702155112.964534952@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271456-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:qiwenjie@xiaomi.com,m:chao@kernel.org,m:jaegeuk@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,xiaomi.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7C476FBC0D

7.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenjie Qi <qiwenjie@xiaomi.com>

commit 74c8d2ec95c59a5651ecd975c466998af1961fd4 upstream.

f2fs_read_data_large_folio() can keep a read bio across multiple
readahead folios.  If a later folio hits an error before any of its
blocks are added to the bio, folio_in_bio is false and the current error
path returns immediately after ending that folio.

This can leave the bio accumulated for earlier folios unsubmitted.  Those
folios then never receive read completion, and readers can wait
indefinitely on the locked folios.

Route errors through the common out path so any pending bio is submitted
before returning.  Stop consuming more readahead folios once an error is
seen, and only wait on and clear the current folio when it was actually
added to the bio.

Cc: stable@kernel.org
Fixes: a5d8b9d94e18 ("f2fs: fix to unlock folio in f2fs_read_data_large_folio()")
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/data.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2495,7 +2495,7 @@ static int f2fs_read_data_large_folio(st
 	unsigned nrpages;
 	struct f2fs_folio_state *ffs;
 	int ret = 0;
-	bool folio_in_bio;
+	bool folio_in_bio = false;
 
 	if (!IS_IMMUTABLE(inode) || f2fs_compressed_file(inode)) {
 		if (folio)
@@ -2611,18 +2611,17 @@ submit_and_realloc:
 	}
 	trace_f2fs_read_folio(folio, DATA);
 err_out:
-	if (!folio_in_bio) {
+	if (!folio_in_bio)
 		folio_end_read(folio, !ret);
-		if (ret)
-			return ret;
-	}
+	if (ret)
+		goto out;
 	if (rac) {
 		folio = readahead_folio(rac);
 		goto next_folio;
 	}
 out:
 	f2fs_submit_read_bio(F2FS_I_SB(inode), bio, DATA);
-	if (ret) {
+	if (ret && folio_in_bio) {
 		/* Wait bios and clear uptodate. */
 		folio_lock(folio);
 		folio_clear_uptodate(folio);



