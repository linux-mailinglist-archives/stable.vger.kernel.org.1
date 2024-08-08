Return-Path: <stable+bounces-66050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8232594BF8E
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 16:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 188BFB285A1
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 14:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC1018EFEB;
	Thu,  8 Aug 2024 14:21:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB9C18EFC6;
	Thu,  8 Aug 2024 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126883; cv=none; b=Y/BzTxhv9C8T1IoyjtgLWI563/ADqNJ5o5inDnjJd7fZbX7iVhlUJDsxFZ+JtdngkEIUJ7gIrTo1ohZm8MgdXgGT0w74Pev8t3tYWmZVvFnky6S9ZuByvaiKY+vipuOCv3dbpE1JxdEJypYepAlqYUtvPjQRRYIMHwzH9+EFkbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126883; c=relaxed/simple;
	bh=JabJ5QhBlNkSmBWMfbOaIZD89W/aJXnKKjtFuJG13PA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GWP//61xOb5jT1qF/3KjfRTKV5S8gxaaMfpcAouha++yHhuoxZuYVDgOUKUdN3ZhkIkejAO2X6nmNHx+pCJHCLMmoLx4nMtSOC9Vjt5tldOufXYdVdJvdwjrsOCT9NvaXXvS5afbSvCUOLiwGilIHnsv1tAokTXTmmCVQnRX57E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72229C4AF15;
	Thu,  8 Aug 2024 14:21:23 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sc416-00000000BS0-1WC2;
	Thu, 08 Aug 2024 10:21:24 -0400
Message-ID: <20240808142124.228782864@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 08 Aug 2024 10:20:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 stable@vger.kernel.org,
 Mathias Krause <minipli@grsecurity.net>
Subject: [for-linus][PATCH 5/9] eventfs: Use SRCU for freeing eventfs_inodes
References: <20240808142037.495820579@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Mathias Krause <minipli@grsecurity.net>

To mirror the SRCU lock held in eventfs_iterate() when iterating over
eventfs inodes, use call_srcu() to free them too.

This was accidentally(?) degraded to RCU in commit 43aa6f97c2d0
("eventfs: Get rid of dentry pointers without refcounts").

Cc: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20240723210755.8970-1-minipli@grsecurity.net
Fixes: 43aa6f97c2d0 ("eventfs: Get rid of dentry pointers without refcounts")
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index a9c28a1d5dc8..01e99e98457d 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -112,7 +112,7 @@ static void release_ei(struct kref *ref)
 			entry->release(entry->name, ei->data);
 	}
 
-	call_rcu(&ei->rcu, free_ei_rcu);
+	call_srcu(&eventfs_srcu, &ei->rcu, free_ei_rcu);
 }
 
 static inline void put_ei(struct eventfs_inode *ei)
-- 
2.43.0



