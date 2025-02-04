Return-Path: <stable+bounces-112100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A8FA269AF
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 02:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A84164FE4
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 01:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B985214A69;
	Tue,  4 Feb 2025 01:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6EonZQT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0789B209695;
	Tue,  4 Feb 2025 01:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738631916; cv=none; b=oS3ItzGnj0g80YkT5JYTVflQUo5nsKWY8Vf3DiZ372wVi7NpEWg25Kyq6MPRxUFbTqTOfy3Zt6Oir0luw5FWA39yeKUuh6rqbyjtqisy3UeUIOLMekl18qmi/a5w073AOtgEgpnqxRzT3JtFHiS4QV+vw1q0BHXxZ7vtOskdGsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738631916; c=relaxed/simple;
	bh=U5xUI/dJojXi8jaM2KImFDgZC+wj5t9cCLBkF+tjfyk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QjLGxdLmjlkiMDIPfJvGFSCWdMRmwIcoROnP5OYwYqfVZX1SwtPeamt4fYxvD/Yj3QEuhj9Un2kfQ+o/SYasu0IhdL70LCoznvZuAmBb7BbCjGYuOp06T9Iq/Tvc6z0TsWEtZTHwyrUIJ0+Rnt4FDiSV1GKd1Zh/DIZDDXfuw/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6EonZQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133B5C4CEE7;
	Tue,  4 Feb 2025 01:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738631915;
	bh=U5xUI/dJojXi8jaM2KImFDgZC+wj5t9cCLBkF+tjfyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g6EonZQTuXITPAVXvz6TBOtZlAj8LGvMZzaqDNtVKzqix1YTe+V4SUmF7WNv0+po6
	 avaaMmZoT02A5/4OA5lihSDpOfRtw7++ZoMcbUm4PE9A1S8xAdlYg5i97gNQX1/jNb
	 KpR8xJyiemO94P/xfACgrUF5fo4BkNLAA0BvkCYeKtZ5vFHfoJOcQ4sRdtDz8q27IY
	 0obTNOA1nzQUpEwYCV4aIKjAni9Gwem4v0xKfckmToRJ+eCIlfkJXYX2B6Tm6qM7Sn
	 CDDMV+IVYS3D10vd5RSwtUpzMUIuhZEeBh1BN0FhyPQWImBqpjya5BlWAbPrFBJwqC
	 lQzcjSJiTjsXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mike Marshall <hubcap@omnibond.com>,
	syzbot+fc519d7875f2d9186c1f@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	devel@lists.orangefs.org
Subject: [PATCH AUTOSEL 6.1 2/3] orangefs: fix a oob in orangefs_debug_write
Date: Mon,  3 Feb 2025 20:18:24 -0500
Message-Id: <20250204011828.2207072-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250204011828.2207072-1-sashal@kernel.org>
References: <20250204011828.2207072-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.128
Content-Transfer-Encoding: 8bit

From: Mike Marshall <hubcap@omnibond.com>

[ Upstream commit f7c848431632598ff9bce57a659db6af60d75b39 ]

I got a syzbot report: slab-out-of-bounds Read in
orangefs_debug_write... several people suggested fixes,
I tested Al Viro's suggestion and made this patch.

Signed-off-by: Mike Marshall <hubcap@omnibond.com>
Reported-by: syzbot+fc519d7875f2d9186c1f@syzkaller.appspotmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/orangefs/orangefs-debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugfs.c
index 1b508f5433846..fa41db0884880 100644
--- a/fs/orangefs/orangefs-debugfs.c
+++ b/fs/orangefs/orangefs-debugfs.c
@@ -393,9 +393,9 @@ static ssize_t orangefs_debug_write(struct file *file,
 	 * Thwart users who try to jamb a ridiculous number
 	 * of bytes into the debug file...
 	 */
-	if (count > ORANGEFS_MAX_DEBUG_STRING_LEN + 1) {
+	if (count > ORANGEFS_MAX_DEBUG_STRING_LEN) {
 		silly = count;
-		count = ORANGEFS_MAX_DEBUG_STRING_LEN + 1;
+		count = ORANGEFS_MAX_DEBUG_STRING_LEN;
 	}
 
 	buf = kzalloc(ORANGEFS_MAX_DEBUG_STRING_LEN, GFP_KERNEL);
-- 
2.39.5


