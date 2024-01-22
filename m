Return-Path: <stable+bounces-14218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FC1838005
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA2A1C294F4
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F992657C4;
	Tue, 23 Jan 2024 00:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UGiNhoVy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C45A657C3;
	Tue, 23 Jan 2024 00:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971500; cv=none; b=paBIDmVmJFCa+9ULlM4uQtYnOMDLI/rXwcGwM/5ups1exwk5V2SRERntAr3RuwtHzbpOOC+xW0TNunJSD00jMQPQakM5qG3/tWQJ8mXCWadRxMOcMUBQlGFFKkaAtC4tI5JzXmqfRqFn7d0gSjaOh1lmuFu0NezBMiIQIslJ7x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971500; c=relaxed/simple;
	bh=9IjEnqwe1o1QpkUexCDGyCXxvUQlig+UOtFK4bFWaIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=roY65LFSs5k9yJgEkSWxNCNz3Cn6eVrN5ga7KRCDw+ZPfoYQnP3/ERRI7NaHX8fLn3NOsVZA30tqB0k4r4WL1hblaJ82Cls9qU5iwThGRlkA/ABuY0s9CnlefC/uSGXAp90O0MgmkqK2u9GkF0cyx0C1CpMh0YgXSX9KcwttSMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UGiNhoVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D3AC433F1;
	Tue, 23 Jan 2024 00:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705971500;
	bh=9IjEnqwe1o1QpkUexCDGyCXxvUQlig+UOtFK4bFWaIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UGiNhoVyVJ+AQS48hHZE9UGq4FpEJn5Joab9WyaLaHVS15S1UUw4TtONR2PjlIZIU
	 eWMzUclicQZur2z6BB1//30+DWagWBWYaVK2sq6f1oNz6TzPMivDlzGlj1LO8PIAUP
	 pSLZJ/KyXfD7TVBntvT0+ct+24zaKdEx76gBOXWA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 148/286] drm/bridge: tpd12s015: Drop buggy __exit annotation for remove function
Date: Mon, 22 Jan 2024 15:57:34 -0800
Message-ID: <20240122235737.856224425@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235732.009174833@linuxfoundation.org>
References: <20240122235732.009174833@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit ce3e112e7ae854249d8755906acc5f27e1542114 ]

With tpd12s015_remove() marked with __exit this function is discarded
when the driver is compiled as a built-in. The result is that when the
driver unbinds there is no cleanup done which results in resource
leakage or worse.

Fixes: cff5e6f7e83f ("drm/bridge: Add driver for the TI TPD12S015 HDMI level shifter")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20231102165640.3307820-19-u.kleine-koenig@pengutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/ti-tpd12s015.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-tpd12s015.c b/drivers/gpu/drm/bridge/ti-tpd12s015.c
index e0e015243a60..b588fea12502 100644
--- a/drivers/gpu/drm/bridge/ti-tpd12s015.c
+++ b/drivers/gpu/drm/bridge/ti-tpd12s015.c
@@ -179,7 +179,7 @@ static int tpd12s015_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __exit tpd12s015_remove(struct platform_device *pdev)
+static int tpd12s015_remove(struct platform_device *pdev)
 {
 	struct tpd12s015_device *tpd = platform_get_drvdata(pdev);
 
@@ -197,7 +197,7 @@ MODULE_DEVICE_TABLE(of, tpd12s015_of_match);
 
 static struct platform_driver tpd12s015_driver = {
 	.probe	= tpd12s015_probe,
-	.remove	= __exit_p(tpd12s015_remove),
+	.remove = tpd12s015_remove,
 	.driver	= {
 		.name	= "tpd12s015",
 		.of_match_table = tpd12s015_of_match,
-- 
2.43.0




