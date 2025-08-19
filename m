Return-Path: <stable+bounces-171686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3500DB2B54B
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 02:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C36BF7AFE98
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 00:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B0A1C69D;
	Tue, 19 Aug 2025 00:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpxzXNG/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745B6CA6B
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 00:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755563213; cv=none; b=Ma0J4mDqSCzSOSGDkiBw6XVvbQctdTF4mj67xKNRAkUu798AX/KpFTkNGryGA2KhDZsmGQnxanvKVznl9bl8Vlhfjf+Dv03H/UAQpJXm/NHZQevvzv7Wto90jrVJB7cLlVjEH1dVhcKIfTHEyi4SC9xmcdlvEK/cF3l8II3VAkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755563213; c=relaxed/simple;
	bh=GbaW/jRLL2YCh8mut1lc31ddJgiDHiUCFY8F1T27Ewc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5Ud0imD6v/naUt8aml91PjUIM0xl0uX3pS1Fdg1+ZJRB8JgmVbcNtw9sZdpAVtjvVgslb3KJuhJpF7lV+mdIgf8yN82iARvP2uxO8OmTFO9bkRnPeMUI06uAySQ9hIkILBFtD9NW6jLQ4VylodM2sftfwmhX4qbLKQ8cDqj2lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpxzXNG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A0EC4CEEB;
	Tue, 19 Aug 2025 00:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755563213;
	bh=GbaW/jRLL2YCh8mut1lc31ddJgiDHiUCFY8F1T27Ewc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HpxzXNG/1QZHiFVwN1xGPubVZBfMTDM7tlxlPljl0sF1NG9eIQVKdCD8pErWve9k9
	 FsJQQhEJSzs0cEiANWISisY2hlYp3iswILV6lM5DL1nRmub7DloSvHqvyatyd0C/85
	 1KunLadflpgTf/aEyZr4SLkCKN/tSRCrYSmY3/oZMP4iWsyHlTcVJhf+3JsLIA0uQV
	 keRqK/6FYYa9yQfHiYASL1P+HTU3/R/DJZn9B7McIKcfUJ0Na0cCrtCwXqE+KvuXRs
	 dHhvrTROILpaLOreAS15xwIljaG0gaSqE2kiPAIypeIZYas/CNhj4xxPzfNn9ZN3jJ
	 W4iCSklJGILmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15.y 1/2] btrfs: move transaction aborts to the error site in add_block_group_free_space()
Date: Mon, 18 Aug 2025 20:26:49 -0400
Message-ID: <20250819002650.221088-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081808-companion-arson-989c@gregkh>
References: <2025081808-companion-arson-989c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Sterba <dsterba@suse.com>

[ Upstream commit b63c8c1ede4407835cb8c8bed2014d96619389f3 ]

Transaction aborts should be done next to the place the error happens,
which was not done in add_block_group_free_space().

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 1f06c942aa70 ("btrfs: always abort transaction on failure to add block group to free space tree")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/free-space-tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 64af363f36dd..d976acf33ab1 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1440,16 +1440,17 @@ int add_block_group_free_space(struct btrfs_trans_handle *trans,
 	path = btrfs_alloc_path();
 	if (!path) {
 		ret = -ENOMEM;
+		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
 	ret = __add_block_group_free_space(trans, block_group, path);
+	if (ret)
+		btrfs_abort_transaction(trans, ret);
 
 out:
 	btrfs_free_path(path);
 	mutex_unlock(&block_group->free_space_lock);
-	if (ret)
-		btrfs_abort_transaction(trans, ret);
 	return ret;
 }
 
-- 
2.50.1


