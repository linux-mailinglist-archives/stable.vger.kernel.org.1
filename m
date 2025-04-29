Return-Path: <stable+bounces-138447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 324F8AA1876
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17589A7452
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81812517AF;
	Tue, 29 Apr 2025 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SxixMpTF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BE8233735;
	Tue, 29 Apr 2025 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949283; cv=none; b=SJWR+tnfWNqeiGNj2at0iCmCqz9e31xA4iwe6jrOLqfBztGmoAvDdvnPAvkj+8eAmCsEmN+o9FD20qtNDUeVfbVP8nxBg0RTRzuuY2vlyG2MtXpztDpObEKvctYMRNOuxPycmyXXd0PNu61NQS/wixUOfj/fhkwCFaDXKjg8jUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949283; c=relaxed/simple;
	bh=QVLKmQATUUHhW0bYkpGih3rOCjp+LWK4CTlmAThMzUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CynkeMxCePuA8e4lmOCXKXuMQaSdhLR2ZFb8avJff9zlf8gkzkuZFObYwWTlcBOciKqAI2EpHCClK1RjVAV4Jkhy9yM6hw7D161PVR+oGBVwkd7+v/FckEPIiKKQyRg7TuryTLqM3R66qL0WXvqfK2olIDYQqtirsiSPJsylxnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SxixMpTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37831C4CEE3;
	Tue, 29 Apr 2025 17:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745949283;
	bh=QVLKmQATUUHhW0bYkpGih3rOCjp+LWK4CTlmAThMzUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SxixMpTFfv6PtXnkgSkBl+czJjomkiz+UA0yaVF8LD+h3T3Qh8LqFd7KdsbDo+coT
	 oc114wrtmQxD14S74nW403q2RcQRatVCku67Mct+f4DcQeKN6L+02/dzV0bKoo0cjr
	 20Cu9+DhxHQCqOC7NS5HEG6HT9nfdSGelY8KZSDU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Herve Codina <herve.codina@bootlin.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 269/373] backlight: led_bl: Hold led_access lock when calling led_sysfs_disable()
Date: Tue, 29 Apr 2025 18:42:26 +0200
Message-ID: <20250429161134.185051478@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herve Codina <herve.codina@bootlin.com>

[ Upstream commit 276822a00db3c1061382b41e72cafc09d6a0ec30 ]

Lockdep detects the following issue on led-backlight removal:
  [  142.315935] ------------[ cut here ]------------
  [  142.315954] WARNING: CPU: 2 PID: 292 at drivers/leds/led-core.c:455 led_sysfs_enable+0x54/0x80
  ...
  [  142.500725] Call trace:
  [  142.503176]  led_sysfs_enable+0x54/0x80 (P)
  [  142.507370]  led_bl_remove+0x80/0xa8 [led_bl]
  [  142.511742]  platform_remove+0x30/0x58
  [  142.515501]  device_remove+0x54/0x90
  ...

Indeed, led_sysfs_enable() has to be called with the led_access
lock held.

Hold the lock when calling led_sysfs_disable().

Fixes: ae232e45acf9 ("backlight: add led-backlight driver")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Link: https://lore.kernel.org/r/20250122091914.309533-1-herve.codina@bootlin.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/led_bl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
index a1b6a2ad73a07..589dae9ebb638 100644
--- a/drivers/video/backlight/led_bl.c
+++ b/drivers/video/backlight/led_bl.c
@@ -226,8 +226,11 @@ static void led_bl_remove(struct platform_device *pdev)
 	backlight_device_unregister(bl);
 
 	led_bl_power_off(priv);
-	for (i = 0; i < priv->nb_leds; i++)
+	for (i = 0; i < priv->nb_leds; i++) {
+		mutex_lock(&priv->leds[i]->led_access);
 		led_sysfs_enable(priv->leds[i]);
+		mutex_unlock(&priv->leds[i]->led_access);
+	}
 }
 
 static const struct of_device_id led_bl_of_match[] = {
-- 
2.39.5




