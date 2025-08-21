Return-Path: <stable+bounces-172139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE3BB2FD2F
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02345E37C6
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CC0286434;
	Thu, 21 Aug 2025 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pLHZoLHU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4180E257AC6
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786548; cv=none; b=jmPGsW2kCkYjFQLoHSbdNx8z9JEeFRQfWnV23V/bhbyGFa94UA2feu4J5RK2R/15n1yRX6nChqaKWuF7jFm3QM1vdCDVry9DesTUj4Ba9tQWioIbfn/Ri23p7QWg7/oR/Gw79A1CaSWDhIH1ppUVBIyXsgoSHOiXvUsetuJwVQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786548; c=relaxed/simple;
	bh=lOUpE+r3ykq8al/AGiN5QS9nBuIPzjeIrXApYVC1+XE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cKnofBvDUKccRj/8bEQv4pKYYItKGAZMJPBXX54ebp9FqeB/63YIelK9banlSIacZTO4qy9WR2/zeEMI6lgu2mcU7zoZpu7bl1A7oB1bvxrJ4rNTY5KKWGm/48ZqH8VHeTrCf/Zpb4Kh7r1fZmcGImZ2yqp0iyJ5j7jzfEbow7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pLHZoLHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2A9C4CEF4;
	Thu, 21 Aug 2025 14:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755786548;
	bh=lOUpE+r3ykq8al/AGiN5QS9nBuIPzjeIrXApYVC1+XE=;
	h=Subject:To:Cc:From:Date:From;
	b=pLHZoLHUqQY5QhOah6jnZRt37QqIYbQSO4OjrqEkfOhjgtQdzXQ19kr+ItRvfMpIf
	 LWsuht50SF608i11ywxUmA0bidsdnk6vPDSqtC/xOvLwahd+Q0rJ0yQK/TwMHSpj8M
	 wxWHtYdIy7G1a9L7PkJIy6TfLzEDMHgXusmiKRLk=
Subject: FAILED: patch "[PATCH] media: venus: protect against spurious interrupts during" failed to apply to 5.10-stable tree
To: jorge.ramirez@oss.qualcomm.com,bod@kernel.org,bryan.odonoghue@linaro.org,hverkuil@xs4all.nl,quic_dikshita@quicinc.com,quic_vgarodia@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 16:28:51 +0200
Message-ID: <2025082151-mummified-annoying-20b6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 3200144a2fa4209dc084a19941b9b203b43580f0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082151-mummified-annoying-20b6@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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
 


