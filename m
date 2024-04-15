Return-Path: <stable+bounces-39496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CE78A51D4
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 15:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B1D1F23AB6
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AF073526;
	Mon, 15 Apr 2024 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eM37Quom"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AC873501
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188295; cv=none; b=SQny0yQ4JfVi4XTn5epTJq1y6+qoVwSBSHhM3+H0QcUfq5hU2VieVGaEEQ9wY/DTqrkHWbrbDrAXs6wp4Cq7Wu9rxMX2kRgLYOIo1wNpp/UaTSnPztbnKCA+1WQ8sTzJ+9L8K7O3D53mY0w4zzu19zblaNKnnlu5+2zr1ir17ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188295; c=relaxed/simple;
	bh=sUbUqFCvmgi89IyFzqEFi8In9W1JLb56VrKs6KtUjEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baGyeWzE8mUlcS+nuNhyjUOiMXlZt2LNhJXvJ80jEEkHxlwClHDpw56O+zRHYsktec4K4eOTS/AgZJWHOMEly0mO2ucVtU9AEsOy9PyglGsunZadCdMdI8lOF8yZc/a7TZvEu+pE4xFKn3S7yH7v2UzfP7y9u/uIyMR93MCxA54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eM37Quom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561ACC3277B;
	Mon, 15 Apr 2024 13:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713188295;
	bh=sUbUqFCvmgi89IyFzqEFi8In9W1JLb56VrKs6KtUjEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eM37QuomVXkuWXdiXfkwjqTS7jHOpaeuXBexhus1gYiDxd/iwIwbPPKBFJtL+OqHV
	 /P9qOHDFN3VDx3X2IguEBe1I6ai0Pxk1GGu1JJjkRZKvCrPl2IEUcPZlq0vpkdi2UF
	 /+gJ/9fZZTl7GaNGly1frMrTFy0w+Fx7C7jYVhCUtcoKfPkhTCu/U8iVlD1kT7nL5R
	 lBqaI2ytJKETGRxTq5Y3XcqgVoE7B4/MOIxtBlVLeuKeSZpZ6IAPQfddBike8kdFKj
	 uEWcqQheWw6RAkWJfqEm7YIKo0P+68Z1PX+yhEQtOvg3MyGLNZpcRXWZL7ysn1Hykk
	 2mqKuBs00lZSQ==
From: Sasha Levin <sashal@kernel.org>
To: kernel-lts@openela.org
Cc: Filipe Manana <fdmanana@suse.com>,
	stable@vger.kernel.org,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14-openela 005/190] btrfs: fix extent buffer leak after tree mod log failure at split_node()
Date: Mon, 15 Apr 2024 06:48:55 -0400
Message-ID: <20240415105208.3137874-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415105208.3137874-1-sashal@kernel.org>
References: <20240415105208.3137874-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit ede600e497b1461d06d22a7d17703d9096868bc3 ]

At split_node(), if we fail to log the tree mod log copy operation, we
return without unlocking the split extent buffer we just allocated and
without decrementing the reference we own on it. Fix this by unlocking
it and decrementing the ref count before returning.

Fixes: 5de865eebb83 ("Btrfs: fix tree mod logging")
CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ctree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 156716f9e3e21..61ed69c688d58 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3537,6 +3537,8 @@ static noinline int split_node(struct btrfs_trans_handle *trans,
 
 	ret = tree_mod_log_eb_copy(fs_info, split, c, 0, mid, c_nritems - mid);
 	if (ret) {
+		btrfs_tree_unlock(split);
+		free_extent_buffer(split);
 		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
-- 
2.43.0


