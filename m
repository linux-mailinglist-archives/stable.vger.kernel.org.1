Return-Path: <stable+bounces-83697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B59899BEC1
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415EB1F22D9C
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 04:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372C51A08C4;
	Mon, 14 Oct 2024 03:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcEmEm/Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FDE1A0724;
	Mon, 14 Oct 2024 03:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878333; cv=none; b=Cw3Oi93zsFTMxW72EweRdiZUv3hBwuMk/haPGCpTspLqdWsI7Ms+OHiOaIuJj/DB1TtE6vFBuohapyWa88HANZGmhXoVkMMhY2r2rfFu7fcO0g7CrqJ8ezTdtqJi8y+bO3i6zsFpDmmbiUYhRPmzvKEibqQKeyGR55xXz/AXmfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878333; c=relaxed/simple;
	bh=zAJLZ6vcOwANUP/l/KPEgt+8owItw66k89x9WaNry3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdgFpum/+OAx2CR+2OBKN7Pcc+U3KEWLAzXh3E8+JWtjXFwhRNgsn2ntKxEMBdmZyf8HSobYEtRc13yGZER+5XjbhFzTexebEwdsAyLFslOeVIwwTOIqUWzk73oRFeDyloDQTo7ntwqhBuwZBtonkEI0t6cHIHF04+YIfymWL04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcEmEm/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997FBC4CEC3;
	Mon, 14 Oct 2024 03:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878332;
	bh=zAJLZ6vcOwANUP/l/KPEgt+8owItw66k89x9WaNry3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fcEmEm/Qj1H1WYUpnM3Dt05BJE0AKc/V4YVGXdhafdby5+dUJfkpfON1j+0FFkNpf
	 hgM4sukMTMDENaeBJJdoUpUiTqiYOB9hYCgFxsJOZz1zooT0x3u1DW0qlzfDQHydgY
	 PduvVKRowl7KdGXd4kstb9zelgySFyJSBsTMYud4j2pHb/fZGIRuOATCoADt6HHkvS
	 KjpaJZKKsXMY5LoR9pCCPjJJ8fpk/QvljgBPG4vD8Cy68FToVjExaibYlDHKdFPxch
	 X0L5PAr6i46447pgZD0H+P/WVtwtaQI1eOZBQ3EmBxmYhotsodlJf029jNunnjvnwe
	 q3xPQb3GXW1YA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+c2ada45c23d98d646118@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 02/10] fs/ntfs3: Fix warning possible deadlock in ntfs_set_state
Date: Sun, 13 Oct 2024 23:58:37 -0400
Message-ID: <20241014035848.2247549-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035848.2247549-1-sashal@kernel.org>
References: <20241014035848.2247549-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 5b2db723455a89dc96743d34d8bdaa23a402db2f ]

Use non-zero subkey to skip analyzer warnings.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Reported-by: syzbot+c2ada45c23d98d646118@syzkaller.appspotmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/ntfs_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index a88f6879fcaaa..26dbe1b46fdd1 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -328,7 +328,7 @@ struct mft_inode {
 
 /* Nested class for ntfs_inode::ni_lock. */
 enum ntfs_inode_mutex_lock_class {
-	NTFS_INODE_MUTEX_DIRTY,
+	NTFS_INODE_MUTEX_DIRTY = 1,
 	NTFS_INODE_MUTEX_SECURITY,
 	NTFS_INODE_MUTEX_OBJID,
 	NTFS_INODE_MUTEX_REPARSE,
-- 
2.43.0


