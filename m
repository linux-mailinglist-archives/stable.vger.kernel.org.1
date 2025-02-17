Return-Path: <stable+bounces-115585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77BFA34519
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9823D3B15E8
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6432222DE;
	Thu, 13 Feb 2025 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r5plMj6I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277C6221713;
	Thu, 13 Feb 2025 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458549; cv=none; b=jk5cg6dt8M57KnH/ERNDN5C8MlSl28Un7RKKxbBW6LfllHMOyRw0G5UO/mJVkO4OcjmOl6Mo7c8qCDdOI6sloIN20CsXJNorsqHTjK3eRuRbYVIYMwFw++y/1FL/u948d7PaSu7tSI4MXrsuTWZIufl2wGCIhWQMB00Srm1rQdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458549; c=relaxed/simple;
	bh=R/l/qZUUImEsNmMXRo1iSoVI4sNLcP+YhBCR/bP3Qtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5yPWzo34aB/OMvzCfyeIjbLrlMka2hLWJKF3yyglFke93LOBFazdBhkBaZpo5oDP6j+tkJYDhnrC2XgLoJLV17EzxvqRb8ywBHaPuv9kjbVdXgsY1XYFxmPTPNHVxotu+Fqev/vT3aq6266OohHy8SPMgwD9Bte42PBYiZY7NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r5plMj6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8925EC4CED1;
	Thu, 13 Feb 2025 14:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739458549;
	bh=R/l/qZUUImEsNmMXRo1iSoVI4sNLcP+YhBCR/bP3Qtc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r5plMj6IwHz/5uHDYV+vMqDWp2IPwkHIx6qfmHkBHch30izDwLOdE5vr/JNpNRu8B
	 JHInDksr7998MFXhGCmtYIoKsq6eaEKfd1e2jFjDLJqlAacStp7+jIMb6GS15IhIC7
	 gSD1F58zpeMduBzuZqrfF96S7PMc+u2k3+kSe4Po=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Boris Burkov <boris@bur.io>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 010/443] btrfs: convert BUG_ON in btrfs_reloc_cow_block() to proper error handling
Date: Thu, 13 Feb 2025 15:22:55 +0100
Message-ID: <20250213142441.019189047@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>
References: <20250213142440.609878115@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 6a4730b325aaa48f7a5d5ba97aff0a955e2d9cec ]

This BUG_ON is meant to catch backref cache problems, but these can
arise from either bugs in the backref cache or corruption in the extent
tree.  Fix it to be a proper error.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/relocation.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index db8b42f674b7c..ab2de2d1b2bee 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4405,8 +4405,18 @@ int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
 		WARN_ON(!first_cow && level == 0);
 
 		node = rc->backref_cache.path[level];
-		BUG_ON(node->bytenr != buf->start &&
-		       node->new_bytenr != buf->start);
+
+		/*
+		 * If node->bytenr != buf->start and node->new_bytenr !=
+		 * buf->start then we've got the wrong backref node for what we
+		 * expected to see here and the cache is incorrect.
+		 */
+		if (unlikely(node->bytenr != buf->start && node->new_bytenr != buf->start)) {
+			btrfs_err(fs_info,
+"bytenr %llu was found but our backref cache was expecting %llu or %llu",
+				  buf->start, node->bytenr, node->new_bytenr);
+			return -EUCLEAN;
+		}
 
 		btrfs_backref_drop_node_buffer(node);
 		atomic_inc(&cow->refs);
-- 
2.39.5




