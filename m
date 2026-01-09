Return-Path: <stable+bounces-206583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA61D091FF
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 12:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C58030DB50D
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 11:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D603633B97F;
	Fri,  9 Jan 2026 11:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kjvYydC4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998F722F77B;
	Fri,  9 Jan 2026 11:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767959618; cv=none; b=d0mVq/Pav0e1DwxfsTh18W29c77S1IwoUDkJdC35Y53DWuAox9UxSpRIf1rCQa/pF8KUAaMQFmdUD6Y2Dd7DDBy1NqtE89EIkMEyrXEJfMXUuw+5P9O52egQiDKv457kubdo8VzTlzU479c9vQ0+hO8snG8+ONuEo+DZ4313L4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767959618; c=relaxed/simple;
	bh=k1F0loTu3nIwotFeyWNXLCvXy4MyCUiGQ4RDOG6M8co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=juwhXjvW6GxbvOpozmnXaJHHqr47VTW34uHODgiWyR70z9NoinZXJPKp4CHktlSgL+WrOFs7msTUQiSg92I5wb2UQFV+QTTB6yi2KI3Z3rKs8EgSspm8Hg7Uy3+b1NT3j03ypsO+gMQZSKzLJyS5fBapvqJbCPHcAMaVKFQOFr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kjvYydC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20969C4CEF1;
	Fri,  9 Jan 2026 11:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767959618;
	bh=k1F0loTu3nIwotFeyWNXLCvXy4MyCUiGQ4RDOG6M8co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kjvYydC4wvOmNheqmMcSle+y8RpPnhn0aaAkYPFZRRytrWqv7lEiP4q1RGjsTJVRO
	 57shp5RewJXHRFuZhsD7qvtB9c4MYvmmfgUIW7O6f68na7gP20GnMSatL2ZACXgx8X
	 3GT/gbL+iQwfLRjpHEdcqKHXM2IZj/JQA/E4HpKc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 116/737] power: supply: apm_power: only unset own apm_get_power_status
Date: Fri,  9 Jan 2026 12:34:15 +0100
Message-ID: <20260109112138.368592161@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112133.973195406@linuxfoundation.org>
References: <20260109112133.973195406@linuxfoundation.org>
User-Agent: quilt/0.69
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>

[ Upstream commit bd44ea12919ac4e83c9f3997240fe58266aa8799 ]

Mirroring drivers/macintosh/apm_emu.c, this means that
  modprobe apm_power && modprobe $anotherdriver && modprobe -r apm_power
leaves $anotherdriver's apm_get_power_status instead of deleting it.

Fixes: 3788ec932bfd ("[BATTERY] APM emulation driver for class batteries")
Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
Link: https://patch.msgid.link/xczpgox57hxbunkcbdl5fxhc4gnsajsipldfidi7355afezk64@tarta.nabijaczleweli.xyz
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/apm_power.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/apm_power.c b/drivers/power/supply/apm_power.c
index 9d1a7fbcaed42..50b9636945599 100644
--- a/drivers/power/supply/apm_power.c
+++ b/drivers/power/supply/apm_power.c
@@ -365,7 +365,8 @@ static int __init apm_battery_init(void)
 
 static void __exit apm_battery_exit(void)
 {
-	apm_get_power_status = NULL;
+	if (apm_get_power_status == apm_battery_apm_get_power_status)
+		apm_get_power_status = NULL;
 }
 
 module_init(apm_battery_init);
-- 
2.51.0




