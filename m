Return-Path: <stable+bounces-194766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08887C5BA26
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 07:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D8313A3AAF
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 06:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3668E2C21C5;
	Fri, 14 Nov 2025 06:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="uwRHRqCq"
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746641B983F
	for <stable@vger.kernel.org>; Fri, 14 Nov 2025 06:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763103063; cv=none; b=SVNuhRw3RV9gqLQwEK9CqSldBuVvQgN5/8GIg0244vzZjI67QORvqE8vA8meIC/pvADaM1b0c2wL61PItmLKPEE+cs6/bruIB72llEV/m4FLcv2T1xPcWQT1aUfm1AS3SC19+2GfMnAu+KVBuBxRFyS2vo/XEd3dqDxtXMW8WqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763103063; c=relaxed/simple;
	bh=FpEQ0eNPB9JV38wbzvthYlflWjLCM+ABp0zDNQFYyTc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=SiwU4fzXLGtE0Md4Qge9dB7SEUqVqEGY0zAQEvuJq/UWHpNfbkgs9ZwYwIN5pRdH05ZdsbkcZqzc2/PfpIJTqRqFpmnoO4BISQwzFraOGI9mTXJ007mHeOy7eox9bOyUIcU0qlK2jGJUqnPAJA4AbSb1v0oI+kGLoRb5PeZp1UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=uwRHRqCq; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=uwRHRqCqVoteqbSABfiGafTk3uazYHhgAIw+0Kqx54GgRcMh3klmna9mnc647wbhjIhyS3OVHx9Ea
	 uzdfPZAETSRj3R7eY+kl8W6OkjMC05lf5V/zEktsnqJQKfOdcyNWRDSOepsXT09xI3VLef4MJVwfuV
	 UhxWqODuF4AWkXC8=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[117.129.7.61])
	by rmsmtp-lg-appmail-03-12081 (RichMail) with SMTP id 2f316916d09056d-47915;
	Fri, 14 Nov 2025 14:47:46 +0800 (CST)
X-RM-TRANSID:2f316916d09056d-47915
From: Rajani Kantha <681739313@139.com>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6.12] f2fs: fix to avoid overflow while left shift operation
Date: Fri, 14 Nov 2025 14:47:40 +0800
Message-Id: <20251114064740.25944-1-681739313@139.com>
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
index b05bb7bfa14c..fcd21bb060cd 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1236,7 +1236,7 @@ int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
 		int i;
 
 		for (i = cluster_size - 1; i >= 0; i--) {
-			loff_t start = rpages[i]->index << PAGE_SHIFT;
+			loff_t start = (loff_t)rpages[i]->index << PAGE_SHIFT;
 
 			if (from <= start) {
 				zero_user_segment(rpages[i], 0, PAGE_SIZE);
-- 
2.17.1



