Return-Path: <stable+bounces-86179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DA299EC24
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290821F23B19
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90547227BA7;
	Tue, 15 Oct 2024 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D0lRXoGx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B880227B9F;
	Tue, 15 Oct 2024 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998036; cv=none; b=DV74BNG0As11vyliPyGwx69JNBW2+vaoGYnVMPfcGuyK2QMAqfp2R4RyZfjxp5WFDOngZ9eJ5BLl6o+eguf+AQftwrJ6Ky6Uk8nK8jC9CgpvdRGtPzXxbwb4n1yZL8WzybzP0AwNiAkOn51ecL2j04VoTu11qkPIVNHuZ0RHd2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998036; c=relaxed/simple;
	bh=jGPxcuW7/JGW9aG6F7eh9/nAX3EMCxO4L6gJuES+CjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJIxJxKSryv0dlPSAVY67weVxPgKTGtLBsPz/F2jvjCn4T6GAxvqdZEyH6v1MKYu0pDWHnahDFI2a0WyE/t15tlnw6Q0zycEVnQxe8skY3qw2dCZBelpaaDkxFX6mSEnGtCTKsrvkufPptArKJBXAuSeFM2RuOnEppA78qEe6Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D0lRXoGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75E5C4CED2;
	Tue, 15 Oct 2024 13:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728998036;
	bh=jGPxcuW7/JGW9aG6F7eh9/nAX3EMCxO4L6gJuES+CjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D0lRXoGx1vsB2VDSf/aSZFP+ExY6pNrnweeaPqRYGawLR2Ot5tDPKdWtlEvtlgKiB
	 AUjySV9Kkz5n4D4JZgHCB3FiARjkQ4V+fYwmVWR2vr/mF5Yn7kapSHxX28qWgrx4aP
	 ssoMCFwU1J6udUzUW8dpEuFD25CHXgoab7A/El/E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 5.10 360/518] i2c: qcom-geni: Use IRQF_NO_AUTOEN flag in request_irq()
Date: Tue, 15 Oct 2024 14:44:24 +0200
Message-ID: <20241015123930.863701651@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jinjie Ruan <ruanjinjie@huawei.com>

commit e2c85d85a05f16af2223fcc0195ff50a7938b372 upstream.

disable_irq() after request_irq() still has a time gap in which
interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
disable IRQ auto-enable when request IRQ.

Fixes: 37692de5d523 ("i2c: i2c-qcom-geni: Add bus driver for the Qualcomm GENI I2C controller")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <stable@vger.kernel.org> # v4.19+
Acked-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -569,15 +569,13 @@ static int geni_i2c_probe(struct platfor
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



