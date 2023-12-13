Return-Path: <stable+bounces-5989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 893DD80D832
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446072810D2
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB74C5103A;
	Mon, 11 Dec 2023 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EI/L6+14"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB62FC06;
	Mon, 11 Dec 2023 18:43:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FA0C433C7;
	Mon, 11 Dec 2023 18:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320212;
	bh=GS8G0gsDAKl6sa7hWtwib8GuwnfHpCcQalIbHk2/wUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EI/L6+14ZmrJpWHT+F8MyeW2bTqirPv4Ih8MQFjAFZVEqc/JNkzwFIThfBqzLoD/8
	 MLyJjj9h5gzP0o0FYsYnCcNrqVXudlLdAIhk4o2rXMbJ5gw9kfP7b6mDcFQhArHmMp
	 nSDuRKLlX1P+w2C6poRPom3U6wkvTgx1izkWMmLg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Boerge Struempfel <boerge.struempfel@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 45/67] gpiolib: sysfs: Fix error handling on failed export
Date: Mon, 11 Dec 2023 19:22:29 +0100
Message-ID: <20231211182016.949174361@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182015.049134368@linuxfoundation.org>
References: <20231211182015.049134368@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boerge Struempfel <boerge.struempfel@gmail.com>

[ Upstream commit 95dd1e34ff5bbee93a28ff3947eceaf6de811b1a ]

If gpio_set_transitory() fails, we should free the GPIO again. Most
notably, the flag FLAG_REQUESTED has previously been set in
gpiod_request_commit(), and should be reset on failure.

To my knowledge, this does not affect any current users, since the
gpio_set_transitory() mainly returns 0 and -ENOTSUPP, which is converted
to 0. However the gpio_set_transitory() function calles the .set_config()
function of the corresponding GPIO chip and there are some GPIO drivers in
which some (unlikely) branches return other values like -EPROBE_DEFER,
and -EINVAL. In these cases, the above mentioned FLAG_REQUESTED would not
be reset, which results in the pin being blocked until the next reboot.

Fixes: e10f72bf4b3e ("gpio: gpiolib: Generalise state persistence beyond sleep")
Signed-off-by: Boerge Struempfel <boerge.struempfel@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib-sysfs.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 558cd900d3996..b993416961a75 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -490,14 +490,17 @@ static ssize_t export_store(struct class *class,
 	}
 
 	status = gpiod_set_transitory(desc, false);
-	if (!status) {
-		status = gpiod_export(desc, true);
-		if (status < 0)
-			gpiod_free(desc);
-		else
-			set_bit(FLAG_SYSFS, &desc->flags);
+	if (status) {
+		gpiod_free(desc);
+		goto done;
 	}
 
+	status = gpiod_export(desc, true);
+	if (status < 0)
+		gpiod_free(desc);
+	else
+		set_bit(FLAG_SYSFS, &desc->flags);
+
 done:
 	if (status)
 		pr_debug("%s: status %d\n", __func__, status);
-- 
2.42.0




