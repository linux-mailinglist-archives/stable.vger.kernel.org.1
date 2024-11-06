Return-Path: <stable+bounces-90285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1015B9BE78A
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4258C1C233EC
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A0D1DE8A2;
	Wed,  6 Nov 2024 12:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SBMu3rKc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6E8171CD;
	Wed,  6 Nov 2024 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895321; cv=none; b=nBdkeRfZJle8nPnM58B4D1SYvBdfc3oUVSvVx/Czb4LUG+Di/WvHq/LnHlVALVOkzEbQ8kZShwEYcwpMmx/lq2d9f9VikJFYI9qc1wAfhUfMgjoWPNAtTW+0Sq03554b1GmXs6KsMg52T7TUv7bNKoozXkzZbmR278M8CXdK7eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895321; c=relaxed/simple;
	bh=7VZYTFrpoq1DDy7+iqNRZxeO261X6j+Xgr2m6MFregw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5cnEqT989VMLyAQm7Gm2aA9kwAdfEdFX4bOxnl7WQwTHd/2tYWP6b7WukZxQwcT+OTXGoy/MwwCIjk9gDDay9B2ahIppm/d4zkQfgVaoUJphKxtvrlUfa36BiE1Znx0hE2+NqQrsN0QCJbvNCfyXhs2yYFpIL9oI5BCr3yv2Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SBMu3rKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C354C4CECD;
	Wed,  6 Nov 2024 12:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730895320;
	bh=7VZYTFrpoq1DDy7+iqNRZxeO261X6j+Xgr2m6MFregw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SBMu3rKcqi08X0mhSA5sn+XMujVwhFioqt2RVrlf3+CrVH9QGZHGYsDWyN5j0XGAK
	 Ue3aLTsBRWrp7fJ8l6C2oXYK5pKJ14p2zUXAzBsv7CtBkZW2e5kJK+EPLnd/GuAwac
	 EEFYuBhiwOtSlAbkgeemWFG2SWjBROyXlV1stcL8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Mikhail Ukhin <mish.uxin2012@yandex.ru>,
	Artem Sadovnikov <ancowi69@gmail.com>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 179/350] ext4: fix i_data_sem unlock order in ext4_ind_migrate()
Date: Wed,  6 Nov 2024 13:01:47 +0100
Message-ID: <20241106120325.353991202@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120320.865793091@linuxfoundation.org>
References: <20241106120320.865793091@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Artem Sadovnikov <ancowi69@gmail.com>

[ Upstream commit cc749e61c011c255d81b192a822db650c68b313f ]

Fuzzing reports a possible deadlock in jbd2_log_wait_commit.

This issue is triggered when an EXT4_IOC_MIGRATE ioctl is set to require
synchronous updates because the file descriptor is opened with O_SYNC.
This can lead to the jbd2_journal_stop() function calling
jbd2_might_wait_for_commit(), potentially causing a deadlock if the
EXT4_IOC_MIGRATE call races with a write(2) system call.

This problem only arises when CONFIG_PROVE_LOCKING is enabled. In this
case, the jbd2_might_wait_for_commit macro locks jbd2_handle in the
jbd2_journal_stop function while i_data_sem is locked. This triggers
lockdep because the jbd2_journal_start function might also lock the same
jbd2_handle simultaneously.

Found by Linux Verification Center (linuxtesting.org) with syzkaller.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Co-developed-by: Mikhail Ukhin <mish.uxin2012@yandex.ru>
Signed-off-by: Mikhail Ukhin <mish.uxin2012@yandex.ru>
Signed-off-by: Artem Sadovnikov <ancowi69@gmail.com>
Rule: add
Link: https://lore.kernel.org/stable/20240404095000.5872-1-mish.uxin2012%40yandex.ru
Link: https://patch.msgid.link/20240829152210.2754-1-ancowi69@gmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index 4a72583c75593..9f73c2f7f9492 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -678,8 +678,8 @@ int ext4_ind_migrate(struct inode *inode)
 		ei->i_data[i] = cpu_to_le32(blk++);
 	ext4_mark_inode_dirty(handle, inode);
 errout:
-	ext4_journal_stop(handle);
 	up_write(&EXT4_I(inode)->i_data_sem);
+	ext4_journal_stop(handle);
 out_unlock:
 	percpu_up_write(&sbi->s_writepages_rwsem);
 	return ret;
-- 
2.43.0




