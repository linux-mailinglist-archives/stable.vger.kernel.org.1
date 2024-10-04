Return-Path: <stable+bounces-80990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D638C990D94
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9880D28348F
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED92720E342;
	Fri,  4 Oct 2024 18:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAXrJZTf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EFA20E33A;
	Fri,  4 Oct 2024 18:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066450; cv=none; b=tBHANYe59iCnxdOzue/HpVNZ3KXatRoWmsTKq5UaGntbzcS4/8fUzVdX0fOoWrCpKCG3GM8nYSacgkPIzT1kHxO4vrM5mcSdPYt3l5miDfP/IwuKoL/9wbrFTzwEPB+bjT5hvG58gsr3qAHjvNT9nPCh4du0qEOFC/IJOpX+LEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066450; c=relaxed/simple;
	bh=nDpLI8neqpuksrhtF77dhgdQLVt6E3sajr3D1Q7iHr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfm0kDDjB0WNr6PnkuW3Pq4rxQPEPJBZIjkC1lOQaGrc0OTrlvCfnZ0WYQqPb9DVxIPVphtLl5CfHBkZek6aMWhZLwMhVFn2PAKmENSihfXtlqtGj9Gk2SwkRPbp5afgJeXZTuLlDr1Q8v8zJAS2asAl1inkJnKVk45ZUFrGMFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAXrJZTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930ACC4CECD;
	Fri,  4 Oct 2024 18:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066450;
	bh=nDpLI8neqpuksrhtF77dhgdQLVt6E3sajr3D1Q7iHr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KAXrJZTf1c1luaL1tKjiAE7YROKjC/vcmfKeNPtq5My2ziZ5OhYGNgnIg9VhGHHmb
	 p3sR1JnE7kEMME5VxH6f+Hnghi5PE9+YqZ6LoqDq3eu8NwRpnG2l5uTGWxixQLQEfV
	 NiofAYmFUZ2Wwug9KCk4rcoIzTWhGjiQhBtnP1gm0Jn0kQqHPUtl1r0eplJbArsI/W
	 q15MtQJzSLOZWnnOK2j0d0/xo+ahThJlk8GBOfW/gDPVi1VUi0A2SZPwxkLwK33zYu
	 9XrPM37v93yx5N/8eDwfXpf9Hb+7zsGNngicwRGrVxnaS/CTYloHCWvm97+4kgt7m0
	 b0yqFk1k85eHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Artem Sadovnikov <ancowi69@gmail.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Mikhail Ukhin <mish.uxin2012@yandex.ru>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 06/42] ext4: fix i_data_sem unlock order in ext4_ind_migrate()
Date: Fri,  4 Oct 2024 14:26:17 -0400
Message-ID: <20241004182718.3673735-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182718.3673735-1-sashal@kernel.org>
References: <20241004182718.3673735-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
Content-Transfer-Encoding: 8bit

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
index a19a9661646eb..0be0467ae6dd2 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -662,8 +662,8 @@ int ext4_ind_migrate(struct inode *inode)
 	if (unlikely(ret2 && !ret))
 		ret = ret2;
 errout:
-	ext4_journal_stop(handle);
 	up_write(&EXT4_I(inode)->i_data_sem);
+	ext4_journal_stop(handle);
 out_unlock:
 	percpu_up_write(&sbi->s_writepages_rwsem);
 	return ret;
-- 
2.43.0


