Return-Path: <stable+bounces-41831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C181D8B6DEE
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62A541F22D29
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 09:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABB71292C4;
	Tue, 30 Apr 2024 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tuo8cJnd"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7284129E7F
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 09:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468366; cv=none; b=c9lGZ2aYiVu8ioEXh23ZPocJN7NkukGr92v/ioP+rV+35t9iK4C6Lwh9k75lMKJFhI8U6Buyue0KBFsuXc3160VTNKyeuy4XqEVOojrL2ElzehAgvFv4k+e7tBX0xzlhw/U+rWhhnBOzAhf0tmiGyxbsVuvLiFD7de+3Nj56JNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468366; c=relaxed/simple;
	bh=7OkAqKieBSDhAhQDX4AtdgKVwzo06pSREmFyHqNCt8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qu1Kl6n9hn/FhRmbpXDHpojSgmqBBHUKcznRhdptHARyH0zLqkQmnhhh2/Mhe7semnNigHQ43AoAiic6Ka7+t1swuNw75yKCrNbgcv1m3Ln/kNE4No7p1C+965EaRTghGuAfqcJisxkjxdlE/YslvGSinAJnBBIYeg5mWuA5OoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tuo8cJnd; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2df848f9325so41397161fa.1
        for <stable@vger.kernel.org>; Tue, 30 Apr 2024 02:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714468363; x=1715073163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JIXMZ+tmEG/2vj3SvYBH4bXcI4VlX9A3+yAB/lRDd4=;
        b=Tuo8cJndBf1xx5Lv7PCLXceNh1P/VLZcrBmzyiKsQ4vMNfzcsL/7LWJI1MNzQqVF3Z
         +o91pZqq9Kg4SXTb3+O63HDAzRbFQOMt9bOzaT2oA0E8D8FNo/qlPI4FZz5lYpmWd+PW
         Y16PGPdo3RqT2TX66DzMgjaWCfJMZeUAeLqk1+KpKTaFsMjVtbm60G3cn1G7/CGrD5qS
         Tpb3gMzZ1FnxZ62346ovr76VL8+XJYHUPK3g61YAZZ4OSz2vQ9qlmnm3MNc+Wt7Iomfn
         ij9xFfRSWaI24+97qGH9zC1LTttI0COy9LVJ7r1MK7cekyU3O4hjw3Zo/0VRcAv2eaws
         PyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714468363; x=1715073163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JIXMZ+tmEG/2vj3SvYBH4bXcI4VlX9A3+yAB/lRDd4=;
        b=bFwPmt2CEjnyT5+PjkdWNSWQJDlN50MUNK0x0LvEyV6qgopi5A1AbQOIJULn2ke5vz
         Mk5yqcpsf5N/4Or6TWIVnahgKSNn5X65nD4ZHnCYo+rJ3Y5LVc/0H5UVEgITRtsx6I+f
         832VYaqNOmIesuOBy/pkqaWlBFB8OudCiLW3yvmcwgXpB78AYsJt0TBfvIcasdr50kOA
         kSgwnl6dTryCyvwWTF/GvGMh1mFlaaKUF0ApCuhcDt7A/uTBxvARPRQ2VkuaV3zHncjh
         EsWQm2Jqp2Xm2CPgfnXWJvgmugPOhy8IoJWUSncPwxV5QIxvPNnNUGH6cpzooGH47s8H
         1ZXg==
X-Forwarded-Encrypted: i=1; AJvYcCUalDgBrUjTmDRNAiyyZSweq/DwKoCrufwcYnHvC55ci7DWUdi4jEjC3aPZ7VxLrfSf97K4R0n0LHJshx4TemnWLmC0D8XY
X-Gm-Message-State: AOJu0YxhdVJasrT1retr85iFg+6F+CbB6+JXX6G3A37MV5kvSan19YKL
	HOxVI89Gd4RKoXSW48nOoBHJP/uBonG96l7Dx+CWiHco5yf6SDPjKvML2eW9Nmc=
X-Google-Smtp-Source: AGHT+IE1C/pV3fQbZ1npEvn9jYsbIVazA75C3yRortDB86xYNP4RhDsS3v1bh2f+LFvT9p1grv7z/A==
X-Received: by 2002:a2e:7214:0:b0:2d8:54b3:954b with SMTP id n20-20020a2e7214000000b002d854b3954bmr8056617ljc.53.1714468363074;
        Tue, 30 Apr 2024 02:12:43 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id f17-20020a05600c4e9100b004182b87aaacsm44334164wmq.14.2024.04.30.02.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 02:12:42 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Viken Dadhaniya <quic_vdadhani@quicinc.com>,
	stable@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/1] slimbus: qcom-ngd-ctrl: Add timeout for wait operation
Date: Tue, 30 Apr 2024 10:12:38 +0100
Message-Id: <20240430091238.35209-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430091238.35209-1-srinivas.kandagatla@linaro.org>
References: <20240430091238.35209-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1428; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=nY3vC2NApvFywCNrd7bStLnbD2rZAm4vIaxy7vAQZe8=; b=owGbwMvMwMVYtfBv5HGTUHPG02pJDGkG29i8Raa4yZwz+RpfX+dnO33J/5d6u9oclq+PcvXc5 HXMYdm7TkZjFgZGLgZZMUUWpef+Ucf+PPr2Xe5uL8wgViaQKQxcnAIwkbs27P9LHf36C5wZVmhV FRd4zNo4/Xbat2ov7dVLm5Lv7ddsv5kZ+eTqDQmXSunupzXHUvK1eK72+i/lPTUryES80ebc9Cl 1+/kuaRuGOJ32+B8zM73jMrdPm9Hyb5lCDM26E88HVa2bwe58g2mt18Idd47kbfw9R92t7W1nf+ npALlXXwtPtsQ0lPSkL17/1ZvNYvlMvra/GxMnO98Vis8WD4jLZrFlVy2wn3paOoqRQ2Xi86ypj P4xMRrvLio6li5RmsV57aTILC+xr75SM1vYzN12bdHU3b3GoEmpWJj54AlOryc1UbPcJpsIWmQJ FzeLTzb2LPWZ4s65/zVjj6DDjzs7NbZlaLH0H7707psSAA==
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Viken Dadhaniya <quic_vdadhani@quicinc.com>

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
---
 drivers/slimbus/qcom-ngd-ctrl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index efeba8275a66..a09a26bf4988 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1451,7 +1451,11 @@ static void qcom_slim_ngd_up_worker(struct work_struct *work)
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
-- 
2.25.1


