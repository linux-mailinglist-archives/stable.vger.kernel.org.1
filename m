Return-Path: <stable+bounces-202364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FDACC3EAC
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 16:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D92FE30E4226
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 15:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801F6346A06;
	Tue, 16 Dec 2025 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B001A3r+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA3927F00A;
	Tue, 16 Dec 2025 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887657; cv=none; b=QrK+sIxNOJ0tyl/alJwsvx3uC1tpHPpiPAjmdLgyo29meS1A6Gepr+ItTuPm9MI5qy2sjd9RPlMdZzeFY/ZFCHzpGQwRf5Y4McT5kttN5mJTrIOpytx1cEVgRTjhIND5tMqIdRMQ4mC/59sSr0liSPI/qTHhJ2UoALSlCEpzPHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887657; c=relaxed/simple;
	bh=z7TzAr+kDjRZ8wQFAnSXofU3FF4jpEIoh/32NYJ0k/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3WDm9pwjywe6+GP4tDsF+WZdRbtn5I0HeoCtXfnW6l+SWWrZLDo+G35ibE3Z4fdNqOGYZByjJNLRG1/GXqNSxfNne6OISiKemWXXq08Gg1ikWVgPe2E4ofomR+1ExgOCVZlk40u4cMS5na3bW2YYcAOCYOEwD3HrUu76vsLMx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B001A3r+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED43C4CEF1;
	Tue, 16 Dec 2025 12:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765887657;
	bh=z7TzAr+kDjRZ8wQFAnSXofU3FF4jpEIoh/32NYJ0k/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B001A3r+e5LzkpYW3Lj4XIGOIN0pbdkFkVnD/hZFKfWQIOZz8bsCxNRBkFKw/YB8o
	 9gq7C4wNkAA5aQpO7WaCTdcON76ZAotf2ag97u2h9AKdO1j8f7Xsr21ApJo74WKpYZ
	 LUD8Tk1mPLAG+oDEI+ufhtVypEmCxq4+i1OlPdqs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 298/614] watchdog: starfive: Fix resource leak in probe error path
Date: Tue, 16 Dec 2025 12:11:05 +0100
Message-ID: <20251216111412.167287577@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>
References: <20251216111401.280873349@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haotian Zhang <vulab@iscas.ac.cn>

[ Upstream commit 5bcc5786a0cfa9249ccbe539833040a6285d0de3 ]

If pm_runtime_put_sync() fails after watchdog_register_device()
succeeds, the probe function jumps to err_exit without
unregistering the watchdog device. This leaves the watchdog
registered in the subsystem while the driver fails to load,
resulting in a resource leak.

Add a new error label err_unregister_wdt to properly unregister
the watchdog device.

Fixes: 8bc22a2f1bf0 ("watchdog: starfive: Check pm_runtime_enabled() before decrementing usage counter")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
Reviewed-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/starfive-wdt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
index 355918d62f63d..ed71d3960a0f2 100644
--- a/drivers/watchdog/starfive-wdt.c
+++ b/drivers/watchdog/starfive-wdt.c
@@ -500,12 +500,14 @@ static int starfive_wdt_probe(struct platform_device *pdev)
 		if (pm_runtime_enabled(&pdev->dev)) {
 			ret = pm_runtime_put_sync(&pdev->dev);
 			if (ret)
-				goto err_exit;
+				goto err_unregister_wdt;
 		}
 	}
 
 	return 0;
 
+err_unregister_wdt:
+	watchdog_unregister_device(&wdt->wdd);
 err_exit:
 	starfive_wdt_disable_clock(wdt);
 	pm_runtime_disable(&pdev->dev);
-- 
2.51.0




