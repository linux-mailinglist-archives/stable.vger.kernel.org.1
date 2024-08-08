Return-Path: <stable+bounces-66048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E4994BF8B
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 16:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 301C51C25B64
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 14:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE44918EFC8;
	Thu,  8 Aug 2024 14:21:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E2118E768;
	Thu,  8 Aug 2024 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126883; cv=none; b=n7ED4ofODtF72RG//jG6Iqn9DX8ZdzKHj70Ce85V7RQdMHvheT8s586mkP93Wk9gwe4C7C52HQhFKAmZO0evLJnZ7JGXjnmBddOFz0jl9/MQQdgcjE5egGODvI/QoZgz+7XqNKk3/PsbMMJdrrWnR+DvjXs5Uw8VrBc0p0u4LSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126883; c=relaxed/simple;
	bh=xb1nkess4mMziSd9yl9g244/emxwwaALFsGdq1DT6OA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=mfspqTMETaVSJAPD2Rp0jhS6TR947xUsQnXAI0WSjQM3tPFDvEYuNzVmMHKe+F10cSoAUE8d2feTXh51T5EEP9vl27+yOj4JXE/be/PI5b82FBgeUSea1C/Z/+rLN3Vzv9pVkmzw1ara3377jHpVIUqv9UQO5Tc0QepZ8HvUCS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A03CC4AF10;
	Thu,  8 Aug 2024 14:21:23 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sc416-00000000BR2-0C6C;
	Thu, 08 Aug 2024 10:21:24 -0400
Message-ID: <20240808142123.905578907@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 08 Aug 2024 10:20:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Al Viro <viro@zeniv.linux.org.uk>,
 stable@vger.kernel.org,
 Mathias Krause <minipli@grsecurity.net>
Subject: [for-linus][PATCH 3/9] tracefs: Fix inode allocation
References: <20240808142037.495820579@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Mathias Krause <minipli@grsecurity.net>

The leading comment above alloc_inode_sb() is pretty explicit about it:

  /*
   * This must be used for allocating filesystems specific inodes to set
   * up the inode reclaim context correctly.
   */

Switch tracefs over to alloc_inode_sb() to make sure inodes are properly
linked.

Cc: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20240807115143.45927-2-minipli@grsecurity.net
Fixes: ba37ff75e04b ("eventfs: Implement tracefs_inode_cache")
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 1028ab6d9a74..21a7e51fc3c1 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -42,7 +42,7 @@ static struct inode *tracefs_alloc_inode(struct super_block *sb)
 	struct tracefs_inode *ti;
 	unsigned long flags;
 
-	ti = kmem_cache_alloc(tracefs_inode_cachep, GFP_KERNEL);
+	ti = alloc_inode_sb(sb, tracefs_inode_cachep, GFP_KERNEL);
 	if (!ti)
 		return NULL;
 
-- 
2.43.0



