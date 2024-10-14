Return-Path: <stable+bounces-83661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B13B99BE64
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 05:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26AE281DF5
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 03:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D7B13B287;
	Mon, 14 Oct 2024 03:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kpta0FGM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A7813A25B;
	Mon, 14 Oct 2024 03:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878257; cv=none; b=bOaBNTRB6slmAmgFro/H7M48C4VKX3TDt7jU9Vt1arPnR7hYZPDfg45CdxmVBQK7QO6iZbJzrzizr/CFGzN8RwpXyUecNOreVxhqUBgGohs0fgo2q02CjD38cvRLAsWsxExNrefcoEECjpHmqyCq2tOx5J3un+3ZwQbUueWf04U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878257; c=relaxed/simple;
	bh=AZSLE5u636YRwv58zS/iaUVsjZjUtUpnDiCxk2qw0to=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SI1D076NU9SSs3gnN7q3IJ4ZbELnloQQLyQkLNMGMw3I1+LKQ9TL6IdSTH/uCycTYRUowlk+7NLjUwi1Vp0JvdJAopLSHrXbjNQzQU9wUvw90eky0xAoPj0b3hy/mtiKkG86MyoJXS2VpoVU8zzc7MA1qeM4umY1Goea/vsvUX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kpta0FGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282EAC4AF09;
	Mon, 14 Oct 2024 03:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878256;
	bh=AZSLE5u636YRwv58zS/iaUVsjZjUtUpnDiCxk2qw0to=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kpta0FGMQc0LPqkcScLGK2fQA9t1oN1vmWQuSlfxrJN6m0Fe1goXz1HFOOpMDocB9
	 fEryOOP8IUBRdebbpIoZUk1NC2Gzb77tOohQELknLWzdxSXvRQjeV7y9M7jcPzo1ZW
	 xsW3Ct9xhmDj0k32/0qtit90wwf38mbJ0LrhGhBb8CEmiYgV9SxNZWtNbHNkrhExN3
	 aL6N2dzjast+DyBUofZMFWV+IGkFsAri5b0bDqpWyDjBylmAdgAQjhPPDaSp8YWPUP
	 WuBLnpV7W5Ad1/eBGG5hJ6giAAmC+62RmrNhzlbsKXRDBOPrXy1T7IYn5GiEhd+PSW
	 jBvgTCUiIBDIQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+c2ada45c23d98d646118@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 03/20] fs/ntfs3: Fix warning possible deadlock in ntfs_set_state
Date: Sun, 13 Oct 2024 23:57:05 -0400
Message-ID: <20241014035731.2246632-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035731.2246632-1-sashal@kernel.org>
References: <20241014035731.2246632-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.3
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
index e5255a251929a..79047cd546117 100644
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


