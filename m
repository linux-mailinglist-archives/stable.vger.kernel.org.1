Return-Path: <stable+bounces-172137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4AAB2FCEB
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49864AE517C
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631972571DA;
	Thu, 21 Aug 2025 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C5r87x+Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222DC2EC572
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786542; cv=none; b=DbGGjvxDjNFhm445k4GRWMehR2s3GMZaQNHRtvLKE46bHgIOdxwlMfU6z23wAct5OUOzN5hCLvCo8A3bIUXdPi7SPFQSEOJWQ9i0TejSXuHzJvbrZYTnbFzGD1kpdVViGHIwpFiNfaxg0zkeJAH14Dycgit8w4lPp+Xqz01Lrtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786542; c=relaxed/simple;
	bh=2ZzjRpUWsOpmS6X4daIZ+e5XGE2eo0cWeFhzAju5wGI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lXycoumOI264tchGHUAwOXIGfUJH2r9IONvwz/0Iwh+MipsrkA2F65U+3wJV9OjzJb1aSAkCOMRhWlvfZd7arAt4GqZWucpIiMaaXwEpnR+V8IbZLbNLwDcVj+hnxD7qHkWWN7GNDYXvWtN763FIJmOGWbehqh9u6wynxEp2TWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C5r87x+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BACC4CEEB;
	Thu, 21 Aug 2025 14:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755786542;
	bh=2ZzjRpUWsOpmS6X4daIZ+e5XGE2eo0cWeFhzAju5wGI=;
	h=Subject:To:Cc:From:Date:From;
	b=C5r87x+QXQadkYYXABmAVQ0xnBvOm2WG5fhMqftwQgzJAV5LqvU0lyshFtXTC2q0z
	 +CPiuiuiL+7epwy/OdvHUMOxCbvdqkUgHZiEvdSDlYyNYjFfm4YXlPAwCsxmN9zx1o
	 mNAb8R9tVj7JaA4H32gNMILQUdxwtrAWCAQ7M7vY=
Subject: FAILED: patch "[PATCH] media: venus: protect against spurious interrupts during" failed to apply to 5.15-stable tree
To: jorge.ramirez@oss.qualcomm.com,bod@kernel.org,bryan.odonoghue@linaro.org,hverkuil@xs4all.nl,quic_dikshita@quicinc.com,quic_vgarodia@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 16:28:50 +0200
Message-ID: <2025082150-feminize-barterer-4a0f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 3200144a2fa4209dc084a19941b9b203b43580f0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082150-feminize-barterer-4a0f@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3200144a2fa4209dc084a19941b9b203b43580f0 Mon Sep 17 00:00:00 2001
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Date: Fri, 6 Jun 2025 17:25:22 +0200
Subject: [PATCH] media: venus: protect against spurious interrupts during
 probe

Make sure the interrupt handler is initialized before the interrupt is
registered.

If the IRQ is registered before hfi_create(), it's possible that an
interrupt fires before the handler setup is complete, leading to a NULL
dereference.

This error condition has been observed during system boot on Rb3Gen2.

Fixes: af2c3834c8ca ("[media] media: venus: adding core part and helper functions")
Cc: stable@vger.kernel.org
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Tested-by: Dikshita Agarwal <quic_dikshita@quicinc.com> # RB5
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index d305d74bb152..5bd99d0aafe4 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -424,13 +424,13 @@ static int venus_probe(struct platform_device *pdev)
 	INIT_DELAYED_WORK(&core->work, venus_sys_error_handler);
 	init_waitqueue_head(&core->sys_err_done);
 
-	ret = devm_request_threaded_irq(dev, core->irq, hfi_isr, venus_isr_thread,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
-					"venus", core);
+	ret = hfi_create(core, &venus_core_ops);
 	if (ret)
 		goto err_core_put;
 
-	ret = hfi_create(core, &venus_core_ops);
+	ret = devm_request_threaded_irq(dev, core->irq, hfi_isr, venus_isr_thread,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					"venus", core);
 	if (ret)
 		goto err_core_put;
 


