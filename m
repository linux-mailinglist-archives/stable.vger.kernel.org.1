Return-Path: <stable+bounces-264097-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +NRkOjpvMWr5jAUAu9opvQ
	(envelope-from <stable+bounces-264097-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:43:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7625069156B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:43:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=W4BmAyE8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264097-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-264097-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7EC430BE30D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A3743E48C;
	Tue, 16 Jun 2026 15:35:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AB238837F;
	Tue, 16 Jun 2026 15:35:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624110; cv=none; b=ZepuwEADXR5y8YZBmLusTKGbCjJtlg+LHGeDL/lRch6+DBMpV1EwANo/ZZHX7+2ZFRsN+cPycEThe5JAuDqiTTCgfb3fX3+YVmBtQ4mypMxjNEzQvMLUzXBd2NBa9nTlEiE74muLx7VKr1lEjrdDCi9jiUkbzoDJ3fOMRCQjLzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624110; c=relaxed/simple;
	bh=onOvCiI8C73U3DEeLK44Zb/fly7XdxqenXX+WBhUXSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFmemRIpNbW1fCbk43gkIbaj3Rno8Kk17tCQiA+xUb72ShPLh5Ow1ZP9OLtilITxtt6yqyqkFPEF26VgfSpu27td+TRaXW2M2NecFoT8DaNKPO5BsXVCI1qNXulIQZWsgC2sZnDXMOrk/FFpx+LfBPmJGOgygDffGxmmIaTNa3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W4BmAyE8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21631F00A3A;
	Tue, 16 Jun 2026 15:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624109;
	bh=tZLLx95HJaiRxFhIe6O9zOceRtHIsW00VPWY3ubRl+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W4BmAyE8ekFVWvCY27Geavl8DYzfSYKS/yxR4TPH23vgRiTCEvtbY/gORYx/rBXYo
	 K2dpHHQi1+zUHL7YJ8bjs6e/pvQJjqpqHb33K6+HrZVWzuh9qVLkSwNNP+kXSgFlVN
	 DWwFTXDLIoI2tmiplqKyK3J/laJIHQS3rrXd5mLI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sam Sun <samsun1006219@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>
Subject: [PATCH 7.0 276/378] iomap: avoid potential null folio->mapping deref during error reporting
Date: Tue, 16 Jun 2026 20:28:27 +0530
Message-ID: <20260616145124.638380142@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-264097-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:samsun1006219@gmail.com,m:joannelkoong@gmail.com,m:djwong@kernel.org,m:brauner@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7625069156B

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joanne Koong <joannelkoong@gmail.com>

commit 2eea7f44b9c8b42fd7d3a1a87c06a7cd1b99c327 upstream.

When a buffered read fails, iomap_finish_folio_read() reports the error
with fserror_report_io(folio->mapping->host, ...). This is called after
ifs->read_bytes_pending has been decremented by the bytes attempted to
be read.

For a folio split across multiple read completions, the folio is only
guaranteed to stay locked while read_bytes_pending > 0. Once
iomap_finish_folio_read() decrements read_bytes_pending, another
in-flight read can complete and end the read on the folio, which unlocks
it. This allows truncate logic to run and detach the folio (set
folio->mapping to NULL). The error reporting path then can dereference a
NULL folio->mapping. As reported by Sam Sun, this is the race that can
occur:

CPU0: failed completion      CPU1: final completion     CPU2: truncate
-----------------------      ----------------------     --------------
read_bytes_pending -= len
finished = false
/* preempted before
   fserror_report_io() */
			     read_bytes_pending -= len
			     finished = true
			     folio_end_read()
							truncate clears
							folio->mapping
fserror_report_io(
  folio->mapping->host, ...)
	      ^ NULL deref

Fix this by reporting the error first before decrementing
ifs->read_bytes_pending.

Fixes: a9d573ee88af ("iomap: report file I/O errors to the VFS")
Cc: stable@vger.kernel.org
Reported-by: Sam Sun <samsun1006219@gmail.com>
Closes: https://lore.kernel.org/linux-fsdevel/CAEkJfYPhWdd59RKmuNLJg-bkypHz7xiOwaWyNVu3A8CUqQCnvg@mail.gmail.com/
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Link: https://patch.msgid.link/20260604011858.2297561-1-joannelkoong@gmail.com
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/iomap/buffered-io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d7b648421a70..d55b936e6986 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -400,6 +400,11 @@ void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
 	bool uptodate = !error;
 	bool finished = true;
 
+	if (error)
+		fserror_report_io(folio->mapping->host, FSERR_BUFFERED_READ,
+				  folio_pos(folio) + off, len, error,
+				  GFP_ATOMIC);
+
 	if (ifs) {
 		unsigned long flags;
 
@@ -411,11 +416,6 @@ void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
 		spin_unlock_irqrestore(&ifs->state_lock, flags);
 	}
 
-	if (error)
-		fserror_report_io(folio->mapping->host, FSERR_BUFFERED_READ,
-				  folio_pos(folio) + off, len, error,
-				  GFP_ATOMIC);
-
 	if (finished)
 		folio_end_read(folio, uptodate);
 }
-- 
2.54.0




