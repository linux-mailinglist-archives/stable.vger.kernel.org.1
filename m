Return-Path: <stable+bounces-206360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A8CD03E98
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E347B3131C1F
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A78F25C838;
	Thu,  8 Jan 2026 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="h2O2G+JP"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A4B50095E
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767884649; cv=none; b=qimyIubJlk2/CSi2aqu/R3Pw9pWgwI3dgrBKceSj+iWn+yFOrlJjjKvX6p1BIcV53N5BfqSJtppCz5ZwzGWzOMeB+Xet52fYFp2nJ1yTbZFARIb18c2d9QmmqDFGrDgwoo0oZxy5+eGi6rJs20Fn5Hneg5rLerlR7PJiCg7F3+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767884649; c=relaxed/simple;
	bh=aIeZj7FHtbxdzph25ngB/9ziEtu19V2t/Njz4xdKc60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hf0NhZDDcoveCrSQnKPO+vuMeT1Y2egxAUR6MrDTcFVEl4gsGzuor2yulK8QsX78WK6PVZTVB0ofwAOPadewA83V5ismPcJMqP/DqH6ZEIS1HUHxFkmwySq6/5lBlHZZpjGtRGGYxnTHu654eD9xeO2G6d3JQ0MsIjgMOpt5VVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=h2O2G+JP; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lHDRmwVEsgzzw/QKYymhE2pfsoJh+WR5uOm5cGdNlu0=; b=h2O2G+JPHsXJwWVjWWGIFTu8tE
	q3tE1BU8fbOlUoScuZWEe/35uvrOWkhx+KUTip/xnPSF4hacJngXiRAkxgLsP6L9uwSBWt1NQz3QI
	mas62LsaqOf3IXP1+uwmWMFqlFh9wB4ZOdfwDhienm/q2uJDPPjSaFHhNqxBTYbp2uFarPuqNklDV
	y3lUcQRYpBP5ZVBdh9CQ8oH9BhU5hX8FT7K+2PiIKGYFB+ILiakPgLJlR9py3CJLTTdJLEAo9F10G
	EmOM4sXQk4Nqbw2N/6DrsE+Bt5de21SyaPxG/d2JysD6yoXyfwOTsg43hoRfPzYNwQPcRqtbVnTnP
	4w/llJNw==;
Received: from 179-125-75-246-dinamico.pombonet.net.br ([179.125.75.246] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vdrYP-00338f-6u; Thu, 08 Jan 2026 16:04:01 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
	Lizhi Xu <lizhi.xu@windriver.com>,
	syzbot+340581ba9dceb7e06fb3@syzkaller.appspotmail.com,
	Theodore Ts'o <tytso@mit.edu>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 6.6 1/2] ext4: filesystems without casefold feature cannot be mounted with siphash
Date: Thu,  8 Jan 2026 12:03:49 -0300
Message-ID: <20260108150350.3354622-1-cascardo@igalia.com>
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
index 16a6c249580e..5a1e1f7e6124 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3630,6 +3630,14 @@ int ext4_feature_set_ok(struct super_block *sb, int readonly)
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


