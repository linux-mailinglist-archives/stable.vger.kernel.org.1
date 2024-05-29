Return-Path: <stable+bounces-47615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAB38D2D75
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 08:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D8971F27BF1
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 06:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D98415FCFE;
	Wed, 29 May 2024 06:41:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5C515F417;
	Wed, 29 May 2024 06:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716964897; cv=none; b=g56IBr6qeczP4Gi7y7gx38d61vs/Q+8M0+hGgJg+IkDmtjYqlQ0Ui/qxOPwlbXrvfqI3P3QYN2HKX+j94ptLswGo8PxDHUJhpRCghI3cPwjrklIVILxKJCB9qSQHgy/f+q5tNgbqxEFZE2SljUo69P4Aj88NIODIVSlmA6koNFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716964897; c=relaxed/simple;
	bh=YWDdmREmUsG2sdnpM6TKccbxM+ep6uFhfemoebxk7Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OveK0W0ReCK4LNiZZQ2Zn/iyLTIETDPe6WWbKbAeIBXUQ+XL5JXGkDQgpwxw8Ed11oV+Uce1kJkP5bX5w+Thm1jd0ioSbDhURgOVfdzKgaYnmdSDMvn5dTaECurLmlbb8ZRmnKWoW9iitD2o3BbUgU9S8M8j+bND4skSI1x/f80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555FAC2BD10;
	Wed, 29 May 2024 06:41:35 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] fs/ntfs3: Rename the label end_reply to end_replay
Date: Wed, 29 May 2024 14:40:53 +0800
Message-ID: <20240529064053.2741996-3-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240529064053.2741996-1-chenhuacai@loongson.cn>
References: <20240529064053.2741996-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The label end_reply is obviously a typo. It should be "replay" in this
context. So rename end_reply to end_replay.

Cc: stable@vger.kernel.org
Fixes: b46acd6a6a627d876898e ("fs/ntfs3: Add NTFS journal")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 fs/ntfs3/fslog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 19c448093df7..87c0e2b52954 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -4661,7 +4661,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 	 * table are not empty.
 	 */
 	if ((!dptbl || !dptbl->total) && (!trtbl || !trtbl->total))
-		goto end_reply;
+		goto end_replay;
 
 	sbi->flags |= NTFS_FLAGS_NEED_REPLAY;
 	if (is_ro)
@@ -5090,7 +5090,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 
 	sbi->flags &= ~NTFS_FLAGS_NEED_REPLAY;
 
-end_reply:
+end_replay:
 
 	err = 0;
 	if (is_ro)
-- 
2.43.0


