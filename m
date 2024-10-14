Return-Path: <stable+bounces-83700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0112599BEC8
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29BB31C22755
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 04:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F05A1A4F13;
	Mon, 14 Oct 2024 03:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqO/OBqz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CFC145B18;
	Mon, 14 Oct 2024 03:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878336; cv=none; b=GNsoPa01M6Tmwajg+hAueTQc+m5D7j44iXf7X7kAKOOu6qE666T1BZLu97h2Y7Zk0Jvf8VPujfA6ZJwLeBbEM4PpNJeBYMK6pI2C/cz1vqfWfPB5PULsuBsq3Eb9W2+lc54KeLlWq3HsUnhgrdgBLKI9BgO67xVdDUt+8Z/Lh4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878336; c=relaxed/simple;
	bh=l9CPfeX3T6QhLr8nM+G9xBjbSUfXhNiE8pZfFYilJyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4IUoqd3wth6qed7narKbz/X5T33zfOkKnlVqe0wsgH+h2EU+KwpWGheYVsSw9jfZGRxkuBxb7WTFRxM1Rr2BlFcdYfqrqpi6XSxLaWqe0U1iajcL06hY7APJSEX0Qaw1+JeUXjbrFtEjqk8Pz2AqhAfRy0PgmjILV1uaIdRmcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqO/OBqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EC1C4CECE;
	Mon, 14 Oct 2024 03:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878336;
	bh=l9CPfeX3T6QhLr8nM+G9xBjbSUfXhNiE8pZfFYilJyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DqO/OBqzHi4XzDGLjIt4/5nQCYdScKwcrjGsSYo9328CXTKAndXih9LOp7L+YkQ1b
	 5Q2TsYbLJSJ/9UQ5ab1/0ZsK4hLDzfkkisr9L7QdzA8h00A0En2Lfar09nJiMO/Mu9
	 F92hZkQLtM53iuguCu2zDiguLb8GMbk6LND56E9OQPc9apyFyo5P3WOki4knhKiDL7
	 Hje2lCkH0zCdJox8r1Hk6AxV925pU3oLXw38pYhnURt+k19pYKnsB879oVvkXKShCt
	 +yNQdejFB607BejjBJc9gEpEE4luO6SH9fcUORgj8mQPN/5NB4nOnd2rsJOfaVzc85
	 NkbnAsPPXu1+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+3bfd2cc059ab93efcdb4@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 05/10] fs/ntfs3: Additional check in ni_clear()
Date: Sun, 13 Oct 2024 23:58:40 -0400
Message-ID: <20241014035848.2247549-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035848.2247549-1-sashal@kernel.org>
References: <20241014035848.2247549-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit d178944db36b3369b78a08ba520de109b89bf2a9 ]

Checking of NTFS_FLAGS_LOG_REPLAYING added to prevent access to
uninitialized bitmap during replay process.

Reported-by: syzbot+3bfd2cc059ab93efcdb4@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/frecord.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index b3299cda59622..44bcc9c7591d9 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -102,7 +102,9 @@ void ni_clear(struct ntfs_inode *ni)
 {
 	struct rb_node *node;
 
-	if (!ni->vfs_inode.i_nlink && ni->mi.mrec && is_rec_inuse(ni->mi.mrec))
+	if (!ni->vfs_inode.i_nlink && ni->mi.mrec &&
+	    is_rec_inuse(ni->mi.mrec) &&
+	    !(ni->mi.sbi->flags & NTFS_FLAGS_LOG_REPLAYING))
 		ni_delete_all(ni);
 
 	al_destroy(ni);
-- 
2.43.0


