Return-Path: <stable+bounces-130650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB08A805AE
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97CD71B66550
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C2126A1C4;
	Tue,  8 Apr 2025 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IdE+Uryb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C395F26A1B3;
	Tue,  8 Apr 2025 12:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114279; cv=none; b=WA5JvVpd5lUcsWRCG04E68fwWwYVEJ+ogqxuog1oIrBt2sGjNclofJiWYMSTqf/ha/2NZdVwdBkGh+R/wrwyCb/aU+SJ7DEy3+z00okFbnUbm8vxz5czx8tus0RepiybkekZm9ehQTysFurmrGHfIkTTupVtQTgTCuzMa2q0/RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114279; c=relaxed/simple;
	bh=MeFbRzAmmfzBLFtTIP/6rPTtFVbUZaaF3khHRh0wlro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jFi9zD7k3yafUt/TFlcOkMMPlQfCpWgJIkzgb2BxYWlcH255HF8MkP3RedDtcY6UJh878XbCYd3R8aSAEi7googkGKyQLiTVwAbCSGntVEkvkadloj1ZhmASDwEEsxGf90mTQU/cTqSxaXMXwuweOTfb1ZgL0m4EPDYy/LbTDi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IdE+Uryb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56382C4CEE5;
	Tue,  8 Apr 2025 12:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114279;
	bh=MeFbRzAmmfzBLFtTIP/6rPTtFVbUZaaF3khHRh0wlro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IdE+Urybcptz7K64ltpDx6OTwRW10MKCH3naYeoI59a+JwR1rz3G9QefaRgp0jswm
	 M/YVdrj/q5Sjn+xl8jV+txPlQXpHwG4y61gd9o5hp8wxduk3DYnNRRPT0KP4EV9BBH
	 FHU/6fC9UZTEioaY2OEvwDUXY7EEB9WSHND48G1U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <maroi.limonciello@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 049/499] platform/x86: dell-uart-backlight: Make dell_uart_bl_serdev_driver static
Date: Tue,  8 Apr 2025 12:44:21 +0200
Message-ID: <20250408104852.464285879@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 4878e0b14c3e31a87ab147bd2dae443394cb5a2c ]

Sparse reports:

dell-uart-backlight.c:328:29: warning: symbol
'dell_uart_bl_serdev_driver' was not declared. Should it be static?

Fix it by making the symbol static.

Fixes: 484bae9e4d6ac ("platform/x86: Add new Dell UART backlight driver")
Reviewed-by: Mario Limonciello <maroi.limonciello@amd.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20250304160639.4295-2-ilpo.jarvinen@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/dell/dell-uart-backlight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/dell-uart-backlight.c b/drivers/platform/x86/dell/dell-uart-backlight.c
index bcc5c0f3bb4d1..f1ea587a03413 100644
--- a/drivers/platform/x86/dell/dell-uart-backlight.c
+++ b/drivers/platform/x86/dell/dell-uart-backlight.c
@@ -325,7 +325,7 @@ static int dell_uart_bl_serdev_probe(struct serdev_device *serdev)
 	return PTR_ERR_OR_ZERO(dell_bl->bl);
 }
 
-struct serdev_device_driver dell_uart_bl_serdev_driver = {
+static struct serdev_device_driver dell_uart_bl_serdev_driver = {
 	.probe = dell_uart_bl_serdev_probe,
 	.driver = {
 		.name = KBUILD_MODNAME,
-- 
2.39.5




