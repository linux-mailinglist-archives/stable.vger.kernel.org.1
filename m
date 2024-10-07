Return-Path: <stable+bounces-81231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4E9992811
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 11:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6045D1C22172
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 09:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B6718E359;
	Mon,  7 Oct 2024 09:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z/f+Fu8h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C978F1741E0
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728293267; cv=none; b=WD8JkKuLN2wbbtCcuBWKkef3hXForqIaLIU/yKwt6o6pOveN0eS45kXX5dU1UnibBhzxMqwRUxJ+3uoS11UA3NAZ5L1C9g08dkL3s6xk2HqInld+XAktrc0/fovRtgyzODQlB3gayQ5SFgO16gXVpCtLLG1sGt+k3sc27VNpO+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728293267; c=relaxed/simple;
	bh=yt7rJkenNoykEvdAdawsp5I2oB5viUqwa2WEhpi6ygA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WjBApsZgB/SHg4aHEu/PiADUC1NOLoV7lJiIPbU6pvvM/XOiDGUza293v27ixAhOxOGt9QrixUHfx9GMGW6HKpNIluaomVH1yGYdIAyfJ/jLz+Jh+HdD0WJc1rZzmR8GwSqN+iOaZTZ2y6ur80vHiQeqhmNzuYjvo3D2qhefarM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z/f+Fu8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C7FC4CEC6;
	Mon,  7 Oct 2024 09:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728293267;
	bh=yt7rJkenNoykEvdAdawsp5I2oB5viUqwa2WEhpi6ygA=;
	h=Subject:To:Cc:From:Date:From;
	b=z/f+Fu8hpV01OhbxBV+sqpg0mNSsqgy4QWurT5nbcap25WoDvfVpngR80wyIazXMJ
	 qgHZ+i9Vl1KSZCguAqoupMm1Mfbr1SDtVQVL9mkvz+G/WqFNYBX2QNgThycU2bCqm7
	 REpZPem587I8p0lXPHFVL/1TIbU4luYeTBFjEqYg=
Subject: FAILED: patch "[PATCH] i2c: xiic: Fix pm_runtime_set_suspended() with runtime pm" failed to apply to 5.15-stable tree
To: ruanjinjie@huawei.com,andi.shyti@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 11:27:33 +0200
Message-ID: <2024100733-hypertext-dreamily-8b37@gregkh>
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
git cherry-pick -x 0c8d604dea437b69a861479b413d629bc9b3da70
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100733-hypertext-dreamily-8b37@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

0c8d604dea43 ("i2c: xiic: Fix pm_runtime_set_suspended() with runtime pm enabled")
8390dc7477e4 ("i2c: xiic: Use devm_clk_get_enabled()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0c8d604dea437b69a861479b413d629bc9b3da70 Mon Sep 17 00:00:00 2001
From: Jinjie Ruan <ruanjinjie@huawei.com>
Date: Mon, 23 Sep 2024 11:42:50 +0800
Subject: [PATCH] i2c: xiic: Fix pm_runtime_set_suspended() with runtime pm
 enabled

It is not valid to call pm_runtime_set_suspended() for devices
with runtime PM enabled because it returns -EAGAIN if it is enabled
already and working. So, call pm_runtime_disable() before to fix it.

Fixes: 36ecbcab84d0 ("i2c: xiic: Implement power management")
Cc: <stable@vger.kernel.org> # v4.6+
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 4c89aad02451..1d68177241a6 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1337,8 +1337,8 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	return 0;
 
 err_pm_disable:
-	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
 
 	return ret;
 }


