Return-Path: <stable+bounces-135063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59E6A962C8
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 10:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B78677A5CA3
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D0C25E837;
	Tue, 22 Apr 2025 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="VKc3UsUF"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE02238C15;
	Tue, 22 Apr 2025 08:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311443; cv=none; b=ipxqiadY1fTQ8vOQtfPt7TTQ8YkFFF8nPK9E+FdeSYlN60mKFrUCEbkk5HAZaQplrPMh3wuoCWOZnKpFWi1kadAAXHh5GuXwnfrK15ZWEt2p6cZPww+oDH80VisrKesXSJ5M5Oq4QpafgkeLAXTKq2qkVkFvhZwINMJI3tArrnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311443; c=relaxed/simple;
	bh=fE6e3T0ztqihdFOemjtdTl+BdpIf6JYZqyHpceFLW1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O68+0jhUC6WT62B0ZwDvA4Zj6l2NpJwORSmUPpDobvRMfNPO4bQvs56r9JYsOh3ULuX87r3jVLwNQopyfMr3pm1Zayzxek5kGgQnXrbbD2tj7j+JcyfmKn5ZqE3yfaAopkdTpCJj3vGBBWGY5wvB8QRzxzg+unkHdbvpIORjIuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=VKc3UsUF; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1745311358;
	bh=ta9c7PBfYNJdA/EddRHHdw/PT5n6zrxUu0kZcu8S4yI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=VKc3UsUFJ4dkJhG5s3Qpr5aVx5K5scUwzl5lNPG23iu42gG9VfaHXWOpX5+GX9cas
	 Yg/4K/SLT/NB9O6Bnc3N3Gm4BfKA4L428Sg5Rw0phcmPZ6EV5F5b5o21N5F5moOKb4
	 lAtASLe8xwwSOivSi0Y2NKzdz0Xj++Jy3+5q4LBQ=
X-QQ-mid: zesmtpip4t1745311352tbc6f2798
X-QQ-Originating-IP: D8iucQ4g6QfgRn6AdF4rdReU2rpnTyIVkPf9B1N4tYU=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Apr 2025 16:42:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6722607593758922458
EX-QQ-RecipientCnt: 11
From: WangYuli <wangyuli@uniontech.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: james.smart@broadcom.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	WangYuli <wangyuli@uniontech.com>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH 5.15/6.1/6.6] nvmet-fc: Remove unused functions
Date: Tue, 22 Apr 2025 16:40:47 +0800
Message-ID: <85E64841B89AA153+20250422084047.100708-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Macl0gWiWu4eRuOOyk37VxCKREBShQeCnU1W3GYww67YWdfrfBicqJUW
	CXKHT17TFozzMO9ShqUyqkhflZP4klbot6zzUoXae2EVnzorSMbBIsLqob2Bofyrev+aVMQ
	lUeJiVEq5eBtlxEKRLyNbZ2r9zAWeWG4jRBN1fEpRr/rm3hUNr9bN9b92Z0G3r8hAAQ2ulR
	wFCEgIKq1PN1hPd1MOHhTJ0tIML5AW0puC80eD8xoFNSujMB04gFzw8uxDxwrfahd0P4Hl6
	5YzMxN6CN/Hg7ulJQYP5ajYrViJ7zyM/12NZny9AJK9Zh7PRn5Rp4OigGiLu64C+2dSFaUE
	J/olxGNow8bJ6sSxJ8w89wNJ/Wnk2PJdzP2FKSCcd4IqK9jeLGAmQwvXBuUfFfnr4KgVlXv
	XIWE1J0L3z9N46MDjwLtlwSeKJQw7GOmrMtH437rYoZ0jzIcnp2Pxn5Pvdp+gIWA2I6bli+
	9J8Lt27zrIlh6eNlKxp0GY3F3Q9DxvVo1/Ov0AF4IF22ZYCWi2IzE1JNKWxsChBrs6I8kBv
	TkC0BbPny4GMxHs1QmCoXKuaLU6r57MAyjjg5PFhD3lqbAha/859YpRni+1dAo5qFSL3z7U
	W0YbPIw4tACgwu86KAb7gygENy0/JJc/Eb+Vk6I/IDVb9E5WBfin8stPYq6utagHhMYiRN9
	Ae8j74AeHx+JGCjqQPNLUZttZCZPFQH0Ak6dQgQLul4sOsQ9tvdwhytM0whbFjI1axC+A4M
	AXS+nKs+vV4CZjHeCs7fNVdMToE4zBrBfejTIHuRxvhMftTqYSEovSaIlmZI/Jfmx8WXJGI
	hKOeb8LzCNmVHBOZZJiEIrX/aOEKG+3ymjbZ/lK/igAU3UY+YCj1IUD/lQonDSDTVEIF9aD
	mvuuuTsnPW8i87SONr4KIPHqEWzUCUQUgjXU1xPfGnUzvuLD1VM2kwzOPSbkU6nHNDmKwQU
	LqZKJtkx2++LU1HnyTzdjwDwl5Mygk5xFgzwbpaGJpHRuObV3PixqEMxMaVculKxZEbYjf0
	tMdkbnZM1YdfZSk6SgWhJgbC+0bt1GR/kgoIQzv5KnTUiAr9ZvGNjKlTAJddsOGinX4NSTB
	ktwoRIVmwcQ
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

[ Upstream commit 1b304c006b0fb4f0517a8c4ba8c46e88f48a069c ]

The functions nvmet_fc_iodnum() and nvmet_fc_fodnum() are currently
unutilized.

Following commit c53432030d86 ("nvme-fabrics: Add target support for FC
transport"), which introduced these two functions, they have not been
used at all in practice.

Remove them to resolve the compiler warnings.

Fix follow errors with clang-19 when W=1e:
  drivers/nvme/target/fc.c:177:1: error: unused function 'nvmet_fc_iodnum' [-Werror,-Wunused-function]
    177 | nvmet_fc_iodnum(struct nvmet_fc_ls_iod *iodptr)
        | ^~~~~~~~~~~~~~~
  drivers/nvme/target/fc.c:183:1: error: unused function 'nvmet_fc_fodnum' [-Werror,-Wunused-function]
    183 | nvmet_fc_fodnum(struct nvmet_fc_fcp_iod *fodptr)
        | ^~~~~~~~~~~~~~~
  2 errors generated.
  make[8]: *** [scripts/Makefile.build:207: drivers/nvme/target/fc.o] Error 1
  make[7]: *** [scripts/Makefile.build:465: drivers/nvme/target] Error 2
  make[6]: *** [scripts/Makefile.build:465: drivers/nvme] Error 2
  make[6]: *** Waiting for unfinished jobs....

Fixes: c53432030d86 ("nvme-fabrics: Add target support for FC transport")
Signed-off-by: WangYuli <wangyuli@uniontech.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/fc.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index d3ca59ae4c7a..88893e78661c 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -173,20 +173,6 @@ struct nvmet_fc_tgt_assoc {
 	struct rcu_head			rcu;
 };
 
-
-static inline int
-nvmet_fc_iodnum(struct nvmet_fc_ls_iod *iodptr)
-{
-	return (iodptr - iodptr->tgtport->iod);
-}
-
-static inline int
-nvmet_fc_fodnum(struct nvmet_fc_fcp_iod *fodptr)
-{
-	return (fodptr - fodptr->queue->fod);
-}
-
-
 /*
  * Association and Connection IDs:
  *
-- 
2.49.0


