Return-Path: <stable+bounces-166541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A66B1B05E
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 10:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81B2717A7E7
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 08:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BACA238176;
	Tue,  5 Aug 2025 08:46:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m32100.qiye.163.com (mail-m32100.qiye.163.com [220.197.32.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139781991CA;
	Tue,  5 Aug 2025 08:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754383600; cv=none; b=Nf1h12glMKW3S2OqkcwscKzEYrrsENfQYf3jg1l3NEVnrtdvW27bB7Mjc22ZUewH9bOJt8cSr0CmthAuARrGDlPGaXIv1LOllMg1i7AXHrxy6Bo9HmM4zOMVTHhvvQL7dThD41T2V9dT+0UcCuc4t+tR5/ueuFecxctPcS5ECfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754383600; c=relaxed/simple;
	bh=8+mnIs3SVQARHbtATo2pOwtW5bUbAsS2w/imde7zygY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nfRU00J+/5ahrusd8DQpAb9zZnhWEp1v3jk/HDmbjs/2TwADtqCsToB2FoJXFaE2NorC0pSMpnCHiY7Prdo8qZTx2aX+a2enzQ09ddqYMZ/bgFeuzDLnlrMdTWLmASSmLKGa9pL+tjGd8QE6WSM7or33R0RxppH+J4P+40EgoNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=220.197.32.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id e29cf60e;
	Tue, 5 Aug 2025 15:30:49 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: Markus.Elfring@web.de,
	viro@zeniv.linux.org.uk,
	linux@armlinux.org.uk,
	rmk+kernel@armlinux.org.uk
Cc: linux-kernel@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] fs/adfs: bigdir: Restore EIO errno return when checkbyte mismatch
Date: Tue,  5 Aug 2025 15:30:40 +0800
Message-Id: <20250805073040.192968-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250801093806.1223287-1-zhen.ni@easystack.cn>
References: <20250801093806.1223287-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a987923d7f80229kunm0b0815b455eeb2
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGBoZVhoZS0JOTkpKGhkYT1YVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+

The error path in adfs_fplus_read() prints an error message via
adfs_error() but incorrectly returns success (0) to the caller.
This occurs because the 'ret' variable remains set to 0 from the earlier
successful call to adfs_fplus_validate_tail().

Fix by setting 'ret = -EIO' before jumping to the error exit.

This issue was detected by smatch static analysis:
warning: fs/adfs/dir_fplus.c:146: adfs_fplus_read() warn: missing error
code 'ret'.

Fixes: d79288b4f61b ("fs/adfs: bigdir: calculate and validate directory checkbyte")
Cc: stable@vger.kernel.org
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
Changes in v2:
- Add tags of 'Fixes' and 'Cc' in commit message
- Added error description and the corresponding fix in commit message
---
 fs/adfs/dir_fplus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index 4a15924014da..4334279409b2 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -143,6 +143,7 @@ static int adfs_fplus_read(struct super_block *sb, u32 indaddr,
 
 	if (adfs_fplus_checkbyte(dir) != t->bigdircheckbyte) {
 		adfs_error(sb, "dir %06x checkbyte mismatch\n", indaddr);
+		ret = -EIO;
 		goto out;
 	}
 
-- 
2.20.1


