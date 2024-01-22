Return-Path: <stable+bounces-14545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44894838156
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 783581C266B6
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6A014A0B8;
	Tue, 23 Jan 2024 01:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JIhVPvdv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F137F137C55;
	Tue, 23 Jan 2024 01:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705972104; cv=none; b=X4gCHIY22ofWf06YGV3oMqvG0BC1AYuZSLJmX/hNYr8Q/OvFPObmY4dceHaZ76gL/mWsjPNaXCtyO2n9bYmIe2+cs7ZTwNOXz8bWQVRx7D3lqVENHSMsMfzXVLcWjVJpiCf25hKq6bKoYlGFiLnHPWVV4MR7gCgl8LNy78F76ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705972104; c=relaxed/simple;
	bh=4SeQFj7droMnH8ZKtCQWchAjQpuW9CpQJFNIWj/gnbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1B9mjKmgqz/7PtJbs5+BsoOxApBh4jwru8bhmlFZuCtOeSsSz+k2Fx5LjiIy0UAmIibKCAnUarE8CDwSiLKpjRZ2JYYtk+PpFrOCusIyWgwhhJhn2909WwbjlC4h2PyQb1Gsbj8wWfX/jY3w37Qzv1ZKTO7AL2Zy6JbH7uS9jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JIhVPvdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB298C43394;
	Tue, 23 Jan 2024 01:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705972103;
	bh=4SeQFj7droMnH8ZKtCQWchAjQpuW9CpQJFNIWj/gnbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JIhVPvdvEhUsWdwkArQGiijkpEWcFO81KuqdruBckpKDgjf+0Nv1MmfISKngoajrf
	 yoFhx0nJZSF2APDAEnfhYBFCAx5sIad2NvPHM4CWuaA5l8cEBX5aKFjK0gg+ngeWnF
	 R8x2K79LXqL0qU7ToR6PTe5ry0XgjsOUMT4Tc0z4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 040/374] s390/scm: fix virtual vs physical address confusion
Date: Mon, 22 Jan 2024 15:54:56 -0800
Message-ID: <20240122235746.012835237@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235744.598274724@linuxfoundation.org>
References: <20240122235744.598274724@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vineeth Vijayan <vneethv@linux.ibm.com>

[ Upstream commit b1a6a1a77f0666a5a6dc0893ab6ec8fcae46f24c ]

Fix virtual vs physical address confusion (which currently are the same).

Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/block/scm_blk.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/block/scm_blk.c b/drivers/s390/block/scm_blk.c
index 88cba6212ee2..e36775c14782 100644
--- a/drivers/s390/block/scm_blk.c
+++ b/drivers/s390/block/scm_blk.c
@@ -18,6 +18,7 @@
 #include <linux/genhd.h>
 #include <linux/slab.h>
 #include <linux/list.h>
+#include <linux/io.h>
 #include <asm/eadm.h>
 #include "scm_blk.h"
 
@@ -131,7 +132,7 @@ static void scm_request_done(struct scm_request *scmrq)
 
 	for (i = 0; i < nr_requests_per_io && scmrq->request[i]; i++) {
 		msb = &scmrq->aob->msb[i];
-		aidaw = msb->data_addr;
+		aidaw = (u64)phys_to_virt(msb->data_addr);
 
 		if ((msb->flags & MSB_FLAG_IDA) && aidaw &&
 		    IS_ALIGNED(aidaw, PAGE_SIZE))
@@ -196,12 +197,12 @@ static int scm_request_prepare(struct scm_request *scmrq)
 	msb->scm_addr = scmdev->address + ((u64) blk_rq_pos(req) << 9);
 	msb->oc = (rq_data_dir(req) == READ) ? MSB_OC_READ : MSB_OC_WRITE;
 	msb->flags |= MSB_FLAG_IDA;
-	msb->data_addr = (u64) aidaw;
+	msb->data_addr = (u64)virt_to_phys(aidaw);
 
 	rq_for_each_segment(bv, req, iter) {
 		WARN_ON(bv.bv_offset);
 		msb->blk_count += bv.bv_len >> 12;
-		aidaw->data_addr = (u64) page_address(bv.bv_page);
+		aidaw->data_addr = virt_to_phys(page_address(bv.bv_page));
 		aidaw++;
 	}
 
-- 
2.43.0




