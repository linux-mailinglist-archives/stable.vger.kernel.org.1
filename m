Return-Path: <stable+bounces-216131-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIFAB5wsj2kPKwEAu9opvQ
	(envelope-from <stable+bounces-216131-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:52:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AD49B136996
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E0F72302E1BC
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A45E3563C3;
	Fri, 13 Feb 2026 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FqPHSjYS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F44241665;
	Fri, 13 Feb 2026 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770990737; cv=none; b=ZdTxmkSdHQ2OYphs/XmZDhnS+YXPNEJXJQlwEkE/6eE5dX/+75JWV4Huy1GRnaydsSkv6aExXzRQI7Gom9fnieJBq2USM/vUixeKp4mFQ/5CEd0i/1b76WTGGSWaheOSSuemLXgPizVARfV1xCOyuLfISfw3O/8REJvLz9GeuDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770990737; c=relaxed/simple;
	bh=ZFfPG+ZjkMbYeLqXUR2xwRFjMoyBP6x0zNtcTJvBiQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIHl+/DM+WSj0qfV5tC78BDZ2P6TitSaTwSfe0RMNfHkEPuatZTMADFkukkI6CgDGXzCmsQX768fhZVFPZilqQX1PifmJBv2Lx0Mpk6J61HVaVsrW3lajmza60OS7M6X5Xpd98OwLvsgjWZ8bfxtR01pAEhNVtdybc1gPLZiDWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FqPHSjYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387CDC16AAE;
	Fri, 13 Feb 2026 13:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770990737;
	bh=ZFfPG+ZjkMbYeLqXUR2xwRFjMoyBP6x0zNtcTJvBiQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FqPHSjYS5zZQXET9Z28Gtw05BFfefhrTIijDnv1I3QiTDKk2ir+5Kny+q3h+5PoGZ
	 la+EKNelln+O9hfhgzi/jwDXH1SCRWVsGwsGFV9rXNklt1m2WFVPDTnYgPtu0tSfoR
	 6pXXRtd96BCJo2KOLEOdDhiDEyjgJZROzF7QxN9w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Chen <me@linux.beauty>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.18 02/49] io_uring: allow io-wq workers to exit when unused
Date: Fri, 13 Feb 2026 14:47:46 +0100
Message-ID: <20260213134708.977402986@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213134708.885500854@linuxfoundation.org>
References: <20260213134708.885500854@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216131-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kernel.dk:email,linux.beauty:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: AD49B136996
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Chen <me@linux.beauty>

commit 91214661489467f8452d34edbf257488d85176e4 upstream.

io_uring keeps a per-task io-wq around, even when the task no longer has
any io_uring instances.

If the task previously used io_uring for file I/O, this can leave an
unrelated iou-wrk-* worker thread behind after the last io_uring
instance is gone.

When the last io_uring ctx is removed from the task context, mark the
io-wq exit-on-idle so workers can go away. Clear the flag on subsequent
io_uring usage.

Signed-off-by: Li Chen <me@linux.beauty>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/tctx.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/io_uring/tctx.c
+++ b/io_uring/tctx.c
@@ -122,6 +122,14 @@ int __io_uring_add_tctx_node(struct io_r
 				return ret;
 		}
 	}
+
+	/*
+	 * Re-activate io-wq keepalive on any new io_uring usage. The wq may have
+	 * been marked for idle-exit when the task temporarily had no active
+	 * io_uring instances.
+	 */
+	if (tctx->io_wq)
+		io_wq_set_exit_on_idle(tctx->io_wq, false);
 	if (!xa_load(&tctx->xa, (unsigned long)ctx)) {
 		node = kmalloc(sizeof(*node), GFP_KERNEL);
 		if (!node)
@@ -183,6 +191,9 @@ __cold void io_uring_del_tctx_node(unsig
 	if (tctx->last == node->ctx)
 		tctx->last = NULL;
 	kfree(node);
+
+	if (xa_empty(&tctx->xa) && tctx->io_wq)
+		io_wq_set_exit_on_idle(tctx->io_wq, true);
 }
 
 __cold void io_uring_clean_tctx(struct io_uring_task *tctx)



