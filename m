Return-Path: <stable+bounces-110427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C4FA1BF7D
	for <lists+stable@lfdr.de>; Sat, 25 Jan 2025 01:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E81F316363B
	for <lists+stable@lfdr.de>; Sat, 25 Jan 2025 00:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC635680;
	Sat, 25 Jan 2025 00:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KLE6h6rV"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C514125A630
	for <stable@vger.kernel.org>; Sat, 25 Jan 2025 00:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737763317; cv=none; b=eR++IbjjKFU/AYcliUU7L7ifpjnTcYlPUjJzIV5pKNyXgx5becWSV0ZTit5W1OyZUcOCBoPWWibyL6N2+34BWVLUt+9yivnQDNFC1hKCMQ+mL9UBCfPRi/Gu8+Ptq8CAuyGB2WEbYegQGK0GJ2mO2QLSquR4JlPE99eNR8ywEA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737763317; c=relaxed/simple;
	bh=2QS7huEtu+eeOVeCGTMv21kTnQbbj95gYaiQkVvioL8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e6vsPxyEZW3oJLkoRaYDqDfQLg/+i3gJGxQBMpWyQc/8dHPBNPFDXEY7OjSYCI9RmekSEq6Lmi41q+x3efgnUV3FuaAgmg7Cs4SxM5+EEcKHL66+rkJtofPWmNW/C64v6IDgje1TSOhFNtae+NLPw8CMdmXkAFgUb32hxpuyQ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KLE6h6rV; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737763315; x=1769299315;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u8B/S2NY20KYsfADsnCSCYtQCvAu1XTwq08NI+C1eA4=;
  b=KLE6h6rV0scinn75QwvPLwuD4gujKoF3r5hoy4PneQSj5FP48U4itgcA
   wqZiBvUBRzQCN4aRh1gVmlwpZiKE7NIYYpBe/evgJs8GN9yzSqrGLDwki
   bYzD5FRW0Y3gKnT0BQHgpNKNbCoXj0c8Hmtwb48lPCF68F9iNvYBolEHa
   M=;
X-IronPort-AV: E=Sophos;i="6.13,232,1732579200"; 
   d="scan'208";a="166841038"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2025 00:01:55 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:47245]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.180:2525] with esmtp (Farcaster)
 id bd7fcdf2-4461-47a9-96cc-1b3e2f7fc914; Sat, 25 Jan 2025 00:01:54 +0000 (UTC)
X-Farcaster-Flow-ID: bd7fcdf2-4461-47a9-96cc-1b3e2f7fc914
Received: from EX19D015UWB002.ant.amazon.com (10.13.138.70) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 25 Jan 2025 00:01:54 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D015UWB002.ant.amazon.com (10.13.138.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 25 Jan 2025 00:01:54 +0000
Received: from email-imr-corp-prod-pdx-all-2b-5ec155c2.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Sat, 25 Jan 2025 00:01:54 +0000
Received: from dev-dsk-surajjs-2c-afd24e6d.us-west-2.amazon.com (dev-dsk-surajjs-2c-afd24e6d.us-west-2.amazon.com [10.189.247.117])
	by email-imr-corp-prod-pdx-all-2b-5ec155c2.us-west-2.amazon.com (Postfix) with ESMTP id A804340CDD;
	Sat, 25 Jan 2025 00:01:53 +0000 (UTC)
Received: by dev-dsk-surajjs-2c-afd24e6d.us-west-2.amazon.com (Postfix, from userid 10505755)
	id A25ACCFF; Sat, 25 Jan 2025 00:01:53 +0000 (UTC)
From: Suraj Jitindar Singh <surajjs@amazon.com>
To: <stable@vger.kernel.org>
CC: <almaz.alexandrovich@paragon-software.com>, <surajjs@amazon.com>,
	<sjitindarsingh@gmail.com>,
	<syzbot+8c652f14a0fde76ff11d@syzkaller.appspotmail.com>, Bin Lan
	<bin.lan.cn@windriver.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] fs/ntfs3: Additional check in ntfs_file_release
Date: Sat, 25 Jan 2025 00:01:12 +0000
Message-ID: <20250125000112.22389-1-surajjs@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

commit 031d6f608290c847ba6378322d0986d08d1a645a upstream.

Reported-by: syzbot+8c652f14a0fde76ff11d@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
---
 fs/ntfs3/file.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index af7e138064624..2d5d234a4533d 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -1192,8 +1192,16 @@ static int ntfs_file_release(struct inode *inode, struct file *file)
 	int err = 0;
 
 	/* If we are last writer on the inode, drop the block reservation. */
-	if (sbi->options->prealloc && ((file->f_mode & FMODE_WRITE) &&
-				      atomic_read(&inode->i_writecount) == 1)) {
+	if (sbi->options->prealloc &&
+	    ((file->f_mode & FMODE_WRITE) &&
+	     atomic_read(&inode->i_writecount) == 1)
+	   /*
+	    * The only file when inode->i_fop = &ntfs_file_operations and
+	    * init_rwsem(&ni->file.run_lock) is not called explicitly is MFT.
+	    *
+	    * Add additional check here.
+	    */
+	    && inode->i_ino != MFT_REC_MFT) {
 		ni_lock(ni);
 		down_write(&ni->file.run_lock);
 
-- 
2.40.1


