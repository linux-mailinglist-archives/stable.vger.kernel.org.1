Return-Path: <stable+bounces-172471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256C0B320EA
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 19:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1340F7ABF15
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660613090C1;
	Fri, 22 Aug 2025 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZO9UQ7CI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2486D3009C1
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755882088; cv=none; b=a5D9MBhWNI/6ERP6MSmmhSu3dc1bU9ApiYq0mancYFnoZXVupn//nYwh+Dw+96jVfcOml6MiI3H79ychkhhYZjTXOvd0Crl+MUFijXMlBuaeS1I0XcDYVcojsCpB4NwWFkwQYKwNUEYEvoLzd6QLHpRm6X8UJ+sB16i1NAfzP/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755882088; c=relaxed/simple;
	bh=Pi43T1r9IvZ2vqeEMBHcik6kzxWzs6y2DlgRnrjbgIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Te/PNaclTOqmatyWHyL/hNkGsKexSSKFIjZpHW4DgftUjkeMZ7N9wmegUj/vdiCzPm0kkmCx+XZU+c4HGZp/aqp+QOkRX72be3uVwCmjOMPQDeVMJ7s1NoyZf5+5Twe85sbsgAGN5qXrEJmqskJFgFX/eqytNUs6NNEIBVSzQco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZO9UQ7CI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E11C4CEED;
	Fri, 22 Aug 2025 17:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755882087;
	bh=Pi43T1r9IvZ2vqeEMBHcik6kzxWzs6y2DlgRnrjbgIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZO9UQ7CIFDJqXgKowQifIorg8wlZ/Xh4c6ZQ3/gBcBCNYWGnYOJOiEVcMGIMQB9PW
	 Thw9vdW3AVU08hKHQeD78SlxsT5TgvmuKxFMBpjvCs3MIzqSZoQwfe/6TtKBQZ7zEX
	 ++cXmfkvG68ZnWwj4aX2W1bhhT7JYaEqfj9eIE+8t/QTxgw78/SeMsOG5Aju2o3bpl
	 yiK5sOts1UsI4tmcz/8a5D6Pn+VXE4kHvgZLcsh8VPRjAtuuzgHywnldOn5YZ7nSZy
	 hryk3VJ7ffJiafvDBi6KMeeQu7JO9KVuhvJB7iCw4k+z5zL12xxVJLxxfEffRbUDFW
	 gWha6YWQoc2Zg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	stable@kernel.org,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ext4: preserve SB_I_VERSION on remount
Date: Fri, 22 Aug 2025 13:01:24 -0400
Message-ID: <20250822170124.1319222-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082139-grudging-earplugs-9567@gregkh>
References: <2025082139-grudging-earplugs-9567@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit f2326fd14a224e4cccbab89e14c52279ff79b7ec ]

IMA testing revealed that after an ext4 remount, file accesses triggered
full measurements even without modifications, instead of skipping as
expected when i_version is unchanged.

Debugging showed `SB_I_VERSION` was cleared in reconfigure_super() during
remount due to commit 1ff20307393e ("ext4: unconditionally enable the
i_version counter") removing the fix from commit 960e0ab63b2e ("ext4: fix
i_version handling on remount").

To rectify this, `SB_I_VERSION` is always set for `fc->sb_flags` in
ext4_init_fs_context(), instead of `sb->s_flags` in __ext4_fill_super(),
ensuring it persists across all mounts.

Cc: stable@kernel.org
Fixes: 1ff20307393e ("ext4: unconditionally enable the i_version counter")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250703073903.6952-2-libaokun@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f829f989f2b5..e8f976bf5c5a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1937,6 +1937,9 @@ int ext4_init_fs_context(struct fs_context *fc)
 	fc->fs_private = ctx;
 	fc->ops = &ext4_context_ops;
 
+	/* i_version is always enabled now */
+	fc->sb_flags |= SB_I_VERSION;
+
 	return 0;
 }
 
@@ -5113,9 +5116,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
 
-	/* i_version is always enabled now */
-	sb->s_flags |= SB_I_VERSION;
-
 	if (ext4_check_feature_compatibility(sb, es, silent))
 		goto failed_mount;
 
-- 
2.50.1


