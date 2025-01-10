Return-Path: <stable+bounces-108224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1BFA09970
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 19:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820F33A066A
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 18:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C5220767B;
	Fri, 10 Jan 2025 18:30:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C000121420C;
	Fri, 10 Jan 2025 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736533853; cv=none; b=gdYwGRcGd5ZdcSnOTEa6rtEWZSLNy6kkZGyLro7aQiAG8Mwo3am/nmRU2cQMQqtAbu+Eg1+SnF3YC5ujmxa2gJ0D2hkSaEjssvinfTh327IiJFPLW0ci/xMmtSsQBFEtMkdxKyWvIQnPyi9GCLmufP4obDznfmjv/gq8NJYmSQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736533853; c=relaxed/simple;
	bh=eEFxMl4mDu4wcI4ulehibmPMv1+PIEYYk/7+gzyWdho=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R2X8ItF0ywk45tfGiTmTHezg5cRcnkL6Yh6dst45u9BxHSCUKemnW9uIH73DyFCoAkp2pVONPIL5dEmUTkDqg9zBlz8pvc3C3Ah8lU6Two6RXFkFalE0oADgBtQiyzFAZ9pjLeH0RcHkPuXvwSY5ASX7RrpuKBJaF5nPX6k773k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 7AC4A2339E;
	Fri, 10 Jan 2025 21:30:40 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: Bob Peterson <rpeterso@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-kernel@vger.kernel.org,
	Juntong Deng <juntong.deng@outlook.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Clayton Casciato <majortomtosourcecontrol@gmail.com>,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH 5.15] gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
Date: Fri, 10 Jan 2025 21:30:39 +0300
Message-Id: <20250110183039.104994-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Juntong Deng <juntong.deng@outlook.com>

commit bdcb8aa434c6d36b5c215d02a9ef07551be25a37 upstream.

In gfs2_put_super(), whether withdrawn or not, the quota should
be cleaned up by gfs2_quota_cleanup().

Otherwise, struct gfs2_sbd will be freed before gfs2_qd_dealloc (rcu
callback) has run for all gfs2_quota_data objects, resulting in
use-after-free.

Also, gfs2_destroy_threads() and gfs2_quota_cleanup() is already called
by gfs2_make_fs_ro(), so in gfs2_put_super(), after calling
gfs2_make_fs_ro(), there is no need to call them again.

Reported-by: syzbot+29c47e9e51895928698c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=29c47e9e51895928698c
Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
(cherry picked from commit 7ad4e0a4f61c57c3ca291ee010a9d677d0199fba)
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
Backport to fix CVE-2023-52760
Link: https://www.cve.org/CVERecord/?id=CVE-2023-52760
---
 fs/gfs2/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 268651ac9fc848..98158559893f48 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -590,6 +590,8 @@ static void gfs2_put_super(struct super_block *sb)
 
 	if (!sb_rdonly(sb)) {
 		gfs2_make_fs_ro(sdp);
+	} else {
+		gfs2_quota_cleanup(sdp);
 	}
 	WARN_ON(gfs2_withdrawing(sdp));
 
-- 
2.33.8


