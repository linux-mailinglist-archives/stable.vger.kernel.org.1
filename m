Return-Path: <stable+bounces-255357-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NeVEtmgGGqblggAu9opvQ
	(envelope-from <stable+bounces-255357-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:08:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E729A5F7E97
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F26F30D002D
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B42040B6DE;
	Thu, 28 May 2026 20:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q33pgV0i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310F5339866;
	Thu, 28 May 2026 20:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998683; cv=none; b=OZTT8cF0s7lBnZe0t8gQOFZdA0VcZnbOUqcUV5FbzDCRTllZM6K4jGFBWLnLrwlCM59IsLO3acCmpPZ4kWCqnune8KnoF38wlZClieBZZn1bZTmg4X8Mbqx2MuY7iJM2ntBsFdoVQWhVL9aCwtYUpATekxafUi+4HFTn4iMUZUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998683; c=relaxed/simple;
	bh=YuhaFk9XmmL6Wmwtkrakp50fKkdj5rGKYB2vZKbBews=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lM8t+M3y5E4yIApHZA2PytPBQP61mEUlvP0d6E4fwjZBsD74Ud9qgZZ1+0t85TjLPbgbePsZK6cYUNzKEm/fT6iNiE8r9T5zsStob5SJX50ftUE72qWBiTyapfEZ9xqOu4u+ebIcQUNjBR/eAjWF6FAMntli1EmEFQ9LIUZyTsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q33pgV0i; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968001F000E9;
	Thu, 28 May 2026 20:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998682;
	bh=w9MZd2BPsPV3xzeHqwYez5jK8Eoiw4UkmWnF9Rh5p5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=q33pgV0iyJCiCApxQda+p1yDmqQ8Sc025TdjkAAHUfKGfKlOQ2quDc9YeeKu5tHva
	 bmp9w/5+jEmp6dIXrJrR6EjRFpXwl6/++G48iMzVvNqRtwEnUGROFigS0AzTMKlrLf
	 awXL9x+hfTda1/Px2Cn5peI8I0MTbHzVoLNLHiTo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 260/461] netfs: Fix streaming write being overwritten
Date: Thu, 28 May 2026 21:46:29 +0200
Message-ID: <20260528194654.683746942@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255357-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linux.dev:email,infradead.org:email,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,manguebit.org:email]
X-Rspamd-Queue-Id: E729A5F7E97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 7b4dcf1b9455a6e52ac7478b4057dbe10359576d ]

In order to avoid reading whilst writing, netfslib will allow "streaming
writes" in which dirty data is stored directly into folios without reading
them first.  Such folios are marked dirty but may not be marked uptodate.
If a folio is entirely written by a streaming write, uptodate will be set,
otherwise it will have a netfs_folio struct attached to ->private recording
the dirty region.

In the event that a partially written streaming write page is to be
overwritten entirely by a single write(), netfs_perform_write() will try to
copy over it, but doesn't discard the netfs_folio if it succeeds; further,
it doesn't correctly handle a partial copy that overwrites some of the
dirty data.

Fix this by the following:

 (1) If the folio is successfully overwritten, free the netfs_folio struct
     before marking the page uptodate.

 (2) If the copy to the folio partially fails, but short of the dirty data,
     just ignore the copy.

 (3) If the copy partially fails and overwrites some of the dirty data,
     accept the copy, update the netfs_folio struct to record the new data.
     If the folio is now filled, free the netfs_folio and set uptodate,
     otherwise return a partial write.

Found with:

	fsx -q -N 1000000 -p 10000 -o 128000 -l 600000 \
	  /xfstest.test/junk --replay-ops=junk.fsxops

using the following as junk.fsxops:

	truncate 0x0 0 0x927c0
	write 0x63fb8 0x53c8 0
	copy_range 0xb704 0x19b9 0x24429 0x79380
	write 0x2402b 0x144a2 0x90660 *
	write 0x204d5 0x140a0 0x927c0 *
	copy_range 0x1f72c 0x137d0 0x7a906 0x927c0 *
	read 0x00000 0x20000 0x9157c
	read 0x20000 0x20000 0x9157c
	read 0x40000 0x20000 0x9157c
	read 0x60000 0x20000 0x9157c
	read 0x7e1a0 0xcfb9 0x9157c

