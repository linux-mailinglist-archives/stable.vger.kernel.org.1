Return-Path: <stable+bounces-59703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AABC932B5A
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7D71C22D30
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1202136643;
	Tue, 16 Jul 2024 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d6XlJgZH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD9CF9E8;
	Tue, 16 Jul 2024 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144651; cv=none; b=eGJ7d20mpSkd6Oet7Z9twKMwIgkMS5tBJ8moNPpFodh5YKFJAuheUyKdjj7YdiIdz/vG9OaABY4mE2ifkZxTemD4XAx6Lrdqn9SYAfxmrg3v/7fwkOBGz18UDFhp1blII6ytAO2bu8ttugLTtITlWvWOFM8Qb6pamBm1UATYcbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144651; c=relaxed/simple;
	bh=t9WQUtINYhOACtm3FnYeDfgSbpbXnoZDTKYSgEiMKqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hD2KZWoV5vgfkVYc9zRI5ILfO0deU93CNQSz7zOi5uLuBwZS6ogtyPEjvP94++AJpgkQUAG+X/RqtXCKPjIE/EoR+pq7BTiyVG8OdaApgqXH/4tWHhzpCYDx+lAJll7GHQguMvaM15KWYF73UovqQ9yKsbNY3iIJDWEi2wJMLqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d6XlJgZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2D8C116B1;
	Tue, 16 Jul 2024 15:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721144651;
	bh=t9WQUtINYhOACtm3FnYeDfgSbpbXnoZDTKYSgEiMKqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d6XlJgZHVSIzzs1PN7f4Hyo11URTIeHWRCWVQYE42VoYUM3wgudV3X/c26gKUWkcj
	 rDuISdeb6ZrYwtUAQmZkQjEd51fGC92prwp6MgsoyT/rL8BquDzdoUNv289KZKkb4t
	 i0YDTe9U+/GlDXiFz8UWcinGrjIQUJPzhJKxn2dg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linke li <lilinke99@qq.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 060/108] fs/dcache: Re-use value stored to dentry->d_flags instead of re-reading
Date: Tue, 16 Jul 2024 17:31:15 +0200
Message-ID: <20240716152748.288955650@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152745.988603303@linuxfoundation.org>
References: <20240716152745.988603303@linuxfoundation.org>
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

From: linke li <lilinke99@qq.com>

[ Upstream commit 8bfb40be31ddea0cb4664b352e1797cfe6c91976 ]

Currently, the __d_clear_type_and_inode() writes the value flags to
dentry->d_flags, then immediately re-reads it in order to use it in a if
statement. This re-read is useless because no other update to
dentry->d_flags can occur at this point.

This commit therefore re-use flags in the if statement instead of
re-reading dentry->d_flags.

Signed-off-by: linke li <lilinke99@qq.com>
Link: https://lore.kernel.org/r/tencent_5E187BD0A61BA28605E85405F15228254D0A@qq.com
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: aabfe57ebaa7 ("vfs: don't mod negative dentry count when on shrinker list")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 976c7474d62a9..d2ebee3a120c4 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -329,7 +329,7 @@ static inline void __d_clear_type_and_inode(struct dentry *dentry)
 	flags &= ~(DCACHE_ENTRY_TYPE | DCACHE_FALLTHRU);
 	WRITE_ONCE(dentry->d_flags, flags);
 	dentry->d_inode = NULL;
-	if (dentry->d_flags & DCACHE_LRU_LIST)
+	if (flags & DCACHE_LRU_LIST)
 		this_cpu_inc(nr_dentry_negative);
 }
 
-- 
2.43.0




