Return-Path: <stable+bounces-206362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EF1D03B38
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 961513074001
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674EF500962;
	Thu,  8 Jan 2026 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="e7rSHSmy"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806F1200C2
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767884664; cv=none; b=WyB47styQZ5qvXDCd+z5fONe8yv0eHzA84ZBrECdWLc+7kT7Et+ejaywookARDN1ReQKCcdO3zSbhBG8oCgHvyNHXAuEetnxsmQhOAW/O0JIFafh1kOSjpEm8aOrbUxdj0NZZD1HO1xW/2dgBI/9tvK7a4MzLGkLaKPBG/P6vd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767884664; c=relaxed/simple;
	bh=bi3pT8/VJVJeyvHyZ0UYLXu4X0RfXFIHObznf/QFq5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qFGADkQi2RonwJCZaOnszsr0Q+kjJUBV3F3VLRiJenKKkod8BIWXjwWZoM/KtBtLH/p8Ac986HjtRn5L/iNooQCawTnFlXZptiZk7ZyhGWbtSLzpnXnyUmi+Oua5kHFE/ijVmNwZdKu+0pMC9gRDWW9U6Y/6hPb96hdRueFy7iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=e7rSHSmy; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=80OqXlq08eKiEqr5fA/x5baR41YlhlWCmuzxpJT7a+g=; b=e7rSHSmy1PZXbO/Z0qa3KtnjWm
	qkc+3WThQ8tf1dFvgs6AzVIcjbBXdfvVnIo9Kb1Nbq+UAlsToHZbUBQaua/7Ys6tZgZeMZJlieerL
	7fJ8oC62vPEXnS1XY6+GERnH+GElrX1S9HbYahtkMvVEzHD1bsvaXURvAZ0p7OfpeBpbPP7t6oooc
	tknhl9Fszy68UTZQBPP+Sf1ftesKLBeetxMJXPOLVReb7WZpMxCDJ5TjGjX2+sH7bYujJ2qDjhB2I
	/XJk2kHbQwYPYV2ioH9FYFSixF/aoFg0/Yxj8zdFRjaMTpCJXAbA4qRGkTudQpTp4aCb1MX2m/4w7
	uhRYTzsg==;
Received: from 179-125-75-246-dinamico.pombonet.net.br ([179.125.75.246] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vdrYg-00339G-A8; Thu, 08 Jan 2026 16:04:18 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
	Lizhi Xu <lizhi.xu@windriver.com>,
	syzbot+340581ba9dceb7e06fb3@syzkaller.appspotmail.com,
	Theodore Ts'o <tytso@mit.edu>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 6.1 1/3] ext4: filesystems without casefold feature cannot be mounted with siphash
Date: Thu,  8 Jan 2026 12:04:07 -0300
Message-ID: <20260108150409.3354721-1-cascardo@igalia.com>
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
index b563c2e59227..106fa338840d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3550,6 +3550,14 @@ int ext4_feature_set_ok(struct super_block *sb, int readonly)
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


