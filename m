Return-Path: <stable+bounces-66886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0912794F2EF
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 980DC1F20E7A
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BC6187356;
	Mon, 12 Aug 2024 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZHEnGgC0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A3E1EA8D;
	Mon, 12 Aug 2024 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723479105; cv=none; b=dPTJ7PjXonuV8Cd70cLoRsfGmGUuGUItrcCQbHf+Ys4Zah9+mF1Ud4IdFxlrwqHvKD4lf/njFC/0xP4EXGKbBBPK+aVKVERDH6KeBrUHbtBUGQ5bBRWHgs4PibGUxq1os6n3XwwYKF+qskEk7H9R4yzM0CFPJwVpoe9+IVnZWBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723479105; c=relaxed/simple;
	bh=QGWrqx6QFrNp8KcWVq2lxqaGtKZxHk+tV+S2c4Y7N90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UhC973jpsULcs2F1QhEx2QrlZ3tB5BzB4QB5OBEHT7nY+CHON0K5hxFReO29aZoUjQJLFtfSOyNlKg9cRW5WmcWfOnSJAI//MkEKaXIFXdPbwoXgZ2cJ7s/1lVPYtvvMr6AbyB8/GPGdMjq73uPJggU+qOBNwHJ9QaGCxKdCbsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZHEnGgC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A63AC4AF09;
	Mon, 12 Aug 2024 16:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723479105;
	bh=QGWrqx6QFrNp8KcWVq2lxqaGtKZxHk+tV+S2c4Y7N90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZHEnGgC0BGu0oaEYwQV5cZvpNR7HDTPhjvckx9GGPg4FXaS3f6ma0Cb2KuD4KtOVo
	 vKJdu8q4LosH+dhio1Bcqg+U5h5kAR+BVgSVTxnq71P3bk0sBfimapR8iknUpgDm//
	 2nUJvz49Qt3LZDHW8JH3w/ToK0rhR6YcxOGG9gAA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jens Axboe <axboe@kernel.dk>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH 6.1 135/150] block: use the right type for stub rq_integrity_vec()
Date: Mon, 12 Aug 2024 18:03:36 +0200
Message-ID: <20240812160130.380106105@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160125.139701076@linuxfoundation.org>
References: <20240812160125.139701076@linuxfoundation.org>
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

From: Jens Axboe <axboe@kernel.dk>

commit 69b6517687a4b1fb250bd8c9c193a0a304c8ba17 upstream.

For !CONFIG_BLK_DEV_INTEGRITY, rq_integrity_vec() wasn't updated
properly. Fix it up.

Fixes: cf546dd289e0 ("block: change rq_integrity_vec to respect the iterator")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Cc: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/blk-integrity.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -175,7 +175,7 @@ static inline int blk_integrity_rq(struc
 	return 0;
 }
 
-static inline struct bio_vec *rq_integrity_vec(struct request *rq)
+static inline struct bio_vec rq_integrity_vec(struct request *rq)
 {
 	/* the optimizer will remove all calls to this function */
 	return (struct bio_vec){ };



