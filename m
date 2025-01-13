Return-Path: <stable+bounces-108472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EACA0BFEA
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 19:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854441881E02
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 18:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EC11C8FD7;
	Mon, 13 Jan 2025 18:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2p6IHo7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FDF1C878A;
	Mon, 13 Jan 2025 18:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793277; cv=none; b=gchvvy54+mjMH8uWCeAZi/Yh+k0vtGc40L7kg/jN/FFTF/csyP4G8u/lJoN2fjzQUKp6Xdh8hpqpmPXUV+LIdqo6u/AS8ngt1lqkjjze/DuLMmdi2AOjTTOqUt/pPdwiwm5/UlaxOORhk49CEi2EEfXgJYWqMWEpIicWbnCoTw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793277; c=relaxed/simple;
	bh=meyT/138H6uUKnNJHS7jtwUHgEzJzLhv8vD2EEV3VTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u04im8hCF+l0oXL4m8BtRoRLAPw2zHYHSIiA8RhZg+bfdPrDFA0j4TPsuxxZq6PWvrJ1YW31SwGCfA/pX4gRcB3Sf6FzwxhIoN+mOifWfVGTkIIzC4M5Ut3s7miOsUzaqTuHvvtamstzZYH23+FEQaGRBpeGZ94elDtpM9CDWfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2p6IHo7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDA7C4CEE3;
	Mon, 13 Jan 2025 18:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793277;
	bh=meyT/138H6uUKnNJHS7jtwUHgEzJzLhv8vD2EEV3VTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H2p6IHo79ybj0FTsC+Aga+a0xz5ceIsrOfNBegJD7LoI7rcjaiW/Vhl90wYRSWKAr
	 BN3knObODxLojfiZavwP2Z+WQBGJ7kTlJ+TemFaDm4rRuWfc0bq5tjnnW34mVjokfV
	 j8XdekLK9yWJBQQzHx/CnK7b/+yxLLa5hRH707NejIxcyPxazqd1Bb+fIgezzP2QbX
	 ppouxpcqAQt0K5HK5Ujh8dwEQbutap5PKQkWfCw7yk4reLMTgXBhKS42XNyRGSPgg4
	 BmMwATqPboIlypi4iP22QW7Rnu9P/hLhBGZRwSsK1md2yoQFnwCyRc8X31wWZM4apU
	 sxJHyM4zOTqmg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brahmajit Das <brahmajit.xyz@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	willy@infradead.org,
	josef@toxicpanda.com,
	bodonnel@redhat.com,
	quic_jjohnson@quicinc.com,
	zhouchengming@bytedance.com
Subject: [PATCH AUTOSEL 6.12 03/20] fs/qnx6: Fix building with GCC 15
Date: Mon, 13 Jan 2025 13:34:08 -0500
Message-Id: <20250113183425.1783715-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183425.1783715-1-sashal@kernel.org>
References: <20250113183425.1783715-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.9
Content-Transfer-Encoding: 8bit

From: Brahmajit Das <brahmajit.xyz@gmail.com>

[ Upstream commit 989e0cdc0f18a594b25cabc60426d29659aeaf58 ]

qnx6_checkroot() had been using weirdly spelled initializer - it needed
to initialize 3-element arrays of char and it used NUL-padded
3-character string literals (i.e. 4-element initializers, with
completely pointless zeroes at the end).

That had been spotted by gcc-15[*]; prior to that gcc quietly dropped
the 4th element of initializers.

However, none of that had been needed in the first place - all this
array is used for is checking that the first directory entry in root
directory is "." and the second - "..".  The check had been expressed as
a loop, using that match_root[] array.  Since there is no chance that we
ever want to extend that list of entries, the entire thing is much too
fancy for its own good; what we need is just a couple of explicit
memcmp() and that's it.

[*]: fs/qnx6/inode.c: In function ‘qnx6_checkroot’:
fs/qnx6/inode.c:182:41: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
  182 |         static char match_root[2][3] = {".\0\0", "..\0"};
      |                                         ^~~~~~~
fs/qnx6/inode.c:182:50: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
  182 |         static char match_root[2][3] = {".\0\0", "..\0"};
      |                                                  ^~~~~~

Signed-off-by: Brahmajit Das <brahmajit.xyz@gmail.com>
Link: https://lore.kernel.org/r/20241004195132.1393968-1-brahmajit.xyz@gmail.com
Acked-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/qnx6/inode.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 85925ec0051a..3310d1ad4d0e 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -179,8 +179,7 @@ static int qnx6_statfs(struct dentry *dentry, struct kstatfs *buf)
  */
 static const char *qnx6_checkroot(struct super_block *s)
 {
-	static char match_root[2][3] = {".\0\0", "..\0"};
-	int i, error = 0;
+	int error = 0;
 	struct qnx6_dir_entry *dir_entry;
 	struct inode *root = d_inode(s->s_root);
 	struct address_space *mapping = root->i_mapping;
@@ -189,11 +188,9 @@ static const char *qnx6_checkroot(struct super_block *s)
 	if (IS_ERR(folio))
 		return "error reading root directory";
 	dir_entry = kmap_local_folio(folio, 0);
-	for (i = 0; i < 2; i++) {
-		/* maximum 3 bytes - due to match_root limitation */
-		if (strncmp(dir_entry[i].de_fname, match_root[i], 3))
-			error = 1;
-	}
+	if (memcmp(dir_entry[0].de_fname, ".", 2) ||
+	    memcmp(dir_entry[1].de_fname, "..", 3))
+		error = 1;
 	folio_release_kmap(folio, dir_entry);
 	if (error)
 		return "error reading root directory.";
-- 
2.39.5


