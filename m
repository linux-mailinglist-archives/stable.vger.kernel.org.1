Return-Path: <stable+bounces-31540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B428896E6
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 10:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 545F8B246D6
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 08:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B4D368E14;
	Mon, 25 Mar 2024 02:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCYirlPm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C1E2251E5;
	Sun, 24 Mar 2024 23:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321936; cv=none; b=KvxYz/vsY1bmPfuxa6rb0WAicW1VeYf30/fX1ZU99Yd70lBxdzHcPAoMb9tKQO5ANz6m0+AgszXuqMI8KlsjO6IHVU/LsfLNa65H8vBSEv4Dzdsncq3v4mhNtfbcMQEpl73sAtM4hAUEVHlYKBugPr3Qadt5WXDMt7LIuzCxLO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321936; c=relaxed/simple;
	bh=dtNOvme6ogz8oy0RlFfXP0mN36Z6AcIzo+gAkw5HKh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgCp+r7nNv2ewuDIoCFcby4RvBZRhMtSwCcfeFyDHK42hpADJff+gCvuPq01JhBxeKbq3WpeaJQ1QUhcYzykyVizLIQ8utMZpAlLY4gPApRz8CInf4eNSmZST2b5wzdUj8HDU24Z8blyx1vcaMXsicP8l+50L6i9AtdgArxe2UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCYirlPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CA6C433C7;
	Sun, 24 Mar 2024 23:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321936;
	bh=dtNOvme6ogz8oy0RlFfXP0mN36Z6AcIzo+gAkw5HKh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cCYirlPmgSQKS3WrK5nIHEc00sgJeCD5DUCUvqF7WwN1ZWyHiQBBk38OUrZoIIdLd
	 wsBICc31aFkd8xhpZhhTC33sAkrm4LFvbJ9WKY1YWc2ArP79O/vqQj4G75KIDbZdF9
	 OMTXOq+Fbh7s4Gtq6rhXnbXFMaZqcnL66ads7Tpihu4S+XV/vX81af0txUuw0rNuVI
	 3YXVkBu74jwYJM4+I+9KyMhb6pLWwTqsxwlF6HChMyZdlM0atjiLiQvCwwdu/n8n25
	 cyEES3U30F4VOVpCZu2jHXO4NZqcjrtHbYbyVY3BW59nQ0+nkHP+R4XBLAiyIXPjx9
	 F4f2sN8mLKoZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 007/451] nfsd: NFSD_FILE_KEY_INODE only needs to find GC'ed entries
Date: Sun, 24 Mar 2024 19:04:43 -0400
Message-ID: <20240324231207.1351418-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 6c31e4c98853a4ba47355ea151b36a77c42b7734 ]

Since v4 files are expected to be long-lived, there's little value in
closing them out of the cache when there is conflicting access.

Change the comparator to also match the gc value in the key. Change both
of the current users of that key to set the gc value in the key to
"true".

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/filecache.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 5b5d39ec7b010..c36e3032d4386 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -175,6 +175,8 @@ static int nfsd_file_obj_cmpfn(struct rhashtable_compare_arg *arg,
 
 	switch (key->type) {
 	case NFSD_FILE_KEY_INODE:
+		if (test_bit(NFSD_FILE_GC, &nf->nf_flags) != key->gc)
+			return 1;
 		if (nf->nf_inode != key->inode)
 			return 1;
 		break;
@@ -695,6 +697,7 @@ nfsd_file_queue_for_close(struct inode *inode, struct list_head *dispose)
 	struct nfsd_file_lookup_key key = {
 		.type	= NFSD_FILE_KEY_INODE,
 		.inode	= inode,
+		.gc	= true,
 	};
 	struct nfsd_file *nf;
 
@@ -1049,6 +1052,7 @@ nfsd_file_is_cached(struct inode *inode)
 	struct nfsd_file_lookup_key key = {
 		.type	= NFSD_FILE_KEY_INODE,
 		.inode	= inode,
+		.gc	= true,
 	};
 	bool ret = false;
 
-- 
2.43.0


