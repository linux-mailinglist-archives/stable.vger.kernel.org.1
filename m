Return-Path: <stable+bounces-132537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB8EA882DD
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D5C77AA748
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD942299CA6;
	Mon, 14 Apr 2025 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U30UE/Kd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A11C2E3386;
	Mon, 14 Apr 2025 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637363; cv=none; b=kvt+OFgv2NzGe7WShGdn85F+2bmPkY4riDtAf2HgOVCLhfliPu9CinxFlxecAEKwuqDxuhY7p60viMgR294FnwLthDP9GE9OUPzWjcOGw6RSOcGuNKDK0tFHCYNeSJbmLt1UAuJZ45ssSRVPH3CUxu/g0nE8GBacowdSj64Jae4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637363; c=relaxed/simple;
	bh=I+36j+CyOb8kFmQbUR4LMjxknVZjHJKc44tiTRjQpeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d8puBl4qyHAK3oAuPtiYEHEYI5Pe5G9Tzh3+uwv2VANmGQ2pweCa3r5ULy5CVTlQ8yPCBAWa4P26xB///30JeLRb7myRnMZwz6VllNT5zBQcbzlVWAqIIJjKklKpDYvAqcQq7QV0SA+8HHN7rzDKLqeUjLDQ/KJ5lhahOejqtBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U30UE/Kd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6EDC4CEE2;
	Mon, 14 Apr 2025 13:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637363;
	bh=I+36j+CyOb8kFmQbUR4LMjxknVZjHJKc44tiTRjQpeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U30UE/KdpnCp0qxdlc8Ex2NNsJdaUqECM1x7QG5Ux11Y6qd9udy4yhip7na92p+wK
	 1WIWs9VyBg8aJshMrXwEujLFHpbRqxsFVccaqx1qs7z1iGIPUoAMlMVpoFqfUJQfPR
	 laCcHVbAw/9+GnRw9MQ0CoDnBIyte6A2Eysr1pnG+UTv9/iUy1hwz1bQ6kKCrE/iYP
	 yMx5ZSDViFJsK/Q0wkNvaB60Nji/ABvznztpm3tf1Nt+a1urz4g7s5bqWI3CORORRT
	 1RDnuOYSrW3z0IIQJBf5o/KSFVokpbEwZ8g/BNF7ljeO7a1IVSOghLXGV53vCJy2zs
	 CezPTpKe8lLhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 14/30] nvme: multipath: fix return value of nvme_available_path
Date: Mon, 14 Apr 2025 09:28:31 -0400
Message-Id: <20250414132848.679855-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132848.679855-1-sashal@kernel.org>
References: <20250414132848.679855-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.23
Content-Transfer-Encoding: 8bit

From: Uday Shankar <ushankar@purestorage.com>

[ Upstream commit e3105f54a51554fb1bbf19dcaf93c4411d2d6c8a ]

The function returns bool so we should return false, not NULL. No
functional changes are expected.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index f25582e4d88bb..561dd08022c06 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -427,7 +427,7 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 	struct nvme_ns *ns;
 
 	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
-		return NULL;
+		return false;
 
 	list_for_each_entry_srcu(ns, &head->list, siblings,
 				 srcu_read_lock_held(&head->srcu)) {
-- 
2.39.5


