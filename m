Return-Path: <stable+bounces-83707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4BB99BEDE
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7600E1C21A5E
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 04:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617F61AB6D4;
	Mon, 14 Oct 2024 03:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bR8f3dtM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6941AB6D7;
	Mon, 14 Oct 2024 03:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878373; cv=none; b=CBtDdWfcLS5yeCHyJ42O3QPBDDOQ3rJg7WbRLj4AuK+ckRdxcnuzQkc+pfBBvp6XIErf86BlKn1qUy/EzeaAGVJntX41IN6kkJ24A9TvNYkROt69w8GfiXGdZTgIve2sRVX5ALa0QnWvJX6y24VXhxO+2NlN+xFkOCt5y+M9dB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878373; c=relaxed/simple;
	bh=gGIyYUJnHlLrVScmyBAWeLoH9u0AXPLQxtYfGgXoIzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=is6keKjv2wA32C36IJQWDN31b+MPOiOmUIKXyNQJ1PJSFtGpVQ3Gp6khd7TvTpBcp9/sHtv1gOuwg+DbZ1pbS0qdPYQ4fPg3FhAb5guU1lDsxsQvVE1dgZ5Bizc8Z6AmJvxTbD6zSfp5GzcQmSnaH9eFou/tGB1JWT4ALoRkj1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bR8f3dtM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0725C4CECE;
	Mon, 14 Oct 2024 03:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878372;
	bh=gGIyYUJnHlLrVScmyBAWeLoH9u0AXPLQxtYfGgXoIzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bR8f3dtMv/fExgCAQYHYqmvAWiNnpyvgqrczBnQ55Y4yq8hhBjOurS6zeN7Qs/gvt
	 AhdZ1PAALqKA57Qv6ulSw0KK7/x7ohbarCkcUcdpRt6+4lYAotufN5/+v98xwT17yk
	 lZFJGv59GFyruxUUF5InD5bRNBC2ec6XdH+oYcJhnIUatjL56gsKmyTquXpFKtTz+K
	 FtmHMVbkernmTcSZkqWfIZrQGZCaR1IVH2Xkg8VEP0xlNScEVZLi3n5cMvdjI2pWeT
	 FOVdE5+t3Brv8LKTvCWISDH68ft1xRoB88zrsZCdW30fRf315UIVAP3UeAMyzpRobf
	 YSivkLniPe8iw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+c2ada45c23d98d646118@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 2/8] fs/ntfs3: Fix warning possible deadlock in ntfs_set_state
Date: Sun, 13 Oct 2024 23:59:17 -0400
Message-ID: <20241014035929.2251266-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035929.2251266-1-sashal@kernel.org>
References: <20241014035929.2251266-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
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
index b4c09b99edd1d..7b46926e920c6 100644
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


