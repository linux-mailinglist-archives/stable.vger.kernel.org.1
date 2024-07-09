Return-Path: <stable+bounces-58561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE77492B79F
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50031F24363
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3541414EC4D;
	Tue,  9 Jul 2024 11:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xRTiSuyz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86BC27713;
	Tue,  9 Jul 2024 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524310; cv=none; b=lGm6FzdigzSIWV8T7iSDWoyETTzihzY6SxsTPbSYKRr2Kjdlyz5D+n/mHoCXvGUts63g3MeZxgkC0IMQwr9GKJWr6gFsJv4Afbc4PQoKLs16DsE6qi9r6OsXNT6Fru0/ZZNX5ZG5iOa5q2Tnve3rYXWur+zWsJrnLKaAHbYBXOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524310; c=relaxed/simple;
	bh=xLmRY4zoHtKYbWpO2ueCLKveRLpV/nr32DoMr0W5pEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MX43sk/iUVK+Yma4ojZ5Ki1hsF/tw8VK633L3aTa8WRqT6ICa6O9cTQy7/e5UCGDZ6h/UX6rUcr3vFJqBlvBwEvGdvWpB8FXMomawQLZJEX1xbD//grfWcGk4J0uxYTtEX7LYw7z5GXsiV4M6mrEaewJ4iPJb8nvDGKqGjMqsdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xRTiSuyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669E1C3277B;
	Tue,  9 Jul 2024 11:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720524309;
	bh=xLmRY4zoHtKYbWpO2ueCLKveRLpV/nr32DoMr0W5pEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xRTiSuyzgbZzNSq2HIHvFgRAsQ7cnap6x+lsgkGqG6C0GrBCyMWRge9j1D+z2WZ4M
	 8eh04KHiVbh2ykjQqhwJdbTQqJ7WViuLbvi0/zw4Iw0rrFHeCnDHiHiy23RJYSlr0E
	 nzozXwsQkyVcoHJJXbHuuHm2duXgKzAiUcoK1xPY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6.9 141/197] f2fs: Add inline to f2fs_build_fault_attr() stub
Date: Tue,  9 Jul 2024 13:09:55 +0200
Message-ID: <20240709110714.410809170@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110708.903245467@linuxfoundation.org>
References: <20240709110708.903245467@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <nathan@kernel.org>

commit 0d8968287a1cf7b03d07387dc871de3861b9f6b9 upstream.

When building without CONFIG_F2FS_FAULT_INJECTION, there is a warning
from each file that includes f2fs.h because the stub for
f2fs_build_fault_attr() is missing inline:

  In file included from fs/f2fs/segment.c:21:
  fs/f2fs/f2fs.h:4605:12: warning: 'f2fs_build_fault_attr' defined but not used [-Wunused-function]
   4605 | static int f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned long rate,
        |            ^~~~~~~~~~~~~~~~~~~~~

Add the missing inline to resolve all of the warnings for this
configuration.

Fixes: 4ed886b187f4 ("f2fs: check validation of fault attrs in f2fs_build_fault_attr()")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/f2fs.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4600,8 +4600,8 @@ static inline bool f2fs_need_verity(cons
 extern int f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned long rate,
 							unsigned long type);
 #else
-static int f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned long rate,
-							unsigned long type)
+static inline int f2fs_build_fault_attr(struct f2fs_sb_info *sbi,
+					unsigned long rate, unsigned long type)
 {
 	return 0;
 }



