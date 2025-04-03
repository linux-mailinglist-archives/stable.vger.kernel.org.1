Return-Path: <stable+bounces-127941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE68A7AD76
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748CA189C60D
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAE428A3F9;
	Thu,  3 Apr 2025 19:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJUvs7dS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B445A28A3EE;
	Thu,  3 Apr 2025 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707441; cv=none; b=c/qrLspKzy4gYHnRLb2j3+1XI+8l/Hb1g5hGzhCk/9MDbTweMEjUnmNrjnApimOzCJSCmAD24ULJDflwTm9uiuUnA5lFKyOwd9hSF6NUBmxBjlMPXGMWGjbRzqYcQ5ZUXjeh0BdS3yhFqA0tJoT2ZABfN+/xK97IfiC148OS/mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707441; c=relaxed/simple;
	bh=M7lFV45Fx+2+0E22nSVxRdUTHbc4t70UypBkKOnWtR8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RmotBm5PBfOQFiCxN8/HiVG2RcOxbzQUC6fp7YOZ91CsWRCSYwg2BMa+iYcsQRLEJ/3qm/vG2yxGUuRh/0Zt0+q0CrGgrG1buWZT8QxEQ6v4u4CVYPdfw/chju7Ro+iAX3noaFxEvlIPajf562xe8LMKwHi1UEKN+jsOMa0RE1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJUvs7dS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D507C4CEE3;
	Thu,  3 Apr 2025 19:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707441;
	bh=M7lFV45Fx+2+0E22nSVxRdUTHbc4t70UypBkKOnWtR8=;
	h=From:To:Cc:Subject:Date:From;
	b=oJUvs7dSqSiAVgFqnYEKz53/CAUlAWYBlZ5O2P4pELOhef+ShMJo7YkLK0wi/16MH
	 7YMydJK+UgeIz91ZyMMUnT9y/v4cznf8HD5yYj3ptP6TdXkukeoyTTzp5+zP+ISrrh
	 +75YcF9PXLsb0s86RgNizwTn6E2mH3BVxdPl+5T/GxOtoOwRKGO4KUkiW2kS+pu3Yr
	 zuvnd2ycmueWHMJgLA6U+HIOPaXek42JJ4Pn5Q9c6/xW33V+ck03CgdO6VL4OjIXPN
	 lwtANlRIxSzbIRsk1ckqwuXqtrD3hxp6B/rjQ0waC53Y7XIZ6QyZ3Vp+G625tSbJTq
	 4QbLtieb4hz7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kerneljasonxing@gmail.com>,
	Mina Almasry <almasrymina@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 01/14] page_pool: avoid infinite loop to schedule delayed worker
Date: Thu,  3 Apr 2025 15:10:23 -0400
Message-Id: <20250403191036.2678799-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.291
Content-Transfer-Encoding: 8bit

From: Jason Xing <kerneljasonxing@gmail.com>

[ Upstream commit 43130d02baa137033c25297aaae95fd0edc41654 ]

We noticed the kworker in page_pool_release_retry() was waken
up repeatedly and infinitely in production because of the
buggy driver causing the inflight less than 0 and warning
us in page_pool_inflight()[1].

Since the inflight value goes negative, it means we should
not expect the whole page_pool to get back to work normally.

This patch mitigates the adverse effect by not rescheduling
the kworker when detecting the inflight negative in
page_pool_release_retry().

[1]
[Mon Feb 10 20:36:11 2025] ------------[ cut here ]------------
[Mon Feb 10 20:36:11 2025] Negative(-51446) inflight packet-pages
...
[Mon Feb 10 20:36:11 2025] Call Trace:
[Mon Feb 10 20:36:11 2025]  page_pool_release_retry+0x23/0x70
[Mon Feb 10 20:36:11 2025]  process_one_work+0x1b1/0x370
[Mon Feb 10 20:36:11 2025]  worker_thread+0x37/0x3a0
[Mon Feb 10 20:36:11 2025]  kthread+0x11a/0x140
[Mon Feb 10 20:36:11 2025]  ? process_one_work+0x370/0x370
[Mon Feb 10 20:36:11 2025]  ? __kthread_cancel_work+0x40/0x40
[Mon Feb 10 20:36:11 2025]  ret_from_fork+0x35/0x40
[Mon Feb 10 20:36:11 2025] ---[ end trace ebffe800f33e7e34 ]---
Note: before this patch, the above calltrace would flood the
dmesg due to repeated reschedule of release_dw kworker.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Link: https://patch.msgid.link/20250214064250.85987-1-kerneljasonxing@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/page_pool.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 335f68eaaa05c..dbe0489e46035 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -387,7 +387,13 @@ static void page_pool_release_retry(struct work_struct *wq)
 	int inflight;
 
 	inflight = page_pool_release(pool);
-	if (!inflight)
+	/* In rare cases, a driver bug may cause inflight to go negative.
+	 * Don't reschedule release if inflight is 0 or negative.
+	 * - If 0, the page_pool has been destroyed
+	 * - if negative, we will never recover
+	 * in both cases no reschedule is necessary.
+	 */
+	if (inflight <= 0)
 		return;
 
 	/* Periodic warning */
-- 
2.39.5


