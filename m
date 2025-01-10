Return-Path: <stable+bounces-108227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3009A0997B
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 19:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5B3188D545
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 18:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0212144B5;
	Fri, 10 Jan 2025 18:32:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89B9207E12;
	Fri, 10 Jan 2025 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736533952; cv=none; b=RrDUSdHhwLlTCYGqp8oqCk1tzvtwtbfHbqYwSL8fHx21kcOc5tqulEpiRlthytW6hy5cXDON6zfBX8B2AWaLyaI4wt90REoIUuDIuUvu6frFUyzfWrEuZQfOSdnl5zBLATmnqmYdRZAztF7qRBPcf9gASAThZ2tf9yR0qZ+8gFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736533952; c=relaxed/simple;
	bh=Ezk6YNVsorymjF+R0CV5it+emPw8MjhKEyF6TGSOB20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CjfvmBD9AO7kwqGwrnqB0tZIeBIQv/zhlsNOAdHnBkHyNcZc1yQ/dkmVcaGFipNlQBrMk1COTmqyiqsLTZ2/oaX12eCf6zXiyfgellUzaEM1d29ioiccDx/rhCD3pT5RARxy1hF7f5+WQQ0oe0slUh5cQtq15tPiHomZpKx42QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id A6716233A7;
	Fri, 10 Jan 2025 21:32:27 +0300 (MSK)
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
Subject: [PATCH 5.10 2/2] gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
Date: Fri, 10 Jan 2025 21:32:13 +0300
Message-Id: <20250110183213.105051-3-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20250110183213.105051-1-kovalev@altlinux.org>
References: <20250110183213.105051-1-kovalev@altlinux.org>
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
 fs/gfs2/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index a9e3956a5b4698..d4399bec7b5b12 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -623,6 +623,8 @@ static void gfs2_put_super(struct super_block *sb)
 
 	if (!sb_rdonly(sb)) {
 		gfs2_make_fs_ro(sdp);
+	} else {
+		gfs2_quota_cleanup(sdp);
 	}
 	WARN_ON(gfs2_withdrawing(sdp));
 
-- 
2.33.8


