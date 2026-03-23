Return-Path: <stable+bounces-228754-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHPoM/pTwWkYSQQAu9opvQ
	(envelope-from <stable+bounces-228754-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:53:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3B72F561C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14C1E3028F6B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBECA3AF648;
	Mon, 23 Mar 2026 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N/d997k0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9E33AF643;
	Mon, 23 Mar 2026 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277033; cv=none; b=iqLu99YYlp0DLeBEtbe7SGSE8iLyPkMue/afJtrru29i+uHMMyujTT5+O2ysexEarkCskxbdlIj6TDOiEma0nvZkJOph6xFZUv9fsNMpNREccd50G7U8srp90ahclmQ+3dj8hHXNKLqaVkCXyHrLQFjNXYo70M0mxImudikU7P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277033; c=relaxed/simple;
	bh=Dlgz1hQDmwir1+6zLcC89BTwZEFzRrd0Vfs+XDvoYAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lY1AV2ij+tiNQQpPv2SiDsNIg/aZHhhA7QuGH+TttYb6bSyp+VtYboHLQB9w+ikJtEf46dcXcM3m2f5xXYeypZL3o+Hbfxj5HHQMJ7QPMYJufx6SbydeTuf7j4uP9wQIqL44JbPtG51Im9wnzJinCIfWPjEb+IzDKkNQC5wjmew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N/d997k0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA7EC2BCB3;
	Mon, 23 Mar 2026 14:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277033;
	bh=Dlgz1hQDmwir1+6zLcC89BTwZEFzRrd0Vfs+XDvoYAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N/d997k0kYTxT1/NB2Cez/pdb8mpS/qgFgLzZajHgQt0ONvssjgXv/ftMv93k7E6R
	 UNzoGlbj7/RVBpoMWtP2xjSb7JMbp8azWEuekly+RVfTyMsaFzsfEQtCzCemX9yF9O
	 XLXBxa5eTQkwA/6k1iXyht6orjmRKW1YXijwnueE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Keenan Dong <keenanat2000@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.12 297/460] io_uring/kbuf: check if target buffer list is still legacy on recycle
Date: Mon, 23 Mar 2026 14:44:53 +0100
Message-ID: <20260323134533.782553626@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-228754-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.dk];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4E3B72F561C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

Commit c2c185be5c85d37215397c8e8781abf0a69bec1f upstream.

There's a gap between when the buffer was grabbed and when it
potentially gets recycled, where if the list is empty, someone could've
upgraded it to a ring provided type. This can happen if the request
is forced via io-wq. The legacy recycling is missing checking if the
buffer_list still exists, and if it's of the correct type. Add those
checks.

Cc: stable@vger.kernel.org
Fixes: c7fb19428d67 ("io_uring: add support for ring mapped supplied buffers")
Reported-by: Keenan Dong <keenanat2000@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/kbuf.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -62,9 +62,17 @@ bool io_kbuf_recycle_legacy(struct io_ki
 
 	buf = req->kbuf;
 	bl = io_buffer_get_list(ctx, buf->bgid);
-	list_add(&buf->list, &bl->buf_list);
-	req->flags &= ~REQ_F_BUFFER_SELECTED;
+	/*
+	 * If the buffer list was upgraded to a ring-based one, or removed,
+	 * while the request was in-flight in io-wq, drop it.
+	 */
 	req->buf_index = buf->bgid;
+	if (bl && !(bl->flags & IOBL_BUF_RING))
+		list_add(&buf->list, &bl->buf_list);
+	else
+		kmem_cache_free(io_buf_cachep, buf);
+	req->flags &= ~REQ_F_BUFFER_SELECTED;
+	req->kbuf = NULL;
 
 	io_ring_submit_unlock(ctx, issue_flags);
 	return true;



