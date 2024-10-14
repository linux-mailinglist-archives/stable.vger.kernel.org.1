Return-Path: <stable+bounces-83681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382A299BE9A
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6988C1C2357A
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 04:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A195A158535;
	Mon, 14 Oct 2024 03:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQUz7f95"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADF5158214;
	Mon, 14 Oct 2024 03:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878300; cv=none; b=BONe7mE+90aik3KXcbmYsMCYijgKcEOHLVP9MJaf7Bgvsqd07D2gl/EPiyu7yILBjZlplNrGTeXTsc7VnQmOswgNo6jgfVQI/KngkO8rYSsKf/y7BnrZskAYlAb1Wpi98xfnSy26xoifMvB2BVsxn1TeZ/2EMsNYBVYlFNq5QkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878300; c=relaxed/simple;
	bh=HUrnRQW+6a4jkQ+x6ZqtW6+Gj3Exzj4pW6GVIbMGqTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gw9mH86mAB1ymdTzmHZVipd/Mz9ZIBjCHYo+Qvu5hIjeGpW6kw3Q5Oty18944Ijt6s1Zp5TVkKS41M6rhfTSOE+/jIXtQFoWhtyBBjCD7j4PwxhFvFzdWvlfvKn0yW3cHIF0Aqcv3QESBrdYEzoiefwLJnZfRr6ZeQToO9ykZAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQUz7f95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34625C4CED1;
	Mon, 14 Oct 2024 03:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878300;
	bh=HUrnRQW+6a4jkQ+x6ZqtW6+Gj3Exzj4pW6GVIbMGqTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jQUz7f95mqeuClXgWus5e7OuzfUBxumzcZLYpi3/XTlKOMSrYLdB8mqNH/rL6OAon
	 naWsD+LGnVIGRIzUjIkh/3H1d0tvOS5CUoSX9CTizcIL9egOHhJAvg0L3Q4cqccbHj
	 rCzfrN9eRUGvZ0w//qOhY8drF9aKV0x5NpDAvhQwlmElfYo+PUFZk2J0DVeDCivKPZ
	 8EnTmiqwQe7I1WynSyo+TV2SvxfRRfp3m+hl9FvCD2mZGnOjd5XOizRS+B1w61fFrk
	 1uaV0w0eolhiN1gL/+OMXEuUOsNDv3yNr1SyfcetpL2ZHBXBAvE+KleX4rH4weS+nw
	 dkBea0F92eVdQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+c2ada45c23d98d646118@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 03/17] fs/ntfs3: Fix warning possible deadlock in ntfs_set_state
Date: Sun, 13 Oct 2024 23:57:53 -0400
Message-ID: <20241014035815.2247153-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035815.2247153-1-sashal@kernel.org>
References: <20241014035815.2247153-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.56
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
index 28788cf6ba407..cfe9d3bf07f91 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -334,7 +334,7 @@ struct mft_inode {
 
 /* Nested class for ntfs_inode::ni_lock. */
 enum ntfs_inode_mutex_lock_class {
-	NTFS_INODE_MUTEX_DIRTY,
+	NTFS_INODE_MUTEX_DIRTY = 1,
 	NTFS_INODE_MUTEX_SECURITY,
 	NTFS_INODE_MUTEX_OBJID,
 	NTFS_INODE_MUTEX_REPARSE,
-- 
2.43.0


