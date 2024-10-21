Return-Path: <stable+bounces-87271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 037799A642B
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250791C21584
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9281E572C;
	Mon, 21 Oct 2024 10:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wChgrfek"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AB81E2618;
	Mon, 21 Oct 2024 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507106; cv=none; b=asgT52zqeht3UcJKSdPwe06IfdoqPHQpJDdL7biR9SCEtOMM92lLc5CRrsVt8kJ6F4H/NPxeqjkj0SKd8A8QSEs21HRenWHvp/rmB6Fz26uEp7hHGysJPmTy5rUuSDWBuM32vBaRI78UpAKVmiErPJsAWsykOEYCCCLQBr/bZP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507106; c=relaxed/simple;
	bh=QTdVnUSG4c2VGCD8KJwq32JqaBdmnVonYu9JVYXeVnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqikAwXZ38f22q/PtIL4IEuYZCcGv4ZQ420xzycrNJk0Jv3HjCUMMAhYWrNTuKyu2MPNj5Ps8VLxvx5NfgYwg++ui6M4BzP+ejVbhAwJw+vtWKbOtkWMXZh309STwJqbPb4qKzvLNN4fNtYOx7vbUILM0FWNI3K3qd8NoFNVVoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wChgrfek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A11EC4CEE5;
	Mon, 21 Oct 2024 10:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729507105;
	bh=QTdVnUSG4c2VGCD8KJwq32JqaBdmnVonYu9JVYXeVnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wChgrfekkf+ZjP8yYQGwJRRzKaFA7UGdC12KvMlSMyQzp3lCfN1lsMp73KrqYvNm3
	 sZrjdV8cSjAs0r5hq/HWJnhF6dP89iwWrSX/oW3gV6wLdQ/BzYQBUzUdmyHYaAbdKd
	 fzf4AuSfOKOMjB/wiy7+fQIrKEOVuxE7LH+B4yDg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benedek Thaler <thaler@thaler.hu>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.6 060/124] io_uring/sqpoll: close race on waiting for sqring entries
Date: Mon, 21 Oct 2024 12:24:24 +0200
Message-ID: <20241021102259.055828930@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021102256.706334758@linuxfoundation.org>
References: <20241021102256.706334758@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit 28aabffae6be54284869a91cd8bccd3720041129 upstream.

When an application uses SQPOLL, it must wait for the SQPOLL thread to
consume SQE entries, if it fails to get an sqe when calling
io_uring_get_sqe(). It can do so by calling io_uring_enter(2) with the
flag value of IORING_ENTER_SQ_WAIT. In liburing, this is generally done
with io_uring_sqring_wait(). There's a natural expectation that once
this call returns, a new SQE entry can be retrieved, filled out, and
submitted. However, the kernel uses the cached sq head to determine if
the SQRING is full or not. If the SQPOLL thread is currently in the
process of submitting SQE entries, it may have updated the cached sq
head, but not yet committed it to the SQ ring. Hence the kernel may find
that there are SQE entries ready to be consumed, and return successfully
to the application. If the SQPOLL thread hasn't yet committed the SQ
ring entries by the time the application returns to userspace and
attempts to get a new SQE, it will fail getting a new SQE.

Fix this by having io_sqring_full() always use the user visible SQ ring
head entry, rather than the internally cached one.

Cc: stable@vger.kernel.org # 5.10+
Link: https://github.com/axboe/liburing/discussions/1267
Reported-by: Benedek Thaler <thaler@thaler.hu>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.h |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -262,7 +262,14 @@ static inline bool io_sqring_full(struct
 {
 	struct io_rings *r = ctx->rings;
 
-	return READ_ONCE(r->sq.tail) - ctx->cached_sq_head == ctx->sq_entries;
+	/*
+	 * SQPOLL must use the actual sqring head, as using the cached_sq_head
+	 * is race prone if the SQPOLL thread has grabbed entries but not yet
+	 * committed them to the ring. For !SQPOLL, this doesn't matter, but
+	 * since this helper is just used for SQPOLL sqring waits (or POLLOUT),
+	 * just read the actual sqring head unconditionally.
+	 */
+	return READ_ONCE(r->sq.tail) - READ_ONCE(r->sq.head) == ctx->sq_entries;
 }
 
 static inline unsigned int io_sqring_entries(struct io_ring_ctx *ctx)



