Return-Path: <stable+bounces-70592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C887960EFF
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E94A1C233FF
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E201C5793;
	Tue, 27 Aug 2024 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WC+I074d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B1B1A0B13;
	Tue, 27 Aug 2024 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770420; cv=none; b=r1wJ/HEcdLWetQWNzLwvLOwzgTVmczSn8ujjkXW7NsTXLo/QYrjhj4+AlVf7wtYAPr8vqwdC/SwuwJmjfLRs6W2SDLOF81UGjvUZ/Kpp8XWk8LpuEkWhe8rVdVT8/bs0Ys7kY4AaebXLX4afnQ8z3ecsjs1ucKxIkE2tZL5Nn6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770420; c=relaxed/simple;
	bh=gRxGGeGyqtdHeIDibJZ958eUV6xSeX65LZgD5LRZ/Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhXysXq1ZF328LXS9zfXI4d4g5vKYlQ7w/ojqn3FM4gRsINQw71yjzLD3ewzQpa+44HuXPEWgL7kjWNtUT+ZdsWRRY7qZ2RJLU00AIfq/AhZBmcTSn0GqbKf6Zuz/mOhebJ3MQwMiF1wfPNlvQA/fK/v5I3evQji9jA7HD6t5aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WC+I074d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361FBC61053;
	Tue, 27 Aug 2024 14:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724770419;
	bh=gRxGGeGyqtdHeIDibJZ958eUV6xSeX65LZgD5LRZ/Yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WC+I074dnO4z8LtocjxEEvdBF3Su1PjD6azpzIIZw4YLEt0P8nTFYYNXKmGqVEYk7
	 JR/5qNNXFvzcB9EVKYvmbV4UZqeYt9LI2m+Yr+kSwpdwVbskeTkXAF3dfbX4BfKyuh
	 jK9317xlhi/15/ZI73i7cc+YAOtdNOqgVJVKKhsM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 192/341] btrfs: change BUG_ON to assertion in tree_move_down()
Date: Tue, 27 Aug 2024 16:37:03 +0200
Message-ID: <20240827143850.718992705@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
References: <20240827143843.399359062@linuxfoundation.org>
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

From: David Sterba <dsterba@suse.com>

[ Upstream commit 56f335e043ae73c32dbb70ba95488845dc0f1e6e ]

There's only one caller of tree_move_down() that does not pass level 0
so the assertion is better suited here.

Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 9da3c72eb6153..163f36eb7491a 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7448,8 +7448,8 @@ static int tree_move_down(struct btrfs_path *path, int *level, u64 reada_min_gen
 	u64 reada_done = 0;
 
 	lockdep_assert_held_read(&parent->fs_info->commit_root_sem);
+	ASSERT(*level != 0);
 
-	BUG_ON(*level == 0);
 	eb = btrfs_read_node_slot(parent, slot);
 	if (IS_ERR(eb))
 		return PTR_ERR(eb);
-- 
2.43.0




