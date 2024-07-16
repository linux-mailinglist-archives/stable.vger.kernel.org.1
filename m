Return-Path: <stable+bounces-59434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 010F893289E
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A9528268A
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438941A0AF8;
	Tue, 16 Jul 2024 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncGpJLZ8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5181A0AEF;
	Tue, 16 Jul 2024 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139999; cv=none; b=Zr4XrofsPlahQylEgjQqsN/5/Q7vxRVQABjA9ypheQDvyQPSCzQ3JLaghOdYkDsPvPo3fR8BVN0Tk/vkZtxfcvH/EJKTXAZRhK05+SyCv9otyzFu/wcnpBNgHkno4cuEePJWmONt3BqQIpBvdkGY1Cv296Cf1wGh7qajQ22ak9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139999; c=relaxed/simple;
	bh=o999yEuYcVA54k+5MUQHO5GFQI7Kd42PMS8cjrC3XsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZhhTwxjE9JOF/kn3giGZivGPIvyVSGkjgPdVkOniQdH9BZmZLv8t6ZXTIXJ2JbIZGX5nxr198a2cruUguVqjzhWxEmvmsYuguKIxF6FfCU1LJBzLvt3ZOOneHZINCkIRBfg0qrvfTrl/blqpUQwhJluJuND6DYqN0ER4u7I/C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncGpJLZ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24DFC116B1;
	Tue, 16 Jul 2024 14:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721139998;
	bh=o999yEuYcVA54k+5MUQHO5GFQI7Kd42PMS8cjrC3XsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ncGpJLZ8JzaMIxwpI+C5eeOB2DNhjv0gjOG6y4Az6sksoMZynlevdMZ5iNy2luhv1
	 V3quDO+9cdSQBMTtGHoYT44/Lwlfr8nHBIDNcJIBD+D9vJlX+CKvgTlfplkG9usBmk
	 gMukRxPyqUmdIiV8lbh21GnwEVOyzCUOx+zDrE1pcvu/tTv4Lzdm1xSAmLpIOmsN9j
	 9lyhAmHq76002/5CD27z48lQTW++tsUQNl9tCuN3wRVyhBfxjHdnGIHbTXQF1U0JQG
	 0o1noOlEv8Auq3WA43u41AJAQbPLPumSvwVo9XD2zXFIayXt7CorcaeB2gdBF8c0t+
	 IQrGdAn5t+SEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Mirsad Todorovac <mtodorovac69@gmail.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 18/22] btrfs: fix uninitialized return value in the ref-verify tool
Date: Tue, 16 Jul 2024 10:24:25 -0400
Message-ID: <20240716142519.2712487-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142519.2712487-1-sashal@kernel.org>
References: <20240716142519.2712487-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.9
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 9da45c88e124f13a3c4d480b89b298e007fbb9e4 ]

In the ref-verify tool, when processing the inline references of an extent
item, we may end up returning with uninitialized return value, because:

1) The 'ret' variable is not initialized if there are no inline extent
   references ('ptr' == 'end' before the while loop starts);

2) If we find an extent owner inline reference we don't initialize 'ret'.

So fix these cases by initializing 'ret' to 0 when declaring the variable
and set it to -EINVAL if we find an extent owner inline references and
simple quotas are not enabled (as well as print an error message).

Reported-by: Mirsad Todorovac <mtodorovac69@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/59b40ebe-c824-457d-8b24-0bbca69d472b@gmail.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ref-verify.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 8c4fc98ca9ce7..aa7ddc09c55fa 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -441,7 +441,8 @@ static int process_extent_item(struct btrfs_fs_info *fs_info,
 	u32 item_size = btrfs_item_size(leaf, slot);
 	unsigned long end, ptr;
 	u64 offset, flags, count;
-	int type, ret;
+	int type;
+	int ret = 0;
 
 	ei = btrfs_item_ptr(leaf, slot, struct btrfs_extent_item);
 	flags = btrfs_extent_flags(leaf, ei);
@@ -486,7 +487,11 @@ static int process_extent_item(struct btrfs_fs_info *fs_info,
 						  key->objectid, key->offset);
 			break;
 		case BTRFS_EXTENT_OWNER_REF_KEY:
-			WARN_ON(!btrfs_fs_incompat(fs_info, SIMPLE_QUOTA));
+			if (!btrfs_fs_incompat(fs_info, SIMPLE_QUOTA)) {
+				btrfs_err(fs_info,
+			  "found extent owner ref without simple quotas enabled");
+				ret = -EINVAL;
+			}
 			break;
 		default:
 			btrfs_err(fs_info, "invalid key type in iref");
-- 
2.43.0


