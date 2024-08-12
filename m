Return-Path: <stable+bounces-66917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 502EA94F314
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0632B26451
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A194918732A;
	Mon, 12 Aug 2024 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oLqQakKH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A25130E27;
	Mon, 12 Aug 2024 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723479205; cv=none; b=LpAzwBGJvVbBHXebTLV8M+yaT9pxXx3QfQDPxYjTaZA161j60i47SKkGFVBnwZAVD0/fTwf9T2XEOXVG7HPo0QtqYelvhr240XxJ4T7fhHH974c6oHJ4T8qaTFjk5z9bG5PZ1Th9mJpe4c6CdP9Rm+iy/R7y/k6c3/H9JX6WBYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723479205; c=relaxed/simple;
	bh=/hm1kNpx9b/l481ewxT3LvhG2d9hPrllbQr1H37H9kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7Qu00bHgIglCNj0L2FIJWfvwTxsTel0F4ct0ZPhhd137p/kdiDwnj93D40G30pgA3sOHZ2T47o+KtnMW3I5PocFsIiVHJFtyh7eQu8e6KFeh/4mC+6lex778CZYh7kIkQxLxMDm7IveJWLWTAMzjnWV/Ko30JceT6DrtfnmXfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oLqQakKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AF7C32782;
	Mon, 12 Aug 2024 16:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723479205;
	bh=/hm1kNpx9b/l481ewxT3LvhG2d9hPrllbQr1H37H9kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oLqQakKHAzihKf2LR3ehfbjOi9Wg/Ao/rREkgHIbP6Pi2W2wMoNWmcrO6iIX+XbJp
	 w1a4tNKyLNEWfquTvSz1qsDQ6J0Tou4cCNI6kWEc838N4ZztuS/8F9bopisRTmCwq4
	 hVxVMZfSrXTSXKoVD1FkqBsW3z+4yJ2msp53RyBw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 015/189] net: linkwatch: use system_unbound_wq
Date: Mon, 12 Aug 2024 18:01:11 +0200
Message-ID: <20240812160132.729755692@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160132.135168257@linuxfoundation.org>
References: <20240812160132.135168257@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 3e7917c0cdad835a5121520fc5686d954b7a61ab ]

linkwatch_event() grabs possibly very contended RTNL mutex.

system_wq is not suitable for such work.

Inspired by many noisy syzbot reports.

3 locks held by kworker/0:7/5266:
 #0: ffff888015480948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015480948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90003f6fd00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 , at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8fa6f208 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276

Reported-by: syzbot <syzkaller@googlegroups.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://patch.msgid.link/20240805085821.1616528-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/link_watch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/link_watch.c b/net/core/link_watch.c
index cb43f5aebfbcc..cf867f6e38bf1 100644
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -153,9 +153,9 @@ static void linkwatch_schedule_work(int urgent)
 	 * override the existing timer.
 	 */
 	if (test_bit(LW_URGENT, &linkwatch_flags))
-		mod_delayed_work(system_wq, &linkwatch_work, 0);
+		mod_delayed_work(system_unbound_wq, &linkwatch_work, 0);
 	else
-		schedule_delayed_work(&linkwatch_work, delay);
+		queue_delayed_work(system_unbound_wq, &linkwatch_work, delay);
 }
 
 
-- 
2.43.0




