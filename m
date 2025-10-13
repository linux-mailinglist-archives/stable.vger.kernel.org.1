Return-Path: <stable+bounces-184164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B036BD209F
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 10:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0E976348EB2
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 08:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B962F3627;
	Mon, 13 Oct 2025 08:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LVVeaEPC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EC62F28FF
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343938; cv=none; b=l68z1bN4oVbt8VwS8VFEOKmuOzlOQfDBIYrzpOY0XGWsFCGwB9MEZFhZ1ZKHSrBaQoWjgGnEyRXmMDMI9lmAPUA3spk66ruIkgVfFZKl1Q8itbZuor2wnii4znnWRJgqip9ckJr+gA6MUgkOf4UYy0lmCRShDgQIBlZjf/a6b+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343938; c=relaxed/simple;
	bh=CTtMgmnKQnUTz4H7BoCsg+dAe7Y/G112fjA/QhWfPOE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=if+8Ce+KW0ePQQrKOaW5Dlf1kiv/VAg8soMdFmG6D/WqJeY0jU76myZVytCXrSkRS4C+6iJaqskxGv+7kNX4eREnEAbUmuR+KNUOd/CeuNPN9WTYUFzuQ7v/oEaFhWOGn19my6GlsUH9yFcvcUuIcnDsKlXVdy2mJsdzeyEVOmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LVVeaEPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BD2C116D0;
	Mon, 13 Oct 2025 08:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760343938;
	bh=CTtMgmnKQnUTz4H7BoCsg+dAe7Y/G112fjA/QhWfPOE=;
	h=Subject:To:Cc:From:Date:From;
	b=LVVeaEPCHZ76UxlDGYzwhM0g2JHRs+MXUv3yB+2nyhkfy9kqOUOKrVGWHlTaz4cht
	 QB9KwAnPf/c2IdOXQhj7g1DAg1lADAcuQyKzrmqBdYAdFkXxI393/WjZsEL9G3vT6Q
	 Du2o2/EAMYV8S20FuqhPr1tgBtAfYd+ejLB/YnoI=
Subject: FAILED: patch "[PATCH] mfd: vexpress-sysreg: Check the return value of" failed to apply to 5.4-stable tree
To: bartosz.golaszewski@linaro.org,lee@kernel.org,linus.walleij@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Oct 2025 10:25:36 +0200
Message-ID: <2025101336-abrasion-hatchling-01bc@gregkh>
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
git cherry-pick -x 1efbee6852f1ff698a9981bd731308dd027189fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101336-abrasion-hatchling-01bc@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1efbee6852f1ff698a9981bd731308dd027189fb Mon Sep 17 00:00:00 2001
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 11 Aug 2025 15:36:16 +0200
Subject: [PATCH] mfd: vexpress-sysreg: Check the return value of
 devm_gpiochip_add_data()

Commit 974cc7b93441 ("mfd: vexpress: Define the device as MFD cells")
removed the return value check from the call to gpiochip_add_data() (or
rather gpiochip_add() back then and later converted to devres) with no
explanation. This function however can still fail, so check the return
value and bail-out if it does.

Cc: stable@vger.kernel.org
Fixes: 974cc7b93441 ("mfd: vexpress: Define the device as MFD cells")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20250811-gpio-mmio-mfd-conv-v1-1-68c5c958cf80@linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>

diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
index fc2daffc4352..77245c1e5d7d 100644
--- a/drivers/mfd/vexpress-sysreg.c
+++ b/drivers/mfd/vexpress-sysreg.c
@@ -99,6 +99,7 @@ static int vexpress_sysreg_probe(struct platform_device *pdev)
 	struct resource *mem;
 	void __iomem *base;
 	struct gpio_chip *mmc_gpio_chip;
+	int ret;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem)
@@ -119,7 +120,10 @@ static int vexpress_sysreg_probe(struct platform_device *pdev)
 	bgpio_init(mmc_gpio_chip, &pdev->dev, 0x4, base + SYS_MCI,
 			NULL, NULL, NULL, NULL, 0);
 	mmc_gpio_chip->ngpio = 2;
-	devm_gpiochip_add_data(&pdev->dev, mmc_gpio_chip, NULL);
+
+	ret = devm_gpiochip_add_data(&pdev->dev, mmc_gpio_chip, NULL);
+	if (ret)
+		return ret;
 
 	return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
 			vexpress_sysreg_cells,


