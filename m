Return-Path: <stable+bounces-201995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A13EFCC468D
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 17:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1B1330CB154
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 16:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3C5354AE5;
	Tue, 16 Dec 2025 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yM6m53kC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460D5354ADA;
	Tue, 16 Dec 2025 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886478; cv=none; b=PmoxIow1od6abdTX+NV7XIdXr1Dm+Q/cKIRC0j+019MzgcYmF0xBl/XnNw25KCS6w3Bc0vxl21tA7z4YZW3LSkfJdwA9RgeGf8YywuVQFpSW7hsWTix4Nrtvt70QKhyKj+6r7h4hW8KFj4Wx7R8tOQpUaUHUD+TG4jb94q4h1EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886478; c=relaxed/simple;
	bh=OCs9n8HTXGsfJnv2Kh8OOoGGE+H7sUFdWhhTgBVVlrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXUZ5q0BEoD1HDMz2SUHnaosoZ+6AtUoy8fQOkAALuun0I4XFB19XWChkxjgYs3Sw0rSZSHxvQQRGJ+LPGt74OGxUDI00MBg3lhimsLuXYvcRkoMLiO3Ek9WAZ413RHFR7N6sohObz62ebEM1l425sivfAfroKcQ7zat2jLymYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yM6m53kC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0E3C4CEF1;
	Tue, 16 Dec 2025 12:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765886478;
	bh=OCs9n8HTXGsfJnv2Kh8OOoGGE+H7sUFdWhhTgBVVlrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yM6m53kCRMS09wGRiZ4cunZdkhcf1hKCDmg1CelNDZK3B/+VmoGpSF6oiHdMHSWPB
	 WUqNZoOKDBLsrMXQPIVJL8JpvmeU+uhsDwjAsMUdWRhcE4kOZ9JcXghkJ1ReWuGYdi
	 j70b3HM0924I3fWJ1WtQgGyc5iDqQh6cncjbDdSA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alkis Georgopoulos <alkisg@gmail.com>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 448/507] Revert "nfs: ignore SB_RDONLY when remounting nfs"
Date: Tue, 16 Dec 2025 12:14:49 +0100
Message-ID: <20251216111401.683395434@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111345.522190956@linuxfoundation.org>
References: <20251216111345.522190956@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 400fa37afbb11a601c204b72af0f0e5bc2db695c ]

This reverts commit 80c4de6ab44c14e910117a02f2f8241ffc6ec54a.

Silently ignoring the "ro" and "rw" mount options causes user confusion,
and regressions.

Reported-by: Alkis Georgopoulos<alkisg@gmail.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>
Fixes: 80c4de6ab44c ("nfs: ignore SB_RDONLY when remounting nfs")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/super.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 72dee6f3050e6..527000f5d150c 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1051,16 +1051,6 @@ int nfs_reconfigure(struct fs_context *fc)
 
 	sync_filesystem(sb);
 
-	/*
-	 * The SB_RDONLY flag has been removed from the superblock during
-	 * mounts to prevent interference between different filesystems.
-	 * Similarly, it is also necessary to ignore the SB_RDONLY flag
-	 * during reconfiguration; otherwise, it may also result in the
-	 * creation of redundant superblocks when mounting a directory with
-	 * different rw and ro flags multiple times.
-	 */
-	fc->sb_flags_mask &= ~SB_RDONLY;
-
 	/*
 	 * Userspace mount programs that send binary options generally send
 	 * them populated with default values. We have no way to know which
-- 
2.51.0




