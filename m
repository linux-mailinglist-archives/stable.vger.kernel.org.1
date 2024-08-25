Return-Path: <stable+bounces-70104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A9595E25C
	for <lists+stable@lfdr.de>; Sun, 25 Aug 2024 09:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 243DB1C21388
	for <lists+stable@lfdr.de>; Sun, 25 Aug 2024 07:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652523C092;
	Sun, 25 Aug 2024 07:16:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BEE17C61
	for <stable@vger.kernel.org>; Sun, 25 Aug 2024 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724570210; cv=none; b=VLe1t9mdcFqILW7SBo8ALTLZzrUZcmNtJs1ArpMWsRlFLr3uFqBMLPzGBcmaQtKoi1lmqJkVU39zWs38sPuaKotXGjFfYns09pPhCizX/12165SL6rvR5bgHtUUKW+YpTUY9XK/0te3oRKwKKKbE/I4umGvEtSKaZkE2EmToPoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724570210; c=relaxed/simple;
	bh=ZKpCFYH4SsZ9irh4f1lBtF+pbP7WN1rXh9IOr3mQ05U=;
	h=From:Date:Subject:To:Cc:Message-Id; b=CsJPWOWjIsYoPaWUB3PEo5pDA5L0+hXitGqMtAgJt6n9lWK8nGi79YANNkyLkd3j0gvyf2/63n4iZaw3QoAyt2jee6rmbFZVDNaPgxU0ofhAbXNCtrHrg3ixxoplDvw+2LZL3ZsTgBfZ6OM+LbVs/wPNKJJ9qd1o4XcBqRHL420=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1si7UQ-0008Lu-0A;
	Sun, 25 Aug 2024 07:16:42 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Sun, 25 Aug 2024 07:16:07 +0000
Subject: [git:media_stage/master] media: venus: fix use after free bug in venus_remove due to race condition
To: linuxtv-commits@linuxtv.org
Cc: Dikshita Agarwal <quic_dikshita@quicinc.com>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Zheng Wang <zyytlz.wz@163.com>, stable@vger.kernel.org
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1si7UQ-0008Lu-0A@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: venus: fix use after free bug in venus_remove due to race condition
Author:  Zheng Wang <zyytlz.wz@163.com>
Date:    Tue Jun 18 14:55:59 2024 +0530

in venus_probe, core->work is bound with venus_sys_error_handler, which is
used to handle error. The code use core->sys_err_done to make sync work.
The core->work is started in venus_event_notify.

If we call venus_remove, there might be an unfished work. The possible
sequence is as follows:

CPU0                  CPU1

                     |venus_sys_error_handler
venus_remove         |
hfi_destroy	 		 |
venus_hfi_destroy	 |
kfree(hdev);	     |
                     |hfi_reinit
					 |venus_hfi_queues_reinit
                     |//use hdev

Fix it by canceling the work in venus_remove.

Cc: stable@vger.kernel.org
Fixes: af2c3834c8ca ("[media] media: venus: adding core part and helper functions")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Signed-off-by: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/platform/qcom/venus/core.c | 1 +
 1 file changed, 1 insertion(+)

---

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 165c947a6703..84e95a46dfc9 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -430,6 +430,7 @@ static void venus_remove(struct platform_device *pdev)
 	struct device *dev = core->dev;
 	int ret;
 
+	cancel_delayed_work_sync(&core->work);
 	ret = pm_runtime_get_sync(dev);
 	WARN_ON(ret < 0);
 

