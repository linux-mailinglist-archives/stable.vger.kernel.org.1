Return-Path: <stable+bounces-195453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E84C772F8
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 04:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 7133129A2D
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 03:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F1A2701D1;
	Fri, 21 Nov 2025 03:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="spoLQxjk"
X-Original-To: stable@vger.kernel.org
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1355B27702E
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 03:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763696972; cv=none; b=Nsd/C4HdOu+qv5ZV742d+VAnu2/H55XPRnugWwrvmUQcEycgvjtEqynSpyAFyTFOW65HR9Bp7kESzZFGs0rTV0BtEIXiSRS4KMIsInJzs6Qo6sUsa5bdAQ3gV10qfMD+hBvHvdvhUxjhEOZ+gkiv3tIjrn4V90CDakQ4YhyXpjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763696972; c=relaxed/simple;
	bh=a1doaysq9Nil/3qONO52jTyBmEug72290VcvQu9YkIY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=SfpKO1X6LEh1ne+YanebXvSWPgV4tZtJKzG3F5ZZGoJey7Htf9u0byx9i2mFbum9b/iKAZ9189Mu7UnYHhnmi19zdfWdDzjqFu172bl2p0C2d3Dq3ER1qwwWFl6gSgzlPTPk3OIuHQIcp/2/l9ytDA43I7DYU7JH+iIEwXFAhoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=spoLQxjk; arc=none smtp.client-ip=120.232.169.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=spoLQxjkK1isspDxlCdd7zhAyA/h/9yQfufjwUJDdgaGGdM7o2Ys6vabTCL0qHuLE9O5A3uJaylKS
	 2JMYu1mx+CecrIRp45X9ZaYNintdSVTnOWFfRxP2E2xO/bbMPXSsBc+CMxXfg/pr/9J1yuQYwkzvJk
	 M8jJfQMMxMo/3fQ0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[117.129.7.61])
	by rmsmtp-lg-appmail-24-12027 (RichMail) with SMTP id 2efb691fe087fd2-f8c67;
	Fri, 21 Nov 2025 11:46:16 +0800 (CST)
X-RM-TRANSID:2efb691fe087fd2-f8c67
From: Rajani Kantha <681739313@139.com>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6.6.y] f2fs: fix to avoid overflow while left shift operation
Date: Fri, 21 Nov 2025 11:46:10 +0800
Message-Id: <20251121034610.2709-1-681739313@139.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Chao Yu <chao@kernel.org>

[ Upstream commit 0fe1c6bec54ea68ed8c987b3890f2296364e77bb ]

Should cast type of folio->index from pgoff_t to loff_t to avoid overflow
while left shift operation.

Fixes: 3265d3db1f16 ("f2fs: support partial truncation on compressed inode")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ Modification: Using rpages[i]->index instead of folio->index due to
it was changed since commit:1cda5bc0b2fe ("f2fs: Use a folio in
f2fs_truncate_partial_cluster()") on 6.14 ]
Signed-off-by: Rajani Kantha <681739313@139.com>
---
 fs/f2fs/compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index e962de4ecaa2..c3b2f78ca4e3 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1209,7 +1209,7 @@ int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
 		int i;
 
 		for (i = cluster_size - 1; i >= 0; i--) {
-			loff_t start = rpages[i]->index << PAGE_SHIFT;
+			loff_t start = (loff_t)rpages[i]->index << PAGE_SHIFT;
 
 			if (from <= start) {
 				zero_user_segment(rpages[i], 0, PAGE_SIZE);
-- 
2.17.1



