Return-Path: <stable+bounces-89455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1109B8829
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 02:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C842814AC
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 01:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2812F219FC;
	Fri,  1 Nov 2024 01:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V4z4qmDO"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4239335C0
	for <stable@vger.kernel.org>; Fri,  1 Nov 2024 01:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730423092; cv=none; b=JZswZPjegz8BFbxPC2GGjsQ0cdqnJfP/QadSCHgu5GQ5u8Y2Y2K3dzVpXndvLGD3sIcDaEwf7QlhPquLVnpWIwdmeSJo7h40VffUNTfj23D9xEMSCg+dchpZsLQK2FNszMtN3lJPLxxhvuARlDAgk3u+nwAIpYu6WelgCrnKfrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730423092; c=relaxed/simple;
	bh=b000gK2eeyGVybAeUtdp3ol8MSJmrwkUM8+QObbFxsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nybhXEWpCwlYD3XTiVMGshuW3LQParuDlVIRjOomsE96UfM7IE/lxzqCSp+q+ZXCPUBftUCLqba1Lvjf6FNY/E/p9usU0ogP5UcQVzgxN5EbuWHiQP2guYdGB4JM/o+7XPZDZa37iaoR3z2UGQDX78drg1W0s5C2NpGZgKfifH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V4z4qmDO; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e8607c2aso1649208e87.3
        for <stable@vger.kernel.org>; Thu, 31 Oct 2024 18:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730423085; x=1731027885; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FqUKffGBxGjGIy1gxbpRHdCLpRulUNePaLzIj22S1/0=;
        b=V4z4qmDO0mw9Hk6qZunKeHmqcWcTUfx9yGlKSPJuVC6dUMBk3maDgn35fBF94qnviy
         US07KCHafewOMewIkCUwvRqJuW129AugJ9AaBWza+aIvlZVP302ic/iGv6YOOxtGh4Sa
         xvrhpiAqyR1/yVuKZCBJajU1xmPfK3igsuCeBU+6m4X+kiQRufLaVQ+yJLy7MMSF3v6u
         yG59nWvXWZmAj9nFIda59AS49ijO5DrlN03+zCp1rfufvbdz0mSAqLD4Ypmv4mhqOBKE
         JvtWBwXhtNPPbCCDTNsGfNTdP7kpYs6CX01mEfFA3+nE7GEGPwZStKm5NxdrpLf2yN+9
         +g7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730423085; x=1731027885;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FqUKffGBxGjGIy1gxbpRHdCLpRulUNePaLzIj22S1/0=;
        b=Jwl8ZoHJkjRDRqsPonGsewsZDZ0laBMPuJ96a4fPUpkNKiRMYBfygwcgl8O6EnwODW
         ttyNhTwgllmtRUZhQPYrOpdhsq/Q5e6Yhp2+YoS+z36LJUkHEHOAVouIono7LH9xZYId
         h6hPr88fyginUBq44pB0eoVv7iLXcH0BXEpBp5bsP3UtNbT3LGlxxYT21lQ8K0vy7h7e
         GYhXKgatXZUaEGihByEZgE69SIFG4wVbQKDXMg9C9ARINZZDiG09SKN1wprAkxRBXytH
         xv/2iv5z3YYtudZvJjR1+DttVqJrkd6QcX355pUqp4Bq8qRuypYoON/773fT4MIwU1GQ
         Gg9w==
X-Forwarded-Encrypted: i=1; AJvYcCX8ayQ6doSFCcvKvl46sZtxYkmW8mBmijIKsRjFTK/Pg7PJ2LvlixORVp59xM+WggWLEo9DPSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1v9Hh0PKFupVbwQa8RI+8f7wLusGpbmMTnErtMlQecmr+BpX1
	NTKJpu3q0KuLF3WzoIxeR6PAtW5wggb12GkLIJx/mXcGRtZZ52h63ce1dnKvgZA=
X-Google-Smtp-Source: AGHT+IFxKPkvoKcfI/+ZFD75cw7Ke/QIfWvEUTopSMRY+wGIMnAaGHV4oXlMPkMPyBM0NA8JoShqsA==
X-Received: by 2002:a05:6512:b84:b0:536:55a9:caf0 with SMTP id 2adb3069b0e04-53b347231b4mr11193807e87.0.1730423084837;
        Thu, 31 Oct 2024 18:04:44 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bde0ce9sm376165e87.268.2024.10.31.18.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 18:04:43 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 01 Nov 2024 03:04:42 +0200
