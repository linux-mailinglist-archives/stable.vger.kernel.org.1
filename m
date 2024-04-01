Return-Path: <stable+bounces-34864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DABA5894137
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B1D4B20819
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1292947A6B;
	Mon,  1 Apr 2024 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YTVq0UcS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC71B1E86C;
	Mon,  1 Apr 2024 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989554; cv=none; b=HTUabWArgUZcwz/9sApV/8MrTtdrJBoBbQspDvTtrhaIZsNfeYhZ1f+JvFdxuCv8DPFXlO9ekpylF8wGjjKa8KcNVFPwDSTD3iLmT8OiLyY/KvldRzK8K2bZg0E90bdbLpji1/NEoZ/G1zRgs04D4mgwi3X4sOUe90stbb0asbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989554; c=relaxed/simple;
	bh=o2+BAX5+oykDTaI2ccZQ9t012MT95l7pCe4+UVTItHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ksxlI/Wg2UVgwkdYhnO+mRZllH5jrk/qVuPNgXFXuzyx05xovCT0mSW6NEiztY8SAQsfb1JsQmYaqw1m/37SNSEnxpT4/oTqixUnWtAvVpvMb4EIkM6g2iKoVZIubus15E3SEeELazg+YZR++8EvLzsJM/Wn4Ia2x1dMMTr+k4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YTVq0UcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29347C433F1;
	Mon,  1 Apr 2024 16:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711989554;
	bh=o2+BAX5+oykDTaI2ccZQ9t012MT95l7pCe4+UVTItHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YTVq0UcSjNmrigOhhai91ytjIe8LAR1LD2/cGRCNqNnqs9I2HIcKQtBtAYgd5DVEK
	 zpNVTA9a2UCly5L1aXt/nwuq9M5i+pC/cHR4XxYiiM5mnWfi67UEO/nPNqWpYQafHP
	 paVG2eLFnTBLGe0eIxkXLT0sjGGU5TzMENegmCRU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Antonio SJ Musumeci <trapexit@spawn.link>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 083/396] fuse: fix root lookup with nonzero generation
Date: Mon,  1 Apr 2024 17:42:12 +0200
Message-ID: <20240401152550.392380859@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
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

From: Miklos Szeredi <mszeredi@redhat.com>

[ Upstream commit 68ca1b49e430f6534d0774a94147a823e3b8b26e ]

The root inode has a fixed nodeid and generation (1, 0).

Prior to the commit 15db16837a35 ("fuse: fix illegal access to inode with
reused nodeid") generation number on lookup was ignored.  After this commit
lookup with the wrong generation number resulted in the inode being
unhashed.  This is correct for non-root inodes, but replacing the root
inode is wrong and results in weird behavior.

Fix by reverting to the old behavior if ignoring the generation for the
root inode, but issuing a warning in dmesg.

Reported-by: Antonio SJ Musumeci <trapexit@spawn.link>
Closes: https://lore.kernel.org/all/CAOQ4uxhek5ytdN8Yz2tNEOg5ea4NkBb4nk0FGPjPk_9nz-VG3g@mail.gmail.com/
Fixes: 15db16837a35 ("fuse: fix illegal access to inode with reused nodeid")
Cc: <stable@vger.kernel.org> # v5.14
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dir.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index a4ad01a78e826..a8a7fc0e17547 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -391,6 +391,10 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 	err = -EIO;
 	if (fuse_invalid_attr(&outarg->attr))
 		goto out_put_forget;
+	if (outarg->nodeid == FUSE_ROOT_ID && outarg->generation != 0) {
+		pr_warn_once("root generation should be zero\n");
+		outarg->generation = 0;
+	}
 
 	*inode = fuse_iget(sb, outarg->nodeid, outarg->generation,
 			   &outarg->attr, ATTR_TIMEOUT(outarg),
-- 
2.43.0




