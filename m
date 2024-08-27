Return-Path: <stable+bounces-70529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC5B960E97
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA281F22815
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB8A1C4EF9;
	Tue, 27 Aug 2024 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eCJFefNr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC651BA87C;
	Tue, 27 Aug 2024 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770211; cv=none; b=Ibcal5nmYSxXY0e7ItpUmgmB8r1rmXrZ/PfUX7ui57GcQpurXH8kRNNLOQNpkpEDyY/RnBdLUfw8psQe+hJe+/eIqb6wy/yoVfv8sdfp6jO1C/Of+d2VjZTCTunjkBfsH/2Exdi6Xj2mNWMD83Qa0fgjdOXkfspFLKVRstcTxK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770211; c=relaxed/simple;
	bh=l0my1M8ei7B8IhnfpK7GZGvbB59FsSZTy2NMY1w/Nlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azvlNkksQeWoGujfSyp/iHDu8O0SUaFSYvU3d4o9RV5VCWoC8JkCdmtCQatLXeDLiNFPUCO0OcVBqfUpYkpidkTA2Ux48IYuKssAO2w6YTTiEEAYQUggiFKOYEThmRIA+5att0J/vkW/SifchpAJ1xaRW1q2ntoaTKHmsgmFL/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eCJFefNr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE15AC4DDF5;
	Tue, 27 Aug 2024 14:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724770211;
	bh=l0my1M8ei7B8IhnfpK7GZGvbB59FsSZTy2NMY1w/Nlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eCJFefNrdJOFZY6ikVR6asNrpOK6zRW8K8CnI/DxgikTg7+nfcArqvyXtH4T2T86W
	 xERnuQPjHU/J9m8bki06mvxZrFBohGtImpJQ6qL6QylH39fpz3TYD76Kt3a2CVKqne
	 qUGoeHjpW/F3UyTQ6xg8ShPKFG4vCN4z1JPwabAg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Neel Natu <neelnatu@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 161/341] kernfs: fix false-positive WARN(nr_mmapped) in kernfs_drain_open_files
Date: Tue, 27 Aug 2024 16:36:32 +0200
Message-ID: <20240827143849.542168638@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
References: <20240827143843.399359062@linuxfoundation.org>
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

From: Neel Natu <neelnatu@google.com>

[ Upstream commit 05d8f255867e3196565bb31a911a437697fab094 ]

Prior to this change 'on->nr_mmapped' tracked the total number of
mmaps across all of its associated open files via kernfs_fop_mmap().
Thus if the file descriptor associated with a kernfs_open_file was
mmapped 10 times then we would have: 'of->mmapped = true' and
'of_on(of)->nr_mmapped = 10'.

The problem is that closing or draining a 'of->mmapped' file would
only decrement one from the 'of_on(of)->nr_mmapped' counter.

For e.g. we have this from kernfs_unlink_open_file():
        if (of->mmapped)
                on->nr_mmapped--;

The WARN_ON_ONCE(on->nr_mmapped) in kernfs_drain_open_files() is
easy to reproduce by:
1. opening a (mmap-able) kernfs file.
2. mmap-ing that file more than once (mapping just once masks the issue).
3. trigger a drain of that kernfs file.

Modulo out-of-tree patches I was able to trigger this reliably by
identifying pci device nodes in sysfs that have resource regions
that are mmap-able and that don't have any driver attached to them
(steps 1 and 2). For step 3 we can "echo 1 > remove" to trigger a
kernfs_drain.

Signed-off-by: Neel Natu <neelnatu@google.com>
Link: https://lore.kernel.org/r/20240127234636.609265-1-neelnatu@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/kernfs/file.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 180906c36f515..332d08d2fe0d5 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -532,9 +532,11 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
 		goto out_put;
 
 	rc = 0;
-	of->mmapped = true;
-	of_on(of)->nr_mmapped++;
-	of->vm_ops = vma->vm_ops;
+	if (!of->mmapped) {
+		of->mmapped = true;
+		of_on(of)->nr_mmapped++;
+		of->vm_ops = vma->vm_ops;
+	}
 	vma->vm_ops = &kernfs_vm_ops;
 out_put:
 	kernfs_put_active(of->kn);
-- 
2.43.0