Subject: [PATCH RESEND] thermal/drivers/qcom/lmh: remove false lockdep
 backtrace
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-lmh-lockdep-v1-1-96fd53cc241c@linaro.org>
To: Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2638;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=b000gK2eeyGVybAeUtdp3ol8MSJmrwkUM8+QObbFxsk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnJCkr21SOVaVEBe03u7HvWqvzrgdKJekHTS+c5
 nL1aUunbmqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZyQpKwAKCRCLPIo+Aiko
 1dPnCACzq4nh7dVe9+PjvKpVpZhQn/7UQSBhgo5mEnx48N7AxGKGmxQ7iOFhwKa+53+XJTo9Dxc
 +6qhzL5rNr1td7T7F0+pkeeRY8Aq9Fpizt50vq/dm1RU591XPnwNeJHyZe11mDeRTP4doc+md/B
 D6qHrA9BbmGCTN0HwNklDldFgBIwp8kzDEbUUxVBM7zNxCa5p6nTozrRAJbSB6WP5FVyk7mz0bZ
 wm0KzA/t+4RJbWo291z/hz4DLjtcyP/9kzpZ6iuTm4awcAlPA5rDW8N/lxOaDd7wj8bGTBS/Ig8
 gL4+Ir7vpyoZGtf9Wua+FSOBNyK8k8oD+PNF+YLYPb9c29/s
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Annotate LMH IRQs with lockdep classes so that the lockdep doesn't
report possible recursive locking issue between LMH and GIC interrupts.

For the reference:

       CPU0
       ----
  lock(&irq_desc_lock_class);
  lock(&irq_desc_lock_class);

 *** DEADLOCK ***

Call trace:
 dump_backtrace+0x98/0xf0
 show_stack+0x18/0x24
 dump_stack_lvl+0x90/0xd0
 dump_stack+0x18/0x24
 print_deadlock_bug+0x258/0x348
 __lock_acquire+0x1078/0x1f44
 lock_acquire+0x1fc/0x32c
 _raw_spin_lock_irqsave+0x60/0x88
 __irq_get_desc_lock+0x58/0x98
 enable_irq+0x38/0xa0
 lmh_enable_interrupt+0x2c/0x38
 irq_enable+0x40/0x8c
 __irq_startup+0x78/0xa4
 irq_startup+0x78/0x168
 __enable_irq+0x70/0x7c
 enable_irq+0x4c/0xa0
 qcom_cpufreq_ready+0x20/0x2c
 cpufreq_online+0x2a8/0x988
 cpufreq_add_dev+0x80/0x98
 subsys_interface_register+0x104/0x134
 cpufreq_register_driver+0x150/0x234
 qcom_cpufreq_hw_driver_probe+0x2a8/0x388
 platform_probe+0x68/0xc0
 really_probe+0xbc/0x298
 __driver_probe_device+0x78/0x12c
 driver_probe_device+0x3c/0x160
 __device_attach_driver+0xb8/0x138
 bus_for_each_drv+0x84/0xe0
 __device_attach+0x9c/0x188
 device_initial_probe+0x14/0x20
 bus_probe_device+0xac/0xb0
 deferred_probe_work_func+0x8c/0xc8
 process_one_work+0x20c/0x62c
 worker_thread+0x1bc/0x36c
 kthread+0x120/0x124
 ret_from_fork+0x10/0x20

Fixes: 53bca371cdf7 ("thermal/drivers/qcom: Add support for LMh driver")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/lmh.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index 5225b3621a56c4a11f0ae56af1060d6d1460ef02..d2d49264cf83a4c4646202044700a7a8bf3c0b95 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -73,7 +73,14 @@ static struct irq_chip lmh_irq_chip = {
 static int lmh_irq_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
 {
 	struct lmh_hw_data *lmh_data = d->host_data;
+	static struct lock_class_key lmh_lock_key;
+	static struct lock_class_key lmh_request_key;
 
+	/*
+	 * This lock class tells lockdep that GPIO irqs are in a different
+	 * category than their parents, so it won't report false recursion.
+	 */
+	irq_set_lockdep_class(irq, &lmh_lock_key, &lmh_request_key);
 	irq_set_chip_and_handler(irq, &lmh_irq_chip, handle_simple_irq);
 	irq_set_chip_data(irq, lmh_data);
 

---
base-commit: 797012914d2d031430268fe512af0ccd7d8e46ef
change-id: 20240721-lmh-lockdep-88de09e77089

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


