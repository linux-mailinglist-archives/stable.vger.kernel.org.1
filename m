Return-Path: <stable+bounces-48124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5DC8FCCA2
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133D21C23D28
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791AF19ADBB;
	Wed,  5 Jun 2024 11:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1gafLws"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3470319ADA7;
	Wed,  5 Jun 2024 11:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588604; cv=none; b=NjYRNvmT+mElsM/rqtCGmoQQY5MxuYD45YdVqEsDAp+AbVRfouivspZ/d1V6qRymFcQdH0uCW2pnG4Z5SKJJlT8L8c/iVKNnf9gBVhnGo1QKJtaZ5cPi1ZkiYTgM+DiOtzyprzhI3j58Dsn51+6RcbPc3ciNP6lMFPR9MR5mWMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588604; c=relaxed/simple;
	bh=uQIkL1E/HHY6EpoCtNAJE0d56wVqsrIf/eWT7Jo3cpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YdgiBGL3hWEqNbAJpgKovAi4NqzADHwNgs5o+VaTXmxWxSFPlTvT++FPrBvMFRLOSz5dHwBSxYqb2JQqrnpNQFH01gcXJLsCijv2YlbM6rqfahy4iQG+zr2eQ6R5cJVKGpVCdeAfv1hJrmZL7qw4HiSkc2g7rPPXJhFZcuVwIRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1gafLws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734FDC3277B;
	Wed,  5 Jun 2024 11:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588604;
	bh=uQIkL1E/HHY6EpoCtNAJE0d56wVqsrIf/eWT7Jo3cpE=;
	h=From:To:Cc:Subject:Date:From;
	b=h1gafLwslIyjAexC+1OCk4y+K+G6lwaWaPaU6t1acKyWhT6z+pSoyOPddHdSwlEnM
	 lPrjKFUACEqIG5xJrY3cMBSNz+Rs2zlauta6Hs+zIDzaoiEmBm8TRMQS3M0GHHiwO/
	 GseosHiPJRvucdZy9eootScKVJ9CQcsFgI0IuLR9eUHOkELrixO4Qad53xQmRJB4LL
	 ooa0i3a/Sz37p6b5EJyhPLQ+WoJoDTaM9KrkjVp4+kWxjGXFRjYBJ6WGCvL/6+9Oro
	 c4vSKYdg89wLucFed5Xo11ITP85FuHpGtBJz0PW7OEepCqkSXyb9b+Y11FAIKIZlsm
	 XaNw76NqLtHmw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 1/2] fs/ntfs3: Mark volume as dirty if xattr is broken
Date: Wed,  5 Jun 2024 07:56:38 -0400
Message-ID: <20240605115642.2965408-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.160
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 24f6f5020b0b2c89c2cba5ec224547be95f753ee ]

Mark a volume as corrupted if the name length exceeds the space
occupied by ea.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/xattr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index d0b75d7f58a7b..4a7753384b0e9 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -217,8 +217,11 @@ static ssize_t ntfs_list_ea(struct ntfs_inode *ni, char *buffer,
 		if (!ea->name_len)
 			break;
 
-		if (ea->name_len > ea_size)
+		if (ea->name_len > ea_size) {
+			ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_ERROR);
+			err = -EINVAL; /* corrupted fs */
 			break;
+		}
 
 		if (buffer) {
 			/* Check if we can use field ea->name */
-- 
2.43.0


