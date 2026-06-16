Return-Path: <stable+bounces-265540-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7806EGSMMWpRmQUAu9opvQ
	(envelope-from <stable+bounces-265540-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:48:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD3C6937E9
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:48:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=d19U7Y5s;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265540-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265540-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 433E931C5FC0
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538093101A7;
	Tue, 16 Jun 2026 17:42:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ED847CC7F;
	Tue, 16 Jun 2026 17:41:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631720; cv=none; b=Oji5tFlgPykVEKjSGwyaUzr87m64DH4O1x60mgFcLwtpjUX5s1S0ePlSfEk5Gn3wnSpg5hjqYksDbx9uwYt3e3BqKw2befsQs96mVL1o4r6VdQk132CtiTEnSxf6CKc9BlV8I9rjKY7odLAz4yNU57peZG8xnRk3D06VqcdwbKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631720; c=relaxed/simple;
	bh=tgTf8fUh5aRArfwmxehXKtxUnNkkNjAKGOnYZGwOcKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YjSJRy8u0oNT1LCbZ66VdTDFSKtbLT106x/168AD+XRA6QgqI4roVBjS8e9PWONMRnYtwkjiyXgbNrUVBOGw+JXET0ZTx47PC4gJMeurYkqxMdi4yP+scymhxuMOYnv3A199VVcxRHmdKzeD+dGA6yKfZlaMX31afxfJzMcvNoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d19U7Y5s; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D801F00A3A;
	Tue, 16 Jun 2026 17:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781631715;
	bh=o2cKLRB2fd361Cd+oOJaWsqIKkNIx1yhKvbow5zIG7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d19U7Y5suSc6rYAmJcBCvYSbVYraGEEQwmF4mRrS+/VpQpUqjbiMqm4Qwr3eIZ7LY
	 GJm3UOZeaKuN6PdD/WiDeQVgWr0re7sIgDrNLrORAqpL1VMbsV0fSFllO6zWKb0cJj
	 FHswoWCbBcELCiRU2owU279VSA4h9SLIs1Iy1iI8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gil Portnoy <dddhkts1@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 272/522] ksmbd: fix use-after-free of a deferred file_lock on double SMB2_CANCEL
Date: Tue, 16 Jun 2026 20:26:59 +0530
Message-ID: <20260616145138.690642369@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-265540-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:dddhkts1@gmail.com,m:linkinjeon@kernel.org,m:stfrench@microsoft.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,microsoft.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8BD3C6937E9

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gil Portnoy <dddhkts1@gmail.com>

commit f580d27e8928828693df44ba2db0fffdbe11dfea upstream.

A deferred byte-range lock (an SMB2_LOCK that blocks) registers an async work on
conn->async_requests via setup_async_work(), with cancel_fn =
smb2_remove_blocked_lock and cancel_argv[0] pointing at the struct file_lock.

When the request is cancelled, the worker frees the file_lock with
locks_free_lock() and takes the cancelled early-exit, which "goto out"s and never
reaches release_async_work() -- the only site that unlinks the work from
conn->async_requests and clears cancel_fn/cancel_argv. The work therefore stays
matchable on async_requests with a live cancel_fn pointing at the freed file_lock,
until connection teardown finally runs release_async_work().

smb2_cancel() fires cancel_fn unconditionally with no state guard, so a second
SMB2_CANCEL for the same AsyncId, arriving in that window, re-runs
smb2_remove_blocked_lock() on the freed file_lock -- a slab use-after-free:

  BUG: KASAN: slab-use-after-free in __locks_delete_block
    __locks_delete_block
    locks_delete_block
    ksmbd_vfs_posix_lock_unblock
    smb2_remove_blocked_lock
    smb2_cancel                 <- 2nd SMB2_CANCEL fires cancel_fn
    handle_ksmbd_work
  Allocated by ...: locks_alloc_lock <- smb2_lock
  Freed by ...:     locks_free_lock  <- smb2_lock (cancelled branch)
  ... cache file_lock_cache of size 192

Reproduced on mainline with KASAN by an authenticated SMB client.

Skip a work whose state is already KSMBD_WORK_CANCELLED so its cancel callback
cannot be fired a second time.

Cc: stable@vger.kernel.org
Signed-off-by: Gil Portnoy <dddhkts1@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smb2pdu.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6810,6 +6810,17 @@ int smb2_cancel(struct ksmbd_work *work)
 			    le64_to_cpu(hdr->Id.AsyncId))
 				continue;
 
+			/*
+			 * A cancelled deferred byte-range lock frees its
+			 * file_lock and takes the smb2_lock() early-exit that
+			 * skips release_async_work(), so the work stays on
+			 * conn->async_requests with a live cancel_fn pointing
+			 * at the freed file_lock.  Re-firing it on a second
+			 * SMB2_CANCEL is a use-after-free.
+			 */
+			if (iter->state == KSMBD_WORK_CANCELLED)
+				break;
+
 			ksmbd_debug(SMB,
 				    "smb2 with AsyncId %llu cancelled command = 0x%x\n",
 				    le64_to_cpu(hdr->Id.AsyncId),



