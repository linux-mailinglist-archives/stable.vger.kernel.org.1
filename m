Return-Path: <stable+bounces-93784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4869D0E5F
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 11:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EFA71F2229C
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 10:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1794419922A;
	Mon, 18 Nov 2024 10:21:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D441991C8
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925261; cv=none; b=erZ9UqqlK/aUDeUCTE//J8+PDMF13qZ1/qrVmtZpA7+3KHSK9i2PV5lxDuaKS+1GCZ8s5s5rUNHayL6UZ9dMKH7ncEygOptLC6Ab5cEaVQHg9TJoWTQqVty0H6S+FchOftzFLX3oNPJk3BLS+dHy1hjhMHs7RHLxwzmFi/7u+0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925261; c=relaxed/simple;
	bh=Iy2Gvq6LLru+B142klb6yQpukUOOmTYNXyzt7ruXzaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FhcmnnafuR5T4JCnwPXREx1U2jHOaeK9zmPUOLvqwlIrdDK45CQB+xOGg1Yp2nowZSbriM0XoxJ6ePKOx1GsPtU2nFN8y//jVUT1d4bK++O1vZTAFb212L1earZB9DiGs5I5qSUQvyQ4NFkM3u2zCOCtcO+AYGvvDy5x4KRniz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 8779F23391;
	Mon, 18 Nov 2024 13:20:58 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Cc: lvc-project@linuxtesting.org,
	dutyrok@altlinux.org,
	gerben@altlinux.org,
	kovalev@altlinux.org
Subject: [PATCH 2/3] ext4: filesystems without casefold feature cannot be mounted with siphash
Date: Mon, 18 Nov 2024 13:20:49 +0300
Message-Id: <20241118102050.16077-3-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20241118102050.16077-1-kovalev@altlinux.org>
References: <20241118102050.16077-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lizhi Xu <lizhi.xu@windriver.com>

[ Upstream commit 985b67cd86392310d9e9326de941c22fc9340eec ]

When mounting the ext4 filesystem, if the default hash version is set to
DX_HASH_SIPHASH but the casefold feature is not set, exit the mounting.

Reported-by: syzbot+340581ba9dceb7e06fb3@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
Link: https://patch.msgid.link/20240605012335.44086-1-lizhi.xu@windriver.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 fs/ext4/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index cf2c8cf507780..68070b1859803 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3559,6 +3559,14 @@ int ext4_feature_set_ok(struct super_block *sb, int readonly)
 	}
 #endif
 
+	if (EXT4_SB(sb)->s_es->s_def_hash_version == DX_HASH_SIPHASH &&
+	    !ext4_has_feature_casefold(sb)) {
+		ext4_msg(sb, KERN_ERR,
+			 "Filesystem without casefold feature cannot be "
+			 "mounted with siphash");
+		return 0;
+	}
+
 	if (readonly)
 		return 1;
 
-- 
2.33.8


