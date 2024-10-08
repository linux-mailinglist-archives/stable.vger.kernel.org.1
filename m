Return-Path: <stable+bounces-82534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8AD994D36
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C68282E6C
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2531DE4CC;
	Tue,  8 Oct 2024 13:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N/S0l1MQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5969F1DFD1;
	Tue,  8 Oct 2024 13:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392586; cv=none; b=aov2SyCBXltjTIRGLfzKqC5jK/50vRm3slGxwHYPdDuSnYCPXgStOD6Vei2HklbDY/hsbjupA8+hXwcHp7+BByiAN1GY5E9Mv6iR8EQYS0Ve88b10/zUGBc4m0TRmo8kmwVyixD/a7M66B9UBEIfjswsOE95HgEcNMpgcGjw60U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392586; c=relaxed/simple;
	bh=uttZCf+lJRSeTAe9iZCE1X2+O2YH+fn8gf6dqjkNK+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=larvaGXCdLsHW2+JWv6YXjXWuWfwwSPFLO8DJyrxvUQeAOfvuzAv4+Q7IRdR1hZT7UvUeUcHf6lHECHXamXTLMKVz+NU6WbYgxJpCkbZkAC2vwYtJ4ooPUBQek3IZ+iKkmyisyhqrWix1AvO2Sq+gRlUtnQSQU83oXXZnyyWhow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N/S0l1MQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD046C4CEC7;
	Tue,  8 Oct 2024 13:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728392586;
	bh=uttZCf+lJRSeTAe9iZCE1X2+O2YH+fn8gf6dqjkNK+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N/S0l1MQSS1ojGv1b0GTiap9Tv1zCf52j9ftPcwO5eERYojLx+kUK07JNn3reNlWn
	 tNJfSEZEQFYehz1XvEQWamWa5QgK3XOTEE8ei1PKSjgHfEf80M40415jUAlflsuKEx
	 sVeB7z/bhIldhbJvHAkkc51/a9tbsVNnY8ob9/Hw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zheng Wang <zyytlz.wz@163.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 6.11 460/558] media: venus: fix use after free bug in venus_remove due to race condition
Date: Tue,  8 Oct 2024 14:08:10 +0200
Message-ID: <20241008115720.355325357@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zheng Wang <zyytlz.wz@163.com>

commit c5a85ed88e043474161bbfe54002c89c1cb50ee2 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/qcom/venus/core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -430,6 +430,7 @@ static void venus_remove(struct platform
 	struct device *dev = core->dev;
 	int ret;
 
+	cancel_delayed_work_sync(&core->work);
 	ret = pm_runtime_get_sync(dev);
 	WARN_ON(ret < 0);
 



