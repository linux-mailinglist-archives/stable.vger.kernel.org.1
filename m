Return-Path: <stable+bounces-234731-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLGhJtSm1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-234731-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:04:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F36463C2597
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 555C1315EEA4
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D313D4134;
	Wed,  8 Apr 2026 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xoFI+ikw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAA9B67E;
	Wed,  8 Apr 2026 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673616; cv=none; b=kxqcf7hzxzDvRL+beNtbN/uS2OLD+G8B8emG5UqTAajAgSHV/9yb6KG5YSbKt55KwbdtObFHVnkaJXHLextL0EX9SibeJ588C5oBSBt/5jEcSY/z5En+w0yS/a68/XlFQmhlgjB6x5b3wdItU6SWzsweA08B8kVpeaMa/bwE2yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673616; c=relaxed/simple;
	bh=B2K/pfd55T6Ej2fw8AfcXEyhhgo1LpDa3zerW9DgPIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpUbhQCdpsJH58gggQIWCpRUeFRO1wni+4RVaWslcUK0EmLVwoFuerGmMJVIkeJXsDkOl00VX3M+jFkrLZR2wyf87Pnq+M783cenkten3P1FFhBwEbPRVRmDVGIi/32AT1/ygiI2aF5cAve8cjUFQiZ51r9kVOaQtZ7HiMxkCcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xoFI+ikw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C7CC19425;
	Wed,  8 Apr 2026 18:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673616;
	bh=B2K/pfd55T6Ej2fw8AfcXEyhhgo1LpDa3zerW9DgPIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xoFI+ikwa4EFcnmIG9MKscgWu6ZVB8WUFBg4bqpNa7viW5y5CPZ/x2aHncK624Ajc
	 uPCp0dKNytCD8GDswVpn5r+Za4zJZ+FmG4krrGJGaL+IEfilAxFUsbpbZznQcuZJwE
	 IaiH9G5UdGtlaFt9APOl18ZEpIJPQ4188ZPB3XPs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joanne Koong <joannelkoong@gmail.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.12 023/242] io_uring/kbuf: use WRITE_ONCE() for userspace-shared buffer ring fields
Date: Wed,  8 Apr 2026 20:01:03 +0200
Message-ID: <20260408175927.938801992@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-234731-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,purestorage.com,kernel.dk];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel.dk:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: F36463C2597
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joanne Koong <joannelkoong@gmail.com>

Commit a4c694bfc2455e82b7caf6045ca893d123e0ed11 upstream.

buf->addr and buf->len reside in memory shared with userspace. They
should be written with WRITE_ONCE() to guarantee atomic stores and
prevent tearing or other unsafe compiler optimizations.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/kbuf.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -44,11 +44,11 @@ static bool io_kbuf_inc_commit(struct io
 		buf_len -= this_len;
 		/* Stop looping for invalid buffer length of 0 */
 		if (buf_len || !this_len) {
-			buf->addr = READ_ONCE(buf->addr) + this_len;
-			buf->len = buf_len;
+			WRITE_ONCE(buf->addr, READ_ONCE(buf->addr) + this_len);
+			WRITE_ONCE(buf->len, buf_len);
 			return false;
 		}
-		buf->len = 0;
+		WRITE_ONCE(buf->len, 0);
 		bl->head++;
 		len -= this_len;
 	}
@@ -289,7 +289,7 @@ static int io_ring_buffers_peek(struct i
 				arg->partial_map = 1;
 				if (iov != arg->iovs)
 					break;
-				buf->len = len;
+				WRITE_ONCE(buf->len, len);
 			}
 		}
 



