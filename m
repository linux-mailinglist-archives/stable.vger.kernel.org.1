Return-Path: <stable+bounces-206365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7A1D03CB5
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DAEF3350C97
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13646135A53;
	Thu,  8 Jan 2026 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sVu9YPmo"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0809850096B
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767884687; cv=none; b=MM3XCKKcj1tEuZeFx38e77sbBYvAU4WlJMtZ6ndQ74QryYwEFvxziHjJRLpo0PsM+8ntKRtRES0VPfr5YdnSFYyCTLnI3qFw2shx1hni5DVstu5+yqau6wK4EOL5tdKgUXb433pJ5w7qEjdeRxp4VwhZvmIyXn4ju76B7/s+xHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767884687; c=relaxed/simple;
	bh=2/nEB+CJWDIaX3DueKDOyRQokdYn/i/2dUJKp/xNGd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TXwFLNkk2AEqEipbwswBQvLWjsWBq37ve+Wz8h1q6ATyaGYj4Hq4zzU/8Rej6lBZJETt7neHb2i5+5K+rHkm15TjScbJXY4kquZeQ9ih5xaHXBtY+knJFUO6s0xGL133PisX/pSdvPdJM7D3ojsXV1cjOM/Wfvl4+oIP9Iv95R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=sVu9YPmo; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=SoLU0YfP+xC6BVlw/S0vvRuM+EnmlX1tkmHjzQ88/7I=; b=sVu9YPmotON5czvS7TPVVDqcWM
	lM8Fecl3rluvVdNh+xevO7qh3Qv//JyjaCugii1kmF2RiPnPpV/12wLgaVfbsvqMlBa9yFdzfypJH
	v6o6DMjXZCQVqhmTDY7bosOqtsOLsy5Gb++RMFxrb50YxteUwDVJYgEQchrq41EL2awj9mVho4B5B
	MjlP33y7lff2cjozrxU9ipNh/8QuGgCobMlSlim2ZErHS0RXUVio18JItQPLigjYE/f6gUDRNBpmE
	ZSPv9G3xc6fAo5/pkLe+AJEGBN/KcfED0L1Kfe9+SpwobzcJNMFxifMksJoj+E2dejZMkf6RaII0j
	ZF98oXPg==;
Received: from 179-125-75-246-dinamico.pombonet.net.br ([179.125.75.246] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vdrZ5-00339z-6P; Thu, 08 Jan 2026 16:04:43 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
	Lizhi Xu <lizhi.xu@windriver.com>,
	syzbot+340581ba9dceb7e06fb3@syzkaller.appspotmail.com,
	Theodore Ts'o <tytso@mit.edu>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 5.15 1/3] ext4: filesystems without casefold feature cannot be mounted with siphash
Date: Thu,  8 Jan 2026 12:04:27 -0300
Message-ID: <20260108150429.3354837-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lizhi Xu <lizhi.xu@windriver.com>

commit 985b67cd86392310d9e9326de941c22fc9340eec upstream.

When mounting the ext4 filesystem, if the default hash version is set to
DX_HASH_SIPHASH but the casefold feature is not set, exit the mounting.

Reported-by: syzbot+340581ba9dceb7e06fb3@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
Link: https://patch.msgid.link/20240605012335.44086-1-lizhi.xu@windriver.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[cascardo: small conflict fixup]
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/ext4/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b677b7d14bc2..58456b1a5349 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3190,6 +3190,14 @@ int ext4_feature_set_ok(struct super_block *sb, int readonly)
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
2.47.3


