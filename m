Return-Path: <stable+bounces-127778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E7AA7AB91
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14D83BCE17
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786FB261392;
	Thu,  3 Apr 2025 19:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWvxZYXs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3085126138E;
	Thu,  3 Apr 2025 19:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707068; cv=none; b=uem48ee9/mRrLpjcdr9LRxBjgqxRSJ2wy9VBuFo2N2Xk4mLCSMSbFQ73EBGjcYK06JhEZwdW8XUKupZP97ByFQa3encRNkQB7UFuV3TYNePfpg/nywTTWA5I+eUnTVMJZw93X8NbXKEvl8/D6Q0d5fYb5jSfzfXKYlgPMifA01k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707068; c=relaxed/simple;
	bh=HQCgpjchunj1FJD3SaVOn0xEk0XIX0sRg0O8RbbEhiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jm98Jvb+iSm/IcN6VQ0h2kz49S7K/drZ7TBBZQT3EXQGtG498LhR5TV9PuxdE8MoekgiC02KHjaBCaE6wP+wTU/ef9YjUi+3dhXKwjgfDIu1CYfbTELz16bVPl7se7xqlKeJC7NWR+d0Igld9C9+ThozMcJ7U7FFXQHSkETvgio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWvxZYXs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C171C4CEE8;
	Thu,  3 Apr 2025 19:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707068;
	bh=HQCgpjchunj1FJD3SaVOn0xEk0XIX0sRg0O8RbbEhiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uWvxZYXs1XwXDSv+yLO//ggBpFkb1Ta2Y2/TitN3PU0N23aF00jwS+s1om6hI42od
	 AqljQtM07X5M5zpzbinrc9koBcSfK34ii4+A9GTpoQ5KBsvOM5XmvswICO6EEr79z9
	 04Q0RabRsvV7x4ldodjaN2GDH/gGwNDYrhKFmwsEex4J45jg1rgosgxqIfQy9IkJFf
	 kiX8DPHA5E/gV5WgxpXvToT2xmIf27c11isKHjy7VQj0glTYHGU0efvrLAuS6iNvHF
	 WWD/mlLnQGzD5KklRioS9sBzn85ufRvX7Nl4noZz6u7PIYHB3d4ZHwjphV34R0t9f6
	 Bc2/G8p4Xqw4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.13 09/49] f2fs: don't retry IO for corrupted data scenario
Date: Thu,  3 Apr 2025 15:03:28 -0400
Message-Id: <20250403190408.2676344-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190408.2676344-1-sashal@kernel.org>
References: <20250403190408.2676344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 1534747d3170646ddeb9ea5f7caaac90359707cf ]

F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]

If node block is loaded successfully, but its content is inconsistent, it
doesn't need to retry IO.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 282fd320bdb35..3f7a417bbe817 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -764,8 +764,12 @@ void f2fs_update_inode_page(struct inode *inode)
 		if (err == -ENOENT)
 			return;
 
+		if (err == -EFSCORRUPTED)
+			goto stop_checkpoint;
+
 		if (err == -ENOMEM || ++count <= DEFAULT_RETRY_IO_COUNT)
 			goto retry;
+stop_checkpoint:
 		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_UPDATE_INODE);
 		return;
 	}
-- 
2.39.5


