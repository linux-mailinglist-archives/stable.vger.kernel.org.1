Return-Path: <stable+bounces-69274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685E09540E3
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 07:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E65289974
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 05:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0806078286;
	Fri, 16 Aug 2024 05:10:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D007711B
	for <stable@vger.kernel.org>; Fri, 16 Aug 2024 05:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723785058; cv=none; b=MV/yXchTTXFkSH/6/w8jTNS9DbLjj/c/G8qzA/rfK7HNb5Xas5X97sIZBCm2ES178v6YmYGIwpmygnc2sw+oPUK2RmDh3JgIKP9gKCmZ6AYYGd485/3oNpQB34buIcFXRBkHANhw4ct7XdLH+aHZfNuRHVxPRzCFICm66iEClNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723785058; c=relaxed/simple;
	bh=dZMDHl1PfvkYqP9qrXCuFp6LtpbUTMFKXR8Q/GyxfRc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lC260A2uVuXDER0JggEsFxvLvK4cg7EQinC91/Kc3UhtJcyPlbz8Bp7duH1TxpmfWdkB779MTslsNu+5F2bU5daRCjau0RHbffOBiVjwbYWzOs7d+e7SBy7vuO0JEzwcfFZG5w4EHoNIYU9MFBduDu45J4sdwVD6+396BP6ZI/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WlVRq6GwxzyNyL;
	Fri, 16 Aug 2024 13:10:15 +0800 (CST)
Received: from dggpemf500017.china.huawei.com (unknown [7.185.36.126])
	by mail.maildlp.com (Postfix) with ESMTPS id 3FDB214037E;
	Fri, 16 Aug 2024 13:10:48 +0800 (CST)
Received: from localhost.localdomain (10.175.104.67) by
 dggpemf500017.china.huawei.com (7.185.36.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 16 Aug 2024 13:10:47 +0800
From: Long Li <leo.lilong@huawei.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <jannh@google.com>, <leo.lilong@huawei.com>,
	<yangerkun@huawei.com>
Subject: [PATCH 5.4] filelock: Correct the filelock owner in fcntl_setlk/fcntl_setlk64
Date: Fri, 16 Aug 2024 13:06:27 +0800
Message-ID: <20240816050627.2122228-1-leo.lilong@huawei.com>
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

This problem occurs only in the 4.19/5.4 stable version.

Fixes: 4c43ad4ab416 ("filelock: Fix fcntl/close race recovery compat path")
Fixes: dc2ce1dfceaa ("filelock: Remove locks reliably when fcntl/close race is detected")
Cc: stable@vger.kernel.org
Signed-off-by: Long Li <leo.lilong@huawei.com>
---
 fs/locks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 85c8af53d4eb..cf6ed857664b 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2542,7 +2542,7 @@ int fcntl_setlk(unsigned int fd, struct file *filp, unsigned int cmd,
 		f = fcheck(fd);
 		spin_unlock(&current->files->file_lock);
 		if (f != filp) {
-			locks_remove_posix(filp, &current->files);
+			locks_remove_posix(filp, current->files);
 			error = -EBADF;
 		}
 	}
@@ -2672,7 +2672,7 @@ int fcntl_setlk64(unsigned int fd, struct file *filp, unsigned int cmd,
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


