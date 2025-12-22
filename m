Return-Path: <stable+bounces-203206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AE6CD559E
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 10:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09FB23020C4C
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 09:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9E7311967;
	Mon, 22 Dec 2025 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="buB7uoF3"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E788830F949;
	Mon, 22 Dec 2025 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766396265; cv=none; b=Ug0iDxeRLqnqRsjnQFNCvASqiF7pwa8MMKWhDKMlEfV47905LoWJvhY6q8DSi9yyCfXY4FJteZ5k6e6hJdVAebKgza8qYr19FJYCmySTlgTKAuflPvVjZLSVy+/4LtVSZFD5UTBOpsxzm+Pqpreai9yNBASmUhesn/WKYB40ytA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766396265; c=relaxed/simple;
	bh=VwOk0KrORHi4rzm7L7X2SEpvILp0jvuywJgDjew0cN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dKear/0SQZESvIb8s4jGF363aqgvcitGq0T1N/owKlt/i84jGEN7wPE8y/ipzNSHBOf8PGMdzP3HdCCQhDGp75qGVc7uYpe/JlA0yCXkxdu9g7yYUWHUwidueklRcHmzkF9WJ4RJTSfHun+FJL7jbkFWgDhWkdmCj1VKH7qg6/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=buB7uoF3; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=AN
	Md3WXbGHnt1eZja1yDTXINJmeObLlJnACM7kb9+Kw=; b=buB7uoF34Boj5aM20H
	gLTNOXDJm6KmuNKDCB9kCzPeSehledCFaMlBwIorUo0WdaP0N1EDWe6LZsmO28bP
	zyznh+Nr1sf6W36STHinaGpZPPwWaFdLof/veQN0oIhKm1E568iIgfR6YH8QGuaP
	g12EiFR8EaGgIiTYcuGMIDN8I=
Received: from mi-work.mioffice.cn (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgB3y6s5EUlpL+Z3IQ--.37483S4;
	Mon, 22 Dec 2025 17:37:01 +0800 (CST)
From: yangshiguang1011@163.com
To: gregkh@linuxfoundation.org
Cc: rafael@kernel.org,
	dakr@kernel.org,
	peterz@infradead.org,
	linux-kernel@vger.kernel.org,
	yangshiguang@xiaomi.com,
	stable@vger.kernel.org
Subject: [PATCH] debugfs: Fix NULL pointer dereference at debugfs_read_file_str
Date: Mon, 22 Dec 2025 17:36:16 +0800
Message-ID: <20251222093615.663252-2-yangshiguang1011@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgB3y6s5EUlpL+Z3IQ--.37483S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4xXw18ury5ur1DCFykZrb_yoWDCrbEq3
	48Xayktw45JrW7Xr4xC345ZrWv9a1rCr4furZxtrZxtrW7J397Gw1kuwn3Xr93G3y8Gr1r
	Jry5Jr9xGF1IyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1WSrUUUUUU==
X-CM-SenderInfo: 51dqw25klj3ttqjriiqr6rljoofrz/xtbC3h0A5WlJET1fIAAA3V

From: yangshiguang <yangshiguang@xiaomi.com>

Check in debugfs_read_file_str() if the string pointer is NULL.

When creating a node using debugfs_create_str(), the string parameter
value can be NULL to indicate empty/unused/ignored.
However, reading this node using debugfs_read_file_str() will cause a
kernel panic.
This should not be fatal, so return an invalid error.

Signed-off-by: yangshiguang <yangshiguang@xiaomi.com>
Fixes: 9af0440ec86e ("debugfs: Implement debugfs_create_str()")
Cc: stable@vger.kernel.org
---
 fs/debugfs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 3ec3324c2060..a22ff0ceb230 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -1026,6 +1026,9 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
 		return ret;
 
 	str = *(char **)file->private_data;
+	if (!str)
+		return -EINVAL;
+
 	len = strlen(str) + 1;
 	copy = kmalloc(len, GFP_KERNEL);
 	if (!copy) {
-- 
2.43.0


