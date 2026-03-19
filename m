Return-Path: <stable+bounces-227387-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGd6L1FpvGlQyQIAu9opvQ
	(envelope-from <stable+bounces-227387-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 22:23:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A51E2D2A29
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 22:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1D48301C564
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 21:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4497F40242C;
	Thu, 19 Mar 2026 21:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nVtJwNCM"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450913B7773
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773955403; cv=none; b=FOcLLQ8vDYxscM8ll0fgYe4cKuKiD037qRpL5w/Ayv/H/7M8rLPqhEbhK2ksI6DbbL25361BLkyv2VKWG/r/t5ZP9GfesQegOAVtyu4kqWJ2YdOjhoMQiyENo9ladZDHFHPctpjXgn1uMi7rwJ7A0AQo9rAmz87ofZ/cC5SXaEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773955403; c=relaxed/simple;
	bh=StJfLB9hF/4Lxg7xG9mSwfOFdap+/YtChcudW6Umfj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ct5iLkW/PpbIO0q6lSGrvx3nLlpa9UhhuEnizFV2gy6gNvDB+LU6trTeOxzi3o8g5QGtnzAdb3UJLHI450dlMUabLKa15J/+8Vnk86Qq41R3UnRDjW8lRdrQ1JwuSTe7OvxVIXjLvpOeOourTuMp78LyMB8z0ngHodno9JHsRG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nVtJwNCM; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-41729dc7d7aso449369fac.3
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 14:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773955400; x=1774560200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKxWJXPBsb1pqKefO6RKKySVkGscxQ9SCqJ8fzyBdCM=;
        b=nVtJwNCMpUGTmkohFubcH5NYt3Oz6DVQ3e/kIKNsC8ce/2SgmUafp+VeTTwmwacHZ1
         4NQnzDEoKH/OUzK4KwWdljshaMyvirJQWgBVvuRYKSczA7r0Muzg80kfwdWvkVkZguxd
         T/gRMv0YcHPUk1v7Lt05BZ1AOUMKJAKp9M2AQZAwzYeS9u4nNRoA9d9KvSiGgVVlH1oy
         E7P8OLQ+bkDhqKQbz4OuDuL3eklX0TZjtmsSa9BbPQOwr+MbPKsH5LoSgXzRtxTN+sEt
         0XDHgYeWOGTtgH4V/t5kCtDW3OF0zmX6WB2UdqQaIPbLVLgpnj6Mmq2+68bxLuGFwOcZ
         mB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773955400; x=1774560200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IKxWJXPBsb1pqKefO6RKKySVkGscxQ9SCqJ8fzyBdCM=;
        b=mkk92PB+eISntmPKJdM+mzNqn51DAPyyKBTY7t5j4U4AIJEbxtBEpuyNvPg4SVR/OY
         AoZzl1DjUoXA+08xZqYNGRF+kbRWEE3LuyAOuAz2Z9Wwte6UGEwihURdy5/9gB3CVXuG
         7UZm6PNKlGtPWe0SR1LNqHy+VCYkNZA7hxASfMaB2MZILaplOb2sudVzi9+gSu+nsYVN
         MTj/UMOjK3Z7gmfHLxeCpTLtL9mKwAUJgYzBDjYyy28gEjlrbqDiEwa7t7gMs1eOOur1
         mAHaXdWqK5xVcNyei/ByWr+gY/2a9tBcoOlBNn5j8oRcgE9vrEuJSXdo4jEGt5j4aGPG
         a2UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgPkNhJbU1eBGa8BTgAdrsM+kqffKMvjUtctkTdIMlPzkGGPBH7yQB0dWFJuKrTME4R+Cut94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9zAbJBikT3yKoWD/GxfObGpwZgHGLRRqIJA7JLyQY1FgUFXTX
	Jdv2b3aHKEZHdmzhGRDfUhGNryr55EM4f1X/jOzQb4U8vAhQnCJmviTeXmNPvF77hlI=
X-Gm-Gg: ATEYQzxeozJ9K/w6Zxw7Q0a99aMjCOycGzwU6HYbJNA+pqJ+//JwWFjd8ajcjogacBO
	J0QSF5GOCKPNmJ2/VcXpie94IjbWPEcYpQcS4MCtU++JLxOG6GDTIzdWvIHfVTInMZxlAD2noZo
	C5TUiWGi12pP20ZYxYq0Y3uKiRfIYPtGAk7yj8vSOAl37arTXd3QfWgvxO/swMZ8ZvblZ6waQV5
	xFZLxzaD/z8Qv5xTzfiV4tVA6U55JL29B/upT4XvesLsAIyU+7TW6vEAFSHwVkI1O+2fsOQ87sf
	CO+yLuovSGVsRRuOEBJt4RbcZj2XOwEwQakL6sWWAyzWoDB4rro0NEfWQQe6oVZ4hCGxL8gW5nL
	PNRKkywLFWm1GW3v6RmEzlvlPdQf5vKL3fD8gwYIjAMswEENte9j5s4oSUP/Se+19twmlsLSa0S
	GBNIGUxqsTRZSOsJzcFRvxwf51VTEYwjoRuQas2Mt4hf08UDZnsnyafK6/Ogpb3jJ27ng=
X-Received: by 2002:a05:6870:911e:b0:41b:e9c4:9778 with SMTP id 586e51a60fabf-41c11179184mr505000fac.32.1773955400265;
        Thu, 19 Mar 2026 14:23:20 -0700 (PDT)
Received: from m2max ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c148a5ca4sm186363fac.3.2026.03.19.14.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 14:23:17 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: code@mgjm.de,
	Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] io_uring/kbuf: propagate BUF_MORE through early buffer commit path
