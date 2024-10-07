Return-Path: <stable+bounces-81226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF75499280C
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 11:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40241F23511
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 09:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3457418E055;
	Mon,  7 Oct 2024 09:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oCVhfPqO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E558818BC05
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 09:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728293212; cv=none; b=RwHh3Row6dLjjwOAdJ47IapOo1j+xvrS7lbzryYQksCygh5qtMBjIaMLeI9N4aB3n5QHOd5e/twN14ojf/msNraL841b72fclX/1unqP3wwIhSvACnIGkkUb4ps3atur7x7HOa2DmLU19r6ItJm5yc2fG5JwTM5Sv6GnRXt3RRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728293212; c=relaxed/simple;
	bh=Bh9HcfNDnCSBZBMIYTu1LBGkjktAHpEkjkYDJerSdEU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jjcuc9HlwPTSsAvvlAveX6cF21ZvQs/5hn+ZMd1k5blRZnLZH+fg/OaxDlWzQhEFrYK8EOOOo1xkyJUTSX0O8S/57iZKyP9t6gUdV3De0ecf9fZO1fuOPACT/wbMbeIE2blHi2ktPpT87m1tbzT18HVp8domOFKaSreYrTJ2nJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oCVhfPqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15291C4CEC6;
	Mon,  7 Oct 2024 09:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728293211;
	bh=Bh9HcfNDnCSBZBMIYTu1LBGkjktAHpEkjkYDJerSdEU=;
	h=Subject:To:Cc:From:Date:From;
	b=oCVhfPqOUx5Xkv/1yOL6nvDoVNX3vRoa9AkRxZptaFe2vNPGH4gYH9UL+x4AGCvBD
	 Rs/ylbe7mQHJFqJrm9Xa1iGYA0mQsQ0p9stRUvn/sea1OogARCBHUV+LuUE46WC3yD
	 eHQ+H00dsyWgOvfgVKJz/N2G+aD4YmYhw1KBwAos=
Subject: FAILED: patch "[PATCH] i2c: qcom-geni: Use IRQF_NO_AUTOEN flag in request_irq()" failed to apply to 4.19-stable tree
To: ruanjinjie@huawei.com,andi.shyti@kernel.org,quic_msavaliy@quicinc.com,stable@vger.kernel.org,vladimir.zapolskiy@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 11:26:40 +0200
Message-ID: <2024100740-rickety-tamale-ac1e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x e2c85d85a05f16af2223fcc0195ff50a7938b372
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100740-rickety-tamale-ac1e@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

e2c85d85a05f ("i2c: qcom-geni: Use IRQF_NO_AUTOEN flag in request_irq()")
3b7d81f08a6a ("i2c: qcom-geni: Grow a dev pointer to simplify code")
b2ca8800621b ("i2c: qcom-geni: Let firmware specify irq trigger flags")
c9913ac42135 ("i2c: qcom-geni: Provide support for ACPI")
c3c2889b8a2c ("i2c: qcom-geni: Signify successful driver probe")
848bd3f3de9d ("i2c: qcom-geni: Fix runtime PM mismatch with child devices")

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


