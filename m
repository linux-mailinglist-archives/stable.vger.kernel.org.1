Return-Path: <stable+bounces-236284-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIHGCIcX3WnNZwkAu9opvQ
	(envelope-from <stable+bounces-236284-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:19:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3FC3EE9DE
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE2C330E559B
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120BD28CF4A;
	Mon, 13 Apr 2026 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k9NN3odo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C05277035;
	Mon, 13 Apr 2026 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096516; cv=none; b=EpYvGLY/0JjrONAG6DIIZ6gHApWmJeRF+7FIUIwCP6W5yxQ9T8o0cxqlas5Nc8PTTA4Ysh4YVnUec1raNpeFaTIrkOgKiLabpd7eRo53kLlo729Ql2I7G+seghp6UK1zWgc6/8TifVUZs7JivNkzNZb3e7jq3eh2fZgUcSbntlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096516; c=relaxed/simple;
	bh=zX+OVbNPlq7diIetqRExaBmq1AUc18/p8bwQwBxtJV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BOx6YA93NP+nD7apkzUt7yvqvuw6kFrz9qb/ZgunA+5uKj5BVYQeRg0gpi2ZGYT2qcZoN2iOLtWA6npOnaPFnwmPeMeFQWcA4fmpS1L/0Zy6M+Rr9gXNoqFDEg06dKjgQdYDnXA5uDGYYOFnYuIOpPGjZO8R6BonT7To+DtWgbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k9NN3odo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F87C2BCB0;
	Mon, 13 Apr 2026 16:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096516;
	bh=zX+OVbNPlq7diIetqRExaBmq1AUc18/p8bwQwBxtJV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k9NN3odojK281HklC1yHBwyzZefQiFvbKmgLZgqIJqJdLYOpACK6lWc+xgqO/MJ7Z
	 HqCkz1PHf/J78yCbTv12WuK+kxMu7EllrtXn/2BdRs/UQ8EpI/SGSiLdlitOUaoaRI
	 3aRsSQJ1fNFasN0q8/bb4xw5TFV0h70jNm40m9aI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Muhammad Alifa Ramdhan <ramdhan@starlabs.sg>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.18 40/83] net/tls: fix use-after-free in -EBUSY error path of tls_do_encryption
Date: Mon, 13 Apr 2026 18:00:08 +0200
Message-ID: <20260413155732.512133281@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155731.019638460@linuxfoundation.org>
References: <20260413155731.019638460@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236284-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,starlabs.sg:email]
X-Rspamd-Queue-Id: 8B3FC3EE9DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Muhammad Alifa Ramdhan <ramdhan@starlabs.sg>

commit a9b8b18364fffce4c451e6f6fd218fa4ab646705 upstream.

The -EBUSY handling in tls_do_encryption(), introduced by commit
859054147318 ("net: tls: handle backlogging of crypto requests"), has
a use-after-free due to double cleanup of encrypt_pending and the
scatterlist entry.

When crypto_aead_encrypt() returns -EBUSY, the request is enqueued to
the cryptd backlog and the async callback tls_encrypt_done() will be
invoked upon completion. That callback unconditionally restores the
scatterlist entry (sge->offset, sge->length) and decrements
ctx->encrypt_pending. However, if tls_encrypt_async_wait() returns an
error, the synchronous error path in tls_do_encryption() performs the
same cleanup again, double-decrementing encrypt_pending and
double-restoring the scatterlist.

The double-decrement corrupts the encrypt_pending sentinel (initialized
to 1), making tls_encrypt_async_wait() permanently skip the wait for
pending async callbacks. A subsequent sendmsg can then free the
tls_rec via bpf_exec_tx_verdict() while a cryptd callback is still
pending, resulting in a use-after-free when the callback fires on the
freed record.

Fix this by skipping the synchronous cleanup when the -EBUSY async
wait returns an error, since the callback has already handled
encrypt_pending and sge restoration.

Fixes: 859054147318 ("net: tls: handle backlogging of crypto requests")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Alifa Ramdhan <ramdhan@starlabs.sg>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://patch.msgid.link/20260403013617.2838875-1-ramdhan@starlabs.sg
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_sw.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -584,6 +584,16 @@ static int tls_do_encryption(struct sock
 	if (rc == -EBUSY) {
 		rc = tls_encrypt_async_wait(ctx);
 		rc = rc ?: -EINPROGRESS;
+		/*
+		 * The async callback tls_encrypt_done() has already
+		 * decremented encrypt_pending and restored the sge on
+		 * both success and error. Skip the synchronous cleanup
+		 * below on error, just remove the record and return.
+		 */
+		if (rc != -EINPROGRESS) {
+			list_del(&rec->list);
+			return rc;
+		}
 	}
 	if (!rc || rc != -EINPROGRESS) {
 		atomic_dec(&ctx->encrypt_pending);



