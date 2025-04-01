Return-Path: <stable+bounces-127342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16212A77EBB
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 17:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D36F188FEE6
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 15:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D285C20A5E9;
	Tue,  1 Apr 2025 15:19:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715C0204875;
	Tue,  1 Apr 2025 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743520765; cv=none; b=HrrG0v3GK6RIWps/+y3Mu+CWxAmUb70TTQOZjt7q3Q8whr4SsjnvKWDIcLLuChwm+qdTlj7Nc2k38StflVKTfivK1hx5i5U78XNTDz2MrwtuDZwHxQwZ3rINiuybFj7knnDA+4Y447hC4RAtHS95CEVuy+MYDHJGXzs1tDR+H44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743520765; c=relaxed/simple;
	bh=UDBLdp3G5XLl9adnfAstrrZW/PBho8d/rc6SWcjR6WE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cYRnwv5fSopt8ncrwlVkYbcRjKBQSdUdObmPckJRCfOpGLRrXSHvRDQ9frQjb8e2S2+LtcP0ElSpq7wwt6VEU6AvFMSOPQ2M+pnZ7Sb2mHz55BMlJrP5mNvJt6FUZhT6NJhqcdXiam6pEWh83gEtrp/WLA609XS3vPCkdn79rY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowADnIwz0A+xnSRjGBA--.10747S2;
	Tue, 01 Apr 2025 23:19:18 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: gregkh@linuxfoundation.org,
	tj@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] kernfs: fix potential NULL dereference in mmap handler
Date: Tue,  1 Apr 2025 23:18:59 +0800
Message-ID: <20250401151859.2842-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnIwz0A+xnSRjGBA--.10747S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr4DKFWkAF1fJFWrCr45KFg_yoWkurc_Jr
	95CrZ8Wr4UXF1avF1ayws3Zr9aqaykZr1Fya15t3yUtws8t3s7Gr95u3Zrur4DJrWUGr4D
	Aw1DCr90vr17CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
	Gr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU8miiUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwsTA2fr2Gl+eQAAsm

The kernfs_fop_mmap() invokes the '->mmap' callback without verifying its
existence. This leads to a NULL pointer dereference when the kernfs node
does not define the operation, resulting in an invalid memory access.

Add a check to ensure the '->mmap' callback is present before invocation.
Return -EINVAL when uninitialized to prevent the invalid access.

Fixes: 324a56e16e44 ("kernfs: s/sysfs_dirent/kernfs_node/ and rename its friends accordingly")
Cc: stable@vger.kernel.org # 3.14+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 fs/kernfs/file.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 8502ef68459b..7d8434a97487 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -459,9 +459,14 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
 		goto out_unlock;
 
 	ops = kernfs_ops(of->kn);
-	rc = ops->mmap(of, vma);
-	if (rc)
+	if (ops->mmap) {
+		rc = ops->mmap(of, vma);
+		if (rc)
+			goto out_put;
+	} else {
+		rc = -EINVAL;
 		goto out_put;
+	}
 
 	/*
 	 * PowerPC's pci_mmap of legacy_mem uses shmem_zero_setup()
-- 
2.42.0.windows.2