Date: Thu, 19 Mar 2026 15:21:36 -0600
Message-ID: <20260319212309.284152-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319212309.284152-1-axboe@kernel.dk>
References: <20260319212309.284152-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227387-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A51E2D2A29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When io_should_commit() returns true (eg for non-pollable files), buffer
commit happens at buffer selection time and sel->buf_list is set to
NULL. When __io_put_kbufs() generates CQE flags at completion time, it
calls __io_put_kbuf_ring() which finds a NULL buffer_list and hence
cannot determine whether the buffer was consumed or not. This means that
IORING_CQE_F_BUF_MORE is never set for non-pollable input with
incrementally consumed buffers.

Likewise for io_buffers_select(), which always commits upfront and
discards the return value of io_kbuf_commit().

Add REQ_F_BUF_MORE to store the result of io_kbuf_commit() during early
commit. Then __io_put_kbuf_ring() can check this flag and set
IORING_F_BUF_MORE accordingy.

Reported-by: Martin Michaelis <code@mgjm.de>
Cc: stable@vger.kernel.org
Fixes: ae98dbf43d75 ("io_uring/kbuf: add support for incremental buffer consumption")
Link: https://github.com/axboe/liburing/issues/1553
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/io_uring_types.h |  3 +++
 io_uring/kbuf.c                | 10 +++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index dd1420bfcb73..214fdbd49052 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -541,6 +541,7 @@ enum {
 	REQ_F_BL_NO_RECYCLE_BIT,
 	REQ_F_BUFFERS_COMMIT_BIT,
 	REQ_F_BUF_NODE_BIT,
+	REQ_F_BUF_MORE_BIT,
 	REQ_F_HAS_METADATA_BIT,
 	REQ_F_IMPORT_BUFFER_BIT,
 	REQ_F_SQE_COPIED_BIT,
@@ -626,6 +627,8 @@ enum {
 	REQ_F_BUFFERS_COMMIT	= IO_REQ_FLAG(REQ_F_BUFFERS_COMMIT_BIT),
 	/* buf node is valid */
 	REQ_F_BUF_NODE		= IO_REQ_FLAG(REQ_F_BUF_NODE_BIT),
+	/* incremental buffer consumption, more space available */
+	REQ_F_BUF_MORE		= IO_REQ_FLAG(REQ_F_BUF_MORE_BIT),
 	/* request has read/write metadata assigned */
 	REQ_F_HAS_METADATA	= IO_REQ_FLAG(REQ_F_HAS_METADATA_BIT),
 	/*
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index a4cb6752b7aa..f72f38d22d2b 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -216,7 +216,8 @@ static struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
 	sel.addr = u64_to_user_ptr(READ_ONCE(buf->addr));
 
 	if (io_should_commit(req, issue_flags)) {
-		io_kbuf_commit(req, sel.buf_list, *len, 1);
+		if (!io_kbuf_commit(req, sel.buf_list, *len, 1))
+			req->flags |= REQ_F_BUF_MORE;
 		sel.buf_list = NULL;
 	}
 	return sel;
@@ -349,7 +350,8 @@ int io_buffers_select(struct io_kiocb *req, struct buf_sel_arg *arg,
 		 */
 		if (ret > 0) {
 			req->flags |= REQ_F_BUFFERS_COMMIT | REQ_F_BL_NO_RECYCLE;
-			io_kbuf_commit(req, sel->buf_list, arg->out_len, ret);
+			if (!io_kbuf_commit(req, sel->buf_list, arg->out_len, ret))
+				req->flags |= REQ_F_BUF_MORE;
 		}
 	} else {
 		ret = io_provided_buffers_select(req, &arg->out_len, sel->buf_list, arg->iovs);
@@ -395,8 +397,10 @@ static inline bool __io_put_kbuf_ring(struct io_kiocb *req,
 
 	if (bl)
 		ret = io_kbuf_commit(req, bl, len, nr);
+	if (ret && (req->flags & REQ_F_BUF_MORE))
+		ret = false;
 
-	req->flags &= ~REQ_F_BUFFER_RING;
+	req->flags &= ~(REQ_F_BUFFER_RING | REQ_F_BUF_MORE);
 	return ret;
 }
 
-- 
2.53.0


