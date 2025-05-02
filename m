Return-Path: <stable+bounces-139514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6B8AA7A1F
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 21:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A7616E269
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 19:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605271D89E3;
	Fri,  2 May 2025 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aSWM4/m6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fno4J4GY"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EEE185B73;
	Fri,  2 May 2025 19:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746213538; cv=none; b=LQgZznr2Gg9y1UAOZ8m+a2jAIVzszuxQ8m2lGtlaFXrajkqsqfkoEKHYu5eFSUu6Dq29z17jHyp2PbWcyohOl3qQx0Rb0rdd2/oMZ0STHIcMYwb+15kZ8wAmBvC1XXeOXY7oXH2PqMriUaDC/KsY5j5igYPJt94zWzHDvkOkjdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746213538; c=relaxed/simple;
	bh=KIPErOtyZkn8In6mCP+4UwwhSq7iRx8QLimBtxZPGSE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nXOHLAM9AqIG3KFRmnWLlmnHQExnfCo3/AAZuw/fahPTlUzCryi2H0a9pkPRlHfEzDdb1ODMqiq80obZSRf9xHd3M1efxDCqH9ukWgJov2IWL8+p0j4G0AqmCKpBuDkYw+2ANTaGhNn6DRdOBB4vzM0qYpzJRdDYgF9V2Nk7hvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aSWM4/m6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fno4J4GY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 19:18:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746213534;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N9fs6+BA1aJDHTiBWOlJ4M1yDdsQE8GsdG3fQO/PsnU=;
	b=aSWM4/m6xBYNaoqzYpBJYGlPB+MBpX7EN2CuMNpqIRKx0DNNsjrNLGg1ilFZPd1yl7leU0
	qIto7alFyYZWlvvTTVnUlBFDesiuRLJgKTZvh07tfF5RrzISqpcGHEuwy56xQ5BXthMYO8
	8aTcTiHCMBvVMXXfwFBb1SE6D7yfbwep0C4mCHdOXUWqcpHtonXrqOPaP/90CU2qG6XiJ2
	lPH3dlhiw7/EZhXX93WeUK7V2R6gXn6BiAQjZ0T4QV0ekkl8DKNT/DQ+C2VmP7orpM+uEt
	Sp2ZPq8T9Iw+pSWcDWRAKzyJcf/0SQnParFurlIXq4exSsGKf1w9OvORFUpG4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746213534;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N9fs6+BA1aJDHTiBWOlJ4M1yDdsQE8GsdG3fQO/PsnU=;
	b=fno4J4GY+ySCJuEdPXdq8Pu4HTSqsDCqgJ+awjlAe9XL4dBfgVLNpcEtggA/TYuA6Rg036
	mE5gxuZyYkeZd9DA==
From: "tip-bot2 for Stephan Gerhold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/qcom-mpm: Prevent crash when trying to
 handle non-wake GPIOs
Cc: Alexey Klimov <alexey.klimov@linaro.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250502-irq-qcom-mpm-fix-no-wake-v1-1-8a1eafcd28d4@linaro.org>
References: <20250502-irq-qcom-mpm-fix-no-wake-v1-1-8a1eafcd28d4@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174621352984.22196.3097382094433288761.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     38a05c0b87833f5b188ae43b428b1f792df2b384
Gitweb:        https://git.kernel.org/tip/38a05c0b87833f5b188ae43b428b1f792df2b384
Author:        Stephan Gerhold <stephan.gerhold@linaro.org>
AuthorDate:    Fri, 02 May 2025 13:22:28 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 May 2025 21:07:02 +02:00

irqchip/qcom-mpm: Prevent crash when trying to handle non-wake GPIOs

On Qualcomm chipsets not all GPIOs are wakeup capable. Those GPIOs do not
have a corresponding MPM pin and should not be handled inside the MPM
driver. The IRQ domain hierarchy is always applied, so it's required to
explicitly disconnect the hierarchy for those. The pinctrl-msm driver marks
these with GPIO_NO_WAKE_IRQ. qcom-pdc has a check for this, but
irq-qcom-mpm is currently missing the check. This is causing crashes when
setting up interrupts for non-wake GPIOs:

 root@rb1:~# gpiomon -c gpiochip1 10
   irq: IRQ159: trimming hierarchy from :soc@0:interrupt-controller@f200000-1
   Unable to handle kernel paging request at virtual address ffff8000a1dc3820
   Hardware name: Qualcomm Technologies, Inc. Robotics RB1 (DT)
   pc : mpm_set_type+0x80/0xcc
   lr : mpm_set_type+0x5c/0xcc
   Call trace:
    mpm_set_type+0x80/0xcc (P)
    qcom_mpm_set_type+0x64/0x158
    irq_chip_set_type_parent+0x20/0x38
    msm_gpio_irq_set_type+0x50/0x530
    __irq_set_trigger+0x60/0x184
    __setup_irq+0x304/0x6bc
    request_threaded_irq+0xc8/0x19c
    edge_detector_setup+0x260/0x364
    linereq_create+0x420/0x5a8
    gpio_ioctl+0x2d4/0x6c0

Fix this by copying the check for GPIO_NO_WAKE_IRQ from qcom-pdc.c, so that
MPM is removed entirely from the hierarchy for non-wake GPIOs.

Fixes: a6199bb514d8 ("irqchip: Add Qualcomm MPM controller driver")
Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Alexey Klimov <alexey.klimov@linaro.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250502-irq-qcom-mpm-fix-no-wake-v1-1-8a1eafcd28d4@linaro.org
---
 drivers/irqchip/irq-qcom-mpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
index 7942d8e..f772deb 100644
--- a/drivers/irqchip/irq-qcom-mpm.c
+++ b/drivers/irqchip/irq-qcom-mpm.c
@@ -227,6 +227,9 @@ static int qcom_mpm_alloc(struct irq_domain *domain, unsigned int virq,
 	if (ret)
 		return ret;
 
+	if (pin == GPIO_NO_WAKE_IRQ)
+		return irq_domain_disconnect_hierarchy(domain, virq);
+
 	ret = irq_domain_set_hwirq_and_chip(domain, virq, pin,
 					    &qcom_mpm_chip, priv);
 	if (ret)

