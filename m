Return-Path: <stable+bounces-45053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 703538C5587
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FF7BB22480
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7630B26AC5;
	Tue, 14 May 2024 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pBY1zowT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364CFF9D4;
	Tue, 14 May 2024 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687945; cv=none; b=WQblwiyxH93d2tjJXhH3QHqs36UyLGKDw98NY1ZCWdq0Uk3HSfwQWukxqFCb7/Uyn+GTEDyU8eT12zsizIzQ7LdkbwyGY89uKfi05KouoWVlFwyzB/ujJuqxOnSLB/jw4Y86BDqUNOv3SaY1cKQ2fF/em+mMjsYMyMVexNSiq3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687945; c=relaxed/simple;
	bh=Qr12FvKj8A9VeeQhTKpNt/XeupP11VUDMLkT1f83mgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/f50XnGBBHyUSVlGVOSRoxJ018wS8tkH1h/tQQrh7gCnf3aq7IUnXkm/ttjpKXozaZqSVHmuXuLG5pPsffm6VjiMw9CtYwOyfTvuz2OnsrH+oJQb8KYiQScQ6aISb2KMOM9l2IjNy90nIKvyzvmHLoiyo7JrcHTOa/ry1MMwi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pBY1zowT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4469C2BD10;
	Tue, 14 May 2024 11:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687945;
	bh=Qr12FvKj8A9VeeQhTKpNt/XeupP11VUDMLkT1f83mgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pBY1zowTCVEsbhBy7JRyrH8QWe6hUCei1nGQcTfUExAT0hG0Xftr4Qb0CjBGniF11
	 DHbG3h+MFnVD4ElAQUoNMT2V6UlRdjVOSeTFsT2okw7IIXz04H5KWsOcpiaZgfAMF/
	 z0x8W0GFjMBNoDRQKnqvURfC/w8IvQ20GEdsbT40=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Viken Dadhaniya <quic_vdadhani@quicinc.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5.15 160/168] slimbus: qcom-ngd-ctrl: Add timeout for wait operation
Date: Tue, 14 May 2024 12:20:58 +0200
Message-ID: <20240514101012.798087042@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101006.678521560@linuxfoundation.org>
References: <20240514101006.678521560@linuxfoundation.org>
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

From: Viken Dadhaniya <quic_vdadhani@quicinc.com>

commit 98241a774db49988f25b7b3657026ce51ccec293 upstream.

In current driver qcom_slim_ngd_up_worker() indefinitely
waiting for ctrl->qmi_up completion object. This is
resulting in workqueue lockup on Kthread.

Added wait_for_completion_interruptible_timeout to
allow the thread to wait for specific timeout period and
bail out instead waiting infinitely.

Fixes: a899d324863a ("slimbus: qcom-ngd-ctrl: add Sub System Restart support")
Cc: stable@vger.kernel.org
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20240430091238.35209-2-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1376,7 +1376,11 @@ static void qcom_slim_ngd_up_worker(stru
 	ctrl = container_of(work, struct qcom_slim_ngd_ctrl, ngd_up_work);
 
 	/* Make sure qmi service is up before continuing */
-	wait_for_completion_interruptible(&ctrl->qmi_up);
+	if (!wait_for_completion_interruptible_timeout(&ctrl->qmi_up,
+						       msecs_to_jiffies(MSEC_PER_SEC))) {
+		dev_err(ctrl->dev, "QMI wait timeout\n");
+		return;
+	}
 
 	mutex_lock(&ctrl->ssr_lock);
 	qcom_slim_ngd_enable(ctrl, true);



