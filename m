Return-Path: <stable+bounces-58411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF6992B6DA
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA9091F241C2
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29457156F2B;
	Tue,  9 Jul 2024 11:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r5CKhw3L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACD855E4C;
	Tue,  9 Jul 2024 11:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523856; cv=none; b=eUGUVHOPlNlG9bJsAs/gWxRgTKcQHum2h59b0YIpbAdglH4odd206TJtWvJGYzZDLxMXwk2rKjSckEPf/tkyYLjy1nA/Aa9zw9+3kA7xV5LZR240/hcFrr2bcl7dPBJGXmwm8DYdZVZCCa0uwEx8OkOCyKXD2QfwP9e85JC119E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523856; c=relaxed/simple;
	bh=03kUArBLKD8UzWESyydux9LCOq4qFIgQ81HLZLPvghU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxMge8iS+DsHC4XgFYxIgNS9eV1INkuulghDovZUAQaL2foRbSvKZBjnNTBJkpkjE62XcAKmc3ysULA2qVwYw/xwHi9Lp+STMEBB+Fv12Eia3ZwOsTIgih1Rc/E5Myg8LuIBpH6AXnyq7g0v0mqTMmXt05bwPPvZ8CmNthpexmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r5CKhw3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617EBC3277B;
	Tue,  9 Jul 2024 11:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720523856;
	bh=03kUArBLKD8UzWESyydux9LCOq4qFIgQ81HLZLPvghU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r5CKhw3LB6BF1VhG1MqVt31+pcXe7UeAz+1DJZ0oVBVJbyV4BmZsb4uCvfLmk4NkF
	 H8MBE7eyGL3kPzX+GRun4Gp2uLki91xU9A6QvMk9Et84nLioplTmb2cDCDw4al7wIl
	 MXSMgCzMVlXLgADBTtcEnU+m2mwveJ91Bs8DY6vo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	hmtheboy154 <buingoc67@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 131/139] platform/x86: touchscreen_dmi: Add info for the EZpad 6s Pro
Date: Tue,  9 Jul 2024 13:10:31 +0200
Message-ID: <20240709110703.229549109@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110658.146853929@linuxfoundation.org>
References: <20240709110658.146853929@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: hmtheboy154 <buingoc67@gmail.com>

[ Upstream commit 3050052613790e75b5e4a8536930426b0a8b0774 ]

The "EZpad 6s Pro" uses the same touchscreen as the "EZpad 6 Pro B",
unlike the "Ezpad 6 Pro" which has its own touchscreen.

Signed-off-by: hmtheboy154 <buingoc67@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20240527091447.248849-3-hdegoede@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/touchscreen_dmi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index bb1df9d03bbcd..06ebab520f271 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -1406,6 +1406,17 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_BIOS_DATE, "04/24/2018"),
 		},
 	},
+	{
+		/* Jumper EZpad 6s Pro */
+		.driver_data = (void *)&jumper_ezpad_6_pro_b_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Jumper"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Ezpad"),
+			/* Above matches are too generic, add bios match */
+			DMI_MATCH(DMI_BIOS_VERSION, "E.WSA116_8.E1.042.bin"),
+			DMI_MATCH(DMI_BIOS_DATE, "01/08/2020"),
+		},
+	},
 	{
 		/* Jumper EZpad 6 m4 */
 		.driver_data = (void *)&jumper_ezpad_6_m4_data,
-- 
2.43.0




