Return-Path: <stable+bounces-105564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E119FA8A3
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 00:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AFF17A1F1D
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 23:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E191993B6;
	Sun, 22 Dec 2024 23:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0ggchTu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F93A198A01;
	Sun, 22 Dec 2024 23:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734909147; cv=none; b=Ezwc3K7dw/Vkz9/vhznF/zIhzfarBNu22h8uiQbGEbqUB2c7k3uAj9Cjui3/CCMBXvgFKkMlHLfbUBbmJQbBcWLN1q8j13DpTwOqdAq3LBZYg6YjyU6D6Wt0oJrNiVz7FmZavhZtGcHcPLh6YHgOay+7GSiGm4+muT+wFtI1ksY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734909147; c=relaxed/simple;
	bh=zvpnzpnU6SEsn/lS2CcE/GaMIrv4lRmkiTD51TF9JK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VaruZHK655+v3/3srFebb+4VWgtd0BBn4gU/jEYDDaF/9/rgfqIk6YFrk2LRLfOQSGzqs1j5CuO3dgaf3rgHIDiHs2PVgQrrSERpBMFZ9nTnQDH7ZJYElxNQh0sgnNDuVnethI+cyKNZ28O1MmSRIM2VUcTESrA2ppcaXAVrjHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0ggchTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE365C4CECD;
	Sun, 22 Dec 2024 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734909145;
	bh=zvpnzpnU6SEsn/lS2CcE/GaMIrv4lRmkiTD51TF9JK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W0ggchTuurFk/4bVT7d6P1pbWuYieEKHqJaICN3aHGVUWNzUSjiNo4BsPlE/RH3XW
	 SQ4lp2SVVQukk9ETBPKbEDXe0C/PCNAJtMKrWn/3/bmx0cKfb69pPjJFDn0XOeM8P+
	 vfn9XMjpaxNpgVNE46SBYchgHg8Ew1XLDnm5/rsavJfY+rth5hrdKLEEdoZksys22V
	 3h+SqDrUMFjwElMOKgkBdysVpScq3CiOe10FMBw1mSsNHtoAGIfgFFDeOexYUpGIhk
	 XROXbwrjhj+apd1SrSGKONqcxQXNC6J+92mZ5lF7tu6Yspy0zUuE6lEppy1OI4pYvN
	 zL/84F2RZR10A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mm/damon/core: fix new damon_target objects leaks on damon_commit_targets()
Date: Sun, 22 Dec 2024 15:12:21 -0800
Message-Id: <20241222231222.85060-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241222231222.85060-1-sj@kernel.org>
References: <20241222231222.85060-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When new DAMON targets are added via damon_commit_targets(), the newly
created targets are not deallocated when updating the internal data
(damon_commit_target()) is failed.  Worse yet, even if the setup is
successfully done, the new target is not linked to the context.  Hence,
the new targets are always leaked regardless of the internal data setup
failure.  Fix the leaks.

Fixes: 9cb3d0b9dfce ("mm/damon/core: implement DAMON context commit function")
Cc: <stable@vger.kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index a71703e05300..931e8e4b1333 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -961,8 +961,11 @@ static int damon_commit_targets(
 			return -ENOMEM;
 		err = damon_commit_target(new_target, false,
 				src_target, damon_target_has_pid(src));
-		if (err)
+		if (err) {
+			damon_destroy_target(new_target);
 			return err;
+		}
+		damon_add_target(dst, new_target);
 	}
 	return 0;
 }
-- 
2.39.5


