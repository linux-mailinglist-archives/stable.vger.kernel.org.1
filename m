Return-Path: <stable+bounces-110152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E0AA190BD
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 12:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7E71656BE
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 11:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2766C211A32;
	Wed, 22 Jan 2025 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="PY1+N8bD"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6857E20FA9A
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737545875; cv=none; b=KVOV7E9apPbPJfCnYpCh+fnW8OktXUBAoCUSqMVOOn4xTrUlD4BwXWCVDv9o+bc0m3/byCXT20TEqrQjPaO6sHkcJIaVzVAUhSXiUG/27StAvdLW76snYz5gj0DoHb9pQvDQI+z48D9TYDebQRb9DcT9KgtqFZmMKLTILjCrSHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737545875; c=relaxed/simple;
	bh=+NHbohwkpxI53A1CDLdxMfW9WYxK8vT7iEtFaPnFzRY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=nbRZR+DvnJhyqNY0wotdUCpkBrysOh+bbOPmQQssNykSo5Xge2etDXQ12nMZ2q2HPQG9O6I3lJEGz6aqt6wYHzU8YKxQalmopDZEBqlXEAoX5zBEAGRUYHHz6VVzKcBUI6d10fg1WVBcf8nnC0lR7hl1QIN79boHdMr1elAct8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=PY1+N8bD; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1737545870;
	bh=1LrXgti5zqf2aJw0Ag5frAOnN1gKc/aUo0+QuZol2dI=;
	h=From:To:Cc:Subject:Date;
	b=PY1+N8bD7/jh8/zwxR98WoXWcO26QyS7CS+VlMPr1j59cYzWuGdwwUMtu8NVNG0of
	 V+F4NQYwBZOAKiWF+XH7y/pCQxEMaL2pHwtYLy6ae2axV7AAE4C0aipKPTFuqLJ6xN
	 y7rJ6BR3zrKvSWhe9U6V4fQldY/8IrbT/p7DZjds=
Received: from public ([120.244.194.224])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 963B8C6F; Wed, 22 Jan 2025 19:37:35 +0800
X-QQ-mid: xmsmtpt1737545855tfcvv72yo
Message-ID: <tencent_ABAD564DE407BF249EF53E0E184C5CC30006@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoe9tlIgDnrlMhQpCOAeabs896fe9P7GGZILTrQ8wAiCRY1qKrJJ3
	 nLgFMxTst3ndKKeJZVZpEgJPXiop7bzT1Z+OlxxmyLcUhKFqQyf+gnzJ1GERswUTfyT+AxVZyKEd
	 /FvsFldLO119+/zjyAJ1sSRkJyRFq6I0QDMH3NFkn4rzJU3Q/ru3wBlyMC6Is/Avt6qGkiCOJ0az
	 TLNHUdpgDBjj0w0qIZqEEMB0equu5QGUNWMyDd6zYBi0aKaQWn+/7Nw7AkK+HCDsEMsL86iCaHdk
	 AziqUfOSzcW8id66WHIGdZZ+Ph4JLal/owZ9sHrTU9VdcPLFSVtznx72ndJewfRo3pU3FNwmjda/
	 DjUP1F81shpnf3xH9S/WQmFLvXfUgQB2hWa0efpHaPSipbQKyZ0VqKQK69N34z4rjh8yX2KCGqoL
	 IXw7FdLVngrZRcG+qHh4Aa2o3ViOS0PrH2h0v8nzih+elbL1ojWv+IF5dJsMOfFHVGuHoh3cDDSP
	 y2I3idFzga7z3odDkdYv5ur2/q8t7ITB8HgIr6iqAbp4+CF6UNXv6EN/SxaNjtdPiPvxAq2hyyA6
	 vAcm04iJhQ7zabqgXaOfaALr9Q7LkNzrHadfibPB4ptetftHdLQ90yysZu8YpB/37avXGU81Dyc8
	 3oDRxcm9gRwkSLB/21KXYKGzIk/2+ugFqYo9B8O0LG9QMgohJrgV+GE0+pd8+pnT6Jhz9iSANhsF
	 JbFZI6TTBDOLWBtdlY8oeoC3+u3y5QWgO3VKpzPx8kVXA4GXuGIRZneNIYdqFJzoel/E7cnaNNpw
	 ieyRqh5s2Js1WaR1xecR5LxtixjJTfF5zekerHuD2izSJCTErlv+rLQ9iRyy0MZZl2sEWYlhpWOW
	 eKnnldSWH20pOWy6zVT8Q2LmFFpR4HAWfBpKjSa78S+t8ZhR8IH0/m6oeTG5TZt1jOeyf119P5R9
	 mbR4wPF2pOc96k27DJ47vPlexc1Wsy1IuA8Fk0t1S9AJZPFqyE5Wd9mC34yi5Vxh6ome/ur03vxF
	 pjiO3gkaDNIqIo3Hq9R0umaC+Ynhs=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: alvalan9@foxmail.com
To: stable@vger.kernel.org
Cc: Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Chandramohan Akula <chandramohan.akula@broadcom.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.6.y] RDMA/bnxt_re: Avoid CPU lockups due fifo occupancy check loop
Date: Wed, 22 Jan 2025 19:37:36 +0800
X-OQ-MSGID: <20250122113736.2474-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Selvin Xavier <selvin.xavier@broadcom.com>

[ Upstream commit 8be3e5b0c96beeefe9d5486b96575d104d3e7d17 ]

Driver waits indefinitely for the fifo occupancy to go below a threshold
as soon as the pacing interrupt is received. This can cause soft lockup on
one of the processors, if the rate of DB is very high.

Add a loop count for FPGA and exit the __wait_for_fifo_occupancy_below_th
if the loop is taking more time. Pacing will be continuing until the
occupancy is below the threshold. This is ensured by the checks in
bnxt_re_pacing_timer_exp and further scheduling the work for pacing based
on the fifo occupancy.

Fixes: 2ad4e6303a6d ("RDMA/bnxt_re: Implement doorbell pacing algorithm")
Link: https://patch.msgid.link/r/1728373302-19530-7-git-send-email-selvin.xavier@broadcom.com
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
[ Add the declaration of variable pacing_data to make it work on 6.6.y ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index c7e51cc2ea26..082a383c4913 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -485,6 +485,8 @@ static void bnxt_re_set_default_pacing_data(struct bnxt_re_dev *rdev)
 static void __wait_for_fifo_occupancy_below_th(struct bnxt_re_dev *rdev)
 {
 	u32 read_val, fifo_occup;
+	struct bnxt_qplib_db_pacing_data *pacing_data = rdev->qplib_res.pacing_data;
+	u32 retry_fifo_check = 1000;
 
 	/* loop shouldn't run infintely as the occupancy usually goes
 	 * below pacing algo threshold as soon as pacing kicks in.
@@ -500,6 +502,14 @@ static void __wait_for_fifo_occupancy_below_th(struct bnxt_re_dev *rdev)
 
 		if (fifo_occup < rdev->qplib_res.pacing_data->pacing_th)
 			break;
+		if (!retry_fifo_check--) {
+			dev_info_once(rdev_to_dev(rdev),
+				      "%s: fifo_occup = 0x%xfifo_max_depth = 0x%x pacing_th = 0x%x\n",
+				      __func__, fifo_occup, pacing_data->fifo_max_depth,
+					pacing_data->pacing_th);
+			break;
+		}
+
 	}
 }
 
-- 
2.43.0


