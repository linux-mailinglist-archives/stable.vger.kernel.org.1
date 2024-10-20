Return-Path: <stable+bounces-86962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B54C9A5358
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 11:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC061C20C8F
	for <lists+stable@lfdr.de>; Sun, 20 Oct 2024 09:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9B42942A;
	Sun, 20 Oct 2024 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="o0PrbTs7"
X-Original-To: stable@vger.kernel.org
Received: from st43p00im-zteg10072001.me.com (st43p00im-zteg10072001.me.com [17.58.63.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7FC14A08D
	for <stable@vger.kernel.org>; Sun, 20 Oct 2024 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.63.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729416883; cv=none; b=LaPWoTDeSkOJNeWW5of5Lyl7SHpJ8JU/zN/Md08DMWudE1iaSKLghpTmqwoRt5aDZa8xnKNrrAUGNEDbR3xpYgV8GPe5tFXaTuucdF7rrp3cLiGvQgz4qeMng7f4bcmgUi9F7mC6NdvdDTaW1Qz60S8sYEo3hoTfzzywcborodc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729416883; c=relaxed/simple;
	bh=7Nm7nRSbLLyNZ2RqYx5uMGbxBgzfASTKa2l6cmlJeYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q2Y+VmUXCvGugdVRsK27yJFeMyYffrwLiySZbHWU/K1PsVfuOMm7iiKoSWYZR5De33T9/7NSQN1qfRbf5DSJlAzVWYHuW8rO3ht0OYWmfjkL7fcUvksa08pwx08j5aALZ51KOIpPmhC1/1l6DVLDdeM/WR0PZapSq0Fa0rJYeqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=o0PrbTs7; arc=none smtp.client-ip=17.58.63.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1729416880;
	bh=PrNAGZjnmK7jN0fRs2s2KJ+MNWHEA/Daolze1eLHVSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=o0PrbTs7fn6UCGGYaAd5Nm2gsDqXAW8nMkNuNKSuPnzQrKwJZN24wtxPlt5Cjm+/E
	 i/x/kIIhZcsyWiRl6hEHeN3a/4kvxybP5doF689noGdUHbKM6Ve7ujGg9FGzj5zHOa
	 OMhFb5yLKzQbYxR0LpbJbPDbKqBK02wYWoyWF/IFTt3oP58opKHk0o6X6y9M8b7sFt
	 cou8vKrlYrLSqZRPVQhVWlrBl6u1EomUm3BebmUYj5ovc7NmL1OfD5dEX/swI6H5Kp
	 nYpFqWTliAH/inKeJUXLuFAQHDXWvQscptD5HGAM3/Fo0VyxNRYFDvtUGEBSXeL4kc
	 LavepkB3j0wGw==
Received: from [192.168.1.26] (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-zteg10072001.me.com (Postfix) with ESMTPSA id 150351202EC;
	Sun, 20 Oct 2024 09:34:36 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 20 Oct 2024 17:33:42 +0800
Subject: [PATCH] usb: phy: Fix API devm_usb_put_phy() can not release the
 phy
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241020-usb_phy_fix-v1-1-7f79243b8e1e@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAHXOFGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAyMD3dLipPiCjMr4tMwKXcsU82Qz89Q0k8QkEyWgjoKiVKAw2LTo2Np
 aAEHJtd9dAAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Felipe Balbi <balbi@ti.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For devm_usb_put_phy(), its comment says it needs to invoke usb_put_phy()
to release the phy, but it does not do that actually, so it can not fully
undo what the API devm_usb_get_phy() does, that is wrong, fixed by using
devres_release() instead of devres_destroy() within the API.

Fixes: cedf8602373a ("usb: phy: move bulk of otg/otg.c to phy/phy.c")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
The API is directly used by drivers/usb/musb/sunxi.c, sorry for that
i can't evaluate relevant impact since i know nothing about sunxi.
---
 drivers/usb/phy/phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
index 06e0fb23566c..06f789097989 100644
--- a/drivers/usb/phy/phy.c
+++ b/drivers/usb/phy/phy.c
@@ -628,7 +628,7 @@ void devm_usb_put_phy(struct device *dev, struct usb_phy *phy)
 {
 	int r;
 
-	r = devres_destroy(dev, devm_usb_phy_release, devm_usb_phy_match, phy);
+	r = devres_release(dev, devm_usb_phy_release, devm_usb_phy_match, phy);
 	dev_WARN_ONCE(dev, r, "couldn't find PHY resource\n");
 }
 EXPORT_SYMBOL_GPL(devm_usb_put_phy);

---
base-commit: 07b887f8236eb3ed52f1fe83e385e6436dc4b052
change-id: 20241020-usb_phy_fix-9d7c67ef4ab4

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


