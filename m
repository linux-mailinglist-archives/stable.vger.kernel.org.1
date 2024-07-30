Return-Path: <stable+bounces-64585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0BD941E8A
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569221F243CB
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E670E1898E0;
	Tue, 30 Jul 2024 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c2id64rP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEBE188003;
	Tue, 30 Jul 2024 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360605; cv=none; b=FtAkrfPGO+ucmunjgpsmjaudp6TmKjYI3Iu75ag1LWwJxeEGsy2VHHG7zycFQPVh9ynB3Y1TcFzC6OLXdT2HqwpiHmBbNb9P9vqYX4SYA+Etpg0sfuZUsl5JYW+bAW0dZgV1GMm1aK9SW/4C3z04HIWYqg0PN2z31LHWpoOdI1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360605; c=relaxed/simple;
	bh=bN2KrbyLrMtM5akDdZYvMSQGJ3kcoZ3MO5eJGzu9Kms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/QKw0xEHr9MRF3/VtArnWSTElsMLQZs/oj6pYt3uSKyflhdvBro4bxHmUMy74V/LqOFTvIRAgAHa5kCRpC/7CSPCLlB4269aXyAMQR3z/2ZV+dGm3cMIDzGnO/C1QkYSarjg6IJsH3deqetvl7/ZUZMIWFDnFpXxDnm9LrrRD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c2id64rP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3F0C32782;
	Tue, 30 Jul 2024 17:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722360605;
	bh=bN2KrbyLrMtM5akDdZYvMSQGJ3kcoZ3MO5eJGzu9Kms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c2id64rP7YaT1Orh+KKj1wOrBxPyTBfGOguQFIc2t+ariiX+H4M3Qn8NKwcNajSar
	 vWMKP7mjEY2wKkPkdJdadtAgkGVNBFd2fJBdSwx3BjBN17BrrGJ41vuotPjSmcPSZr
	 SuDL0ipT0CFUZWB4TcVcWAJsickBq8sdOLMQZLmk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 750/809] watchdog: rzg2l_wdt: Check return status of pm_runtime_put()
Date: Tue, 30 Jul 2024 17:50:26 +0200
Message-ID: <20240730151754.582172311@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

[ Upstream commit 471e45a33302852bf79bc140fe418782f50734f6 ]

pm_runtime_put() may return an error code. Check its return status.

Along with it the rzg2l_wdt_set_timeout() function was updated to
propagate the result of rzg2l_wdt_stop() to its caller.

Fixes: 2cbc5cd0b55f ("watchdog: Add Watchdog Timer driver for RZ/G2L")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20240531065723.1085423-5-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/rzg2l_wdt.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index d87d4f50180c5..7bce093316c4d 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -144,9 +144,13 @@ static int rzg2l_wdt_start(struct watchdog_device *wdev)
 static int rzg2l_wdt_stop(struct watchdog_device *wdev)
 {
 	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
+	int ret;
 
 	rzg2l_wdt_reset(priv);
-	pm_runtime_put(wdev->parent);
+
+	ret = pm_runtime_put(wdev->parent);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
@@ -163,7 +167,10 @@ static int rzg2l_wdt_set_timeout(struct watchdog_device *wdev, unsigned int time
 	 * to reset the module) so that it is updated with new timeout values.
 	 */
 	if (watchdog_active(wdev)) {
-		rzg2l_wdt_stop(wdev);
+		ret = rzg2l_wdt_stop(wdev);
+		if (ret)
+			return ret;
+
 		ret = rzg2l_wdt_start(wdev);
 	}
 
-- 
2.43.0




