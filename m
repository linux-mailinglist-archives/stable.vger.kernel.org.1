Return-Path: <stable+bounces-64144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E46941C4A
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A3D1C22852
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ABE1A6192;
	Tue, 30 Jul 2024 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jmJgR2K+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C273718801A;
	Tue, 30 Jul 2024 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359139; cv=none; b=o/4hNmC2J03BVI2ZKYLrEsgTSlbNfoR2rx0X0ZFhupU8HbFZjn37TW/NFp0xqzLuWlOV7tTmLW+17jqmiODAM0FJK2LuOMHpygd4KSbwxbBwznSXqzfndVmAKgCN6pnL1IFYmjQ7HB21dJBUZMaCnCd4uIY5TdOJ3Gad/gsYOqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359139; c=relaxed/simple;
	bh=9+L4T1MQNu+F11eoTnLaBdXVeoE7/IcN+JgGyE5KefM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JjaGY+U+u0K3PL+RTr+Ry2+o0R9qdSubTgt64XCOlg78CPSQtgCDqYW2orCl6P5mPRW+sbM61dO+vWaztMWAg/a8cz1jF6b8LCs7UR7NRMtdQ5VYS91Sv1QMRwsPI9r4tfeYBHgReIFZ6FYVIr4ziJ4gSI3ADskq7LHBg7aFW4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jmJgR2K+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10615C32782;
	Tue, 30 Jul 2024 17:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722359139;
	bh=9+L4T1MQNu+F11eoTnLaBdXVeoE7/IcN+JgGyE5KefM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jmJgR2K+63AMUx1ZH1dda4kp3Al7gDMvCaDAn2SwMBpkD7quJx4fvqzn9u/aEZh20
	 SLsIqjPB2kfz+xDl2UGRjkp/neq7Am4APloTebyzJt5SuVbD3TnIQ1O8LqzmNzMBPK
	 JwAFp8GNUglwKXpk64Tm+MozDGLp8u7k5ljqiUII=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 438/440] io_uring: fix io_match_task must_hold
Date: Tue, 30 Jul 2024 17:51:11 +0200
Message-ID: <20240730151632.881328509@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Begunkov <asml.silence@gmail.com>

[ Upstream commit e142e9cd8891b0c6f277ac2c2c254199a6aa56e3 ]

The __must_hold annotation in io_match_task() uses a non existing
parameter "req", fix it.

Fixes: 6af3f48bf6156 ("io_uring: fix link traversal locking")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/3e65ee7709e96507cef3d93291746f2c489f2307.1721819383.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/timeout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/timeout.c b/io_uring/timeout.c
index b0cf05ebcbcc3..7cdc234c5f53f 100644
--- a/io_uring/timeout.c
+++ b/io_uring/timeout.c
@@ -601,7 +601,7 @@ void io_queue_linked_timeout(struct io_kiocb *req)
 
 static bool io_match_task(struct io_kiocb *head, struct task_struct *task,
 			  bool cancel_all)
-	__must_hold(&req->ctx->timeout_lock)
+	__must_hold(&head->ctx->timeout_lock)
 {
 	struct io_kiocb *req;
 
-- 
2.43.0




