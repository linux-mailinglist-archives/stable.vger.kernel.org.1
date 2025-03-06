Return-Path: <stable+bounces-121184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F2AA54478
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 09:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED57F18862DE
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 08:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFA31DF24E;
	Thu,  6 Mar 2025 08:17:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F5F2E3386;
	Thu,  6 Mar 2025 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249038; cv=none; b=t0ox4hwHsFf39F/ynOL6BbBVvIwrShXfXMw1BdXkyDDbkmtkg74LkDDsT1nD0raLAEn9P7SUl3o7Mm134g7Rz9x66U1iIuNjw/yVHB41loftn3+xWHvFJ4p29c9L0QRdJnn+G9m2UyQZMIf9wlcSoUIChFtW0k0pcwiThLC27b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249038; c=relaxed/simple;
	bh=r2SNjSzrTJri8d4TezjFMm+gimnEBaOKUfo4+QtRBeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DFUoyTZYItpc/gs8QwR3UBKZc8cJSRmG1SbBakH1NLIyCfvbTkrq/p6/pCypJaR+a8cG1V3BPCyVdaGBg5qRqVSa14idXKAawGgFu0OhfZmty2eTrNBYgIsjynmPR85E9c3Wvm3QQ961WFXYLulhPIvqcYDvftextSubpSkhons=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CA4B21A102D;
	Thu,  6 Mar 2025 09:17:15 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 869B41A1036;
	Thu,  6 Mar 2025 09:17:15 +0100 (CET)
Received: from lsv03121.swis.in-blr01.nxp.com (lsv03121.swis.in-blr01.nxp.com [92.120.146.118])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id AE11B18000AB;
	Thu,  6 Mar 2025 16:17:13 +0800 (+08)
From: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
To: miquel.raynal@bootlin.com,
	conor.culhane@silvaco.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	manjunatha.venkatesh@nxp.com,
	rvmanjumce@gmail.com
Subject: [PATCH v2] svc-i3c-master: Fix read from unreadable memory at svc_i3c_master_ibi_work()
Date: Thu,  6 Mar 2025 13:47:10 +0530
Message-ID: <20250306081710.247247-1-manjunatha.venkatesh@nxp.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

As part of I3C driver probing sequence for particular device instance,
While adding to queue it is trying to access ibi variable of dev which is
not yet initialized causing "Unable to handle kernel read from unreadable
memory" resulting in kernel panic.

Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
---
Changes since v1:
  - Patch tittle updated as per the review feedback

 drivers/i3c/master/svc-i3c-master.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index d6057d8c7dec..98c4d2e5cd8d 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -534,8 +534,11 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 	switch (ibitype) {
 	case SVC_I3C_MSTATUS_IBITYPE_IBI:
 		if (dev) {
-			i3c_master_queue_ibi(dev, master->ibi.tbq_slot);
-			master->ibi.tbq_slot = NULL;
+			data = i3c_dev_get_master_data(dev);
+			if (master->ibi.slots[data->ibi]) {
+				i3c_master_queue_ibi(dev, master->ibi.tbq_slot);
+				master->ibi.tbq_slot = NULL;
+			}
 		}
 		svc_i3c_master_emit_stop(master);
 		break;
-- 
2.46.1


