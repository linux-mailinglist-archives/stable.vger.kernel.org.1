Return-Path: <stable+bounces-171996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39669B2F8D2
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4A51CE2BD1
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 12:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E431131DD9D;
	Thu, 21 Aug 2025 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lm/Vt3XB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A481F319867
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780263; cv=none; b=IASYvK2eLDTxjckGGCi2n9yn2kI9YnA+7f9uKd1Qss1jhxKyiw6wlm5eKM8B+86FoHx7jiVq+URKdoUj2WvpSzlPJvI1L9kS3AV4nNFzY9LtBqZ8aXo1BMV8BzMEj65uzXZ+IfTdUXpx/Wg8TCgcgrZ2KGZHcYVDYmOiQXOcufk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780263; c=relaxed/simple;
	bh=6DLvW3wiMVevECHz7s8mZxHUWaWKL9ozC3A7F/qQfUY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SYGJE2nbjh/GXY7EmykRNOnI2fcOxtZwSeq9WdnfbcAFT+XtoQr18wennARbCnBedCs0qFOndnFwUemk1Z3GuBK7uJfJWNf1DIXgYRX9hvq3cSs+3GCFDq3txe2oYJSdrsD/B9ti2yfuyIBjAD4UDflpM/VFOwwGDd59jBBLuM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lm/Vt3XB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17AC8C4CEEB;
	Thu, 21 Aug 2025 12:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755780263;
	bh=6DLvW3wiMVevECHz7s8mZxHUWaWKL9ozC3A7F/qQfUY=;
	h=Subject:To:Cc:From:Date:From;
	b=Lm/Vt3XBNPvPJgH136Nzd+oRp/U+Id9GvfcYyKDMvGDp7CQzP/dmxNov9D9wq0ctP
	 YL/4oIpz3DKexOnhPL4gNDW+metCe6zk7uWxucVvegS2exkxy/DQJMYNHGA7hR0ui7
	 Yqk6Id5wXUZ3g40ta4qyyoN1BDGrLItqK6wjvkbw=
Subject: FAILED: patch "[PATCH] usb: dwc3: imx8mp: fix device leak at unbind" failed to apply to 6.6-stable tree
To: johan@kernel.org,gregkh@linuxfoundation.org,jun.li@nxp.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 14:44:20 +0200
Message-ID: <2025082120-canteen-quickly-68c4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 086a0e516f7b3844e6328a5c69e2708b66b0ce18
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082120-canteen-quickly-68c4@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 086a0e516f7b3844e6328a5c69e2708b66b0ce18 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 24 Jul 2025 11:19:06 +0200
Subject: [PATCH] usb: dwc3: imx8mp: fix device leak at unbind

Make sure to drop the reference to the dwc3 device taken by
of_find_device_by_node() on probe errors and on driver unbind.

Fixes: 6dd2565989b4 ("usb: dwc3: add imx8mp dwc3 glue layer driver")
Cc: stable@vger.kernel.org	# 5.12
Cc: Li Jun <jun.li@nxp.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20250724091910.21092-2-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
index 3edc5aca76f9..bce6af82f54c 100644
--- a/drivers/usb/dwc3/dwc3-imx8mp.c
+++ b/drivers/usb/dwc3/dwc3-imx8mp.c
@@ -244,7 +244,7 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 					IRQF_ONESHOT, dev_name(dev), dwc3_imx);
 	if (err) {
 		dev_err(dev, "failed to request IRQ #%d --> %d\n", irq, err);
-		goto depopulate;
+		goto put_dwc3;
 	}
 
 	device_set_wakeup_capable(dev, true);
@@ -252,6 +252,8 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 
 	return 0;
 
+put_dwc3:
+	put_device(&dwc3_imx->dwc3->dev);
 depopulate:
 	of_platform_depopulate(dev);
 remove_swnode:
@@ -265,8 +267,11 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 
 static void dwc3_imx8mp_remove(struct platform_device *pdev)
 {
+	struct dwc3_imx8mp *dwc3_imx = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
 
+	put_device(&dwc3_imx->dwc3->dev);
+
 	pm_runtime_get_sync(dev);
 	of_platform_depopulate(dev);
 	device_remove_software_node(dev);


