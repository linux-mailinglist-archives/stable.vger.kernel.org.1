Return-Path: <stable+bounces-81225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2AD99280B
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 11:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC9D1F23554
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 09:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DEA18E74A;
	Mon,  7 Oct 2024 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yauRq7Kk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D9318E37D
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728293203; cv=none; b=dGDB6+KY/Zecxg3Ep+6dhxrGq4BAD4bI8DJaIIq9fXP8JlGrf0ukoukiNWkldiOEKEIG7g6466JhNWpgG20OMt/SLCw8Q5gufgfFmvFQKMESS1zboQJ9GTgSrxuM8O98uqMvinii1d/IxUgVRKRLOcmlLME4L3gJP3BUMXvchow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728293203; c=relaxed/simple;
	bh=v5aP4TV257iAy+yRiiZxaKkAGObjcAhwM2ftaKHN4ik=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BkmaaU2I5KhIghhIGJVh364WejypImXI3raSCR/6/IiHHH1xGR46zkjPco38AwphRMv7kdOz2wTpWjFU6585obmDG+FVhOMJZu0XjbcyXwG3pKONS9m5b1f98boDKhILA5qmxrqUCJDqLGXhf/Opdxz7iflGTVjKFGlVEasW/Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yauRq7Kk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579D5C4CEC6;
	Mon,  7 Oct 2024 09:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728293202;
	bh=v5aP4TV257iAy+yRiiZxaKkAGObjcAhwM2ftaKHN4ik=;
	h=Subject:To:Cc:From:Date:From;
	b=yauRq7KkcfLGVIhAEbx5aBZsgfKIcVcd4yYled6g3UkNn8dOkXsAsmPVBwHWrJlwg
	 NXEMg9T3XLOoR6py8bh7qsDApFZfqb6VZ8brGcvlmuuhEZfHX/hKj9FdNgkY1ZEqbp
	 f28+5i5zjvZHNdiuiafK70PF7zTIFTGKPHkYk690=
Subject: FAILED: patch "[PATCH] i2c: qcom-geni: Use IRQF_NO_AUTOEN flag in request_irq()" failed to apply to 5.4-stable tree
To: ruanjinjie@huawei.com,andi.shyti@kernel.org,quic_msavaliy@quicinc.com,stable@vger.kernel.org,vladimir.zapolskiy@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 11:26:39 +0200
Message-ID: <2024100739-baked-blizzard-0044@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x e2c85d85a05f16af2223fcc0195ff50a7938b372
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100739-baked-blizzard-0044@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

e2c85d85a05f ("i2c: qcom-geni: Use IRQF_NO_AUTOEN flag in request_irq()")
3b7d81f08a6a ("i2c: qcom-geni: Grow a dev pointer to simplify code")
b2ca8800621b ("i2c: qcom-geni: Let firmware specify irq trigger flags")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e2c85d85a05f16af2223fcc0195ff50a7938b372 Mon Sep 17 00:00:00 2001
From: Jinjie Ruan <ruanjinjie@huawei.com>
Date: Thu, 12 Sep 2024 11:34:59 +0800
Subject: [PATCH] i2c: qcom-geni: Use IRQF_NO_AUTOEN flag in request_irq()

disable_irq() after request_irq() still has a time gap in which
interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
disable IRQ auto-enable when request IRQ.

Fixes: 37692de5d523 ("i2c: i2c-qcom-geni: Add bus driver for the Qualcomm GENI I2C controller")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <stable@vger.kernel.org> # v4.19+
Acked-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 06e836e3e877..4c9050a4d58e 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -818,15 +818,13 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	init_completion(&gi2c->done);
 	spin_lock_init(&gi2c->lock);
 	platform_set_drvdata(pdev, gi2c);
-	ret = devm_request_irq(dev, gi2c->irq, geni_i2c_irq, 0,
+	ret = devm_request_irq(dev, gi2c->irq, geni_i2c_irq, IRQF_NO_AUTOEN,
 			       dev_name(dev), gi2c);
 	if (ret) {
 		dev_err(dev, "Request_irq failed:%d: err:%d\n",
 			gi2c->irq, ret);
 		return ret;
 	}
-	/* Disable the interrupt so that the system can enter low-power mode */
-	disable_irq(gi2c->irq);
 	i2c_set_adapdata(&gi2c->adap, gi2c);
 	gi2c->adap.dev.parent = dev;
 	gi2c->adap.dev.of_node = dev->of_node;


