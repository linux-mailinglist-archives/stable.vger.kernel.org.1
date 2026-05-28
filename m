Return-Path: <stable+bounces-256139-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cI0nEoyqGGoomAgAu9opvQ
	(envelope-from <stable+bounces-256139-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:50:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBE05F9A6F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48A6F3215500
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D375133987F;
	Thu, 28 May 2026 20:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mJrO2+fW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE8F317164;
	Thu, 28 May 2026 20:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000865; cv=none; b=IvqrJWNcyIYFaxYx5UG51xqIdJrXLgIJGa3uor5qCbLIBkgV1A2EzeKOTJwAZ3lsm3j5EQ4SQns057CTs2NoLBRy/neRF9L1ddmDHUFVtYCeG9j65lTxtIyLqPsKKedHvRYe8qCggTz9Jfwf8j9x5kN6PCkWuR5u/tYBT7gZc18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000865; c=relaxed/simple;
	bh=6sVpRQM9aSPOk06g88Rsdc6IIm5+gK+M5GXf67An98M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IR9LjrI9t1n/iCWj+oEY3F7oOmBzJKmi2t5S7DcSSfHis34CX4WDqrbIHU7tYoUb23r97U8sg24io9Q117QYfpOFqOdQxbZva7eB8rajQu7SlY28A7z/qfkAh/r3261QgJFxitCO8ZiLRhKZPSDsTUSAWE11JD+C+E9JPTC85Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mJrO2+fW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CD41F000E9;
	Thu, 28 May 2026 20:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000864;
	bh=IX2q0qrSwvAEa40ASLPP30xUDswqRzd3rkHposRlPvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mJrO2+fWXgDpgH+Wuyobe6G3x2Ww7/bMy4RrbpBtyV7Mqee3V1cFnsU2QI+ZCDq4h
	 +PqN6Usx+yHj11TeROiV1Uw7NGJUc59TnlIyKudfqYt030NWmsplUWXelA2+DsMF/h
	 BumAY+t0ohz8mTNCr1pnQl5LZCrUL0MrALzCDL/I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 195/272] netfs: Fix potential deadlock in write-through mode
Date: Thu, 28 May 2026 21:49:29 +0200
Message-ID: <20260528194634.724053423@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256139-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[manguebit.org:email,linux.dev:email,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: ACBE05F9A6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit b6a4ae1634b3ad2aaa05222e53d36da532852faf ]

Fix netfs_advance_writethrough() to always unlock the supplied folio and to
mark it dirty if it isn't yet written to the end.  Unfortunately, it can't
be marked for writeback until the folio is done with as that may cause a
deadlock against mmapped reads and writes.

Even though it has been marked dirty, premature writeback can't occur as
the caller is holding both inode->i_rwsem (which will prevent concurrent
truncation, fallocation, DIO and other writes) and ictx->wb_lock (which
will cause flushing to wait and writeback to skip or wait).

Note that this may be easier to deal with once the queuing of folios is
split from the generation of subrequests.

Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Closes: https://sashiko.dev/#/patchset/20260427154639.180684-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://patch.msgid.link/20260512123404.719402-15-dhowells@redhat.com
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/write_issue.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index b7830a15ae40f..2789ac4c80272 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -402,12 +402,7 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 	if (streamw)
 		netfs_issue_write(wreq, cache);
 
-	/* Flip the page to the writeback state and unlock.  If we're called
-	 * from write-through, then the page has already been put into the wb
-	 * state.
-	 */
-	if (wreq->origin == NETFS_WRITEBACK)
-		folio_start_writeback(folio);
+	folio_start_writeback(folio);
 	folio_unlock(folio);
 
 	if (fgroup == NETFS_FOLIO_COPY_TO_CACHE) {
@@ -632,29 +627,41 @@ int netfs_advance_writethrough(struct netfs_io_request *wreq, struct writeback_c
 			       struct folio *folio, size_t copied, bool to_page_end,
 			       struct folio **writethrough_cache)
 {
+	int ret;
+
 	_enter("R=%x ic=%zu ws=%u cp=%zu tp=%u",
 	       wreq->debug_id, wreq->iter.count, wreq->wsize, copied, to_page_end);
 
-	if (!*writethrough_cache) {
-		if (folio_test_dirty(folio))
-			/* Sigh.  mmap. */
-			folio_clear_dirty_for_io(folio);
+	/* The folio is locked. */
 
+	if (*writethrough_cache != folio) {
+		if (*writethrough_cache) {
+			/* Did the folio get moved? */
+			folio_put(*writethrough_cache);
+			*writethrough_cache = NULL;
+		}
 		/* We can make multiple writes to the folio... */
-		folio_start_writeback(folio);
 		if (wreq->len == 0)
 			trace_netfs_folio(folio, netfs_folio_trace_wthru);
 		else
 			trace_netfs_folio(folio, netfs_folio_trace_wthru_plus);
 		*writethrough_cache = folio;
+		folio_get(folio);
 	}
 
 	wreq->len += copied;
-	if (!to_page_end)
+
+	if (!to_page_end) {
+		folio_mark_dirty(folio);
+		folio_unlock(folio);
 		return 0;
+	}
 
+	ret = netfs_write_folio(wreq, wbc, folio);
+	folio_put(*writethrough_cache);
 	*writethrough_cache = NULL;
-	return netfs_write_folio(wreq, wbc, folio);
+	wreq->submitted = wreq->len;
+	return ret;
 }
 
 /*
@@ -668,8 +675,12 @@ int netfs_end_writethrough(struct netfs_io_request *wreq, struct writeback_contr
 
 	_enter("R=%x", wreq->debug_id);
 
-	if (writethrough_cache)
+	if (writethrough_cache) {
+		folio_lock(writethrough_cache);
 		netfs_write_folio(wreq, wbc, writethrough_cache);
+		folio_put(writethrough_cache);
+		wreq->submitted = wreq->len;
+	}
 
 	netfs_end_issue_write(wreq);
 
-- 
2.53.0




