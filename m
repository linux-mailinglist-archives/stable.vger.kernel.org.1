Return-Path: <stable+bounces-124163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5730A5DE17
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 14:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE5D1897E20
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 13:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5894D2459CC;
	Wed, 12 Mar 2025 13:32:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D9E248191;
	Wed, 12 Mar 2025 13:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741786379; cv=none; b=HkttqfBjJFmjFXy/qPw/F/eyQyge7IjyKVJ2aRiFSNR6uesY3NqDcW3NU3CygVxM9XxIds39nUffcgwtkn7bG5faNHribghrqa3B5/LdFOAr0wh+YO8YQy7HyigbOJFmMPioMXbOVbzBIDnq8ph1eGHKAKeL8Uhq/37qNNMCzq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741786379; c=relaxed/simple;
	bh=kv403D/IQDN0pDBtd3LOqsksN46GogObziXacwjD4xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rpg8CEU7YnmhzevhR7BX9sOLlN+18M+lElp5XjFO9OE2ozx62r4lrgb79Wmyd1Z2smy6RLcsbp6ySiuJssQpwNo890dOYYRZfLe6INt4hlzedpP8GgmDq7sFxLCQO6oPXdp9yxBRHxCZcg+1HXryFiqTWsoDyucrM17nV+XEC5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B920D200AD5;
	Wed, 12 Mar 2025 14:32:48 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 63B4420002C;
	Wed, 12 Mar 2025 14:32:48 +0100 (CET)
Received: from lsv03121.swis.in-blr01.nxp.com (lsv03121.swis.in-blr01.nxp.com [92.120.146.118])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 890CA1800088;
	Wed, 12 Mar 2025 21:32:46 +0800 (+08)
From: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
To: miquel.raynal@bootlin.com,
	conor.culhane@silvaco.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	manjunatha.venkatesh@nxp.com,
	rvmanjumce@gmail.com
Subject: [PATCH v3] svc-i3c-master: Fix read from unreadable memory at svc_i3c_master_ibi_work
Date: Wed, 12 Mar 2025 19:02:38 +0530
Message-ID: <20250312133238.2313772-1-manjunatha.venkatesh@nxp.com>
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

Below is the sequence where this issue happened.
1. During boot up sequence IBI is received at host  from the slave device
   before requesting for IBI, Usually will request IBI by calling
   i3c_device_request_ibi() during probe of slave driver.
2. Since master code trying to access IBI Variable for the particular
   device instance before actually it initialized by slave driver,
   due to this randomly accessing the address and causing kernel panic.
3. i3c_device_request_ibi() function invoked by the slave driver where
   dev->ibi = ibi; assigned as part of function call
   i3c_dev_request_ibi_locked().
4. But when IBI request sent by slave device, master code  trying to access
   this variable before its initialized due to this race condition
   situation kernel panic happened.

fixes: dd3c52846d595 (i3c: master: svc: Add Silvaco I3C master driver)
Cc: stable@vger.kernel.org
Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
---
Changes since v2:
  - Description  updated as per the review feedback

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


