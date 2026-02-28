Return-Path: <stable+bounces-220487-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDL2CmY5o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220487-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:52:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BD96C1C657D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8577F31EC9F7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9660335DA74;
	Sat, 28 Feb 2026 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V61Rnmda"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5973835DA6A;
	Sat, 28 Feb 2026 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300373; cv=none; b=mapInrJlxtH+Fxw/I8uJ2awt0C9ASTlbsFpUu5P0TNE3f7rT5VaEIU26/1Ej37XLhyP1k4ANPzxX40MGFG7VHfl0VbaeW9eqMF0aL89m33X/NKOf7ZabHtscOmW1B19G9Z1itShaMJQgd4sF95oGBi0AcL4VieOjyLHCtG8qjK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300373; c=relaxed/simple;
	bh=lvdZkfkW74kRgGoxKJBGpZCeXsBUgyeAH0BQerntK04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgykEsYn93Zhg47uXmCHqJ9w9js0wSmTN6Al++8rqsDVRgmZAsRxBF6bm4vV24YLf+Tm8n9MXugVU/huG9EvT9ETbmLDG9AU44wMO04O3wF6UM3S3aePIi8bNK8E+0qu0IOg7UR/ljdUri0m8NoRNtpp73ACu3zDbuxqHpPJVYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V61Rnmda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7360CC19424;
	Sat, 28 Feb 2026 17:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300373;
	bh=lvdZkfkW74kRgGoxKJBGpZCeXsBUgyeAH0BQerntK04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V61RnmdazZD4rEk7ILE1u+3cPa+4HOAGgSRKV3INOUlmBUrTeMSlQLowSdpMyC8Y8
	 gh3FvrBpdXx9qE9ksfYQmZaianQhqdvifuhGbn1FdujCpjVY5l0/jlZFGJyeo8cufs
	 Iym45me2QEfoqTOkEbTkAtMtOignw+MBPTYDqbrfumMcDaT1gR4FyWEZOR0KZuWJdg
	 1RcKgS9SSvR8VkWzPl+B5rfrdVzVYmQKbgEEs+M8HX44DexoNU1l6HX+P7QpOtJsa6
	 +6lCuL/FdNN2XWb6RWbePULJhhLdb2mGMbJgYWQ/bNPXUQm6nZRcSUmvvAIYitrovN
	 U1Zxk8TlVCmzg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Szymon Wilczek <swilczek.lx@gmail.com>,
	syzbot+d27edf9f96ae85939222@syzkaller.appspotmail.com,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 408/844] ntfs3: fix circular locking dependency in run_unpack_ex
Date: Sat, 28 Feb 2026 12:25:21 -0500
Message-ID: <20260228173244.1509663-409-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220487-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,syzkaller.appspotmail.com,paragon-software.com,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,d27edf9f96ae85939222];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BD96C1C657D
X-Rspamd-Action: no action

From: Szymon Wilczek <swilczek.lx@gmail.com>

[ Upstream commit 08ce2fee1b869ecbfbd94e0eb2630e52203a2e03 ]

Syzbot reported a circular locking dependency between wnd->rw_lock
(sbi->used.bitmap) and ni->file.run_lock.

The deadlock scenario:
1. ntfs_extend_mft() takes ni->file.run_lock then wnd->rw_lock.
2. run_unpack_ex() takes wnd->rw_lock then tries to acquire
   ni->file.run_lock inside ntfs_refresh_zone().

This creates an AB-BA deadlock.

Fix this by using down_read_trylock() instead of down_read() when
acquiring run_lock in run_unpack_ex(). If the lock is contended,
skip ntfs_refresh_zone() - the MFT zone will be refreshed on the
next MFT operation. This breaks the circular dependency since we
never block waiting for run_lock while holding wnd->rw_lock.

Reported-by: syzbot+d27edf9f96ae85939222@syzkaller.appspotmail.com
Tested-by: syzbot+d27edf9f96ae85939222@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d27edf9f96ae85939222
Signed-off-by: Szymon Wilczek <swilczek.lx@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/run.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index 395b204925258..dc59cad4fa376 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -1131,11 +1131,14 @@ int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 			struct rw_semaphore *lock =
 				is_mounted(sbi) ? &sbi->mft.ni->file.run_lock :
 						  NULL;
-			if (lock)
-				down_read(lock);
-			ntfs_refresh_zone(sbi);
-			if (lock)
-				up_read(lock);
+			if (lock) {
+				if (down_read_trylock(lock)) {
+					ntfs_refresh_zone(sbi);
+					up_read(lock);
+				}
+			} else {
+				ntfs_refresh_zone(sbi);
+			}
 		}
 		up_write(&wnd->rw_lock);
 		if (err)
-- 
2.51.0


