Return-Path: <stable+bounces-69275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F859540EC
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 07:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878C51F24862
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 05:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E2978C7A;
	Fri, 16 Aug 2024 05:13:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331037711B
	for <stable@vger.kernel.org>; Fri, 16 Aug 2024 05:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723785201; cv=none; b=ldl8kViatsBgt1YCcrOTnO7XRTzEnlpsC+39X52E05emoRflh1AxdX8lbMIAhYsxm2k+6ric1XhUvHrnmqfHleDThJBSKCCSUxnWcOnA6U0Y2jPK3S4fWqV1lbzKOonVEXENYNhYf8PNPP+GB1H2W1CgjhSjGC3e810db/gJGb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723785201; c=relaxed/simple;
	bh=wZGiKpKPY1K8b7Mi9mCxc/9dBAsQ/r9pvgjQRgnTdDw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oCzm3thQZ6GpjHTtWn0FSHkQwDFERNQz+OmQjiTLMJn7N4Lz3XW363LdRClVYyBMBcCv4pnNUpol1ZlxUmLamNTBAHo4FT6KH2f8mjy0GJWQZ0zxWhPsKHi6rWoSCZMKZ3YyuL4bUlVo/lTcIEminyUMLptcHzIZxALC4jJW3NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WlVPy0HHMzQpyP;
	Fri, 16 Aug 2024 13:08:38 +0800 (CST)
Received: from dggpemf500017.china.huawei.com (unknown [7.185.36.126])
	by mail.maildlp.com (Postfix) with ESMTPS id 61959140138;
	Fri, 16 Aug 2024 13:13:14 +0800 (CST)
Received: from localhost.localdomain (10.175.104.67) by
 dggpemf500017.china.huawei.com (7.185.36.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 16 Aug 2024 13:13:13 +0800
From: Long Li <leo.lilong@huawei.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <jannh@google.com>, <leo.lilong@huawei.com>,
	<yangerkun@huawei.com>
Subject: [4.19 v2] filelock: Correct the filelock owner in fcntl_setlk/fcntl_setlk64
Date: Fri, 16 Aug 2024 13:08:48 +0800
Message-ID: <20240816050848.2124829-1-leo.lilong@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf500017.china.huawei.com (7.185.36.126)

The locks_remove_posix() function in fcntl_setlk/fcntl_setlk64 is designed
to reliably remove locks when an fcntl/close race is detected. However, it
was passing in the wrong filelock owner, it looks like a mistake and
resulting in a failure to remove locks. More critically, if the lock
removal fails, it could lead to a uaf issue while traversing the locks.

This problem occurs only in the 4.19/5.4 stable version.

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


