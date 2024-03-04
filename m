Return-Path: <stable+bounces-26224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EA5870DA1
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83349B27090
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0643E200CD;
	Mon,  4 Mar 2024 21:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c3eKaQem"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91DCDDCB;
	Mon,  4 Mar 2024 21:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588164; cv=none; b=m4OBHjQJxiepJuS/pLOT0u7jt46pfpBMuMDSK3VYdnrQz7uBU6E4W2jSC4eLy5YEHanynFE8gWyQEvHpJyiPAnUJRB3pMeEQNq9sRR4vdNNw+df0eN6sLGRP5cgLr8ElgQvcDeAmS67bgiJvgK+11/W6qomlqmSkXMpka5osdg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588164; c=relaxed/simple;
	bh=N+eXHdsaVhVQB3eCX3YDyGMI1kuKGUP2hT7CP2IKMs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=To5yYcvKbhJ2kFGrZyg4+fN13vg4AbMs8UbkwYob+pLfuNDE+CuXxUC+DtT5SwgY81ENeOISdAtZ8KGqZMl0b+Xid6HSq/2lT15Qu4yL9anGSTVZjhzmPgCixcBCJ1TOSigfJMSWGeiyRU+rL+xk/w0QnRen0mHuXDPEM66JIA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c3eKaQem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC45C433C7;
	Mon,  4 Mar 2024 21:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588164;
	bh=N+eXHdsaVhVQB3eCX3YDyGMI1kuKGUP2hT7CP2IKMs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c3eKaQemrGiufzQ+M6ItUmJ19VBO/96VvBsqMMMW6vIcyRjHlTChrWOl7HczlR6r5
	 t3fUCblbjbXJ8yal1Mfl/amVe5ofpyU6Sun937FVKB5gLotOaMtMllPL3fOTzP85p+
	 qZ7O/zP7Q3lsUV4GOUnnJ5iNtJQpP0NTUkI0WRKk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sam Sun <samsun1006219@gmail.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.10 22/42] tomoyo: fix UAF write bug in tomoyo_write_control()
Date: Mon,  4 Mar 2024 21:23:49 +0000
Message-ID: <20240304211538.378797988@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211537.631764077@linuxfoundation.org>
References: <20240304211537.631764077@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit 2f03fc340cac9ea1dc63cbf8c93dd2eb0f227815 upstream.

Since tomoyo_write_control() updates head->write_buf when write()
of long lines is requested, we need to fetch head->write_buf after
head->io_sem is held.  Otherwise, concurrent write() requests can
cause use-after-free-write and double-free problems.

Reported-by: Sam Sun <samsun1006219@gmail.com>
Closes: https://lkml.kernel.org/r/CAEkJfYNDspuGxYx5kym8Lvp--D36CMDUErg4rxfWFJuPbbji8g@mail.gmail.com
Fixes: bd03a3e4c9a9 ("TOMOYO: Add policy namespace support.")
Cc:  <stable@vger.kernel.org> # Linux 3.1+
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/tomoyo/common.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -2657,13 +2657,14 @@ ssize_t tomoyo_write_control(struct tomo
 {
 	int error = buffer_len;
 	size_t avail_len = buffer_len;
-	char *cp0 = head->write_buf;
+	char *cp0;
 	int idx;
 
 	if (!head->write)
 		return -EINVAL;
 	if (mutex_lock_interruptible(&head->io_sem))
 		return -EINTR;
+	cp0 = head->write_buf;
 	head->read_user_buf_avail = 0;
 	idx = tomoyo_read_lock();
 	/* Read a line and dispatch it to the policy handler. */



