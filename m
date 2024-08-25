Return-Path: <stable+bounces-73653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2655096E197
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 20:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B121C23D40
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 18:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1C917BEA4;
	Thu,  5 Sep 2024 18:09:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06FD15B562
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 18:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725559765; cv=none; b=LDd2R1TjtLcEKEQdp+eEiT2XjIxftHNKxtRu0rPmW5S1awio30niNWGOWDnR8xXWkCSeiJrSMn4Fx23S29F4J3R6eW/iqDS/sLgrkge4yGhAVNMQI3jfOjr268qDK20CZ2PTiJDrugZvhdLCZjPGU0b6GdJVNzjKWz7cMo1ZubY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725559765; c=relaxed/simple;
	bh=ZKpCFYH4SsZ9irh4f1lBtF+pbP7WN1rXh9IOr3mQ05U=;
	h=From:Date:Subject:To:Cc:Message-Id; b=rzLnUE3S6cBaza6tp5OvthIWVMjFvm7LPTp0zNLJayF5PeqmcDdmCVRVxTdbPmYs5TaYXcRjrJkOVfqxGsvrjGYnxo66d88PQIxIFlmtpEianL09VXr/envybfqrRr0+B5Ea1hrmH8jUGHiaG3CG6Z9LYSomoSzP+oDQNhGaRsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from mchehab by linuxtv.org with local (Exim 4.96)
	(envelope-from <mchehab@linuxtv.org>)
	id 1smGv1-0001iU-1u;
	Thu, 05 Sep 2024 18:09:19 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Sun, 25 Aug 2024 07:16:07 +0000
Subject: [git:media_tree/master] media: venus: fix use after free bug in venus_remove due to race condition
To: linuxtv-commits@linuxtv.org
Cc: Zheng Wang <zyytlz.wz@163.com>, Dikshita Agarwal <quic_dikshita@quicinc.com>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, stable@vger.kernel.org
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1smGv1-0001iU-1u@linuxtv.org>
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
 

