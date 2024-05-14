Return-Path: <stable+bounces-44980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346198C5534
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65F381C231A5
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907995103D;
	Tue, 14 May 2024 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w8qQhlYJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE7C2B9AD;
	Tue, 14 May 2024 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687735; cv=none; b=MeAmCAlJlgleuoKVCaWXe3SbXhKFU1bibch5VJTjyMJHbv4eCI0BLIl0Y+z5k6E+1FQ/trq8Gptaq1qBb9UOgMYBG7qnMqDDZAQA6NKISUcG6rR6ay8H6olfo4hDkx20e8SRk/M3LVKOVjw4SaOknZTCbI4dOGGWjSKjahxigpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687735; c=relaxed/simple;
	bh=sgqj05B5GawxJfb35kz89bS7zAfC1u6mzDAfiFhAt+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZYdpttkNkeWkkTcS6UwN7Rbyzf1mcTyYJ+5GiBplUZfrjjy2+PdQhcAOVrVBlgZwmJMw5Sk/02dQ2EZ2hqYlMEr21dPpuLYYtXFHbuibRHCywr0ITklJxn5URSpXapfpvdyKiMyOQnco07dVDktctoWDp1TRGStbGjrq7Jw2gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w8qQhlYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE990C2BD10;
	Tue, 14 May 2024 11:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687735;
	bh=sgqj05B5GawxJfb35kz89bS7zAfC1u6mzDAfiFhAt+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w8qQhlYJ8Tiyx3yPGaNQszzEJ9Yvjbbslv7vWxWFXWuf7YlleaQuXq3DQ2ne9BKK7
	 5sXVubuDUiBH3eBvpHpKDpNJcSDCi9gLg8B6BL6mCXrVgAL8u5f23/FSuAiLfcKOcA
	 7lmJgmWRvbAm9hFo578TKzB1LCHPhOcbNxrBnRvs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joakim Sindholt <opensource@zhasha.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 087/168] fs/9p: translate O_TRUNC into OTRUNC
Date: Tue, 14 May 2024 12:19:45 +0200
Message-ID: <20240514101009.977369357@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101006.678521560@linuxfoundation.org>
References: <20240514101006.678521560@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joakim Sindholt <opensource@zhasha.com>

[ Upstream commit 87de39e70503e04ddb58965520b15eb9efa7eef3 ]

This one hits both 9P2000 and .u as it appears v9fs has never translated
the O_TRUNC flag.

Signed-off-by: Joakim Sindholt <opensource@zhasha.com>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/vfs_inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 75907f77f9e38..ef103ef392ee3 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -178,6 +178,9 @@ int v9fs_uflags2omode(int uflags, int extended)
 		break;
 	}
 
+	if (uflags & O_TRUNC)
+		ret |= P9_OTRUNC;
+
 	if (extended) {
 		if (uflags & O_EXCL)
 			ret |= P9_OEXCL;
-- 
2.43.0




