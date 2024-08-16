Return-Path: <stable+bounces-69273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7F49540E1
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 07:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C951C214D5
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 05:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE08978286;
	Fri, 16 Aug 2024 05:09:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B608D7711B
	for <stable@vger.kernel.org>; Fri, 16 Aug 2024 05:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723784982; cv=none; b=AhWalf39a4zOjsJgb4dMvZDulrWS9VpBa/lQOrs69tY7hIXC26kW42UIiCHpfs+Osl8G03TK5CUZrMTB5ItNVNCw6JlBgiJi704b5RyyTsPWXs1gf6yQuBqNMDwcKztXrA1EfaEW5kw9ePKrnF3Kb3yokjVzg3BmdHO2htBFmDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723784982; c=relaxed/simple;
	bh=Idh4UqXWQWouM4c3RH2lHW/NZoWDwH10zoG53MFK8NE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VPSKGL0hiurCPUiuLNRe3+fV0rQqul+nERLt5SMKIVdB/RPcZIr4P30l+fnZ/ki5wk64e1LYXPHbS6xrvqLBYJfAel3hzruMlNR9O9sEob8mh4xUq92wkLVcjgkdLYnWpXwqMpA9fJnYJXPA+E6fi9ApA29yK8IS2iSAbOx2PbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WlVQR659Sz1T7SD;
	Fri, 16 Aug 2024 13:09:03 +0800 (CST)
Received: from dggpemf500017.china.huawei.com (unknown [7.185.36.126])
	by mail.maildlp.com (Postfix) with ESMTPS id E79F81401E9;
	Fri, 16 Aug 2024 13:09:35 +0800 (CST)
Received: from localhost.localdomain (10.175.104.67) by
 dggpemf500017.china.huawei.com (7.185.36.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 16 Aug 2024 13:09:35 +0800
From: Long Li <leo.lilong@huawei.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <jannh@google.com>, <leo.lilong@huawei.com>,
	<yangerkun@huawei.com>
Subject: [PATCH 4.19] filelock: Correct the filelock owner in fcntl_setlk/fcntl_setlk64
Date: Fri, 16 Aug 2024 13:05:16 +0800
Message-ID: <20240816050516.2120947-1-leo.lilong@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500017.china.huawei.com (7.185.36.126)

The locks_remove_posix() function in fcntl_setlk/fcntl_setlk64 is designed
to reliably remove locks when an fcntl/close race is detected. However, it
was passing in the wrong filelock owner, it looks like a mistake and
resulting in a failure to remove locks. More critically, if the lock
removal fails, it could lead to a uaf issue while traversing the locks.

This problem occurs only in the 4.19 stable version.

Fixes: a561145f3ae9 ("filelock: Fix fcntl/close race recovery compat path")
Fixes: d30ff3304083 ("filelock: Remove locks reliably when fcntl/close race is detected")
Cc: stable@vger.kernel.org
Signed-off-by: Long Li <leo.lilong@huawei.com>
---
 fs/locks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 234ebfa8c070..b1201b01867a 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2313,7 +2313,7 @@ int fcntl_setlk(unsigned int fd, struct file *filp, unsigned int cmd,
 		f = fcheck(fd);
 		spin_unlock(&current->files->file_lock);
 		if (f != filp) {
-			locks_remove_posix(filp, &current->files);
+			locks_remove_posix(filp, current->files);
 			error = -EBADF;
 		}
 	}
@@ -2443,7 +2443,7 @@ int fcntl_setlk64(unsigned int fd, struct file *filp, unsigned int cmd,
 		f = fcheck(fd);
 		spin_unlock(&current->files->file_lock);
 		if (f != filp) {
-			locks_remove_posix(filp, &current->files);
+			locks_remove_posix(filp, current->files);
 			error = -EBADF;
 		}
 	}
-- 
2.39.2