on cifs with the default cache option.

It shows folio 0x24 misbehaving if the FMODE_READ check is commented out in
netfs_perform_write():

		if (//(file->f_mode & FMODE_READ) ||
		    netfs_is_cache_enabled(ctx)) {

and no fscache.  This was initially found with the generic/522 xfstest.

Fixes: 8f52de0077ba ("netfs: Reduce number of conditional branches in netfs_perform_write()")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://patch.msgid.link/20260512123404.719402-14-dhowells@redhat.com
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/buffered_write.c    | 47 ++++++++++++++++++++++++++----------
 include/trace/events/netfs.h |  3 +++
 2 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index a695d5168b2fc..0ff4c790ae263 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -247,18 +247,38 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		/* See if we can write a whole folio in one go. */
 		if (!maybe_trouble && offset == 0 && part >= flen) {
 			copied = copy_folio_from_iter_atomic(folio, offset, part, iter);
-			if (unlikely(copied == 0))
+			if (likely(copied == part)) {
+				if (finfo) {
+					trace = netfs_whole_folio_modify_filled;
+					goto folio_now_filled;
+				}
+				__netfs_set_group(folio, netfs_group);
+				folio_mark_uptodate(folio);
+				trace = netfs_whole_folio_modify;
+				goto copied;
+			}
+			if (copied == 0)
 				goto copy_failed;
-			if (unlikely(copied < part)) {
+			if (!finfo || copied <= finfo->dirty_offset) {
 				maybe_trouble = true;
 				iov_iter_revert(iter, copied);
 				copied = 0;
 				folio_unlock(folio);
 				goto retry;
 			}
-			__netfs_set_group(folio, netfs_group);
-			folio_mark_uptodate(folio);
-			trace = netfs_whole_folio_modify;
+
+			/* We overwrote some existing dirty data, so we have to
+			 * accept the partial write.
+			 */
+			finfo->dirty_len += finfo->dirty_offset;
+			if (finfo->dirty_len == flen) {
+				trace = netfs_whole_folio_modify_filled_efault;
+				goto folio_now_filled;
+			}
+			if (copied > finfo->dirty_len)
+				finfo->dirty_len = copied;
+			finfo->dirty_offset = 0;
+			trace = netfs_whole_folio_modify_efault;
 			goto copied;
 		}
 
@@ -328,16 +348,10 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 				goto copy_failed;
 			finfo->dirty_len += copied;
 			if (finfo->dirty_offset == 0 && finfo->dirty_len == flen) {
-				if (finfo->netfs_group)
-					folio_change_private(folio, finfo->netfs_group);
-				else
-					folio_detach_private(folio);
-				folio_mark_uptodate(folio);
-				kfree(finfo);
 				trace = netfs_streaming_cont_filled_page;
-			} else {
-				trace = netfs_streaming_write_cont;
+				goto folio_now_filled;
 			}
+			trace = netfs_streaming_write_cont;
 			goto copied;
 		}
 
@@ -351,6 +365,13 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 			goto out;
 		continue;
 
+	folio_now_filled:
+		if (finfo->netfs_group)
+			folio_change_private(folio, finfo->netfs_group);
+		else
+			folio_detach_private(folio);
+		folio_mark_uptodate(folio);
+		kfree(finfo);
 	copied:
 		trace_netfs_folio(folio, trace);
 		flush_dcache_folio(folio);
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 88d814ba1e697..db045135406c9 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -177,6 +177,9 @@
 	EM(netfs_folio_is_uptodate,		"mod-uptodate")	\
 	EM(netfs_just_prefetch,			"mod-prefetch")	\
 	EM(netfs_whole_folio_modify,		"mod-whole-f")	\
+	EM(netfs_whole_folio_modify_efault,	"mod-whole-f!")	\
+	EM(netfs_whole_folio_modify_filled,	"mod-whole-f+")	\
+	EM(netfs_whole_folio_modify_filled_efault, "mod-whole-f+!") \
 	EM(netfs_modify_and_clear,		"mod-n-clear")	\
 	EM(netfs_streaming_write,		"mod-streamw")	\
 	EM(netfs_streaming_write_cont,		"mod-streamw+")	\
-- 
2.53.0




